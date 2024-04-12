Return-Path: <netdev+bounces-87439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485D8A320B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5B72834E9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADC14E2E0;
	Fri, 12 Apr 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DOyJXDV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749914900B
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934819; cv=none; b=k1pS2O65OX+7MzRb+aJNaFDLwKIgT4Fh+8A9AujYAFGi9XZRv5H1CvyCKK39II2zmUrwpj9bqu284blDdDlnGkSlCEUN+6sEKdYtC2g1rOiZT08s3YCqujCMHKUJ0UZaiSK9naa28QpRsGimW88jFfyePUmclcf5U2qhmMoUrEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934819; c=relaxed/simple;
	bh=vG/dFpiKplr0KjS27Xya8aAHKc92Q9+PvZTQfbvlf6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0wrYF9yHORXytKXOybtYqKkuZPrR1bajQynX6j/Ht5PuUjWBQiFTVRrNUSQXjPmQTwSE+vT0bDGMEHmW/pdKe6iVk5tzBRhgeYirUk5YokNu97FRlWF+GHBG6MSxeAo8hRoeaad/WpPlOgWlauTrAof+SIFLLVrjB77FVZlb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DOyJXDV8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516dbc36918so1336610e87.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934815; x=1713539615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTunXC6x4034AG0WHitd+4hipFdLCF+F+A/dgWvIp8o=;
        b=DOyJXDV8mxtSBhtVOztke5wV1hegkpo7z+t6lR4Rr33pWEfl6ltz51fTLwhc+/ms1Y
         W5EZUwiFOykcbkmX3Ir1PP8GJDX+gXjVdMWr6BDg/2LQhdOU7vZgt5kZWGo4bGeNjqEK
         8plhIVZJEIGR30JTSyH6eZ5v4B+hq4j6eEcb/Mba5zqgbgd/qhvGXJB8bfxQsK4MB5jm
         jFTgLQwUA8Oysxz2soCkKBYNmLYLAixetDkxDxFUxPpK8Isy2sUVOIK/dWpawi5AKigm
         3nyzwTzJ1U+7fbkl/pIjbOjQhw+uy2QcUCyG+pYi9p+khQarVZTbPHDHtf7JscFtxeO0
         7Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934815; x=1713539615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTunXC6x4034AG0WHitd+4hipFdLCF+F+A/dgWvIp8o=;
        b=Wl4JpHyWMg/mcsTzi++WT/PfDk1JVfthJELt4v8Lu+Svw3st76oZ+1+kMqYTPMvw5Z
         3BnfcthdBVIBlhp5GYA7kySJBOh9hEIUQpeeJPanhLR3Kg5Mf15sN9ieHiun5m9U5HjL
         VrqEimXxjx2aKzFrvKtdy8ZsnGl0AOABBasDPJ3cjOdONn1XRnhE58wi0DAYlywS9RJ9
         cJkCk0Xi4DxrL6ccTA2N4b/RrklxHFYBRs71YQ5MOeisMONFYlRKbuIKW3HxIyoZ6TdA
         fuIo6kVDOXg7aNYqrOpOCNhAOiLrAqly7w8ep5S3Vr6memdLOcs5N0UPDORpHphloY3p
         bS5g==
X-Gm-Message-State: AOJu0YwdDxBy+nXE5obeqI4txQqSM2lHdMW/6UEhMvsgXNUu6NZBPFmm
	CzLW7qy15hWDGtfImsJoSnTqShb/L2VCCymqzn/HpWZAMuKsYAPZ/lsPechlS9XI2mRsJccdQt2
	I
X-Google-Smtp-Source: AGHT+IEFA5gkQ0ib7+hUmRwuS1fmSH2StHxV6OdCj4Zff4iXBk/jIHEX9eBmv8UKr6k22h+0gOtUDA==
X-Received: by 2002:a19:f80a:0:b0:513:d3c0:f66 with SMTP id a10-20020a19f80a000000b00513d3c00f66mr1903270lff.51.1712934815395;
        Fri, 12 Apr 2024 08:13:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f30-20020a19381e000000b00517aaa8670csm544114lfa.276.2024.04.12.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:34 -0700 (PDT)
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
Subject: [patch net-next 6/6] selftests: virtio_net: add initial tests
Date: Fri, 12 Apr 2024 17:13:14 +0200
Message-ID: <20240412151314.3365034-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
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
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |   5 +
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6dab886d6f7a..a8e40599c65f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -20,6 +20,7 @@ TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
+TARGETS += drivers/net/virtio
 TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
new file mode 100644
index 000000000000..c6edf5ddb0e4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = basic_features.sh
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


