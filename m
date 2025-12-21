Return-Path: <netdev+bounces-245661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F31CD45CF
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F30C53004C8C
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C3B2505A5;
	Sun, 21 Dec 2025 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4mnj+yL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFF248F5C
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352021; cv=none; b=B8X5cXjX2a8TzhOgPDAO94S+oUSkXnSUAfu+hAsW0Fh/Qm0XQWVXBZElMQtpU96C5SZtLJI3l5u5Uu9YblZZtaOQMkoujo2PYHgpNFbXMNQn2y2VbEbavVHcc36BSNbUswzJcLIsSdrDWOyAFlyNF4phKwFTHnEKsPKvJ+oIomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352021; c=relaxed/simple;
	bh=H+HZM6bumyEGWYfONmys5Yk/QgtT5RkU6BYzH+6H02M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBij97lOLN4x1JbnUjsG1DUSOCCi6Z5/cv/IVBD7C0kYscZNSVjAWO6f/bFbVWI0Bv/KyiL3ZFAxJKazm8ESWlTxvb2SHVGFEApFajZ8edpM/CDLyKGFupQZg1rHkPNhHJb9Pc9ZktX7UU2nbZUYpEHapOqFLyhHycKt6nWtrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4mnj+yL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477b91680f8so28590575e9.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352018; x=1766956818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCD1mltWDFFvN5rFGI+GONViMkaogLhjOPTXKwpnxgA=;
        b=h4mnj+yLjxyk0AkB2I79pXTXjBxBB//fiwCNiTWP6/FHJJY+Bj3YsXZkIzH3WmPEz4
         /V/TpV7FRKa85n5z/2STw4TjQNN36FWBNWOmpDCNkHh4cUkcYIcq2a1GNu7nbB3NCnKj
         9DMYbB80EWXOdwAov6RXbFSDVlhL3lyAaL3karwLYsZ5pavpqNmPYvuXQmN/o3d5GlVo
         SUlpeLWIFM/whoaik3h/NcuEFUGVokHlCEQNoKr56mLV47C8mpTDothXsyQ6UsuD2pXV
         fxDEzTILa1mBp1isqQ4vDuN7sqzTayABLjbFFlglciqg0KDhz51t53QevKdOQAZsCVry
         A88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352018; x=1766956818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCD1mltWDFFvN5rFGI+GONViMkaogLhjOPTXKwpnxgA=;
        b=vEbqsSDSH39fTs0jO5sIpAA5aSIBFOEuQ7JVaYh0uMSTQPA7bH4o/I4yfbU/ejPuZp
         JuIlFkwdq3Y3u3QzjC4vBWyj6RH1GLzzRJ5gbXdsdW6UAj9J/OAQ7vwyzyFaDWQdZG9A
         0LRnXjsv2SOQ2mtRgU8C/sb1wFZ9HXlGWWe+zDfApcDLt1DFiFr6uuZGYImatiqgd/ja
         JRIbCpryw3nAVhtP2v00K7A8cBWWNFPgisM6Tlobbyx02+mSXHYXFsjqDEG125CkA52n
         zayv15VLxPKXsiF0RJ5nzAXtD1SWOgr89ovu2DQ39bJ6Thqf/kzo1/zadpgYuu0RYJvk
         QBTA==
X-Gm-Message-State: AOJu0YypKOGicK3HZTVOia/1eDZfMwHT6crlmZ7DJLmF+McoqKltsqcr
	e48N4NCehDVJMFVzZmODT2vrYHGbIeUvx0keJzdo04qD2ptJm/1prf1J
X-Gm-Gg: AY/fxX4NBw4uCnjOCAjfYrt1zorlrsK6BaKqzmdLm3XgTC4xloFGyqGRs/nEHQvhtvQ
	zHR2AgPUtwxaq1wGaV//XPA1P4hh9MeGkGXy/iDnXMNsA8Fdqm76k6ZKMvg5kzabETmFCFkFB6y
	TkpP/+71dTWbFHYJi3xeY90sPnNqCAY5EYnFMOTK7iO3gvmFRZq9VntQ3YnogwgUbNHku1Zv6DG
	YhhpqTm3Iy6Mx22fT2oDLZu+YVlQ739Y9KqtCs5cb/8iyu3Fe16/1h1jXPfUfi3mymuC9vNr3Y0
	27MqWDlm9Ws6904H3WYVpqfZiTNzvsBi3TLeN1UHpsnwZIijEJVd5/9dUqYORkKucQfhRcSdDg4
	nRP2oSOJbNocSkB6ZZpVT40GmITh79zDZ+zAUXHPVdPIZOVErVdA20NdiqI1dD1LkoHHSGNX8mc
	4LXWLosF9LSHkiFsCikKuOc4qUdqRZRrt2xMSJ8gmAKB8JCg02heh7H+0j60RUGWhi00LrD4w=
X-Google-Smtp-Source: AGHT+IHQar7G6n8DBEBSf0tVL+t70u2TjWLgkJd2Q9fnd7EeSonQ+dtOTBT7vV4w9m0qxygXlUURtg==
X-Received: by 2002:a05:600c:5487:b0:47b:da85:b9f3 with SMTP id 5b1f17b1804b1-47d195a72c0mr103753335e9.23.1766352017507;
        Sun, 21 Dec 2025 13:20:17 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:17 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 5/5] selftests/net: use scapy for no_bcastnull_poison
Date: Sun, 21 Dec 2025 22:19:38 +0100
Message-ID: <3cfd28edb2c2b055e74b975623a3d38ade0237f1.1766349632.git.marcdevel@gmail.com>
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

Use Scapy to generate ARP/ND packets for ARP/ND no bcast/NULL MAC
poisoning.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   2 -
 .../net/arp_ndisc_no_bcastnull_poison.sh      |  12 +-
 tools/testing/selftests/net/arp_send.c        | 138 ------------
 tools/testing/selftests/net/arp_send.py       |  24 +++
 tools/testing/selftests/net/ndisc_send.c      | 198 ------------------
 tools/testing/selftests/net/ndisc_send.py     |  36 ++++
 6 files changed, 66 insertions(+), 344 deletions(-)
 delete mode 100644 tools/testing/selftests/net/arp_send.c
 create mode 100644 tools/testing/selftests/net/arp_send.py
 delete mode 100644 tools/testing/selftests/net/ndisc_send.c
 create mode 100644 tools/testing/selftests/net/ndisc_send.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a5bd845e1c58..6fe0b962cd05 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -164,12 +164,10 @@ TEST_GEN_FILES := \
 # end of TEST_GEN_FILES
 
 TEST_GEN_PROGS := \
-	arp_send \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
 	ipv6_fragmentation \
-	ndisc_send \
 	proc_net_pktgen \
 	reuseaddr_conflict \
 	reuseport_bpf \
diff --git a/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh b/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
index dd0bdd0e3f37..8dc79da27a2e 100755
--- a/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
+++ b/tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
@@ -75,7 +75,7 @@ run_no_arp_poisoning() {
 	ip netns exec ${PEER_NS} ping -c 1 ${V4_ADDR0} >/dev/null 2>&1
 
 	# Poison with a valid MAC to ensure injection is working
-	./arp_send ${veth0_ifindex} ${BCAST_MAC} ${VALID_MAC} ${op} \
+	python3 ./arp_send.py "veth0" ${BCAST_MAC} ${VALID_MAC} ${op} \
 		${V4_ADDR0} ${VALID_MAC} ${V4_ADDR0} ${VALID_MAC}
 
 	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
@@ -88,7 +88,7 @@ run_no_arp_poisoning() {
 	fi
 
 	# Poison with tmac
-	./arp_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${op} \
+	python3 ./arp_send.py "veth0" ${BCAST_MAC} ${VALID_MAC} ${op} \
 		${V4_ADDR0} ${tmac} ${V4_ADDR0} ${tmac}
 
 	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V4_ADDR0} | \
@@ -119,8 +119,8 @@ run_no_ndp_poisoning() {
 	ip netns exec ${PEER_NS} ping -c 1 ${V6_ADDR0} >/dev/null 2>&1
 
 	# Poison with a valid MAC to ensure injection is working
-	./ndisc_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${dst_ip} \
-		${V6_ADDR0} ${tip} ${op} ${VALID_MAC}
+	python3 ./ndisc_send.py "veth0" ${l2_dmac} ${VALID_MAC} \
+		${dst_ip} ${V6_ADDR0} ${tip} ${op} ${VALID_MAC}
 	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0} | \
 		grep ${VALID_MAC})
 	if [ "${neigh}" == "" ]; then
@@ -131,8 +131,8 @@ run_no_ndp_poisoning() {
 	fi
 
 	# Poison with tmac
-	./ndisc_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${dst_ip} \
-		${V6_ADDR0} ${tip} ${op} ${tmac}
+	python3 ./ndisc_send.py "veth0" ${l2_dmac} ${VALID_MAC} \
+		${dst_ip} ${V6_ADDR0} ${tip} ${op} ${tmac}
 	neigh=$(ip netns exec ${PEER_NS} ip neigh show ${V6_ADDR0} | \
 		grep ${tmac})
 	if [ "${neigh}" != "" ]; then
diff --git a/tools/testing/selftests/net/arp_send.c b/tools/testing/selftests/net/arp_send.c
deleted file mode 100644
index 463ee435c9c1..000000000000
--- a/tools/testing/selftests/net/arp_send.c
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <sys/socket.h>
-#include <inttypes.h>
-#include <netinet/ether.h>
-#include <arpa/inet.h>
-
-#include <linux/if_packet.h>
-#include <linux/if_ether.h>
-
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
-struct arp_pkt {
-	struct ethhdr eth;
-	struct {
-		struct arphdr hdr;
-
-		/* Variable part for Ethernet IP ARP */
-		unsigned char ar_sha[ETH_ALEN]; /* sender hardware address */
-		__be32 ar_sip;                  /* sender IP address       */
-		unsigned char ar_tha[ETH_ALEN]; /* target hardware address */
-		__be32 ar_tip;                  /* target IP address       */
-	} __packed arp;
-} __packed;
-
-int parse_opts(int argc, char **argv, int *ifindex, struct arp_pkt *pkt)
-{
-	int rc;
-	struct ether_addr *mac;
-	uint16_t op_code;
-
-	if (argc != 9) {
-		fprintf(stderr, "Usage: %s <iface> <mac_dst> <mac_src> <op_code> <target-ip> <target-hwaddr> <sender-ip> <sender-hwaddr>\n",
-			argv[0]);
-		return -1;
-	}
-
-	*ifindex = atoi(argv[1]);
-	mac = ether_aton(argv[2]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse mac_dst from '%s'\n", argv[2]);
-		return -1;
-	}
-
-	/* Ethernet */
-	memcpy(pkt->eth.h_dest, mac, ETH_ALEN);
-	mac = ether_aton(argv[3]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse mac_src from '%s'\n", argv[3]);
-		return -1;
-	}
-	memcpy(pkt->eth.h_source, mac, ETH_ALEN);
-	pkt->eth.h_proto = htons(ETH_P_ARP);
-
-	/* ARP */
-	op_code = atol(argv[4]);
-	if (op_code != ARPOP_REQUEST && op_code != ARPOP_REPLY) {
-		fprintf(stderr, "Invalid ARP op %s\n", argv[4]);
-		return -1;
-	}
-	pkt->arp.hdr.ar_op = htons(op_code);
-
-	pkt->arp.hdr.ar_hrd = htons(0x1); /* Ethernet */
-	pkt->arp.hdr.ar_pro = htons(ETH_P_IP);
-	pkt->arp.hdr.ar_hln = ETH_ALEN;
-	pkt->arp.hdr.ar_pln = 4;
-
-	rc = inet_pton(AF_INET, argv[5], &pkt->arp.ar_tip);
-	if (rc != 1) {
-		fprintf(stderr, "Invalid IPv4 address %s\n", argv[5]);
-		return -1;
-	}
-	rc = inet_pton(AF_INET, argv[7], &pkt->arp.ar_sip);
-	if (rc != 1) {
-		fprintf(stderr, "Invalid IPv4 address %s\n", argv[7]);
-		return -1;
-	}
-
-	mac = ether_aton(argv[6]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse target-hwaddr from '%s'\n",
-			argv[6]);
-		return -1;
-	}
-	memcpy(pkt->arp.ar_tha, mac, ETH_ALEN);
-	mac = ether_aton(argv[8]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse sender-hwaddr from '%s'\n",
-			argv[8]);
-		return -1;
-	}
-	memcpy(pkt->arp.ar_sha, mac, ETH_ALEN);
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int rc, fd;
-	struct sockaddr_ll bind_addr = {0};
-	int ifindex;
-	struct arp_pkt pkt = {0};
-
-	if (parse_opts(argc, argv, &ifindex, &pkt) < 0)
-		return -1;
-
-	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-	if (fd < 0) {
-		fprintf(stderr, "Unable to open raw socket(%d). Need root privileges?\n",
-			fd);
-		return 1;
-	}
-
-	bind_addr.sll_family   = AF_PACKET;
-	bind_addr.sll_protocol = htons(ETH_P_ALL);
-	bind_addr.sll_ifindex  = ifindex;
-
-	rc = bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
-	if (rc < 0) {
-		fprintf(stderr, "Unable to bind raw socket(%d). Invalid iface '%d'?\n",
-			rc, ifindex);
-		return 1;
-	}
-
-	rc = send(fd, &pkt, sizeof(pkt), 0);
-	if (rc < 0) {
-		fprintf(stderr, "Unable to send packet: %d\n", rc);
-		return 1;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/net/arp_send.py b/tools/testing/selftests/net/arp_send.py
new file mode 100644
index 000000000000..1161dfd60b27
--- /dev/null
+++ b/tools/testing/selftests/net/arp_send.py
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from scapy.all import *
+
+if len(sys.argv) != 9:
+    print(f"Usage: {sys.argv[0]} <iface> <mac_dst> <mac_src> <op_code> <target-ip> <target-hwaddr> <sender-ip> <sender-hwaddr>\n");
+
+iface = sys.argv[1]
+mac_dst = sys.argv[2]
+mac_src = sys.argv[3]
+op = int(sys.argv[4])
+tip = sys.argv[5]
+tha = sys.argv[6]
+sip = sys.argv[5]
+sha = sys.argv[6]
+
+pkt = (
+    Ether(dst=mac_dst, src=mac_src) /
+    ARP(op=op, psrc=sip, hwsrc=sha, pdst=tip, hwdst=tha)
+)
+
+sendp(pkt, iface=iface, verbose=False)
diff --git a/tools/testing/selftests/net/ndisc_send.c b/tools/testing/selftests/net/ndisc_send.c
deleted file mode 100644
index 4f226221d079..000000000000
--- a/tools/testing/selftests/net/ndisc_send.c
+++ /dev/null
@@ -1,198 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <sys/socket.h>
-#include <inttypes.h>
-#include <netinet/ether.h>
-#include <arpa/inet.h>
-
-#include <linux/if_packet.h>
-#include <linux/if_ether.h>
-#include <linux/ipv6.h>
-#include <linux/icmpv6.h>
-
-#define ICMPV6_ND_NS 135
-#define ICMPV6_ND_NA 136
-#define ICMPV6_ND_SLLADR 1
-#define ICMPV6_ND_TLLADR 2
-
-#ifndef __noinline
-#define __noinline __attribute__((noinline))
-#endif
-#ifndef __packed
-#define __packed __attribute__((packed))
-#endif
-
-struct icmp6_pseudohdr {
-	struct in6_addr saddr;
-	struct in6_addr daddr;
-	uint32_t plen;
-	uint8_t zero[3];
-	uint8_t next;
-};
-
-struct ndisc_pkt {
-	struct ethhdr eth;
-	struct ipv6hdr ip6;
-	struct ndp_hdrs {
-		struct icmp6hdr hdr;
-		struct in6_addr target;
-
-		uint8_t opt_type;
-		uint8_t opt_len;
-		uint8_t opt_mac[ETH_ALEN];
-	} __packed ndp;
-} __packed;
-
-__noinline uint32_t csum_add(void *buf, int len, uint32_t sum)
-{
-	uint16_t *p = (uint16_t *)buf;
-
-	while (len > 1) {
-		sum += *p++;
-		len -= 2;
-	}
-
-	if (len)
-		sum += *(uint8_t *)p;
-
-	return sum;
-}
-
-static uint16_t csum_fold(uint32_t sum)
-{
-	return ~((sum & 0xffff) + (sum >> 16)) ? : 0xffff;
-}
-
-int parse_opts(int argc, char **argv, int *ifindex, struct ndisc_pkt *pkt)
-{
-	struct ether_addr *mac;
-	uint16_t op;
-	struct icmp6_pseudohdr ph = {0};
-	uint32_t sum = 0;
-
-	if (argc != 9) {
-		fprintf(stderr, "Usage: %s <iface> <mac_dst> <mac_src> <dst_ip> <src_ip> <target_ip> <op> <lladr>\n",
-			argv[0]);
-		return -1;
-	}
-
-	*ifindex = atoi(argv[1]);
-	mac = ether_aton(argv[2]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse mac_dst from '%s'\n", argv[1]);
-		return -1;
-	}
-
-	/* Ethernet */
-	memcpy(pkt->eth.h_dest, mac, ETH_ALEN);
-	mac = ether_aton(argv[3]);
-	if (!mac) {
-		fprintf(stderr, "Unable to parse mac_src from '%s'\n", argv[2]);
-		return -1;
-	}
-	memcpy(pkt->eth.h_source, mac, ETH_ALEN);
-	pkt->eth.h_proto = htons(ETH_P_IPV6);
-
-	/* IPv6 */
-	pkt->ip6.version = 6;
-	pkt->ip6.nexthdr = IPPROTO_ICMPV6;
-	pkt->ip6.hop_limit = 255;
-
-	if (inet_pton(AF_INET6, argv[4], &pkt->ip6.daddr) != 1) {
-		fprintf(stderr, "Unable to parse src_ip from '%s'\n", argv[4]);
-		return -1;
-	}
-	if (inet_pton(AF_INET6, argv[5], &pkt->ip6.saddr) != 1) {
-		fprintf(stderr, "Unable to parse src_ip from '%s'\n", argv[5]);
-		return -1;
-	}
-
-	/* ICMPv6 */
-	op = atoi(argv[7]);
-	if (op != ICMPV6_ND_NS && op != ICMPV6_ND_NA) {
-		fprintf(stderr, "Invalid ICMPv6 op %d\n", op);
-		return -1;
-	}
-
-	pkt->ndp.hdr.icmp6_type = op;
-	pkt->ndp.hdr.icmp6_code = 0;
-
-	if (inet_pton(AF_INET6, argv[6], &pkt->ndp.target) != 1) {
-		fprintf(stderr, "Unable to parse target_ip from '%s'\n",
-			argv[6]);
-		return -1;
-	}
-
-	/* Target/Source Link-Layer Address */
-	if (op == ICMPV6_ND_NS) {
-		pkt->ndp.opt_type = ICMPV6_ND_SLLADR;
-	} else {
-		pkt->ndp.opt_type = ICMPV6_ND_TLLADR;
-		pkt->ndp.hdr.icmp6_override = 1;
-	}
-	pkt->ndp.opt_len = 1;
-
-	mac = ether_aton(argv[8]);
-	if (!mac) {
-		fprintf(stderr, "Invalid lladdr %s\n", argv[8]);
-		return -1;
-	}
-
-	memcpy(pkt->ndp.opt_mac, mac, ETH_ALEN);
-
-	pkt->ip6.payload_len = htons(sizeof(pkt->ndp));
-
-	/* Pseudoheader */
-	ph.saddr = pkt->ip6.saddr;
-	ph.daddr = pkt->ip6.daddr;
-	ph.plen = htonl(sizeof(pkt->ndp));
-	ph.next = IPPROTO_ICMPV6;
-
-	sum = csum_add(&ph, sizeof(ph), 0);
-	sum = csum_add(&pkt->ndp, sizeof(pkt->ndp), sum);
-
-	pkt->ndp.hdr.icmp6_cksum = csum_fold(sum);
-
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int rc, fd;
-	struct sockaddr_ll bind_addr = {0};
-	int ifindex;
-	struct ndisc_pkt pkt = {0};
-
-	if (parse_opts(argc, argv, &ifindex, &pkt) < 0)
-		return -1;
-
-	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-	if (fd < 0) {
-		fprintf(stderr, "Unable to open raw socket(%d). Need root privileges?\n",
-			fd);
-		return 1;
-	}
-
-	bind_addr.sll_family   = AF_PACKET;
-	bind_addr.sll_protocol = htons(ETH_P_ALL);
-	bind_addr.sll_ifindex  = ifindex;
-
-	rc = bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
-	if (rc < 0) {
-		fprintf(stderr, "Unable to bind raw socket(%d). Invalid iface '%d'?\n",
-			rc, ifindex);
-		return 1;
-	}
-
-	rc = send(fd, &pkt, sizeof(pkt), 0);
-	if (rc < 0) {
-		fprintf(stderr, "Unable to send packet: %d\n", rc);
-		return 1;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/net/ndisc_send.py b/tools/testing/selftests/net/ndisc_send.py
new file mode 100644
index 000000000000..7b1a1c057862
--- /dev/null
+++ b/tools/testing/selftests/net/ndisc_send.py
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from scapy.all import *
+
+if len(sys.argv) != 9:
+    print(f"Usage: {sys.argv[0]} <iface> <mac_dst> <mac_src> <ip_dst> <ip_src> <target_ip> <op> <lladr>")
+
+iface = sys.argv[1]
+mac_dst = sys.argv[2]
+mac_src = sys.argv[3]
+ip_dst = sys.argv[4]
+ip_src = sys.argv[5]
+tip = sys.argv[6]
+op = int(sys.argv[7])
+lladdr = sys.argv[8]
+
+NDP_NA=136
+
+if op == NDP_NA:
+    pkt = (
+        Ether(dst=mac_dst, src=mac_src) /
+        IPv6(src=ip_src, dst=ip_dst, hlim=255) /
+        ICMPv6ND_NA(R=0, S=0, O=1, tgt=tip) /
+        ICMPv6NDOptDstLLAddr(lladdr=lladdr)
+    )
+else:
+    pkt = (
+        Ether(dst=mac_dst, src=mac_src) /
+        IPv6(src=ip_src, dst=ip_dst, hlim=255) /
+        ICMPv6ND_NS(tgt=tip) /
+        ICMPv6NDOptSrcLLAddr(lladdr=lladdr)
+    )
+
+sendp(pkt, iface=iface, verbose=False)
-- 
2.47.3


