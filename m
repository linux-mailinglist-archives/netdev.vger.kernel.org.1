Return-Path: <netdev+bounces-264551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IZfOlryqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:15:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8FF218726
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFD10305C334
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C546A358382;
	Thu,  5 Mar 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rneBKLqY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3335837D;
	Thu,  5 Mar 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745250; cv=none; b=VtJ4rVloKZnfMmCxqiblgLFl+4pcuzn5zuEuBOeMTQRd+hrWx+3wyPV0XF+rPVUXyOYyScktEdyZJOnXCkHRLU5u9yEwzYu3a4vwLtAbSVzvY+J+1tNkKu9G1ayjS9N0zqLsVYOPODMbGNM6zHXntFXMNuhKDEZASNmkhIxZAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745250; c=relaxed/simple;
	bh=fNFXVm/4fNgruSF527ctAXE6XveTNU8yNOqSX6DVsOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjJT/UrgAcpvtZJhl6FSh502gRrcfJx4aNavcuvJrnt4LCWdEpItSDgX0o9yrKaDfdUoISV18XqKnIy2oUWwgtdvk+rhdCFpaAH1zZgp/pizRDOwVYubAmL1KRq2D2b0UP9UBGzNbltOsdmHN+bGGploKN/aU5p9mZplBSP7bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rneBKLqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB98C2BC9E;
	Thu,  5 Mar 2026 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745250;
	bh=fNFXVm/4fNgruSF527ctAXE6XveTNU8yNOqSX6DVsOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rneBKLqYfEPRkCXottTyNl8Kdd5GghdgELpSyHlvaULBLjjdZAdxxHEiWu7d1yGTW
	 95sUymzWJa7M7RO2j0LBHuxlPZfqGPL0LLvLGGNyNT6IVdVObfemqMWWYp5htn5R5l
	 KIss3hK7TAO9PndITK1ujMX8CdjK0CUsfiMPcCK+N+9MrRrYKcphFu3SCdqOHXVP4R
	 Ue2R+PS2KolDoE6lrWc9IeefUsbmg59B8eAE/YYBou0gNQ0omQW0N/uXFVx9+UyuQ2
	 ByjIeX3FSO4UuFELE8Qa3YOEy3EtdxELkLDIG5CeuoprOM1Gxi0qDsRO32MdpZV/a0
	 AVCoZps3WdASQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v1 5/6] tls: Restructure tls_sw_read_sock() into submit/deliver phases
Date: Thu,  5 Mar 2026 16:14:01 -0500
Message-ID: <20260305211402.39408-6-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E8FF218726
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264551-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Pipelining multiple AEAD operations requires separating decryption
from delivery so that several records can be submitted before any
are passed to the read_actor callback. The main loop in
tls_sw_read_sock() is split into two explicit phases: a submit
phase that decrypts one record onto ctx->rx_list, and a deliver
phase that drains rx_list and passes each cleartext skb to the
read_actor callback.

With a single record per submit phase, behavior is identical to the
previous code. A subsequent patch will extend the submit phase to
pipeline multiple AEAD operations.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 79 +++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 70a9c2402ea1..0e72a74ab1ee 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2338,8 +2338,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
-	struct strp_msg *rxm = NULL;
 	struct sk_buff *skb = NULL;
+	struct strp_msg *rxm;
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
@@ -2364,17 +2364,15 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 	decrypted = 0;
 	for (;;) {
-		if (!skb_queue_empty(&ctx->rx_list)) {
-			skb = __skb_dequeue(&ctx->rx_list);
-			rxm = strp_msg(skb);
-			tlm = tls_msg(skb);
-		} else {
-			struct tls_decrypt_arg darg;
+		struct tls_decrypt_arg darg;
 
-			/* Drain backlog so segments that arrived while the
-			 * lock was held appear on sk_receive_queue before
-			 * tls_rx_rec_wait waits for a new record.
-			 */
+		/* Phase 1: Submit -- decrypt one record onto rx_list.
+		 * Flush the backlog first so that segments that
+		 * arrived while the lock was held appear on
+		 * sk_receive_queue before tls_rx_rec_wait waits
+		 * for a new record.
+		 */
+		if (skb_queue_empty(&ctx->rx_list)) {
 			sk_flush_backlog(sk);
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
@@ -2391,38 +2389,43 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,
 							  &flushed_at);
-			skb = darg.skb;
+			decrypted += strp_msg(darg.skb)->full_len;
+			tls_rx_rec_release(ctx);
+			__skb_queue_tail(&ctx->rx_list, darg.skb);
+		}
+
+		/* Phase 2: Deliver -- drain rx_list to read_actor */
+		while ((skb = __skb_dequeue(&ctx->rx_list)) != NULL) {
 			rxm = strp_msg(skb);
 			tlm = tls_msg(skb);
-			decrypted += rxm->full_len;
 
-			tls_rx_rec_release(ctx);
-		}
-
-		/* read_sock does not support reading control messages */
-		if (tlm->control != TLS_RECORD_TYPE_DATA) {
-			err = -EINVAL;
-			goto read_sock_requeue;
-		}
-
-		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
-		if (used <= 0) {
-			if (!copied)
-				err = used;
-			goto read_sock_requeue;
-		}
-		copied += used;
-		if (used < rxm->full_len) {
-			rxm->offset += used;
-			rxm->full_len -= used;
-			if (!desc->count)
+			/* read_sock does not support reading control messages */
+			if (tlm->control != TLS_RECORD_TYPE_DATA) {
+				err = -EINVAL;
 				goto read_sock_requeue;
-		} else {
-			consume_skb(skb);
-			skb = NULL;
-			if (!desc->count)
-				break;
+			}
+
+			used = read_actor(desc, skb, rxm->offset,
+					  rxm->full_len);
+			if (used <= 0) {
+				if (!copied)
+					err = used;
+				goto read_sock_requeue;
+			}
+			copied += used;
+			if (used < rxm->full_len) {
+				rxm->offset += used;
+				rxm->full_len -= used;
+				if (!desc->count)
+					goto read_sock_requeue;
+			} else {
+				consume_skb(skb);
+				skb = NULL;
+			}
 		}
+		/* Drain all of rx_list before honoring !desc->count */
+		if (!desc->count)
+			break;
 	}
 
 read_sock_end:
-- 
2.53.0


