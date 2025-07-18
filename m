Return-Path: <netdev+bounces-208099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C028B09CF5
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5FC1C43A34
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB94291C3A;
	Fri, 18 Jul 2025 07:52:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1D291882
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825128; cv=none; b=snLP8UqVYj3ys+KCMeG4P7xzXiiCVwRTszS+4BZDMXpM2h2jLnSa+iGO0strEuEdwHm/ZRPIGBuQ+fmgKUVCSYn84ADpUteAyS51vHA9vSbprRihoJk1/oNLiabX5yTHBYBPQhF0uNVQOgnx+/PSbg3Jpq1XuvxTiaTh1w/0vHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825128; c=relaxed/simple;
	bh=AaKcgNe71sb7S6nbkCZavd6gw0BvsHajGOmUPXABzJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OgwaaHR7pFoaJ+t9VR+Dh6xu6oZYKRacMaZY2mb2WSGGodWlmyZFTBcIQS8d/p2pXsr0faa+9YvkKhQ6evUVz2/FnDXYq1gftmLBjHYXXXLfL0fkT5j11AVLvijM8DSVPgbOo1lqbe0swgGCs2Ksjy8L2K+G2hmwYN9yjzV2g7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ucfst-0003Vl-MC; Fri, 18 Jul 2025 09:51:59 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ucfst-0092Ux-0Z;
	Fri, 18 Jul 2025 09:51:59 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ucfst-001FVi-0M;
	Fri, 18 Jul 2025 09:51:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Steve Glendinning <steve.glendinning@shawell.net>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v1 1/1] net: usb: smsc95xx: add support for ethtool pause parameters
Date: Fri, 18 Jul 2025 09:51:56 +0200
Message-Id: <20250718075157.297923-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Implement ethtool .get_pauseparam and .set_pauseparam handlers for
configuring flow control on smsc95xx. The driver now supports enabling
or disabling transmit and receive pause frames, with or without
autonegotiation. Pause settings are applied during link-up based on
current PHY state and user configuration.

Previously, the driver used phy_get_pause() during link-up handling,
but lacked initialization and an ethtool interface to configure pause
modes. As a result, flow control support was effectively non-functional.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/smsc95xx.c | 72 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 8e82184be5e7..de733e0488bf 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -63,6 +63,9 @@ struct smsc95xx_priv {
 	u32 hash_hi;
 	u32 hash_lo;
 	u32 wolopts;
+	bool pause_rx;
+	bool pause_tx;
+	bool pause_autoneg;
 	spinlock_t mac_cr_lock;
 	u8 features;
 	u8 suspend_flags;
@@ -537,16 +540,23 @@ static void smsc95xx_set_multicast(struct net_device *netdev)
 
 static int smsc95xx_phy_update_flowcontrol(struct usbnet *dev)
 {
-	u32 flow = 0, afc_cfg;
 	struct smsc95xx_priv *pdata = dev->driver_priv;
-	bool tx_pause, rx_pause;
+	u32 flow = 0, afc_cfg;
 
 	int ret = smsc95xx_read_reg(dev, AFC_CFG, &afc_cfg);
 	if (ret < 0)
 		return ret;
 
 	if (pdata->phydev->duplex == DUPLEX_FULL) {
-		phy_get_pause(pdata->phydev, &tx_pause, &rx_pause);
+		bool tx_pause, rx_pause;
+
+		if (pdata->phydev->autoneg == AUTONEG_ENABLE &&
+		    pdata->pause_autoneg) {
+			phy_get_pause(pdata->phydev, &tx_pause, &rx_pause);
+		} else {
+			tx_pause = pdata->pause_tx;
+			rx_pause = pdata->pause_rx;
+		}
 
 		if (rx_pause)
 			flow = 0xFFFF0002;
@@ -772,6 +782,55 @@ static int smsc95xx_ethtool_get_sset_count(struct net_device *ndev, int sset)
 	}
 }
 
+static void smsc95xx_get_pauseparam(struct net_device *ndev,
+				    struct ethtool_pauseparam *pause)
+{
+	struct smsc95xx_priv *pdata;
+	struct usbnet *dev;
+
+	dev = netdev_priv(ndev);
+	pdata = dev->driver_priv;
+
+	pause->autoneg = pdata->pause_autoneg;
+	pause->rx_pause = pdata->pause_rx;
+	pause->tx_pause = pdata->pause_tx;
+}
+
+static int smsc95xx_set_pauseparam(struct net_device *ndev,
+				   struct ethtool_pauseparam *pause)
+{
+	bool pause_autoneg_rx, pause_autoneg_tx;
+	struct smsc95xx_priv *pdata;
+	struct phy_device *phydev;
+	struct usbnet *dev;
+
+	dev = netdev_priv(ndev);
+	pdata = dev->driver_priv;
+	phydev = ndev->phydev;
+
+	if (!phydev)
+		return -ENODEV;
+
+	pdata->pause_rx = pause->rx_pause;
+	pdata->pause_tx = pause->tx_pause;
+	pdata->pause_autoneg = pause->autoneg;
+
+	if (pause->autoneg) {
+		pause_autoneg_rx = pause->rx_pause;
+		pause_autoneg_tx = pause->tx_pause;
+	} else {
+		pause_autoneg_rx = false;
+		pause_autoneg_tx = false;
+	}
+
+	phy_set_asym_pause(ndev->phydev, pause_autoneg_rx, pause_autoneg_tx);
+	if (phydev->link && (!pause->autoneg ||
+			     phydev->autoneg == AUTONEG_DISABLE))
+		smsc95xx_mac_update_fullduplex(dev);
+
+	return 0;
+}
+
 static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.get_link	= smsc95xx_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
@@ -791,6 +850,8 @@ static const struct ethtool_ops smsc95xx_ethtool_ops = {
 	.self_test	= net_selftest,
 	.get_strings	= smsc95xx_ethtool_get_strings,
 	.get_sset_count	= smsc95xx_ethtool_get_sset_count,
+	.get_pauseparam	= smsc95xx_get_pauseparam,
+	.set_pauseparam	= smsc95xx_set_pauseparam,
 };
 
 static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
@@ -1227,6 +1288,11 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 	dev->net->max_mtu = ETH_DATA_LEN;
 	dev->hard_mtu = dev->net->mtu + dev->net->hard_header_len;
 
+	pdata->pause_tx = true;
+	pdata->pause_rx = true;
+	pdata->pause_autoneg = true;
+	phy_support_asym_pause(pdata->phydev);
+
 	ret = phy_connect_direct(dev->net, pdata->phydev,
 				 &smsc95xx_handle_link_change,
 				 PHY_INTERFACE_MODE_MII);
-- 
2.39.5


