Return-Path: <netdev+bounces-302925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9/K4MIM2Q2p/VAoAu9opvQ
	(envelope-from <netdev+bounces-302925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:22:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F326E0065
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:22:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=L9immHmb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302925-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD94E301BA40
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ADC3C10A7;
	Tue, 30 Jun 2026 03:22:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DF37B025;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789758; cv=none; b=AU+b3nuWe27GHWYEsjX3YE6F/jBD7eleWVWXse8AYzVlUyil7URSfgk4+MOydEqvkS+pf+ZOa8XfRUr/gJ8+r9JbTEp3rKT5W1rPkc+imjgFcX6/S8F3hjjDByRIZpkagOHfZSU2ILVOwTXdqsAJ/h0qA/05V8zlnVjq2LZi+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789758; c=relaxed/simple;
	bh=shK4mJNMtglXzrGTewRqbTWM3fwjbOyvyTaHSBH8cSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=le2CzLUlzJlRveZAIxdLQ0ecN3JKB0pqzYcV/xBDR5Y8ZsMTSORkx2u+HFJuS+zqAX3hdF/zCnsN1qMb7R0WUtcIuyrZmir/CpwskpEgCcCNDUiAyvNM/S2Q4oB6EK3bCbGH4vtyuMhYJ3uZnY1EXiCtrnOs2ioZwgPfZ581HB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=L9immHmb; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789747;
	bh=n8oidag/bhukNRJOmJRpTQgx6GQ1U7A97uae4lIhKvU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L9immHmbLKbiSZ0jSfelqOpizaswbRJHfgeDG0423Z+gML8L5csjLyWtJ1SoM167e
	 cvOohrPPrqkqTDlvoVO8/yA3pNS4K22z4DHh7XjRvmj3DK1XN24/82P/pfNbkdmtPB
	 KtOT7xhz+WaDLp3aTgQVsj7TPWYX1x5bED5yJt3Izt03+dNcMUT84KNR6GHwjt2As5
	 rfa2RvyT3zy8ZQYCmZCdYtG6+uoyBojMc8/VtkReg3y4yiYdVB96KxnhGKHdUy0G26
	 HeRfl8PrDo2wjEMc/M1kgIyEzm4ItqEuhYuzB2lPIPlAaZrAGGhF5nIGL6i4pLFkxL
	 JRvk+xRMo96cQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 86552660F2; Tue, 30 Jun 2026 11:22:27 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:27 +0800
Subject: [PATCH net-next 06/12] net: mctp: usblib: Add support for
 multi-packet transmit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-6-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-302925-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33F326E0065

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
 drivers/net/mctp/mctp-usblib.c | 242 +++++++++++++++++++++++++++++++++--------
 include/linux/usb/mctp-usb.h   |   4 +
 2 files changed, 202 insertions(+), 44 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 56eca496bbe4..a8491ec04df3 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -165,11 +165,13 @@ EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
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
@@ -179,52 +181,123 @@ void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
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
+	return mctp_usblib_tx_avail(ctx) < (68 + sizeof(struct mctp_usb_hdr));
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
+
+		buf = ctx->buf;
+	} else {
+		return -EINVAL;
+	}
 
-	return tx->ops.send(ctx, buf, ctx->len);
+	return ctx->tx->ops.send(ctx, buf, ctx->len);
 }
 
 static void mctp_usblib_tx_ctx_free(struct mctp_usblib_tx_ctx *ctx)
 {
-	if (ctx)
-		dev_kfree_skb_any(ctx->skb);
+	struct sk_buff *skb;
+
+	if (!ctx)
+		return;
+
+	while ((skb = __skb_dequeue(&ctx->skbs)) != NULL)
+		dev_kfree_skb_any(skb);
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
+	if (tx->cur_ctx)
+		mctp_usblib_tx_ctx_free(tx->cur_ctx);
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
+	ctx->len += skb->len;
+	skb_queue_head_init(&ctx->skbs);
+	__skb_queue_tail(&ctx->skbs, skb);
+
+	return ctx;
+}
+
 static void mctp_usblib_tx_stats_update(struct mctp_usblib_tx_ctx *ctx,
 					struct net_device *dev,
 					bool ok)
@@ -234,10 +307,10 @@ static void mctp_usblib_tx_stats_update(struct mctp_usblib_tx_ctx *ctx,
 
 	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
 	if (ok) {
-		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_packets, ctx->skbs.qlen);
 		u64_stats_add(&dstats->tx_bytes, ctx->len);
 	} else {
-		u64_stats_inc(&dstats->tx_drops);
+		u64_stats_add(&dstats->tx_drops, ctx->skbs.qlen);
 	}
 	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
 	put_cpu_ptr(dev->dstats);
@@ -294,8 +367,8 @@ static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb)
 }
 
 /*
- * Push a new skb to the transfer. At present, no send must be in progress,
- * as we only handle single-packet USB transfers.
+ * Push a new skb to the transfer. May result in zero or more calls to
+ * ops->send().
  *
  * Takes ownership of @skb, including on error.
  */
@@ -303,34 +376,104 @@ int mctp_usblib_tx_push(struct net_device *dev,
 			struct mctp_usblib_tx *tx,
 			struct sk_buff *skb, bool more)
 {
-	struct mctp_usblib_tx_ctx *ctx;
-	int rc;
+	struct mctp_usblib_tx_ctx *ctx, *send_ctx = NULL;
+	const int max_tries = 3;
+	unsigned long flags;
+	int try = 1, rc;
+
+	rc = mctp_usblib_tx_skb_prepare(skb);
+	if (rc) {
+		mctp_usblib_tx_stats_single_drop(dev);
+		kfree_skb(skb);
+		/* we may still need to proceed, in case an existing ctx
+		 * is now sendable (ie.: !more).
+		 */
+		skb = NULL;
+	}
+
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
+			mctp_usblib_tx_ctx_free(send_ctx);
+		}
+		send_ctx = NULL;
+	}
 
+	/* we have either queued, or the prepare failed; nothing more to do */
 	if (!skb)
 		return 0;
 
-	rc = mctp_usblib_tx_skb_prepare(skb);
-	if (rc)
-		goto err_drop_single;
-
-	ctx = mctp_usblib_tx_ctx_create(tx, skb);
+	ctx = mctp_usblib_tx_ctx_create(tx, skb, !more);
 	if (!ctx) {
-		rc = -ENOMEM;
-		goto err_drop_single;
+		netdev_dbg(dev, "TX context create failed\n");
+		mctp_usblib_tx_stats_single_drop(dev);
+		kfree_skb(skb);
+		return -ENOMEM;
 	}
 
-	rc = mctp_usblib_tx_send(ctx);
-	if (rc) {
-		mctp_usblib_tx_stats_update(ctx, dev, false);
-		mctp_usblib_tx_ctx_free(ctx);
+	/* if we're ready to send now, no need to enqueue */
+	if (!more || mctp_usblib_tx_should_send(ctx)) {
+		rc = mctp_usblib_tx_send(ctx);
+		if (rc) {
+			mctp_usblib_tx_stats_update(ctx, dev, false);
+			mctp_usblib_tx_ctx_free(ctx);
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
-	kfree_skb(skb);
-	return rc;
+	/* we may have lost the race with a concurrent tx; shouldn't happen, as
+	 * ndo_start_xmit should be serialised over one queue, but try again
+	 * from the top, as we may be able to queue the skb to that context.
+	 */
+	if (ctx) {
+		/* unlink the new (sole) skb, we don't want it freed with ctx */
+		__skb_queue_head_init(&ctx->skbs);
+		mctp_usblib_tx_ctx_free(ctx);
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
 
@@ -338,7 +481,18 @@ EXPORT_SYMBOL_GPL(mctp_usblib_tx_push);
 void mctp_usblib_tx_cancel(struct mctp_usblib_tx *tx,
 			   struct net_device *dev)
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
+	mctp_usblib_tx_ctx_free(ctx);
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_cancel);
 
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 9fe314c2551e..56a4aef1f7d0 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -76,6 +76,10 @@ struct mctp_usblib_tx_ops {
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


