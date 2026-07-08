Return-Path: <netdev+bounces-305734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zc73BNggTmoJDwIAu9opvQ
	(envelope-from <netdev+bounces-305734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EE72405A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:05:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=j9M9HLzs;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305734-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305734-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283BB302A6CB
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F18379EFE;
	Wed,  8 Jul 2026 09:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B8377EC5;
	Wed,  8 Jul 2026 09:59:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504776; cv=none; b=WVX48Twp4ASi0PXe/jVe9pOXMPbwkz7IY16REEfpu2JoXYi8yIHcE/q/quk5al4bWp6v18t0uF0T1mRCSbQ3kCx+SILYN2yIlJmtf/m2o8SXlx4pZWSzqH7iDe3m2GrLjCKeEA++RX5f5fqZCGbgBb6TjBo3nE4ZcHIyFqJuK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504776; c=relaxed/simple;
	bh=1+X9sMAq/T8f9PWIJoZJfSrRKxDM3KCMLpmQ/n6xwJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vdwu7SZCx9ZimWFtN1ikd+tcFmQVy9skIyM/HC0xfjRFQlVGpwrTG3rzWX4DkXY0pXL+xGQizTYWSC5oZ/TGhj6GK3KSXh5mfU651F0VQXJHA528Nb/zfF0HGxhEzHWoh4pbGA/UMDGHe/5Io8of4xMGWpmw+ngowbXNbDHsEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j9M9HLzs; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504773;
	bh=oQ7Lby2vNJz2oK/rmIU9qqILJ8h5gazOnhVdh3FlgGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j9M9HLzs/WVJjvOO9TW+IHB+TFrHsaBe0ZNSA874DOEf+01tKTpIm2eLHmAKUEH4t
	 fhIJN3yNg8hPXa+sXpYCv5seSUMTwBvTZTQ3cJ9jk8DB/Wn+Q7y/KjI+Iwu+FyKsOa
	 n+XacCotxWkyK+5KBjdGneCfeKxWR3BSd3fHdrH9wg13KrU+kbeUpgNvxN1g0dFTf4
	 SMIbQBAhHO2d9tPQxzBnqxHAfrTx/qS8KeV5hEHuLm67z+EV9puuHe4fpw5JVS2D5e
	 NosR7s1ohttKIzKd5hj6JvweZ98r/Lv2KC0/PdjtgJBaMlUVvbKfZfqKnJ5njdbl+p
	 +TuzvBZ+SrcKw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0CE3866526; Wed,  8 Jul 2026 17:59:33 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 08 Jul 2026 17:58:39 +0800
Subject: [PATCH net-next v3 08/12] net: mctp: usblib: Implement
 receive-side packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dev-mctp-usb-1-1-v3-8-9e710155cdbf@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-305734-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D9EE72405A

Using the existing prepare/complete API, we can persist the rx skb
across receives to implement v1.1 packet spanning.

Alter the packet-extraction loop to allow truncated packets, returning
early with the skb persisted for the next IN urb completion. When we see
we have a complete packet, netif_rx() that. If the packet boundary
aligns with the urb completion, we can netif_rx() the whole thing.

One subtle change: the mctp_usblib_rx() helper now handles skbs with the
full transport header, so we shift the skb_pull() for the header data to
the helper, before doing the rx_bytes stats update.

We still need to handle non-spanning mode, so error out on
truncated-packet cases there.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v3:
 - only expand skb if cloned or under min xfer size, preventing excessive
   reallocation
 - align rx len to ep pktlen.
v2:
 - note change in semantics for mctp_usblib_rx
 - reject rx packets too short for a MCTP header, rather than deferring
   to the MCTP core do do so
---
 drivers/net/mctp/mctp-usb.c    |   2 +-
 drivers/net/mctp/mctp-usblib.c | 158 ++++++++++++++++++++++++++++-------------
 include/linux/usb/mctp-usb.h   |   6 +-
 3 files changed, 114 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index ef58703040d6..644e7f88ce8b 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -320,7 +320,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx);
+	mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize), false);
 	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
 	init_usb_anchor(&dev->tx_anchor);
 
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index d58178f47c06..dad876c4da68 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -3,7 +3,7 @@
  * mctp-usblib.c - MCTP-over-USB (DMTF DSP0283) transport helper library
  *
  * DSP0283 is available at:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
  * Copyright (C) 2024-2026 Code Construct Pty Ltd
  */
@@ -14,9 +14,11 @@
 #include <linux/usb/mctp-usb.h>
 #include <net/mctp.h>
 
-void mctp_usblib_rx_init(struct mctp_usblib_rx *rx)
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx, u16 ep_pktlen, bool span)
 {
 	memset(rx, 0, sizeof(*rx));
+	rx->span = span;
+	rx->ep_pktlen = ep_pktlen;
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_rx_init);
 
@@ -34,15 +36,51 @@ int mctp_usblib_rx_prepare(struct net_device *netdev,
 			   struct mctp_usblib_rx *rx,
 			   void **bufp, size_t *lenp, gfp_t gfp)
 {
-	const unsigned int len = MCTP_USB_1_0_XFER_SIZE;
-	struct sk_buff *skb;
+	struct sk_buff *skb = rx->skb;
+	unsigned int len = 0;
 
-	skb = __netdev_alloc_skb(netdev, len, gfp);
-	if (!skb)
-		return -ENOMEM;
+	if (skb && skb->len >= MCTP_USB_1_1_PKTLEN_MAX) {
+		/* something must have gone terribly wrong. clear and restart */
+		mctp_usblib_rx_cancel(rx);
+		skb = NULL;
+	}
+
+	len = rx->span ? ALIGN(MCTP_USB_1_1_PKTLEN_MAX, rx->ep_pktlen)
+		: MCTP_USB_1_0_XFER_SIZE;
+
+	if (!skb) {
+		skb = __netdev_alloc_skb(netdev, len, gfp);
+		if (!skb)
+			return -ENOMEM;
+
+	} else if (skb->cloned || skb_tailroom(skb) < rx->ep_pktlen) {
+		/* We always need to realloc if ->cloned, as we cannot
+		 * resubmit the (now-shared) skb buffer for possible DMA.
+		 *
+		 * Otherwise (if we have an un-cloned SKB): just ensure we
+		 * have sufficient space to prevent babble. Since we allocated
+		 * for max size in the last prepare (and have not consumed any
+		 * of that space for a prior MCTP packet, because !cloned), we
+		 * have sufficient data to finish the current MCTP packet.
+		 */
+		struct sk_buff *skb2;
+
+		skb2 = skb_copy_expand(skb, 0, len, gfp);
+		if (!skb2)
+			return -ENOMEM;
+		dev_kfree_skb_any(skb);
+		skb = skb2;
+	}
 
 	rx->skb = skb;
 
+	/* Spanning mode allows ZLPs, so we don't require exactly one
+	 * transfer packet. If we have extra tailroom, may as well use it,
+	 * and we have ensured that the tailroom >= ep_pktlen.
+	 */
+	if (rx->span)
+		len = ALIGN_DOWN(skb_tailroom(skb), rx->ep_pktlen);
+
 	*bufp = skb_tail_pointer(skb);
 	*lenp = len;
 
@@ -56,6 +94,9 @@ static void mctp_usblib_rx(struct net_device *netdev, struct sk_buff *skb)
 	struct mctp_skb_cb *cb;
 	unsigned long flags;
 
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_usb_hdr));
+
 	/* we're called from an URB completion handler, and cannot assume local
 	 * irqs are always disabled
 	 */
@@ -96,72 +137,89 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 
 	__skb_put(skb, len);
 
-	while (skb) {
-		struct sk_buff *skb2 = NULL;
+	for (;;) {
 		struct mctp_usb_hdr *hdr;
-		u16 hdr_len;
-		/* length of MCTP packet, no USB header */
-		u8 pkt_len;
-
-		skb_reset_mac_header(skb);
-		hdr = skb_pull_data(skb, sizeof(*hdr));
-		if (!hdr) {
-			rc = -ENOMSG;
+		struct sk_buff *skb2;
+		/* length of MCTP packet, including USB header */
+		u16 pkt_len;
+
+		/* no header yet, resubmit for the rest of the packet */
+		if (skb->len < sizeof(*hdr)) {
+			if (!rx->span) {
+				netdev_dbg(netdev,
+					   "rx: tiny xfer (%d) in non-span mode",
+					   skb->len);
+				rc = -ENOMSG;
+				goto err_reset;
+			}
 			break;
 		}
 
+		hdr = (struct mctp_usb_hdr *)skb->data;
+
 		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {
+			/* By resetting here, will start the next IN transfer
+			 * at the beginning of the new skb. This will mean
+			 * we re-sync when we next see a spanned packet aligned
+			 * with the start of a transfer.
+			 *
+			 * In non-spanning mode, this just means we'll drop
+			 * the current transfer only
+			 */
 			netdev_dbg(netdev, "rx: invalid id %04x\n",
 				   be16_to_cpu(hdr->id));
 			rc = -EPROTO;
-			break;
+			goto err_reset;
 		}
 
-		hdr_len = be16_to_cpu(hdr->len) & MCTP_USB_1_0_PKTLEN_MAX;
-
-		if (hdr_len <
-		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
-			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
-				   hdr_len);
+		pkt_len = be16_to_cpu(hdr->len);
+		/* v1.1, with span enabled, has a 13-bit length */
+		pkt_len &= rx->span ?
+			MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;
+		if (pkt_len < sizeof(*hdr) + sizeof(struct mctp_hdr)) {
+			netdev_dbg(netdev, "rx: invalid len %d\n", pkt_len);
 			rc = -EPROTO;
-			break;
+			goto err_reset;
 		}
 
-		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
-		pkt_len = hdr_len - sizeof(struct mctp_usb_hdr);
+		/* span continues to the next transfer, resubmit */
 		if (pkt_len > skb->len) {
-			rc = -EPROTO;
-			netdev_dbg(netdev,
-				   "rx: short packet (xfer) %d, actual %d\n",
-				   hdr_len, skb->len);
+			if (!rx->span) {
+				netdev_dbg(netdev,
+					   "rx: short xfer (%d vs %d) in non-span mode",
+					   pkt_len, skb->len);
+				rc = -ENOMSG;
+				goto err_reset;
+			}
 			break;
 		}
 
-		if (pkt_len < skb->len) {
-			/* more packets may follow - clone to a new
-			 * skb to use on the next iteration
-			 */
-			skb2 = skb_clone(skb, GFP_ATOMIC);
-			if (skb2) {
-				if (!skb_pull(skb2, pkt_len)) {
-					dev_kfree_skb_any(skb2);
-					skb2 = NULL;
-				}
-			} else {
-				mctp_usblib_rx_stats_single_drop(netdev);
-			}
-			skb_trim(skb, pkt_len);
+		/* we have (exactly) a complete packet, RX it directly */
+		if (pkt_len == skb->len) {
+			mctp_usblib_rx(netdev, skb);
+			rx->skb = NULL;
+			break;
 		}
 
-		mctp_usblib_rx(netdev, skb);
-		skb = skb2;
+		/* more packets follow - RX a clone so that we can continue
+		 * processing the current SKB, which may be the start of a
+		 * span.
+		 */
+		skb2 = skb_clone(skb, GFP_ATOMIC);
+		if (skb2) {
+			skb_trim(skb2, pkt_len);
+			mctp_usblib_rx(netdev, skb2);
+		} else {
+			mctp_usblib_rx_stats_single_drop(netdev);
+		}
+		skb_pull(skb, pkt_len);
 	}
 
-	if (skb)
-		dev_kfree_skb_any(skb);
+	return 0;
 
+err_reset:
+	dev_kfree_skb_any(rx->skb);
 	rx->skb = NULL;
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_rx_complete);
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 1a5e795b4ec1..c8fe22d7f68e 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -34,6 +34,8 @@ struct mctp_usb_hdr {
 #define MCTP_USB_MTU_MIN	MCTP_USB_BTU
 #define MCTP_USB_1_0_PKTLEN_MAX	U8_MAX
 #define MCTP_USB_1_0_MTU_MAX	(MCTP_USB_1_0_PKTLEN_MAX - sizeof(struct mctp_usb_hdr))
+#define MCTP_USB_1_1_PKTLEN_MAX	GENMASK(12, 0)
+#define MCTP_USB_1_1_MTU_MAX	(MCTP_USB_1_1_PKTLEN_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
 /* mctp-usblib */
@@ -46,9 +48,11 @@ struct mctp_usb_hdr {
  */
 struct mctp_usblib_rx {
 	struct sk_buff *skb;
+	u16 ep_pktlen;
+	bool span;
 };
 
-void mctp_usblib_rx_init(struct mctp_usblib_rx *rx);
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx, u16 ep_pktlen, bool span);
 void mctp_usblib_rx_fini(struct mctp_usblib_rx *rx);
 
 int mctp_usblib_rx_prepare(struct net_device *netdev,

-- 
2.47.3


