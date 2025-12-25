Return-Path: <netdev+bounces-246068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC750CDE0C5
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 19:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E143011A59
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5856286D55;
	Thu, 25 Dec 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2H86K9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E05238C0A
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766688969; cv=none; b=lmiTZFIe4NZSw0TMc0gRmvtpg5b5j+9K4CVhpGu5oCrmjt/BjHKbAMgIe1QVFklFK/sKS9XaThe59f/YwvxRLD1JmgdNbnN8FGNW879lKcubpK8ZCmHgdkj6oFWSGfXGW4MSVpenJV3zVDzLa1hcTcLaTU3o4EdY1/hq8/eHw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766688969; c=relaxed/simple;
	bh=pkU1vhyxVPsa80QtcLTzS24f0f7U2mlqk1sxVZuFAN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqYmz9kPt+2ovJIQZP4R4uyqcyGnC30ZWWubturTG/C/xAQxlJXikjh5b3GLwtbzQxgm9Qo2/MmNZYxms8OB8pwGuyPFGtJZo1HqbMaZCiRZ+Q991SuxpD1x7Gueg7cNPmlzLUVdnATQnk1M1FbnXUDAmMLVZSbgIQSQ46ogKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2H86K9x; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-594285c6509so7320193e87.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766688961; x=1767293761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1aK8peXC2B82T7cDIp2oaMCByBh7JADsCX835eYT7k=;
        b=e2H86K9xz20vvDSQqU2HzzmjDBSe1Pwk2gFt9x46DiYulwNrdD8Kz9vkE4INyGjQuD
         oI/D/aDhG1nCeLSKWmd/0xHZjvgLgU7T10JyoOaxa+queDCmvUX5vfSl9Zi4yt5S/fNs
         CtODRNwG3rjPVpOwKxu+AKzZ2xLAm0Cu1Aw62cfz5sBvtfgjph3HYoxDpBLG0o8kQfg8
         vu+7j137hFJcYPavG9OwJNlWs2WTAt5SpjwARoKTsi3RD2LWmDFkO5V9HIXhz82EZ/t2
         0ERWrrfRQtr2kdsenO0sk3ya6THvxrifkKJA0QXAKOgHFAviEWmc7WcAQeZ2NQyXsoGJ
         QFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766688961; x=1767293761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1aK8peXC2B82T7cDIp2oaMCByBh7JADsCX835eYT7k=;
        b=v1LMTvW3f/E9wX6Epi1Ge587YIyydY8J/xfHfYKcZZ2hWn4vgGnjCAC3HeOmT8jqRr
         xk6LMTh7EWCOeMAM+TMkUiusERXmVpMnd3+PbYBd+hSUzbN/t3lFUen80p2YpbNUOyDC
         6iexTfJAcL1MjapKtRbSifwSWxNAUp5AHBaEptvFpHUkQ2zhJH5SfpT7nsU6ZGVqPAKZ
         VR5JxX2Nu9D867jmbeUwksVxy4kyZ/AEQbcp4ShdQjshNxo5Jm6oS89I9pgVd1h5fzlL
         AhVzbd6gfL/aglLu+J1hUdZl3aWFSDixlT98X2HuTU2YXyjURNq+7Hr8XL7Q3OuB3xRP
         Qf2Q==
X-Gm-Message-State: AOJu0YwMuQCveci6EE+BZ3DCv1HF3f32hTAGz0tLvOF2CHLgWJb3jvN5
	b1gTZBM6ksYGpsQn0cP2AzfbXHgsXrkjumD7XfhbyxQK4DoWTemGX/Z+n1fDiZ9gBMc=
X-Gm-Gg: AY/fxX5ggxEcpRvvfoGHTv3bBSO3JreZjV84KVNbTDLg97i0N6CsqJyRQxKn+szePA4
	Wv+n5aBHEc3nkvLPva/QLDyh+1Y/1OrCVKia2tvmmYd9vxqOrhstkVZs//r/TEUPuSMWpbKX5of
	oKDq1QmdwqfB84+1ijTj8clbhJMeVKxaTakxBzsD0jrJpDwKD22hUc223JKk9y04cCaFEm5f116
	CEGemm9zuDR9x1nr6nF2b2A41mAnzOtJs2BMXhc7fyVzC0+GNJWXarcCETAOl6tnHM7JHxsACk7
	XwP8TB59Yh/TDyZahlPkvkTDwg1UO0ZqpBTAVG7ysby1Ij9sc6WWXj6qnvlV2h2iw1tH/ZXat0u
	UOHHx9qLeNZZV6G1Zm7z99ZmYHZV9sbNP4bF3oZlxk1QgqIwOti+3gQjNS8Mi71YXlg2CcYnKql
	bvAGAQc0VsFstgYdLZ8jBDPEyfDln2dGQYcGORi3wjV5yKQosL6vbT1SxEepCkZuQqR/sfNRUr5
	i9DNbtlJ4TbOmbG
X-Google-Smtp-Source: AGHT+IHNodzROWG00OZtD9XAVBI/12GdF0BJwnFJoCI+sHM6hIAnNnf7LvT6ycqlxfjJpXo6K0YBzw==
X-Received: by 2002:a05:6512:128c:b0:598:faf1:3c95 with SMTP id 2adb3069b0e04-59a17d46185mr7446288e87.36.1766688960692;
        Thu, 25 Dec 2025 10:56:00 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddd78sm6057675e87.39.2025.12.25.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 10:56:00 -0800 (PST)
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
Subject: [PATCH net 2/2] selftests: net: simple selftest for ipvtap
Date: Thu, 25 Dec 2025 21:55:34 +0300
Message-ID: <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple ipvtap test to do simple test
on handling IP-address assigning to ipvlan interface.

It creates a veth-interface and then creates several
network-namespace with ipvlan0 interface in it linked to veth.

Then it starts to add/remove addresses on ipvlan0 interfaces
in several threads.

At finish, it checks that there is no duplicated addresses.

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 167 +++++++++++++++++++++
 3 files changed, 170 insertions(+)
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
index 000000000000..751793f26fed
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
+# |------HOST------|     |------PHY-------|
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
+	modprobe -q tap
+	modprobe -q ipvlan
+	modprobe -q ipvtap
+
+	setup_ns NS_PHY
+
+	# setup simulated other-host (phy) and host itself
+	ip link add $VETH_HOST type veth peer name $VETH_PHY \
+		netns "$NS_PHY" >/dev/null
+	ip link set $VETH_HOST up
+	ns_run "$NS_PHY" ip link set $VETH_PHY up
+
+	for ((i=0; i<NS_COUNT; i++)); do
+		setup_ns ipvlan_ns_$i
+		ns="ipvlan_ns_$i"
+		if [ "$DEBUG" = "1" ]; then
+			echo "created NS ${!ns}"
+		fi
+		if ! ip link add netns ${!ns} ipvlan0 link $VETH_HOST \
+		    type ipvtap mode l2 bridge; then
+			exit_error "FAIL: Failed to configure ipvlan link."
+		fi
+	done
+}
+
+test_ip_cleanup_env() {
+	ip link del $VETH_HOST
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
+	modprobe -q tap
+	modprobe -q ipvlan
+	modprobe -q ipvtap
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


