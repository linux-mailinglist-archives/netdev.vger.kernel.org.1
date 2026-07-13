Return-Path: <netdev+bounces-307211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WIN7H834VGrbiAAAu9opvQ
	(envelope-from <netdev+bounces-307211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:40:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87574C80C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:40:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=fDYiYvsd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307211-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307211-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D83D230719F1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8C43B6CE;
	Mon, 13 Jul 2026 14:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564143B3DC;
	Mon, 13 Jul 2026 14:33:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953195; cv=none; b=G5hjJ9zKqP/R4Noqb0JCPBS6RTOYYbCHHcoFsBJHshXJRkbfnTAFyMYvg5DuS2POrLQHhiXBh7e0tTlJoe8hsYyLAqdJdQPPegzRaGXWZatOY59UuKIkwUf7ItJROaA9MtmlO7V4VyqNc6ZZmokMw1/vP1eY2GbcFh5Ss0/mjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953195; c=relaxed/simple;
	bh=rllhw7Uus8m+fjKyheFKTqzRmm9TuH3IJD/b3l1hmqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxtKrV5ySO9rWSYIgLW3qSLHVEG6teiKcV6M2dTe2KjuOn76nuN3CoMjhNQgw4ZGT9sypBNNlplvy4mLu3tF+aFgs8X8UxHMSYXQuu836+/FPekaxe+blsmPNdQ3feDWCRrug6oba1dTCTm6P4MfYqD9oLtefKqXf6mYSwDvHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fDYiYvsd; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783953183;
	bh=L1mTsX5Xi1rwyuge70AKJFQmaEKAk//V1DkqDf3Knsc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fDYiYvsdlyH6XGAaYGu/YV9JUeYDMyknj4B9cT3NIgFjYYgjSDG78QP9IKnma/kHB
	 2G5lXeEyJ2xHq47KNwxgwNczdo22MsZapr4bmabxtLA9LDzfNEw8jYZysSkc8lasPX
	 i+Wz+Onw6vsMS1HRcGD0r6fsPDeMExGnOzx2HCffVYi2pR9L+bVsXSqCvhM/8Okb1A
	 ui9tY50rhFGg2hs568lvzoxbfvpAts0GEGSEf+RvjngVVMqOR7GzHKX4GNNuqVsMHS
	 n8oVc1kbvw/d6YxfbT8zYE/HQxUMjZ6IG2wnWfp80BQ4Uz3SRjKWZPw9MI9fI76LLC
	 h2Ublv0plGhxA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 71BE66561D; Mon, 13 Jul 2026 22:33:03 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Jul 2026 22:33:01 +0800
Subject: [PATCH net-next v4 08/12] net: mctp: usblib: Implement
 receive-side packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-dev-mctp-usb-1-1-v4-8-4ae8de764a01@codeconstruct.com.au>
References: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
In-Reply-To: <20260713-dev-mctp-usb-1-1-v4-0-4ae8de764a01@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307211-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,codeconstruct.com.au:from_mime,codeconstruct.com.au:mid,codeconstruct.com.au:email,codeconstruct.com.au:dkim,vger.kernel.org:from_smtp,dmtf.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC87574C80C

Using the existing prepare/complete API, we can persist the rx skb
across receives to implement v1.1 packet spanning.

Alter the packet-extraction loop to allow truncated packets, returning
early with the skb persisted for the next IN urb completion. When we see
we have a complete packet, netif_rx() that. If the packet boundary
aligns with the urb completion, we can netif_rx() the whole thing.

Those intermediate packets are cloned from the original
(large-transfer-data) skb. Unlike existing behaviour, if the clone
fails, we drop just that clone, instead of the existing transfer skb.
This allows us to process the rest of the skb data, and any continuation
of the span into the next transfer.

One subtle change: the mctp_usblib_rx() helper now handles skbs with the
full transport header, so we shift the skb_pull() for the header data to
the helper, before doing the rx_bytes stats update.

We still need to handle non-spanning mode, so error out on
truncated-packet cases there.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v4:
 - describe clone failure behaviour
 - keep EPROTO for header-size mismatches
 - validate wMaxPacketSize on init
v3:
 - only expand skb if cloned or under min xfer size, preventing excessive
   reallocation
 - align rx len to ep pktlen.
v2:
 - note change in semantics for mctp_usblib_rx
 - reject rx packets too short for a MCTP header, rather than deferring
   to the MCTP core do do so
---
 drivers/net/mctp/mctp-usb.c    |   6 +-
 drivers/net/mctp/mctp-usblib.c | 167 +++++++++++++++++++++++++++++------------
 include/linux/usb/mctp-usb.h   |   6 +-
 3 files changed, 127 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index aa7d20865596..17699e09ba87 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -339,7 +339,10 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx);
+	rc = mctp_usblib_rx_init(&dev->rx, le16_to_cpu(ep_in->wMaxPacketSize),
+				 false);
+	if (rc)
+		goto err_free_netdev;
 	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
 	init_usb_anchor(&dev->tx_anchor);
 
@@ -365,6 +368,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 err_fini_rxtx:
 	mctp_usblib_tx_fini(&dev->tx);
 	mctp_usblib_rx_fini(&dev->rx);
+err_free_netdev:
 	free_netdev(netdev);
 	return rc;
 }
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index d58178f47c06..3f47807a8d3a 100644
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
@@ -11,12 +11,23 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <linux/usb/ch9.h>
 #include <linux/usb/mctp-usb.h>
 #include <net/mctp.h>
 
-void mctp_usblib_rx_init(struct mctp_usblib_rx *rx)
+int mctp_usblib_rx_init(struct mctp_usblib_rx *rx, u16 ep_pktlen, bool span)
 {
+	if (!ep_pktlen)
+		return -EINVAL;
+
+	if (ep_pktlen & ~USB_ENDPOINT_MAXP_MASK)
+		return -EINVAL;
+
 	memset(rx, 0, sizeof(*rx));
+	rx->span = span;
+	rx->ep_pktlen = ep_pktlen;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_rx_init);
 
@@ -34,15 +45,51 @@ int mctp_usblib_rx_prepare(struct net_device *netdev,
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
 
@@ -56,6 +103,9 @@ static void mctp_usblib_rx(struct net_device *netdev, struct sk_buff *skb)
 	struct mctp_skb_cb *cb;
 	unsigned long flags;
 
+	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_usb_hdr));
+
 	/* we're called from an URB completion handler, and cannot assume local
 	 * irqs are always disabled
 	 */
@@ -96,72 +146,89 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 
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
+				rc = -EPROTO;
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
index 1a5e795b4ec1..2979ddaa4dab 100644
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
+int mctp_usblib_rx_init(struct mctp_usblib_rx *rx, u16 ep_pktlen, bool span);
 void mctp_usblib_rx_fini(struct mctp_usblib_rx *rx);
 
 int mctp_usblib_rx_prepare(struct net_device *netdev,

-- 
2.47.3


