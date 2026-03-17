Return-Path: <netdev+bounces-268647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGKKN8tvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C22ACC48
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D18EC309915D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A383EC2E9;
	Tue, 17 Mar 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY/JB3kD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52593EB811;
	Tue, 17 Mar 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759889; cv=none; b=WpJysBVOb3PqA5YlTS5HR5vFfcl/xKGYNMwGsLYhG46J3JFdp+FdnSHbO6l/cEGOpWf9u6ajo2hKO6B4qU3rqjZAtp+Qs0lV3W+emVbZ2DtdDBN83P+KR9KBibWP/rTlk/yqAaCBn1QnC8UfHZAN97ntzrm32Fbx4k2UHl0Xgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759889; c=relaxed/simple;
	bh=GslHWkPAiOKLeI+K6IeZu81lefBpZMWCOMA9G63tr3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhJL1YmChRHRlR1th/Viy70xRgKUr8mL2Wv57jgY4HWGmZE8r1hoziD2Hl/e4PoxtQZkYwshYYqJuUy97G1nNC9jMxuHLZqFgP3ZZnXf1ksxwmn5S+NaSbtE724vOQiuskOvZGWm7FZH/0/ubF7dPOUNNR6jvybnk5MV0uMyMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY/JB3kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31493C19424;
	Tue, 17 Mar 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759889;
	bh=GslHWkPAiOKLeI+K6IeZu81lefBpZMWCOMA9G63tr3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cY/JB3kDesk+io1Lyqyla4yhxtmNNWdDTMF89GAHDzb4zT/kFIBaNHqN6AKLYEVMs
	 w9a4LXIwXqB1BsMECsM5zYvXtoUyOVGSsOcyQv7B5kzVtRrqmY4j1EU/Y517R6EJrA
	 2mr52DT0Qa9TOGebXg+XxpIpl07qlyub0vUu1JiSvls8rYt6QVgs86RSn2eXeDlIDg
	 vR9IRWAE2ADSC0/Hih8djFojbbFSbPvEHZg6D0h29BZzbaV9XK5WbgZFykNoZv1IqU
	 bYdxArakL6i6pLswixRI8sp83/R4UwE0sJlfrNH01xnijRzQXXSUBgZ5npHooDLd6q
	 KPtC0kpQNTplQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:20 -0400
Subject: [PATCH PATCH net-next v4 7/8] tls: Restructure tls_sw_read_sock()
 into submit/deliver phases
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-7-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=lTd2NEGrLw1n7BEpjk0q1q6MFi1jAsUzRIqQER2CxMg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KlVJrRRl3S5H5CKER9iBAnSaeneQL/UT3u
 BtLzVOw046JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 l9+5D/9iHUsa+f3FL5WPQDxPZGkNW9wjMeVbLh3NdILNZUYC8onQ+xjcS//ZOCnZQoqxyKufd8+
 n4pmJasvv60Kg1SGgOh0xuIPvjxXWRaXssaROUGP3/5vvRVzViO8HyELQz/zoWoKxHuHvc+B8K/
 Ih6O6UjgeEV+rg7cbktbdBN7Lu8QQH5iUXKfLZfBXTLPhyobyCMC2cDzFffGkkqIXkt3P0nHx3G
 X6elU6gKxzrI/0rMJvg5iIH9yC00InLGe5fL+awPMneBmfj5E65o/IrATULAu6s1wqXS/5b38DJ
 MmtTqlgnDdhsut8aJ5M5MAINsXEXu3Jc4A4aDa6j99jldT5nRayGi6KqVlIR+ktsoHoh+76tptA
 UL03pkUgfqZxMRrUZo3Yhh6Csh7wtZhGKpJka67Ctj3PVT6g6pJG9/J96umfe0uqX5zKUqjtroJ
 Q2zCVGm8g7nWoH/MxOFui8P1qIdTVryBJ1g8pqH/fMxwNeNSqChjoCXU57AsZRwrP0w70eUc58I
 edPo+R2WKoSIzvH9YA13I1Aq0MtWrahLxH+F6PinxZA1AA682CKcNDPUVrAu6lS1N8BbHouAT9Z
 2OvAPjdFtwOxr5l1N1MYByoDlFkI/70I8e9cZYVfpIZgTpRGS5zT8rg3ME9eoegqOQtyvdQXf3l
 PQvXnlIk9SUHMHA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268647-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D5C22ACC48
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
 net/tls/tls_sw.c | 70 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5b154afbd7ac2ddd51b46d8d6bef0a7a41f0a841..5ae7e0c026e4437fe442c3a77b0a6d9623816ce1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2346,8 +2346,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
-	struct strp_msg *rxm = NULL;
 	struct sk_buff *skb = NULL;
+	struct strp_msg *rxm;
 	struct sk_psock *psock;
 	size_t flushed_at = 0;
 	bool released = true;
@@ -2372,13 +2372,10 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 
 	decrypted = 0;
 	for (;;) {
-		if (!skb_queue_empty(&ctx->rx_list)) {
-			skb = __skb_dequeue(&ctx->rx_list);
-			rxm = strp_msg(skb);
-			tlm = tls_msg(skb);
-		} else {
-			struct tls_decrypt_arg darg;
+		struct tls_decrypt_arg darg;
 
+		/* Phase 1: Submit -- decrypt one record onto rx_list. */
+		if (skb_queue_empty(&ctx->rx_list)) {
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
 				goto read_sock_end;
@@ -2392,38 +2389,43 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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


