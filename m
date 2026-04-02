Return-Path: <netdev+bounces-274694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFW/MljZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:02:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8238E345
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 244623053BF7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380037AA95;
	Thu,  2 Apr 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqeSKa/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA9366564;
	Thu,  2 Apr 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163610; cv=none; b=ttdlWqf4JWv6PEUrAtqpnNQG96X9Aitxp8Wl5PSplYx1eSqBByzFWcHJguDKSL/8g9kHtbYpxoYdP0GJ96QcWeTazeYYSoIcKgy7u3M/xb/5XRn1xMfnbOdyBjTrktVV8nZGUB+CLvMaVAg7Iy0vB0+/jfyczL0meTa4cQ0S6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163610; c=relaxed/simple;
	bh=7LbvwLMEtASpVz1VnSq0X0Qyml0y8mF7qPhSUHUQ4Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG22b26GD2aUIE916zNmb+HkyakRepyEMEN2hLhXpN6rHhHvmUXoAFHh+J5Nk6Ax4jOxIwQsKAhV52S11itlAPXkqToaUrSI3YBLPc5sZ4kOvpnTZ7kwNy7dAFtiwYuhTdbqFhnZEpVvCM4VldO4bkcde+d8h90HWx6wDg9JtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqeSKa/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F1C19424;
	Thu,  2 Apr 2026 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775163610;
	bh=7LbvwLMEtASpVz1VnSq0X0Qyml0y8mF7qPhSUHUQ4Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqeSKa/bnliip1+nwNvNcT2RzuCKzDXouRoaAon+ANIcMphFzy03V7CWBJsZf+9gU
	 HWc8VywISxxPzvMqFIMSmblvvsj2rUcezbvLQivtFczOGN1ZAYuG5TAc/oInVZQuol
	 zHLp1yJiNyUv9dv/ybMv2AbmURHdjnS7Mr+VVrZd0t/X8XfKYjcap/sK7nSX8g0Qd2
	 lcS8X21jVkWIxAZoOg21tQ3phwod6LBF/uFbjCriy4pRgSTB6KrIrBjTNiPiz8UE5z
	 cEKiJRnQ/vdABtU4b7OtAICVVUdjNeYYSP1hI2txX+RWulH9cqGrqmdZVW1PsACXhA
	 ivWjwQwjXgBqw==
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
Subject: [PATCH net-next v2 1/8] selftests: drv-net: gro: add data burst test case
Date: Thu,  2 Apr 2026 13:59:53 -0700
Message-ID: <20260402210000.1512696-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
References: <20260402210000.1512696-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274694-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E8238E345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test trying to induce a GRO context timeout followed
by another sequence of packets for the same flow. The second
burst arrives 100ms after the first one so any implementation
(SW or HW) must time out waiting at that point. We expect both
bursts to be aggregated successfully but separately.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c      | 21 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/gro.py |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 3e611ae25f61..4d002af4a7aa 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -12,6 +12,7 @@
  *   - data_same:    same size packets coalesce
  *   - data_lrg_sml: large then small coalesces
  *   - data_sml_lrg: small then large doesn't coalesce
+ *   - data_burst:   two bursts of two, separated by 100ms
  *
  * ack:
  *  Pure ACK does not coalesce.
@@ -1298,6 +1299,21 @@ static void gro_sender(void)
 	} else if (strcmp(testname, "data_sml_lrg") == 0) {
 		send_data_pkts(txfd, &daddr, PAYLOAD_LEN / 2, PAYLOAD_LEN);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "data_burst") == 0) {
+		static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+
+		create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
+		write_packet(txfd, buf, total_hdr_len + PAYLOAD_LEN, &daddr);
+		create_packet(buf, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
+		write_packet(txfd, buf, total_hdr_len + PAYLOAD_LEN, &daddr);
+
+		usleep(100 * 1000); /* 100ms */
+		create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
+		write_packet(txfd, buf, total_hdr_len + PAYLOAD_LEN, &daddr);
+		create_packet(buf, PAYLOAD_LEN * 3, 0, PAYLOAD_LEN, 0);
+		write_packet(txfd, buf, total_hdr_len + PAYLOAD_LEN, &daddr);
+
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* ack test */
 	} else if (strcmp(testname, "ack") == 0) {
@@ -1463,6 +1479,11 @@ static void gro_receiver(void)
 		correct_payload[0] = PAYLOAD_LEN / 2;
 		correct_payload[1] = PAYLOAD_LEN;
 		check_recv_pkts(rxfd, correct_payload, 2);
+	} else if (strcmp(testname, "data_burst") == 0) {
+		printf("two bursts of two data packets: ");
+		correct_payload[0] = PAYLOAD_LEN * 2;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		check_recv_pkts(rxfd, correct_payload, 2);
 
 	/* ack test */
 	} else if (strcmp(testname, "ack") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 70709bf670c7..10da5d4bee9b 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -289,7 +289,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
 
     # Tests that work for all protocols
     common_tests = [
-        "data_same", "data_lrg_sml", "data_sml_lrg",
+        "data_same", "data_lrg_sml", "data_sml_lrg", "data_burst",
         "ack",
         "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
-- 
2.53.0


