Return-Path: <netdev+bounces-48318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176F7EE0B4
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848C11C20940
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AF211A;
	Thu, 16 Nov 2023 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d1GL5Q1n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58A1A3
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 04:30:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09338204FF;
	Thu, 16 Nov 2023 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700137841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S+xuwkffgG1uvFyKsxV11s0Bd5Y0Ek0RNr2Q8b/oRAU=;
	b=d1GL5Q1ny6248SnNIqATDJxAk4yAEEX7AibgNtwuRVPPErVWhF4eMnUtN3cpTE2nDNFFrS
	QnFTEWiDMH1QAkhYQfwoYTn0Oc03YZPgkyfzq2JaG/ZFM8SLgvQcyn4JKd6xmVi8FeGQCD
	Dfzf98xcd0uF20V+omq5spuSVowZXs4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D88B11377E;
	Thu, 16 Nov 2023 12:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sIo2M3ALVmWtbgAAMHmgww
	(envelope-from <oneukum@suse.com>); Thu, 16 Nov 2023 12:30:40 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	bjorn@mork.no
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC] usbnet: assign unique random MAC
Date: Thu, 16 Nov 2023 13:30:24 +0100
Message-ID: <20231116123033.26035-1-oneukum@suse.com>
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
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[]

The old method had the bug of issuing the same
random MAC over and over even to every device.
This bug is as old as the driver.

This new method generates each device whose minidriver
does not provide its own MAC its own unique random
MAC.

A module parameter to go back to the old behavior
is included.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/usbnet.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 2d14b0d78541..53cb3a8d48c3 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -61,8 +61,10 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
+/* for the legacy behavior */
+
+u8 legacyrandomid[ETH_ALEN];
+static bool legacymac = false;
 
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
@@ -1731,7 +1733,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
 	dev->net = net;
 	strscpy(net->name, "usb%d", sizeof(net->name));
-	eth_hw_addr_set(net, node_id);
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1805,9 +1806,19 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
-		net->addr_assign_type = NET_ADDR_RANDOM;
+	/*
+	 * if the device does not come with a MAC
+	 * we ask the network core to generate us one
+	 * and flag the device accordingly
+	 */
+	if (!is_valid_ether_addr(net->dev_addr)) {
+		if (legacymac) {
+			eth_hw_addr_set(net, legacyrandomid);
+			net->addr_assign_type = NET_ADDR_RANDOM;
+		} else {
+			eth_hw_addr_random(net);
+		}
+	}
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
 		SET_NETDEV_DEVTYPE(net, &wlan_type);
@@ -2217,7 +2228,7 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
+	eth_random_addr(legacyrandomid);
 	return 0;
 }
 module_init(usbnet_init);
@@ -2227,6 +2238,8 @@ static void __exit usbnet_exit(void)
 }
 module_exit(usbnet_exit);
 
+module_param(legacymac, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(legacymac, "Use a legacy style common MAC if device need a random MAC");
 MODULE_AUTHOR("David Brownell");
 MODULE_DESCRIPTION("USB network driver framework");
 MODULE_LICENSE("GPL");
-- 
2.42.1


