Return-Path: <netdev+bounces-304347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pH+GILRNR2o+VwAAu9opvQ
	(envelope-from <netdev+bounces-304347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:50:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBA6FED71
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:50:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=C+donDEI;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304347-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304347-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC8AF304DADD
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDCD372EF4;
	Fri,  3 Jul 2026 05:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19035BDDB;
	Fri,  3 Jul 2026 05:48:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057695; cv=none; b=iM0AZWI+4DsrYPVASZhkNitLh0AtJZTC3/C7AAsPW3AmFvnXx9k41NlaygM2XFlbZdZ4agwnM5sgmgSV+nntAYNWriZxe0bxBU09Es9K6OJHFRKffrBKtlneaStUZxgEULHooLHktIH5ws9n3LkuKSfhS/O3L/2o9cTMqmAaZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057695; c=relaxed/simple;
	bh=4ugjlslrmXN4WKmNTQZlylWxtLXFLBWzBMoTTxNJRo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Szoh5sObMDPGfmzEy+JIadWE0rVWCA6mcVz3M5GZAwxENEzKTkzPxLQ+Vueo09T6as3AogPr/l5rUhPzeQaHSPcEEYKCtcamyDBXDV5h6nRNI+ENGgydmj5+KesHEXz70YF9EuWSAgzTD7uIEEcGaKZ5wNX/bU9WXuMwmzR4lEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C+donDEI; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057670;
	bh=GjcOMU5LkoxcSoJ5zxYNPoFstXAlijZiD1FyylBNJJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C+donDEIuUlL1RtJbBJ3lDq4aTXjyG4tvQgdcpw9qHwAYdPXJ2LOhl+r8PH0x++uy
	 jou5PC7S4yWRHHeilqhkU2Tl66w38EVkJOTlUSqP93jA/tez0Hk5N/u8No+eOMVjoy
	 dKE7BE9OMLlecQ/I43XJfu1IXXoI8LMYgPxtaJKtnrurDdW8AaP1m0IAf4kn3IqnHX
	 n2Axjou49t/silML15gYFc1CMtIeN+TUgGCIa3KDkESpy+HF4+SXAzQfb9LghFRUXa
	 0nCPSEx+4rhBL33Ay4LH7e7eslE2BuKQvzDP4Yho3PXJ2q4fTXp2fA09Bz2TyKlhnC
	 zY4MwrpcRVQ1w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A06436628B; Fri,  3 Jul 2026 13:47:50 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:23 +0800
Subject: [PATCH net-next v2 03/12] net: mctp: usblib: Move RX transfer
 processing to a new mctp-usblib
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-3-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
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
	TAGGED_FROM(0.00)[bounces-304347-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11BBA6FED71

The processing of USB receive transfers is common to both sides of a
MCTP over USB transport. In order to support a future gadget driver,
move the current host-side driver into a new common file, mctp-usblib.

This currently handles the submit-complete-packetise process of the
receive path of the USB transport. We'll add transmit handling in an
upcoming change.

While we're here, improve coverage for the bulk-IN urb status values,
and requeue where possible.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - drop unneeded skb_reset_mac_header
 - don't count transport header in rx bytes stats
 - disallow >512 bytes on RX URBs; the non-spanning protocol does not
   specify ZLPs, so we cannot allow an over-length transfer
 - add requeue on transient urb errors
---
 drivers/net/mctp/Kconfig       |  11 +++
 drivers/net/mctp/Makefile      |   1 +
 drivers/net/mctp/mctp-usb.c    | 114 ++++++++--------------------
 drivers/net/mctp/mctp-usblib.c | 166 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h   |  26 +++++++
 5 files changed, 235 insertions(+), 83 deletions(-)

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..a564a792801d 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,9 +47,20 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_USBLIB
+	tristate "MCTP over USB common library"
+	depends on USB
+	help
+	  Common protocol handling functions for MCTP-over-USB transport
+	  implementations, suitable for use in either host- or gadget-side
+	  transport driver
+
+	  This will be automatically enabled by the transport driver.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
+	select MCTP_TRANSPORT_USBLIB
 	help
 	  Provides a driver to access MCTP devices over USB transport,
 	  defined by DMTF specification DSP0283.
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..c870b62d3f1c 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
+obj-$(CONFIG_MCTP_TRANSPORT_USBLIB) += mctp-usblib.o
diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index c6e36b63e87a..cfecf1e4b98b 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -28,6 +28,8 @@ struct mctp_usb {
 	u8 ep_in;
 	u8 ep_out;
 
+	struct mctp_usblib_rx rx;
+
 	struct urb *tx_urb;
 	struct urb *rx_urb;
 
@@ -125,24 +127,23 @@ static const unsigned long RX_RETRY_DELAY = HZ / 4;
 static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 {
 	unsigned long flags;
-	struct sk_buff *skb;
+	size_t len;
+	void *buf;
 	int rc;
 
-	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_1_0_XFER_SIZE, gfp);
-	if (!skb) {
-		rc = -ENOMEM;
+	rc = mctp_usblib_rx_prepare(mctp_usb->netdev, &mctp_usb->rx,
+				    &buf, &len, gfp);
+	if (rc)
 		goto err_retry;
-	}
 
 	usb_fill_bulk_urb(mctp_usb->rx_urb, mctp_usb->usbdev,
 			  usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in),
-			  skb->data, MCTP_USB_1_0_XFER_SIZE,
-			  mctp_usb_in_complete, skb);
+			  buf, len, mctp_usb_in_complete, mctp_usb);
 
 	rc = usb_submit_urb(mctp_usb->rx_urb, gfp);
 	if (rc) {
 		netdev_dbg(mctp_usb->netdev, "rx urb submit failure: %d\n", rc);
-		kfree_skb(skb);
+		mctp_usblib_rx_cancel(&mctp_usb->rx);
 		if (rc == -ENOMEM)
 			goto err_retry;
 	}
@@ -159,93 +160,36 @@ static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
 
 static void mctp_usb_in_complete(struct urb *urb)
 {
-	struct sk_buff *skb = urb->context;
-	struct net_device *netdev = skb->dev;
-	struct mctp_usb *mctp_usb = netdev_priv(netdev);
-	struct mctp_skb_cb *cb;
-	unsigned int len;
+	struct mctp_usb *mctp_usb = urb->context;
+	struct net_device *netdev = mctp_usb->netdev;
 	int status;
 
 	status = urb->status;
 
 	switch (status) {
-	case -ENOENT:
-	case -ECONNRESET:
-	case -ESHUTDOWN:
-	case -EPROTO:
-		kfree_skb(skb);
-		return;
 	case 0:
+		mctp_usblib_rx_complete(netdev, &mctp_usb->rx,
+					urb->actual_length);
 		break;
+
 	default:
 		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
-		kfree_skb(skb);
-		return;
-	}
+		fallthrough;
+	case -ETIME:
+	case -EPROTO:
+	case -EILSEQ:
+	case -EOVERFLOW:
+		mctp_usblib_rx_cancel(&mctp_usb->rx);
+		break;
 
-	len = urb->actual_length;
-	__skb_put(skb, len);
-
-	while (skb) {
-		struct sk_buff *skb2 = NULL;
-		struct mctp_usb_hdr *hdr;
-		u8 pkt_len; /* length of MCTP packet, no USB header */
-
-		skb_reset_mac_header(skb);
-		hdr = skb_pull_data(skb, sizeof(*hdr));
-		if (!hdr)
-			break;
-
-		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {
-			netdev_dbg(netdev, "rx: invalid id %04x\n",
-				   be16_to_cpu(hdr->id));
-			break;
-		}
-
-		if (hdr->len <
-		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
-			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
-				   hdr->len);
-			break;
-		}
-
-		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
-		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
-		if (pkt_len > skb->len) {
-			netdev_dbg(netdev,
-				   "rx: short packet (xfer) %d, actual %d\n",
-				   hdr->len, skb->len);
-			break;
-		}
-
-		if (pkt_len < skb->len) {
-			/* more packets may follow - clone to a new
-			 * skb to use on the next iteration
-			 */
-			skb2 = skb_clone(skb, GFP_ATOMIC);
-			if (skb2) {
-				if (!skb_pull(skb2, pkt_len)) {
-					kfree_skb(skb2);
-					skb2 = NULL;
-				}
-			}
-			skb_trim(skb, pkt_len);
-		}
-
-		dev_dstats_rx_add(netdev, skb->len);
-
-		skb->protocol = htons(ETH_P_MCTP);
-		skb_reset_network_header(skb);
-		cb = __mctp_cb(skb);
-		cb->halen = 0;
-		netif_rx(skb);
-
-		skb = skb2;
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+	case -EPIPE:
+		mctp_usblib_rx_cancel(&mctp_usb->rx);
+		return;
 	}
 
-	if (skb)
-		kfree_skb(skb);
-
 	mctp_usb_rx_queue(mctp_usb, GFP_ATOMIC);
 }
 
@@ -341,6 +285,8 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	spin_lock_init(&dev->rx_lock);
 	usb_set_intfdata(intf, dev);
 
+	mctp_usblib_rx_init(&dev->rx);
+
 	dev->ep_in = ep_in->bEndpointAddress;
 	dev->ep_out = ep_out->bEndpointAddress;
 
@@ -362,6 +308,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 err_free_urbs:
 	usb_free_urb(dev->tx_urb);
 	usb_free_urb(dev->rx_urb);
+	mctp_usblib_rx_fini(&dev->rx);
 	free_netdev(netdev);
 	return rc;
 }
@@ -371,6 +318,7 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 	struct mctp_usb *dev = usb_get_intfdata(intf);
 
 	mctp_unregister_netdev(dev->netdev);
+	mctp_usblib_rx_fini(&dev->rx);
 	usb_free_urb(dev->tx_urb);
 	usb_free_urb(dev->rx_urb);
 	free_netdev(dev->netdev);
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
new file mode 100644
index 000000000000..875644de1780
--- /dev/null
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-usblib.c - MCTP-over-USB (DMTF DSP0283) transport helper library
+ *
+ * DSP0283 is available at:
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ *
+ * Copyright (C) 2024-2026 Code Construct Pty Ltd
+ */
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/usb/mctp-usb.h>
+#include <net/mctp.h>
+
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx)
+{
+	memset(rx, 0, sizeof(*rx));
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_rx_init);
+
+void mctp_usblib_rx_fini(struct mctp_usblib_rx *rx)
+{
+	kfree_skb(rx->skb);
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_rx_fini);
+
+/*
+ * Prepare a transfer buffer for future completion; *bufp and *lenp will
+ * be populated on success.
+ */
+int mctp_usblib_rx_prepare(struct net_device *netdev,
+			   struct mctp_usblib_rx *rx,
+			   void **bufp, size_t *lenp, gfp_t gfp)
+{
+	const unsigned int len = MCTP_USB_1_0_XFER_SIZE;
+	struct sk_buff *skb;
+
+	skb = __netdev_alloc_skb(netdev, len, gfp);
+	if (!skb)
+		return -ENOMEM;
+
+	rx->skb = skb;
+
+	*bufp = skb_tail_pointer(skb);
+	*lenp = len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_rx_prepare);
+
+static void mctp_usblib_rx(struct net_device *netdev, struct sk_buff *skb)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
+	struct mctp_skb_cb *cb;
+	unsigned long flags;
+
+	/* we're called from an URB completion handler, and cannot assume local
+	 * irqs are always disabled
+	 */
+	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, skb->len);
+	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
+
+	skb->protocol = htons(ETH_P_MCTP);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+/*
+ * Receive a USB completion of @len bytes of incoming data. We will then split
+ * this into packets and netif_rx() each. Intended to be called in atomic
+ * contexts - ie., URB completion.
+ *
+ * Assumes @netdev uses dstats.
+ */
+int mctp_usblib_rx_complete(struct net_device *netdev,
+			    struct mctp_usblib_rx *rx, size_t len)
+{
+	struct sk_buff *skb = rx->skb;
+	int rc = 0;
+
+	__skb_put(skb, len);
+
+	while (skb) {
+		struct sk_buff *skb2 = NULL;
+		struct mctp_usb_hdr *hdr;
+		/* length of MCTP packet, no USB header */
+		u8 pkt_len;
+
+		skb_reset_mac_header(skb);
+		hdr = skb_pull_data(skb, sizeof(*hdr));
+		if (!hdr) {
+			rc = -ENOMSG;
+			break;
+		}
+
+		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {
+			netdev_dbg(netdev, "rx: invalid id %04x\n",
+				   be16_to_cpu(hdr->id));
+			rc = -EPROTO;
+			break;
+		}
+
+		if (hdr->len <
+		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
+			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
+				   hdr->len);
+			rc = -EPROTO;
+			break;
+		}
+
+		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
+		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
+		if (pkt_len > skb->len) {
+			rc = -EPROTO;
+			netdev_dbg(netdev,
+				   "rx: short packet (xfer) %d, actual %d\n",
+				   hdr->len, skb->len);
+			break;
+		}
+
+		if (pkt_len < skb->len) {
+			/* more packets may follow - clone to a new
+			 * skb to use on the next iteration
+			 */
+			skb2 = skb_clone(skb, GFP_ATOMIC);
+			if (skb2) {
+				if (!skb_pull(skb2, pkt_len)) {
+					dev_kfree_skb_any(skb2);
+					skb2 = NULL;
+				}
+			}
+			skb_trim(skb, pkt_len);
+		}
+
+		mctp_usblib_rx(netdev, skb);
+		skb = skb2;
+	}
+
+	if (skb)
+		dev_kfree_skb_any(skb);
+
+	rx->skb = NULL;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_rx_complete);
+
+/*
+ * Cancel a rx context; subsequent prepare/complete calls will not be a
+ * continuation of any data already received.
+ */
+void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx)
+{
+	dev_kfree_skb_any(rx->skb);
+	rx->skb = NULL;
+}
+EXPORT_SYMBOL_GPL(mctp_usblib_rx_cancel);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
+MODULE_DESCRIPTION("MCTP USB transport library");
diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
index 2bece8afd1c7..595e6af16dd0 100644
--- a/include/linux/usb/mctp-usb.h
+++ b/include/linux/usb/mctp-usb.h
@@ -13,6 +13,8 @@
 #ifndef __LINUX_USB_MCTP_USB_H
 #define __LINUX_USB_MCTP_USB_H
 
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include <linux/types.h>
 
 struct mctp_usb_hdr {
@@ -29,4 +31,28 @@ struct mctp_usb_hdr {
 #define MCTP_USB_1_0_MTU_MAX	(MCTP_USB_1_0_PKTLEN_MAX - sizeof(struct mctp_usb_hdr))
 #define MCTP_USB_DMTF_ID	0x1ab4
 
+/* mctp-usblib */
+
+/*
+ * RX handle: drivers will typically create one on init, which persists for
+ * the life of the driver. The same handle is used for progressive
+ * prepare -> complete operations (for each incoming USB transfer), which
+ * result in netif_rx()-ing the MCTP packets received
+ */
+struct mctp_usblib_rx {
+	struct sk_buff *skb;
+};
+
+void mctp_usblib_rx_init(struct mctp_usblib_rx *rx);
+void mctp_usblib_rx_fini(struct mctp_usblib_rx *rx);
+
+int mctp_usblib_rx_prepare(struct net_device *netdev,
+			   struct mctp_usblib_rx *rx,
+			   void **bufp, size_t *lenp, gfp_t gfp);
+
+int mctp_usblib_rx_complete(struct net_device *netdev,
+			    struct mctp_usblib_rx *rx, size_t len);
+
+void mctp_usblib_rx_cancel(struct mctp_usblib_rx *rx);
+
 #endif /*  __LINUX_USB_MCTP_USB_H */

-- 
2.47.3


