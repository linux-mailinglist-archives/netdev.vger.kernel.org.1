Return-Path: <netdev+bounces-25222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDA773631
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2075C1C20DF7
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B10394;
	Tue,  8 Aug 2023 02:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1737E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:06:57 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB610FF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:06:49 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691460293to20vgx6
Received: from wxdbg.localdomain.com ( [115.195.149.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Aug 2023 10:04:51 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKaP5PgdxiOdgV+uoQUqHeVoMthW33/tqGERtmBcwNtZdYV9gv2qx
	x2qltvIvqDMUZLKGrp80bnzkAVYvUzRF7xm5/8RPtxY7Fr/JVuLv6UXOyfj/CpRlyfawDdG
	IidaOYgy05X2edxWLnZKf28x6SdoieRhPwz8IatqqMeXVl1ddp+nqG5WvxkLzRL2GVVVCsi
	O2lRpyWG3xPEwEYslyA9WX4q/R0BxmLKuANlV8mJlQ+EmwvU0+LN9w/DHaF7A6IgVAsRVIi
	zOqjeUHUF20kTuOLMSpKgATBj4zCf7eflNgirwziSQjs99mzEeLQ27B0CpXc2I0iU2RykP1
	k99CalB+QQVTq4dMwNQ4zYhX+LZjfqRET4qo5s12HZGjzy5SCHiKedzFz0PBWSiq9sl8ZUw
	yyXaM4E+B24=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8558681814484831284
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 6/7] net: txgbe: support copper NIC with external PHY
Date: Tue,  8 Aug 2023 10:17:07 +0800
Message-Id: <20230808021708.196160-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230808021708.196160-1-jiawenwu@trustnetic.com>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |  13 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  53 +++++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 150 +++++++++++++++++-
 5 files changed, 221 insertions(+), 22 deletions(-)

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
index 46eba6d6188b..a1db3a453638 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -300,6 +300,49 @@ static void txgbe_down(struct wx *wx)
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
@@ -324,15 +367,7 @@ static int txgbe_sw_init(struct wx *wx)
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
index bcb2beaa4005..92bfd41bdb2f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -161,7 +161,10 @@ static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *confi
 {
 	struct txgbe *txgbe = netdev_to_txgbe(to_net_dev(config->dev));
 
-	return &txgbe->xpcs->pcs;
+	if (interface == PHY_INTERFACE_MODE_10GBASER)
+		return &txgbe->xpcs->pcs;
+
+	return NULL;
 }
 
 static void txgbe_mac_config(struct phylink_config *config, unsigned int mode,
@@ -244,8 +247,8 @@ static const struct phylink_mac_ops txgbe_mac_ops = {
 
 static int txgbe_phylink_init(struct txgbe *txgbe)
 {
+	struct fwnode_handle *fwnode = NULL;
 	struct phylink_config *config;
-	struct fwnode_handle *fwnode;
 	struct wx *wx = txgbe->wx;
 	phy_interface_t phy_mode;
 	struct phylink *phylink;
@@ -256,16 +259,34 @@ static int txgbe_phylink_init(struct txgbe *txgbe)
 
 	config->dev = &wx->netdev->dev;
 	config->type = PHYLINK_NETDEV;
-	config->mac_capabilities = MAC_10000FD | MAC_1000FD | MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
-	phy_mode = PHY_INTERFACE_MODE_10GBASER;
-	__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
-	fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_PHYLINK]);
+	config->mac_capabilities = MAC_10000FD | MAC_1000FD | MAC_100FD |
+				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	if (wx->media_type == sp_media_copper) {
+		phy_mode = PHY_INTERFACE_MODE_XAUI;
+		__set_bit(PHY_INTERFACE_MODE_XAUI, config->supported_interfaces);
+	} else {
+		phy_mode = PHY_INTERFACE_MODE_10GBASER;
+		fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_PHYLINK]);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX, config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII, config->supported_interfaces);
+	}
+
 	phylink = phylink_create(config, fwnode, phy_mode, &txgbe_mac_ops);
 	if (IS_ERR(phylink))
 		return PTR_ERR(phylink);
 
+	if (wx->phydev) {
+		int ret;
+
+		ret = phylink_connect_phy(phylink, wx->phydev);
+		if (ret) {
+			phylink_destroy(phylink);
+			return ret;
+		}
+	}
+
 	txgbe->phylink = phylink;
 
 	return 0;
@@ -626,10 +647,117 @@ static int txgbe_sfp_register(struct txgbe *txgbe)
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
+static int txgbe_ext_phy_init(struct txgbe *txgbe)
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
+	wx->link = 0;
+	wx->speed = 0;
+	wx->duplex = 0;
+	wx->phydev = phydev;
+
+	ret = txgbe_phylink_init(txgbe);
+	if (ret) {
+		wx_err(wx, "failed to init phylink: %d\n", ret);
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
+		return txgbe_ext_phy_init(txgbe);
+
 	ret = txgbe_swnodes_register(txgbe);
 	if (ret) {
 		wx_err(txgbe->wx, "failed to register software nodes\n");
@@ -691,6 +819,12 @@ int txgbe_init_phy(struct txgbe *txgbe)
 
 void txgbe_remove_phy(struct txgbe *txgbe)
 {
+	if (txgbe->wx->media_type == sp_media_copper) {
+		phylink_disconnect_phy(txgbe->phylink);
+		phylink_destroy(txgbe->phylink);
+		return;
+	}
+
 	platform_device_unregister(txgbe->sfp_dev);
 	platform_device_unregister(txgbe->i2c_dev);
 	clkdev_drop(txgbe->clock);
-- 
2.27.0


