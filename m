Return-Path: <netdev+bounces-49210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6B7F125D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD4D2820A2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0615E85;
	Mon, 20 Nov 2023 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y6w59Xrn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798F93
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:44:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E627F1F85D;
	Mon, 20 Nov 2023 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700480681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RGvdt6voUy/HNXqyEOuspSP+xlRARR9BpeEfEKhrTQQ=;
	b=Y6w59Xrn13JgMFK9VvMcd5sv4nBWk89Iq9mWsEm+UwZ2poR87KqcXOoWH0t/wPedRfw8YP
	4KzKYEz3cjJLjhhkHn1Wm6Q+2f2eE1WkvGpejINcOFFELZxSx9Qp66tVnxIDBGxMGzIFu2
	dTJJppdgDV3F4o4Dh6gJ6eSh5zL2XlA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8EA213499;
	Mon, 20 Nov 2023 11:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xI1PK6hGW2UFQQAAMHmgww
	(envelope-from <oneukum@suse.com>); Mon, 20 Nov 2023 11:44:40 +0000
From: Oliver Neukum <oneukum@suse.com>
To: bjorn@mork.no,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv2] usbnet: assign unique random MAC
Date: Mon, 20 Nov 2023 12:44:27 +0100
Message-ID: <20231120114438.12790-1-oneukum@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

The old method had the bug of issuing the same
random MAC over and over even to every device.
This bug is as old as the driver.

This new method generates each device whose minidriver
does not provide its own MAC its own unique random
MAC.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 2d14b0d78541..0115ce11e78b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -61,9 +61,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
@@ -1672,6 +1669,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	struct usb_device		*xdev;
 	int				status;
 	const char			*name;
+	u8				initialaddr[ETH_ALEN];
 	struct usb_driver 	*driver = to_usb_driver(udev->dev.driver);
 
 	/* usbnet already took usb runtime pm, so have to enable the feature
@@ -1683,6 +1681,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		pm_runtime_enable(&udev->dev);
 	}
 
+	eth_random_addr(initialaddr);
 	name = udev->dev.driver->name;
 	info = (const struct driver_info *) prod->driver_info;
 	if (!info) {
@@ -1731,7 +1730,7 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
 	dev->net = net;
 	strscpy(net->name, "usb%d", sizeof(net->name));
-	eth_hw_addr_set(net, node_id);
+	eth_hw_addr_set(net, initialaddr);
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1805,8 +1804,13 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
+	/* we assign a random MAC before we call bind
+	 * because we need to have the local assignment bit set
+	 * Before we mess around with temporary stuff we can
+	 * just as well generate a real random MAC
+	 * That means we need to set the flag if necessary
+	 */
+	if (ether_addr_equal(net->dev_addr, initialaddr))
 		net->addr_assign_type = NET_ADDR_RANDOM;
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
@@ -2217,7 +2221,6 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
 	return 0;
 }
 module_init(usbnet_init);
-- 
2.42.1


