Return-Path: <netdev+bounces-302929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mxm6Opc2Q2qSVAoAu9opvQ
	(envelope-from <netdev+bounces-302929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:23:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DD6E0087
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:23:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=WTqpN32J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302929-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B4A93025A47
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33393D9023;
	Tue, 30 Jun 2026 03:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA37B3FE;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789759; cv=none; b=GXhEewiN3kKytPvnLB88lRZFvQkjF6ZEzQO1R817HMoTvkmhhOiQ4pSLgsbBG+MURHLwQHPdqsF7fvJ76DWVIQ5xNpAVTGQlxQdOFU6yu7/doQjQg29OdO4ekXdqd0u+aINMNajwejlBFZ38xkjx9Qu5pGN38U3X9plP+Dlb2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789759; c=relaxed/simple;
	bh=1tqCYrfxlkiW0Yvx6XadNQzRu9uqIA914m5QF6m2MCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EN6Lr1qd9iYJc9/tbbajir/DQsUSEKqFteDb5H8MIca92l04ZPvLIbwuTKsv+6gdEX2HerA3MbhQAk/Cc1sWi6blaYnYiMc3p/RiOiySzuSzKvPIg/RHhvdx5NIDQLJoX11t+pIyF/kE3h9QVG3G4QMSOVUNoNGAXHoR6gLZz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WTqpN32J; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789748;
	bh=NCOo+o5/Qa83/RFOxQME+CtTWm5U7Ue1c/eJJIr5LFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WTqpN32JlQfx1ePNXY+cfMhvFsl9hfqSB5Qv7kzZDQMh2lx7b6s+1zplmBPi/5G+n
	 BW17PgA1EcA43jhw+FXeV+aWtRgZO1lIiON99lDK+yZtGmVmEayZtIU/13h1bcXZTA
	 DT+YdwoGd/3WNqYeC3pOC5+olOcMa5ZZt+ArPI/IluNxzg6Uj+l2vT3F/ENsGV3eJn
	 ESeBfKp3uMCAjT88nkoCY62bddegFfiTEh9aqF6/IW13rtDlxN6K4Uex/lXclC9Uuv
	 QopQEgpUDkv9fmeP2hdttNHAhfeKc7pCW4snQSTJk92pcAJeNdZRqa1CB7JwGUvIY+
	 ZQ3igcLKFGjYQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 5A17B660F5; Tue, 30 Jun 2026 11:22:28 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:30 +0800
Subject: [PATCH net-next 09/12] net: mctp: usblib: Implement transmit-side
 packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-9-86a311fc67b7@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-302929-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 687DD6E0087

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
index c89588741855..91109ad17d1c 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -276,7 +276,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	mctp_usblib_rx_init(&dev->rx, false);
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index a1649f24d937..dbc056bfd627 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -206,7 +206,7 @@ EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
 struct mctp_usblib_tx_ctx {
 	struct mctp_usblib_tx *tx;
 	struct sk_buff_head skbs;
-	unsigned int len;
+	unsigned int buf_len, len;
 	enum mctp_usblib_tx_buf_type {
 		TX_SINGLE,
 		TX_FLAT,
@@ -216,18 +216,19 @@ struct mctp_usblib_tx_ctx {
 
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
@@ -310,6 +311,12 @@ void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx)
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
@@ -318,11 +325,11 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
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
@@ -331,6 +338,7 @@ mctp_usblib_tx_ctx_create(struct mctp_usblib_tx *tx, struct sk_buff *skb,
 
 	ctx->tx = tx;
 	ctx->buf_type = type;
+	ctx->buf_len = sz;
 	ctx->len += skb->len;
 	skb_queue_head_init(&ctx->skbs);
 	__skb_queue_tail(&ctx->skbs, skb);
@@ -381,14 +389,16 @@ void mctp_usblib_tx_send_complete(struct mctp_usblib_tx_ctx *tx_ctx,
 EXPORT_SYMBOL_GPL(mctp_usblib_tx_send_complete);
 
 /* Prepare a skb for push() */
-static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb)
+static int mctp_usblib_tx_skb_prepare(struct sk_buff *skb, bool span)
 {
+	unsigned long plen, max_len;
 	struct mctp_usb_hdr *hdr;
-	unsigned long plen;
 	int rc;
 
+	max_len = span ? MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;
+
 	plen = skb->len;
-	if (plen + sizeof(*hdr) > MCTP_USB_1_0_PKTLEN_MAX)
+	if (plen + sizeof(*hdr) > max_len)
 		return -EMSGSIZE;
 
 	rc = skb_cow_head(skb, sizeof(*hdr));
@@ -420,7 +430,7 @@ int mctp_usblib_tx_push(struct net_device *dev,
 	unsigned long flags;
 	int try = 1, rc;
 
-	rc = mctp_usblib_tx_skb_prepare(skb);
+	rc = mctp_usblib_tx_skb_prepare(skb, tx->span);
 	if (rc) {
 		mctp_usblib_tx_stats_single_drop(dev);
 		kfree_skb(skb);
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 00c538a8e211..61fb36f34525 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -84,6 +84,7 @@ struct mctp_usblib_tx_ops {
 struct mctp_usblib_tx {
 	struct mctp_usblib_tx_ops ops;
 	void *priv;
+	bool span;
 	/* protects access to cur_ctx */
 	spinlock_t lock;
 	/* context to which we are adding packets, cleared on send */
@@ -91,7 +92,8 @@ struct mctp_usblib_tx {
 };
 
 void mctp_usblib_tx_init(struct mctp_usblib_tx *tx,
-			 const struct mctp_usblib_tx_ops *ops, void *priv);
+			 const struct mctp_usblib_tx_ops *ops, void *priv,
+			 bool span);
 void mctp_usblib_tx_fini(struct mctp_usblib_tx *tx);
 
 void *mctp_usblib_tx_ctx_priv(struct mctp_usblib_tx_ctx *tx_ctx);

-- 
2.47.3


