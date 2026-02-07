Return-Path: <netdev+bounces-257777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDtpLAekh2lSbAQAu9opvQ
	(envelope-from <netdev+bounces-257777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:43:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B11071A4
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8DF303DAF1
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79668340D98;
	Sat,  7 Feb 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geX/0Sex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B433DEF1
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496939; cv=none; b=c/2iwQmng9OcmviFizYk2dbpbtncrz+pty3xeK+yycebG1UHZJb7rP+5xbwoG3Mthnahl7DgOgx9OtRG3PvQtpW73rgQlhMD08UiMz/ILELxIuWYXL9hZLXXhYDGVwwVQvpadQQl4s/6/OXxBkQCoA/UmEEnC78dTE3CjP0UTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496939; c=relaxed/simple;
	bh=yM0LoVUIbtTPUDyxBm9/qYPNrhwDkTIxcRhS90JI8Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSmy7+uuEgJ72I7hepAG+RTXrm8zdXI03ItGqY/CEX/KBnIxliU6ZDPfi+xxME9wGTx0xmTz313Ovol7LfkYJ4obW8nBfy8N4KeFMbtzIKmIpddMrF1+hb/kxqZpvQxf95AdfFSjArTFkdHiiRPlZu4csK+c6daYTbZSG0dEwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geX/0Sex; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so42851045e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770496937; x=1771101737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uQylL01+UA/IGo3nlqogMySDEw+nKormjjLEwW2sD8=;
        b=geX/0Sex3wyaJ4wjB8lrnMoL02+I9Bmm3QDW8sKKUFoatZ8V5BqclbpCOdltE4L99n
         kSZUPDLrBLBxjxzE6pRnNFKdIVxzyzfson/b+vSXdYilOoU0JTqbbPFoIgCxOTZTkH57
         ioDUS8LlbSyPBrScRw8P0yl0N2Tb92JU9xjR9znCzYZxWElqgIqr3Fy0NhlKxJEuHI2U
         qBZY+ZgyZ/sRjtaskMNQ7LLYCrtbmfy9gKFZ7N/W5ZX5cWBqIC3bIcmpWFSGXcC8nnns
         lhqdHHGCKRMAIQS1EhHkmANb94kYhTaVyyoDLw2Z9k+ErZ04r9BT99Z15/tWSsG+8SQQ
         WSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770496937; x=1771101737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uQylL01+UA/IGo3nlqogMySDEw+nKormjjLEwW2sD8=;
        b=u58OOU+OlCDqjWdDZenFBq24PQeEiaI5zR87PEyAlbMs2ENOZgu/8FT4UkeVfN7e1+
         HIbwIrMcipHqYGDRROkYVsF4uH5vEKGDln+AuK9+rDY8B6Su/r6fIGmfrwmbqAcStfoI
         +PqKnrqc9Oc4Ni936qva5v4Jr+7jSqa5PfiPvmCDvSO1zegRNB6J6E9ZEiCPm6wC9sRa
         tHcS4upOY3pqhWuRD+ESvjiGgf4xaHyqsLfSJGmUecvkdv4H6CV4RwL8kAx5+soPQbBV
         hNSv79uJzsrw5Gs1vaHZiBFY6dmCDkG28CnrbA4fuwY9fEC2gcoJLqOexIlu8+7Lg54w
         +7XQ==
X-Gm-Message-State: AOJu0YyRIyptQeGxf422QN9dV7b7rUr6Cnb7cgvNVHtu3UOneh6FE2qi
	I0+zWnds9YjBlEWH5aRipZeezcKfbZsR8EXZweN5684NQof/hU16oC/t
X-Gm-Gg: AZuq6aJGXZEt0U3nnaOFKjw5/vHE1Sjs8L8/ZjR37npGRbjWicX3nmCrUNi7/zDtRZj
	v0OqAX14tupT00eNLz/fT+YCuhG/IL6K3sxxIIYxK2oQ16mK/p9c7DoJOZiHC2IzuKiXkRjhfa3
	ShlJPjn697DmN7v3a6uaV8tS8QY3IWzHxfivH3hS3m4ohEsNvTiLnAbEjInn5bPYlvg90ya331T
	kID54zC7RPqmAwDjiFrlEIQrXoHl/CV8AOCVosK1vPIKp2TV/d05Wtw0TO0h6P8jaLqZ7yfMM8j
	vZHDiD/bxfKQmGLzgX9cusHeUfhpN8r0bveqhkmU/YrqoBUdyV1yZ1b5Wz37O+umuVQY9YrY2bI
	TSrLz/lHXXuih7V+XIMjS6WBh6wFdvtKe2KqiWFMxr0HwEdFaCM82opqn3mo3OUXs1en4Bks0oo
	cg9qlln5mYDZMdB6C2s7WtRoImgj5fM1ovHDE8tKfcUkLCTYhOQUn55nFs0xtDVvUlLaXAA7de3
	1IRhYgnW1ID+0OjtucyIF5w/xvd+fksKa4LUWi0pYcJtob5ZaOuvK9hIZcl0cpg+8HK+kQ=
X-Received: by 2002:a05:600c:c11c:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4832c98458bmr37298775e9.18.1770496937161;
        Sat, 07 Feb 2026 12:42:17 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm324540145e9.10.2026.02.07.12.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 12:42:16 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v4 4/4] selftests/net: add no NDP b/mcast,null poison test
Date: Sat,  7 Feb 2026 21:40:36 +0100
Message-ID: <67615bd24a429899f500a248bb2a0bd261d71c84.1770399836.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770399836.git.marcdevel@gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.87 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-257777-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arp_ndisc_no_invalid_sha_poison.sh:url,lib.sh:url]
X-Rspamd-Queue-Id: 0F2B11071A4
X-Rspamd-Action: no action

Add a selftest to test that NDP bcast/mcast/null poisioning checks are
never bypassed.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 .../net/arp_ndisc_no_invalid_sha_poison.sh    | 368 ++++++++++++++++++
 .../net/arp_no_invalid_sha_poision.sh         | 173 --------
 tools/testing/selftests/net/ndisc_send.c      | 198 ++++++++++
 5 files changed, 569 insertions(+), 173 deletions(-)
 create mode 100755 tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh
 delete mode 100755 tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
 create mode 100644 tools/testing/selftests/net/ndisc_send.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 97ad4d551d44..3e703b31a8e1 100644
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
index c6d571bf72be..a8661191a78b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	altnames.sh \
 	amt.sh \
 	arp_ndisc_evict_nocarrier.sh \
+	arp_ndisc_no_invalid_sha_poison.sh \
 	arp_ndisc_untracked_subnets.sh \
 	arp_no_invalid_sha_poision.sh \
 	bareudp.sh \
@@ -171,6 +172,7 @@ TEST_GEN_PROGS := \
 	epoll_busy_poll \
 	icmp_rfc4884 \
 	ipv6_fragmentation \
+	ndisc_send \
 	proc_net_pktgen \
 	reuseaddr_conflict \
 	reuseport_bpf \
diff --git a/tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh b/tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh
new file mode 100755
index 000000000000..ad91eac18c89
--- /dev/null
+++ b/tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh
@@ -0,0 +1,368 @@
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
+readonly MCAST_MAC="01:00:5e:00:00:00"
+readonly NULL_MAC="00:00:00:00:00:00"
+readonly VALID_MAC="02:01:02:03:04:05"
+readonly V6_ALL_NODE_MAC="33:33:FF:00:00:01"
+readonly V6_SOL_NODE_MAC1="33:33:FF:00:00:02"
+readonly NS=135
+readonly NA=136
+readonly ARP_REQ=request
+readonly ARP_REPLY=reply
+ret=0
+veth0_ifindex=0
+veth1_mac=
+
+setup() {
+	setup_ns PEER_NS
+
+	ip link add name veth0 type veth peer name veth1
+	ip link set dev veth0 up
+	ip link set dev veth1 netns "${PEER_NS}"
+	ip netns exec "${PEER_NS}" ip link set dev veth1 up
+	ip addr add "${V4_ADDR0}"/24 dev veth0
+	ip addr add "${V6_ADDR0}"/64 dev veth0
+	ip netns exec "${PEER_NS}" ip addr add "${V4_ADDR1}"/24 dev veth1
+	ip netns exec "${PEER_NS}" ip route add default via "${V4_ADDR0}" dev veth1
+
+	ip netns exec "${PEER_NS}" ip addr add "${V6_ADDR1}"/64 dev veth1
+	ip netns exec "${PEER_NS}" ip route add default via "${V6_ADDR0}" dev veth1
+
+	# Raise ARP timers to avoid flakes due to refreshes
+	sysctl -w net.ipv4.neigh.veth0.base_reachable_time=3600 \
+		>/dev/null 2>&1
+	ip netns exec "${PEER_NS}" \
+		sysctl -w net.ipv4.neigh.veth1.gc_stale_time=3600 \
+		>/dev/null 2>&1
+	ip netns exec "${PEER_NS}" \
+		sysctl -w net.ipv4.neigh.veth1.base_reachable_time=3600 \
+		>/dev/null 2>&1
+
+	veth0_ifindex=$(ip -j link show veth0 | jq -r '.[0].ifindex')
+	veth1_mac="$(ip netns exec "${PEER_NS}" ip -j link show veth1 | \
+		jq -r '.[0].address' )"
+}
+
+cleanup() {
+	ip neigh flush dev veth0
+	ip link del veth0
+	cleanup_ns "${PEER_NS}"
+}
+
+# Make sure ARP announcement with invalid MAC is never learnt
+run_no_arp_poisoning() {
+	local l2_dmac="${1}"
+	local tmac="${2}"
+	local op="${3}"
+
+	ret=0
+
+	ip netns exec "${PEER_NS}" ip neigh flush dev veth1 >/dev/null 2>&1
+	ip netns exec "${PEER_NS}" ping -c 1 "${V4_ADDR0}" >/dev/null 2>&1
+
+	# Poison with a valid MAC to ensure injection is working
+	mausezahn "veth0" -q -a "${VALID_MAC}" -b "${BCAST_MAC}" -t arp \
+		  "${op}, sip=${V4_ADDR0}, tip=${V4_ADDR0}, smac=${VALID_MAC}, tmac=${VALID_MAC}"
+
+	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}" | \
+		grep "${VALID_MAC}")
+	if [ "${neigh}" == "" ]; then
+		echo "ERROR: unable to ARP poision with a valid MAC ${VALID_MAC}"
+		ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}"
+		ret=1
+		return
+	fi
+
+	# Poison with tmac
+	mausezahn "veth0" -q -a "${VALID_MAC}" -b "${l2_dmac}" -t arp \
+		  "${op}, sip=${V4_ADDR0}, tip=${V4_ADDR0}, smac=${tmac}, tmac=${tmac}"
+
+
+	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}" | \
+		grep "${tmac}")
+	if [ "${neigh}" != "" ]; then
+		echo "ERROR: ARP entry learnt for ${tmac} announcement."
+		ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}"
+		ret=1
+		return
+	fi
+}
+
+# Make sure NDP announcement with invalid MAC is never learnt
+run_no_ndp_poisoning() {
+	local l2_dmac="${1}"
+	local dst_ip="${2}"
+	local op="${3}"
+	local tip="${V6_ADDR0}"
+	local tmac="${4}"
+
+	if [ "${op}" == "${NS}" ]; then
+		tip="${V6_ADDR1}"
+	fi
+
+	ret=0
+
+	ip netns exec "${PEER_NS}" ip -6 neigh flush dev veth1 >/dev/null 2>&1
+	ip netns exec "${PEER_NS}" ping -c 1 "${V6_ADDR0}" >/dev/null 2>&1
+
+	# Poison with a valid MAC to ensure injection is working
+	./ndisc_send "${veth0_ifindex}" "${l2_dmac}" "${VALID_MAC}" "${dst_ip}" \
+		"${V6_ADDR0}" "${tip}" "${op}" "${VALID_MAC}"
+	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V6_ADDR0}" | \
+		grep "${VALID_MAC}")
+	if [ "${neigh}" == "" ]; then
+		echo "ERROR: unable to NDP poision with a valid MAC ${VALID_MAC}"
+		ip netns exec "${PEER_NS}" ip neigh show "${V6_ADDR0}"
+		ret=1
+		return
+	fi
+
+	# Poison with tmac
+	./ndisc_send "${veth0_ifindex}" "${l2_dmac}" "${VALID_MAC}" "${dst_ip}" \
+		"${V6_ADDR0}" "${tip}" "${op}" "${tmac}"
+	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V6_ADDR0}" | \
+		grep "${tmac}")
+	if [ "${neigh}" != "" ]; then
+		echo "ERROR: NDP entry learnt for ${tmac} announcement."
+		ip netns exec "${PEER_NS}" ip neigh show "${V6_ADDR0}"
+		ret=1
+		return
+	fi
+}
+
+print_test_result() {
+	local msg="${1}"
+	local rc="${2}"
+
+	if [ "${rc}" == 0 ]; then
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
+	run_no_arp_poisoning "${BCAST_MAC}" "${BCAST_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.2  ARP no poisoning dmac=bcast reply sha=null"
+	run_no_arp_poisoning "${BCAST_MAC}" "${NULL_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.3  ARP no poisoning dmac=bcast req   sha=bcast"
+	run_no_arp_poisoning "${BCAST_MAC}" "${BCAST_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.4  ARP no poisoning dmac=bcast req   sha=null"
+	run_no_arp_poisoning "${BCAST_MAC}" "${NULL_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.5  ARP no poisoning dmac=bcast req   sha=mcast"
+	run_no_arp_poisoning "${BCAST_MAC}" "${MCAST_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.6  ARP no poisoning dmac=bcast reply sha=mcast"
+	run_no_arp_poisoning "${BCAST_MAC}" "${MCAST_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Targeted gARPs
+	msg="1.7  ARP no poisoning dmac=veth0 reply sha=bcast"
+	run_no_arp_poisoning "${veth1_mac}" "${BCAST_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.8  ARP no poisoning dmac=veth0 reply sha=null"
+	run_no_arp_poisoning "${veth1_mac}" "${NULL_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.9  ARP no poisoning dmac=veth0 req   sha=bcast"
+	run_no_arp_poisoning "${veth1_mac}" "${BCAST_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.10 ARP no poisoning dmac=veth0 req   sha=null"
+	run_no_arp_poisoning "${veth1_mac}" "${NULL_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.11 ARP no poisoning dmac=veth0 req   sha=mcast"
+	run_no_arp_poisoning "${veth1_mac}" "${MCAST_MAC}" "${ARP_REQ}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="1.12 ARP no poisoning dmac=veth0 reply sha=mcast"
+	run_no_arp_poisoning "${veth1_mac}" "${MCAST_MAC}" "${ARP_REPLY}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	### NDP
+	## NA
+	# Broadcast / All node MAC, all-node IP announcements
+	msg="2.1  NDP no poisoning dmac=bcast   all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ALL_NODES}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.2  NDP no poisoning dmac=bcast   all_nodes na lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ALL_NODES}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.3  NDP no poisoning dmac=allnode all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ALL_NODES}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.4  NDP no poisoning dmac=allnode all_nodes na lladdr=null"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ALL_NODES}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.5  NDP no poisoning dmac=bcast   all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ALL_NODES}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.6  NDP no poisoning dmac=bcast   all_nodes na lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ALL_NODES}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.7  NDP no poisoning dmac=allnode all_nodes na lladdr=bcast"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ALL_NODES}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.8  NDP no poisoning dmac=allnode all_nodes na lladdr=null"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ALL_NODES}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Broadcast / All node MAC, Targeted IP announce
+	msg="2.9  NDP no poisoning dmac=bcast   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.10 NDP no poisoning dmac=bcast   targeted  na lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.11 NDP no poisoning dmac=allnode targeted  na lladdr=bcast"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ADDR1}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.12 NDP no poisoning dmac=allnode targeted  na lladdr=null"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ADDR1}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.13 NDP no poisoning dmac=bcast   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.14 NDP no poisoning dmac=bcast   targeted  na lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.15 NDP no poisoning dmac=allnode targeted  na lladdr=bcast"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ADDR1}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.16 NDP no poisoning dmac=allnode targeted  na lladdr=null"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ADDR1}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Targeted MAC, Targeted IP announce
+	msg="2.17 NDP no poisoning dmac=veth1   targeted  na lladdr=bcast"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NA}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.18 NDP no poisoning dmac=veth1   targeted  na lladdr=null"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NA}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Poison with MCAST mac
+	msg="2.19 NDP no poisoning dmac=allnode all_nodes na lladdr=mcast"
+	run_no_ndp_poisoning "${V6_ALL_NODE_MAC}" "${V6_ALL_NODES}" "${NA}" "${MCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+	msg="2.20 NDP no poisoning dmac=veth1   targeted  na lladdr=mcast"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NA}" "${MCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	## NS
+	# Broadcast / SolNode node MAC, SolNode IP solic
+	msg="2.21 NDP no poisoning dmac=bcast   solnode   ns lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_SOL_NODE1}" "${NS}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.22 NDP no poisoning dmac=bcast   solnode   ns lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_SOL_NODE1}" "${NS}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.23 NDP no poisoning dmac=solnode solnode   ns lladdr=bcast"
+	run_no_ndp_poisoning "${V6_SOL_NODE_MAC1}" "${V6_SOL_NODE1}" "${NS}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.24 NDP no poisoning dmac=solnode solnode   ns lladdr=null"
+	run_no_ndp_poisoning "${V6_SOL_NODE_MAC1}" "${V6_SOL_NODE1}" "${NS}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Broadcast / SolNode node MAC, target IP solic
+	msg="2.25 NDP no poisoning dmac=bcast   target    ns lladdr=bcast"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NS}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.26 NDP no poisoning dmac=bcast   target    ns lladdr=null"
+	run_no_ndp_poisoning "${BCAST_MAC}" "${V6_ADDR1}" "${NS}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.27 NDP no poisoning dmac=solnode target    ns lladdr=bcast"
+	run_no_ndp_poisoning "${V6_SOL_NODE_MAC1}" "${V6_ADDR1}" "${NS}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.28 NDP no poisoning dmac=solnode target    ns lladdr=null"
+	run_no_ndp_poisoning "${V6_SOL_NODE_MAC1}" "${V6_ADDR1}" "${NS}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Targeted MAC, Targeted IP solic
+	msg="2.29 NDP no poisoning dmac=veth1   target    ns lladdr=bcast"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NS}" "${BCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.30 NDP no poisoning dmac=veth1   target    ns lladdr=null"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NS}" "${NULL_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	# Poison with MCAST mac
+	msg="2.31 NDP no poisoning dmac=solnode solnode   ns lladdr=mcast"
+	run_no_ndp_poisoning "${V6_SOL_NODE_MAC1}" "${V6_SOL_NODE1}" "${NS}" "${MCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	msg="2.32 NDP no poisoning dmac=veth1   target    ns lladdr=mcast"
+	run_no_ndp_poisoning "${veth1_mac}" "${V6_ADDR1}" "${NS}" "${MCAST_MAC}"
+	results+="$(print_test_result "${msg}" "${ret}")\n"
+
+	cleanup
+
+	printf '%b' "${results}"
+}
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit "${ksft_skip}"
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit "${ksft_skip}"
+fi
+
+run_all_tests
+exit "${ret}"
diff --git a/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh b/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
deleted file mode 100755
index 755dd31212c8..000000000000
--- a/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
+++ /dev/null
@@ -1,173 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Tests that ARP announcements with Broadcast, Multicast or NULL mac are never
-# accepted
-#
-
-source lib.sh
-
-readonly V4_ADDR0="10.0.10.1"
-readonly V4_ADDR1="10.0.10.2"
-readonly BCAST_MAC="ff:ff:ff:ff:ff:ff"
-readonly MCAST_MAC="01:00:5e:00:00:00"
-readonly NULL_MAC="00:00:00:00:00:00"
-readonly VALID_MAC="02:01:02:03:04:05"
-readonly ARP_REQ="request"
-readonly ARP_REPLY="reply"
-ret=0
-veth1_mac=
-
-setup() {
-	setup_ns PEER_NS
-
-	ip link add name veth0 type veth peer name veth1
-	ip link set dev veth0 up
-	ip link set dev veth1 netns "${PEER_NS}"
-	ip netns exec "${PEER_NS}" ip link set dev veth1 up
-	ip addr add "${V4_ADDR0}"/24 dev veth0
-	ip netns exec "${PEER_NS}" ip addr add "${V4_ADDR1}"/24 dev veth1
-	ip netns exec "${PEER_NS}" ip route add default via "${V4_ADDR0}" dev veth1
-
-	# Raise ARP timers to avoid flakes due to refreshes
-	sysctl -w net.ipv4.neigh.veth0.base_reachable_time=3600 \
-		>/dev/null 2>&1
-	ip netns exec "${PEER_NS}" \
-		sysctl -w net.ipv4.neigh.veth1.gc_stale_time=3600 \
-		>/dev/null 2>&1
-	ip netns exec "${PEER_NS}" \
-		sysctl -w net.ipv4.neigh.veth1.base_reachable_time=3600 \
-		>/dev/null 2>&1
-
-	veth1_mac="$(ip netns exec "${PEER_NS}" ip -j link show veth1 | \
-		jq -r '.[0].address' )"
-}
-
-cleanup() {
-	ip neigh flush dev veth0
-	ip link del veth0
-	cleanup_ns "${PEER_NS}"
-}
-
-# Make sure ARP announcement with invalid MAC is never learnt
-run_no_arp_poisoning() {
-	local l2_dmac="${1}"
-	local tmac="${2}"
-	local op="${3}"
-
-	ret=0
-
-	ip netns exec "${PEER_NS}" ip neigh flush dev veth1 >/dev/null 2>&1
-	ip netns exec "${PEER_NS}" ping -c 1 "${V4_ADDR0}" >/dev/null 2>&1
-
-	# Poison with a valid MAC to ensure injection is working
-	mausezahn "veth0" -q -a "${VALID_MAC}" -b "${BCAST_MAC}" -t arp \
-		  "${op}, sip=${V4_ADDR0}, tip=${V4_ADDR0}, smac=${VALID_MAC}, tmac=${VALID_MAC}"
-
-	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}" | \
-		grep "${VALID_MAC}")
-	if [ "${neigh}" == "" ]; then
-		echo "ERROR: unable to ARP poision with a valid MAC ${VALID_MAC}"
-		ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}"
-		ret=1
-		return
-	fi
-
-	# Poison with tmac
-	mausezahn "veth0" -q -a "${VALID_MAC}" -b "${l2_dmac}" -t arp \
-		  "${op}, sip=${V4_ADDR0}, tip=${V4_ADDR0}, smac=${tmac}, tmac=${tmac}"
-
-	neigh=$(ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}" | \
-		grep "${tmac}")
-	if [ "${neigh}" != "" ]; then
-		echo "ERROR: ARP entry learnt for ${tmac} announcement."
-		ip netns exec "${PEER_NS}" ip neigh show "${V4_ADDR0}"
-		ret=1
-		return
-	fi
-}
-
-print_test_result() {
-	local msg="${1}"
-	local rc="${2}"
-
-	if [ "${rc}" == 0 ]; then
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
-	msg="1.1  ARP no poisoning dmac=bcast reply sha=bcast"
-	run_no_arp_poisoning "${BCAST_MAC}" "${BCAST_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.2  ARP no poisoning dmac=bcast reply sha=null"
-	run_no_arp_poisoning "${BCAST_MAC}" "${NULL_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.3  ARP no poisoning dmac=bcast req   sha=bcast"
-	run_no_arp_poisoning "${BCAST_MAC}" "${BCAST_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.4  ARP no poisoning dmac=bcast req   sha=null"
-	run_no_arp_poisoning "${BCAST_MAC}" "${NULL_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.5  ARP no poisoning dmac=bcast req   sha=mcast"
-	run_no_arp_poisoning "${BCAST_MAC}" "${MCAST_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.6  ARP no poisoning dmac=bcast reply sha=mcast"
-	run_no_arp_poisoning "${BCAST_MAC}" "${MCAST_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	# Targeted gARPs
-	msg="1.7  ARP no poisoning dmac=veth0 reply sha=bcast"
-	run_no_arp_poisoning "${veth1_mac}" "${BCAST_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.8  ARP no poisoning dmac=veth0 reply sha=null"
-	run_no_arp_poisoning "${veth1_mac}" "${NULL_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.9  ARP no poisoning dmac=veth0 req   sha=bcast"
-	run_no_arp_poisoning "${veth1_mac}" "${BCAST_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.10 ARP no poisoning dmac=veth0 req   sha=null"
-	run_no_arp_poisoning "${veth1_mac}" "${NULL_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.11 ARP no poisoning dmac=veth0 req   sha=mcast"
-	run_no_arp_poisoning "${veth1_mac}" "${MCAST_MAC}" "${ARP_REQ}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	msg="1.12 ARP no poisoning dmac=veth0 reply sha=mcast"
-	run_no_arp_poisoning "${veth1_mac}" "${MCAST_MAC}" "${ARP_REPLY}"
-	results+="$(print_test_result "${msg}" "${ret}")\n"
-
-	cleanup
-
-	printf '%b' "${results}"
-}
-
-if [ "$(id -u)" -ne 0 ];then
-	echo "SKIP: Need root privileges"
-	exit "${ksft_skip}"
-fi
-
-if [ ! -x "$(command -v ip)" ]; then
-	echo "SKIP: Could not run test without ip tool"
-	exit "${ksft_skip}"
-fi
-
-run_all_tests
-exit "${ret}"
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


