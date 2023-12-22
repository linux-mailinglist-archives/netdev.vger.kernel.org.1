Return-Path: <netdev+bounces-59878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46C81C813
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB841F25120
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3814A82;
	Fri, 22 Dec 2023 10:23:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A8156F8
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp84t1703240520tnu4ixww
Received: from wxdbg.localdomain.com ( [125.119.246.92])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Dec 2023 18:21:58 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: W+onFc5Tw4OninTCG+rjeaKwyydLvnXRCoC8ggT33Zi1hFOWZr1YqdsX6NVoK
	I7R3BjUOe6yO95A5koj4mFGta8U37HAMb9drxs0xrM/wf5jkkpTVu98sJ5vZVFlO+eusn7v
	uzK8HMtRKXvN4gyP8G7PJ33EZxMO/SV/oMmNUJAKKNJPVaVsIPppqRyAIE42ST3MZ2So3b6
	P6yTQJ7UGV55ZoGo3FJ/0gJd2QRoy2/8hs2NdwS3PrlNPl5JXLU9WoJtxA1bMOz2s/0sIzM
	XVV5CnIHwxQP7vkNeIka7KZ2WEcAsUTE5QtLiT9L4pRw5EIpfvRRuCPmApXL46lCIkiN1/w
	C1M0ehR65D1jHEu1tRXDNlhiDPZm5Mj1CpcOPK05CtWSbGsxrIP2KJCXsEpMJ5McXGopdE1
	L3yMGFW6x4YbgYIHr7Uz2A==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13649636134181146590
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
Subject: [PATCH net-next v6 2/8] net: txgbe: use phylink bits added in libwx
Date: Fri, 22 Dec 2023 18:16:33 +0800
Message-Id: <20231222101639.1499997-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
References: <20231222101639.1499997-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Convert txgbe to use phylink and phylink_config added in libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 29 ++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +---
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 43 +++++++++----------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  8 ----
 4 files changed, 26 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 3f336a088e43..60f351a3b89d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -10,35 +10,12 @@
 #include "txgbe_type.h"
 #include "txgbe_ethtool.h"
 
-static int txgbe_nway_reset(struct net_device *netdev)
-{
-	struct txgbe *txgbe = netdev_to_txgbe(netdev);
-
-	return phylink_ethtool_nway_reset(txgbe->phylink);
-}
-
-static int txgbe_get_link_ksettings(struct net_device *netdev,
-				    struct ethtool_link_ksettings *cmd)
-{
-	struct txgbe *txgbe = netdev_to_txgbe(netdev);
-
-	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);
-}
-
-static int txgbe_set_link_ksettings(struct net_device *netdev,
-				    const struct ethtool_link_ksettings *cmd)
-{
-	struct txgbe *txgbe = netdev_to_txgbe(netdev);
-
-	return phylink_ethtool_ksettings_set(txgbe->phylink, cmd);
-}
-
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
-	.nway_reset		= txgbe_nway_reset,
+	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= txgbe_get_link_ksettings,
-	.set_link_ksettings	= txgbe_set_link_ksettings,
+	.get_link_ksettings	= wx_get_link_ksettings,
+	.set_link_ksettings	= wx_set_link_ksettings,
 	.get_sset_count		= wx_get_sset_count,
 	.get_strings		= wx_get_strings,
 	.get_ethtool_stats	= wx_get_ethtool_stats,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a78da2309db5..1007ae2541ce 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -206,7 +206,6 @@ static int txgbe_request_irq(struct wx *wx)
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-	struct txgbe *txgbe;
 
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
@@ -215,8 +214,7 @@ static void txgbe_up_complete(struct wx *wx)
 	smp_mb__before_atomic();
 	wx_napi_enable_all(wx);
 
-	txgbe = netdev_to_txgbe(netdev);
-	phylink_start(txgbe->phylink);
+	phylink_start(wx->phylink);
 
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
@@ -292,11 +290,9 @@ static void txgbe_disable_device(struct wx *wx)
 
 static void txgbe_down(struct wx *wx)
 {
-	struct txgbe *txgbe = netdev_to_txgbe(wx->netdev);
-
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
-	phylink_stop(txgbe->phylink);
+	phylink_stop(wx->phylink);
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index b6c06adb8656..3c0524d19866 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -159,7 +159,8 @@ static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
 static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *config,
 						    phy_interface_t interface)
 {
-	struct txgbe *txgbe = netdev_to_txgbe(to_net_dev(config->dev));
+	struct wx *wx = phylink_to_wx(config);
+	struct txgbe *txgbe = wx->priv;
 
 	if (interface == PHY_INTERFACE_MODE_10GBASER)
 		return &txgbe->xpcs->pcs;
@@ -175,7 +176,7 @@ static void txgbe_mac_config(struct phylink_config *config, unsigned int mode,
 static void txgbe_mac_link_down(struct phylink_config *config,
 				unsigned int mode, phy_interface_t interface)
 {
-	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+	struct wx *wx = phylink_to_wx(config);
 
 	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 }
@@ -186,7 +187,7 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 			      int speed, int duplex,
 			      bool tx_pause, bool rx_pause)
 {
-	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+	struct wx *wx = phylink_to_wx(config);
 	u32 txcfg, wdg;
 
 	txcfg = rd32(wx, WX_MAC_TX_CFG);
@@ -217,7 +218,7 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
 			     phy_interface_t interface)
 {
-	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+	struct wx *wx = phylink_to_wx(config);
 
 	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
@@ -228,7 +229,7 @@ static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
 static int txgbe_mac_finish(struct phylink_config *config, unsigned int mode,
 			    phy_interface_t interface)
 {
-	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+	struct wx *wx = phylink_to_wx(config);
 
 	txgbe_enable_sec_tx_path(wx);
 	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
@@ -253,10 +254,7 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 	phy_interface_t phy_mode;
 	struct phylink *phylink;
 
-	config = devm_kzalloc(&wx->pdev->dev, sizeof(*config), GFP_KERNEL);
-	if (!config)
-		return -ENOMEM;
-
+	config = &wx->phylink_config;
 	config->dev = &wx->netdev->dev;
 	config->type = PHYLINK_NETDEV;
 	config->mac_capabilities = MAC_10000FD | MAC_1000FD | MAC_100FD |
@@ -287,7 +285,7 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 		}
 	}
 
-	txgbe->phylink = phylink;
+	wx->phylink = phylink;
 
 	return 0;
 }
@@ -483,7 +481,7 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 		    TXGBE_PX_MISC_ETH_AN)) {
 		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
 
-		phylink_mac_change(txgbe->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
+		phylink_mac_change(wx->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
 	}
 
 	/* unmask interrupt */
@@ -701,6 +699,7 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 
 int txgbe_init_phy(struct txgbe *txgbe)
 {
+	struct wx *wx = txgbe->wx;
 	int ret;
 
 	if (txgbe->wx->media_type == sp_media_copper)
@@ -708,43 +707,43 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 	ret = txgbe_swnodes_register(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to register software nodes\n");
+		wx_err(wx, "failed to register software nodes\n");
 		return ret;
 	}
 
 	ret = txgbe_mdio_pcs_init(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to init mdio pcs: %d\n", ret);
+		wx_err(wx, "failed to init mdio pcs: %d\n", ret);
 		goto err_unregister_swnode;
 	}
 
 	ret = txgbe_phylink_init(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to init phylink\n");
+		wx_err(wx, "failed to init phylink\n");
 		goto err_destroy_xpcs;
 	}
 
 	ret = txgbe_gpio_init(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to init gpio\n");
+		wx_err(wx, "failed to init gpio\n");
 		goto err_destroy_phylink;
 	}
 
 	ret = txgbe_clock_register(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to register clock: %d\n", ret);
+		wx_err(wx, "failed to register clock: %d\n", ret);
 		goto err_destroy_phylink;
 	}
 
 	ret = txgbe_i2c_register(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to init i2c interface: %d\n", ret);
+		wx_err(wx, "failed to init i2c interface: %d\n", ret);
 		goto err_unregister_clk;
 	}
 
 	ret = txgbe_sfp_register(txgbe);
 	if (ret) {
-		wx_err(txgbe->wx, "failed to register sfp\n");
+		wx_err(wx, "failed to register sfp\n");
 		goto err_unregister_i2c;
 	}
 
@@ -756,7 +755,7 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
 err_destroy_phylink:
-	phylink_destroy(txgbe->phylink);
+	phylink_destroy(wx->phylink);
 err_destroy_xpcs:
 	xpcs_destroy(txgbe->xpcs);
 err_unregister_swnode:
@@ -768,8 +767,8 @@ int txgbe_init_phy(struct txgbe *txgbe)
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
 	if (txgbe->wx->media_type == sp_media_copper) {
-		phylink_disconnect_phy(txgbe->phylink);
-		phylink_destroy(txgbe->phylink);
+		phylink_disconnect_phy(txgbe->wx->phylink);
+		phylink_destroy(txgbe->wx->phylink);
 		return;
 	}
 
@@ -777,7 +776,7 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
-	phylink_destroy(txgbe->phylink);
+	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 3ba9ce43f394..5494ea88df0a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -129,13 +129,6 @@
 
 extern char txgbe_driver_name[];
 
-static inline struct txgbe *netdev_to_txgbe(struct net_device *netdev)
-{
-	struct wx *wx = netdev_priv(netdev);
-
-	return wx->priv;
-}
-
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
 		.name = _NAME,			\
@@ -175,7 +168,6 @@ struct txgbe {
 	struct wx *wx;
 	struct txgbe_nodes nodes;
 	struct dw_xpcs *xpcs;
-	struct phylink *phylink;
 	struct platform_device *sfp_dev;
 	struct platform_device *i2c_dev;
 	struct clk_lookup *clock;
-- 
2.27.0


