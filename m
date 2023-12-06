Return-Path: <netdev+bounces-54349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C925806B35
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC411C20956
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BA20307;
	Wed,  6 Dec 2023 10:02:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 93 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 02:02:16 PST
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04FAC3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:02:16 -0800 (PST)
X-QQ-mid: bizesmtp87t1701856754t8rquxfw
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 17:59:13 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: vLOCICHxEeATSIEfBIee0IDT0mtR64pqvEBEoVyTVl1P4VxShWmXK1AvY3e53
	AKoZUBnXrjVMLSl4SSL+abv3aIIF3PWBjc/cvhrq1a+mMO3omqz7UScfRYzT7d8aymgRC+2
	ar7mzXjXMkInG+x07+pLkhBYSIBpxkCddGV52mL7uW9JJWJ2fBnfj3OPjsRZChB+8VzmdId
	ZvSwGTQoHf+LA0rwZ1z8GqFzZl4vS6RzXb4nvZOo1WOk1iCi5ZIbBBiXzbmnXya3QZ3aBmt
	zxqha0SXycpi6+C5iIWKzRe+KA0FWflWPBHIrHIBSFatCfwXPmJvrgBO+ujL8xcayKXdFC6
	Fz7wG/oj8l/iI43Qn0KcSJuS6OszvZtE5YOictJB+1ROIVR4c3f/n2X8rXSku4tjVj7VA0/
	gxlMwGlGkoejvFnkr4tCiA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 786562421831322864
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
Subject: [PATCH net-next v3 2/7] net: wangxun: unified phylink implementation in libwx
Date: Wed,  6 Dec 2023 17:53:50 +0800
Message-Id: <20231206095355.1220086-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Use wx->phylink instead of txgbe->phylink, and move the same ethtool
functions to libwx because them can be implemented with phylink in
ngbe driver.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 27 ++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  5 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  6 +--
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 29 ++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +---
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 43 +++++++++----------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  8 ----
 7 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ddc5f6d20b9c..f210ce48ac55 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/ethtool.h>
 
 #include "wx_type.h"
@@ -185,3 +186,29 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	}
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
+
+int wx_nway_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_nway_reset(wx->phylink);
+}
+EXPORT_SYMBOL(wx_nway_reset);
+
+int wx_get_link_ksettings(struct net_device *netdev,
+			  struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(wx->phylink, cmd);
+}
+EXPORT_SYMBOL(wx_get_link_ksettings);
+
+int wx_set_link_ksettings(struct net_device *netdev,
+			  const struct ethtool_link_ksettings *cmd)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(wx->phylink, cmd);
+}
+EXPORT_SYMBOL(wx_set_link_ksettings);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 16d1a09369a6..f15cc445ae0f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -13,4 +13,9 @@ void wx_get_mac_stats(struct net_device *netdev,
 void wx_get_pause_stats(struct net_device *netdev,
 			struct ethtool_pause_stats *stats);
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info);
+int wx_nway_reset(struct net_device *netdev);
+int wx_get_link_ksettings(struct net_device *netdev,
+			  struct ethtool_link_ksettings *cmd);
+int wx_set_link_ksettings(struct net_device *netdev,
+			  const struct ethtool_link_ksettings *cmd);
 #endif /* _WX_ETHTOOL_H_ */
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
index 526250102db2..ffb7a182baf3 100644
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


