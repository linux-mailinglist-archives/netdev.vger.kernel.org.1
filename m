Return-Path: <netdev+bounces-53424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292A802E7E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDCA1F2111B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A1171D1;
	Mon,  4 Dec 2023 09:26:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0587CD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:26:40 -0800 (PST)
X-QQ-mid: bizesmtp89t1701681828t2de2kgk
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 17:23:47 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2ifPhqjmx/yH5SK2wsJ/GFV/aYZnt+EvQ0LTCWg1VGC977JryHDUF
	ihgfbYWzqbWDQaR/hdT13Sd5FRu0vbKGD+zlt6S75xrMfp8SpAlXV6hDDDekxniop1gW5nv
	jAkRSbCN1BeU749JQcQFAwVaNrbEychwJ5IHrwwf4bOzxawibojuvRQDeuTesGIkNWzYiWc
	crHOUOonHKDmQe8p3Mgn5BFxerLenw334nik0yrOmfZ/AGRyRhn4dKXdhUXeSV8rRNId8+V
	vVMQ2pCb3NNF032CX21LqK1hQgWPQCqiUeZtzQov9Vg6JD0cPYCwTzpxW9Sc+NoLHWQp367
	ZaYF1itRvJx/jF5JXbQEHoYuEdW8yhq5XeTddiZ3pDp5WSmn5jFzax6jJp9HxX9C6sl7hMU
	RvQ5NOPypdg7vW3Po/pJFg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8728571161658335240
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
Subject: [PATCH net-next v2 2/7] net: wangxun: unified phylink implementation in libwx
Date: Mon,  4 Dec 2023 17:19:00 +0800
Message-Id: <20231204091905.1186255-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
References: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
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
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 27 +++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  5 ++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  6 ++--
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 29 ++-----------------
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 ++---
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 27 ++++++++---------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 -
 7 files changed, 54 insertions(+), 49 deletions(-)

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
index b6c06adb8656..a5423acafb35 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -287,7 +287,7 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 		}
 	}
 
-	txgbe->phylink = phylink;
+	wx->phylink = phylink;
 
 	return 0;
 }
@@ -483,7 +483,7 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 		    TXGBE_PX_MISC_ETH_AN)) {
 		u32 reg = rd32(wx, TXGBE_CFG_PORT_ST);
 
-		phylink_mac_change(txgbe->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
+		phylink_mac_change(wx->phylink, !!(reg & TXGBE_CFG_PORT_ST_LINK_UP));
 	}
 
 	/* unmask interrupt */
@@ -701,6 +701,7 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 
 int txgbe_init_phy(struct txgbe *txgbe)
 {
+	struct wx *wx = txgbe->wx;
 	int ret;
 
 	if (txgbe->wx->media_type == sp_media_copper)
@@ -708,43 +709,43 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
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
 
@@ -756,7 +757,7 @@ int txgbe_init_phy(struct txgbe *txgbe)
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
 err_destroy_phylink:
-	phylink_destroy(txgbe->phylink);
+	phylink_destroy(wx->phylink);
 err_destroy_xpcs:
 	xpcs_destroy(txgbe->xpcs);
 err_unregister_swnode:
@@ -768,8 +769,8 @@ int txgbe_init_phy(struct txgbe *txgbe)
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
 	if (txgbe->wx->media_type == sp_media_copper) {
-		phylink_disconnect_phy(txgbe->phylink);
-		phylink_destroy(txgbe->phylink);
+		phylink_disconnect_phy(txgbe->wx->phylink);
+		phylink_destroy(txgbe->wx->phylink);
 		return;
 	}
 
@@ -777,7 +778,7 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
 	clk_unregister(txgbe->clk);
-	phylink_destroy(txgbe->phylink);
+	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 3ba9ce43f394..2823c755b20e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -175,7 +175,6 @@ struct txgbe {
 	struct wx *wx;
 	struct txgbe_nodes nodes;
 	struct dw_xpcs *xpcs;
-	struct phylink *phylink;
 	struct platform_device *sfp_dev;
 	struct platform_device *i2c_dev;
 	struct clk_lookup *clock;
-- 
2.27.0


