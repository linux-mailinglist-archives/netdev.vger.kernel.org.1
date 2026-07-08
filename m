Return-Path: <netdev+bounces-305732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cinXGoYfTmqfDgIAu9opvQ
	(envelope-from <netdev+bounces-305732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E699A723F48
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 11:59:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=EHWqBn02;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305732-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305732-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB093014C56
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D5377003;
	Wed,  8 Jul 2026 09:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED4379ED4;
	Wed,  8 Jul 2026 09:59:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504768; cv=none; b=dWNNWXR+cU/XvQIgY0lnEjzYnpaHK/9IzI4KjWKslw1295xcHbVzJcgbw8jxv/310zPoqtVxAj5bwDO6uJEXTGEo4PSGobfKLAWSLwGDOtdUTNuHTupKvR9CuEhliWDRsf+GKFhj+fWRKXsaDz0OY4Rpjb6kUdEsqRtmnu1poBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504768; c=relaxed/simple;
	bh=eIwVs6pnXz3Eqse2MSx5tB+20FoGPRH90HPKlEcouqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLFfpu3W4bS+pX2uBwmCnOB7Mm/wZXNhysBFz7Asya+ESXQZOrsEXZ2Pfbv/XNJ3yccRHb7ntRzIMtcyPlIwCdhJhFGFfNBwct0pq6BpxAENL26VhEDBvgvMHbRJbYx64HI4xc1Hb/WARmt9xBwZIkaM7I/Lf+caI9KG+q4Fu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EHWqBn02; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504765;
	bh=ra5G7asGoeWwsZsEQqV1BqtsGlhg5hXPsTqJyqpIZbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EHWqBn02AqwJkI2KSwn5Yc6FwkQx+dH2gdDDgJ+X9WIsCN5kMiPa+qtOMLp+1R5VZ
	 vQ9ofjbu/bllUSDcNie660pzdSJZJZj8oCgiFnzCJL+qxp/4GlZ9DkahcfEAwq5wLO
	 +CJ62W1GSmUrqEBmGZn53N2Bk7lfapmYmGVvmS3+5cflFePuD0rGbrglNnpV3SZLal
	 zvtn6mfcnnv9I4EU/AvBWj4MYH6rK1wRM7OrqRDi1UMifS6GAyTeL0l5IoUkjPFahV
	 jl+D9NvZ1/1klkuqT6bQlX/Dm/Zf+DDYmTTAEQGp5V/WKIWCefys1PmpqtRXc7I9vf
	 IO7M3ENuAynUw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 8F96F66526; Wed,  8 Jul 2026 17:59:25 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:37 +0800
Subject: [PATCH net-next v3 06/12] net: mctp: usblib: Add support for
 multi-packet transmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-6-9e710155cdbf@codeconstruct.com.au>
References: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
In-Reply-To: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E699A723F48

The MCTP over USB spec allows us to pack multiple packets in one
transfer. Given the packet max length is 255, and the transfer max
length is 512, we can typically include two full-size packets per
urb submission.

To do this, we allow a struct mctp_usb_tx to persist a tx_ctx,
representing the ongoing context for a transmit. If possible, a TX skb
will be queued to the context and the send deferred until the context is
full, or the device queue reports no more packets.

This typically requires a linear buffer for the 512-byte TX, which we
allocate along with the TX context.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v3:
 - ensure we are setting drop reasons correctly on _prepare() failure
v2:
 - expand on tx_should_send logic, rather than the hardcoded 68 value.
 - don't increment ctx->len (from zero) on ctx_create(), set explicitly
 - add skb_drop_reasons
---
 drivers/net/mctp/mctp-usblib.c | 252 +++++++++++++++++++++++++++++++++--------
 include/linux/usb/mctp-usb.h   |   8 +-
 2 files changed, 210 insertions(+), 50 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 3f4295f3145c..2e464254353e 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -177,11 +177,13 @@ EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
 /* transmit context: encapsulates one transfer */
 struct mctp_usblib_tx_ctx {
 	struct mctp_usblib_tx *tx;
-	struct sk_buff *skb;
+	struct sk_buff_head skbs;
 	unsigned int len;
 	enum mctp_usblib_tx_buf_type {
 		TX_SINGLE,
+		TX_FLAT,
 	} buf_type;
+	u8 buf[] ____cacheline_aligned;
 };
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
@@ -191,53 +193,129 @@ void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
 	memset(tx, 0, sizeof(*tx));
 	tx->ops = *ops;
 	tx->priv = priv;
+	spin_lock_init(&tx->lock);
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_init);
 
-void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
+static int mctp_usblib_tx_avail(struct mctp_usblib_tx_ctx *ctx)
 {
+	return ctx->buf_type == TX_SINGLE ? 0 : MCTP_USB_1_0_XFER_SIZE - ctx->len;
 }
-EXPORT_SYMBOL_GPL(mctp_usblib_tx_fini);
 
-void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx)
+static bool mctp_usblib_tx_should_send(struct mctp_usblib_tx_ctx *ctx)
 {
-	return tx_ctx->tx->priv;
+	/* Use the baseline length (ie, BTU) as an approximate
+	 * "reasonably-sized" packet we could expect. If there is
+	 * insufficient capacity for that, then send.
+	 */
+	const size_t pkt_len = MCTP_USB_BTU + sizeof(struct mctp_usb_hdr);
+
+	return mctp_usblib_tx_avail(ctx) < pkt_len;
 }
-EXPORT_SYMBOL_GPL(mctp_usblib_tx_ctx_priv);
 
-static struct mctp_usblib_tx_ctx *
-mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb)
+/*
+ * Returns zero on success, non-zero on failure - indicating that the new skb
+ * could not be appended. So, errors reported here to the TX path will result
+ * in the TX being transmitted.
+ */
+static int mctp_usblib_tx_append(struct mctp_usblib_tx_ctx *ctx,
+				 struct sk_buff *skb)
 {
-	struct mctp_usblib_tx_ctx *ctx;
+	if (ctx->buf_type == TX_SINGLE)
+		return -EINVAL;
 
-	ctx = kzalloc_obj(*ctx, GFP_ATOMIC);
-	if (!ctx)
-		return NULL;
+	if (mctp_usblib_tx_avail(ctx) < skb->len)
+		return -ENOBUFS;
+
+	__skb_queue_tail(&ctx->skbs, skb);
 
-	ctx->tx = tx;
-	ctx->buf_type = TX_SINGLE;
-	ctx->skb = skb;
 	ctx->len += skb->len;
 
-	return ctx;
+	return 0;
 }
 
 static int mctp_usblib_tx_send(struct mctp_usblib_tx_ctx *ctx)
 {
-	struct mctp_usblib_tx *tx = ctx->tx;
-	void *buf = ctx->skb->data;
+	void *buf;
+
+	/* If we have a qlen of 1, we only ended up packing a single skb,
+	 * despite allocating for multiple. Skip the copy and send directly
+	 * from the skb data.
+	 */
+	if (ctx->buf_type == TX_SINGLE || ctx->skbs.qlen == 1) {
+		buf = ctx->skbs.next->data;
+
+	} else if (ctx->buf_type == TX_FLAT) {
+		struct sk_buff *skb;
+		size_t pos = 0;
+
+		skb_queue_walk(&ctx->skbs, skb) {
+			skb_copy_bits(skb, 0, ctx->buf + pos, skb->len);
+			pos += skb->len;
+		}
 
-	return tx->ops.send(ctx, buf, ctx->len);
+		buf = ctx->buf;
+	} else {
+		return -EINVAL;
+	}
+
+	return ctx->tx->ops.send(ctx, buf, ctx->len);
 }
 
 static void mctp_usblib_tx_ctx_free(struct mctp_usblib_tx_ctx *ctx,
 				    enum skb_drop_reason reason)
 {
-	if (ctx)
-		dev_kfree_skb_any_reason(ctx->skb, reason);
+	struct sk_buff *skb;
+
+	if (!ctx)
+		return;
+
+	while ((skb = __skb_dequeue(&ctx->skbs)) != NULL)
+		dev_kfree_skb_any_reason(skb, reason);
 	kfree(ctx);
 }
 
+void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx)
+{
+	return tx_ctx->tx->priv;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_ctx_priv);
+
+/* caller must ensure the tx & completion path is quiesced */
+void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
+{
+	mctp_usblib_tx_ctx_free(tx->cur_ctx, SKB_DROP_REASON_NOT_SPECIFIED);
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_fini);
+
+static struct mctp_usblib_tx_ctx *
+mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
+			  bool single)
+{
+	enum mctp_usblib_tx_buf_type type;
+	struct mctp_usblib_tx_ctx *ctx;
+	size_t sz = 0;
+
+	if (single) {
+		type = TX_SINGLE;
+	} else {
+		type = TX_FLAT;
+		sz = MCTP_USB_1_0_XFER_SIZE;
+	}
+
+	ctx = kzalloc_flex(*ctx, buf, sz, GFP_ATOMIC);
+	if (!ctx)
+		return NULL;
+
+	ctx->tx = tx;
+	ctx->buf_type = type;
+	ctx->len = skb->len;
+	skb_queue_head_init(&ctx->skbs);
+	__skb_queue_tail(&ctx->skbs, skb);
+
+	return ctx;
+}
+
 static void mctp_usblib_tx_stats_update(struct mctp_usblib_tx_ctx *ctx,
 					struct net_device *dev,
 					bool ok)
@@ -251,12 +329,13 @@ static void mctp_usblib_tx_stats_update(struct mctp_usblib_tx_ctx *ctx,
 		 * that there is a 4-byte header pushed to all skbs in
 		 * tx_skb_prepare()
 		 */
-		s64 len = ctx->len - sizeof(struct mctp_usb_hdr);
+		u64 n = ctx->skbs.qlen;
+		s64 len = ctx->len - (n * sizeof(struct mctp_usb_hdr));
 
-		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_packets, n);
 		u64_stats_add(&dstats->tx_bytes, len);
 	} else {
-		u64_stats_inc(&dstats->tx_drops);
+		u64_stats_add(&dstats->tx_drops, ctx->skbs.qlen);
 	}
 	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
 	put_cpu_ptr(dev->dstats);
@@ -327,8 +406,8 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
 }
 
 /*
- * Push a new skb to the transfer. At present, no send must be in progress,
- * as we only handle single-packet USB transfers.
+ * Push a new skb to the transfer. May result in zero or more calls to
+ * ops->send().
  *
  * Takes ownership of @skb, including on error.
  */
@@ -336,36 +415,106 @@ int mctp_usblib_tx_push(struct net_device *dev,
 			struct mctp_usblib_tx *tx,
 			struct sk_buff *skb, bool more)
 {
-	struct mctp_usblib_tx_ctx *ctx;
+	struct mctp_usblib_tx_ctx *ctx, *send_ctx = NULL;
 	enum skb_drop_reason reason;
-	int rc;
+	const int max_tries = 3;
+	unsigned long flags;
+	int try = 1, rc;
+
+	rc = mctp_usblib_tx_skb_prepare(skb, &reason);
+	if (rc) {
+		mctp_usblib_tx_stats_single_drop(dev);
+		kfree_skb_reason(skb, reason);
+		/* we may still need to proceed, in case an existing ctx
+		 * is now sendable (ie.: !more).
+		 */
+		skb = NULL;
+	}
+
+	reason = SKB_DROP_REASON_NOT_SPECIFIED;
+retry:
+	/* Try and queue to the current context. We exit this critical section
+	 * with a few bits of state:
+	 *  - send_ctx: indicating a prior context that needs to be sent
+	 *  - skb: indicating that a skb still needs to be queued/sent
+	 */
+	spin_lock_irqsave(&tx->lock, flags);
+	ctx = tx->cur_ctx;
+	if (ctx) {
+		if (skb) {
+			rc = mctp_usblib_tx_append(ctx, skb);
+			if (rc) {
+				/* can't append to the pending tx - detach for
+				 * sending, and we'll create a new tx below.
+				 */
+				swap(tx->cur_ctx, send_ctx);
+			} else {
+				/* we have queued */
+				skb = NULL;
+				if (!more || mctp_usblib_tx_should_send(ctx))
+					swap(tx->cur_ctx, send_ctx);
+			}
+		} else if (!more) {
+			swap(tx->cur_ctx, send_ctx);
+		}
+	}
+	spin_unlock_irqrestore(&tx->lock, flags);
+
+	if (send_ctx) {
+		rc = mctp_usblib_tx_send(send_ctx);
+		if (rc) {
+			mctp_usblib_tx_stats_update(send_ctx, dev, false);
+			mctp_usblib_tx_ctx_free(send_ctx, reason);
+		}
+		send_ctx = NULL;
+	}
 
+	/* we have either queued, or the prepare failed; nothing more to do */
 	if (!skb)
 		return 0;
 
-	rc = mctp_usblib_tx_skb_prepare(skb, &reason);
-	if (rc)
-		goto err_drop_single;
-
-	ctx = mctp_usblib_tx_ctx_create(tx, skb);
+	ctx = mctp_usblib_tx_ctx_create(tx, skb, !more);
 	if (!ctx) {
-		rc = -ENOMEM;
-		reason = SKB_DROP_REASON_NOMEM;
-		goto err_drop_single;
+		netdev_dbg(dev, "TX context create failed\n");
+		mctp_usblib_tx_stats_single_drop(dev);
+		kfree_skb(skb);
+		return -ENOMEM;
 	}
 
-	rc = mctp_usblib_tx_send(ctx);
-	if (rc) {
-		mctp_usblib_tx_stats_update(ctx, dev, false);
-		mctp_usblib_tx_ctx_free(ctx, SKB_DROP_REASON_NOT_SPECIFIED);
+	/* if we're ready to send now, no need to enqueue */
+	if (!more || mctp_usblib_tx_should_send(ctx)) {
+		rc = mctp_usblib_tx_send(ctx);
+		if (rc) {
+			mctp_usblib_tx_stats_update(ctx, dev, false);
+			mctp_usblib_tx_ctx_free(ctx, reason);
+		}
+		return 0;
 	}
 
-	return rc;
+	spin_lock_irqsave(&tx->lock, flags);
+	if (!tx->cur_ctx) {
+		tx->cur_ctx = ctx;
+		ctx = NULL;
+	}
+	spin_unlock_irqrestore(&tx->lock, flags);
 
-err_drop_single:
-	mctp_usblib_tx_stats_single_drop(dev);
-	kfree_skb_reason(skb, reason);
-	return rc;
+	/* we may have lost the race with a concurrent tx; shouldn't happen, as
+	 * ndo_start_xmit should be serialised over one queue, but try again
+	 * from the top, as we may be able to queue the skb to that context.
+	 */
+	if (ctx) {
+		/* unlink the new (sole) skb, we don't want it freed with ctx */
+		__skb_queue_head_init(&ctx->skbs);
+		mctp_usblib_tx_ctx_free(ctx, reason);
+		if (++try > max_tries) {
+			kfree_skb(skb);
+			mctp_usblib_tx_stats_single_drop(dev);
+			return -EBUSY;
+		}
+		goto retry;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_push);
 
@@ -373,7 +522,18 @@ EXPORT_SYMBOL_GPL(mctp_usblib_tx_push);
 void mctp_usblib_tx_cancel(struct mctp_usblib_tx *tx, struct net_device *dev,
 			   enum skb_drop_reason reason)
 {
-	/* nothing to do at present, no ctx is persistent */
+	struct mctp_usblib_tx_ctx *ctx = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tx->lock, flags);
+	swap(tx->cur_ctx, ctx);
+	spin_unlock_irqrestore(&tx->lock, flags);
+
+	if (!ctx)
+		return;
+
+	mctp_usblib_tx_stats_update(ctx, dev, false);
+	mctp_usblib_tx_ctx_free(ctx, reason);
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_cancel);
 
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 76f9d8879254..2e1cde6a6745 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -58,10 +58,6 @@ void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx);
 /*
  * TX handle: created by mctp_usblib_tx_push() during the tx path, and
  * may persist across multiple packet transmits.
- *
- * Currently though, there is a 1:1 mapping between packets and transfers, so
- * the tx context will be cleared over each transmit. This will change in
- * future.
  */
 struct mctp_usblib_tx_ctx;
 
@@ -76,6 +72,10 @@ struct mctp_usblib_tx_ops {
 struct mctp_usblib_tx {
 	struct mctp_usblib_tx_ops ops;
 	void *priv;
+	/* protects access to cur_ctx */
+	spinlock_t lock;
+	/* context to which we are adding packets, cleared on send */
+	struct mctp_usblib_tx_ctx *cur_ctx;
 };
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,

-- 
2.47.3


