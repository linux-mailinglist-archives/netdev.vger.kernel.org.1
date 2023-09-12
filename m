Return-Path: <netdev+bounces-33015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F092379C3A9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A077028165A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CA14F7F;
	Tue, 12 Sep 2023 03:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53414ABE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:04:52 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077C5395AD
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:04:51 -0700 (PDT)
X-QQ-mid: bizesmtp67t1694487769ty0a92fl
Received: from wxdbg.localdomain.trustnetic.co ( [36.24.98.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Sep 2023 11:02:34 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJknQdj8DNcL83XwwynIB6lQLIDKBOHtSC/XLprc+cEoev7sdMqE2
	YVjRSlfaQpjRg2FPlGTpNlGN2Ub40Gz/99PKjhG4VSlCJg7APsK/YOz6Su5FcwaJXSLJJfE
	Q9T52gbujatHl2LTVx9V7HeGMzUqZQuR94uihRIsb9QbEjpyh1YTTOxjRqNSAPlciHhj8Z7
	QYrPFMDTayQTuC17HEv2oS/Y0qKy5GWEEg5VAsUvnGyJQ5gdGdzDg9/A3nhGNd34kBGTsdG
	MFrO2cpbzBgUUz+i7TciNCHEVJ9N3ahA2R4W+Fyxp+REjjN5BDx95oz2g2w1aqk9qrhr9qo
	dg7Z4Zfqjhi5lo/lwkiU286uLdbxvKkAM0y0WKCKsjh11zqQ0iEr7L0BVJ20Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11010468949235566489
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: wangxun: move MDIO bus implementation to the library
Date: Tue, 12 Sep 2023 11:14:24 +0800
Message-Id: <20230912031424.721386-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Move similar code of accessing MDIO bus from txgbe/ngbe to libwx.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  92 ++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   7 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 119 +-----------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   3 -
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  56 +--------
 6 files changed, 106 insertions(+), 172 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 85dc16faca54..f0063d569c80 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -12,6 +12,98 @@
 #include "wx_lib.h"
 #include "wx_hw.h"
 
+static int wx_phy_read_reg_mdi(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
+{
+	struct wx *wx = bus->priv;
+	u32 command, val;
+	int ret;
+
+	/* setup and write the address cycle command */
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
+
+	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) | WX_MSCC_BUSY;
+	if (wx->mac.type == wx_mac_em)
+		command |= WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
+
+	/* wait to complete */
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
+	if (ret) {
+		wx_err(wx, "Mdio read c22 command did not complete.\n");
+		return ret;
+	}
+
+	return (u16)rd32(wx, WX_MSCC);
+}
+
+static int wx_phy_write_reg_mdi(struct mii_bus *bus, int phy_addr,
+				int devnum, int regnum, u16 value)
+{
+	struct wx *wx = bus->priv;
+	u32 command, val;
+	int ret;
+
+	/* setup and write the address cycle command */
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
+
+	command = value | WX_MSCC_CMD(WX_MSCA_CMD_WRITE) | WX_MSCC_BUSY;
+	if (wx->mac.type == wx_mac_em)
+		command |= WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
+
+	/* wait to complete */
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
+	if (ret)
+		wx_err(wx, "Mdio write c22 command did not complete.\n");
+
+	return ret;
+}
+
+int wx_phy_read_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum)
+{
+	struct wx *wx = bus->priv;
+
+	wr32(wx, WX_MDIO_CLAUSE_SELECT, 0xF);
+	return wx_phy_read_reg_mdi(bus, phy_addr, 0, regnum);
+}
+EXPORT_SYMBOL(wx_phy_read_reg_mdi_c22);
+
+int wx_phy_write_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum, u16 value)
+{
+	struct wx *wx = bus->priv;
+
+	wr32(wx, WX_MDIO_CLAUSE_SELECT, 0xF);
+	return wx_phy_write_reg_mdi(bus, phy_addr, 0, regnum, value);
+}
+EXPORT_SYMBOL(wx_phy_write_reg_mdi_c22);
+
+int wx_phy_read_reg_mdi_c45(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
+{
+	struct wx *wx = bus->priv;
+
+	wr32(wx, WX_MDIO_CLAUSE_SELECT, 0);
+	return wx_phy_read_reg_mdi(bus, phy_addr, devnum, regnum);
+}
+EXPORT_SYMBOL(wx_phy_read_reg_mdi_c45);
+
+int wx_phy_write_reg_mdi_c45(struct mii_bus *bus, int phy_addr,
+			     int devnum, int regnum, u16 value)
+{
+	struct wx *wx = bus->priv;
+
+	wr32(wx, WX_MDIO_CLAUSE_SELECT, 0);
+	return wx_phy_write_reg_mdi(bus, phy_addr, devnum, regnum, value);
+}
+EXPORT_SYMBOL(wx_phy_write_reg_mdi_c45);
+
 static void wx_intr_disable(struct wx *wx, u64 qmask)
 {
 	u32 mask;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 0b3447bc6f2f..48d3ccabc272 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -4,6 +4,13 @@
 #ifndef _WX_HW_H_
 #define _WX_HW_H_
 
+#include <linux/phy.h>
+
+int wx_phy_read_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum);
+int wx_phy_write_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum, u16 value);
+int wx_phy_read_reg_mdi_c45(struct mii_bus *bus, int phy_addr, int devnum, int regnum);
+int wx_phy_write_reg_mdi_c45(struct mii_bus *bus, int phy_addr,
+			     int devnum, int regnum, u16 value);
 void wx_intr_enable(struct wx *wx, u64 qmask);
 void wx_irq_disable(struct wx *wx);
 int wx_check_flash_load(struct wx *wx, u32 check_bit);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c5cbd177ef62..e3fc49284219 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -251,6 +251,7 @@ enum WX_MSCA_CMD_value {
 #define WX_MSCC_SADDR                BIT(18)
 #define WX_MSCC_BUSY                 BIT(22)
 #define WX_MDIO_CLK(v)               FIELD_PREP(GENMASK(21, 19), v)
+#define WX_MDIO_CLAUSE_SELECT        0x11220
 #define WX_MMC_CONTROL               0x11800
 #define WX_MMC_CONTROL_RSTONRD       BIT(2) /* reset on read */
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index 591f5b7b6da6..6302ecca71bb 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -29,117 +29,6 @@ static int ngbe_phy_write_reg_internal(struct mii_bus *bus, int phy_addr, int re
 	return 0;
 }
 
-static int ngbe_phy_read_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum)
-{
-	u32 command, val, device_type = 0;
-	struct wx *wx = bus->priv;
-	int ret;
-
-	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0xF);
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(device_type);
-	wr32(wx, WX_MSCA, command);
-	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) |
-		  WX_MSCC_BUSY |
-		  WX_MDIO_CLK(6);
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret) {
-		wx_err(wx, "Mdio read c22 command did not complete.\n");
-		return ret;
-	}
-
-	return (u16)rd32(wx, WX_MSCC);
-}
-
-static int ngbe_phy_write_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum, u16 value)
-{
-	u32 command, val, device_type = 0;
-	struct wx *wx = bus->priv;
-	int ret;
-
-	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0xF);
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(device_type);
-	wr32(wx, WX_MSCA, command);
-	command = value |
-		  WX_MSCC_CMD(WX_MSCA_CMD_WRITE) |
-		  WX_MSCC_BUSY |
-		  WX_MDIO_CLK(6);
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret)
-		wx_err(wx, "Mdio write c22 command did not complete.\n");
-
-	return ret;
-}
-
-static int ngbe_phy_read_reg_mdi_c45(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
-{
-	struct wx *wx = bus->priv;
-	u32 val, command;
-	int ret;
-
-	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0x0);
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(devnum);
-	wr32(wx, WX_MSCA, command);
-	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) |
-		  WX_MSCC_BUSY |
-		  WX_MDIO_CLK(6);
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret) {
-		wx_err(wx, "Mdio read c45 command did not complete.\n");
-		return ret;
-	}
-
-	return (u16)rd32(wx, WX_MSCC);
-}
-
-static int ngbe_phy_write_reg_mdi_c45(struct mii_bus *bus, int phy_addr,
-				      int devnum, int regnum, u16 value)
-{
-	struct wx *wx = bus->priv;
-	int ret, command;
-	u16 val;
-
-	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0x0);
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(devnum);
-	wr32(wx, WX_MSCA, command);
-	command = value |
-		  WX_MSCC_CMD(WX_MSCA_CMD_WRITE) |
-		  WX_MSCC_BUSY |
-		  WX_MDIO_CLK(6);
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret)
-		wx_err(wx, "Mdio write c45 command did not complete.\n");
-
-	return ret;
-}
-
 static int ngbe_phy_read_reg_c22(struct mii_bus *bus, int phy_addr, int regnum)
 {
 	struct wx *wx = bus->priv;
@@ -148,7 +37,7 @@ static int ngbe_phy_read_reg_c22(struct mii_bus *bus, int phy_addr, int regnum)
 	if (wx->mac_type == em_mac_type_mdi)
 		phy_data = ngbe_phy_read_reg_internal(bus, phy_addr, regnum);
 	else
-		phy_data = ngbe_phy_read_reg_mdi_c22(bus, phy_addr, regnum);
+		phy_data = wx_phy_read_reg_mdi_c22(bus, phy_addr, regnum);
 
 	return phy_data;
 }
@@ -162,7 +51,7 @@ static int ngbe_phy_write_reg_c22(struct mii_bus *bus, int phy_addr,
 	if (wx->mac_type == em_mac_type_mdi)
 		ret = ngbe_phy_write_reg_internal(bus, phy_addr, regnum, value);
 	else
-		ret = ngbe_phy_write_reg_mdi_c22(bus, phy_addr, regnum, value);
+		ret = wx_phy_write_reg_mdi_c22(bus, phy_addr, regnum, value);
 
 	return ret;
 }
@@ -262,8 +151,8 @@ int ngbe_mdio_init(struct wx *wx)
 	mii_bus->priv = wx;
 
 	if (wx->mac_type == em_mac_type_rgmii) {
-		mii_bus->read_c45 = ngbe_phy_read_reg_mdi_c45;
-		mii_bus->write_c45 = ngbe_phy_write_reg_mdi_c45;
+		mii_bus->read_c45 = wx_phy_read_reg_mdi_c45;
+		mii_bus->write_c45 = wx_phy_write_reg_mdi_c45;
 	}
 
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "ngbe-%x", pci_dev_id(pdev));
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 72c8cd2d5575..ff754d69bdf6 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -59,9 +59,6 @@
 #define NGBE_EEPROM_VERSION_L			0x1D
 #define NGBE_EEPROM_VERSION_H			0x1E
 
-/* Media-dependent registers. */
-#define NGBE_MDIO_CLAUSE_SELECT			0x11220
-
 /* GPIO Registers */
 #define NGBE_GPIO_DR				0x14800
 #define NGBE_GPIO_DDR				0x14804
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 4159c84035fd..b6c06adb8656 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -647,58 +647,6 @@ static int txgbe_sfp_register(struct txgbe *txgbe)
 	return 0;
 }
 
-static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
-			  int devnum, int regnum)
-{
-	struct wx *wx = bus->priv;
-	u32 val, command;
-	int ret;
-
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(devnum);
-	wr32(wx, WX_MSCA, command);
-
-	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) | WX_MSCC_BUSY;
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret) {
-		wx_err(wx, "Mdio read c45 command did not complete.\n");
-		return ret;
-	}
-
-	return (u16)rd32(wx, WX_MSCC);
-}
-
-static int txgbe_phy_write(struct mii_bus *bus, int phy_addr,
-			   int devnum, int regnum, u16 value)
-{
-	struct wx *wx = bus->priv;
-	int ret, command;
-	u16 val;
-
-	/* setup and write the address cycle command */
-	command = WX_MSCA_RA(regnum) |
-		  WX_MSCA_PA(phy_addr) |
-		  WX_MSCA_DA(devnum);
-	wr32(wx, WX_MSCA, command);
-
-	command = value | WX_MSCC_CMD(WX_MSCA_CMD_WRITE) | WX_MSCC_BUSY;
-	wr32(wx, WX_MSCC, command);
-
-	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
-				100000, false, wx, WX_MSCC);
-	if (ret)
-		wx_err(wx, "Mdio write c45 command did not complete.\n");
-
-	return ret;
-}
-
 static int txgbe_ext_phy_init(struct txgbe *txgbe)
 {
 	struct phy_device *phydev;
@@ -715,8 +663,8 @@ static int txgbe_ext_phy_init(struct txgbe *txgbe)
 		return -ENOMEM;
 
 	mii_bus->name = "txgbe_mii_bus";
-	mii_bus->read_c45 = &txgbe_phy_read;
-	mii_bus->write_c45 = &txgbe_phy_write;
+	mii_bus->read_c45 = &wx_phy_read_reg_mdi_c45;
+	mii_bus->write_c45 = &wx_phy_write_reg_mdi_c45;
 	mii_bus->parent = &pdev->dev;
 	mii_bus->phy_mask = GENMASK(31, 1);
 	mii_bus->priv = wx;
-- 
2.27.0


