Return-Path: <netdev+bounces-256836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H1EOYDEg2ncuAMAu9opvQ
	(envelope-from <netdev+bounces-256836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6DECF1F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D78302615E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55048361DB0;
	Wed,  4 Feb 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz3+W2SF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5B37F74B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243143; cv=none; b=jV/rTa8gHix6w3wbaN8Zjtt0fRoviM57hSRLgyabpHH58ohCn+2bCfS+8jTfjto03mN8IA8D0+ffg7p9MQbwsgQWuClVjR88DJ4lWEnqAZJtmZvfsrIIunQDm8sHp/2epu21mqpix4OIhQis2l4NyRg+wTh1X7s/6eo5nEl8Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243143; c=relaxed/simple;
	bh=VC9YZ9V/0k37gO/k/L0uj6o6Gk2MXcrL6QCPvvQME88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtooFbC8fgAyys39xmgL+peTC+1ee/pF+Sp05xqMIPNuvlRuYk/onDnA1e/zeCUwEx1rF7wZdsrIaw7CaFqznzmIK3gtXfn8ATnej0+wEq8zgGh71dkAQsJpy9D20MmPKBw4vJ69PycRUinFIaUYxL6P7+mGY6iZ8R1qdrG4a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz3+W2SF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359108fd24so226449f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770243141; x=1770847941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Eu6WVhygb2RScuEMU0NX7hkO0+maLSDuh1/2gj4u8=;
        b=gz3+W2SFgPW5GA05+3BsXt8lobbx1ZGP07xoIDgyNoeEdmIATl8Jo+OYtwdyA4Gs74
         72f3psm7/BGgNPcxNg0u5mlyL1lHZRwEB3dMcd3V+yqBTVy0AUJ1GkWevmMFN7uZAEn7
         1IMpNEvKal2Cb6tBml92s49Tut6ZGRSEumgMuaWw8D9y1CF8MOZ05eCCxWQi5l6F2JE2
         Gp3MkialslYF2O2EfKj899nZgZSxOoXOQ0fb59LmBUiLBcIq7fq+bqBu/HLnSU2/CGBe
         y18o1qVm+TKiw0rNXuDVvwZ/9pd0dlheXO1ZIWkl79Bj5qM6T2kyMwt8TqNQucNDIbk7
         Fm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770243141; x=1770847941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4Eu6WVhygb2RScuEMU0NX7hkO0+maLSDuh1/2gj4u8=;
        b=bjgiwu5vIWgGf9XGAFQkJ8iSnYuzhw8fGAnSKGNRChksjqsE3mIthKG4s5jzoKfe1y
         xGLr1EfWUXUMaEJMjVreyp+nWnsUK5os2FTVMLSHaJXPaFUTJFVOHw/Pxn5YbXHsJ6VL
         fxjkhujzMKaGTb5jSWDwm4IIXL0ik7/KGPVd1y3jPh/iwLgCcmH2gpRBpLRFFTzKsxod
         fAjj/DscPW2JUwunxHZhCNn14binhf2XEYBoktABNOcN1GALhTENallVSVNJ4ae8GOTT
         FRbippEFv4oM0OlDzxqG4U+IORHlk32149ijTjN3oPEqooexD7jZgC5iFg1ahI9CrFNR
         QLQA==
X-Gm-Message-State: AOJu0Yw85xZt9xYZuGHv6amg/9En3nQcQIJSmm9CivRQ2BSelSAO3CyD
	wJmcgm1ZkbEPBL/neXTn+wsDW7FDbYN8DKWjgvaQDchWxZNpOEixLqYJ
X-Gm-Gg: AZuq6aIGOadP0ZtLzroyAf8OxlZCHj6Azu0ss3y6eAL1/d0E+31dscur0TzZRxTxigO
	9Gntk41cbdAuhmZTxshtShODADfJkwggShHKi4v7PDVWYs8lQfK4uix++RRdSPq27BSibwmUQND
	CLQanH/4VlPigU7FthmgZzunbFPJmHt1gJ5nSDqZFlI0tHdtFgbjkG/WGL/f9mt8rsXYsbibAES
	6On6JbCIc2MG+s5MMF5uTlk4OSDoh4s5XUkgQtSuXPpsCeiF1Ogi7cZHsHR7SYMMQywcn5qDWr6
	/n9m+42DnFNvzXCnYbphqYevqQ8Bi2VYB9Hsb4OfpMtQReHF/GGzUXG943gipbmNLA/Y08i2973
	HwBzy3FJba7NKNSKyWq+RJvOIkEwlivLHNQwnR9MaVlewOUhhriEtoUpClDXLTrQ1zj1F50R0S/
	ycxnB4KNwam+fFOy2w5QpL63rH0Cdz+ToZDsWqHGps0+GjQMP2ARcROk4gaZqMuz07+gmTFc2+A
	rYMbdUro5tjqc89SgRpp30RYAMNBxGVdQfqwqDqqbTZ9gV8griSKWaQWsmR8oUBF/H+5mQ=
X-Received: by 2002:a05:6000:2287:b0:435:9ce0:f93c with SMTP id ffacd0b85a97d-43618061540mr7047429f8f.62.1770243141068;
        Wed, 04 Feb 2026 14:12:21 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm8327099f8f.5.2026.02.04.14.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:12:20 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v3 2/4] selftests/net: add no ARP b/mcast,null poison test
Date: Wed,  4 Feb 2026 23:11:59 +0100
Message-ID: <f19d6b009da1f198a2afa51a271afcb535c5cf8b.1770241104.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770241104.git.marcdevel@gmail.com>
References: <cover.1770241104.git.marcdevel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-256836-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arp_no_invalid_sha_poision.sh:url]
X-Rspamd-Queue-Id: 46C6DECF1F
X-Rspamd-Action: no action

Add a selftest to test that ARP bcast/mcast/null poisioning checks
are never bypassed.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/arp_no_invalid_sha_poision.sh         | 173 ++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_no_invalid_sha_poision.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 45c4ea381bc3..64bfbb29a427 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS := \
 	amt.sh \
 	arp_ndisc_evict_nocarrier.sh \
 	arp_ndisc_untracked_subnets.sh \
+	arp_no_invalid_sha_poision.sh \
 	bareudp.sh \
 	big_tcp.sh \
 	bind_bhash.sh \
diff --git a/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh b/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
new file mode 100755
index 000000000000..755dd31212c8
--- /dev/null
+++ b/tools/testing/selftests/net/arp_no_invalid_sha_poision.sh
@@ -0,0 +1,173 @@
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
+readonly ARP_REQ="request"
+readonly ARP_REPLY="reply"
+ret=0
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
+	ip netns exec "${PEER_NS}" ip addr add "${V4_ADDR1}"/24 dev veth1
+	ip netns exec "${PEER_NS}" ip route add default via "${V4_ADDR0}" dev veth1
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
-- 
2.47.3


