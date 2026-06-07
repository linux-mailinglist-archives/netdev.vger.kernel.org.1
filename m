Return-Path: <netdev+bounces-296168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEsJFCi6JGoG+wEAu9opvQ
	(envelope-from <netdev+bounces-296168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B38964E991
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eYLGphjO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296168-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493B13018281
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692691DED49;
	Sun,  7 Jun 2026 00:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449887404E;
	Sun,  7 Jun 2026 00:24:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780791845; cv=none; b=ILEJpOZGAGAlI8qvcx4soi1N+eqcgGbtAwwdiWFCSF/igRn5I7otqjP79VbZhS6HhEwbjJvSqh2/qfHIfnLUXH8GaKUHWrZmzqps08lWnEDCbYRur1mtCis4AwB6O7lAxVjwSYOhfbriz7siOULOQLV1F/b1tSZ2ziN4o1dzf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780791845; c=relaxed/simple;
	bh=DKguOZb9mOl7XKbSfwY+p/PXNRTpSvnWvJbTr9s8+Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuyHp90WzK9j0GDmAasAfx3CGrtXZVPeZOAp254UiwxK8JgW/SELwTwcEdKfK+ETbzTc+vG/auA+6rEh7GzLO9W4xmsc+q3xUo2sO+1r34epjUDQIMmmkonRBCK9q6b90hOv6Ituks+jDdyal2GQBd5013YuhAB/FdMRf47wVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYLGphjO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC4D1F00893;
	Sun,  7 Jun 2026 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780791843;
	bh=2BbaLjFNS7Uw5sD2tYs4S6utpBK8n6JKQZdIEsfwDNQ=;
	h=From:To:Cc:Subject:Date;
	b=eYLGphjOBFE3r0Kn+2qVclxjKAPS3N1KATs9kylTiZb5fu2kRwOj99Sc5Z1GDZ5Nm
	 VSMPmQvD0QznCNzP0NsbsOPt6roZonUhUCz6UN2QyzWOF3m1oSHUIfiMSoY78KtuON
	 vVc9u414Bk6rnZrXeBzkJBacALHMG+0zggAJeERDIlFurg6KmFl1PyI5s8B2087i/v
	 Iy9M4A5pf4MZcPK5j8Ltt3dIQgI/V1AjTrkDl0IXbzuAPwntDdWW7FyBwhi6iHimqa
	 Ih845zzqBL/rMEDWzgVKM3uhoWlBCDkbWkXscWSc/TPQWMDfUmG4aujimRUVgakGCC
	 NmqWSNM7rht8A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: gro: signal over-coalescing more reliably
Date: Sat,  6 Jun 2026 17:24:01 -0700
Message-ID: <20260607002401.212976-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-296168-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B38964E991

GRO test is very timing-sensitive, packets may be delayed
by the network or just sent slowly. Because of this we retry
each test case up to 6 times.

This makes perfect sense for positive cases, in which we want
to see coalescing. Negative test cases, which modify headers
and expect no coalescing should have opposite treatment.
We should really try 6 times and make sure that each time
the test failed. This would, however, require that we annotate
each test to indicate whether its positive or negative.
Let's start with a simpler improvement. Do not allow
retries if we detected over-coalescing. Previously the negative
case would have to get lucky at least once in 6 tries to pass.
Now the first failure breaks the retry loop.

For background - NICs tend to ignore the contents of the TCP
timestamp option, so that test case commonly fails. In NIPA
having 6 attempts, however, was enough for some NICs to get
multiple successful runs in a row, getting the test cases
auto-classified as expected to pass, even tho the NIC does
not comply with the expectations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/gro.c      | 16 +++++++++++++++-
 tools/testing/selftests/drivers/net/gro.py |  8 +++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index fa35dfc8e790..7a333155de1a 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -108,6 +108,8 @@
 #define EXT_PAYLOAD_1 "\x00\x00\x00\x00\x00\x00"
 #define EXT_PAYLOAD_2 "\x11\x11\x11\x11\x11\x11"
 
+#define EXIT_OVER_COALESCE	42
+
 #define ipv6_optlen(p)  (((p)->hdrlen+1) << 3) /* calculate IPv6 extension header len */
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 
@@ -1165,6 +1167,8 @@ static void check_recv_pkts(int fd, int *correct_payload,
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(buffer + nhoff);
 	struct tcphdr *tcph;
 	bool bad_packet = false;
+	int bytes_expected = 0;
+	int bytes_received = 0;
 	int tcp_ext_len = 0;
 	int ip_ext_len = 0;
 	int pkt_size = -1;
@@ -1173,8 +1177,10 @@ static void check_recv_pkts(int fd, int *correct_payload,
 	int i;
 
 	vlog("Expected {");
-	for (i = 0; i < correct_num_pkts; i++)
+	for (i = 0; i < correct_num_pkts; i++) {
 		vlog("%d ", correct_payload[i]);
+		bytes_expected += correct_payload[i];
+	}
 	vlog("}, Total %d packets\nReceived {", correct_num_pkts);
 
 	while (1) {
@@ -1209,9 +1215,17 @@ static void check_recv_pkts(int fd, int *correct_payload,
 			vlog("[!=%d]", correct_payload[num_pkt]);
 			bad_packet = true;
 		}
+		bytes_received += data_len;
 		num_pkt++;
 	}
 	vlog("}, Total %d packets.\n", num_pkt);
+	/* Signal over-coalescing explicitly, it's a hard failure, unlike
+	 * under-coalescing which could be timing- or loss-related.
+	 */
+	if (num_pkt < correct_num_pkts && bytes_received == bytes_expected)
+		error(EXIT_OVER_COALESCE, 0,
+		      "over-coalesced: got %d pkts vs expected %d (%d B)",
+		      num_pkt, correct_num_pkts, bytes_received);
 	if (num_pkt != correct_num_pkts)
 		error(1, 0, "incorrect number of packets");
 	if (bad_packet)
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index fd158c775b1c..6ab8c97880d1 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -40,7 +40,7 @@ import glob
 import os
 import re
 from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import NetDrvEpEnv, KsftXfailEx
+from lib.py import NetDrvEpEnv, KsftFailEx, KsftXfailEx
 from lib.py import NetdevFamily, EthtoolFamily
 from lib.py import bkg, cmd, defer, ethtool, ip
 from lib.py import ksft_variants, KsftNamedVariant
@@ -370,6 +370,12 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
 
         ksft_pr(rx_proc)
 
+        # ret==42 means the receiver detected over-coalescing.
+        # This is unambiguous proof of a bug, retries can only cause
+        # false negatives.
+        if rx_proc.ret == 42:
+            raise KsftFailEx(f"GRO over-coalesced in {protocol}/{test_name}")
+
         if test_name.startswith("large_") and os.environ.get("KSFT_MACHINE_SLOW"):
             ksft_pr(f"Ignoring {protocol}/{test_name} failure due to slow environment")
             return
-- 
2.54.0


