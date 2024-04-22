Return-Path: <netdev+bounces-90203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB38AD0F0
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4003628CBA9
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F91534F7;
	Mon, 22 Apr 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZdgJVhHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD6153596
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799996; cv=none; b=WtQP0yLB+Pn/io31zi/KkZokuYgtVGV3IldAFIi7lCJmxegjB/CNILapx7P8bXyC2tEi1EaRhK2Kz9ALiTDM6cmEMMu2tu2YMzLIFZJaCH0bl/nUuzUf5QTlyotUu7HAoNiIm53pad6fJp+2+XLGyxbwL/DR1Yicb7GqrpStNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799996; c=relaxed/simple;
	bh=PpoLD1H94rA4TRptICasS4LawZkbS6b4uI7xKmspqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiOixw8e1x4v9uwoe2uuMCFFjwCMpXjepktONPu3OXy1GqVEHXBQgxxfa602z0yFQuEGS9kMaZdCnj9s7FGQu9frmxG76xb8avXnXGf0yVqWNGtMxEXQNLgonVtqvgzCinwNNdAWMjvIo6xGRIC1gH8Lf74nhZDpkxGQZkaP9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZdgJVhHa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55b3d57277so153016366b.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799993; x=1714404793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5/4hfw3aEXqovOlUV3Xw0f3iNJbck2TFHBWGrv3tv8=;
        b=ZdgJVhHajnt0MhZYjpxyeJY30/WUJD29h+wGHMVNUeRXoyjV/p0jZzp1CIlwz0OBFE
         YwHpSFSYlHidQXsb+3uVINp174eQ6XOli69hKzADtbPiwY1FdV06tTkLGAOQQUbaRFmG
         aa/BUJEeNTrRM7lwNyrrUABkMbfccoXLsAT6B8Cz6WfKCPd+4IP0xsB+necj2HPD9sjD
         dqoBadCliIWizOEBZn8JlM15DCP+9UTtvWXFyIwEEHYg9MbMqF8yl4jaRJfXyxNRCvMP
         2OWlJwnonvm82IymWdzxnJCiNKMYi3eFkDc9NYhHxUUuKEqazq2E8M9Z3SYhfdL0dH/O
         bGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799993; x=1714404793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5/4hfw3aEXqovOlUV3Xw0f3iNJbck2TFHBWGrv3tv8=;
        b=NveMGBbcX94qJ6Qjfi1eSrYce8nynKdzbi8AUw7ugGAVgZIVoLjrhrCmY5rvrXVnZS
         QFQAoTaGWlGos8v6EDHmnpEbR+TLyui3yDMqToeZF9zGsjrVJ0s3DAvjU4Bzgxgvqcq4
         7mwUtxognj0XjZX1mnLou4+MWhQ9vxgUANxoZQ2nSkJmrJs1GUsEnh99fJTbv5asugTI
         VMzHf1jPEswAzTrGsB4WNOsMF7jJnNMxpQfor/pMZcJ35kQnFYsKmfl5qQ+YUiUF5bCx
         mKMhDDZdTaCKmO8nqkT0lu6eo66io5bJyaKd3LxGc8enjN8AYVXEXiT30kDiUwO7vJFy
         r7PA==
X-Gm-Message-State: AOJu0YxvU8EykpBvB05gBKPy7Rm6at28Dt9T5rVRs47pyL3wHxHRgwKA
	7jQ4OaX6tWIrW2nN15EWXeIcN1fe9xfdLtqni9xFFTazdWF+z2cIjTAy0KAf9IlwkYVPRSxDGBf
	u
X-Google-Smtp-Source: AGHT+IGLJFYyGE9Me9SFYHZuwHqIdpetEasSseYPw89aFUMTGlU3WCb9q03mnmSP2C3ofbBZlFbijg==
X-Received: by 2002:a17:906:e2d4:b0:a55:a670:4e63 with SMTP id gr20-20020a170906e2d400b00a55a6704e63mr3084519ejb.13.1713799993174;
        Mon, 22 Apr 2024 08:33:13 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00a5256d8c956sm5832857ejb.61.2024.04.22.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v5 5/5] selftests: virtio_net: add initial tests
Date: Mon, 22 Apr 2024 17:33:00 +0200
Message-ID: <20240422153303.3860947-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
References: <20240418160830.3751846-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Introduce initial tests for virtio_net driver. Focus on feature testing
leveraging previously introduced debugfs feature filtering
infrastructure. Add very basic ping and F_MAC feature tests.

To run this, do:
$ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

Run it on a system with 2 virtio_net devices connected back-to-back
on the hypervisor.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
v3->v4:
- s/cleanup/setup_cleanup/
- moved pre_cleanup call to cleanup() to be called only once on exit
v1->v2:
- added TEST_FILES and TEST_INCLUDES in the Makefile
- fixed directory name in selftests/Makefile
- added MAINTAINERS entry
- added config file with kernel config options
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 ++
 .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
 6 files changed, 249 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index c0bfad334623..f7ae6de3e334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23448,6 +23448,7 @@ F:	include/linux/virtio*.h
 F:	include/linux/vringh.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/
+F:	tools/testing/selftests/drivers/net/virtio_net/
 
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c785b6256a45..2c940e9c4ced 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
+TARGETS += drivers/net/virtio_net
 TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
new file mode 100644
index 000000000000..7ec7cd3ab2cc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = basic_features.sh \
+        #
+
+TEST_FILES = \
+        virtio_net_common.sh \
+        #
+
+TEST_INCLUDES = \
+        ../../../net/forwarding/lib.sh \
+        ../../../net/lib.sh \
+        #
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
new file mode 100755
index 000000000000..cf8cf816ed48
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -0,0 +1,131 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# See virtio_net_common.sh comments for more details about assumed setup
+
+ALL_TESTS="
+	initial_ping_test
+	f_mac_test
+"
+
+source virtio_net_common.sh
+
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+h1=${NETIFS[p1]}
+h2=${NETIFS[p2]}
+
+h1_create()
+{
+	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+initial_ping_test()
+{
+	setup_cleanup
+	setup_prepare
+	ping_test $h1 $H2_IPV4 " simple"
+}
+
+f_mac_test()
+{
+	RET=0
+	local test_name="mac feature filtered"
+
+	virtio_feature_present $h1 $VIRTIO_NET_F_MAC
+	if [ $? -ne 0 ]; then
+		log_test_skip "$test_name" "Device $h1 is missing feature $VIRTIO_NET_F_MAC."
+		return 0
+	fi
+	virtio_feature_present $h1 $VIRTIO_NET_F_MAC
+	if [ $? -ne 0 ]; then
+		log_test_skip "$test_name" "Device $h2 is missing feature $VIRTIO_NET_F_MAC."
+		return 0
+	fi
+
+	setup_cleanup
+	setup_prepare
+
+	grep -q 0 /sys/class/net/$h1/addr_assign_type
+	check_err $? "Permanent address assign type for $h1 is not set"
+	grep -q 0 /sys/class/net/$h2/addr_assign_type
+	check_err $? "Permanent address assign type for $h2 is not set"
+
+	setup_cleanup
+	virtio_filter_feature_add $h1 $VIRTIO_NET_F_MAC
+	virtio_filter_feature_add $h2 $VIRTIO_NET_F_MAC
+	setup_prepare
+
+	grep -q 0 /sys/class/net/$h1/addr_assign_type
+	check_fail $? "Permanent address assign type for $h1 is set when F_MAC feature is filtered"
+	grep -q 0 /sys/class/net/$h2/addr_assign_type
+	check_fail $? "Permanent address assign type for $h2 is set when F_MAC feature is filtered"
+
+	ping_do $h1 $H2_IPV4
+	check_err $? "Ping failed"
+
+	log_test "$test_name"
+}
+
+setup_prepare()
+{
+	virtio_device_rebind $h1
+	virtio_device_rebind $h2
+	wait_for_dev $h1
+	wait_for_dev $h2
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+}
+
+setup_cleanup()
+{
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+
+	virtio_filter_features_clear $h1
+	virtio_filter_features_clear $h2
+	virtio_device_rebind $h1
+	virtio_device_rebind $h2
+	wait_for_dev $h1
+	wait_for_dev $h2
+}
+
+cleanup()
+{
+	pre_cleanup
+	setup_cleanup
+}
+
+check_driver $h1 "virtio_net"
+check_driver $h2 "virtio_net"
+check_virtio_debugfs $h1
+check_virtio_debugfs $h2
+
+trap cleanup EXIT
+
+setup_prepare
+
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
new file mode 100644
index 000000000000..f35de0542b60
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/config
@@ -0,0 +1,2 @@
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_DEBUG=y
diff --git a/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh b/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
new file mode 100644
index 000000000000..57bd8055e2e5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This assumes running on a host with two virtio interfaces connected
+# back to back. Example script to do such wire-up of tap devices would
+# look like this:
+#
+# =======================================================================================================
+# #!/bin/bash
+#
+# DEV1="$1"
+# DEV2="$2"
+#
+# sudo tc qdisc add dev $DEV1 clsact
+# sudo tc qdisc add dev $DEV2 clsact
+# sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
+# sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
+# sudo ip link set $DEV1 up
+# sudo ip link set $DEV2 up
+# =======================================================================================================
+
+REQUIRE_MZ="no"
+NETIF_CREATE="no"
+NETIF_FIND_DRIVER="virtio_net"
+NUM_NETIFS=2
+
+H1_IPV4="192.0.2.1"
+H2_IPV4="192.0.2.2"
+H1_IPV6="2001:db8:1::1"
+H2_IPV6="2001:db8:1::2"
+
+VIRTIO_NET_F_MAC=5
+
+virtio_device_get()
+{
+	local dev=$1; shift
+	local device_path="/sys/class/net/$dev/device/"
+
+	basename `realpath $device_path`
+}
+
+virtio_device_rebind()
+{
+	local dev=$1; shift
+	local device=`virtio_device_get $dev`
+
+	echo "$device" > /sys/bus/virtio/drivers/virtio_net/unbind
+	echo "$device" > /sys/bus/virtio/drivers/virtio_net/bind
+}
+
+virtio_debugfs_get()
+{
+	local dev=$1; shift
+	local device=`virtio_device_get $dev`
+
+	echo /sys/kernel/debug/virtio/$device/
+}
+
+check_virtio_debugfs()
+{
+	local dev=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	if [ ! -f "$debugfs/device_features" ] ||
+	   [ ! -f "$debugfs/filter_feature_add"  ] ||
+	   [ ! -f "$debugfs/filter_feature_del"  ] ||
+	   [ ! -f "$debugfs/filter_features"  ] ||
+	   [ ! -f "$debugfs/filter_features_clear"  ]; then
+		echo "SKIP: not possible to access debugfs for $dev"
+		exit $ksft_skip
+	fi
+}
+
+virtio_feature_present()
+{
+	local dev=$1; shift
+	local feature=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	cat $debugfs/device_features |grep "^$feature$" &> /dev/null
+	return $?
+}
+
+virtio_filter_features_clear()
+{
+	local dev=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	echo "1" > $debugfs/filter_features_clear
+}
+
+virtio_filter_feature_add()
+{
+	local dev=$1; shift
+	local feature=$1; shift
+	local debugfs=`virtio_debugfs_get $dev`
+
+	echo "$feature" > $debugfs/filter_feature_add
+}
-- 
2.44.0


