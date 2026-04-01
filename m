Return-Path: <netdev+bounces-274213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG9WEC5kzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:30:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E144637F486
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1882302E437
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743693803D9;
	Wed,  1 Apr 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvj59M2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD037DEB8;
	Wed,  1 Apr 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067993; cv=none; b=iEwowb5nod/GzHB7Ro1NYqWDCaOe3PxYkHCOKx05UwOqXVd8jNb43TGxqQwPZej2o+XyYVckKMJ0mpwLRyusJ3aL9JeIdeqCgdr5O4DZ20Mxi6nVyKMD+qj3EPhBvQzP/qMYtVyw24VTZ5W5dlfQ9NSQebcufWQZMTQhN2YyX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067993; c=relaxed/simple;
	bh=7LbvwLMEtASpVz1VnSq0X0Qyml0y8mF7qPhSUHUQ4Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvIhsGP4uLgW6RL+FmZCkjiQxIrbzSOO5Hmkd9qB4jKFFayyTpSIZk5MlX38LhwrXofBqj2/4wHJsWOXElAiigA3r4oWvZoADGa3BhDvA5mKfv568Vm8ubR7gyP7eWtQPmi4rWHWna2BpHhGFoSMOd/OZEz2cvalMv4nD4cTDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvj59M2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA12C19423;
	Wed,  1 Apr 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067993;
	bh=7LbvwLMEtASpVz1VnSq0X0Qyml0y8mF7qPhSUHUQ4Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvj59M2FXQEV0aRDbf1bXtljOumQAJh8vrwRt5oyPvKL1wu/yCT65xQHRS/x5jvdL
	 90Q0VtdT9kCzEdu7FnCFQzfS04Tp8d6VIz1ueExzWuR5x1Sre8EJ2FFNuzgCI7WzAb
	 8RGCjTo3sSjNt9YSPfupzR+N9qFfKd/S/ReneUbUg8LuwgdPOsO1haUl8V+gaM4q7+
	 1rGnwbIO3roWNwfaZ9LW6wTn9KnJZ+I7ZbDJyUeZMP7lleyW8WVhqPKDDCL1zx9IEU
	 OpAOl6YI2q8RGZ4KTGB1TtPLbaoX+q8j/2QAP+5u4SzbmzVdmRhWs2OnS2PhGf8vZy
	 YuIWDnisL341g==
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
Subject: [PATCH net-next 1/6] selftests: drv-net: gro: add data burst test case
Date: Wed,  1 Apr 2026 11:26:20 -0700
Message-ID: <20260401182625.372605-2-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-274213-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E144637F486
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


