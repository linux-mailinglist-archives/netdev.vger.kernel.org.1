Return-Path: <netdev+bounces-165377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAECA31C3E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5937A3A801E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120AC1D6DBB;
	Wed, 12 Feb 2025 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DCx06lAV"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710C150980;
	Wed, 12 Feb 2025 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328442; cv=none; b=U15itl5lPCy5nFsNo+b00uE9jCLrPK9MngDY2rdOC1G3dwb1QWH++jnkVvLI/LYqE2Eb5D6zdANcWHrkz2LfrJEbvOx4J6dcdMm3k8iET6EsdTkxLvFnj+PGdYafTTm71IHP27bgy5t01tWE1WFeAcSXPdnIOaqAD0AGHN90hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328442; c=relaxed/simple;
	bh=ve8fJtYeHIFH2g6yvYdQbHXP047CV65mtNiKhnhLJis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoZAhvXsIJ3zDesrjBLciwgoREiUS69FjiwV6YhUKGrlpMjLjbIJxmXmQhcxyRiFvc17hZgD1MHcv/5AwA/JoUP3MOo/Lbr9cg2wHSY0XmTjdYdL+mSIDAQ3IUPQHgrXn2+6JsqiSz8DTQnbKzBDyJdyxTcAfDQxnZ3p4yE/AlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DCx06lAV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739328432;
	bh=basBbk10Agy1MOiWnNRtzNJPgaW1hgUu6zqmz130jnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DCx06lAVF7dFTEMVtNpRSjst9XByaFAja1v/8BrKZbZ27fEbylGElsiXFFaf5T5bL
	 9XuBYRbvOu4bNvhpliAF5vwJnc2OhSLX4BEQlfuYs6XGR0KtegO+FKrOvzPTyFCOl4
	 GSId07dO514ijPJOhXqRUxZeh6lNUaAaP3cq+M65trIx0EATN9Ap8i4iAndRjqa+8G
	 EVeUBAflc4qt0/w9xXAJPl4zPULXsDd98kDpjao8s+ml2zwhVG91YFz6TL3IZyYw8M
	 pMUfdk8UJpRG3go3AVFkeywByjOGEaVpvokYYabsSmlrQnPu8ZPZQdPcwJxmCh1RoX
	 q4fir+2yIcH9g==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2E9C2756DC; Wed, 12 Feb 2025 10:47:12 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 12 Feb 2025 10:46:51 +0800
Subject: [PATCH net-next v2 2/2] net: mctp: Add MCTP USB transport driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-dev-mctp-usb-v2-2-76e67025d764@codeconstruct.com.au>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
In-Reply-To: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.2

Add an implementation for DMTF DSP0283, which defines a MCTP-over-USB
transport. As per that spec, we're restricted to full speed mode,
requiring 512-byte transfers.

Each MCTP-over-USB interface is a peer-to-peer link to a single MCTP
endpoint, so no physical addressing is required (of course, that MCTP
endpoint may then bridge to further MCTP endpoints). Consequently,
interfaces will report with no lladdr data:

    # mctp link
    dev lo index 1 address 00:00:00:00:00:00 net 1 mtu 65536 up
    dev mctpusb0 index 6 address none net 1 mtu 68 up

This is a simple initial implementation, with single rx & tx urbs, and
no multi-packet tx transfers - although we do accept multi-packet rx
from the device.

Includes suggested fixes from Santosh Puranik <spuranik@nvidia.com>.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Santosh Puranik <spuranik@nvidia.com>

---
v2:
 - update copyright year to 2025
 - improve dbg messages: use netdev, demote from _err, remove __func__
 - pass gfp_t to mctp_usb_rx_queue, allocate first as GFP_KERNEL
 - release ->usbdev on disconnect
 - include MODULE_{DESCRIPTION,AUTHOR,DEVICE_TABLE}
 - more sensible driver->name
 - do rx stats update before netif_rx()
 - specify phys binding type via mctp_register_netdev()
---
 drivers/net/mctp/Kconfig    |  10 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-usb.c | 368 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 379 insertions(+)

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index 15860d6ac39fef62847d7186f1f0d81c1d3cd619..cf325ab0b1ef555e21983ace1b838e10c7f34570 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,16 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_USB
+	tristate "MCTP USB transport"
+	depends on USB
+	help
+	  Provides a driver to access MCTP devices over USB transport,
+	  defined by DMTF specification DSP0283.
+
+	  MCTP-over-USB interfaces are peer-to-peer, so each interface
+	  represents a physical connection to one remote MCTP endpoint.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index e1cb99ced54ac136db0347a9ee0435a5ed938955..c36006849a1e7d04f2cafafb8931329fc0992b63 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
new file mode 100644
index 0000000000000000000000000000000000000000..9ffca70811cffbd609aeb2ac7f6df3ba69b8008a
--- /dev/null
+++ b/drivers/net/mctp/mctp-usb.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mctp-usb.c - MCTP-over-USB (DMTF DSP0283) transport binding driver.
+ *
+ * DSP0283 is available at:
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ *
+ * Copyright (C) 2024-2025 Code Construct Pty Ltd
+ */
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+#include <linux/usb/mctp-usb.h>
+
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <net/pkt_sched.h>
+
+#include <uapi/linux/if_arp.h>
+
+struct mctp_usb {
+	struct usb_device *usbdev;
+	struct usb_interface *intf;
+
+	struct net_device *netdev;
+
+	__u8 ep_in;
+	__u8 ep_out;
+
+	struct urb *tx_urb;
+	struct urb *rx_urb;
+};
+
+static void mctp_usb_stat_tx_dropped(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_drops);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static void mctp_usb_stat_tx_done(struct net_device *dev, unsigned int len)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_packets);
+	u64_stats_add(&dstats->tx_bytes, len);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static void mctp_usb_out_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct net_device *netdev = skb->dev;
+	int status;
+
+	status = urb->status;
+
+	switch (status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+	case -EPROTO:
+		mctp_usb_stat_tx_dropped(netdev);
+		break;
+	case 0:
+		mctp_usb_stat_tx_done(netdev, skb->len);
+		netif_wake_queue(netdev);
+		consume_skb(skb);
+		return;
+	default:
+		netdev_dbg(netdev, "unexpected tx urb status: %d\n", status);
+		mctp_usb_stat_tx_dropped(netdev);
+	}
+
+	kfree_skb(skb);
+}
+
+static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct mctp_usb *mctp_usb = netdev_priv(dev);
+	struct mctp_usb_hdr *hdr;
+	unsigned int plen;
+	struct urb *urb;
+	int rc;
+
+	plen = skb->len;
+
+	if (plen + sizeof(*hdr) > MCTP_USB_XFER_SIZE)
+		goto err_drop;
+
+	hdr = skb_push(skb, sizeof(*hdr));
+	if (!hdr)
+		goto err_drop;
+
+	hdr->id = cpu_to_be16(MCTP_USB_DMTF_ID);
+	hdr->rsvd = 0;
+	hdr->len = plen + sizeof(*hdr);
+
+	urb = mctp_usb->tx_urb;
+
+	usb_fill_bulk_urb(urb, mctp_usb->usbdev,
+			  usb_sndbulkpipe(mctp_usb->usbdev, mctp_usb->ep_out),
+			  skb->data, skb->len,
+			  mctp_usb_out_complete, skb);
+
+	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (rc)
+		goto err_drop;
+	else
+		netif_stop_queue(dev);
+
+	return NETDEV_TX_OK;
+
+err_drop:
+	mctp_usb_stat_tx_dropped(dev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_usb_in_complete(struct urb *urb);
+
+static int mctp_usb_rx_queue(struct mctp_usb *mctp_usb, gfp_t gfp)
+{
+	struct sk_buff *skb;
+	int rc;
+
+	skb = __netdev_alloc_skb(mctp_usb->netdev, MCTP_USB_XFER_SIZE, gfp);
+	if (!skb)
+		return -ENOMEM;
+
+	usb_fill_bulk_urb(mctp_usb->rx_urb, mctp_usb->usbdev,
+			  usb_rcvbulkpipe(mctp_usb->usbdev, mctp_usb->ep_in),
+			  skb->data, MCTP_USB_XFER_SIZE,
+			  mctp_usb_in_complete, skb);
+
+	rc = usb_submit_urb(mctp_usb->rx_urb, gfp);
+	if (rc) {
+		netdev_err(mctp_usb->netdev, "rx urb submit failure: %d\n", rc);
+		kfree_skb(skb);
+	}
+
+	return rc;
+}
+
+static void mctp_usb_in_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct net_device *netdev = skb->dev;
+	struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
+	struct mctp_usb *mctp_usb = netdev_priv(netdev);
+	struct mctp_skb_cb *cb;
+	unsigned int len;
+	int status;
+
+	status = urb->status;
+
+	switch (status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+	case -EPROTO:
+		kfree_skb(skb);
+		return;
+	case 0:
+		break;
+	default:
+		netdev_dbg(netdev, "unexpected rx urb status: %d\n", status);
+		kfree_skb(skb);
+		return;
+	}
+
+	len = urb->actual_length;
+	__skb_put(skb, len);
+
+	while (skb) {
+		struct sk_buff *skb2 = NULL;
+		struct mctp_usb_hdr *hdr;
+		u8 pkt_len; /* length of MCTP packet, no USB header */
+
+		hdr = skb_pull_data(skb, sizeof(*hdr));
+		if (!hdr)
+			break;
+
+		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {
+			netdev_dbg(netdev, "rx: invalid id %04x\n",
+				   be16_to_cpu(hdr->id));
+			break;
+		}
+
+		if (hdr->len <
+		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
+			netdev_dbg(netdev, "rx: short packet (hdr) %d\n",
+				   hdr->len);
+			break;
+		}
+
+		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
+		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
+		if (pkt_len > skb->len) {
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
+					kfree_skb(skb2);
+					skb2 = NULL;
+				}
+			}
+			skb_trim(skb, pkt_len);
+		}
+
+		u64_stats_update_begin(&dstats->syncp);
+		u64_stats_inc(&dstats->rx_packets);
+		u64_stats_add(&dstats->rx_bytes, skb->len);
+		u64_stats_update_end(&dstats->syncp);
+
+		skb->protocol = htons(ETH_P_MCTP);
+		skb_reset_network_header(skb);
+		cb = __mctp_cb(skb);
+		cb->halen = 0;
+		netif_rx(skb);
+
+		skb = skb2;
+	}
+
+	if (skb)
+		kfree_skb(skb);
+
+	mctp_usb_rx_queue(mctp_usb, GFP_ATOMIC);
+}
+
+static int mctp_usb_open(struct net_device *dev)
+{
+	struct mctp_usb *mctp_usb = netdev_priv(dev);
+
+	return mctp_usb_rx_queue(mctp_usb, GFP_KERNEL);
+}
+
+static int mctp_usb_stop(struct net_device *dev)
+{
+	struct mctp_usb *mctp_usb = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+	usb_kill_urb(mctp_usb->rx_urb);
+	usb_kill_urb(mctp_usb->tx_urb);
+
+	return 0;
+}
+
+static const struct net_device_ops mctp_usb_netdev_ops = {
+	.ndo_start_xmit = mctp_usb_start_xmit,
+	.ndo_open = mctp_usb_open,
+	.ndo_stop = mctp_usb_stop,
+};
+
+static void mctp_usb_netdev_setup(struct net_device *dev)
+{
+	dev->type = ARPHRD_MCTP;
+
+	dev->mtu = MCTP_USB_MTU_MIN;
+	dev->min_mtu = MCTP_USB_MTU_MIN;
+	dev->max_mtu = MCTP_USB_MTU_MAX;
+
+	dev->hard_header_len = sizeof(struct mctp_usb_hdr);
+	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	dev->addr_len = 0;
+	dev->flags = IFF_NOARP;
+	dev->netdev_ops = &mctp_usb_netdev_ops;
+	dev->needs_free_netdev = false;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+static int mctp_usb_probe(struct usb_interface *intf,
+			  const struct usb_device_id *id)
+{
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
+	struct usb_host_interface *iface_desc;
+	struct net_device *netdev;
+	struct mctp_usb *dev;
+	int rc;
+
+	/* only one alternate */
+	iface_desc = intf->cur_altsetting;
+
+	rc = usb_find_common_endpoints(iface_desc, &ep_in, &ep_out, NULL, NULL);
+	if (rc) {
+		dev_err(&intf->dev, "invalid endpoints on device?\n");
+		return rc;
+	}
+
+	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
+			      mctp_usb_netdev_setup);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+	dev = netdev_priv(netdev);
+	dev->netdev = netdev;
+	dev->usbdev = usb_get_dev(interface_to_usbdev(intf));
+	dev->intf = intf;
+	usb_set_intfdata(intf, dev);
+
+	dev->ep_in = ep_in->bEndpointAddress;
+	dev->ep_out = ep_out->bEndpointAddress;
+
+	dev->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
+	dev->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!dev->tx_urb || !dev->rx_urb) {
+		rc = -ENOMEM;
+		goto err_free_urbs;
+	}
+
+	rc = mctp_register_netdev(netdev, NULL, MCTP_PHYS_BINDING_USB);
+	if (rc)
+		goto err_free_urbs;
+
+	return 0;
+
+err_free_urbs:
+	usb_free_urb(dev->tx_urb);
+	usb_free_urb(dev->rx_urb);
+	free_netdev(netdev);
+	return rc;
+}
+
+static void mctp_usb_disconnect(struct usb_interface *intf)
+{
+	struct mctp_usb *dev = usb_get_intfdata(intf);
+
+	mctp_unregister_netdev(dev->netdev);
+	usb_free_urb(dev->tx_urb);
+	usb_free_urb(dev->rx_urb);
+	usb_put_dev(dev->usbdev);
+	free_netdev(dev->netdev);
+}
+
+static const struct usb_device_id mctp_usb_devices[] = {
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, 0x0, 0x1) },
+	{ 0 },
+};
+
+MODULE_DEVICE_TABLE(usb, mctp_usb_devices);
+
+static struct usb_driver mctp_usb_driver = {
+	.name		= "mctp-usb",
+	.id_table	= mctp_usb_devices,
+	.probe		= mctp_usb_probe,
+	.disconnect	= mctp_usb_disconnect,
+};
+
+module_usb_driver(mctp_usb_driver)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
+MODULE_DESCRIPTION("MCTP USB transport");

-- 
2.39.5


