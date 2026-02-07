Return-Path: <netdev+bounces-257775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOXoBOOjh2lSbAQAu9opvQ
	(envelope-from <netdev+bounces-257775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:43:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B510719D
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C194302FAB8
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75A33C1BF;
	Sat,  7 Feb 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub7U6PAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C320352FA9
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496936; cv=none; b=XAuYuKjobIDlg7BpLJdahgRwdjdKyWvGz9Z+Ysu/kyQHR3EY1/7iRn2l8hMVm/F4eQKJhGeV14WrZRDEsYe8VQyZ7ftevPhy4RaW+BV+4aBTvZtBDf3JOF9HLj8UaYiPaUAUoL92YRUp/9s6D+8zYiwfaAV5VTTpnvjlIrnTIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496936; c=relaxed/simple;
	bh=N8LT+sTP1dnYkoev+J9OnhatcqPm8jP0ymCATs0beA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUskt66/yFOtONAxPf0r2cA3f90Dd7S7CbTTDTMV5JgPtrSbAD7cdGDUiIq+xCbOpwvOY3thUTafW7UCTqzXrXTjYgWl7xHx8I0HSMkJXPatTMMBRAyud63gufwl/zs/bUlzjbP/9+xxd12uKy2uwjptC9NsIuP4VCNleSdA2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub7U6PAp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so30209425e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770496935; x=1771101735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egejKGknhJS2WelsYZ+/6vTtUpWqBY7Fi1aZWxpuXX0=;
        b=Ub7U6PAp1PRezFuM3g66otYMtnkijqnemCWeWg8NqYPjlnAtE+YhTvRz1ALO3MhQQy
         hTIfPa6On08w4UamVNvhnj8X3/jmG3ZlhNxKRUykrIELNdKV+V8jT/cGoQ2Svvjp+PhW
         hqQMnJjTnU6l++tgWi1mivhrHjbIdTaY9sj4ysUK7MG0mmqb6oEGnhC3umbVSrQUypzh
         hOKoKcK3gdewpARFPFpNKSLeJXfD/c+tUpI3HTrxsWYIaIbAT9zyZNhIuZtP703IJpwV
         abaAMhmPxygacSPVz1HuRLzoaT9u6tAhoFi76Bhs722M2OCA1GbRt1EHg4Hj/W4pOcgj
         5FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770496935; x=1771101735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=egejKGknhJS2WelsYZ+/6vTtUpWqBY7Fi1aZWxpuXX0=;
        b=TzAKcANF+L3jlHPusgAgVyDnj4ArEqNza05lrIyOhrwVcFH/O0/btTRGWHH7YRlWIB
         HVdZOCtK8S+GbDzpjEySC0sZtsASuWi5uT2EYMgTmwDLRh2LkAAk+r1LOZ1BDbRU+Zw5
         siQnvyEOdEjA2rotFz1PihZsQDiu2eR3yrO3pAXElGCcyJsxMI51C1cwKoc4TLIHYkU/
         N/v5r7/Tx8dB8bZUyqHxIH6QNY/XxogF2MV7Y1u2QmWlYwmFm4GeZq6sQUJnjxxw3koB
         P1ISTci8nlCqNLnM/0YCYMymz7WFWfqRTQuHkU4Iq7DO8f/+vUAO3VUR3uAmKCwMj6Km
         3Lkw==
X-Gm-Message-State: AOJu0Yz+s4SYY3rlgndw0IIcME8dUBQHAzg+VREi701MSXtbHAoPUgi2
	Xe9dnzllNKwTI3K1U2Gl66dTwdAyKTEnvGAOjoc5fB1XWOnbcfLQlpIc
X-Gm-Gg: AZuq6aL0xfkOWBBQViVwCsGqiPHXXXNDmrm0ZVhVlbPJwEEYebS19/vTXrvclaTQbE3
	50RuzU07iADySIDIrvnsnOHA56aeJog6XGHgWPbGFXs0/U+dT/wmJOLIggmPbg7ikyZFWwKmPPG
	ccV2CpfQjmgib0rjsrzVjAyqQjGEGyvEKYIV9dEvdGGZ09qACqz7vNdFaKLJdVGgO+KiYzOCJ3B
	RmdyFoftF/X/484BHW3Cr04dUpDXkANtC4fS+t/z8hse6AjoTwTkg4V+VWo+wFTJW1/YizzGTKu
	T7UpjTCQT6AaPVJbGeuc+KklUK6ROGl6yHKrZ84ULouuCsTxz7UBTpP2ebVhBgilbN52AlQU0Rw
	ba8MO4fAw07cCXUkj8h6e73e3To/F3AbBPlo7B7izuffUU7qU6TbbhAGh+rjSLWjCQwZN9mBH41
	2JXtb/fwol0TqjfxIiLx8jlhouWyVOPetMels1JqcHjU4JMYfNo5A6AnTT70JS1HQqxWaFiJ7Zh
	5wSOkESAemJSQNyHOpaEVlJXJxB/bKHJtnzMWiglqYYNM9ZiPCBITjGzVo0
X-Received: by 2002:a05:600c:468d:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4832023126bmr110100135e9.17.1770496934583;
        Sat, 07 Feb 2026 12:42:14 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm324540145e9.10.2026.02.07.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 12:42:13 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v4 2/4] selftests/net: add no ARP b/mcast,null poison test
Date: Sat,  7 Feb 2026 21:40:34 +0100
Message-ID: <19761bd8088ea7bab2b8c37461aa77be08082fc4.1770399836.git.marcdevel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257775-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 675B510719D
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
index afdea6d95bde..c6d571bf72be 100644
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


