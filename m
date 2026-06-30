Return-Path: <netdev+bounces-302928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0WTBJZk2Q2qVVAoAu9opvQ
	(envelope-from <netdev+bounces-302928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:23:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7B6E008D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:23:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=H0K3YV5Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302928-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302928-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FCAD300B8EB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7F3D88EF;
	Tue, 30 Jun 2026 03:22:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71B2367DF;
	Tue, 30 Jun 2026 03:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789759; cv=none; b=LFE+XWU6J8jmw15GmkWuM/rwj+ddyc5wAUtZUPXa6XMwIPffroRAy4v4ONshcqRF2MBqg3PHCP2mgZgxE7U+gCRK/4k61mbQSCCZildpqoeQVLdpeVilkkJS5+dVXPQtHgnA15cMUY21CAG4iKV0j3siD3KTbkDjrUA1G/qB7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789759; c=relaxed/simple;
	bh=odY+njQgKQfakAQK6Y1EATWuYnnUc9ZOqow6oTRnl6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYOnmIxs3zbl+hu1U/pXXy1f0t/7YM3HLqTZpcoyNYAWY3dGBJy15LVg/aXRC4Ms3burUMFsh9WXSLJLSLwYmRfDDGqpDiWb0bmGs/d5tq/308x4/9sLLh/IGmWZW7iHamf4AIWTkFOnwPR8w7bjJLV2Tu4mK2IlAEBJ+JgonBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=H0K3YV5Q; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782789748;
	bh=aQim1q4BP2qSiiLcgPwyQduSCFuGgF/F3ifsJ2+rzrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H0K3YV5QH5oZQiUeU6A7rrkQG/7cdOlh2AdJpXiAwNGU3YYPcaG+HetUdjXP9fJUs
	 fTcI+faA0Za5RwJW6g0bqjt4LTUg2LYUiJw4Yx62L137c/Fdbg7txmt/tUl2YD1Lev
	 Jicm7jc+9LyRM8rKNVXMojwePECI3CurEgFWXHg9vt8cYVm7U2fCjq7fU1A4E+NEOd
	 +OQ5mPl39JW7g6T/ec5OgiRmX/1rX86yKm3ky5ld3R4K+xmBf5zKgpziRjpb0+ql2J
	 +wp01BR7eu8YDnhRXBjF9mdeuhJp8xceCGm6Y/ACm7XT7obQYC5TdgO2LHufssRYWT
	 vFIUT+En9rkYw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E5DEC660F7; Tue, 30 Jun 2026 11:22:28 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 30 Jun 2026 11:21:32 +0800
Subject: [PATCH net-next 11/12] net: mctp: usb: enable v1.1 packet spanning
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-dev-mctp-usb-1-1-v1-11-86a311fc67b7@codeconstruct.com.au>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302928-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,dmtf.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,codeconstruct.com.au:dkim,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE7B6E008D

Now that mctp-usblib supports DSP0283 v1.1 packet spanning, enable it in
our host-side transport driver.

Add a match for the new device subclass (0x02), and indicating spanning
mode to the usblib rx/tx implementation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 91109ad17d1c..5739c87da109 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -3,9 +3,9 @@
  * mctp-usb.c - MCTP-over-USB (DMTF DSP0283) transport binding driver.
  *
  * DSP0283 is available at:
- * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.0.1.pdf
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0283_1.1.0.pdf
  *
- * Copyright (C) 2024-2025 Code Construct Pty Ltd
+ * Copyright (C) 2024-2026 Code Construct Pty Ltd
  */
 
 #include <linux/module.h>
@@ -22,6 +22,7 @@
 struct mctp_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
+	bool span;
 
 	struct net_device *netdev;
 
@@ -42,6 +43,11 @@ struct mctp_usb {
 	struct usb_anchor tx_anchor;
 };
 
+enum {
+	MCTP_USB_SUBCLASS_BASE = 0x00,
+	MCTP_USB_SUBCLASS_SPAN = 0x02,
+};
+
 static void mctp_usb_out_complete(struct urb *urb)
 {
 	struct mctp_usblib_tx_ctx *tx_ctx = urb->context;
@@ -76,6 +82,9 @@ static int mctp_usb_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
 			  usb_sndbulkpipe(mctp_usb->usbdev, mctp_usb->ep_out),
 			  data, len, mctp_usb_out_complete, tx_ctx);
 
+	if (mctp_usb->span)
+		urb->transfer_flags |= URB_ZERO_PACKET;
+
 	netif_stop_queue(mctp_usb->netdev);
 
 	spin_lock_irqsave(&mctp_usb->tx_lock, flags);
@@ -250,6 +259,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *iface_desc;
 	struct net_device *netdev;
 	struct mctp_usb *dev;
+	bool span;
 	int rc;
 
 	/* only one alternate */
@@ -261,6 +271,8 @@ static int mctp_usb_probe(struct usb_interface *intf,
 		return rc;
 	}
 
+	span = iface_desc->desc.bInterfaceSubClass == MCTP_USB_SUBCLASS_SPAN;
+
 	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
 			      mctp_usb_netdev_setup);
 	if (!netdev)
@@ -268,15 +280,18 @@ static int mctp_usb_probe(struct usb_interface *intf,
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	dev = netdev_priv(netdev);
+	dev->span = span;
 	dev->netdev = netdev;
 	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
+	if (dev->span)
+		netdev->max_mtu = MCTP_USB_1_1_MTU_MAX;
 	spin_lock_init(&dev->rx_lock);
 	spin_lock_init(&dev->tx_lock);
 	usb_set_intfdata(intf, dev);
 
-	mctp_usblib_rx_init(&dev->rx, false);
-	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, false);
+	mctp_usblib_rx_init(&dev->rx, dev->span);
+	mctp_usblib_tx_init(&dev->tx, &tx_ops, dev, dev->span);
 	init_usb_anchor(&dev->tx_anchor);
 
 	dev->ep_in = ep_in->bEndpointAddress;
@@ -317,7 +332,8 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id mctp_usb_devices[] = {
-	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, 0x0, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_BASE, 0x1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_MCTP, MCTP_USB_SUBCLASS_SPAN, 0x1) },
 	{ 0 },
 };
 

-- 
2.47.3


