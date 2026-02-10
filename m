Return-Path: <netdev+bounces-258109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPc0LX1Li2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329811C604
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5C6300DA6D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192B3815DE;
	Tue, 10 Feb 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SmUi8btW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P5ZPYG9f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97153816EF
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736471; cv=none; b=pffWSSIWGZ2J6RvczlX1dJyru8qLlEzz4odAKnk+6Y7MTdsCPBduuKE+YY5zzZTBbH1xQLEmWY//L8zwZhmq8x0iUfh7kiuRNdq8UuRE0K6bLhTCHwZ/UXBnqHf4uqWLeIpylXLCdqoLqEHZwxT8ysan9Gs7F9HjORZQAMonClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736471; c=relaxed/simple;
	bh=5+7Zjbrnf4bKDlccmAgvUftN5O3jJ4DgYp0EZYB8W0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxcijH3dlpnMd2SS0BE0IXYiI8CpzVkcrUfsDFbf3eT/6F145M1gQzr4PpAPwVedrUADVI9Xhekcoylh5yMEF+NdFZJUQsydZWvqmopzsds46hq4hWPty4ofSqADGyrJly/X/R87admBhtBT710905b7wpF/kCMaI4rIILV/GDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SmUi8btW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P5ZPYG9f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0D175BD6B;
	Tue, 10 Feb 2026 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcyP2EwycHgTLMHMqgc0g6lu+SuagnbFTWXvESiMUqU=;
	b=SmUi8btWlklgjHKyU7gfEZKINfgio4GDAmwb0/tfHNlK7MpjdXAwLB0p+F9O71yvLv15Pc
	x0n8yuCSU3yPAU8ocoY+Fj/H55hgpm9zE1MmnBMmjD0qREEuFFVFBUD5n+F1a8TRm66z7K
	G5ZdNoolP1aa5DW7smlEChsesNcAbT4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=P5ZPYG9f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcyP2EwycHgTLMHMqgc0g6lu+SuagnbFTWXvESiMUqU=;
	b=P5ZPYG9fJZyA44/QMbCcdSO45XagHoSUWw6UGTRx37sTQTzDiKGuqixDReVfrz1iefpXN3
	yWoGyYSXXNw8kPZXRJGk6mMSFPIYiogG0/ObnFXwevix4f/z7IuD8JAa+q9dw72nmjSnIF
	hQ4gMMDALGWT0s0IKMNh5oInB7LKFmY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CA6B3EA66;
	Tue, 10 Feb 2026 15:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eEXbG05Li2lmVgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 15:14:22 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	hayeswang@realtek.com,
	bjorn@mork.no,
	o.rempel@pengutronix.de
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFC net-next 3/3] net: usb: usbnet: remove driver_priv
Date: Tue, 10 Feb 2026 16:11:14 +0100
Message-ID: <20260210151416.42254-4-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210151416.42254-1-oneukum@suse.com>
References: <20260210151416.42254-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258109-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 2329811C604
X-Rspamd-Action: no action

With dynamic private area allocation there is no point in keeping
a second mechanism.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/aqc111.c       | 45 ++++++++++----------
 drivers/net/usb/asix.h         |  2 +-
 drivers/net/usb/asix_common.c  |  2 +-
 drivers/net/usb/asix_devices.c | 76 +++++++++++++++-------------------
 drivers/net/usb/ax88172a.c     | 26 ++++--------
 drivers/net/usb/ax88179_178a.c | 54 +++++++++++++-----------
 drivers/net/usb/cx82310_eth.c  | 56 +++++++++++--------------
 drivers/net/usb/lg-vl600.c     | 15 ++-----
 drivers/net/usb/smsc95xx.c     | 60 ++++++++++++---------------
 include/linux/usb/usbnet.h     |  1 -
 10 files changed, 149 insertions(+), 188 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 0722050dbe32..0ff4ca58fbc5 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -201,7 +201,7 @@ static void aqc111_get_drvinfo(struct net_device *net,
 			       struct ethtool_drvinfo *info)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 
 	/* Inherit standard device info */
 	usbnet_get_drvinfo(net, info);
@@ -215,7 +215,7 @@ static void aqc111_get_wol(struct net_device *net,
 			   struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 
 	wolinfo->supported = WAKE_MAGIC;
 	wolinfo->wolopts = 0;
@@ -228,7 +228,7 @@ static int aqc111_set_wol(struct net_device *net,
 			  struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 
 	if (wolinfo->wolopts & ~WAKE_MAGIC)
 		return -EINVAL;
@@ -267,7 +267,7 @@ static int aqc111_get_link_ksettings(struct net_device *net,
 				     struct ethtool_link_ksettings *elk)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	enum usb_device_speed usb_speed = dev->udev->speed;
 	u32 speed = SPEED_UNKNOWN;
 
@@ -320,7 +320,7 @@ static int aqc111_get_link_ksettings(struct net_device *net,
 
 static void aqc111_set_phy_speed(struct usbnet *dev, u8 autoneg, u16 speed)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 
 	aqc111_data->phy_cfg &= ~AQ_ADV_MASK;
 	aqc111_data->phy_cfg |= AQ_PAUSE;
@@ -369,7 +369,7 @@ static int aqc111_set_link_ksettings(struct net_device *net,
 				     const struct ethtool_link_ksettings *elk)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	enum usb_device_speed usb_speed = dev->udev->speed;
 	u8 autoneg = elk->base.autoneg;
 	u32 speed = elk->base.speed;
@@ -529,7 +529,7 @@ static int aqc111_vlan_rx_add_vid(struct net_device *net, __be16 proto, u16 vid)
 static void aqc111_set_rx_mode(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	int mc_count = 0;
 
 	mc_count = netdev_mc_count(net);
@@ -567,7 +567,7 @@ static int aqc111_set_features(struct net_device *net,
 			       netdev_features_t features)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	netdev_features_t changed = net->features ^ features;
 	u16 reg16 = 0;
 	u8 reg8 = 0;
@@ -703,13 +703,6 @@ static int aqc111_bind(struct usbnet *dev, struct usb_interface *intf)
 		return ret;
 	}
 
-	aqc111_data = kzalloc(sizeof(*aqc111_data), GFP_KERNEL);
-	if (!aqc111_data)
-		return -ENOMEM;
-
-	/* store aqc111_data pointer in device data field */
-	dev->driver_priv = aqc111_data;
-
 	/* Init the MAC address */
 	ret = aqc111_read_perm_mac(dev);
 	if (ret)
@@ -746,13 +739,12 @@ static int aqc111_bind(struct usbnet *dev, struct usb_interface *intf)
 	return 0;
 
 out:
-	kfree(aqc111_data);
 	return ret;
 }
 
 static void aqc111_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u16 reg16;
 
 	/* Force bz */
@@ -775,7 +767,7 @@ static void aqc111_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static void aqc111_status(struct usbnet *dev, struct urb *urb)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u64 *event_data = NULL;
 	int link = 0;
 
@@ -900,7 +892,7 @@ static void aqc111_configure_csum_offload(struct usbnet *dev)
 
 static int aqc111_link_reset(struct usbnet *dev)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u16 reg16 = 0;
 	u8 reg8 = 0;
 
@@ -989,7 +981,7 @@ static int aqc111_link_reset(struct usbnet *dev)
 
 static int aqc111_reset(struct usbnet *dev)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u8 reg8 = 0;
 
 	dev->rx_urb_size = URB_SIZE;
@@ -1033,7 +1025,7 @@ static int aqc111_reset(struct usbnet *dev)
 
 static int aqc111_stop(struct usbnet *dev)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u16 reg16 = 0;
 
 	aqc111_read16_cmd(dev, AQ_ACCESS_MAC, SFR_MEDIUM_STATUS_MODE,
@@ -1071,7 +1063,7 @@ static void aqc111_rx_checksum(struct sk_buff *skb, u64 pkt_desc)
 
 static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	struct sk_buff *new_skb = NULL;
 	u32 pkt_total_offset = 0;
 	u64 *pkt_desc_ptr = NULL;
@@ -1251,6 +1243,7 @@ static const struct driver_info aqc111_info = {
 			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
 	.rx_fixup	= aqc111_rx_fixup,
 	.tx_fixup	= aqc111_tx_fixup,
+	.required_room	= sizeof(struct aqc111_data),
 };
 
 #define ASIX111_DESC \
@@ -1268,6 +1261,7 @@ static const struct driver_info asix111_info = {
 			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
 	.rx_fixup	= aqc111_rx_fixup,
 	.tx_fixup	= aqc111_tx_fixup,
+	.required_room  = sizeof(struct aqc111_data),
 };
 
 #undef ASIX111_DESC
@@ -1287,6 +1281,7 @@ static const struct driver_info asix112_info = {
 			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
 	.rx_fixup	= aqc111_rx_fixup,
 	.tx_fixup	= aqc111_tx_fixup,
+	.required_room  = sizeof(struct aqc111_data),
 };
 
 #undef ASIX112_DESC
@@ -1303,6 +1298,7 @@ static const struct driver_info trendnet_info = {
 			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
 	.rx_fixup	= aqc111_rx_fixup,
 	.tx_fixup	= aqc111_tx_fixup,
+	.required_room  = sizeof(struct aqc111_data),
 };
 
 static const struct driver_info qnap_info = {
@@ -1317,12 +1313,13 @@ static const struct driver_info qnap_info = {
 			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
 	.rx_fixup	= aqc111_rx_fixup,
 	.tx_fixup	= aqc111_tx_fixup,
+	.required_room  = sizeof(struct aqc111_data),
 };
 
 static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u16 temp_rx_ctrl = 0x00;
 	u16 reg16;
 	u8 reg8;
@@ -1418,7 +1415,7 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 static int aqc111_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct aqc111_data *aqc111_data = dev->driver_priv;
+	struct aqc111_data *aqc111_data = (struct aqc111_data *)dev->private;
 	u16 reg16;
 	u8 reg8;
 
diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index cf97bc3d388b..9bcfeada7175 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -159,7 +159,6 @@
 
 #define AX_EMBD_PHY_ADDR	0x10
 
-/* This structure cannot exceed sizeof(unsigned long [5]) AKA 20 bytes */
 struct asix_data {
 	u8 multi_filter[AX_MCAST_FILTER_SIZE];
 	u8 mac_addr[ETH_ALEN];
@@ -182,6 +181,7 @@ struct asix_common_private {
 	u16 presvd_phy_advertise;
 	u16 presvd_phy_bmcr;
 	struct asix_rx_fixup_info rx_fixup_info;
+	struct asix_data asix_data;
 	struct mii_bus *mdio;
 	struct phy_device *phydev;
 	struct phy_device *phydev_int;
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index d97a1920cb6e..f10cdd7dba5e 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -241,7 +241,7 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
 
 int asix_rx_fixup_common(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct asix_common_private *dp = dev->driver_priv;
+	struct asix_common_private *dp = (struct asix_common_private *)dev->private;
 	struct asix_rx_fixup_info *rx = &dp->rx_fixup_info;
 
 	return asix_rx_fixup_internal(dev, skb, rx);
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 5100e0b31f1f..e21ed81bc6e4 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -118,7 +118,8 @@ static const struct ethtool_ops ax88172_ethtool_ops = {
 static void ax88172_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct asix_data *data = (struct asix_data *)&dev->private;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	u8 rx_ctl = 0x8c;
 
 	if (net->flags & IFF_PROMISC) {
@@ -129,10 +130,6 @@ static void ax88172_set_multicast(struct net_device *net)
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
-		/* We use the 20 byte dev->private
-		 * for our 8 byte filter buffer
-		 * to avoid allocating memory that
-		 * is tricky to free later */
 		struct netdev_hw_addr *ha;
 		u32 crc_bits;
 
@@ -295,7 +292,7 @@ static void ax88772_ethtool_get_pauseparam(struct net_device *ndev,
 					  struct ethtool_pauseparam *pause)
 {
 	struct usbnet *dev = netdev_priv(ndev);
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
 	phylink_ethtool_get_pauseparam(priv->phylink, pause);
 }
@@ -304,7 +301,7 @@ static int ax88772_ethtool_set_pauseparam(struct net_device *ndev,
 					 struct ethtool_pauseparam *pause)
 {
 	struct usbnet *dev = netdev_priv(ndev);
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
 	return phylink_ethtool_set_pauseparam(priv->phylink, pause);
 }
@@ -331,8 +328,8 @@ static const struct ethtool_ops ax88772_ethtool_ops = {
 
 static int ax88772_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	int ret;
 
 	/* Rewrite MAC address */
@@ -361,8 +358,8 @@ static int ax88772_reset(struct usbnet *dev)
 
 static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	u16 rx_ctl;
 	int ret;
 
@@ -455,8 +452,8 @@ static int ax88772_hw_reset(struct usbnet *dev, int in_pm)
 
 static int ax88772a_hw_reset(struct usbnet *dev, int in_pm)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	u16 rx_ctl, phy14h, phy15h, phy16h;
 	int ret;
 
@@ -595,7 +592,7 @@ static const struct net_device_ops ax88772_netdev_ops = {
 
 static void ax88772_suspend(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	u16 medium;
 
 	if (netif_running(dev->net)) {
@@ -631,9 +628,9 @@ static void ax88772_suspend(struct usbnet *dev)
 static int asix_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
-	if (priv && priv->suspend)
+	if (priv->suspend)
 		priv->suspend(dev);
 
 	return usbnet_suspend(intf, message);
@@ -641,7 +638,7 @@ static int asix_suspend(struct usb_interface *intf, pm_message_t message)
 
 static void ax88772_resume(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	int i;
 
 	for (i = 0; i < 3; i++)
@@ -658,7 +655,7 @@ static void ax88772_resume(struct usbnet *dev)
 static int asix_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
 	if (priv && priv->resume)
 		priv->resume(dev);
@@ -668,7 +665,7 @@ static int asix_resume(struct usb_interface *intf)
 
 static int ax88772_init_mdio(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	int ret;
 
 	priv->mdio = mdiobus_alloc();
@@ -702,7 +699,7 @@ static void ax88772_mdio_unregister(struct asix_common_private *priv)
 
 static int ax88772_init_phy(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	int ret;
 
 	priv->phydev = mdiobus_get_phy(priv->mdio, priv->phy_addr);
@@ -796,7 +793,7 @@ static const struct phylink_mac_ops ax88772_phylink_mac_ops = {
 
 static int ax88772_phylink_setup(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	phy_interface_t phy_if_mode;
 	struct phylink *phylink;
 
@@ -826,16 +823,10 @@ static int ax88772_phylink_setup(struct usbnet *dev)
 
 static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct asix_common_private *priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	u8 buf[ETH_ALEN] = {0};
 	int ret, i;
 
-	priv = devm_kzalloc(&dev->udev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev->driver_priv = priv;
-
 	ret = usbnet_get_endpoints(dev, intf);
 	if (ret)
 		return ret;
@@ -943,7 +934,7 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static int ax88772_stop(struct usbnet *dev)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
 	phylink_stop(priv->phylink);
 
@@ -952,22 +943,23 @@ static int ax88772_stop(struct usbnet *dev)
 
 static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct asix_common_private *priv = dev->driver_priv;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 
 	rtnl_lock();
 	phylink_disconnect_phy(priv->phylink);
 	rtnl_unlock();
 	phylink_destroy(priv->phylink);
 	ax88772_mdio_unregister(priv);
-	asix_rx_fixup_common_free(dev->driver_priv);
+	asix_rx_fixup_common_free(priv);
 	/* Drop the PM usage ref taken in bind() */
 	pm_runtime_put(&intf->dev);
 }
 
 static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	asix_rx_fixup_common_free(dev->driver_priv);
-	kfree(dev->driver_priv);
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+
+	asix_rx_fixup_common_free(priv);
 }
 
 static const struct ethtool_ops ax88178_ethtool_ops = {
@@ -987,7 +979,8 @@ static const struct ethtool_ops ax88178_ethtool_ops = {
 
 static int marvell_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	u16 reg;
 
 	netdev_dbg(dev->net, "marvell_phy_init()\n");
@@ -1018,7 +1011,8 @@ static int marvell_phy_init(struct usbnet *dev)
 
 static int rtl8211cl_phy_init(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 
 	netdev_dbg(dev->net, "rtl8211cl_phy_init()\n");
 
@@ -1065,7 +1059,8 @@ static int marvell_led_status(struct usbnet *dev, u16 speed)
 
 static int ax88178_reset(struct usbnet *dev)
 {
-	struct asix_data *data = (struct asix_data *)&dev->private;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
+	struct asix_data *data = &priv->asix_data;
 	int ret;
 	__le16 eeprom;
 	u8 status;
@@ -1161,9 +1156,10 @@ static int ax88178_reset(struct usbnet *dev)
 
 static int ax88178_link_reset(struct usbnet *dev)
 {
-	u16 mode;
+	struct asix_common_private *priv = (struct asix_common_private *)dev->private;
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct asix_data *data = (struct asix_data *)&dev->private;
+	struct asix_data *data = &priv->asix_data;
+	u16 mode;
 	u32 speed;
 
 	netdev_dbg(dev->net, "ax88178_link_reset()\n");
@@ -1314,10 +1310,6 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev->rx_urb_size = 2048;
 	}
 
-	dev->driver_priv = kzalloc(sizeof(struct asix_common_private), GFP_KERNEL);
-	if (!dev->driver_priv)
-			return -ENOMEM;
-
 	return 0;
 }
 
diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index 34884805730d..b7f7dd57e4c5 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -30,7 +30,7 @@ static void ax88172a_adjust_link(struct net_device *netdev)
 {
 	struct phy_device *phydev = netdev->phydev;
 	struct usbnet *dev = netdev_priv(netdev);
-	struct ax88172a_private *priv = dev->driver_priv;
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 	u16 mode = 0;
 
 	if (phydev->link) {
@@ -60,7 +60,7 @@ static void ax88172a_status(struct usbnet *dev, struct urb *urb)
 /* use phylib infrastructure */
 static int ax88172a_init_mdio(struct usbnet *dev)
 {
-	struct ax88172a_private *priv = dev->driver_priv;
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 	int ret;
 
 	priv->mdio = mdiobus_alloc();
@@ -93,7 +93,7 @@ static int ax88172a_init_mdio(struct usbnet *dev)
 
 static void ax88172a_remove_mdio(struct usbnet *dev)
 {
-	struct ax88172a_private *priv = dev->driver_priv;
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 
 	netdev_info(dev->net, "deregistering mdio bus %s\n", priv->mdio->id);
 	mdiobus_unregister(priv->mdio);
@@ -159,18 +159,12 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int ret;
 	u8 buf[ETH_ALEN];
-	struct ax88172a_private *priv;
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 
 	ret = usbnet_get_endpoints(dev, intf);
 	if (ret)
 		return ret;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev->driver_priv = priv;
-
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
 	if (ret < ETH_ALEN) {
@@ -230,13 +224,12 @@ static int ax88172a_bind(struct usbnet *dev, struct usb_interface *intf)
 	return 0;
 
 free:
-	kfree(priv);
 	return ret;
 }
 
 static int ax88172a_stop(struct usbnet *dev)
-{
-	struct ax88172a_private *priv = dev->driver_priv;
+	{
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 
 	netdev_dbg(dev->net, "Stopping interface\n");
 
@@ -252,16 +245,13 @@ static int ax88172a_stop(struct usbnet *dev)
 
 static void ax88172a_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct ax88172a_private *priv = dev->driver_priv;
-
 	ax88172a_remove_mdio(dev);
-	kfree(priv);
 }
 
 static int ax88172a_reset(struct usbnet *dev)
 {
+	struct ax88172a_private *priv = (struct ax88172a_private *)dev->private;
 	struct asix_data *data = (struct asix_data *)&dev->private;
-	struct ax88172a_private *priv = dev->driver_priv;
 	int ret;
 	u16 rx_ctl;
 
@@ -338,7 +328,7 @@ static int ax88172a_reset(struct usbnet *dev)
 
 static int ax88172a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	struct ax88172a_private *dp = dev->driver_priv;
+	struct ax88172a_private *dp = (struct ax88172a_private *)dev->private;
 	struct asix_rx_fixup_info *rx = &dp->rx_fixup_info;
 
 	return asix_rx_fixup_internal(dev, skb, rx);
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index df7e3f1c3672..cc88f8faaca1 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -173,6 +173,7 @@ struct ax88179_data {
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
+	u8 m_filter[8];
 	u8 disconnecting;
 };
 
@@ -192,14 +193,14 @@ static const struct {
 
 static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
 {
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 
 	ax179_data->in_pm = pm_mode;
 }
 
 static int ax88179_in_pm(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 
 	return ax179_data->in_pm;
 }
@@ -209,7 +210,7 @@ static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 
 	BUG_ON(!dev);
 
@@ -233,7 +234,7 @@ static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 {
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 
 	BUG_ON(!dev);
 
@@ -406,7 +407,7 @@ ax88179_phy_write_mmd_indirect(struct usbnet *dev, u16 prtad, u16 devad,
 static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 	u16 tmp16;
 	u8 tmp8;
 
@@ -504,7 +505,7 @@ static void ax88179_disconnect(struct usb_interface *intf)
 	if (!dev)
 		return;
 
-	ax179_data = dev->driver_priv;
+	ax179_data = (struct ax88179_data *)dev->private;
 	ax179_data->disconnecting = 1;
 
 	usbnet_disconnect(intf);
@@ -514,7 +515,7 @@ static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 
 	wolinfo->supported = priv->wol_supported;
 	wolinfo->wolopts = priv->wolopts;
@@ -524,7 +525,7 @@ static int
 ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 
 	if (wolinfo->wolopts & ~(priv->wol_supported))
 		return -EINVAL;
@@ -708,7 +709,7 @@ ax88179_ethtool_set_eee(struct usbnet *dev, struct ethtool_keee *data)
 static int ax88179_chk_eee(struct usbnet *dev)
 {
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
@@ -811,7 +812,7 @@ static void ax88179_enable_eee(struct usbnet *dev)
 static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 
 	edata->eee_enabled = priv->eee_enabled;
 	edata->eee_active = priv->eee_active;
@@ -822,7 +823,7 @@ static int ax88179_get_eee(struct net_device *net, struct ethtool_keee *edata)
 static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = dev->driver_priv;
+	struct ax88179_data *priv = (struct ax88179_data *)dev->private;
 	int ret;
 
 	priv->eee_enabled = edata->eee_enabled;
@@ -867,8 +868,8 @@ static const struct ethtool_ops ax88179_ethtool_ops = {
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = dev->driver_priv;
-	u8 *m_filter = ((u8 *)dev->private);
+	struct ax88179_data *data = (struct ax88179_data *)dev->private;
+	u8 *m_filter = data->m_filter;
 
 	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
 
@@ -1280,19 +1281,12 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct ax88179_data *ax179_data;
 	int ret;
 
 	ret = usbnet_get_endpoints(dev, intf);
 	if (ret < 0)
 		return ret;
 
-	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
-	if (!ax179_data)
-		return -ENOMEM;
-
-	dev->driver_priv = ax179_data;
-
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
 	dev->net->needed_headroom = 8;
@@ -1321,7 +1315,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
 	/* Configure RX control register => stop operation */
@@ -1334,8 +1327,6 @@ static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 	/* Power down ethernet PHY */
 	tmp16 = 0;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
-
-	kfree(ax179_data);
 }
 
 static void
@@ -1507,7 +1498,7 @@ ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 
 static int ax88179_link_reset(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 	u8 tmp[5], link_sts;
 	u16 mode, tmp16, delay = HZ / 10;
 	u32 tmp32 = 0x40000000;
@@ -1585,7 +1576,7 @@ static int ax88179_reset(struct usbnet *dev)
 	u8 buf[5];
 	u16 *tmp16;
 	u8 *tmp;
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->private;
 	struct ethtool_keee eee_data;
 
 	tmp16 = (u16 *)buf;
@@ -1718,6 +1709,7 @@ static const struct driver_info ax88179_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info ax88178a_info = {
@@ -1731,6 +1723,7 @@ static const struct driver_info ax88178a_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info cypress_GX3_info = {
@@ -1744,6 +1737,7 @@ static const struct driver_info cypress_GX3_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info dlink_dub1312_info = {
@@ -1757,6 +1751,7 @@ static const struct driver_info dlink_dub1312_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info sitecom_info = {
@@ -1770,6 +1765,7 @@ static const struct driver_info sitecom_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info samsung_info = {
@@ -1783,6 +1779,7 @@ static const struct driver_info samsung_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info lenovo_info = {
@@ -1796,6 +1793,7 @@ static const struct driver_info lenovo_info = {
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info belkin_info = {
@@ -1809,6 +1807,7 @@ static const struct driver_info belkin_info = {
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info toshiba_info = {
@@ -1822,6 +1821,7 @@ static const struct driver_info toshiba_info = {
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info mct_info = {
@@ -1835,6 +1835,7 @@ static const struct driver_info mct_info = {
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info at_umc2000_info = {
@@ -1848,6 +1849,7 @@ static const struct driver_info at_umc2000_info = {
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info at_umc200_info = {
@@ -1861,6 +1863,7 @@ static const struct driver_info at_umc200_info = {
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct driver_info at_umc2000sp_info = {
@@ -1874,6 +1877,7 @@ static const struct driver_info at_umc2000sp_info = {
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
 	.tx_fixup = ax88179_tx_fixup,
+	.required_room = sizeof(struct ax88179_data),
 };
 
 static const struct usb_device_id products[] = {
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index ebbaee0575a8..05ba7c00a943 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -43,6 +43,10 @@ enum cx82310_status {
 struct cx82310_priv {
 	struct work_struct reenable_work;
 	struct usbnet *dev;
+
+	unsigned int partial_len;		/* length of partial packet data */
+	unsigned int partial_rem;		/* remaining (missing) data length */
+	u8 *partial_data;			/* partial packet data */
 };
 
 /*
@@ -134,10 +138,6 @@ static void cx82310_reenable_work(struct work_struct *work)
 	cx82310_enable_ethernet(priv->dev);
 }
 
-#define partial_len	private[0]		/* length of partial packet data */
-#define partial_rem	private[1]		/* remaining (missing) data length */
-#define partial_data	private[2]		/* partial packet data */
-
 static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int ret;
@@ -145,7 +145,7 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	struct usb_device *udev = dev->udev;
 	u8 link[3];
 	int timeout = 50;
-	struct cx82310_priv *priv;
+	struct cx82310_priv *priv = (struct cx82310_priv*)dev->private;
 	u8 addr[ETH_ALEN];
 
 	/* avoid ADSL modems - continue only if iProduct is "USB NET CARD" */
@@ -169,16 +169,10 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 	/* we can receive URBs up to 4KB from the device */
 	dev->rx_urb_size = 4096;
 
-	dev->partial_data = (unsigned long) kmalloc(dev->hard_mtu, GFP_KERNEL);
-	if (!dev->partial_data)
+	priv->partial_data = kmalloc(dev->hard_mtu, GFP_KERNEL);
+	if (!priv->partial_data)
 		return -ENOMEM;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto err_partial;
-	}
-	dev->driver_priv = priv;
 	INIT_WORK(&priv->reenable_work, cx82310_reenable_work);
 	priv->dev = dev;
 
@@ -217,19 +211,16 @@ static int cx82310_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	return 0;
 err:
-	kfree(dev->driver_priv);
-err_partial:
-	kfree((void *)dev->partial_data);
+	kfree(priv->partial_data);
 	return ret;
 }
 
 static void cx82310_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct cx82310_priv *priv = dev->driver_priv;
+	struct cx82310_priv *priv = (struct cx82310_priv*)dev->private;
 
-	kfree((void *)dev->partial_data);
+	kfree(priv->partial_data);
 	cancel_work_sync(&priv->reenable_work);
-	kfree(dev->driver_priv);
 }
 
 /*
@@ -244,25 +235,25 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
 	int len;
 	struct sk_buff *skb2;
-	struct cx82310_priv *priv = dev->driver_priv;
+	struct cx82310_priv *priv = (struct cx82310_priv*)dev->private;
 
 	/*
 	 * If the last skb ended with an incomplete packet, this skb contains
 	 * end of that packet at the beginning.
 	 */
-	if (dev->partial_rem) {
-		len = dev->partial_len + dev->partial_rem;
+	if (priv->partial_rem) {
+		len = priv->partial_len + priv->partial_rem;
 		skb2 = alloc_skb(len, GFP_ATOMIC);
 		if (!skb2)
 			return 0;
 		skb_put(skb2, len);
-		memcpy(skb2->data, (void *)dev->partial_data,
-		       dev->partial_len);
-		memcpy(skb2->data + dev->partial_len, skb->data,
-		       dev->partial_rem);
+		memcpy(skb2->data, (void *)priv->partial_data,
+		       priv->partial_len);
+		memcpy(skb2->data + priv->partial_len, skb->data,
+		       priv->partial_rem);
 		usbnet_skb_return(dev, skb2);
-		skb_pull(skb, (dev->partial_rem + 1) & ~1);
-		dev->partial_rem = 0;
+		skb_pull(skb, (priv->partial_rem + 1) & ~1);
+		priv->partial_rem = 0;
 		if (skb->len < 2)
 			return 1;
 	}
@@ -289,10 +280,10 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		/* incomplete packet, save it for the next skb */
 		if (len > skb->len) {
-			dev->partial_len = skb->len;
-			dev->partial_rem = len - skb->len;
-			memcpy((void *)dev->partial_data, skb->data,
-			       dev->partial_len);
+			priv->partial_len = skb->len;
+			priv->partial_rem = len - skb->len;
+			memcpy((void *)priv->partial_data, skb->data,
+			       priv->partial_len);
 			skb_pull(skb, skb->len);
 			break;
 		}
@@ -338,6 +329,7 @@ static const struct driver_info	cx82310_info = {
 	.unbind		= cx82310_unbind,
 	.rx_fixup	= cx82310_rx_fixup,
 	.tx_fixup	= cx82310_tx_fixup,
+	.required_room	= sizeof(struct cx82310_priv),
 };
 
 #define USB_DEVICE_CLASS(vend, prod, cl, sc, pr) \
diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index b2495fa80171..ed6dff959245 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -56,18 +56,10 @@ struct vl600_state {
 static int vl600_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	int ret;
-	struct vl600_state *s = kzalloc(sizeof(struct vl600_state), GFP_KERNEL);
-
-	if (!s)
-		return -ENOMEM;
 
 	ret = usbnet_cdc_bind(dev, intf);
-	if (ret) {
-		kfree(s);
+	if (ret)
 		return ret;
-	}
-
-	dev->driver_priv = s;
 
 	/* ARP packets don't go through, but they're also of no use.  The
 	 * subnet has only two hosts anyway: us and the gateway / DHCP
@@ -85,7 +77,7 @@ static int vl600_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void vl600_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct vl600_state *s = dev->driver_priv;
+	struct vl600_state *s = (struct vl600_state *)dev->private;
 
 	dev_kfree_skb(s->current_rx_buf);
 	kfree(s);
@@ -101,7 +93,7 @@ static int vl600_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	int packet_len, count;
 	struct sk_buff *buf = skb;
 	struct sk_buff *clone;
-	struct vl600_state *s = dev->driver_priv;
+	struct vl600_state *s = (struct vl600_state *)dev->private;
 
 	/* Frame lengths are generally 4B multiplies but every couple of
 	 * hours there's an odd number of bytes sized yet correct frame,
@@ -306,6 +298,7 @@ static const struct driver_info	vl600_info = {
 	.status		= usbnet_cdc_status,
 	.rx_fixup	= vl600_rx_fixup,
 	.tx_fixup	= vl600_tx_fixup,
+	.required_room	= sizeof(struct vl600_state),
 };
 
 static const struct usb_device_id products[] = {
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 7ecf98d97493..a99d4363fd3f 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -84,7 +84,7 @@ MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
 static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 					  u32 *data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, void *, u16);
@@ -115,7 +115,7 @@ static int __must_check smsc95xx_read_reg(struct usbnet *dev, u32 index,
 static int __must_check smsc95xx_write_reg(struct usbnet *dev, u32 index,
 					   u32 data)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 buf;
 	int ret;
 	int (*fn)(struct usbnet *, u8, u8, u16, u16, const void *, u16);
@@ -265,7 +265,7 @@ static int smsc95xx_mdiobus_reset(struct mii_bus *bus)
 	int ret;
 
 	dev = bus->priv;
-	pdata = dev->driver_priv;
+	pdata = (struct smsc95xx_priv *)dev->private;
 
 	if (pdata->is_internal_phy)
 		return 0;
@@ -481,7 +481,7 @@ static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
 static void smsc95xx_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	unsigned long flags;
 	int ret;
 
@@ -539,7 +539,7 @@ static void smsc95xx_set_multicast(struct net_device *netdev)
 
 static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 flow = 0, afc_cfg;
 
 	int ret = smsc95xx_read_reg(dev, AFC_CFG, &afc_cfg);
@@ -584,7 +584,7 @@ static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 
 static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	unsigned long flags;
 	int ret;
 
@@ -613,7 +613,7 @@ static void smsc95xx_mac_update_fullduplex(struct usbnet *dev)
 
 static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	unsigned long flags;
 	u32 intdata;
 
@@ -730,7 +730,7 @@ static void smsc95xx_ethtool_get_wol(struct net_device *net,
 				     struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 
 	wolinfo->supported = SUPPORTED_WAKE;
 	wolinfo->wolopts = pdata->wolopts;
@@ -740,7 +740,7 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 				    struct ethtool_wolinfo *wolinfo)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	int ret;
 
 	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
@@ -788,7 +788,7 @@ static void smsc95xx_get_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = (struct smsc95xx_priv *)dev->private;
 
 	pause->autoneg = pdata->pause_autoneg;
 	pause->rx_pause = pdata->pause_rx;
@@ -804,7 +804,7 @@ static int smsc95xx_set_pauseparam(struct net_device *ndev,
 	struct usbnet *dev;
 
 	dev = netdev_priv(ndev);
-	pdata = dev->driver_priv;
+	pdata = (struct smsc95xx_priv *)dev->private;
 	phydev = ndev->phydev;
 
 	if (!phydev)
@@ -898,7 +898,7 @@ static int smsc95xx_set_mac_address(struct usbnet *dev)
 /* starts the TX path */
 static int smsc95xx_start_tx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	unsigned long flags;
 	int ret;
 
@@ -918,7 +918,7 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
 /* Starts the Receive path */
 static int smsc95xx_start_rx_path(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
@@ -930,7 +930,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev)
 
 static int smsc95xx_reset(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
@@ -1146,7 +1146,7 @@ static void smsc95xx_handle_link_change(struct net_device *net)
 
 static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	char usb_path[64];
 	int ret, phy_irq;
 	u32 val;
@@ -1157,12 +1157,6 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		return ret;
 	}
 
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	dev->driver_priv = pdata;
-
 	spin_lock_init(&pdata->mac_cr_lock);
 
 	/* LAN95xx devices do not alter the computed checksum of 0 to 0xffff.
@@ -1316,7 +1310,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 
 static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 
 	phy_disconnect(dev->net->phydev);
 	mdiobus_unregister(pdata->mdiobus);
@@ -1325,7 +1319,6 @@ static void smsc95xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 	irq_domain_remove(pdata->irqdomain);
 	irq_domain_free_fwnode(pdata->irqfwnode);
 	netif_dbg(dev, ifdown, dev->net, "free pdata\n");
-	kfree(pdata);
 }
 
 static int smsc95xx_start_phy(struct usbnet *dev)
@@ -1350,7 +1343,7 @@ static u32 smsc_crc(const u8 *buffer, size_t len, int filter)
 
 static int smsc95xx_link_ok(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	int ret;
 
 	/* first, a dummy read, needed to latch some MII phys */
@@ -1367,7 +1360,7 @@ static int smsc95xx_link_ok(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend0(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 val;
 	int ret;
 
@@ -1406,7 +1399,7 @@ static int smsc95xx_enter_suspend0(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend1(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	int ret, phy_id = pdata->phydev->mdio.addr;
 	u32 val;
 
@@ -1453,7 +1446,7 @@ static int smsc95xx_enter_suspend1(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend2(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 val;
 	int ret;
 
@@ -1475,7 +1468,7 @@ static int smsc95xx_enter_suspend2(struct usbnet *dev)
 
 static int smsc95xx_enter_suspend3(struct usbnet *dev)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 val;
 	int ret;
 
@@ -1514,7 +1507,7 @@ static int smsc95xx_enter_suspend3(struct usbnet *dev)
 
 static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 
 	if (!netif_running(dev->net)) {
 		/* interface is ifconfig down so fully power down hw */
@@ -1544,7 +1537,7 @@ static int smsc95xx_autosuspend(struct usbnet *dev, u32 link_up)
 static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	u32 val, link_up;
 	int ret;
 
@@ -1805,7 +1798,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 	u32 val;
 
 	BUG_ON(!dev);
-	pdata = dev->driver_priv;
+	pdata = (struct smsc95xx_priv *)dev->private;
 	suspend_flags = pdata->suspend_flags;
 
 	netdev_dbg(dev->net, "resume suspend_flags=0x%02x\n", suspend_flags);
@@ -1854,7 +1847,7 @@ static int smsc95xx_resume(struct usb_interface *intf)
 static int smsc95xx_reset_resume(struct usb_interface *intf)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 	int ret;
 
 	pdata->pm_task = current;
@@ -2038,7 +2031,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 
 static int smsc95xx_manage_power(struct usbnet *dev, int on)
 {
-	struct smsc95xx_priv *pdata = dev->driver_priv;
+	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)dev->private;
 
 	dev->intf->needs_remote_wakeup = on;
 
@@ -2068,6 +2061,7 @@ static const struct driver_info smsc95xx_info = {
 	.status		= smsc95xx_status,
 	.manage_power	= smsc95xx_manage_power,
 	.flags		= FLAG_ETHER | FLAG_SEND_ZLP | FLAG_LINK_INTR,
+	.required_room	= sizeof(struct smsc95xx_priv),
 };
 
 static const struct usb_device_id products[] = {
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index ba45a3e2be6a..ec90a12eb26c 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -35,7 +35,6 @@ struct usbnet {
 	struct usb_interface	*intf;
 	const struct driver_info *driver_info;
 	const char		*driver_name;
-	void			*driver_priv;
 	wait_queue_head_t	wait;
 	struct mutex		phy_mutex;
 	unsigned char		suspend_count;
-- 
2.53.0


