Return-Path: <netdev+bounces-265651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGb/IYf8rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:59:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6AB23D3B4
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C533730367EB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDC3B8BD1;
	Mon,  9 Mar 2026 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SWnvywin";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SWnvywin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C333E958D
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075437; cv=none; b=lhaxh5i4CkhIwxhD5aAyvlvU5O51IVlmjtR/m+195DE97NwS3a61sawOh9I5FsZpsckNis7DSub5w1pkwpXN0beIGvOKOlf/D0buDgR0mhmX1gAGSND/BpFvMkL7hnlbZ3dszW3mEIXugBFfVioPZgXM02y4aFD1JR/JvOIfOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075437; c=relaxed/simple;
	bh=ZPWQJcb7iKlYiuNzCv1RSLZwzBwUxEqqgxbhvrd1bJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2yS0l/zPqHrMrrgAK0iaT5Z24rfIvV2ZYCIDkxJ8PU/s4v64GQr6jAuf2CiD7+8fvUNFTavfe2AIIum5SCku6EF1aOVWwd8woYycD277BH5NNlpvrRatPSUdE2FGrnVVigaH+Je507v5fJc3Z7IFHLnMC7/v5Epdkl85gxQ5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SWnvywin; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SWnvywin; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 517F04D251;
	Mon,  9 Mar 2026 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq1pqwASc9eiNwagD6abxOaq/+F4zP2I+eLg/uS+b4k=;
	b=SWnvywinJFuOIjLG5ULWtbGjBAC0HtbNjpGQvmR19NNnv9b+LlmNe5rOOqiLb6d/oMaIuh
	iV0YuyQXMQDBZEctI9CgzvBXrQtBLcZyyIaDjDu7aZEu2S3E7+PgHIsiPlVtMOHSZ6jCTo
	ddEcYQvjGJ/DvZqI6jhTnrfb1siZga0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SWnvywin
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq1pqwASc9eiNwagD6abxOaq/+F4zP2I+eLg/uS+b4k=;
	b=SWnvywinJFuOIjLG5ULWtbGjBAC0HtbNjpGQvmR19NNnv9b+LlmNe5rOOqiLb6d/oMaIuh
	iV0YuyQXMQDBZEctI9CgzvBXrQtBLcZyyIaDjDu7aZEu2S3E7+PgHIsiPlVtMOHSZ6jCTo
	ddEcYQvjGJ/DvZqI6jhTnrfb1siZga0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 303943EFD8;
	Mon,  9 Mar 2026 16:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EFKiCrn7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:25 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 12/13] net: usb: smsc95xx: use dynamic private allocation
Date: Mon,  9 Mar 2026 17:53:35 +0100
Message-ID: <20260309165614.861929-12-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309165614.861929-1-oneukum@suse.com>
References: <20260309165614.861929-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 2A6AB23D3B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265651-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The old style private room was too small for smsc95xx
With dynamic allocation that factor is gone.
Remove handling private allocations in the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/smsc95xx.c | 67 +++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 42e4048b574b..b1d66290fe17 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -84,7 +84,7 @@ MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 					  u32 *data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
@@ -115,7 +115,7 @@ static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 					   u32 data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
@@ -265,7 +265,7 @@ static int smsc95xx_mdiobus_reset(struct mii_bus *bus)
 	int ret;
 
 	dev = bus->priv;
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 
 	if (pdata->is_internal_phy)
 		return 0;
@@ -481,7 +481,7 @@ static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 static void smsc95xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -539,7 +539,7 @@ static void smsc95xx_set_multicast(struct net_device *netdev)
 
 static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 flow = 0, afc_cfg;
 
 	int ret = smsc95xx_read_reg(dev, AFC_CFG, &afc_cfg);
@@ -584,7 +584,7 @@ static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 
 static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -613,7 +613,7 @@ static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 
 static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	u32 intdata;
 
@@ -730,7 +730,7 @@ static void smsc95xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -740,7 +740,7 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
@@ -788,7 +788,7 @@ static void smsc95xx_get_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 
 	pause->autoneg = pdata->pause_autoneg;
 	pause->rx_pause = pdata->pause_rx;
@@ -804,7 +804,7 @@ static int smsc95xx_set_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 	phydev = ndev->phydev;
 
 	if (!phydev)
@@ -898,7 +898,7 @@ static int smsc95xx_set_mac_address(struct usbnet *dev)
 /* starts the TX path */
 static int smsc95xx_start_tx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 	int ret;
 
@@ -918,7 +918,7 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
 /* Starts the Receive path */
 static int smsc95xx_start_rx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
@@ -930,7 +930,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev)
 
 static int smsc95xx_reset(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
@@ -1146,7 +1146,7 @@ static void smsc95xx_handle_link_change(struct net_device *net)
 
 static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	char usb_path[64];
 	int ret, phy_irq;
 	u32 val;
@@ -1157,12 +1157,6 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		return ret;
 	}
 
-	pdata = kzalloc_obj(*pdata);
-	if (!pdata)
-		return -ENOMEM;
-
-	dev->driver_priv = pdata;
-
 	spin_lock_init(&pdata->mac_cr_lock);
 
 	/* LAN95xx devices do not alter the computed checksum of 0 to 0xffff.
@@ -1185,14 +1179,14 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* Init all registers */
 	ret = smsc95xx_reset(dev);
 	if (ret)
-		goto free_pdata;
+		goto bail_out;
 
 	/* create irq domain for use by PHY driver and GPIO consumers */
 	usb_make_path(dev->udev, usb_path, sizeof(usb_path));
 	pdata->irqfwnode = irq_domain_alloc_named_fwnode(usb_path);
 	if (!pdata->irqfwnode) {
 		ret = -ENOMEM;
-		goto free_pdata;
+		goto bail_out;
 	}
 
 	pdata->irqdomain = irq_domain_create_linear(pdata->irqfwnode,
@@ -1309,14 +1303,13 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 free_irqfwnode:
 	irq_domain_free_fwnode(pdata->irqfwnode);
 
-free_pdata:
-	kfree(pdata);
+bail_out:
 	return ret;
 }
 
 static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	phy_disconnect(dev->net->phydev);
 	mdiobus_unregister(pdata->mdiobus);
@@ -1324,8 +1317,6 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 	irq_dispose_mapping(irq_find_mapping(pdata->irqdomain, PHY_HWIRQ));
 	irq_domain_remove(pdata->irqdomain);
 	irq_domain_free_fwnode(pdata->irqfwnode);
-	netif_dbg(dev, ifdown, dev->net, "free pdata\n");
-	kfree(pdata);
 }
 
 static int smsc95xx_start_phy(struct usbnet *dev)
@@ -1350,7 +1341,7 @@ static u32 smsc_crc(const u8 *buffer, size_t len, int filter)
 
 static int smsc95xx_link_ok(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	/* first, a dummy read, needed to latch some MII phys */
@@ -1367,7 +1358,7 @@ static int smsc95xx_link_ok(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1406,7 +1397,7 @@ static int smsc95xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret, phy_id = pdata->phydev->mdio.addr;
 	u32 val;
 
@@ -1453,7 +1444,7 @@ static int smsc95xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1475,7 +1466,7 @@ static int smsc95xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val;
 	int ret;
 
@@ -1514,7 +1505,7 @@ static int smsc95xx_enter_suspend3(struct usbnet *dev)
 
 static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	if (!netif_running(dev->net)) {
 		/* interface is ifconfig down so fully power down hw */
@@ -1544,7 +1535,7 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	u32 val, link_up;
 	int ret;
 
@@ -1805,7 +1796,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 	u32 val;
 
 	BUG_ON(!dev);
-	pdata = dev->driver_priv;
+	pdata = usbnet_priv(dev);
 	suspend_flags = pdata->suspend_flags;
 
 	netdev_dbg(dev->net, "resume suspend_flags=0x%02x\n", suspend_flags);
@@ -1854,7 +1845,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 static int smsc95xx_reset_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 	int ret;
 
 	pdata->pm_task = current;
@@ -2038,7 +2029,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 
 static int smsc95xx_manage_power(struct usbnet *dev, int on)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = usbnet_priv(dev);
 
 	dev->intf->needs_remote_wakeup = on;
 
-- 
2.53.0


