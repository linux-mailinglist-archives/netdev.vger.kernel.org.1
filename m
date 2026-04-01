Return-Path: <netdev+bounces-274214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNEGOFtkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14D37F49C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B9E3037456
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1253BD63F;
	Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkysWX0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEEE3A1695;
	Wed,  1 Apr 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067994; cv=none; b=LKzfusCq6cswFrepBh16R3bPl7Fxb4G7csCGwuMUcwePjxcuqGt2HIWzMrSnW6elB+wJ7MN6TlysGteamxB7h9IO36byg8yq/nE9I9vc814lqeBvIkp45NxXWnvBQpFhPRhztTMVuGugDtznFMCWJEEhm++oHWmHqUHKznU53s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067994; c=relaxed/simple;
	bh=nyXWWdLpKVrxz9WCZV7E0Iv9P2IG1bKGFpdoW/2TgLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkQQ6Bp7JSstKvSm+hhLq3JFJwR/d7exuJxM2+E1z/M5YPxuATpWGQCK6FDFFHRhIydmkFWicrEy7h1UFY0Aot1NdiTwc6GZFCLRv2YKylU7ONDO8LoYMAIj2aDXCnCyetL7SylNF1H6ujelEzL7728rw/IZ6hT6+nr4w5nXKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkysWX0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44840C4CEF7;
	Wed,  1 Apr 2026 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067993;
	bh=nyXWWdLpKVrxz9WCZV7E0Iv9P2IG1bKGFpdoW/2TgLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkysWX0SQSIvAmkAVWqij2r9hjlpx9LPSDVGy1vhOQxZGsOiESse9PXGAK0/mqINR
	 RHUiwCWilwSyjEDEPy4iB3IP0dnobbwi9WhdjD8l/0pL7LNWLwc9lVVQzbnXFFS+zZ
	 HgicEnCyOtHHHtMZhC4nYj4Vih+6hqazOR3gmgnb2qIoSEseATBUpX0jMeVriE+94L
	 anQOlp9kC/bz0/p3kIjIPIQs6NMCiCpDWhlGl2H8G7jvkzTAxm0s4DpiXbcsCNGLnl
	 KHTqWe3n2Mh93HUkD9PAlMkTj7oJUwOV93sPKCyMwl+dVuGIYd3GbWYNE7e9Nbp7ib
	 HQbi9+VxskxdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/6] selftests: drv-net: gro: add 1 byte payload test
Date: Wed,  1 Apr 2026 11:26:21 -0700
Message-ID: <20260401182625.372605-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401182625.372605-1-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274214-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B14D37F49C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Small IPv4 packets get padded to 60B, this may break / confuse
some buggy implementations. Add a test to coalesce a 1B payload.
Keep this separate from the lrg_sml test because I suspect some
implementations may not handle this case (treat padded frames
as ineligible for coalescing).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c      | 12 ++++++++++--
 tools/testing/selftests/drivers/net/gro.py |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 4d002af4a7aa..27ccd742615a 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -10,8 +10,9 @@
  *  packet coalesced: it can be smaller than the rest and coalesced
  *  as long as it is in the same flow.
  *   - data_same:    same size packets coalesce
- *   - data_lrg_sml: large then small coalesces
- *   - data_sml_lrg: small then large doesn't coalesce
+ *   - data_lrg_sml:   large then small coalesces
+ *   - data_lrg_1byte: large then 1 byte coalesces (Ethernet padding)
+ *   - data_sml_lrg:   small then large doesn't coalesce
  *   - data_burst:   two bursts of two, separated by 100ms
  *
  * ack:
@@ -1296,6 +1297,9 @@ static void gro_sender(void)
 	} else if (strcmp(testname, "data_lrg_sml") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN, PAYLOAD_LEN / 2);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "data_lrg_1byte") == 0) {
+		send_data_pkts(txfd, &daddr, PAYLOAD_LEN, 1);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "data_sml_lrg") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN / 2, PAYLOAD_LEN);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
@@ -1474,6 +1478,10 @@ static void gro_receiver(void)
 		printf("large data packets followed by a smaller one: ");
 		correct_payload[0] = PAYLOAD_LEN * 1.5;
 		check_recv_pkts(rxfd, correct_payload, 1);
+	} else if (strcmp(testname, "data_lrg_1byte") == 0) {
+		printf("large data packet followed by a 1 byte one: ");
+		correct_payload[0] = PAYLOAD_LEN + 1;
+		check_recv_pkts(rxfd, correct_payload, 1);
 	} else if (strcmp(testname, "data_sml_lrg") == 0) {
 		printf("small data packets followed by a larger one: ");
 		correct_payload[0] = PAYLOAD_LEN / 2;
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 10da5d4bee9b..73436d16b40d 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -11,6 +11,7 @@ coalescing behavior.
 Test cases:
   - data_same: Same size data packets coalesce
   - data_lrg_sml: Large packet followed by smaller one coalesces
+  - data_lrg_1byte: Large packet followed by 1B one coalesces (Ethernet padding)
   - data_sml_lrg: Small packet followed by larger one doesn't coalesce
   - ack: Pure ACK packets do not coalesce
   - flags_psh: Packets with PSH flag don't coalesce
@@ -289,7 +290,8 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
 
     # Tests that work for all protocols
     common_tests = [
-        "data_same", "data_lrg_sml", "data_sml_lrg", "data_burst",
+        "data_same", "data_lrg_sml", "data_sml_lrg", "data_lrg_1byte",
+        "data_burst",
         "ack",
         "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
-- 
2.53.0


