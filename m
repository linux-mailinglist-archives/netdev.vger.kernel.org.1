Return-Path: <netdev+bounces-20362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3475F292
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BB51C204F0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118FD8C02;
	Mon, 24 Jul 2023 10:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCA8BED
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:16:01 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0E46AF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:15:57 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193691t8knieub
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:51 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: /rrU+puPB7S3hUUaLrqbDwm28fl66WViyMUvt8bUpwlaPjSncsQWAle/GZ6zb
	mNIRkbRw0hUdhGr+C4hu7Co6PuhJFTqNH2DZPM6NME7JFZNHiJRDwNi81VUwplRTK2cIBBD
	ayH4CaKTdx4JCSfz5bdnsLqa//8b2zLdpio5eHNk51RVaF/B8g0lWZ5k1Vam7nsnSxBNO+3
	GO3myxMs/m961h/CjRPDp3rnOo/oy/NbMlMSue0fuzMjXLTkKYcETB50/5j+eKNMnfNqwcA
	zqjPw4VtoB6izhMv4Y96bV/uUNVGTsx+OAPb857BC7wz/ZrYkinW2yxoWagDsp3oQGuXu4r
	oy4VzB8SUafkZJ4PSgKmat65BcSbwtmEadqCId0XmQM7uMqx/cvTvNyMSFv2QlmI9kBaxlV
	6Rs4oBFrAdM=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10186371054072967765
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 7/7] net: ngbe: move mdio access registers to libwx
Date: Mon, 24 Jul 2023 18:23:41 +0800
Message-Id: <20230724102341.10401-8-jiawenwu@trustnetic.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Registers of mdio accessing are common defined in libwx, remove the
redundant macro definitions in ngbe driver.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 84 +++++++++----------
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 19 -----
 2 files changed, 42 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index cc2f325a52f7..60fc996bb53e 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -37,24 +37,24 @@ static int ngbe_phy_read_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regn
 
 	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0xF);
 	/* setup and write the address cycle command */
-	command = NGBE_MSCA_RA(regnum) |
-		  NGBE_MSCA_PA(phy_addr) |
-		  NGBE_MSCA_DA(device_type);
-	wr32(wx, NGBE_MSCA, command);
-	command = NGBE_MSCC_CMD(NGBE_MSCA_CMD_READ) |
-		  NGBE_MSCC_BUSY |
-		  NGBE_MDIO_CLK(6);
-	wr32(wx, NGBE_MSCC, command);
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(device_type);
+	wr32(wx, WX_MSCA, command);
+	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) |
+		  WX_MSCC_BUSY |
+		  WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
 
 	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & NGBE_MSCC_BUSY), 1000,
-				100000, false, wx, NGBE_MSCC);
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
 	if (ret) {
 		wx_err(wx, "Mdio read c22 command did not complete.\n");
 		return ret;
 	}
 
-	return (u16)rd32(wx, NGBE_MSCC);
+	return (u16)rd32(wx, WX_MSCC);
 }
 
 static int ngbe_phy_write_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int regnum, u16 value)
@@ -65,19 +65,19 @@ static int ngbe_phy_write_reg_mdi_c22(struct mii_bus *bus, int phy_addr, int reg
 
 	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0xF);
 	/* setup and write the address cycle command */
-	command = NGBE_MSCA_RA(regnum) |
-		  NGBE_MSCA_PA(phy_addr) |
-		  NGBE_MSCA_DA(device_type);
-	wr32(wx, NGBE_MSCA, command);
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(device_type);
+	wr32(wx, WX_MSCA, command);
 	command = value |
-		  NGBE_MSCC_CMD(NGBE_MSCA_CMD_WRITE) |
-		  NGBE_MSCC_BUSY |
-		  NGBE_MDIO_CLK(6);
-	wr32(wx, NGBE_MSCC, command);
+		  WX_MSCC_CMD(WX_MSCA_CMD_WRITE) |
+		  WX_MSCC_BUSY |
+		  WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
 
 	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & NGBE_MSCC_BUSY), 1000,
-				100000, false, wx, NGBE_MSCC);
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
 	if (ret)
 		wx_err(wx, "Mdio write c22 command did not complete.\n");
 
@@ -92,24 +92,24 @@ static int ngbe_phy_read_reg_mdi_c45(struct mii_bus *bus, int phy_addr, int devn
 
 	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0x0);
 	/* setup and write the address cycle command */
-	command = NGBE_MSCA_RA(regnum) |
-		  NGBE_MSCA_PA(phy_addr) |
-		  NGBE_MSCA_DA(devnum);
-	wr32(wx, NGBE_MSCA, command);
-	command = NGBE_MSCC_CMD(NGBE_MSCA_CMD_READ) |
-		  NGBE_MSCC_BUSY |
-		  NGBE_MDIO_CLK(6);
-	wr32(wx, NGBE_MSCC, command);
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
+	command = WX_MSCC_CMD(WX_MSCA_CMD_READ) |
+		  WX_MSCC_BUSY |
+		  WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
 
 	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & NGBE_MSCC_BUSY), 1000,
-				100000, false, wx, NGBE_MSCC);
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
 	if (ret) {
 		wx_err(wx, "Mdio read c45 command did not complete.\n");
 		return ret;
 	}
 
-	return (u16)rd32(wx, NGBE_MSCC);
+	return (u16)rd32(wx, WX_MSCC);
 }
 
 static int ngbe_phy_write_reg_mdi_c45(struct mii_bus *bus, int phy_addr,
@@ -121,19 +121,19 @@ static int ngbe_phy_write_reg_mdi_c45(struct mii_bus *bus, int phy_addr,
 
 	wr32(wx, NGBE_MDIO_CLAUSE_SELECT, 0x0);
 	/* setup and write the address cycle command */
-	command = NGBE_MSCA_RA(regnum) |
-		  NGBE_MSCA_PA(phy_addr) |
-		  NGBE_MSCA_DA(devnum);
-	wr32(wx, NGBE_MSCA, command);
+	command = WX_MSCA_RA(regnum) |
+		  WX_MSCA_PA(phy_addr) |
+		  WX_MSCA_DA(devnum);
+	wr32(wx, WX_MSCA, command);
 	command = value |
-		  NGBE_MSCC_CMD(NGBE_MSCA_CMD_WRITE) |
-		  NGBE_MSCC_BUSY |
-		  NGBE_MDIO_CLK(6);
-	wr32(wx, NGBE_MSCC, command);
+		  WX_MSCC_CMD(WX_MSCA_CMD_WRITE) |
+		  WX_MSCC_BUSY |
+		  WX_MDIO_CLK(6);
+	wr32(wx, WX_MSCC, command);
 
 	/* wait to complete */
-	ret = read_poll_timeout(rd32, val, !(val & NGBE_MSCC_BUSY), 1000,
-				100000, false, wx, NGBE_MSCC);
+	ret = read_poll_timeout(rd32, val, !(val & WX_MSCC_BUSY), 1000,
+				100000, false, wx, WX_MSCC);
 	if (ret)
 		wx_err(wx, "Mdio write c45 command did not complete.\n");
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index b70eca397b67..72c8cd2d5575 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -59,25 +59,6 @@
 #define NGBE_EEPROM_VERSION_L			0x1D
 #define NGBE_EEPROM_VERSION_H			0x1E
 
-/* mdio access */
-#define NGBE_MSCA				0x11200
-#define NGBE_MSCA_RA(v)				FIELD_PREP(U16_MAX, v)
-#define NGBE_MSCA_PA(v)				FIELD_PREP(GENMASK(20, 16), v)
-#define NGBE_MSCA_DA(v)				FIELD_PREP(GENMASK(25, 21), v)
-#define NGBE_MSCC				0x11204
-#define NGBE_MSCC_CMD(v)			FIELD_PREP(GENMASK(17, 16), v)
-
-enum NGBE_MSCA_CMD_value {
-	NGBE_MSCA_CMD_RSV = 0,
-	NGBE_MSCA_CMD_WRITE,
-	NGBE_MSCA_CMD_POST_READ,
-	NGBE_MSCA_CMD_READ,
-};
-
-#define NGBE_MSCC_SADDR				BIT(18)
-#define NGBE_MSCC_BUSY				BIT(22)
-#define NGBE_MDIO_CLK(v)			FIELD_PREP(GENMASK(21, 19), v)
-
 /* Media-dependent registers. */
 #define NGBE_MDIO_CLAUSE_SELECT			0x11220
 
-- 
2.27.0


