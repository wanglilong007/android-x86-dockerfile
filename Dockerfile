FROM ubuntu:18.04

ENV branch q-x86
ENV TARGET_PRODUCT android_x86_64
ENV TARGET_BUILD_VARIANT userdebug

RUN set -ex; \
    apt update; \
    apt -y install git gcc curl make repo libxml2-utils flex m4; \
    apt -y install openjdk-8-jdk lib32stdc++6 libelf-dev; \
    apt -y install libssl-dev python-enum34 python-mako syslinux-utils; \
    mkdir android-x86; cd android-x86; \
    repo init -u http://scm.osdn.net/gitroot/android-x86/manifest -b $branch; \
    repo sync --no-tags --no-clone-bundle; \
    source build/envsetup.sh; \
    lunch $TARGET_PRODUCT-$TARGET_BUILD_VARIANT; \
    m -j4 iso_img; m -j4 rpm; \
