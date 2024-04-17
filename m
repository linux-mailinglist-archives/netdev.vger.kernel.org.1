Return-Path: <netdev+bounces-88809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D511C8A8950
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B841F241BE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34B171E4A;
	Wed, 17 Apr 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aYGEBgqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40ED17166A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372373; cv=none; b=qfHv/EIG6pY0y2y4MmQiMMwRPuaXoZZBiotQnvJ4ejjr/LSPe1QsL5lWG8m6yHuNa7xoDDsqq9rUjKJmVQphqRHzCqN+NKyn62vMGlwgHOVW4vAL8b9aVjI+YFppLNu7MSyO2wlNAARNg/7CK1wBPco8QoezC18+XKBdLgnWLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372373; c=relaxed/simple;
	bh=0H/vjaQNmYH3GF4YhFbd93FGwox9U+b0fRkfa5doB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFUhJ8VvHyBn7B4cFraVOI/Nvk458sow8cBUWyMlTg7Lp+RO9yeMngLpblOreGbp2+ITyDSnvc0cmLfr+Mhyt8W9IZvAQYQ8zrF3mbCs5oHT3S0OxmEEWEsMolOKGZul1Xr+M/Af7D0cuwSdTcy7b1fQQ2LgtprQZVHKZPXPl2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aYGEBgqg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a555b203587so105156566b.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372370; x=1713977170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GseBsN1q0bdHXbiUKHMINZDqk1bayHyPFFMBfv8P5c=;
        b=aYGEBgqgPcOMVDsq22eGqjWncwrWkO3Ah8yjKJ2J5FeD7JZ6gkIce3Nau+s0w/iOaA
         QTUsdmOxLt6V3MVCmHLNfwkb5STeQpJRxYce9ye4Tcg7uZrHf9XQ6i8guFlfx870PIh1
         3RetC422TZSiFQ8sIahXK7MVON+ILkw3Bpbl3L9+RKItww6/4gtZezAOmoEddokE5gCc
         lp/EG2BzybXoCt6UtiBuEPj8gBG4HAdf6Q37FZvA+eRA6bm451SBFxwtzYuQKw640M/L
         FPmHu6d97CgsspVAvR18gztirwOp1VLmpmhbDSNcO+zRsb5LfeL4tqufxVg/oj/8Pne9
         hFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372370; x=1713977170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GseBsN1q0bdHXbiUKHMINZDqk1bayHyPFFMBfv8P5c=;
        b=ucxeb/kI+LkWuA1JzafeUydh/6DmnvIvHTfOMDpu1Sj6GkexwKn8tgcx/k9W+XI7XN
         BT7gwhVqmSCfsj86TGzDWMtVVS8BfEXIOcLeTQLbPSyDPnOTbRWpasDIIIDo5d5hxuxj
         z/OmfYBaeJvt+YHQ7DCxS8vn7sF+Z/PL+3TniVTA6SVKG5QSUa8PPLtZrDnesCZgSR9E
         gSFTH2aQ1lI9hHVnuE78Km2LzX6YDR6k0UpidP6+4h2gInAoDvSkWh4sx/0ZarbA/kKx
         9PUh8TnCSgVpYYTjmbgzUi/5c4zALM2w5r2ap9HElt3IdlsdmE07evHV+7UsR5EZ6r8N
         lhHA==
X-Gm-Message-State: AOJu0Yz0AoEOmHEJDHYGxnHYDMfiXk+TxhiMG5G77kz8asmF8wsMdEO9
	D6PgU+lUG5NNJ2CSqmmEw3MEDMk2D+cpwJCyHpZbC/smVV60XBAjOem2FeKDW2fPYAZGM2f0TYw
	P
X-Google-Smtp-Source: AGHT+IE4TduzrmMU67mJ9eaY8RMcPBvKsaxFK5cqcv2dr69+laIDIKIa2YTJMVf7Btwo7Vuks2Iqgw==
X-Received: by 2002:a17:906:19d3:b0:a46:cef3:4aba with SMTP id h19-20020a17090619d300b00a46cef34abamr38360ejd.75.1713372370171;
        Wed, 17 Apr 2024 09:46:10 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id ht8-20020a170907608800b00a525669000csm5474091ejc.154.2024.04.17.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:09 -0700 (PDT)
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
Subject: [patch net-next v3 6/6] selftests: virtio_net: add initial tests
Date: Wed, 17 Apr 2024 18:45:54 +0200
Message-ID: <20240417164554.3651321-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
---
v1->v2:
- added TEST_FILES and TEST_INCLUDES in the Makefile
- fixed directory name in selftests/Makefile
- added MAINTAINERS entry
- added config file with kernel config options
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 +++
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 6 files changed, 245 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index f22698a7859f..5655fc89f3e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23450,6 +23450,7 @@ F:	include/linux/virtio*.h
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
index 000000000000..b9047299b510
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -0,0 +1,127 @@
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
+	cleanup
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
+	cleanup
+	setup_prepare
+
+	grep -q 0 /sys/class/net/$h1/addr_assign_type
+	check_err $? "Permanent address assign type for $h1 is not set"
+	grep -q 0 /sys/class/net/$h2/addr_assign_type
+	check_err $? "Permanent address assign type for $h2 is not set"
+
+	cleanup
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
+cleanup()
+{
+	pre_cleanup
+
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


