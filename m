Return-Path: <netdev+bounces-54344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F74806B2B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22B7281A3A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4B620307;
	Wed,  6 Dec 2023 10:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99311F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:00:38 -0800 (PST)
X-QQ-mid: bizesmtp87t1701856751tyq64zja
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 17:59:10 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: vLOCICHxEeATSIEfBIee0AincbuuAvexQnq2aZUNrtYd921xlvbgsz/ozHNPA
	5+c7Sf5WAsCFn0+PHLkwE2/pZD8ksp4V86CR7AP5jwfyDDvkJgRKzdwlyXe8ULXuOX4Fqzn
	8dYpFBAckwlaC1hie8b8rfnHIA1uYZLLgSEp1ETX/N7TMqzmwqyVTKZDaCg04NTFkyaqacd
	GAHyTDjPwzjrVkLOu52HgGP2eVw65qvIjSYOU90gHUBz3Hkw9SWZ1TOYziS4ni6+Qo/3+oz
	6wIOYQFe7LFPiZ7WUsbVFrh43o9Ic88ssIFk5qPkynELkBXfKNr/mKHylQTuXGVxYuCUMX6
	lKCgS8fhjxfWCNB+jAqJ9VCuFsE1U1akcPVxlPpGrnuhC8dCEUifW7tjAUKWGwMXVfiLyOV
	srqqoGDiasU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15494707218834055542
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
Subject: [PATCH net-next v3 1/7] net: ngbe: implement phylink to handle PHY device
Date: Wed,  6 Dec 2023 17:53:49 +0800
Message-Id: <20231206095355.1220086-2-jiawenwu@trustnetic.com>
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

Add phylink support for Wangxun 1Gb Ethernet controller.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   8 ++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  20 ++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 126 +++++++++++-------
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h |   2 +-
 4 files changed, 93 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 165e82de772e..9225aaf029f8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <net/ip.h>
+#include <linux/phylink.h>
 
 #define WX_NCSI_SUP                             0x8000
 #define WX_NCSI_MASK                            0x8000
@@ -940,6 +941,8 @@ struct wx {
 	int speed;
 	int duplex;
 	struct phy_device *phydev;
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 
 	bool wol_hw_supported;
 	bool ncsi_enabled;
@@ -1045,4 +1048,9 @@ rd64(struct wx *wx, u32 reg)
 #define wx_dbg(wx, fmt, arg...) \
 	dev_dbg(&(wx)->pdev->dev, fmt, ##arg)
 
+static inline struct wx *phylink_to_wx(struct phylink_config *config)
+{
+	return container_of(config, struct wx, phylink_config);
+}
+
 #endif /* _WX_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8db804543e66..c61f4b9d79fa 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include <net/ip.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include <linux/if_vlan.h>
 
 #include "../libwx/wx_type.h"
@@ -336,7 +337,8 @@ static void ngbe_disable_device(struct wx *wx)
 
 static void ngbe_down(struct wx *wx)
 {
-	phy_stop(wx->phydev);
+	phylink_stop(wx->phylink);
+	phylink_disconnect_phy(wx->phylink);
 	ngbe_disable_device(wx);
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
@@ -359,7 +361,7 @@ static void ngbe_up(struct wx *wx)
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
-	phy_start(wx->phydev);
+	ngbe_phylink_start(wx);
 }
 
 /**
@@ -388,23 +390,18 @@ static int ngbe_open(struct net_device *netdev)
 	if (err)
 		goto err_free_resources;
 
-	err = ngbe_phy_connect(wx);
-	if (err)
-		goto err_free_irq;
-
 	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
 	if (err)
-		goto err_dis_phy;
+		goto err_free_irq;
 
 	err = netif_set_real_num_rx_queues(netdev, wx->num_rx_queues);
 	if (err)
-		goto err_dis_phy;
+		goto err_free_irq;
 
 	ngbe_up(wx);
 
 	return 0;
-err_dis_phy:
-	phy_disconnect(wx->phydev);
+
 err_free_irq:
 	wx_free_irq(wx);
 err_free_resources:
@@ -430,7 +427,6 @@ static int ngbe_close(struct net_device *netdev)
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
-	phy_disconnect(wx->phydev);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -680,6 +676,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
@@ -709,6 +706,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
+	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 6302ecca71bb..324f8af58b97 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -5,6 +5,7 @@
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
@@ -56,22 +57,26 @@ static int ngbe_phy_write_reg_c22(struct mii_bus *bus, int phy_addr,
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
 
-	phydev = wx->phydev;
-	if (!(wx->link != phydev->link ||
-	      wx->speed != phydev->speed ||
-	      wx->duplex != phydev->duplex))
-		return;
+static void ngbe_mac_link_down(struct phylink_config *config,
+			       unsigned int mode, phy_interface_t interface)
+{
+}
+
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
@@ -83,54 +88,68 @@ static void ngbe_handle_link_change(struct net_device *dev)
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
+
+	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
+	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
+
+	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	wx->phylink = phylink;
 
 	return 0;
 }
 
-static void ngbe_phy_fixup(struct wx *wx)
+void ngbe_phylink_start(struct wx *wx)
 {
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
+	struct phylink *phylink = wx->phylink;
+
+	phylink_connect_phy(phylink, wx->phydev);
+
+	if (wx->mac_type == em_mac_type_mdi) {
+		struct ethtool_eee eee;
+
+		/* disable EEE, internal phy does not support eee */
+		memset(&eee, 0, sizeof(eee));
+		phylink_ethtool_set_eee(phylink, &eee);
+	}
+
+	phylink_start(phylink);
 }
 
 int ngbe_mdio_init(struct wx *wx)
@@ -165,11 +184,16 @@ int ngbe_mdio_init(struct wx *wx)
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
index 0a6400dd89c4..c5a9386caf0a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.h
@@ -7,6 +7,6 @@
 #ifndef _NGBE_MDIO_H_
 #define _NGBE_MDIO_H_
 
-int ngbe_phy_connect(struct wx *wx);
+void ngbe_phylink_start(struct wx *wx);
 int ngbe_mdio_init(struct wx *wx);
 #endif /* _NGBE_MDIO_H_ */
-- 
2.27.0


