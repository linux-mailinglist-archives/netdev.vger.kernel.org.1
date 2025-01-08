Return-Path: <netdev+bounces-156245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C53A05B36
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690F51671A2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157661FCFE2;
	Wed,  8 Jan 2025 12:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41851FAC40
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338436; cv=none; b=lFwvxifAECepOVshMxSYiTptPd/5ITXp7giaYjIfip5Ky/wjC2VlW+pl00k904IYlTglZTK7kS3rJbg/BqeSyK4WnwJh/S1Pzc9ivAHSBTPLo30gAdwEeC6ZY+zj5Zh8rvOQzK4/frQGQDQFVdofFfX0MShfPV9/o1YHlWdOtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338436; c=relaxed/simple;
	bh=mJkM4wEUZhOXIfZ6mVNzEFnNFurxis25v2iNlogE658=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8YYJl5G3vKU0p8U/qd+mzWPO8ODnguYT+NkiDld6DiOE9sZ2+U51DAo4HYWTtTF7DFAUbaucXNO0T391i6Y3zTZA3JfPy6WpfIC9H1jbrSdSFy0Hk/GWs4WeJaeeRQ+/Qb02ulbk/LW/bG9KJJc86AcI00LL3YNlC1NAQ5F0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwR-0002eI-PU; Wed, 08 Jan 2025 13:13:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwP-007W4i-1V;
	Wed, 08 Jan 2025 13:13:42 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwQ-00BHaj-0T;
	Wed, 08 Jan 2025 13:13:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support with phylink integration
Date: Wed,  8 Jan 2025 13:13:41 +0100
Message-Id: <20250108121341.2689130-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121341.2689130-1-o.rempel@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver
to integrate with phylink. This includes the following changes:

- Use phylink_ethtool_get_eee and phylink_ethtool_set_eee to manage
  EEE settings, aligning with the phylink API.
- Add a new tx_lpi_timer variable to manage the TX LPI (Low Power Idle)
  request delay. Default it to 50 microseconds based on LAN7800 documentation
  recommendations.
- Update EEE configuration during link_up and ensure proper disabling
  during `link_down` to allow reconfiguration.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 81 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 55488ddba269..b9958a0533de 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -476,6 +476,8 @@ struct lan78xx_net {
 	struct phylink_config	phylink_config;
 
 	struct phy_device	*fixed_phy;
+
+	u32			tx_lpi_timer;
 };
 
 /* use ethtool to change the level for any given device */
@@ -1787,54 +1789,24 @@ static int lan78xx_set_wol(struct net_device *netdev,
 static int lan78xx_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
 	int ret;
-	u32 buf;
 
-	ret = usb_autopm_get_interface(dev->intf);
+	ret = phylink_ethtool_get_eee(dev->phylink, edata);
 	if (ret < 0)
 		return ret;
 
-	ret = phy_ethtool_get_eee(phydev, edata);
-	if (ret < 0)
-		goto exit;
-
-	ret = lan78xx_read_reg(dev, MAC_CR, &buf);
-	if (buf & MAC_CR_EEE_EN_) {
-		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
-		ret = lan78xx_read_reg(dev, EEE_TX_LPI_REQ_DLY, &buf);
-		edata->tx_lpi_timer = buf;
-	} else {
-		edata->tx_lpi_timer = 0;
-	}
-
-	ret = 0;
-exit:
-	usb_autopm_put_interface(dev->intf);
+	edata->tx_lpi_timer = dev->tx_lpi_timer;
 
-	return ret;
+	return 0;
 }
 
 static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	int ret;
-	u32 buf;
-
-	ret = usb_autopm_get_interface(dev->intf);
-	if (ret < 0)
-		return ret;
 
-	ret = phy_ethtool_set_eee(net->phydev, edata);
-	if (ret < 0)
-		goto out;
-
-	buf = (u32)edata->tx_lpi_timer;
-	ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, buf);
-out:
-	usb_autopm_put_interface(dev->intf);
+	dev->tx_lpi_timer = edata->tx_lpi_timer;
 
-	return ret;
+	return phylink_ethtool_set_eee(dev->phylink, edata);
 }
 
 static void lan78xx_get_drvinfo(struct net_device *net,
@@ -2345,6 +2317,13 @@ static void lan78xx_mac_link_down(struct phylink_config *config,
 	if (ret < 0)
 		goto link_down_fail;
 
+	/* at least MAC_CR_EEE_EN_ should be disable for proper configuration
+	 * on link_up
+	 */
+	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_EEE_EN_, 0);
+	if (ret < 0)
+		goto link_down_fail;
+
 	/* MAC reset seems to not affect MAC configuration, no idea if it is
 	 * really needed, but it was done in previous driver version. So, leave
 	 * it here.
@@ -2418,6 +2397,7 @@ static void lan78xx_mac_link_up(struct phylink_config *config,
 {
 	struct net_device *net = to_net_dev(config->dev);
 	struct lan78xx_net *dev = netdev_priv(net);
+	struct phy_device *phydev = net->phydev;
 	u32 mac_cr = 0;
 	int ret;
 
@@ -2439,6 +2419,18 @@ static void lan78xx_mac_link_up(struct phylink_config *config,
 	if (duplex == DUPLEX_FULL)
 		mac_cr |= MAC_CR_FULL_DUPLEX_;
 
+	if (phydev->enable_tx_lpi) {
+		/* EEE_TX_LPI_REQ_DLY should be written before MAC_CR_EEE_EN_
+		 * is set
+		 */
+		ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY,
+					dev->tx_lpi_timer);
+		if (ret < 0)
+			goto link_up_fail;
+
+		mac_cr |=  MAC_CR_EEE_EN_;
+	}
+
 	/* make sure TXEN and RXEN are disabled before reconfiguring MAC */
 	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_SPEED_MASK_ |
 				 MAC_CR_FULL_DUPLEX_ | MAC_CR_EEE_EN_, mac_cr);
@@ -4430,6 +4422,25 @@ static int lan78xx_probe(struct usb_interface *intf,
 	dev->msg_enable = netif_msg_init(msg_level, NETIF_MSG_DRV
 					| NETIF_MSG_PROBE | NETIF_MSG_LINK);
 
+	/*
+	 * Default TX LPI (Low Power Idle) request delay count is set to 50us.
+	 *
+	 * Source: LAN7800 Documentation, DS00001992H, Section 15.1.57, Page 204.
+	 *
+	 * Reasoning:
+	 * According to the application note in the LAN7800 documentation, a
+	 * zero delay may negatively impact the TX data path’s ability to
+	 * support Gigabit operation. A value of 50us is recommended as a
+	 * reasonable default when the part operates at Gigabit speeds,
+	 * balancing stability and power efficiency in EEE mode. This delay can
+	 * be increased based on performance testing, as EEE is designed for
+	 * scenarios with mostly idle links and occasional bursts of full
+	 * bandwidth transmission. The goal is to ensure reliable Gigabit
+	 * performance without overly aggressive power optimization during
+	 * inactive periods.
+	 */
+	dev->tx_lpi_timer = 50;
+
 	skb_queue_head_init(&dev->rxq);
 	skb_queue_head_init(&dev->txq);
 	skb_queue_head_init(&dev->rxq_done);
-- 
2.39.5


