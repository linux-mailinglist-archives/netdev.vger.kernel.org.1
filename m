Return-Path: <netdev+bounces-176042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA06A6873C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432443BA9EA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E992528FB;
	Wed, 19 Mar 2025 08:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2B251792
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374206; cv=none; b=aB+4eliYbWqDnh69If7X0XQwOdnWU19VsFWjz3hy2jCeFc4oX0G3l9qLrVHEAb64tkHUFUZeyCX+RewBkXcxZOJ+duqIB7blI+TwD+EWN+JK1YOs5e/1b3pJ6ksnGh8aXjY1jssEuELiIocJqN+SeN+rEsWVS9kLSokdj6k2Neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374206; c=relaxed/simple;
	bh=S+xPkBFwmZSenA+P1rJEAhj1llQPml3VNhZXeftqDDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqYcFCxgeC7oVeWLmMPDKjGusL/WdTfDmInsw2hrUulf7hBJHs1KB5nkOEuQOaudqJqH/6i9Y/ndA6Nn1VAdRdFtP16+Ur5Gs4az21pw9pW4PXtjSmENfb2JWaiGKbaq2V607uqpksteBCAu3Hzmc8GV4Bhz7XEbvyJOJ5S4w+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7b-0008Ox-V3; Wed, 19 Mar 2025 09:49:55 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-000Z4S-0w;
	Wed, 19 Mar 2025 09:49:53 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-001l2C-1w;
	Wed, 19 Mar 2025 09:49:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 5/6] net: usb: lan78xx: Integrate EEE support with phylink LPI API
Date: Wed, 19 Mar 2025 09:49:51 +0100
Message-Id: <20250319084952.419051-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319084952.419051-1-o.rempel@pengutronix.de>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
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

Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver to
fully integrate with the phylink Low Power Idle (LPI) API. This includes:

- Replacing direct calls to `phy_ethtool_get_eee` and `phy_ethtool_set_eee`
  with `phylink_ethtool_get_eee` and `phylink_ethtool_set_eee`.
- Implementing `.mac_enable_tx_lpi` and `.mac_disable_tx_lpi` to control
  LPI transitions via phylink.
- Configuring `lpi_timer_default` to align with recommended values from
  LAN7800 documentation.
- ensure EEE is disabled on controller reset

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v5:
- remove redundant error prints
changes v2:
- use latest PHYlink TX_LPI API
---
 drivers/net/usb/lan78xx.c | 111 +++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 44 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 9ff8e7850e1e..074ac4d1cbcb 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1785,54 +1785,15 @@ static int lan78xx_set_wol(struct net_device *netdev,
 static int lan78xx_get_eee(struct net_device *net, struct ethtool_keee *edata)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	int ret;
-	u32 buf;
-
-	ret = usb_autopm_get_interface(dev->intf);
-	if (ret < 0)
-		return ret;
-
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
 
-	return ret;
+	return phylink_ethtool_get_eee(dev->phylink, edata);
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
-
-	return ret;
+	return phylink_ethtool_set_eee(dev->phylink, edata);
 }
 
 static void lan78xx_get_drvinfo(struct net_device *net,
@@ -2470,10 +2431,50 @@ static void lan78xx_mac_link_up(struct phylink_config *config,
 		   ERR_PTR(ret));
 }
 
+static int lan78xx_mac_eee_enable(struct lan78xx_net *dev, bool enable)
+{
+	u32 mac_cr = 0;
+
+	if (enable)
+		mac_cr |= MAC_CR_EEE_EN_;
+
+	/* make sure TXEN and RXEN are disabled before reconfiguring MAC */
+	return lan78xx_update_reg(dev, MAC_CR, MAC_CR_EEE_EN_, mac_cr);
+}
+
+static void lan78xx_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+
+	lan78xx_mac_eee_enable(dev, false);
+}
+
+static int lan78xx_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				     bool tx_clk_stop)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	int ret;
+
+	/* Software should only change this field when Energy Efficient
+	 * Ethernet Enable (EEEEN) is cleared. We ensure that by clearing
+	 * EEEEN during probe, and phylink itself guarantees that
+	 * mac_disable_tx_lpi() will have been previously called.
+	 */
+	ret = lan78xx_write_reg(dev, EEE_TX_LPI_REQ_DLY, timer);
+	if (ret < 0)
+		return ret;
+
+	return lan78xx_mac_eee_enable(dev, true);
+}
+
 static const struct phylink_mac_ops lan78xx_phylink_mac_ops = {
 	.mac_config = lan78xx_mac_config,
 	.mac_link_down = lan78xx_mac_link_down,
 	.mac_link_up = lan78xx_mac_link_up,
+	.mac_disable_tx_lpi = lan78xx_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = lan78xx_mac_enable_tx_lpi,
 };
 
 static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
@@ -2528,6 +2529,26 @@ static int lan78xx_phylink_setup(struct lan78xx_net *dev)
 	pc->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_10 |
 			       MAC_100 | MAC_1000FD;
 	pc->mac_managed_pm = true;
+	pc->lpi_capabilities = MAC_100FD | MAC_1000FD;
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
+	pc->lpi_timer_default = 50;
+	pc->eee_enabled_default = true;
 
 	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 		phy_interface_set_rgmii(pc->supported_interfaces);
@@ -2538,6 +2559,10 @@ static int lan78xx_phylink_setup(struct lan78xx_net *dev)
 		link_interface = PHY_INTERFACE_MODE_INTERNAL;
 	}
 
+	memcpy(dev->phylink_config.lpi_interfaces,
+	       dev->phylink_config.supported_interfaces,
+	       sizeof(dev->phylink_config.lpi_interfaces));
+
 	phylink = phylink_create(pc, dev->net->dev.fwnode,
 				 link_interface, &lan78xx_phylink_mac_ops);
 	if (IS_ERR(phylink))
@@ -2607,8 +2632,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		return ret;
 	}
 
-	phy_support_eee(phydev);
-
 	if (phydev->mdio.dev.of_node) {
 		u32 reg;
 		int len;
@@ -3131,7 +3154,7 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (ret < 0)
 		return ret;
 
-	buf &= ~(MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_);
+	buf &= ~(MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_ | MAC_CR_EEE_EN_);
 
 	/* LAN7801 only has RGMII mode */
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
-- 
2.39.5


