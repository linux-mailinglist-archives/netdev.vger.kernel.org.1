Return-Path: <netdev+bounces-275315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MQfF0df0GmB7AYAu9opvQ
	(envelope-from <netdev+bounces-275315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:45:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D9399614
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 472623011515
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACAE286881;
	Sat,  4 Apr 2026 00:45:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099A258EF3;
	Sat,  4 Apr 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775263506; cv=none; b=LMgv2ycjWBcYcA6wW91W9e5Lz2VwozLT30aOLZlPcQzV8NMJob6sqcZ26cpMgoJN7qF77+aq0s9cs+O+VmMiTKw82dVmdsFLZDvC0tmEVNrgZyuaMReS8sdKi0jWTEKm3xQW/n6kRTpRi6xtG9W0meP7ALzzadpc2u/rGK26izI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775263506; c=relaxed/simple;
	bh=qa0qMNvccYa9tE1taL3L+6iJsTvmmm4XfZCuFvShHD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avLormgCaP6sVjSQfZ3ewDwT2a66gHUpJ1LENjn2Wy7rpnnpazv7SQvNLyjyqQ05Ac/YWo6u/FCzroXrnttQkrg8DIunbL4iTiQmf6UB1Alkd10NwNXs17k/IpK5gxP20lAL6FWexLYbZ1Vek0L8f4SaTyffEAIBAKwwI0/Sds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6340iYLF026118;
	Sat, 4 Apr 2026 02:44:41 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
        david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
        justin.iurman@gmail.com, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel
Date: Sat,  4 Apr 2026 02:44:05 +0200
Message-Id: <20260404004405.4057-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260404004405.4057-1-andrea.mayer@uniroma2.it>
References: <20260404004405.4057-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275315-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,uclouvain.be,uniroma2.it,6wind.com,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,uniroma2.it:email,uniroma2.it:mid,srv6_iptunnel_cache.sh:url,lib.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C5D9399614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest that verifies the dst_cache in seg6 lwtunnel is not
shared between the input (forwarding) and output (locally generated)
paths.

The test creates three namespaces (ns_src, ns_router, ns_dst)
connected in a line. An SRv6 encap route on ns_router encapsulates
traffic destined to cafe::1 with SID fc00::100. The SID is
reachable only for forwarded traffic (from ns_src) via an ip rule
matching the ingress interface (iif veth-r0 lookup 100), and
blackholed in the main table.

The test verifies that:

  1. A packet generated locally on ns_router does not reach
     ns_dst with an empty cache, since the SID is blackholed;
  2. A forwarded packet from ns_src populates the input cache
     from table 100 and reaches ns_dst;
  3. A packet generated locally on ns_router still does not
     reach ns_dst after the input cache is populated,
     confirming the output path does not reuse the input
     cache entry.

Both the forwarded and local packets are pinned to the same CPU
with taskset, since dst_cache is per-cpu.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
Changes v2 -> v3:
 - add root privilege check (Justin)
 - extend prerequisite tool checks and use ping instead of ping6
   for consistency with other srv6 selftests

Changes v1 -> v2:
 - fix SKIP message wording (Nicolas)
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_iptunnel_cache.sh      | 197 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100755 tools/testing/selftests/net/srv6_iptunnel_cache.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 605c54c0e8a3..c709523c99c6 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -89,6 +89,7 @@ TEST_PROGS := \
 	srv6_end_x_next_csid_l3vpn_test.sh \
 	srv6_hencap_red_l3vpn_test.sh \
 	srv6_hl2encap_red_l2vpn_test.sh \
+	srv6_iptunnel_cache.sh \
 	stress_reuseport_listen.sh \
 	tcp_fastopen_backup_key.sh \
 	test_bpf.sh \
diff --git a/tools/testing/selftests/net/srv6_iptunnel_cache.sh b/tools/testing/selftests/net/srv6_iptunnel_cache.sh
new file mode 100755
index 000000000000..62638ab679d9
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_iptunnel_cache.sh
@@ -0,0 +1,197 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# author: Andrea Mayer <andrea.mayer@uniroma2.it>
+
+# This test verifies that the seg6 lwtunnel does not share the dst_cache
+# between the input (forwarding) and output (locally generated) paths.
+#
+# A shared dst_cache allows a forwarded packet to populate the cache and a
+# subsequent locally generated packet to silently reuse that entry, bypassing
+# its own route lookup. To expose this, the SID is made reachable only for
+# forwarded traffic (via an ip rule matching iif) and blackholed for everything
+# else. A local ping on ns_router must always hit the blackhole;
+# if it succeeds after a forwarded packet has populated the
+# cache, the bug is confirmed.
+#
+# Both forwarded and local packets are pinned to the same CPU with taskset,
+# since dst_cache is per-cpu.
+#
+#
+# +--------------------+                        +--------------------+
+# |      ns_src        |                        |      ns_dst        |
+# |                    |                        |                    |
+# |  veth-s0           |                        |           veth-d0  |
+# |  fd00::1/64        |                        |        fd01::2/64  |
+# +-------+------------+                        +----------+---------+
+#         |                                                |
+#         |            +--------------------+              |
+#         |            |     ns_router      |              |
+#         |            |                    |              |
+#         +------------+ veth-r0    veth-r1 +--------------+
+#                      | fd00::2    fd01::1 |
+#                      +--------------------+
+#
+#
+# ns_router: encap (main table)
+# +---------+---------------------------------------+
+# | dst     | action                                |
+# +---------+---------------------------------------+
+# | cafe::1 | encap seg6 mode encap segs fc00::100  |
+# +---------+---------------------------------------+
+#
+# ns_router: post-encap SID resolution
+# +-------+------------+----------------------------+
+# | table | dst        | action                     |
+# +-------+------------+----------------------------+
+# | 100   | fc00::100  | via fd01::2 dev veth-r1    |
+# +-------+------------+----------------------------+
+# | main  | fc00::100  | blackhole                  |
+# +-------+------------+----------------------------+
+#
+# ns_router: ip rule
+# +------------------+------------------------------+
+# | match            | action                       |
+# +------------------+------------------------------+
+# | iif veth-r0      | lookup 100                   |
+# +------------------+------------------------------+
+#
+# ns_dst: SRv6 decap (main table)
+# +--------------+----------------------------------+
+# | SID          | action                           |
+# +--------------+----------------------------------+
+# | fc00::100    | End.DT6 table 255 (local)        |
+# +--------------+----------------------------------+
+
+source lib.sh
+
+readonly SID="fc00::100"
+readonly DEST="cafe::1"
+
+readonly SRC_MAC="02:00:00:00:00:01"
+readonly RTR_R0_MAC="02:00:00:00:00:02"
+readonly RTR_R1_MAC="02:00:00:00:00:03"
+readonly DST_MAC="02:00:00:00:00:04"
+
+cleanup()
+{
+	cleanup_ns "${NS_SRC}" "${NS_RTR}" "${NS_DST}"
+}
+
+check_prerequisites()
+{
+	if ! command -v ip &>/dev/null; then
+		echo "SKIP: ip tool not found"
+		exit "${ksft_skip}"
+	fi
+
+	if ! command -v ping &>/dev/null; then
+		echo "SKIP: ping not found"
+		exit "${ksft_skip}"
+	fi
+
+	if ! command -v sysctl &>/dev/null; then
+		echo "SKIP: sysctl not found"
+		exit "${ksft_skip}"
+	fi
+
+	if ! command -v taskset &>/dev/null; then
+		echo "SKIP: taskset not found"
+		exit "${ksft_skip}"
+	fi
+}
+
+setup()
+{
+	setup_ns NS_SRC NS_RTR NS_DST
+
+	ip link add veth-s0 netns "${NS_SRC}" type veth \
+		peer name veth-r0 netns "${NS_RTR}"
+	ip link add veth-r1 netns "${NS_RTR}" type veth \
+		peer name veth-d0 netns "${NS_DST}"
+
+	ip -n "${NS_SRC}" link set veth-s0 address "${SRC_MAC}"
+	ip -n "${NS_RTR}" link set veth-r0 address "${RTR_R0_MAC}"
+	ip -n "${NS_RTR}" link set veth-r1 address "${RTR_R1_MAC}"
+	ip -n "${NS_DST}" link set veth-d0 address "${DST_MAC}"
+
+	# ns_src
+	ip -n "${NS_SRC}" link set veth-s0 up
+	ip -n "${NS_SRC}" addr add fd00::1/64 dev veth-s0 nodad
+	ip -n "${NS_SRC}" -6 route add "${DEST}"/128 via fd00::2
+
+	# ns_router
+	ip -n "${NS_RTR}" link set veth-r0 up
+	ip -n "${NS_RTR}" addr add fd00::2/64 dev veth-r0 nodad
+	ip -n "${NS_RTR}" link set veth-r1 up
+	ip -n "${NS_RTR}" addr add fd01::1/64 dev veth-r1 nodad
+	ip netns exec "${NS_RTR}" sysctl -qw net.ipv6.conf.all.forwarding=1
+
+	ip -n "${NS_RTR}" -6 route add "${DEST}"/128 \
+		encap seg6 mode encap segs "${SID}" dev veth-r0
+	ip -n "${NS_RTR}" -6 route add "${SID}"/128 table 100 \
+		via fd01::2 dev veth-r1
+	ip -n "${NS_RTR}" -6 route add blackhole "${SID}"/128
+	ip -n "${NS_RTR}" -6 rule add iif veth-r0 lookup 100
+
+	# ns_dst
+	ip -n "${NS_DST}" link set veth-d0 up
+	ip -n "${NS_DST}" addr add fd01::2/64 dev veth-d0 nodad
+	ip -n "${NS_DST}" addr add "${DEST}"/128 dev lo nodad
+	ip -n "${NS_DST}" -6 route add "${SID}"/128 \
+		encap seg6local action End.DT6 table 255 dev veth-d0
+	ip -n "${NS_DST}" -6 route add fd00::/64 via fd01::1
+
+	# static neighbors
+	ip -n "${NS_SRC}" -6 neigh add fd00::2 dev veth-s0 \
+		lladdr "${RTR_R0_MAC}" nud permanent
+	ip -n "${NS_RTR}" -6 neigh add fd00::1 dev veth-r0 \
+		lladdr "${SRC_MAC}" nud permanent
+	ip -n "${NS_RTR}" -6 neigh add fd01::2 dev veth-r1 \
+		lladdr "${DST_MAC}" nud permanent
+	ip -n "${NS_DST}" -6 neigh add fd01::1 dev veth-d0 \
+		lladdr "${RTR_R1_MAC}" nud permanent
+}
+
+test_cache_isolation()
+{
+	RET=0
+
+	# local ping with empty cache: must fail (SID is blackholed)
+	if ip netns exec "${NS_RTR}" taskset -c 0 \
+			ping -c 1 -W 2 "${DEST}" &>/dev/null; then
+		echo "SKIP: local ping succeeded, topology broken"
+		exit "${ksft_skip}"
+	fi
+
+	# forward from ns_src to populate the input cache
+	if ! ip netns exec "${NS_SRC}" taskset -c 0 \
+			ping -c 1 -W 2 "${DEST}" &>/dev/null; then
+		echo "SKIP: forwarded ping failed, topology broken"
+		exit "${ksft_skip}"
+	fi
+
+	# local ping again: must still fail; if the output path reuses
+	# the input cache, it bypasses the blackhole and the ping succeeds
+	if ip netns exec "${NS_RTR}" taskset -c 0 \
+			ping -c 1 -W 2 "${DEST}" &>/dev/null; then
+		echo "FAIL: output path used dst cached by input path"
+		RET="${ksft_fail}"
+	else
+		echo "PASS: output path dst_cache is independent"
+	fi
+
+	return "${RET}"
+}
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "SKIP: Need root privileges"
+	exit "${ksft_skip}"
+fi
+
+trap cleanup EXIT
+
+check_prerequisites
+setup
+test_cache_isolation
+exit "${RET}"
-- 
2.43.0


