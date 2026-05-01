Return-Path: <netdev+bounces-283212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDJPJHbD9GnwEQIAu9opvQ
	(envelope-from <netdev+bounces-283212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF44AD83E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74573011C63
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAC3CE487;
	Fri,  1 May 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt6WlEDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562622E62B3
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648500; cv=none; b=T1gzykdGzD3qtllYOBq6az6lHZTc/8IMm5Tswx5m0Bao02wowlFjAvQa93XRApG126DeN0hpLsAL/gjSRICuRGBPpOT6IFtwTbNIhI0EIGeYUox8pVxYlKBxnfNBQ+OZZxotAx6Rd7Su5dbMSSgLC5EC8DRiVMJYaTNn1xu+Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648500; c=relaxed/simple;
	bh=pgx4+xvjUVhKRcRqf68AvT3/u27B062g7R/oe/OG8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oka13hCy8ydxu7jVQNVi7HISSEIiXtQJRFhWZ0nLz4njQ4w3c5U84m3u6URSy0QdCyZYFuDGHZZVTEuSGvH5W1K0Zhio8uBF6y4tdv2MsNigIIPH4fff0+K82Qc4CZ57v29oY29qwAp2YHUP1bNJnEDf3zWVmsmqMVGGlYf5Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt6WlEDN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso16688801fa.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777648497; x=1778253297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llmIKEf8xgxsjh1iuIkSY/YxURawHxS+HKKjGXhYgvc=;
        b=Wt6WlEDNRZda1JyKmws08m8NhB3etOwNbN7rYW32XJyBzawVtlGg7FkqWKemVKIWiC
         dMPDOoQDJ7vWYdcTN4w6QbljItPU2IdoFNjKkfbo2mR7zT0CMWAR9AYKf8WJ97N8p48v
         t4EP6MHvtwLA+kWiGMFIa+qGGuYBNqvTaO5E+o8Epb4bInXHi9P8EVgQwGyN79cM8US7
         Fp91+nsI2AJUiT0bGd7k3937cPEmorzZRaGjDMOZ/EPbdCNPvkEMiWkloBGhSAIrO6IO
         UdGtoMGtBJdp0QeV89dDQ3ILT55i2eAIc0AM+ebUlq7HZ3bFCdT7oO0BSltNFHbNDyCg
         Ogtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777648497; x=1778253297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llmIKEf8xgxsjh1iuIkSY/YxURawHxS+HKKjGXhYgvc=;
        b=WFwGh0SGCKhgHLDBOSfk2mohqttL+DUrYnRMPa621+4gEwWLLcMOr0G2t8dNzWUWR3
         Uj4ZqADEUXQgDJSYPysJQ9oeWrPnWkjAHEdOK7uDYYLmrJJxD7uuC5k4Kh70VBsbt8Q/
         CBvrc3vi7MiLnUZZZpYxyV/QXa4cRlMA1bcNYeTJbVJDYOQgFp9ShHcEo4qih7cqj0VR
         6Qp3ThNLxXxu24tbd2vQ5jCgBDrLplmJ/SI/owbZkiCicBjXgJ9JiOdWMkQd9XYMNvPW
         rarvFAKWJ42OzGKBEa/kedBbXw1xf1jeYnN3P/9KZLWejCOWGqgcUyf3UtS9D62D0EAq
         Ckpg==
X-Forwarded-Encrypted: i=1; AFNElJ+J2f5dgnkNwD5C047WLM2f7vaHQJK8v9jBPO57iibJLHj9Ap+spYLsESbgNG9HDJapNQq1n/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hY1PtdhbQSEIArD+7jRK6t+Ebeen0PHBa6zobuvT+8xn2ho2
	s7kFx4FrKuwhGZ1KmozrANzdPn51PHlBTB7EWSs/l9EkehlLlZk7NEVp
X-Gm-Gg: AeBDieuE/f0W+DxKr9MYMwek+yCnClOgyA8STvF5gslP8gkX4wz4QCmrK3KcThW91UL
	mot+fIjFr/Nc6xAmwV0ihIK6J5lqzwIjH0Bv4cBhRT2UakBdJTl2YkFVpSD93lqfm4I5Figj4I2
	q6KLR26q7Zsczbg5Y1uvKqFivH6wJT/QhY1v2lzTbUZwfO4ECVARf1NICiCPO6u/oz5oVAzA7Er
	pUCU0EXkT+FnQiOe7QZDkEhJr/piS0/BmgEuompWtfWfF0l2TM2vATWB+UCURM3qdlYE6b4DVo/
	H+tERwh8BOqzEmTj4NGCi38z+z7IJqx3TC3Ku5rnKYoZo+u1HOWodpWMsdX8JajYqKQVoy5GS+N
	r1DFC18RLKmKUWhVxQvXdPE5zKM658/5KgcfxCnfEd/CXv8DuRzK25I+rz28ky17hwKTkxqrZYE
	CI3PGpJoR8w23Gc/Dbu6BChEBvtj76BErO/lb7mzYzlqNnJfAUhxGToUpAyV01BR7ns0yV6Mg=
X-Received: by 2002:a2e:a54a:0:b0:38e:a883:62e9 with SMTP id 38308e7fff4ca-393643b72c6mr12372401fa.15.1777648496200;
        Fri, 01 May 2026 08:14:56 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3936109039csm7984831fa.8.2026.05.01.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:14:55 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] selftests: mptcp: add test for IPv6 subflow SLAB placement
Date: Fri,  1 May 2026 18:14:54 +0300
Message-ID: <20260501151454.211598-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05BF44AD83E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283212-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add mptcp_v6_initcall.sh to verify that MPTCP IPv6 subflow child
sockets are allocated from the TCPv6 SLAB cache, not the kmalloc-4k
fallback.

tcpv6_prot_override must copy tcpv6_prot after proto_register(&tcpv6_prot)
populates tcpv6_prot.slab. If the copy runs too early, override.slab
stays NULL (frozen by __ro_after_init) and subflow children fall back
to kmalloc-4k. This lacks SLAB_TYPESAFE_BY_RCU, allowing lockless
ehash lookups in __inet_lookup_established to read freed memory.

The test exercises the IPv6 accept path via MPTCP connections between
two network namespaces, then checks that the TCPv6 slab active object
count grew. On a fixed kernel, the delta is ~2 * NR_CONNS (one subflow
per side per connection); on a broken kernel, it stays near zero because
children land in kmalloc-4k instead.

Topology: two netns connected via veth pair with /64 ULA addresses;
NR_CONNS parallel short-lived MPTCP connections are established and held
open long enough to sample /proc/slabinfo. The test skips if
CONFIG_MPTCP_IPV6 is absent (checked via kallsyms) or /proc/slabinfo is
unreadable.

Verified on Ubuntu 6.17 kernel predating the fix: TAP "not ok 1 ...
TCPv6 slab gains MPTCPv6 subflow children" with delta=0. On kernels
with the fix, delta is well above the threshold of NR_CONNS/2.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_v6_initcall.sh  | 140 ++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..c9f329441490 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS := \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
+	mptcp_v6_initcall.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
 	userspace_pm.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh b/tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh
new file mode 100644
index 000000000000..c55fc74b5ffb
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_v6_initcall.sh
@@ -0,0 +1,140 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that MPTCP IPv6 subflow child sockets are allocated from the
+# TCPv6 slab cache.
+#
+# tcpv6_prot_override is initialised by copying tcpv6_prot, which is only
+# safe after proto_register(&tcpv6_prot) has populated tcpv6_prot.slab.
+# If the override copy runs too early during init, override.slab stays
+# NULL and __ro_after_init freezes that. Subflow child sockets then fall
+# back to kmalloc (kmalloc-4k for a TCPv6 sock), which lacks
+# SLAB_TYPESAFE_BY_RCU; lockless ehash lookups in __inet_lookup_established
+# can read freed memory.
+#
+# This test exercises the IPv6 accept path, which goes through the
+# override proto, and then asserts that the live TCPv6 slab population
+# grew. On a kernel where the override slab is NULL the delta is ~0,
+# because the children land in kmalloc-4k instead.
+
+#shellcheck disable=SC2086
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+ns1=""
+ns2=""
+ret=0
+
+NR_CONNS=20
+TIMEOUT_POLL=30
+TIMEOUT_TEST=$((TIMEOUT_POLL * 2 + 1))
+PORT_BASE=20000
+
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317,SC2329
+cleanup()
+{
+	for ns in "${ns1}" "${ns2}"; do
+		[ -n "${ns}" ] || continue
+		ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
+}
+
+mptcp_lib_check_mptcp
+mptcp_lib_check_tools ip ss
+
+if ! mptcp_lib_kallsyms_has "tcpv6_prot_override$"; then
+	mptcp_lib_pr_skip "CONFIG_MPTCP_IPV6 not available"
+	exit ${KSFT_SKIP}
+fi
+
+if ! [ -r /proc/slabinfo ]; then
+	mptcp_lib_pr_skip "/proc/slabinfo not readable"
+	exit ${KSFT_SKIP}
+fi
+
+if ! awk '/^TCPv6 / { found = 1 } END { exit !found }' /proc/slabinfo; then
+	mptcp_lib_pr_skip "TCPv6 slab cache not present"
+	exit ${KSFT_SKIP}
+fi
+
+trap cleanup EXIT
+mptcp_lib_ns_init ns1 ns2
+
+ip -n "${ns1}" link add eth1 type veth peer name eth1 netns "${ns2}"
+ip -n "${ns1}" link set eth1 up
+ip -n "${ns1}" -6 addr add fc00::1/64 dev eth1 nodad
+ip -n "${ns2}" link set eth1 up
+ip -n "${ns2}" -6 addr add fc00::2/64 dev eth1 nodad
+
+# Wait for DAD-less addresses to settle
+ip -n "${ns1}" -6 route get fc00::2 >/dev/null 2>&1 || sleep 0.1
+
+get_tcpv6_active()
+{
+	awk '/^TCPv6 / { print $2 }' /proc/slabinfo
+}
+
+before=$(get_tcpv6_active)
+
+for i in $(seq 1 ${NR_CONNS}); do
+	echo "a" |
+		timeout ${TIMEOUT_TEST} \
+			ip netns exec "${ns2}" \
+				./mptcp_connect -6 -p $((PORT_BASE + i)) -l \
+					-t ${TIMEOUT_POLL} -w ${TIMEOUT_POLL} \
+					:: >/dev/null 2>&1 &
+done
+
+# wait_local_port_listen() only checks one port. Walk every port so we
+# do not start the connectors before all listeners are ready.
+for i in $(seq 1 ${NR_CONNS}); do
+	mptcp_lib_wait_local_port_listen "${ns2}" $((PORT_BASE + i))
+done
+
+for i in $(seq 1 ${NR_CONNS}); do
+	echo "b" |
+		timeout ${TIMEOUT_TEST} \
+			ip netns exec "${ns1}" \
+				./mptcp_connect -6 -p $((PORT_BASE + i)) \
+					-t ${TIMEOUT_POLL} -w ${TIMEOUT_POLL} \
+					fc00::2 >/dev/null 2>&1 &
+done
+
+# Wait for the accept side to materialise child sockets. ss reports the
+# number of established TCP connections in ns2 owned by mptcp_connect.
+established=0
+for _ in $(seq 20); do
+	established=$(ip netns exec "${ns2}" ss -H -t -6 state established 2>/dev/null | wc -l)
+	[ "${established}" -ge "${NR_CONNS}" ] && break
+	sleep 1
+done
+
+after=$(get_tcpv6_active)
+delta=$(( after - before ))
+
+# Conservative threshold: NR_CONNS connections (each producing at least
+# a server-side accepted child) must leave a clearly observable footprint
+# in the TCPv6 slab. On a regressed kernel, override.slab == NULL routes
+# every child into kmalloc-4k and the TCPv6 delta stays near zero.
+threshold=$(( NR_CONNS / 2 ))
+
+msg="TCPv6 slab gains MPTCPv6 subflow children"
+mptcp_lib_print_title "${msg}"
+if [ "${established}" -lt "${NR_CONNS}" ]; then
+	mptcp_lib_pr_fail "only ${established}/${NR_CONNS} connections established"
+	mptcp_lib_result_fail "${msg}"
+	ret=${KSFT_FAIL}
+elif [ "${delta}" -ge "${threshold}" ]; then
+	mptcp_lib_pr_ok "delta=${delta}"
+	mptcp_lib_result_pass "${msg}"
+else
+	mptcp_lib_pr_fail "delta=${delta} below ${threshold}:" \
+		"subflow children likely in kmalloc fallback"
+	mptcp_lib_result_fail "${msg}"
+	ret=${KSFT_FAIL}
+fi
+
+mptcp_lib_result_print_all_tap
+exit ${ret}
-- 
2.51.0


