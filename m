Return-Path: <netdev+bounces-56274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE980E593
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9E1C212ED
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B695A1A5BE;
	Tue, 12 Dec 2023 08:11:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AACC2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:11:25 -0800 (PST)
X-QQ-mid: bizesmtp74t1702368584tu73648n
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Dec 2023 16:09:43 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: iDzLjIm7mlbYZchPtJ+awxrmpN+bZcZjMwzTw9wJyov+8aOHcFRA53c3zmHKy
	kwU2uKEL6+ixXHh1vMCEngTsRKvN8VTE0GWese7o92Bt2pYR3cPnu8ik56bXIzoJ6YBmE0r
	2+9hAr2G4cJTNzFcEekCHVWlfvvCZlVXt/rtLspPOHiwUv9oaP1FQzdI/5DTN2othYlDGYF
	FMMVi+u0opE0VEv+PSiPnFBEAWbJVGXypK4TgVXiN+Bk6KgMUNt8YSrr8akZ9WiY+Q5xs8o
	ckBkZ5cg/biuhMm1eCt3vNCGwWNgx/0U6R4DpUGQ4bk/NgDJsPwQ/CePns3KnrzfcQmSTo4
	rqdhutOdl1+Fa2YnEvLusanF98PDuZ12iezVReDJFC7ItLvoVPXRSQ5hH0GzTgZryDbtduX
	OZOxd1KozHQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2859810709110150929
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 3/8] net: ngbe: convert phylib to phylink
Date: Tue, 12 Dec 2023 16:04:33 +0800
Message-Id: <20231212080438.1361308-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
References: <20231212080438.1361308-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Implement phylink in ngbe driver, to handle phy uniformly for Wangxun
ethernet devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  12 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 114 +++++++++---------
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   1 -
 4 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index afbdf6919071..0f87898a55b2 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -44,9 +44,9 @@ static int ngbe_set_wol(struct net_device *netdev,
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
-	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link_ksettings	= wx_get_link_ksettings,
+	.set_link_ksettings	= wx_set_link_ksettings,
+	.nway_reset		= wx_nway_reset,
 	.get_wol		= ngbe_get_wol,
 	.set_wol		= ngbe_set_wol,
 	.get_sset_count		= wx_get_sset_count,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a5c623fd023e..db5cae8384e5 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -336,7 +336,7 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_down(struct wx *wx)
 {
-	phy_stop(wx->phydev);
+	phylink_stop(wx->phylink);
 	ngbe_disable_device(wx);
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
@@ -359,7 +359,7 @@ static void ngbe_up(struct wx *wx)
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
-	phy_start(wx->phydev);
+	phylink_start(wx->phylink);
 }
 
 /**
@@ -388,7 +388,7 @@ static int ngbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_resources;
 
-	err = ngbe_phy_connect(wx);
+	err = phylink_connect_phy(wx->phylink, wx->phydev);
 	if (err)
 		goto err_free_irq;
 
@@ -404,7 +404,7 @@ static int ngbe_open(struct net_device *netdev)
 
 	return 0;
 err_dis_phy:
-	phy_disconnect(wx->phydev);
+	phylink_disconnect_phy(wx->phylink);
 err_free_irq:
 	wx_free_irq(wx);
 err_free_resources:
@@ -430,7 +430,7 @@ static int ngbe_close(struct net_device *netdev)
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
-	phy_disconnect(wx->phydev);
+	phylink_disconnect_phy(wx->phylink);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -681,6 +681,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
@@ -710,6 +711,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
+	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 6302ecca71bb..cc75856f231a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -56,22 +56,26 @@ static int ngbe_phy_write_reg_c22(struct mii_bus *bus, int phy_addr,
 	return ret;
 }
 
-static void ngbe_handle_link_change(struct net_device *dev)
+static void ngbe_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
 {
-	struct wx *wx = netdev_priv(dev);
-	struct phy_device *phydev;
-	u32 lan_speed, reg;
+}
+
+static void ngbe_mac_link_down(struct phylink_config *config,
+			       unsigned int mode, phy_interface_t interface)
+{
+}
 
-	phydev = wx->phydev;
-	if (!(wx->link != phydev->link ||
-	      wx->speed != phydev->speed ||
-	      wx->duplex != phydev->duplex))
-		return;
+static void ngbe_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy,
+			     unsigned int mode, phy_interface_t interface,
+			     int speed, int duplex,
+			     bool tx_pause, bool rx_pause)
+{
+	struct wx *wx = phylink_to_wx(config);
+	u32 lan_speed, reg;
 
-	wx->link = phydev->link;
-	wx->speed = phydev->speed;
-	wx->duplex = phydev->duplex;
-	switch (phydev->speed) {
+	switch (speed) {
 	case SPEED_10:
 		lan_speed = 0;
 		break;
@@ -83,54 +87,51 @@ static void ngbe_handle_link_change(struct net_device *dev)
 		lan_speed = 2;
 		break;
 	}
+
 	wr32m(wx, NGBE_CFG_LAN_SPEED, 0x3, lan_speed);
 
-	if (phydev->link) {
-		reg = rd32(wx, WX_MAC_TX_CFG);
-		reg &= ~WX_MAC_TX_CFG_SPEED_MASK;
-		reg |= WX_MAC_TX_CFG_SPEED_1G | WX_MAC_TX_CFG_TE;
-		wr32(wx, WX_MAC_TX_CFG, reg);
-		/* Re configure MAC RX */
-		reg = rd32(wx, WX_MAC_RX_CFG);
-		wr32(wx, WX_MAC_RX_CFG, reg);
-		wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
-		reg = rd32(wx, WX_MAC_WDG_TIMEOUT);
-		wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
-	}
-	phy_print_status(phydev);
+	reg = rd32(wx, WX_MAC_TX_CFG);
+	reg &= ~WX_MAC_TX_CFG_SPEED_MASK;
+	reg |= WX_MAC_TX_CFG_SPEED_1G | WX_MAC_TX_CFG_TE;
+	wr32(wx, WX_MAC_TX_CFG, reg);
+
+	/* Re configure MAC Rx */
+	reg = rd32(wx, WX_MAC_RX_CFG);
+	wr32(wx, WX_MAC_RX_CFG, reg);
+	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
+	reg = rd32(wx, WX_MAC_WDG_TIMEOUT);
+	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
 }
 
-int ngbe_phy_connect(struct wx *wx)
+static const struct phylink_mac_ops ngbe_mac_ops = {
+	.mac_config = ngbe_mac_config,
+	.mac_link_down = ngbe_mac_link_down,
+	.mac_link_up = ngbe_mac_link_up,
+};
+
+static int ngbe_phylink_init(struct wx *wx)
 {
-	int ret;
+	struct phylink_config *config;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
 
-	ret = phy_connect_direct(wx->netdev,
-				 wx->phydev,
-				 ngbe_handle_link_change,
-				 PHY_INTERFACE_MODE_RGMII_ID);
-	if (ret) {
-		wx_err(wx, "PHY connect failed.\n");
-		return ret;
-	}
+	config = &wx->phylink_config;
+	config->dev = &wx->netdev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_1000FD | MAC_100FD | MAC_10FD |
+				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+	config->mac_managed_pm = true;
 
-	return 0;
-}
+	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
+	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
 
-static void ngbe_phy_fixup(struct wx *wx)
-{
-	struct phy_device *phydev = wx->phydev;
-	struct ethtool_eee eee;
-
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-
-	phydev->mac_managed_pm = true;
-	if (wx->mac_type != em_mac_type_mdi)
-		return;
-	/* disable EEE, internal phy does not support eee */
-	memset(&eee, 0, sizeof(eee));
-	phy_ethtool_set_eee(phydev, &eee);
+	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	wx->phylink = phylink;
+
+	return 0;
 }
 
 int ngbe_mdio_init(struct wx *wx)
@@ -165,11 +166,16 @@ int ngbe_mdio_init(struct wx *wx)
 		return -ENODEV;
 
 	phy_attached_info(wx->phydev);
-	ngbe_phy_fixup(wx);
 
 	wx->link = 0;
 	wx->speed = 0;
 	wx->duplex = 0;
 
+	ret = ngbe_phylink_init(wx);
+	if (ret) {
+		wx_err(wx, "failed to init phylink: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h
index 0a6400dd89c4..f610b771888a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h
@@ -7,6 +7,5 @@
 #ifndef _NGBE_MDIO_H_
 #define _NGBE_MDIO_H_
 
-int ngbe_phy_connect(struct wx *wx);
 int ngbe_mdio_init(struct wx *wx);
 #endif /* _NGBE_MDIO_H_ */
-- 
2.27.0


