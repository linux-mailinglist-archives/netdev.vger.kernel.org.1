Return-Path: <netdev+bounces-305735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0/xHe8gTmoPDwIAu9opvQ
	(envelope-from <netdev+bounces-305735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D2F724069
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:05:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=EXsPvVwd;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305735-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305735-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953F7302AD0F
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6F379EFE;
	Wed,  8 Jul 2026 09:59:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF11377EC5;
	Wed,  8 Jul 2026 09:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504791; cv=none; b=IJ/7VfjBfV6NWyuWlIU9SgaGs1NXQ/WCYmdrrpYrDGrNAcF2QSObKbw0jJR7d9UPw2eKlRhp/Q3nu3JW53l910rUqzy2tdtohyUEl2j1GSO3JuXZj0MqFbg8XndGfVmrGXBphAZxhlyxEcBF8TZNmqQ9y6Eoy2yOK2JesS99/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504791; c=relaxed/simple;
	bh=JJDqb+QYIrzkUFHCjuAHhY+kICr+yewKLzrGB/+PSeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+Uapd02hAeW9syvGVqPueTmCS0cIbcddUgVjpINR97caARDz+2v1WRFNR+V45thg2Pj7Nni0OSL37JQVN/+QxriMv2w8MU9i2O+kZwbgJ+Zm7zrKWTxMTqyOUAsnTr2HjXV2FDRFhN5snPYMWXRQ9zYO/MjAe12TsrhFWDLwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EXsPvVwd; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504788;
	bh=10byGrDBUYzD4vHT2KKk0ZCCXHuZx1Ictsu4qzZcgms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EXsPvVwdAmEdVM3iJ2LPnNajLjP0VpXPB/VgUEAkhSZcgcBsuIEnMv6X+Smu1tbPP
	 VLbEFmhqkNdEMSs7p7CLhdhKZl2D/FVibRTjyywYEbyUl9W3okLtkvjzd0ntJtdLYm
	 qJHIbGMIP5QPH+K6FU6UauBbf3bdKNyBWI3c5WpY4dxatXq5PTYYrqzMkMy+HsRLyT
	 cTzSzl5CEMtb/rg9N0yXyJd1vtMJPyluyP+66hs/3uzrFKiZC1G88eLCZGwq/VoOTl
	 vXu3i2zrStlqCWiIOrffPliovoQrlzfqxK2dNaMSGTdZ3Tq7rTGDT1obt9yRYsPga6
	 EXQunUtvPfN9Q==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 9BC7866526; Wed,  8 Jul 2026 17:59:48 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:40 +0800
Subject: [PATCH net-next v3 09/12] net: mctp: usblib: Implement
 transmit-side packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-9-9e710155cdbf@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5D2F724069

Add support for packet spanning as defined in DSP0283 v1.1.

With the existing v1.0 implementation of multi-packet transfers, all we
need here is to adjust the buffer sizes to suit v1.1.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c    |  2 +-
 drivers/net/mctp/mctp-usblib.c | 28 +++++++++++++++++++---------
 include/linux/usb/mctp-usb.h   |  4 +++-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 644e7f88ce8b..0507307c875f 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -321,7 +321,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize), false);
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index dad876c4da68..4131be31db1a 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -239,7 +239,7 @@ EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
 struct mctp_usblib_tx_ctx {
 	struct mctp_usblib_tx *tx;
 	struct sk_buff_head skbs;
-	unsigned int len;
+	unsigned int buf_len, len;
 	enum mctp_usblib_tx_buf_type {
 		TX_SINGLE,
 		TX_FLAT,
@@ -249,18 +249,19 @@ struct mctp_usblib_tx_ctx {
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
 			 const struct mctp_usblib_tx_ops *ops,
-			 void *priv)
+			 void *priv, bool span)
 {
 	memset(tx, 0, sizeof(*tx));
 	tx->ops = *ops;
 	tx->priv = priv;
+	tx->span = span;
 	spin_lock_init(&tx->lock);
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_init);
 
 static int mctp_usblib_tx_avail(struct mctp_usblib_tx_ctx *ctx)
 {
-	return ctx->buf_type == TX_SINGLE ? 0 : MCTP_USB_1_0_XFER_SIZE - ctx->len;
+	return ctx->buf_type == TX_SINGLE ? 0 : ctx->buf_len - ctx->len;
 }
 
 static bool mctp_usblib_tx_should_send(struct mctp_usblib_tx_ctx *ctx)
@@ -349,6 +350,12 @@ void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_fini);
 
+/* Max size of a spanned TX. Since we allocate a separate span buffer, limit
+ * the tx-time allocations to 4k. Larger packets will be sent as single
+ * transfers.
+ */
+static const unsigned int TX_SPAN_MAX = 4096 - sizeof(struct mctp_usblib_tx_ctx);
+
 static struct mctp_usblib_tx_ctx *
 mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 			  bool single)
@@ -357,11 +364,11 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 	struct mctp_usblib_tx_ctx *ctx;
 	size_t sz = 0;
 
-	if (single) {
+	if (single || skb->len > TX_SPAN_MAX) {
 		type = TX_SINGLE;
 	} else {
 		type = TX_FLAT;
-		sz = MCTP_USB_1_0_XFER_SIZE;
+		sz = tx->span ? TX_SPAN_MAX : MCTP_USB_1_0_XFER_SIZE;
 	}
 
 	ctx = kzalloc_flex(*ctx, buf, sz, GFP_ATOMIC);
@@ -370,6 +377,7 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 
 	ctx->tx = tx;
 	ctx->buf_type = type;
+	ctx->buf_len = sz;
 	ctx->len = skb->len;
 	skb_queue_head_init(&ctx->skbs);
 	__skb_queue_tail(&ctx->skbs, skb);
@@ -434,15 +442,17 @@ EXPORT_SYMBOL_GPL(mctp_usblib_tx_send_complete);
  *
  * On error, populates @reason.
  */
-static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb,
+static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb, bool span,
 				      enum skb_drop_reason *reason)
 {
+	unsigned long plen, max_len;
 	struct mctp_usb_hdr *hdr;
-	unsigned long plen;
 	int rc;
 
+	max_len = span ? MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;
+
 	plen = skb->len;
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX) {
+	if (plen + sizeof(*hdr) > max_len) {
 		*reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		return -EMSGSIZE;
 	}
@@ -481,7 +491,7 @@ int mctp_usblib_tx_push(struct net_device *dev,
 	unsigned long flags;
 	int try = 1, rc;
 
-	rc = mctp_usblib_tx_skb_prepare(skb, &reason);
+	rc = mctp_usblib_tx_skb_prepare(skb, tx->span, &reason);
 	if (rc) {
 		mctp_usblib_tx_stats_single_drop(dev);
 		kfree_skb_reason(skb, reason);
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index c8fe22d7f68e..35cc2cc15f9a 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -81,6 +81,7 @@ struct mctp_usblib_tx_ops {
 struct mctp_usblib_tx {
 	struct mctp_usblib_tx_ops ops;
 	void *priv;
+	bool span;
 	/* protects access to cur_ctx */
 	spinlock_t lock;
 	/* context to which we are adding packets, cleared on send */
@@ -88,7 +89,8 @@ struct mctp_usblib_tx {
 };
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
-			 const struct mctp_usblib_tx_ops *ops, void *priv);
+			 const struct mctp_usblib_tx_ops *ops, void *priv,
+			 bool span);
 void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx);
 
 void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx);

-- 
2.47.3


