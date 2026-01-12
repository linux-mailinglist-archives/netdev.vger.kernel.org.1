Return-Path: <netdev+bounces-249054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A91FD132A5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1FDA3022B82
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F002EC54D;
	Mon, 12 Jan 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1jgliMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1672E03F5
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227876; cv=none; b=LwqHDgvR2CS31bifdS+m1pdXJ8Tf9MFP0DXUeNh5v7SAvstA/o6gkcMS/A+K0A0uiHr3h991xHF/e+xTS+YTCi16CXxPuPIWZGyc8qJY5BBArzWbbOX8t8BYCeE+je+uCIjEmiIVFHCP35Ag5JDEIBoClOcPFay/ZrZv7dCOTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227876; c=relaxed/simple;
	bh=BZPU4/lGG0J9r6T98Ec/3n2wqGNY6q8RQ6kaVnq1VSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqKsk92PVXt4oefv2Yk82+LtMMWdaVkovceMnFekyokjb8vKMc0uGcKXd5Vfs9lELcFlo8FVDziJsC44XeWvRSvKV41hzuznpLmjiJ+F9yQlqxLQ38vnxia6UgfdvCDLQLevw24XPtQV2RHsRumw/PGWeAOu2xf+kGg4DWKX/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1jgliMl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b79451206so3710595e87.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768227873; x=1768832673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt/m2Ka5cZdgJMeacG0VQe5n4LWZheKXgFoWxx1SO48=;
        b=a1jgliMlpVrVfILPaGBfhv2/IPqfuUWJDYNl8X4ZpeUFsrnbKMje/QnpTIrv1ym/lC
         17zUyROOUhxK+Bcx605yyOso0gmro5C9xuzTTitSikYgztiAtvyLbjPP6JM4i4uIT/Bl
         NYn3lROhZ3+/yHoheyXvetFr8CZGElSDE/cycRK+fcikfIpXXtg55x+sbRHVsT180Soc
         EoZzFNLEsPiF0BCP44Xh03KtIXRFO7knXoNhzsDeoynSyNHQog9j5YCoLH1ueaSlUX3w
         KPQfqCGL7GwaGTkjYDZfZNUcCV2gBDThB7pPw8vQGsUC6gsWsbGLyYQ7nnYIMGL5VDfm
         PruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227873; x=1768832673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tt/m2Ka5cZdgJMeacG0VQe5n4LWZheKXgFoWxx1SO48=;
        b=d5bRnWeJB6MZzJGeaDkwTEcbZHd9XI15c9mr53WtDQ+OvQ2FZJvsyN2174CkL87tLd
         OnU6tl8EAZemq9+6vZz+FifMplJIoFgmm4H+pwLx8kY0BVG9ihYZuiJrFoTEtM31pext
         fk6VIfpxcHj7/+csFOMfXDa1zD1RUvXmqzdeQQadWLD5LKY3R43oFe7K1zSE3hbH50wJ
         jeVpQrVt3cH6+o3/EQadI0gEalxCNnKal2g36cryUGTEgDno0A31On8hDGLhlhSiSyDz
         xMTnYpOpLrQBqJfvnu76CHFDiHRnIxm0gFNAPG8wozjT+NiYRQ+Osch0VZaWG3dMVLRM
         Z03w==
X-Gm-Message-State: AOJu0Ywco/nB62xExrikeb3fliwKeQ5Lr0TP+88uHDP6/kyXXDahZT5P
	dVcYAohH5Qb52L5Brhpqku6P2JP2W4/DqitjllzPzN5geYrhcN3yBekpcGXkAuqxcqQ=
X-Gm-Gg: AY/fxX6khHrz0nBCB/xDjyesMVH5A+bDrpUTmQ1krArxpa4BFTjar7J3z6qz7HqICVw
	91O/FXm2ufIVv2mZllztdJ4V7tuLSbQlDK95M7T2PhfEs/QMgAo62OscpswzEC6F4y8H/065kKQ
	ag7vsH4qP3Kpv6Qnvpi5G8+n9b7CmdBLVhAb8Oh3fBD2R0xwVrTHxVqPPZhxDcB16rYkyAzyKfw
	d4T3vYBKMl5U0suWN7sEmQWDf6mva6x2gGdUATWU4gVcK40wGlk+ZSYg5kQd4JxVE2SznB2gY2K
	LpPg5fNs9s6ckZjEbcIo+fcyeN7VF6wlaPD3CgWs/+eSrgmWAN6FGsJPQQTlKM85Xqd9YuSlAHQ
	Gsr7JM/rl+pIsXeWGoC7bjMcxvbuFYAetLiWcHNlJxdbXmJgjfvVvLAlqi9uHufwBRA2wShtaxn
	EDC2C1fAODPBzADaptCdcNlY3AF1TZNZr9RFFjgdPcXqEC+Q==
X-Google-Smtp-Source: AGHT+IHLdACavss3zHvYnOW2MtPJbIhLP5zLm/jABvTfWBTEVN6fHDGOQuSD/yyZQlRKXzd/8TRZjA==
X-Received: by 2002:a05:6512:2216:b0:59b:7312:37ab with SMTP id 2adb3069b0e04-59b731238a6mr6418691e87.39.1768227872517;
        Mon, 12 Jan 2026 06:24:32 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0d86bsm4821886e87.23.2026.01.12.06.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:24:32 -0800 (PST)
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
Subject: [PATCH v5 net 2/2] selftests: net: simple selftest for ipvtap
Date: Mon, 12 Jan 2026 17:24:07 +0300
Message-ID: <20260112142417.4039566-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
References: <20260112142417.4039566-1-skorodumov.dmitry@huawei.com>
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
v5:
  - Execution time of ip-set thread is limited with 1 minute.
  - Don't use KSFT_MACHINE_SLOW.
  - Fixed position of "CONFIG_TAP=m" in config
v4:
  - Removed unneeded modprobe
  - Number of threads is 8, if KSFT_MACHINE_SLOW==yes.
    It is needed, since on debug-build test may take more than 15 minutes.
  - Now veth is created in own namespace
  - Added comment about why test adds/removes random ip

 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 168 +++++++++++++++++++++
 3 files changed, 171 insertions(+)
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
index 1e1f253118f5..b84362b9b508 100644
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
@@ -116,6 +117,7 @@ CONFIG_PROC_SYSCTL=y
 CONFIG_PSAMPLE=m
 CONFIG_RPS=y
 CONFIG_SYSFS=y
+CONFIG_TAP=m
 CONFIG_TCP_MD5SIG=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_TEST_BPF=m
diff --git a/tools/testing/selftests/net/ipvtap_test.sh b/tools/testing/selftests/net/ipvtap_test.sh
new file mode 100755
index 000000000000..354ca7ce8584
--- /dev/null
+++ b/tools/testing/selftests/net/ipvtap_test.sh
@@ -0,0 +1,168 @@
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
+IPSET_TIMEOUT="60s"
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
+		ns_run ${!ns} timeout "$IPSET_TIMEOUT" \
+			bash -c "$0 test_ip_set_thread"&
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


