Return-Path: <netdev+bounces-53423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE29802E7D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BFDB208A8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84DC171C7;
	Mon,  4 Dec 2023 09:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2252DCD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:26:26 -0800 (PST)
X-QQ-mid: bizesmtp89t1701681824tlbmhfqb
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 17:23:43 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKb31L5w8u3ejDMJN0HzTtojdCo9oL6Ruxfq3XNvZW5LhRlxvH2qq
	llchdBeYtoC33qJB/h1fTVu7Ybbb+tXyuXD6HJaiop4qorzRgmyXFppRuxymqfYZJixDKek
	CAU2NSy/R4mQFB8qVA1YLLSMS7k9RL+s2oMQlcc9Jy084IQ9aE5nnyToCfpsH+tiLAt5kfK
	SfTeUzeUiE+9G6MbRZfwRf/A5MCjOIsOvcNljqqv0X17BPQb2JYSga/XXiLc1TxnXr6FFjS
	mG2eMKB4xKjnIUY2DNbLpA8eDfQE5thIBcTt8B85fph0bYh9Mm/0qZ64XCHh1f7qHCGUtV8
	rkudL7Zi6A8ZxUeDSHe0vyqARPy9g72Z21BpGYq8EdH9eaL4aYWxI/EWg+N4MjczoRT5YT3
	622hMUc0BXw=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15531841380363705907
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
Subject: [PATCH net-next v2 1/7] net: ngbe: implement phylink to handle PHY device
Date: Mon,  4 Dec 2023 17:18:59 +0800
Message-Id: <20231204091905.1186255-2-jiawenwu@trustnetic.com>
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

Add phylink support for Wangxun 1Gb Ethernet controller.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  21 ++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 127 +++++++++++-------
 3 files changed, 88 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 165e82de772e..4088637440c6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -940,6 +940,7 @@ struct wx {
 	int speed;
 	int duplex;
 	struct phy_device *phydev;
+	struct phylink *phylink;
 
 	bool wol_hw_supported;
 	bool ncsi_enabled;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8db804543e66..3c0c4517ad3b 100644
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
@@ -359,7 +361,8 @@ static void ngbe_up(struct wx *wx)
 	if (wx->gpio_ctrl)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
-	phy_start(wx->phydev);
+	phylink_connect_phy(wx->phylink, wx->phydev);
+	phylink_start(wx->phylink);
 }
 
 /**
@@ -388,23 +391,18 @@ static int ngbe_open(struct net_device *netdev)
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
@@ -430,7 +428,6 @@ static int ngbe_close(struct net_device *netdev)
 	ngbe_down(wx);
 	wx_free_irq(wx);
 	wx_free_resources(wx);
-	phy_disconnect(wx->phydev);
 	wx_control_hw(wx, false);
 
 	return 0;
@@ -680,6 +677,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	phylink_destroy(wx->phylink);
 	wx_control_hw(wx, false);
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
@@ -709,6 +707,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
+	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 6302ecca71bb..31b31433a0a0 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -5,6 +5,7 @@
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
+#include <linux/phylink.h>
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
@@ -56,22 +57,43 @@ static int ngbe_phy_write_reg_c22(struct mii_bus *bus, int phy_addr,
 	return ret;
 }
 
-static void ngbe_handle_link_change(struct net_device *dev)
+static void ngbe_phy_fixup(struct wx *wx)
 {
-	struct wx *wx = netdev_priv(dev);
-	struct phy_device *phydev;
-	u32 lan_speed, reg;
+	struct phy_device *phydev = wx->phydev;
+	struct ethtool_eee eee;
 
-	phydev = wx->phydev;
-	if (!(wx->link != phydev->link ||
-	      wx->speed != phydev->speed ||
-	      wx->duplex != phydev->duplex))
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+
+	phydev->mac_managed_pm = true;
+	if (wx->mac_type != em_mac_type_mdi)
 		return;
+	/* disable EEE, internal phy does not support eee */
+	memset(&eee, 0, sizeof(eee));
+	phy_ethtool_set_eee(phydev, &eee);
+}
+
+static void ngbe_mac_config(struct phylink_config *config, unsigned int mode,
+			    const struct phylink_link_state *state)
+{
+}
+
+static void ngbe_mac_link_down(struct phylink_config *config,
+			       unsigned int mode, phy_interface_t interface)
+{
+}
 
-	wx->link = phydev->link;
-	wx->speed = phydev->speed;
-	wx->duplex = phydev->duplex;
-	switch (phydev->speed) {
+static void ngbe_mac_link_up(struct phylink_config *config,
+			     struct phy_device *phy,
+			     unsigned int mode, phy_interface_t interface,
+			     int speed, int duplex,
+			     bool tx_pause, bool rx_pause)
+{
+	struct wx *wx = netdev_priv(to_net_dev(config->dev));
+	u32 lan_speed, reg;
+
+	switch (speed) {
 	case SPEED_10:
 		lan_speed = 0;
 		break;
@@ -83,54 +105,53 @@ static void ngbe_handle_link_change(struct net_device *dev)
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
+	config = devm_kzalloc(&wx->pdev->dev, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
 
-	return 0;
-}
+	config->dev = &wx->netdev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_1000FD | MAC_100FD |
+				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 
-static void ngbe_phy_fixup(struct wx *wx)
-{
-	struct phy_device *phydev = wx->phydev;
-	struct ethtool_eee eee;
+	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
+	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);
 
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+	phylink = phylink_create(config, NULL, phy_mode, &ngbe_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
 
-	phydev->mac_managed_pm = true;
-	if (wx->mac_type != em_mac_type_mdi)
-		return;
-	/* disable EEE, internal phy does not support eee */
-	memset(&eee, 0, sizeof(eee));
-	phy_ethtool_set_eee(phydev, &eee);
+	wx->phylink = phylink;
+
+	return 0;
 }
 
 int ngbe_mdio_init(struct wx *wx)
@@ -171,5 +192,11 @@ int ngbe_mdio_init(struct wx *wx)
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
-- 
2.27.0


