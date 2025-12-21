Return-Path: <netdev+bounces-245660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F26BCD45C9
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E2313004D39
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EF248867;
	Sun, 21 Dec 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh7WEKeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C824E4AF
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352019; cv=none; b=u59Wbe/50VaplB2bZZ55EFEuonrabcTuP9ZGoVQxu8aeA4quP81IrMx9xV56BuSMIofsd1zNALGEo5MzkXZwtvJxCXhIzH/0kVr0lWVOSWOwk/UhuY8JvNpzs2sMQZnB4EFGB8Uwe/y4DrAWeMCJ9pFR9L+nrUX8VH1l3ZJlxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352019; c=relaxed/simple;
	bh=+2Wb/Npnocg3SWxuPxZOWbVkOXaXt1eSX4L1Us7JW/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0OvTWQY7+/U910YvafMwofjiOe5cP8XjHKeUNDELuhdwxqC28Cta930YhziOuVUviMyaxixCjvoMn8q+BunGRSJA3x3ttx9IJ05rXvup/v5x4g8N0Zacjlors3qOE+3P5XC8iPABjeJRY6s7PYmNrX18T93DY2vSKWl7DpXbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh7WEKeU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42f9ece6387so1219422f8f.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352013; x=1766956813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7CGrC5YUMQMp3kwftJAYcDub7VZfS5GoIKF6gcxwE0=;
        b=Qh7WEKeUt7oOcGE3kkhC3q5Jtkudt/M5xV1Cp2W/BbC7eWPPBMamjIdYV9GG40qYkG
         RPQx2GGjMgzImJsHwncnHT8Dz++U9D4Dxd2UYe4dcqd0Dd3VDtfcqaR7386YNhrEoW/p
         Zk4FlvBwVvMhhYCSrWGaRbNaBkViaJds20P7u6GslCI6Cbja7cQdYx/hfM0Z7RMh8kHI
         XEG+Z083qCmpWznz8A4V4CJHZO6ZObYyPb5oHV0v4TmLKx2h59M8ClS2ueOBHGzl0V08
         J5v11OoR+2sRkGOFJM64SZurmwvuHwENtU0tYrPvzN/MB7tmJed3G54pWS448aWwOQCA
         fJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352013; x=1766956813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7CGrC5YUMQMp3kwftJAYcDub7VZfS5GoIKF6gcxwE0=;
        b=vVBgEWai4RlccmNVdTGz9e+E07EFi+DDbH+9NWHk3IvJ0qpVqiwdtiN4YT36ycMruM
         tsjgvaxhFhPC+ospF+NUdAxcxE8VA78yOAApmDvVYJsjWa7ELBJch3tSkYhlRIvUSLPA
         a1HHcQpRhVHXiSuYR3hpD9w6TaFcGDkWOPIxUyVmUq6E5dVpIBsMkOoM0XukU0DpZf/5
         s0B+Oe5X5fzF9gOWUa9099l/ZKgqnYkUzTyxFJ1kBnBvynECLdLRTU4vvrtycM3AyGuj
         8JmhNBklONTVXapj7H4Ce13KUHjj/chmcY4/rC4peSVBiN8rayKeoJblCz2ppDF2fkUu
         bt3w==
X-Gm-Message-State: AOJu0YwMBL3MdlRq/sg6eoRd6Q/Bcy58i8JnhmIp4hSIam4zE+1wF5v2
	TeHAoP/5+wP+szDoMMi+F93iq2d4E7ObuKQFUCudJ8OmnETkhLW9vWCJp9R4tA==
X-Gm-Gg: AY/fxX6c+RT4Io13vcbtcc4ZHXviaFm9DwHLyY8unvdHqbsDNUH3AJBytcNO/HBGqg5
	45JWECLahasDqRKgKzewdHi/d7O175uMGg9SSQUTX4nlTqkTiQq2hzHLdXhV+54/ouTEVhN5wXp
	ehZE5MARpvchFG/irjac/CsiH5YlxVTGTIIJeWYXE6H67tzHWwCjOZ0a1LQMCUTYaIm5Ms9K1aX
	GSj9HbsBQx2JdIGhE1e4tjN+SR70yBlatVGpt+OEYIpr0qmU6IBrpYKC84C9Xs9mdbwpl6KBm9z
	xbJsRupbHT2JDbLLicuqXOB5F9y5+ZbRmYVIO4+AOEKM65vv3VwSmT7vUJFat6DD5OukBXm4AQS
	vxYTH1fqDJ9LBhICVW02hn1ozcimd4NOc7uRs+T5uvveS2g0iW38LXTllVhvnafzkzKIxcFtZHD
	Hb+nkzvSrGttc2JzF1yaksAIg0p+DbBEitfFgEMssidc4fNJZulDwd0YVewPgqtgSjRIT28KRBS
	+7OMmXtRw==
X-Google-Smtp-Source: AGHT+IHvguj4+sj43OornNFJtVmJGF0/IHvvsgdRRmbdvstep+H6wfFgQkdl2G69STAS0jYELxvXtw==
X-Received: by 2002:a05:6000:2387:b0:42f:8816:c01a with SMTP id ffacd0b85a97d-4324e701ea0mr10706774f8f.62.1766352013149;
        Sun, 21 Dec 2025 13:20:13 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:12 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 2/5] selftests/net: add no ARP bcast/null poison test
Date: Sun, 21 Dec 2025 22:19:35 +0100
Message-ID: <1714feebff7b8d17c3b355430e046344a81399cb.1766349632.git.marcdevel@gmail.com>
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

Add a selftest to test that ARP bcast/null poisioning checks are
never bypassed.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 .../selftests/net/arp_no_bcastnull_poision.sh | 159 ++++++++++++++++++
 tools/testing/selftests/net/arp_send.c        | 138 +++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_no_bcastnull_poision.sh
 create mode 100644 tools/testing/selftests/net/arp_send.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 6930fe926c58..fd08ceeab07c 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+arp_send
 bind_bhash
 bind_timewait
 bind_wildcard
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..8308f0067547 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -9,6 +9,7 @@ CFLAGS += -I../
 TEST_PROGS := \
 	altnames.sh \
 	amt.sh \
+	arp_no_bcastnull_poision.sh \
 	arp_ndisc_evict_nocarrier.sh \
 	arp_ndisc_untracked_subnets.sh \
 	bareudp.sh \
@@ -163,6 +164,7 @@ TEST_GEN_FILES := \
 # end of TEST_GEN_FILES
 
 TEST_GEN_PROGS := \
+	arp_send \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
diff --git a/tools/testing/selftests/net/arp_no_bcastnull_poision.sh b/tools/testing/selftests/net/arp_no_bcastnull_poision.sh
new file mode 100755
index 000000000000..d0b9241599f1
--- /dev/null
+++ b/tools/testing/selftests/net/arp_no_bcastnull_poision.sh
@@ -0,0 +1,159 @@
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
+readonly V4_ADDR1="10.0.10.2"
+readonly BCAST_MAC="ff:ff:ff:ff:ff:ff"
+readonly NULL_MAC="00:00:00:00:00:00"
+readonly VALID_MAC="02:01:02:03:04:05"
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
+	ip netns exec ${PEER_NS} ip addr add ${V4_ADDR1}/24 dev veth1
+	ip netns exec ${PEER_NS} ip route add default via ${V4_ADDR0} dev veth1
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
+	## ARP
+	# Broadcast gARPs
+	msg="1.1 ARP no poisoning dmac=bcast reply sha=bcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.2 ARP no poisoning dmac=bcast reply sha=null"
+	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.3 ARP no poisoning dmac=bcast req   sha=bcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${BCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.4 ARP no poisoning dmac=bcast req   sha=null"
+	run_no_arp_poisoning ${BCAST_MAC} ${NULL_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Targeted gARPs
+	msg="1.5 ARP no poisoning dmac=veth0 reply sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.6 ARP no poisoning dmac=veth0 reply sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.7 ARP no poisoning dmac=veth0 req   sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.8 ARP no poisoning dmac=veth0 req   sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REQ}
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
diff --git a/tools/testing/selftests/net/arp_send.c b/tools/testing/selftests/net/arp_send.c
new file mode 100644
index 000000000000..463ee435c9c1
--- /dev/null
+++ b/tools/testing/selftests/net/arp_send.c
@@ -0,0 +1,138 @@
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
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct arp_pkt {
+	struct ethhdr eth;
+	struct {
+		struct arphdr hdr;
+
+		/* Variable part for Ethernet IP ARP */
+		unsigned char ar_sha[ETH_ALEN]; /* sender hardware address */
+		__be32 ar_sip;                  /* sender IP address       */
+		unsigned char ar_tha[ETH_ALEN]; /* target hardware address */
+		__be32 ar_tip;                  /* target IP address       */
+	} __packed arp;
+} __packed;
+
+int parse_opts(int argc, char **argv, int *ifindex, struct arp_pkt *pkt)
+{
+	int rc;
+	struct ether_addr *mac;
+	uint16_t op_code;
+
+	if (argc != 9) {
+		fprintf(stderr, "Usage: %s <iface> <mac_dst> <mac_src> <op_code> <target-ip> <target-hwaddr> <sender-ip> <sender-hwaddr>\n",
+			argv[0]);
+		return -1;
+	}
+
+	*ifindex = atoi(argv[1]);
+	mac = ether_aton(argv[2]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse mac_dst from '%s'\n", argv[2]);
+		return -1;
+	}
+
+	/* Ethernet */
+	memcpy(pkt->eth.h_dest, mac, ETH_ALEN);
+	mac = ether_aton(argv[3]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse mac_src from '%s'\n", argv[3]);
+		return -1;
+	}
+	memcpy(pkt->eth.h_source, mac, ETH_ALEN);
+	pkt->eth.h_proto = htons(ETH_P_ARP);
+
+	/* ARP */
+	op_code = atol(argv[4]);
+	if (op_code != ARPOP_REQUEST && op_code != ARPOP_REPLY) {
+		fprintf(stderr, "Invalid ARP op %s\n", argv[4]);
+		return -1;
+	}
+	pkt->arp.hdr.ar_op = htons(op_code);
+
+	pkt->arp.hdr.ar_hrd = htons(0x1); /* Ethernet */
+	pkt->arp.hdr.ar_pro = htons(ETH_P_IP);
+	pkt->arp.hdr.ar_hln = ETH_ALEN;
+	pkt->arp.hdr.ar_pln = 4;
+
+	rc = inet_pton(AF_INET, argv[5], &pkt->arp.ar_tip);
+	if (rc != 1) {
+		fprintf(stderr, "Invalid IPv4 address %s\n", argv[5]);
+		return -1;
+	}
+	rc = inet_pton(AF_INET, argv[7], &pkt->arp.ar_sip);
+	if (rc != 1) {
+		fprintf(stderr, "Invalid IPv4 address %s\n", argv[7]);
+		return -1;
+	}
+
+	mac = ether_aton(argv[6]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse target-hwaddr from '%s'\n",
+			argv[6]);
+		return -1;
+	}
+	memcpy(pkt->arp.ar_tha, mac, ETH_ALEN);
+	mac = ether_aton(argv[8]);
+	if (!mac) {
+		fprintf(stderr, "Unable to parse sender-hwaddr from '%s'\n",
+			argv[8]);
+		return -1;
+	}
+	memcpy(pkt->arp.ar_sha, mac, ETH_ALEN);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int rc, fd;
+	struct sockaddr_ll bind_addr = {0};
+	int ifindex;
+	struct arp_pkt pkt = {0};
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


