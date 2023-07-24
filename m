Return-Path: <netdev+bounces-20363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1B75F299
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BF1C20AD4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA0847C;
	Mon, 24 Jul 2023 10:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AF8BED
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:16:09 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635DD7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:16:06 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193688tzkav1zg
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:47 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: CR3LFp2JE4mhkRVIWx93LKeWo321qmeRe2+pRYNJ5P9c8HUjt/DzDQwG1798D
	9el0fn4HyaOl3l2YU5Tl/QHPXDNISAYP3ZyqbOrfTbPrnEEgVlr8Y0PTkIW7B5F0HGGugUF
	pqagj499JeOKR81tpHjSYpT/4O5AU90VR45EFuAdfKtEkww6sYAFNn6FyEn1+2/orvVCdJ8
	RAt9M0qB/T+uTTuDSvJKxDpV4YuocO8gzTMNjKjzEqvJp6HIaPB59BTHnaCK3niDPJ0NC+t
	keCqag25QHufcWqIX4mISqIYgtj6swu+R94ZWklqzcOHGVmsEqiR0SSbFCb9spyZ/k7ejJs
	0MqYS92q5CVY5MS7MC4lLFs2RqH9Dr4AnkWjzO7obNDexYqC/umIm92GbTXJ6TwsXqDpPb5
	VM09XQGGzB4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3506255062714907565
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 6/7] net: txgbe: support copper NIC with external PHY
Date: Mon, 24 Jul 2023 18:23:40 +0800
Message-Id: <20230724102341.10401-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230724102341.10401-1-jiawenwu@trustnetic.com>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wangxun SP chip supports to connect with external PHY (marvell 88x3310),
which links to 10GBASE-T/1000BASE-T/100BASE-T. Add the identification of
media types from subsystem device IDs. For sp_media_copper, register mdio
bus for the external PHY.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  26 +++
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   9 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  13 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  83 +++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 169 ++++++++++++++++++
 6 files changed, 281 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 39596cd13539..23cd610bd376 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -41,6 +41,7 @@ config TXGBE
 	tristate "Wangxun(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	depends on COMMON_CLK
+	select MARVELL_10G_PHY
 	select REGMAP
 	select I2C
 	select I2C_DESIGNWARE_PLATFORM
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 50b92cfb46a0..c5cbd177ef62 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -233,6 +233,24 @@
 #define WX_MAC_WDG_TIMEOUT           0x1100C
 #define WX_MAC_RX_FLOW_CTRL          0x11090
 #define WX_MAC_RX_FLOW_CTRL_RFE      BIT(0) /* receive fc enable */
+/* MDIO Registers */
+#define WX_MSCA                      0x11200
+#define WX_MSCA_RA(v)                FIELD_PREP(U16_MAX, v)
+#define WX_MSCA_PA(v)                FIELD_PREP(GENMASK(20, 16), v)
+#define WX_MSCA_DA(v)                FIELD_PREP(GENMASK(25, 21), v)
+#define WX_MSCC                      0x11204
+#define WX_MSCC_CMD(v)               FIELD_PREP(GENMASK(17, 16), v)
+
+enum WX_MSCA_CMD_value {
+	WX_MSCA_CMD_RSV = 0,
+	WX_MSCA_CMD_WRITE,
+	WX_MSCA_CMD_POST_READ,
+	WX_MSCA_CMD_READ,
+};
+
+#define WX_MSCC_SADDR                BIT(18)
+#define WX_MSCC_BUSY                 BIT(22)
+#define WX_MDIO_CLK(v)               FIELD_PREP(GENMASK(21, 19), v)
 #define WX_MMC_CONTROL               0x11800
 #define WX_MMC_CONTROL_RSTONRD       BIT(2) /* reset on read */
 
@@ -582,6 +600,13 @@ enum wx_mac_type {
 	wx_mac_em
 };
 
+enum sp_media_type {
+	sp_media_unknown = 0,
+	sp_media_fiber,
+	sp_media_copper,
+	sp_media_backplane
+};
+
 enum em_mac_type {
 	em_mac_type_unknown = 0,
 	em_mac_type_mdi,
@@ -829,6 +854,7 @@ struct wx {
 	struct wx_bus_info bus;
 	struct wx_mac_info mac;
 	enum em_mac_type mac_type;
+	enum sp_media_type media_type;
 	struct wx_eeprom_info eeprom;
 	struct wx_addr_filter_info addr_ctrl;
 	struct wx_mac_addr *mac_table;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 859da112586a..889eb8251adc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -14,6 +14,9 @@ static int txgbe_nway_reset(struct net_device *netdev)
 {
 	struct txgbe *txgbe = netdev_to_txgbe(netdev);
 
+	if (txgbe->wx->media_type == sp_media_copper)
+		return phy_ethtool_nway_reset(netdev);
+
 	return phylink_ethtool_nway_reset(txgbe->phylink);
 }
 
@@ -22,6 +25,9 @@ static int txgbe_get_link_ksettings(struct net_device *netdev,
 {
 	struct txgbe *txgbe = netdev_to_txgbe(netdev);
 
+	if (txgbe->wx->media_type == sp_media_copper)
+		return phy_ethtool_get_link_ksettings(netdev, cmd);
+
 	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);
 }
 
@@ -30,6 +36,9 @@ static int txgbe_set_link_ksettings(struct net_device *netdev,
 {
 	struct txgbe *txgbe = netdev_to_txgbe(netdev);
 
+	if (txgbe->wx->media_type == sp_media_copper)
+		return phy_ethtool_set_link_ksettings(netdev, cmd);
+
 	return phylink_ethtool_ksettings_set(txgbe->phylink, cmd);
 }
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
index 90168aab11ae..372745250270 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c
@@ -285,17 +285,20 @@ static void txgbe_reset_misc(struct wx *wx)
 int txgbe_reset_hw(struct wx *wx)
 {
 	int status;
-	u32 val;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = wx_stop_adapter(wx);
 	if (status != 0)
 		return status;
 
-	val = WX_MIS_RST_LAN_RST(wx->bus.func);
-	wr32(wx, WX_MIS_RST, val | rd32(wx, WX_MIS_RST));
-	WX_WRITE_FLUSH(wx);
-	usleep_range(10, 100);
+	if (wx->media_type != sp_media_copper) {
+		u32 val;
+
+		val = WX_MIS_RST_LAN_RST(wx->bus.func);
+		wr32(wx, WX_MIS_RST, val | rd32(wx, WX_MIS_RST));
+		WX_WRITE_FLUSH(wx);
+		usleep_range(10, 100);
+	}
 
 	status = wx_check_flash_load(wx, TXGBE_SPI_ILDR_STATUS_LAN_SW_RST(wx->bus.func));
 	if (status != 0)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 46eba6d6188b..acdbc1f19449 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -203,10 +203,31 @@ static int txgbe_request_irq(struct wx *wx)
 	return err;
 }
 
+static void txgbe_start_phy(struct wx *wx)
+{
+	if (wx->media_type == sp_media_fiber) {
+		struct txgbe *txgbe = wx->priv;
+
+		phylink_start(txgbe->phylink);
+	} else if (wx->media_type == sp_media_copper) {
+		phy_start(wx->phydev);
+	}
+}
+
+static void txgbe_stop_phy(struct wx *wx)
+{
+	if (wx->media_type == sp_media_fiber) {
+		struct txgbe *txgbe = wx->priv;
+
+		phylink_stop(txgbe->phylink);
+	} else if (wx->media_type == sp_media_copper) {
+		phy_stop(wx->phydev);
+	}
+}
+
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
-	struct txgbe *txgbe;
 
 	wx_control_hw(wx, true);
 	wx_configure_vectors(wx);
@@ -215,8 +236,7 @@ static void txgbe_up_complete(struct wx *wx)
 	smp_mb__before_atomic();
 	wx_napi_enable_all(wx);
 
-	txgbe = netdev_to_txgbe(netdev);
-	phylink_start(txgbe->phylink);
+	txgbe_start_phy(wx);
 
 	/* clear any pending interrupts, may auto mask */
 	rd32(wx, WX_PX_IC(0));
@@ -290,16 +310,57 @@ static void txgbe_disable_device(struct wx *wx)
 
 static void txgbe_down(struct wx *wx)
 {
-	struct txgbe *txgbe = netdev_to_txgbe(wx->netdev);
-
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
-	phylink_stop(txgbe->phylink);
+	txgbe_stop_phy(wx);
 
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
 }
 
+/**
+ *  txgbe_init_type_code - Initialize the shared code
+ *  @wx: pointer to hardware structure
+ **/
+static void txgbe_init_type_code(struct wx *wx)
+{
+	u8 device_type = wx->subsystem_device_id & 0xF0;
+
+	switch (wx->device_id) {
+	case TXGBE_DEV_ID_SP1000:
+	case TXGBE_DEV_ID_WX1820:
+		wx->mac.type = wx_mac_sp;
+		break;
+	default:
+		wx->mac.type = wx_mac_unknown;
+		break;
+	}
+
+	switch (device_type) {
+	case TXGBE_ID_SFP:
+		wx->media_type = sp_media_fiber;
+		break;
+	case TXGBE_ID_XAUI:
+	case TXGBE_ID_SGMII:
+		wx->media_type = sp_media_copper;
+		break;
+	case TXGBE_ID_KR_KX_KX4:
+	case TXGBE_ID_MAC_XAUI:
+	case TXGBE_ID_MAC_SGMII:
+		wx->media_type = sp_media_backplane;
+		break;
+	case TXGBE_ID_SFI_XAUI:
+		if (wx->bus.func == 0)
+			wx->media_type = sp_media_fiber;
+		else
+			wx->media_type = sp_media_copper;
+		break;
+	default:
+		wx->media_type = sp_media_unknown;
+		break;
+	}
+}
+
 /**
  * txgbe_sw_init - Initialize general software structures (struct wx)
  * @wx: board private structure to initialize
@@ -324,15 +385,7 @@ static int txgbe_sw_init(struct wx *wx)
 		return err;
 	}
 
-	switch (wx->device_id) {
-	case TXGBE_DEV_ID_SP1000:
-	case TXGBE_DEV_ID_WX1820:
-		wx->mac.type = wx_mac_sp;
-		break;
-	default:
-		wx->mac.type = wx_mac_unknown;
-		break;
-	}
+	txgbe_init_type_code(wx);
 
 	/* Set common capability flags and settings */
 	wx->max_q_vectors = TXGBE_MAX_MSIX_VECTORS;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 30a5ed2ed316..233b1b0fa274 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -616,10 +616,174 @@ static int txgbe_sfp_register(struct txgbe *txgbe)
 	return 0;
 }
 
+static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
+			  int devnum, int regnum)
+{
+	struct wx *wx = bus->priv;
+	u32 val, command;
+	int ret;
+
+	/* setup and write the address cycle command */
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
+
+	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) | WX_MSCC_BUSY;
+	wr32(wx, WX_MSCC, command);
+
+	/* wait to complete */
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
+	if (ret) {
+		wx_err(wx, "Mdio read c45 command did not complete.\n");
+		return ret;
+	}
+
+	return (u16)rd32(wx, WX_MSCC);
+}
+
+static int txgbe_phy_write(struct mii_bus *bus, int phy_addr,
+			   int devnum, int regnum, u16 value)
+{
+	struct wx *wx = bus->priv;
+	int ret, command;
+	u16 val;
+
+	/* setup and write the address cycle command */
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
+
+	command = value | WX_MSCC_CMD(WX_MSCA_CMD_WRITE) | WX_MSCC_BUSY;
+	wr32(wx, WX_MSCC, command);
+
+	/* wait to complete */
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
+	if (ret)
+		wx_err(wx, "Mdio write c45 command did not complete.\n");
+
+	return ret;
+}
+
+static void txgbe_handle_phy_link(struct net_device *dev)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct phy_device *phydev;
+	u32 txcfg, wdg;
+
+	phydev = wx->phydev;
+	if (!(wx->link != phydev->link ||
+	      wx->speed != phydev->speed ||
+	      wx->duplex != phydev->duplex))
+		return;
+
+	wx->link = phydev->link;
+	wx->speed = phydev->speed;
+	wx->duplex = phydev->duplex;
+
+	if (!phydev->link)
+		goto out;
+
+	txcfg = rd32(wx, WX_MAC_TX_CFG);
+	txcfg &= ~WX_MAC_TX_CFG_SPEED_MASK;
+
+	switch (phydev->speed) {
+	case SPEED_10000:
+		txcfg |= WX_MAC_TX_CFG_SPEED_10G;
+		break;
+	case SPEED_1000:
+	case SPEED_100:
+	case SPEED_10:
+		txcfg |= WX_MAC_TX_CFG_SPEED_1G;
+		break;
+	default:
+		break;
+	}
+
+	wr32(wx, WX_MAC_TX_CFG, txcfg | WX_MAC_TX_CFG_TE);
+
+	/* Re configure MAC Rx */
+	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
+	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
+	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
+	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
+
+out:
+	phy_print_status(phydev);
+}
+
+static int txgbe_mdio_phy_init(struct txgbe *txgbe)
+{
+	struct phy_device *phydev;
+	struct mii_bus *mii_bus;
+	struct pci_dev *pdev;
+	struct wx *wx;
+	int ret = 0;
+
+	wx = txgbe->wx;
+	pdev = wx->pdev;
+
+	mii_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!mii_bus)
+		return -ENOMEM;
+
+	mii_bus->name = "txgbe_mii_bus";
+	mii_bus->read_c45 = &txgbe_phy_read;
+	mii_bus->write_c45 = &txgbe_phy_write;
+	mii_bus->parent = &pdev->dev;
+	mii_bus->phy_mask = GENMASK(31, 1);
+	mii_bus->priv = wx;
+	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe-%x",
+		 (pdev->bus->number << 8) | pdev->devfn);
+
+	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
+	if (ret) {
+		wx_err(wx, "failed to register MDIO bus: %d\n", ret);
+		return ret;
+	}
+
+	phydev = phy_find_first(mii_bus);
+	if (!phydev) {
+		wx_err(wx, "no PHY found\n");
+		return -ENODEV;
+	}
+
+	phy_attached_info(phydev);
+
+	/* remove unsupport link mode */
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
+	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
+
+	wx->link = 0;
+	wx->speed = 0;
+	wx->duplex = 0;
+	wx->phydev = phydev;
+
+	ret = phy_connect_direct(wx->netdev, phydev,
+				 txgbe_handle_phy_link,
+				 PHY_INTERFACE_MODE_XAUI);
+	if (ret) {
+		wx_err(wx, "PHY connect failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int txgbe_init_phy(struct txgbe *txgbe)
 {
 	int ret;
 
+	if (txgbe->wx->media_type == sp_media_copper)
+		return txgbe_mdio_phy_init(txgbe);
+
 	ret = txgbe_swnodes_register(txgbe);
 	if (ret) {
 		wx_err(txgbe->wx, "failed to register software nodes\n");
@@ -681,6 +845,11 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
+	if (txgbe->wx->media_type == sp_media_copper) {
+		phy_disconnect(txgbe->wx->phydev);
+		return;
+	}
+
 	platform_device_unregister(txgbe->sfp_dev);
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
-- 
2.27.0


