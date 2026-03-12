Return-Path: <netdev+bounces-266837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEMKFMAbsmnjIgAAu9opvQ
	(envelope-from <netdev+bounces-266837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:49:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E529B26C040
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA84311B872
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B96375F6E;
	Thu, 12 Mar 2026 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKbAmu1u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB6375F60;
	Thu, 12 Mar 2026 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280093; cv=none; b=VWJMlj/XBosE+v4aZHyq9nVmFO1pbePgCwvObPohFJR51IuvqW3T48ffqhdGuqmX4ct7IuOta0MwmsT4FuorvfQgOk4bBPVaW3m6MxR6WuIzw77U6e+AD48E416eO37YzWXxf/OjLMQygRHv0Atq2hHOus0H7CIkEo+gUw4gDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280093; c=relaxed/simple;
	bh=VfdpFWVPRHpJINR/ed3j/JUGrCplXG+EEegFKlrWCJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk9uvlqKN3JkCMdZ5rXpMR62vf+moLiVjCdtG3d7KTzw0EqZKz7xu5WmdlTveYwezqyNbknAc0RdwrFm0Q1pvM882uNgMiHAioKjsWUXFBe5BLoOioad4dnXUKuImV+bZnpaw0Go3lOkTZBI0zoKeDr7kdsgDa+WCX2PyuoRGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKbAmu1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F62C19421;
	Thu, 12 Mar 2026 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773280093;
	bh=VfdpFWVPRHpJINR/ed3j/JUGrCplXG+EEegFKlrWCJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKbAmu1uN2KPUCz3nJJIbRSHTnO4o2WvdlAlGKUz/y318oGIrXrlax3HucR9lFVf/
	 ++g1MnQgoC2WyXMYAyosgM2Z0ivXaY137hJyPAUpAxs8/sdfrMPmZgPUFkxi9rjFwM
	 3zxTFtKw1xoFUTCfVbITaAT9xJdLN60aHS3lrcy77FwXXVov8iTu4rcvC4sJYPLpUx
	 YRgW7ber1d5bcHI461UjxgILXV0zjiACUtDSqwxebTR9mE0ZNfzk9TDgIB1WFt74/i
	 OM/OWBb/R7Iq188RymeCNENJAJKrqitdqgbrsgoeZD1116RmkQnE35VKnlM2kgnLTe
	 +g0Pfz6+EJE2g==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 7/8] tls: Restructure tls_sw_read_sock() into submit/deliver phases
Date: Wed, 11 Mar 2026 21:48:03 -0400
Message-ID: <20260312014804.5083-8-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312014804.5083-1-cel@kernel.org>
References: <20260312014804.5083-1-cel@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266837-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,suse.de:email]
X-Rspamd-Queue-Id: E529B26C040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 7e1560d5ab79..6d54d350bced 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2354,8 +2354,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
-	struct strp_msg *rxm = NULL;
 	struct sk_buff *skb = NULL;
+	struct strp_msg *rxm;
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
@@ -2380,17 +2380,15 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
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
@@ -2405,38 +2403,43 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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
2.52.0


