Return-Path: <netdev+bounces-29884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70B785065
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C83280D8C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 06:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909AB79FA;
	Wed, 23 Aug 2023 06:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A6A922
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:09:47 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52FE6A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 23:09:37 -0700 (PDT)
X-QQ-mid: bizesmtp73t1692770864tn3biux7
Received: from wxdbg.localdomain.com ( [60.177.96.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Aug 2023 14:07:43 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: k0mQ4ihyJQNzHAVC+pdaes6mQKpg8q40I8j5oZqjX3qy4q3hJWW8mnLaysj+h
	1xuZCNvekscY4YW0V2eMB3wJBbWTK9MOUTBXTxbaun38/s+5sAftV9LrDo8Zz3hyji2U6GP
	WiPUxXBvp2FEDOFfhr4XWmLxwKgtoO7x0su66j1VJCNuKTNFkQKMERXwg4YF4uZtn7UYFpv
	GExoztf7K6ZETtspXEEZkEZ3hzN1eW6fXGR2OqoakTIwuZOzpADxOt+9BtQ10HZHaF73SjU
	J4sMRrehRjTP9LKsKVtP43F2//dNgeWfbRRnlS1s+qLaywuWLQS1y+zEjW32+miRO36v1nw
	wiOTz63SG39EZEFQG0XBfJ4YUAUDvWboi7Eul83ye9oC6NgnAwSJBlWFpf4FfvqHLbk9UN1
	YAaaf48rvbg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1307842272495529687
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
Subject: [PATCH net-next v3 8/8] net: ngbe: move mdio access registers to libwx
Date: Wed, 23 Aug 2023 14:19:35 +0800
Message-Id: <20230823061935.415804-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230823061935.415804-1-jiawenwu@trustnetic.com>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fe20f02ecb3a..591f5b7b6da6 100644
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


