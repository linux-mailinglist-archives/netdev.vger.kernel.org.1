Return-Path: <netdev+bounces-246362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97688CE9DDB
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81755302650E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494C26D4CA;
	Tue, 30 Dec 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brz8kQZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD825F98A
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103437; cv=none; b=XaMmRVNb2x2hzIMDAQxtGqsW/FFnfVn5D7dMuns76TPXX9c8hFu90j7DQ8niUwJxlFdkAHuKwrVxXsq7ALZfu/k9jgxHvUzHCpzIhARYgrFHcc77WuaIYlr0LEbqB8vw3RZBAFr+Vh54Lp2OKJLepRE2AJcpYJV0WlKszbGem98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103437; c=relaxed/simple;
	bh=WPoufRWayld6ss/SYhD51ed6m8RXUHzxW8w8g4Chx8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/1HFnJOTAdcZwaqfqh5vI36ygsfEGiBFzlsJsbs779tsCihlM79zZH+FzZ+IOaBpC/WvOx4NF0gxDjTaLV9vD7x6FBl6smaTC7If8SqVeua/AKD4SbFwsEQvHOFKRP7WEOZu6j5qkaiwcGfcISctuliHVe0Z1Ece6voz+H4gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brz8kQZi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-595825c8eb3so10125307e87.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767103431; x=1767708231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/nwLbYNKtnshQbwvUaLIUG2J6xqJ7063t3j/p1UPp4=;
        b=Brz8kQZiI/c8dBKj8cKDDstNmj21EgueJhgxz2dAur6pml5SKZ5fi3CKhTDJd3MVH4
         Ih6GjVCals7j/Ud7W0FJ3PoyMXqOj9DZRcddmK830I1+qYQUNTrOzZlcVhm+8JE89686
         /dV4kN03yDCVKh2IDLqDXz9lIln1CN9bvpiVdVOuc7J7YBCyP1yW0EyNvsR4LoYIC22y
         GugjrHIfOLeL0b9vTeT/Ux0HBmwZD46ZmTYVMHjSKEc8wM+uGnSWfYEQSzN/s8BJQ6Zc
         I+jmLpjXHSD60919hKcU22jlTgAOglowp8EEM0VyCilExXk+ChLe4n3kttfkmkFvjXP/
         M+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103431; x=1767708231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/nwLbYNKtnshQbwvUaLIUG2J6xqJ7063t3j/p1UPp4=;
        b=lfVLW/AGWV79FEfkGFtqY07mDIj9O6o9Cdo9n2p8/qN9H7BRKcBhpgu4K06/bCnF6j
         xK/HaKxXj8iad0fgArOAMm72k1iNUyUHx2wNLPngqeMWpMJpljHvBMQIPhOasY8HMgYC
         kp4oyQe/GIbkILiMb3O6Vf8gR84lSnzIUXUj5+A+s08oNvQziIZ3T33M/cuDsrC2a4au
         x2TqfwHRf1ZmBa+U8qXi2m9nus5shMrUBBTsHdXpl7NTzD+d6IVORRjp/fYbVgwxu2jm
         aXYWfIqdn2TpR910n8WsskMt64h78CXe3naiKK/FDbaKTcmtBLrlxFTGCnEdP/WC371l
         CLpQ==
X-Gm-Message-State: AOJu0YytX/x0JR/E8Dja34j+GsAhJhtLIYvwOlAhXGlfOmA/Tp1W7TJI
	S5xQuD5NEH4yL+3gjAagYhCHZEpRK4Q4rE5ZwiDznr+UIBvTJ/bDwCgjUCLpW3zv+I0=
X-Gm-Gg: AY/fxX7+I73Df/vKLbQToJp6sIxqBPdC7O7rF6oE+k0M0xMrGlSdGT7O7L25JhX7LCG
	JQWWD2zYwPhIjWg8G4c/UV1xJtwQSy2+KPb+ADFHbpO9RqU9TMgQrcIi+0OMLekGctKqU8u5F10
	kOksIAalT602hGS5h6oX/SHvR8F79U66RIYdPD4lxiCvRCLm7xTg2y1e0O8tF5TAiXxEPopFSxA
	u+EXJI8sBS+Vlagfvj122F+pNzHUUCx3lm6I/oCmkbhPAMAEDOlAZTd5w/kCrS4O7glZ0DYAL/2
	xNWRcwAB4mVGNAUo/2mYsSdbawjbZUw6tgRgGcYlCbkt3TfhCCgG1zHZWg6jKW2yvloSOJFBoR6
	ZjHO8mZpC4AOfPuqpp1KTBaKa+isZKNaYSlEgHdFxaXrJL9q+Xr8W1pIMcQZ5qkkC00q17R9Z+3
	IclnlZgM8yOoANUaeRh0Gov3wgQTe1VY28/kMMNOJK4+qxmr12mmQ9xvmvSJeopqJ5bKg67oqct
	uizeO+eeaGeNNuX
X-Google-Smtp-Source: AGHT+IFdefQF8ch2Z7s2KRkzdfYwQxrJGSRsMw+io52P+KbO/I4NVxkcOMeP815s5wDbCRJAPN8PGw==
X-Received: by 2002:a05:6512:32c5:b0:594:2b58:ab83 with SMTP id 2adb3069b0e04-59a17d581fbmr11615422e87.40.1767103431063;
        Tue, 30 Dec 2025 06:03:51 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm10191272e87.72.2025.12.30.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:03:50 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 net 2/2] selftests: net: simple selftest for ipvtap
Date: Tue, 30 Dec 2025 17:03:24 +0300
Message-ID: <20251230140333.2088391-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
References: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple ipvtap test to test handling
IP-address add/remove on ipvlan interface.

It creates a veth-interface and then creates several
network-namespace with ipvlan0 interface in it linked to veth.

Then it starts to add/remove addresses on ipvlan0 interfaces
in several threads.

At finish, it checks that there is no duplicated addresses.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
v4:
  - Removed unneeded modprobe
  - Number of threads is 8, if KSFT_MACHINE_SLOW==yes.
    It is needed, since on debug-build test may take more than 15 minutes.
  - Now veth is created in own namespace
  - Added comment about why test adds/removes random ip

 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 166 +++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..45c4ea381bc3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -48,6 +48,7 @@ TEST_PROGS := \
 	ipv6_flowlabel.sh \
 	ipv6_force_forwarding.sh \
 	ipv6_route_update_soft_lockup.sh \
+	ipvtap_test.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
 	link_netns.py \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 1e1f253118f5..5702ab8fa5ad 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -48,6 +48,7 @@ CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
 CONFIG_IPV6_VTI=y
 CONFIG_IPVLAN=m
+CONFIG_IPVTAP=m
 CONFIG_KALLSYMS=y
 CONFIG_L2TP=m
 CONFIG_L2TP_ETH=m
@@ -122,6 +123,7 @@ CONFIG_TEST_BPF=m
 CONFIG_TLS=m
 CONFIG_TRACEPOINTS=y
 CONFIG_TUN=y
+CONFIG_TAP=m
 CONFIG_USER_NS=y
 CONFIG_VETH=y
 CONFIG_VLAN_8021Q=y
diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
new file mode 100755
index 000000000000..b4e18fc7ada0
--- /dev/null
+++ b/tools/testing/selftests/net/ipvtap_test.sh
@@ -0,0 +1,167 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Simple tests for ipvtap
+
+
+#
+# The testing environment looks this way:
+#
+# |------HNS-------|     |------PHY-------|
+# |      veth<----------------->veth      |
+# |------|--|------|     |----------------|
+#        |  |
+#        |  |            |-----TST0-------|
+#        |  |------------|----ipvlan      |
+#        |               |----------------|
+#        |
+#        |               |-----TST1-------|
+#        |---------------|----ipvlan      |
+#                        |----------------|
+#
+
+ALL_TESTS="
+	test_ip_set
+"
+
+source lib.sh
+
+DEBUG=0
+
+VETH_HOST=vethtst.h
+VETH_PHY=vethtst.p
+
+NS_COUNT=32
+IP_ITERATIONS=1024
+[ "$KSFT_MACHINE_SLOW" = "yes" ] && NS_COUNT=8
+
+ns_run() {
+	ns=$1
+	shift
+	if [[ "$ns" == "global" ]]; then
+		"$@" >/dev/null
+	else
+		ip netns exec "$ns" "$@" >/dev/null
+	fi
+}
+
+test_ip_setup_env() {
+	setup_ns NS_PHY
+	setup_ns HST_NS
+
+	# setup simulated other-host (phy) and host itself
+	ns_run "$HST_NS" ip link add $VETH_HOST type veth peer name $VETH_PHY \
+		netns "$NS_PHY" >/dev/null
+	ns_run "$HST_NS" ip link set $VETH_HOST up
+	ns_run "$NS_PHY" ip link set $VETH_PHY up
+
+	for ((i=0; i<NS_COUNT; i++)); do
+		setup_ns ipvlan_ns_$i
+		ns="ipvlan_ns_$i"
+		if [ "$DEBUG" = "1" ]; then
+			echo "created NS ${!ns}"
+		fi
+		if ! ns_run "$HST_NS" ip link add netns ${!ns} ipvlan0 \
+		    link $VETH_HOST \
+		    type ipvtap mode l2 bridge; then
+			exit_error "FAIL: Failed to configure ipvlan link."
+		fi
+	done
+}
+
+test_ip_cleanup_env() {
+	ns_run "$HST_NS" ip link del $VETH_HOST
+	cleanup_all_ns
+}
+
+exit_error() {
+	echo "$1"
+	exit $ksft_fail
+}
+
+rnd() {
+	echo $(( RANDOM % 32 + 16 ))
+}
+
+test_ip_set_thread() {
+	# Here we are trying to create some IP conflicts between namespaces.
+	# If just add/remove IP, nothing interesting will happen.
+	# But if add random IP and then remove random IP,
+	# eventually conflicts start to apear.
+	ip link set ipvlan0 up
+	for ((i=0; i<IP_ITERATIONS; i++)); do
+		v=$(rnd)
+		ip a a "172.25.0.$v/24" dev ipvlan0 2>/dev/null
+		ip a a "fc00::$v/64" dev ipvlan0 2>/dev/null
+		v=$(rnd)
+		ip a d "172.25.0.$v/24" dev ipvlan0 2>/dev/null
+		ip a d "fc00::$v/64" dev ipvlan0 2>/dev/null
+	done
+}
+
+test_ip_set() {
+	RET=0
+
+	trap test_ip_cleanup_env EXIT
+
+	test_ip_setup_env
+
+	declare -A ns_pids
+	for ((i=0; i<NS_COUNT; i++)); do
+		ns="ipvlan_ns_$i"
+		ns_run ${!ns} bash -c "$0 test_ip_set_thread"&
+		ns_pids[$i]=$!
+	done
+
+	for ((i=0; i<NS_COUNT; i++)); do
+		wait "${ns_pids[$i]}"
+	done
+
+	declare -A all_ips
+	for ((i=0; i<NS_COUNT; i++)); do
+		ns="ipvlan_ns_$i"
+		ip_output=$(ip netns exec ${!ns} ip a l dev ipvlan0 | grep inet)
+		while IFS= read -r nsip_out; do
+			if [[ -z $nsip_out ]]; then
+				continue;
+			fi
+			nsip=$(awk '{print $2}' <<< "$nsip_out")
+			if [[ -v all_ips[$nsip] ]]; then
+				RET=$ksft_fail
+				log_test "conflict for $nsip"
+				return "$RET"
+			else
+				all_ips[$nsip]=$i
+			fi
+		done <<< "$ip_output"
+	done
+
+	if [ "$DEBUG" = "1" ]; then
+		for key in "${!all_ips[@]}"; do
+			echo "$key: ${all_ips[$key]}"
+		done
+	fi
+
+	trap - EXIT
+	test_ip_cleanup_env
+
+	log_test "test multithreaded ip set"
+}
+
+if [[ "$1" == "-d" ]]; then
+	DEBUG=1
+	shift
+fi
+
+if [[ "$1" == "-t" ]]; then
+	shift
+	TESTS="$*"
+fi
+
+if [[ "$1" == "test_ip_set_thread" ]]; then
+	test_ip_set_thread
+else
+	require_command ip
+
+	tests_run
+fi
-- 
2.43.0


