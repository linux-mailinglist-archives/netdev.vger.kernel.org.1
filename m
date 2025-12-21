Return-Path: <netdev+bounces-245662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468ABCD45D2
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354A33014591
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388325334B;
	Sun, 21 Dec 2025 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvlOyELE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59324DCEB
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352022; cv=none; b=F7Q7qzeV1ELHPmKtXQe+3go4w/wH3XfWDIge39oYV8bWPr9NLMQ3ZfLO3O1bqlF3yvJYfIyYtkGRXohHW955lMYbSPX5FD+/9JjSHNB5TaYojH9vOtxaHcmEgsLn1beoHJDUK2JAW4PJeVX0S9/WwDqYkhfX2lYjmsIW3/aBGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352022; c=relaxed/simple;
	bh=Vdcki3ICovIYvVt6hGSX7ffpTGYTSqXHQxmaUfk1HtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hROup8Wr1GCWmnfvLUCP2iO4h+YtUtP8hGpPQt/VN8xvS7r7kFPbZg5BGrs3hTpKr8k6uUkLOj8w62TKHvj8AZddMbzeuBzZt87QWDZ7BkqJjSNlCl+Fgi8G+qk2jtNVqiuwsI+5lVCAt70PnQV6JGJy4KkAEezMOkJTntH7D4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvlOyELE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430ff148844so1647162f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352016; x=1766956816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqVbxVh2Noo4tVuzF11+ZWmHdpJazJWA646OpgCJK48=;
        b=EvlOyELEJl6bVUF73n45r+VTG6CaPeWQ7B9PP2vRsQS9JqNP2JmCMdTsfH7fnBLF0T
         Z223WLBxdjwM1TI9Hvd1nNyhoL3atuD6cxf9SQEbZkinf2TYJjb/IyKETE8T7GdEKUyf
         HkgBSHLE29MfMWGxlCL+TtAhYDaksj3QtazoiCkbJMQ6ozWkV1MQB58Yy7CsS7a9Gs+L
         7FDtI8FZwgYYSiGzX2nUufZjAIBDoM8IAOtWadNEKxROPLG0pLtrgCI2xZaQTVHNAaLm
         EzlvMal/qtEPZ9lC9rlkqZTSL3i0XrEp6LcLsAFs7T88ZuGTgp/Jjmv/9kuzDAzfwCn9
         9QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352016; x=1766956816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqVbxVh2Noo4tVuzF11+ZWmHdpJazJWA646OpgCJK48=;
        b=PjGHug1xyoIMAn7yMmawoJ6pZlOxB2q/qocXNNlJM8CK5R83u9wYXSbjNcMzoOBFQs
         SqOcpTne5x+dwZymTVEWSVqndIc5CyDmN5dKAh+KRQHNxwNbls1gajrvIv8+FvxxnitO
         PKgo/WcRf1gQAwNUZo4K+jjrtBB3ABJdDh4dF0Eaw517kPh3juBeNE1kCHEsxoCgl0wl
         QNgZGFr/GUx9j/nB+xKggGxQq6+wcfP2sPX+fGzNRG7Lombe+8I+7c2L/F6OItc6UjWx
         6Ux01xcxu2NfLrKleeroM8f/ofYT272wo3FYTLye/gEhK2jKnVRiAPMziX/GXEeRUTFw
         ZdWg==
X-Gm-Message-State: AOJu0YzUKzYD3JCaJ6D4XDeugWqMtTWFCeyz1F9XCmF6lO3CZ/JSVWdV
	WA1lG5keYHQqmAYB6AwMRBAzQdBRa73BWHwcWU8FQ6/5zN8F2BAI9gl0
X-Gm-Gg: AY/fxX4cV/gvFbC1CMdzttJWIrbqLr94P7Me8+pnhsO1+JmQo8lYrPbLMg/LZJML58f
	pNg2BIZJfgIf9LMLPpaRH3Cs2d3+HQ5sSCGrNgwDXg1/JlXQAsAbqHFHaGW6TDtoPIJhbCTsCXd
	Dccqg9vFX0AdoAWq1vB6GXbUCsc3KDUcfWt8AMIowSKgilAvp4S/hkVilo1iro0H1kDnc9QD6IN
	7Jc8vgQEfuqS8ilDLI3lTYBg8JCOoMulwg3+xjkNatcQrUgQZ9Ap0Lyh1FMO2Ulmbqko2nGnj82
	7TFw2fRnZuCg05nf9yziRpLsBTeo4rIaMbxPMwxyGTrg5yHeUwJTri/ADAXTWMHmXwcw2dsci3I
	/z+H6xFTFn8GxrV28jN8BCUBkTTFQ4sSUbTsdl2Kw02txayH64QBhcqwfb4GfPXEPXVe++4GEgO
	bm7tRx8Dz2lZrHYPAZCkGb08Jldm//asPmCRFgxB/LOYZIZqY3Obive6s35mNpa1iwop43Duk=
X-Google-Smtp-Source: AGHT+IFXNtpeIxs0KlqNxuBjhRb7FYBmpziDOdKCNMxLwN1tgHxP58OId+4FJ7yrU0wc6ByRw02qDw==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr13785115f8f.18.1766352016290;
        Sun, 21 Dec 2025 13:20:16 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:14 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 4/5] selftests/net: add no NDP bcast/null poison test
Date: Sun, 21 Dec 2025 22:19:37 +0100
Message-ID: <585e7c7c80c24492c7a7565e355c226a7e0d4349.1766349632.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1766349632.git.marcdevel@gmail.com>
References: <cover.1766349632.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a selftest to test that NDP bcast/null poisioning checks are
never bypassed.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/arp_ndisc_no_bcastnull_poison.sh      | 334 ++++++++++++++++++
 .../selftests/net/arp_no_bcastnull_poision.sh | 159 ---------
 tools/testing/selftests/net/ndisc_send.c      | 198 +++++++++++
 5 files changed, 534 insertions(+), 159 deletions(-)
 create mode 100755 tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
 delete mode 100755 tools/testing/selftests/net/arp_no_bcastnull_poision.sh
 create mode 100644 tools/testing/selftests/net/ndisc_send.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index fd08ceeab07c..5a82300a22a9 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -18,6 +18,7 @@ ipv6_flowlabel_mgr
 ipv6_fragmentation
 log.txt
 msg_zerocopy
+ndisc_send
 netlink-dumps
 nettest
 proc_net_pktgen
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 8308f0067547..a5bd845e1c58 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -169,6 +169,7 @@ TEST_GEN_PROGS := \
 	bind_wildcard \
 	epoll_busy_poll \
 	ipv6_fragmentation \
+	ndisc_send \
 	proc_net_pktgen \
 	reuseaddr_conflict \
 	reuseport_bpf \
diff --git a/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh b/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
new file mode 100755
index 000000000000..dd0bdd0e3f37
--- /dev/null
+++ b/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
@@ -0,0 +1,334 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Tests that ARP announcements with Broadcast or NULL mac are never
+# accepted
+#
+
+source lib.sh
+
+readonly V4_ADDR0="10.0.10.1"
+readonly V6_ADDR0="fd00:1::1"
+readonly V4_ADDR1="10.0.10.2"
+readonly V6_ADDR1="fd00:1::2"
+readonly V6_ALL_NODES="ff02::1"
+readonly V6_SOL_NODE1="ff02::1:ff00:0002"
+readonly BCAST_MAC="ff:ff:ff:ff:ff:ff"
+readonly NULL_MAC="00:00:00:00:00:00"
+readonly VALID_MAC="02:01:02:03:04:05"
+readonly V6_ALL_NODE_MAC="33:33:FF:00:00:01"
+readonly V6_SOL_NODE_MAC1="33:33:FF:00:00:02"
+readonly NS=135
+readonly NA=136
+readonly ARP_REQ=1
+readonly ARP_REPLY=2
+nsid=100
+ret=0
+veth0_ifindex=0
+veth1_mac=
+
+setup() {
+	setup_ns PEER_NS
+
+	ip link add name veth0 type veth peer name veth1
+	ip link set dev veth0 up
+	ip link set dev veth1 netns ${PEER_NS}
+	ip netns exec ${PEER_NS} ip link set dev veth1 up
+	ip addr add ${V4_ADDR0}/24 dev veth0
+	ip addr add ${V6_ADDR0}/64 dev veth0
+	ip netns exec ${PEER_NS} ip addr add ${V4_ADDR1}/24 dev veth1
+	ip netns exec ${PEER_NS} ip route add default via ${V4_ADDR0} dev veth1
+
+	ip netns exec ${PEER_NS} ip addr add ${V6_ADDR1}/64 dev veth1
+	ip netns exec ${PEER_NS} ip route add default via ${V6_ADDR0} dev veth1
+
+	# Raise ARP timers to avoid flakes due to refreshes
+	sysctl -w net.ipv4.neigh.veth0.base_reachable_time=3600 \
+		>/dev/null 2>&1
+	ip netns exec ${PEER_NS} \
+		sysctl -w net.ipv4.neigh.veth1.gc_stale_time=3600 \
+		>/dev/null 2>&1
+	ip netns exec ${PEER_NS} \
+		sysctl -w net.ipv4.neigh.veth1.base_reachable_time=3600 \
+		>/dev/null 2>&1
+
+	veth0_ifindex=$(ip -j link show veth0 | jq -r '.[0].ifindex')
+	veth1_mac="$(ip netns exec ${PEER_NS} ip -j link show veth1 | \
+		jq -r '.[0].address' )"
+}
+
+cleanup() {
+	ip neigh flush dev veth0
+	ip link del veth0
+	cleanup_ns ${PEER_NS}
+}
+
+# Make sure ARP announcement with invalid MAC is never learnt
+run_no_arp_poisoning() {
+	local l2_dmac=${1}
+	local tmac=${2}
+	local op=${3}
+
+	ret=0
+
+	ip netns exec ${PEER_NS} ip neigh flush dev veth1 >/dev/null 2>&1
+	ip netns exec ${PEER_NS} ping -c 1 ${V4_ADDR0} >/dev/null 2>&1
+
+	# Poison with a valid MAC to ensure injection is working
+	./arp_send ${veth0_ifindex} ${BCAST_MAC} ${VALID_MAC} ${op} \
+		${V4_ADDR0} ${VALID_MAC} ${V4_ADDR0} ${VALID_MAC}
+
+	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
+		grep ${VALID_MAC})
+	if [ "${neigh}" == "" ]; then
+		echo "ERROR: unable to ARP poision with a valid MAC ${VALID_MAC}"
+		ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0}
+		ret=1
+		return
+	fi
+
+	# Poison with tmac
+	./arp_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${op} \
+		${V4_ADDR0} ${tmac} ${V4_ADDR0} ${tmac}
+
+	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
+		grep ${tmac})
+	if [ "${neigh}" != "" ]; then
+		echo "ERROR: ARP entry learnt for ${tmac} announcement."
+		ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0}
+		ret=1
+		return
+	fi
+}
+
+# Make sure NDP announcement with invalid MAC is never learnt
+run_no_ndp_poisoning() {
+	local l2_dmac=${1}
+	local dst_ip=${2}
+	local op=${3}
+	local tip=${V6_ADDR0}
+	local tmac=${4}
+
+	if [ "${op}" == "${NS}" ]; then
+		tip=${V6_ADDR1}
+	fi
+
+	ret=0
+
+	ip netns exec ${PEER_NS} ip -6 neigh flush dev veth1 >/dev/null 2>&1
+	ip netns exec ${PEER_NS} ping -c 1 ${V6_ADDR0} >/dev/null 2>&1
+
+	# Poison with a valid MAC to ensure injection is working
+	./ndisc_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${dst_ip} \
+		${V6_ADDR0} ${tip} ${op} ${VALID_MAC}
+	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0} | \
+		grep ${VALID_MAC})
+	if [ "${neigh}" == "" ]; then
+		echo "ERROR: unable to NDP poision with a valid MAC ${VALID_MAC}"
+		ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0}
+		ret=1
+		return
+	fi
+
+	# Poison with tmac
+	./ndisc_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${dst_ip} \
+		${V6_ADDR0} ${tip} ${op} ${tmac}
+	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0} | \
+		grep ${tmac})
+	if [ "${neigh}" != "" ]; then
+		echo "ERROR: NDP entry learnt for ${tmac} announcement."
+		ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0}
+		ret=1
+		return
+	fi
+}
+
+print_test_result() {
+	local msg=${1}
+	local rc=${2}
+
+	if [ ${rc} == 0 ]; then
+		printf "TEST: %-60s  [ OK ]" "${msg}"
+	else
+		printf "TEST: %-60s  [ FAIL ]" "${msg}"
+	fi
+}
+
+run_all_tests() {
+	local results
+
+	setup
+
+	### ARP
+	## Broadcast gARPs
+	msg="1.1  ARP no poisoning dmac=bcast reply sha=bcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.2  ARP no poisoning dmac=bcast reply sha=null"
+	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.3  ARP no poisoning dmac=bcast req   sha=bcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.4  ARP no poisoning dmac=bcast req   sha=null"
+	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	## Targeted gARPs
+	msg="1.5  ARP no poisoning dmac=veth0 reply sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.6  ARP no poisoning dmac=veth0 reply sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.7  ARP no poisoning dmac=veth0 req   sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.8  ARP no poisoning dmac=veth0 req   sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	### NDP
+	## NA
+	# Broadcast / All node MAC, all-node IP announcements
+	msg="2.1  NDP no poisoning dmac=bcast   all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ALL_NODES} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.2  NDP no poisoning dmac=bcast   all_nodes na lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ALL_NODES} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.3  NDP no poisoning dmac=allnode all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ALL_NODES} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.4  NDP no poisoning dmac=allnode all_nodes na lladdr=null"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ALL_NODES} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.5  NDP no poisoning dmac=bcast   all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ALL_NODES} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.6  NDP no poisoning dmac=bcast   all_nodes na lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ALL_NODES} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.7  NDP no poisoning dmac=allnode all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ALL_NODES} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.8  NDP no poisoning dmac=allnode all_nodes na lladdr=null"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ALL_NODES} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Broadcast / All node MAC, Targeted IP announce
+	msg="2.9  NDP no poisoning dmac=bcast   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.10 NDP no poisoning dmac=bcast   targeted  na lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.11 NDP no poisoning dmac=allnode targeted  na lladdr=bcast"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ADDR1} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.12 NDP no poisoning dmac=allnode targeted  na lladdr=null"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ADDR1} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.13 NDP no poisoning dmac=bcast   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.14 NDP no poisoning dmac=bcast   targeted  na lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.15 NDP no poisoning dmac=allnode targeted  na lladdr=bcast"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ADDR1} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.16 NDP no poisoning dmac=allnode targeted  na lladdr=null"
+	run_no_ndp_poisoning ${V6_ALL_NODE_MAC} ${V6_ADDR1} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Targeted MAC, Targeted IP announce
+	msg="2.17 NDP no poisoning dmac=veth1   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning ${veth1_mac} ${V6_ADDR1} ${NA} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.18 NDP no poisoning dmac=veth1   targeted  na lladdr=null"
+	run_no_ndp_poisoning ${veth1_mac} ${V6_ADDR1} ${NA} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	## NS
+	# Broadcast / SolNode node MAC, SolNode IP solic
+	msg="2.19 NDP no poisoning dmac=bcast   solnode   ns lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_SOL_NODE1} ${NS} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.20 NDP no poisoning dmac=bcast   solnode   ns lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_SOL_NODE1} ${NS} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.19 NDP no poisoning dmac=solnode solnode   ns lladdr=bcast"
+	run_no_ndp_poisoning ${V6_SOL_NODE_MAC1} ${V6_SOL_NODE1} ${NS} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.20 NDP no poisoning dmac=solnode solnode   ns lladdr=null"
+	run_no_ndp_poisoning ${V6_SOL_NODE_MAC1} ${V6_SOL_NODE1} ${NS} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Broadcast / SolNode node MAC, target IP solic
+	msg="2.21 NDP no poisoning dmac=bcast   target    ns lladdr=bcast"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NS} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.22 NDP no poisoning dmac=bcast   target    ns lladdr=null"
+	run_no_ndp_poisoning ${BCAST_MAC} ${V6_ADDR1} ${NS} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.23 NDP no poisoning dmac=solnode target    ns lladdr=bcast"
+	run_no_ndp_poisoning ${V6_SOL_NODE_MAC1} ${V6_ADDR1} ${NS} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.24 NDP no poisoning dmac=solnode target    ns lladdr=null"
+	run_no_ndp_poisoning ${V6_SOL_NODE_MAC1} ${V6_ADDR1} ${NS} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Targeted MAC, Targeted IP solic
+	msg="2.25 NDP no poisoning dmac=veth1   target    ns lladdr=bcast"
+	run_no_ndp_poisoning ${veth1_mac} ${V6_ADDR1} ${NS} ${BCAST_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="2.26 NDP no poisoning dmac=veth1   target    ns lladdr=null"
+	run_no_ndp_poisoning ${veth1_mac} ${V6_ADDR1} ${NS} ${NULL_MAC}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	cleanup
+
+	printf '%b' "${results}"
+}
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit $ksft_skip;
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+run_all_tests
+exit $ret
diff --git a/tools/testing/selftests/net/arp_no_bcastnull_poision.sh b/tools/testing/selftests/net/arp_no_bcastnull_poision.sh
deleted file mode 100755
index d0b9241599f1..000000000000
--- a/tools/testing/selftests/net/arp_no_bcastnull_poision.sh
+++ /dev/null
@@ -1,159 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Tests that ARP announcements with Broadcast or NULL mac are never
-# accepted
-#
-
-source lib.sh
-
-readonly V4_ADDR0="10.0.10.1"
-readonly V4_ADDR1="10.0.10.2"
-readonly BCAST_MAC="ff:ff:ff:ff:ff:ff"
-readonly NULL_MAC="00:00:00:00:00:00"
-readonly VALID_MAC="02:01:02:03:04:05"
-readonly ARP_REQ=1
-readonly ARP_REPLY=2
-nsid=100
-ret=0
-veth0_ifindex=0
-veth1_mac=
-
-setup() {
-	setup_ns PEER_NS
-
-	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 up
-	ip link set dev veth1 netns ${PEER_NS}
-	ip netns exec ${PEER_NS} ip link set dev veth1 up
-	ip addr add ${V4_ADDR0}/24 dev veth0
-	ip netns exec ${PEER_NS} ip addr add ${V4_ADDR1}/24 dev veth1
-	ip netns exec ${PEER_NS} ip route add default via ${V4_ADDR0} dev veth1
-
-	# Raise ARP timers to avoid flakes due to refreshes
-	sysctl -w net.ipv4.neigh.veth0.base_reachable_time=3600 \
-		>/dev/null 2>&1
-	ip netns exec ${PEER_NS} \
-		sysctl -w net.ipv4.neigh.veth1.gc_stale_time=3600 \
-		>/dev/null 2>&1
-	ip netns exec ${PEER_NS} \
-		sysctl -w net.ipv4.neigh.veth1.base_reachable_time=3600 \
-		>/dev/null 2>&1
-
-	veth0_ifindex=$(ip -j link show veth0 | jq -r '.[0].ifindex')
-	veth1_mac="$(ip netns exec ${PEER_NS} ip -j link show veth1 | \
-		jq -r '.[0].address' )"
-}
-
-cleanup() {
-	ip neigh flush dev veth0
-	ip link del veth0
-	cleanup_ns ${PEER_NS}
-}
-
-# Make sure ARP announcement with invalid MAC is never learnt
-run_no_arp_poisoning() {
-	local l2_dmac=${1}
-	local tmac=${2}
-	local op=${3}
-
-	ret=0
-
-	ip netns exec ${PEER_NS} ip neigh flush dev veth1 >/dev/null 2>&1
-	ip netns exec ${PEER_NS} ping -c 1 ${V4_ADDR0} >/dev/null 2>&1
-
-	# Poison with a valid MAC to ensure injection is working
-	./arp_send ${veth0_ifindex} ${BCAST_MAC} ${VALID_MAC} ${op} \
-		${V4_ADDR0} ${VALID_MAC} ${V4_ADDR0} ${VALID_MAC}
-
-	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
-		grep ${VALID_MAC})
-	if [ "${neigh}" == "" ]; then
-		echo "ERROR: unable to ARP poision with a valid MAC ${VALID_MAC}"
-		ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0}
-		ret=1
-		return
-	fi
-
-	# Poison with tmac
-	./arp_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${op} \
-		${V4_ADDR0} ${tmac} ${V4_ADDR0} ${tmac}
-
-	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
-		grep ${tmac})
-	if [ "${neigh}" != "" ]; then
-		echo "ERROR: ARP entry learnt for ${tmac} announcement."
-		ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0}
-		ret=1
-		return
-	fi
-}
-
-print_test_result() {
-	local msg=${1}
-	local rc=${2}
-
-	if [ ${rc} == 0 ]; then
-		printf "TEST: %-60s  [ OK ]" "${msg}"
-	else
-		printf "TEST: %-60s  [ FAIL ]" "${msg}"
-	fi
-}
-
-run_all_tests() {
-	local results
-
-	setup
-
-	## ARP
-	# Broadcast gARPs
-	msg="1.1 ARP no poisoning dmac=bcast reply sha=bcast"
-	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REPLY}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.2 ARP no poisoning dmac=bcast reply sha=null"
-	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REPLY}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.3 ARP no poisoning dmac=bcast req   sha=bcast"
-	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REQ}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.4 ARP no poisoning dmac=bcast req   sha=null"
-	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REQ}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	# Targeted gARPs
-	msg="1.5 ARP no poisoning dmac=veth0 reply sha=bcast"
-	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REPLY}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.6 ARP no poisoning dmac=veth0 reply sha=null"
-	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REPLY}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.7 ARP no poisoning dmac=veth0 req   sha=bcast"
-	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REQ}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	msg="1.8 ARP no poisoning dmac=veth0 req   sha=null"
-	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REQ}
-	results+="$(print_test_result "${msg}" ${ret})\n"
-
-	cleanup
-
-	printf '%b' "${results}"
-}
-
-if [ "$(id -u)" -ne 0 ];then
-	echo "SKIP: Need root privileges"
-	exit $ksft_skip;
-fi
-
-if [ ! -x "$(command -v ip)" ]; then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
-run_all_tests
-exit $ret
diff --git a/tools/testing/selftests/net/ndisc_send.c b/tools/testing/selftests/net/ndisc_send.c
new file mode 100644
index 000000000000..4f226221d079
--- /dev/null
+++ b/tools/testing/selftests/net/ndisc_send.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <inttypes.h>
+#include <netinet/ether.h>
+#include <arpa/inet.h>
+
+#include <linux/if_packet.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/icmpv6.h>
+
+#define ICMPV6_ND_NS 135
+#define ICMPV6_ND_NA 136
+#define ICMPV6_ND_SLLADR 1
+#define ICMPV6_ND_TLLADR 2
+
+#ifndef __noinline
+#define __noinline __attribute__((noinline))
+#endif
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct icmp6_pseudohdr {
+	struct in6_addr saddr;
+	struct in6_addr daddr;
+	uint32_t plen;
+	uint8_t zero[3];
+	uint8_t next;
+};
+
+struct ndisc_pkt {
+	struct ethhdr eth;
+	struct ipv6hdr ip6;
+	struct ndp_hdrs {
+		struct icmp6hdr hdr;
+		struct in6_addr target;
+
+		uint8_t opt_type;
+		uint8_t opt_len;
+		uint8_t opt_mac[ETH_ALEN];
+	} __packed ndp;
+} __packed;
+
+__noinline uint32_t csum_add(void *buf, int len, uint32_t sum)
+{
+	uint16_t *p = (uint16_t *)buf;
+
+	while (len > 1) {
+		sum += *p++;
+		len -= 2;
+	}
+
+	if (len)
+		sum += *(uint8_t *)p;
+
+	return sum;
+}
+
+static uint16_t csum_fold(uint32_t sum)
+{
+	return ~((sum & 0xffff) + (sum >> 16)) ? : 0xffff;
+}
+
+int parse_opts(int argc, char **argv, int *ifindex, struct ndisc_pkt *pkt)
+{
+	struct ether_addr *mac;
+	uint16_t op;
+	struct icmp6_pseudohdr ph = {0};
+	uint32_t sum = 0;
+
+	if (argc != 9) {
+		fprintf(stderr, "Usage: %s <iface> <mac_dst> <mac_src> <dst_ip> <src_ip> <target_ip> <op> <lladr>\n",
+			argv[0]);
+		return -1;
+	}
+
+	*ifindex = atoi(argv[1]);
+	mac = ether_aton(argv[2]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse mac_dst from '%s'\n", argv[1]);
+		return -1;
+	}
+
+	/* Ethernet */
+	memcpy(pkt->eth.h_dest, mac, ETH_ALEN);
+	mac = ether_aton(argv[3]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse mac_src from '%s'\n", argv[2]);
+		return -1;
+	}
+	memcpy(pkt->eth.h_source, mac, ETH_ALEN);
+	pkt->eth.h_proto = htons(ETH_P_IPV6);
+
+	/* IPv6 */
+	pkt->ip6.version = 6;
+	pkt->ip6.nexthdr = IPPROTO_ICMPV6;
+	pkt->ip6.hop_limit = 255;
+
+	if (inet_pton(AF_INET6, argv[4], &pkt->ip6.daddr) != 1) {
+		fprintf(stderr, "Unable to parse src_ip from '%s'\n", argv[4]);
+		return -1;
+	}
+	if (inet_pton(AF_INET6, argv[5], &pkt->ip6.saddr) != 1) {
+		fprintf(stderr, "Unable to parse src_ip from '%s'\n", argv[5]);
+		return -1;
+	}
+
+	/* ICMPv6 */
+	op = atoi(argv[7]);
+	if (op != ICMPV6_ND_NS && op != ICMPV6_ND_NA) {
+		fprintf(stderr, "Invalid ICMPv6 op %d\n", op);
+		return -1;
+	}
+
+	pkt->ndp.hdr.icmp6_type = op;
+	pkt->ndp.hdr.icmp6_code = 0;
+
+	if (inet_pton(AF_INET6, argv[6], &pkt->ndp.target) != 1) {
+		fprintf(stderr, "Unable to parse target_ip from '%s'\n",
+			argv[6]);
+		return -1;
+	}
+
+	/* Target/Source Link-Layer Address */
+	if (op == ICMPV6_ND_NS) {
+		pkt->ndp.opt_type = ICMPV6_ND_SLLADR;
+	} else {
+		pkt->ndp.opt_type = ICMPV6_ND_TLLADR;
+		pkt->ndp.hdr.icmp6_override = 1;
+	}
+	pkt->ndp.opt_len = 1;
+
+	mac = ether_aton(argv[8]);
+	if (!mac) {
+		fprintf(stderr, "Invalid lladdr %s\n", argv[8]);
+		return -1;
+	}
+
+	memcpy(pkt->ndp.opt_mac, mac, ETH_ALEN);
+
+	pkt->ip6.payload_len = htons(sizeof(pkt->ndp));
+
+	/* Pseudoheader */
+	ph.saddr = pkt->ip6.saddr;
+	ph.daddr = pkt->ip6.daddr;
+	ph.plen = htonl(sizeof(pkt->ndp));
+	ph.next = IPPROTO_ICMPV6;
+
+	sum = csum_add(&ph, sizeof(ph), 0);
+	sum = csum_add(&pkt->ndp, sizeof(pkt->ndp), sum);
+
+	pkt->ndp.hdr.icmp6_cksum = csum_fold(sum);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int rc, fd;
+	struct sockaddr_ll bind_addr = {0};
+	int ifindex;
+	struct ndisc_pkt pkt = {0};
+
+	if (parse_opts(argc, argv, &ifindex, &pkt) < 0)
+		return -1;
+
+	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (fd < 0) {
+		fprintf(stderr, "Unable to open raw socket(%d). Need root privileges?\n",
+			fd);
+		return 1;
+	}
+
+	bind_addr.sll_family   = AF_PACKET;
+	bind_addr.sll_protocol = htons(ETH_P_ALL);
+	bind_addr.sll_ifindex  = ifindex;
+
+	rc = bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
+	if (rc < 0) {
+		fprintf(stderr, "Unable to bind raw socket(%d). Invalid iface '%d'?\n",
+			rc, ifindex);
+		return 1;
+	}
+
+	rc = send(fd, &pkt, sizeof(pkt), 0);
+	if (rc < 0) {
+		fprintf(stderr, "Unable to send packet: %d\n", rc);
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.47.3


