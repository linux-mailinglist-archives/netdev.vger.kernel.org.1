Return-Path: <netdev+bounces-253626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLk9LrD+d2lqnAEAu9opvQ
	(envelope-from <netdev+bounces-253626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC68E56E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE60C302BE9F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C53112B2;
	Mon, 26 Jan 2026 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auj9Sk16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F110E3112DB
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471636; cv=none; b=fD2RWIp+6RhyStEJwhYpKKnNMBbTAunba8qYEAMf9G5IUnfhWOaC6mfZk6QDzLIvtnrXCnMz6k724MNnAwSBgk8JkIQ2qHCfpYixIP3DQlZIYCEcgXx2QkkHBJFzoJlmkXJCc2mvKpY2mgQkdK04US2zNhwBCM4+Bzx8QtsjtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471636; c=relaxed/simple;
	bh=N73RpYJjXaCbhKREvaKpgQbw74DlIfwy6ZQ+c+Ovlps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAsZGJ4X8SrmlcYoC0o9g0IX/q1snm7Kg6Dligwc739AVXuI7WY1t5BXtKmSgpupa0av9Zo9P7hDALGbhNEojVf0euj1EUt5xOv/M6zh1y1kgr9yx+0rAtMizDtonqx5+d13LxpO1URD5ZaKCpJCM5Kvm4adXijGcsfivAHxvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Auj9Sk16; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so36491345e9.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769471633; x=1770076433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBJANW6Kw+fJ7lDbMyabafJluQKcc6q22ZfNcH2WiwA=;
        b=Auj9Sk160+2L2d6p6lJfZiJcxNOQSwxryPOmAX2VlwqoiC4MceDf/pQGBvm2xoEJVo
         bVtjYXYyibEjzH42YrZw5kyOPzm8odaLkwNlcyvl4sfR8fg3iXs9hJKOyjsenZhEEqVU
         aFdb9hTPPUpwGJUk/jqC1Zqq+qBO+Gg4p/QBxrQ2kxE9peoHFix5wI2cuDWl3veAiiIS
         wyabEHniHkBcQWD2KIoBAzt2S6HUr4k9ETpDlEkAyUHw47qGbMo7DHAYybyhBWp52fLz
         ObKbSaFoMAVrcnb7pnvWoxnochlQ0p8tS+h0eiVgwIMMKLuts/ULx1TD9u/a98Smcr6B
         bB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471633; x=1770076433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBJANW6Kw+fJ7lDbMyabafJluQKcc6q22ZfNcH2WiwA=;
        b=UIAmZu0r7P4FifV6JNXZ7fsce+i0CEagwcwWFltfIONEkJbW1rCs3J3JZYCWgAO+N7
         ZWOknfLWUG214oNLLaSdLALwIGOa5eD9os9rZSSogA0Z+E949PxR/6sR9UQsqvIMHBjH
         CK9rwEYEZAOHFzMrAskBs7BvUfO1jCHkAMBh784Lv6bJxZ+1lQoJDolM4QFG4G2IsOaM
         nS3IPNg0Ur1phtDjgemTDfQG2W5ph1wUjeMDMakF6FS4wKlOgGjn+lXYQmf+wQJ4ac1v
         AFVQIWJ67GN0mBtO3hWDVK4/VcQxGaODMFDQiGqpu3V35sXjtK+eOV8kxSGmLiw9SmwZ
         Svzg==
X-Gm-Message-State: AOJu0Yxbl5gOkiBo2Xtd5p/Nqv8C8jpxhV3ibMdcPvcRxGFDaUVE0wdg
	LCf7Em3B55lrwe35V4L+5cdutPei8GNBdnBj0LrRy+Hrcvg0B82NCZZp
X-Gm-Gg: AZuq6aI6FPGuYLDWwBp+RhgFhMCYI0jVW1mA9Rr7CEgYYCtCeCO/3oDLGevwOqC+Y/T
	BFZBhXrJqdwz3D+X+txISFNUqC+PZmWdfaE9641Q46R40c45JuC+Un/Z3t+XOfdV8+Rqw4ziNIk
	PQRU4OVZr4RjuFud1A5p4B1M6iX00rInVO5Qe1SSIOaR5HgPN818Xqc6vxLradrm14ibwDueoL0
	405pMugcW7+SUMNoXAv3npw4+VHJ3li7RohBE2HwNlqUEE3v1NbQweV33Mr+GNJtLXmq/9Ukzfk
	cCUVQbITJUy1Zf5bUKjlgsprMvpl9VRRK2UisLMAS+LXtREUBxkr+g/HZrCkx7hFprUowcb2PtU
	zfE+aiIC7UceSLA9GdJZ1DjWJgtF67a/YAjPZNhdGABhdxm3ohCam5AtdS4qpvGnL3mhHre9/rR
	kGIEe22yuEYdhwnFqGHnp5Tsi7JLcnRQiN1/MN/2pQA2WbZtpO4XpgEJsYGrYKKagxbYltwtjfl
	5kPtry+3waqgvUrPv6ze7Wj7eNQkOiKqtU3ctEMjPh190NgQE+0W2Y3WbUF
X-Received: by 2002:a05:600c:3155:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-4806111e3a5mr61734405e9.19.1769471633277;
        Mon, 26 Jan 2026 15:53:53 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be7404sm22658615e9.1.2026.01.26.15.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:53:52 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net v2 2/4] selftests/net: add no ARP b/mcast,null poison test
Date: Tue, 27 Jan 2026 00:53:03 +0100
Message-ID: <713d6f1ca57b402be420ade1331acee4898675c4.1769464405.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1769464405.git.marcdevel@gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-253626-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arp_no_invalid_sha_poision.sh:url,lib.sh:url]
X-Rspamd-Queue-Id: 36FC68E56E
X-Rspamd-Action: no action

Add a selftest to test that ARP bcast/mcast/null poisioning checks
are never bypassed.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 .../net/arp_no_invalid_sha_poision.sh         | 176 ++++++++++++++++++
 tools/testing/selftests/net/arp_send.c        | 138 ++++++++++++++
 4 files changed, 317 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
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
index 45c4ea381bc3..a765f1800752 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -9,6 +9,7 @@ CFLAGS += -I../
 TEST_PROGS := \
 	altnames.sh \
 	amt.sh \
+	arp_no_invalid_sha_poision.sh \
 	arp_ndisc_evict_nocarrier.sh \
 	arp_ndisc_untracked_subnets.sh \
 	bareudp.sh \
@@ -164,6 +165,7 @@ TEST_GEN_FILES := \
 # end of TEST_GEN_FILES
 
 TEST_GEN_PROGS := \
+	arp_send \
 	bind_timewait \
 	bind_wildcard \
 	epoll_busy_poll \
diff --git a/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh b/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
new file mode 100755
index 000000000000..1505f1bde487
--- /dev/null
+++ b/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
@@ -0,0 +1,176 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Tests that ARP announcements with Broadcast, Multicast or NULL mac are never
+# accepted
+#
+
+source lib.sh
+
+readonly V4_ADDR0="10.0.10.1"
+readonly V4_ADDR1="10.0.10.2"
+readonly BCAST_MAC="ff:ff:ff:ff:ff:ff"
+readonly MCAST_MAC="01:00:5e:00:00:00"
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
+	./arp_send ${veth0_ifindex} ${l2_dmac} ${VALID_MAC} ${op} \
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
+	msg="1.5  ARP no poisoning dmac=bcast req   sha=mcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${MCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.6  ARP no poisoning dmac=bcast reply sha=mcast"
+	run_no_arp_poisoning ${BCAST_MAC} ${MCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	# Targeted gARPs
+	msg="1.7  ARP no poisoning dmac=veth0 reply sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.8  ARP no poisoning dmac=veth0 reply sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REPLY}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.9  ARP no poisoning dmac=veth0 req   sha=bcast"
+	run_no_arp_poisoning ${veth1_mac} ${BCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.10 ARP no poisoning dmac=veth0 req   sha=null"
+	run_no_arp_poisoning ${veth1_mac} ${NULL_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.11 ARP no poisoning dmac=veth0 req   sha=mcast"
+	run_no_arp_poisoning ${veth1_mac} ${MCAST_MAC} ${ARP_REQ}
+	results+="$(print_test_result "${msg}" ${ret})\n"
+
+	msg="1.12 ARP no poisoning dmac=veth0 reply sha=mcast"
+	run_no_arp_poisoning ${veth1_mac} ${MCAST_MAC} ${ARP_REPLY}
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


