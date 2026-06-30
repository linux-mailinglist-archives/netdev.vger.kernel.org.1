Return-Path: <netdev+bounces-302924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cuJtG4w2Q2qKVAoAu9opvQ
	(envelope-from <netdev+bounces-302924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:22:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E706E0078
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:22:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=fHerM7EC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC1F3012D37
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94C3BED44;
	Tue, 30 Jun 2026 03:22:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91E37646B;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789758; cv=none; b=sjdoHAQmytzGmT2LGv7W/jXgEVM6UEzxBsmwRRmid1annJSbNxbipvuI1I7mGjWiIOBSAaVqmPda+ltzBjzniFZuGqRTgtsNRmY4+D9cT56RztZT2qxFyA7VVuU2Md91jZsKj075vVkzmL5Rqe3cUt/GTQsKVXcDCv2VqZT9+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789758; c=relaxed/simple;
	bh=OhVRjnNT//+J/UwBvrIpEY/yAo3H6EGWrndvEauNUt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9Y8JthPnIz4xwNsNgTfGyFJlUP7nvFMjJM/O2xeMBZvm4VadkZf86Cr1sGE/BJysWjqP+U+wQYvW2p0OHut3ulE3hvmfJ4VdACNSQa37r2H3aQpw3Xd+ta/DxGhKV7jKcRnA2eipWcwfgbOowGPMyABQ2LUfqks3rE/sVuZy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fHerM7EC; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789748;
	bh=BjgSm7uukGC44GBBfkaHA98j7uSuIe2VDrys3cTVxMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fHerM7ECcD+avxVzxULwfFYa6qgkE8RMRf0qKa8UySK5c8IQkIffVupjcN+UjVafx
	 F/zxTDh43xawkpYfBPrAV2dR9ecHlsMhFPqgtwR5qwTe1jOF4BSh5Y20rfHL8fioQ8
	 filfTDlCcgjkOBBp2dY1kC1DbCtRY5iwh/fgFO+3Tgyu2qIiZ14Vb3Lbs0jrwxw1bD
	 zS5001MK8juVtxlqMcAT+U2gJHPjQuwl7OzIfzDW8/jupzre/P+s9qdplvTo6n1WcU
	 V+UAQ26JRIK50gakpjNX7F/esR6v8C2WAe2OriYHXGLm5BPqqzOfG0KVd1Gp6EUSGs
	 A8DLqHtNn/uTg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 16C2E660F4; Tue, 30 Jun 2026 11:22:28 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:29 +0800
Subject: [PATCH net-next 08/12] net: mctp: usblib: Implement receive-side
 packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-8-86a311fc67b7@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302924-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,dmtf.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4E706E0078

Using the existing prepare/complete API, we can persist the rx skb
across receives to implement v1.1 packet spanning.

Alter the packet-extraction loop to allow truncated packets, returning
early with the skb persisted for the next IN urb completion. When we see
we have a complete packet, netif_rx() that. If the packet boundary
aligns with the urb completion, we can netif_rx() the whole thing.

We still need to handle non-spanning mode, so error out on
truncated-packet cases there.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c    |   2 +-
 drivers/net/mctp/mctp-usblib.c | 135 ++++++++++++++++++++++++++---------------
 include/linux/usb/mctp-usb.h   |   5 +-
 3 files changed, 91 insertions(+), 51 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index b31599dfaa7e..c89588741855 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -275,7 +275,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->tx_lock);
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx);
+	mctp_usblib_rx_init(&dev->rx, false);
 	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev);
 	init_usb_anchor(&dev->tx_anchor);
 
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index acfae6d32390..a1649f24d937 100644
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
@@ -13,9 +13,10 @@
 #include <linux/usb/mctp-usb.h>
 #include <net/mctp.h>
 
-void mctp_usblib_rx_init(struct mctp_usblib_rx *rx)
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx, bool span)
 {
 	memset(rx, 0, sizeof(*rx));
+	rx->span = span;
 }
 EXPORT_SYMBOL_GPL(mctp_usblib_rx_init);
 
@@ -33,12 +34,30 @@ int mctp_usblib_rx_prepare(struct net_device *netdev,
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
+	len = rx->span ? MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_XFER_SIZE;
+
+	if (skb) {
+		struct sk_buff *skb2;
+
+		skb2 = skb_copy_expand(skb, 0, len, gfp);
+		if (!skb2)
+			return -ENOMEM;
+		dev_kfree_skb_any(skb);
+		skb = skb2;
+	} else {
+		skb = __netdev_alloc_skb(netdev, len, gfp);
+		if (!skb)
+			return -ENOMEM;
+	}
 
 	rx->skb = skb;
 
@@ -60,10 +79,11 @@ static void mctp_usblib_rx(struct net_device *netdev, struct sk_buff *skb)
 	 */
 	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
 	u64_stats_inc(&dstats->rx_packets);
-	u64_stats_add(&dstats->rx_bytes, skb->len + sizeof(struct mctp_usb_hdr));
+	u64_stats_add(&dstats->rx_bytes, skb->len);
 	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
 
 	skb_reset_mac_header(skb);
+	skb_pull(skb, sizeof(struct mctp_usb_hdr));
 	skb->protocol = htons(ETH_P_MCTP);
 	skb_reset_network_header(skb);
 	cb = __mctp_cb(skb);
@@ -86,70 +106,87 @@ int mctp_usblib_rx_complete(struct net_device *netdev,
 
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
-				   hdr->len);
+		pkt_len = be16_to_cpu(hdr->len);
+		/* v1.1, with span enabled, has a 13-bit length */
+		pkt_len &= rx->span ?
+			MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;
+		if (pkt_len < sizeof(*hdr)) {
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
index 47561f2471e5..00c538a8e211 100644
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
@@ -46,9 +48,10 @@ struct mctp_usb_hdr {
  */
 struct mctp_usblib_rx {
 	struct sk_buff *skb;
+	bool span;
 };
 
-void mctp_usblib_rx_init(struct mctp_usblib_rx *rx);
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx, bool span);
 void mctp_usblib_rx_fini(struct mctp_usblib_rx *rx);
 
 int mctp_usblib_rx_prepare(struct net_device *netdev,

-- 
2.47.3


