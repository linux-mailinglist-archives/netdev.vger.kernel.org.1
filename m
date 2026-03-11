Return-Path: <netdev+bounces-266391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EiUDsW1sGlvmQIAu9opvQ
	(envelope-from <netdev+bounces-266391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6499259B68
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E93D730AF3B0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27732AACB;
	Wed, 11 Mar 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbPcEOrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6732A3FD;
	Wed, 11 Mar 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188406; cv=none; b=Wvhtk+mbeCSMgzlNugXRWtOlF0yAsJ2A0gOeHS5NkTYsWZzAKcnsljX77ER4fIBAqLtz7lbC46GmFfLXXbCkMHcito7WsREG9X5HA3S5zJPo4txlY5TCeffXKLGlojiRS/C6c5czGOU8srbXBy419iCfdkaqD/WrxwO5BFB3z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188406; c=relaxed/simple;
	bh=iuaHISxE/W8i0nLEelp452PXlP9gOcNSEJkS4GyM74E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqRGifsP/gq2qP3SEpH5niWQ+tPa8mjIGoN5qbcgyF7t8gqBCxF0KiWNGWxjjHHL3Lel1tCPUC7rKggWUuY7yy4NyXCNMCmIUYeOx0oRWTqeNr4eGPj5W59YAHaRQLSldf+Qvq7/lZls7I7eQoFJyU4VW3Nt+MaGvDDHB0n8heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbPcEOrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64837C2BC9E;
	Wed, 11 Mar 2026 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773188406;
	bh=iuaHISxE/W8i0nLEelp452PXlP9gOcNSEJkS4GyM74E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbPcEOrtSFGtaqWYo5dgptEsCuNq43fw0gbFlSgmeW4TSEh/dylHicA8Ui94BaruA
	 arO55B8VWaYTwQlnl7f6uUjuM01MqIr6lHF0scQ4r1IQVedfUDr9tDsqMQ+dJAZJB1
	 vdQq38hAcz0Bp9r70qhit+1QEdHyao5C7mUJO9elH7VdcW4aOWWDZLSzA9ryYl8law
	 z6yAdnhcuqjYxrPK49Ro9q6tdwCZR0+a0SPZ0wX+UoWja1GAFR8K3fdn50YOP7D3LG
	 e58WSLFHpL4glObrxhpVuZED9ZGxgK/4PVqpCQ9iQN63ChQ87R6cGaKlEFQEtdNqFy
	 lH9O/0hRtrJIQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 7/8] tls: Restructure tls_sw_read_sock() into submit/deliver phases
Date: Tue, 10 Mar 2026 20:19:51 -0400
Message-ID: <20260311001952.57059-8-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6499259B68
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
	TAGGED_FROM(0.00)[bounces-266391-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,suse.de:email]
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
index 644a65ff9964..535c856d64e0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2353,8 +2353,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
-	struct strp_msg *rxm = NULL;
 	struct sk_buff *skb = NULL;
+	struct strp_msg *rxm;
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
@@ -2379,17 +2379,15 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
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
@@ -2404,38 +2402,43 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


