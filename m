Return-Path: <netdev+bounces-302935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2F0KN84Q2r1VQoAu9opvQ
	(envelope-from <netdev+bounces-302935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:32:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E096E014C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:32:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=I7afh7lp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 508F73017456
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F7233936;
	Tue, 30 Jun 2026 03:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7522F01;
	Tue, 30 Jun 2026 03:32:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782790357; cv=none; b=F2bt7SxMqIEoaWjRd8RbqxJ/3OoL2tULAHyixj4QJi1sxE6zwXHz3371fqDEa+/Zyd4HkM7mdOs2PwYYSR2lIHC/aE4RADl9GYDped88Ofj+L1msMrnI7VHivwAkbrlbRCL9D+uxeF7kulIsNw9M8URmRYwcgwGSxZtemXt/oL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782790357; c=relaxed/simple;
	bh=6YGpoGpDrGNHm4M85CvhVW/6Jisytv7xlZe0WlJgazU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbnqPv+4c2YGaR/dIIZO9+nCmvOBXq45ROZQkQtGHsb37ydYh5BEvwu0uTShQeuqRfvcZ//fPNZ/xz4YO5/pN8rsc+KPHZDWWj6CEWWjfOdFG6OPfPXa7CqrEB5vbK64InyufwRqMbh0TJvrjktASROvFXIW+gZDibiBZp2Wj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I7afh7lp; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789746;
	bh=VQvpov+wgyYYKf5j4Vx4WNiOghetMvEvKlktSvb/gQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I7afh7lpp/Ydwyyh+CSEOvYFuryB3g+3po0lbuaRSCnd7QNuO1w2FIIvfwzNOpr3V
	 Ch4p/T7XDW7VQnXT7EmC+Tez6I3H7zXLl0w8NYJ17naKT/ED6hihwdCpWlK/MOJB51
	 i8TRwG4E/v3kVEV+WCh1uGU//+PQ7G0KWpB9Y2aVTgGNv5jpMta1+bU6P7AxdmNeWJ
	 pgp9iN1baW8OFZRodjU6gUGGC3I218XtdXLVD4WCI7dyV+Vc75pDjn0LlmWIYcJ8no
	 tym/wiFJ6YRL7CC5l/2R3pFpn83s2mdsFC9jyzuOQz8ON35ocidBH3GuqKgjSq/N2l
	 jeiBs918JBJRA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E1A3B660F0; Tue, 30 Jun 2026 11:22:26 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:25 +0800
Subject: [PATCH net-next 04/12] net: mctp: usblib: Move TX transfer
 processing to mctp-usblib
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-4-86a311fc67b7@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302935-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30E096E014C

With the RX processing in mctp-usblib, add TX processing alongside.

To accommodate packed transfers in DSP0283, where a transfer may contain
multiple MCTP packets, we move to a split process for the transmit API:

 * push: create a new transmit context, and add a skb to it.

 * send: callback to the driver implementation to send the (possibly
   multi-packet) USB transfer

 * complete: update skb accounting and release the tx context

The actual multi-packet transfer implementation will be added in the
next change; no tx context persists beyond the single send at present.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c    | 125 ++++++++++++++--------------
 drivers/net/mctp/mctp-usblib.c | 180 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h   |  38 +++++++++
 3 files changed, 280 insertions(+), 63 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 531b7c994afb..385350792dd4 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -29,90 +29,82 @@ struct mctp_usb {
 	u8 ep_out;
 
 	struct mctp_usblib_rx rx;
-
-	struct urb *tx_urb;
 	struct urb *rx_urb;
 
 	/* enforces atomic access to rx_stopped and requeuing the retry work */
 	spinlock_t rx_lock;
 	bool rx_stopped;
 	struct delayed_work rx_retry_work;
+
+	struct mctp_usblib_tx tx;
+	/* protects tx_urb */
+	spinlock_t tx_lock;
+	struct urb *tx_urb;
 };
 
 static void mctp_usb_out_complete(struct urb *urb)
 {
-	struct sk_buff *skb = urb->context;
-	struct net_device *netdev = skb->dev;
-	int status;
+	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
+	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	struct net_device *netdev = mctp_usb->netdev;
+	unsigned long flags;
 
-	status = urb->status;
+	mctp_usblib_tx_send_complete(tx_ctx, netdev, urb->status == 0);
 
-	switch (status) {
-	case -ENOENT:
-	case -ECONNRESET:
-	case -ESHUTDOWN:
-	case -EPROTO:
-		dev_dstats_tx_dropped(netdev);
-		break;
-	case 0:
-		dev_dstats_tx_add(netdev, skb->len);
-		netif_wake_queue(netdev);
-		consume_skb(skb);
-		return;
-	default:
-		netdev_dbg(netdev, "unexpected tx urb status: %d\n", status);
-		dev_dstats_tx_dropped(netdev);
-	}
+	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
+	mctp_usb->tx_urb = NULL;
+	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
 
-	kfree_skb(skb);
+	usb_free_urb(urb);
+
+	netif_wake_queue(netdev);
 }
 
-static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
-				       struct net_device *dev)
+static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
+			    void *data, size_t len)
 {
-	struct mctp_usb *mctp_usb = netdev_priv(dev);
-	struct mctp_usb_hdr *hdr;
-	unsigned int plen;
+	struct mctp_usb *mctp_usb = mctp_usblib_tx_ctx_priv(tx_ctx);
+	unsigned long flags;
 	struct urb *urb;
 	int rc;
 
-	plen = skb->len;
-
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
-		goto err_drop;
-
-	rc = skb_cow_head(skb, sizeof(*hdr));
-	if (rc)
-		goto err_drop;
-
-	hdr = skb_push(skb, sizeof(*hdr));
-	if (!hdr)
-		goto err_drop;
-
-	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
-	hdr->rsvd = 0;
-	hdr->len = plen + sizeof(*hdr);
-
-	urb = mctp_usb->tx_urb;
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb)
+		return -ENOMEM;
 
 	usb_fill_bulk_urb(urb, mctp_usb->usbdev,
 			  usb_sndbulkpipe(mctp_usb->usbdev, mctp_usb->ep_out),
-			  skb->data, skb->len,
-			  mctp_usb_out_complete, skb);
+			  data, len, mctp_usb_out_complete, tx_ctx);
 
-	/* Stops TX queue first to prevent race condition with URB complete */
-	netif_stop_queue(dev);
+	netif_stop_queue(mctp_usb->netdev);
+
+	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!rc)
+		mctp_usb->tx_urb = urb;
+	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
+
 	if (rc) {
-		netif_wake_queue(dev);
-		goto err_drop;
+		netdev_dbg(mctp_usb->netdev, "TX urb submit failed, %d\n", rc);
+		usb_free_urb(urb);
+		netif_start_queue(mctp_usb->netdev);
 	}
 
-	return NETDEV_TX_OK;
+	return rc;
+}
+
+static const struct mctp_usblib_tx_ops tx_ops = {
+	.send = mctp_usb_tx_send,
+};
+
+static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct mctp_usb *mctp_usb = netdev_priv(dev);
+	bool more = netdev_xmit_more();
+
+	mctp_usblib_tx_push(dev, &mctp_usb->tx, skb, more);
 
-err_drop:
-	dev_dstats_tx_dropped(dev);
-	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
 
@@ -220,7 +212,12 @@ static int mctp_usb_stop(struct net_device *dev)
 	flush_delayed_work(&mctp_usb->rx_retry_work);
 
 	usb_kill_urb(mctp_usb->rx_urb);
+
+	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
 	usb_kill_urb(mctp_usb->tx_urb);
+	spin_unlock_irqrestore(&mctp_usb->tx_lock, flags);
+
+	mctp_usblib_tx_cancel(&mctp_usb->tx, dev);
 
 	return 0;
 }
@@ -275,31 +272,33 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
 	spin_lock_init(&dev->rx_lock);
+	spin_lock_init(&dev->tx_lock);
 	usb_set_intfdata(intf, dev);
 
 	mctp_usblib_rx_init(&dev->rx);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
 
 	dev->ep_in = ep_in->bEndpointAddress;
 	dev->ep_out = ep_out->bEndpointAddress;
 
-	dev->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	dev->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->tx_urb || !dev->rx_urb) {
+	if (!dev->rx_urb) {
 		rc = -ENOMEM;
-		goto err_free_urbs;
+		goto err_fini_rxtx;
 	}
 
 	INIT_DELAYED_WORK(&dev->rx_retry_work, mctp_usb_rx_retry_work);
 
 	rc = mctp_register_netdev(netdev, NULL, MCTP_PHYS_BINDING_USB);
 	if (rc)
-		goto err_free_urbs;
+		goto err_free_urb;
 
 	return 0;
 
-err_free_urbs:
-	usb_free_urb(dev->tx_urb);
+err_free_urb:
 	usb_free_urb(dev->rx_urb);
+err_fini_rxtx:
+	mctp_usblib_tx_fini(&dev->tx);
 	mctp_usblib_rx_fini(&dev->rx);
 	free_netdev(netdev);
 	return rc;
@@ -311,7 +310,7 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 
 	mctp_unregister_netdev(dev->netdev);
 	mctp_usblib_rx_fini(&dev->rx);
-	usb_free_urb(dev->tx_urb);
+	mctp_usblib_tx_fini(&dev->tx);
 	usb_free_urb(dev->rx_urb);
 	free_netdev(dev->netdev);
 }
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index 9b86eb4310ce..56eca496bbe4 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -162,6 +162,186 @@ void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx)
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
 
+/* transmit context: encapsulates one transfer */
+struct mctp_usblib_tx_ctx {
+	struct mctp_usblib_tx *tx;
+	struct sk_buff *skb;
+	unsigned int len;
+	enum mctp_usblib_tx_buf_type {
+		TX_SINGLE,
+	} buf_type;
+};
+
+void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
+			 const struct mctp_usblib_tx_ops *ops,
+			 void *priv)
+{
+	memset(tx, 0, sizeof(*tx));
+	tx->ops = *ops;
+	tx->priv = priv;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_init);
+
+void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
+{
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_fini);
+
+void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx)
+{
+	return tx_ctx->tx->priv;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_ctx_priv);
+
+static struct mctp_usblib_tx_ctx *
+mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb)
+{
+	struct mctp_usblib_tx_ctx *ctx;
+
+	ctx = kzalloc_obj(*ctx, GFP_ATOMIC);
+	if (!ctx)
+		return NULL;
+
+	ctx->tx = tx;
+	ctx->buf_type = TX_SINGLE;
+	ctx->skb = skb;
+	ctx->len += skb->len;
+
+	return ctx;
+}
+
+static int mctp_usblib_tx_send(struct mctp_usblib_tx_ctx *ctx)
+{
+	struct mctp_usblib_tx *tx = ctx->tx;
+	void *buf = ctx->skb->data;
+
+	return tx->ops.send(ctx, buf, ctx->len);
+}
+
+static void mctp_usblib_tx_ctx_free(struct mctp_usblib_tx_ctx *ctx)
+{
+	if (ctx)
+		dev_kfree_skb_any(ctx->skb);
+	kfree(ctx);
+}
+
+static void mctp_usblib_tx_stats_update(struct mctp_usblib_tx_ctx *ctx,
+					struct net_device *dev,
+					bool ok)
+{
+	struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
+	unsigned long flags;
+
+	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
+	if (ok) {
+		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_bytes, ctx->len);
+	} else {
+		u64_stats_inc(&dstats->tx_drops);
+	}
+	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
+	put_cpu_ptr(dev->dstats);
+}
+
+static void mctp_usblib_tx_stats_single_drop(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
+	unsigned long flags;
+
+	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_drops);
+	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
+	put_cpu_ptr(dev->dstats);
+}
+
+/*
+ * Completion for the ->send() op. This will update netdev stats and
+ * free the tx context.
+ *
+ * Likely called from (atomic) URB completion context.
+ */
+void mctp_usblib_tx_send_complete(struct mctp_usblib_tx_ctx *tx_ctx,
+				  struct net_device *dev, bool ok)
+{
+	mctp_usblib_tx_ctx_free(tx_ctx);
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_send_complete);
+
+/* Prepare a skb for push() */
+static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb)
+{
+	struct mctp_usb_hdr *hdr;
+	unsigned long plen;
+	int rc;
+
+	plen = skb->len;
+	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
+		return -EMSGSIZE;
+
+	rc = skb_cow_head(skb, sizeof(*hdr));
+	if (rc)
+		return rc;
+
+	hdr = skb_push(skb, sizeof(*hdr));
+	if (!hdr)
+		return -ENOMEM;
+
+	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
+	hdr->rsvd = 0;
+	hdr->len = plen + sizeof(*hdr);
+
+	return 0;
+}
+
+/*
+ * Push a new skb to the transfer. At present, no send must be in progress,
+ * as we only handle single-packet USB transfers.
+ *
+ * Takes ownership of @skb, including on error.
+ */
+int mctp_usblib_tx_push(struct net_device *dev,
+			struct mctp_usblib_tx *tx,
+			struct sk_buff *skb, bool more)
+{
+	struct mctp_usblib_tx_ctx *ctx;
+	int rc;
+
+	if (!skb)
+		return 0;
+
+	rc = mctp_usblib_tx_skb_prepare(skb);
+	if (rc)
+		goto err_drop_single;
+
+	ctx = mctp_usblib_tx_ctx_create(tx, skb);
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto err_drop_single;
+	}
+
+	rc = mctp_usblib_tx_send(ctx);
+	if (rc) {
+		mctp_usblib_tx_stats_update(ctx, dev, false);
+		mctp_usblib_tx_ctx_free(ctx);
+	}
+
+	return rc;
+
+err_drop_single:
+	mctp_usblib_tx_stats_single_drop(dev);
+	kfree_skb(skb);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_push);
+
+/* Cancel a tx: any un-sent context is released. */
+void mctp_usblib_tx_cancel(struct mctp_usblib_tx *tx,
+			   struct net_device *dev)
+{
+	/* nothing to do at present, no ctx is persistent */
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_tx_cancel);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 MODULE_DESCRIPTION("MCTP USB transport library");
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 595e6af16dd0..9fe314c2551e 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -55,4 +55,42 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 
 void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx);
 
+/*
+ * TX handle: created by mctp_usblib_tx_push() during the tx path, and
+ * may persist across multiple packet transmits.
+ *
+ * Currently though, there is a 1:1 mapping between packets and transfers, so
+ * the tx context will be cleared over each transmit. This will change in
+ * future.
+ */
+struct mctp_usblib_tx_ctx;
+
+struct mctp_usblib_tx_ops {
+	/* Start a USB TX for @data. On returning success, the implementation
+	 * must arrange for mctp_usblib_tx_send_complete() to be called at some
+	 * later point (eg., on urb completion).
+	 */
+	int (*send)(struct mctp_usblib_tx_ctx *tx_ctx, void *data, size_t len);
+};
+
+struct mctp_usblib_tx {
+	struct mctp_usblib_tx_ops ops;
+	void *priv;
+};
+
+void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
+			 const struct mctp_usblib_tx_ops *ops, void *priv);
+void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx);
+
+void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx);
+
+int mctp_usblib_tx_push(struct net_device *dev,
+			struct mctp_usblib_tx *tx,
+			struct sk_buff *skb, bool more);
+
+void mctp_usblib_tx_send_complete(struct mctp_usblib_tx_ctx *tx_ctx,
+				  struct net_device *dev, bool ok);
+
+void mctp_usblib_tx_cancel(struct mctp_usblib_tx *tx, struct net_device *dev);
+
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3


