Return-Path: <netdev+bounces-20365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180175F2AA
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D14F2815A0
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B179FF;
	Mon, 24 Jul 2023 10:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BA99466
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:16:46 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB849C4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:16:43 -0700 (PDT)
X-QQ-mid: bizesmtp69t1690193681tqxjk6kf
Received: from wxdbg.localdomain.com ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 18:14:40 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: k0mQ4ihyJQO42PSqP1yTZVhIXsuw7rHdG1tmeblU1Ey9YyLrXeOKSYBU6mOnU
	So92gdJKZaiZ2PpevfZrX2/IXSatvI5QoTL+9aHgHbV6AGaaboeajxPFLaXF72ijqakEqRL
	fTa4iS2bG0tDcQVAFK79CShlK4P/zf2IrIukMNzwyn70OpWdwngn+sZg0NWKXReSWZRaV5p
	uWbrc2GTGdCvcVGTfnx1CO5pZPdmuKq0jYfExhCYIqhVuse/FcCeHvKOGYtlnC106tPwChX
	V/OhO5Ns8IgJssLkqXun3wl17vPk6O71XCvz7LO1OyA+OcK9maj7steKo1HddoKaytIiyG7
	YPmCN7HoQcmqPAtj2Xr8+SK8pMIRCJwX75IueE/bwrxzaat339FKL83BEidS9SMK6ixBmy9
	fL+VmGPeVd8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8837276640721424641
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Mon, 24 Jul 2023 18:23:38 +0800
Message-Id: <20230724102341.10401-5-jiawenwu@trustnetic.com>
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

Wangxun NICs support the connection with SFP to RJ45 module. In this case,
PCS need to be configured in SGMII mode.

Accroding to chapter 6.11.1 "SGMII Auto-Negitiation" of DesignWare Cores
Ethernet PCS (version 3.20a) and custom design manual, do the following
configuration when the interface mode is SGMII.

1. program VR_MII_AN_CTRL bit(3) [TX_CONFIG] = 1b (PHY side SGMII)
2. program VR_MII_AN_CTRL bit(8) [MII_CTRL] = 1b (8-bit MII)
3. program VR_MII_DIG_CTRL1 bit(0) [PHY_MODE_CTRL] = 1b

Also CL37 AN in backplane configurations need to be enabled because of the
special hardware design. Another thing to note is that PMA needs to be
reconfigured before each CL37 AN configuration for SGMII, otherwise AN will
fail, although we don't know why.

On this device, CL37_ANSGM_STS (bit[4:1] of VR_MII_AN_INTR_STS) indicates
the status received from remote link during the auto-negotiation, and
self-clear after the auto-negotiation is complete.
Meanwhile, CL37_ANCMPLT_INTR will be set to 1, to indicate CL37 AN is
complete. So add another way to get the state for CL37 SGMII.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/pcs/pcs-xpcs-wx.c |  5 ++--
 drivers/net/pcs/pcs-xpcs.c    | 46 ++++++++++++++++++++++++++++++++---
 drivers/net/pcs/pcs-xpcs.h    |  6 +++++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index 6d1df34958bd..7667924623fa 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -143,8 +143,9 @@ static bool txgbe_xpcs_mode_quirk(struct dw_xpcs *xpcs)
 	/* When txgbe do LAN reset, PCS will change to default 10GBASE-R mode */
 	ret = xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_CTRL2);
 	ret &= MDIO_PCS_CTRL2_TYPE;
-	if (ret == MDIO_PCS_CTRL2_10GBR &&
-	    xpcs->interface != PHY_INTERFACE_MODE_10GBASER)
+	if ((ret == MDIO_PCS_CTRL2_10GBR &&
+	     xpcs->interface != PHY_INTERFACE_MODE_10GBASER) ||
+	    xpcs->interface == PHY_INTERFACE_MODE_SGMII)
 		return true;
 
 	return false;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index f38b9241a942..9f7406b6dd38 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -668,7 +668,10 @@ EXPORT_SYMBOL_GPL(xpcs_config_eee);
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 				      unsigned int neg_mode)
 {
-	int ret, mdio_ctrl;
+	int ret, mdio_ctrl, tx_conf;
+
+	if (xpcs_dev_is_txgbe(xpcs))
+		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP);
 
 	/* For AN for C37 SGMII mode, the settings are :-
 	 * 1) VR_MII_MMD_CTRL Bit(12) [AN_ENABLE] = 0b (Disable SGMII AN in case
@@ -705,9 +708,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	ret |= (DW_VR_MII_PCS_MODE_C37_SGMII <<
 		DW_VR_MII_AN_CTRL_PCS_MODE_SHIFT &
 		DW_VR_MII_PCS_MODE_MASK);
-	ret |= (DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII <<
-		DW_VR_MII_AN_CTRL_TX_CONFIG_SHIFT &
-		DW_VR_MII_TX_CONFIG_MASK);
+	if (xpcs_dev_is_txgbe(xpcs)) {
+		ret |= DW_VR_MII_AN_CTRL_8BIT;
+		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
+	} else {
+		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
+	}
+	ret |= tx_conf << DW_VR_MII_AN_CTRL_TX_CONFIG_SHIFT &
+		DW_VR_MII_TX_CONFIG_MASK;
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, ret);
 	if (ret < 0)
 		return ret;
@@ -721,6 +729,9 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	else
 		ret &= ~DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
+	if (xpcs_dev_is_txgbe(xpcs))
+		ret |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
+
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
 	if (ret < 0)
 		return ret;
@@ -996,6 +1007,33 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
+	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
+		int speed, duplex;
+
+		state->link = true;
+
+		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1);
+		if (speed < 0)
+			return speed;
+
+		speed &= SGMII_SPEED_SS13 | SGMII_SPEED_SS6;
+		if (speed == SGMII_SPEED_SS6)
+			state->speed = SPEED_1000;
+		else if (speed == SGMII_SPEED_SS13)
+			state->speed = SPEED_100;
+		else if (speed == 0)
+			state->speed = SPEED_10;
+
+		duplex = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_ADVERTISE);
+		if (duplex < 0)
+			return duplex;
+
+		if (duplex & DW_FULL_DUPLEX)
+			state->duplex = DUPLEX_FULL;
+		else if (duplex & DW_HALF_DUPLEX)
+			state->duplex = DUPLEX_HALF;
+
+		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
 	}
 
 	return 0;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 08a8881614de..36a1786a2853 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -66,12 +66,14 @@
 
 /* VR_MII_DIG_CTRL1 */
 #define DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW		BIT(9)
+#define DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL	BIT(0)
 
 /* VR_MII_DIG_CTRL2 */
 #define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
 #define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
 
 /* VR_MII_AN_CTRL */
+#define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
 #define DW_VR_MII_AN_CTRL_TX_CONFIG_SHIFT	3
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
@@ -97,6 +99,10 @@
 #define SGMII_SPEED_SS13		BIT(13)	/* SGMII speed along with SS6 */
 #define SGMII_SPEED_SS6			BIT(6)	/* SGMII speed along with SS13 */
 
+/* SR MII MMD AN Advertisement defines */
+#define DW_HALF_DUPLEX			BIT(6)
+#define DW_FULL_DUPLEX			BIT(5)
+
 /* VR MII EEE Control 0 defines */
 #define DW_VR_MII_EEE_LTX_EN			BIT(0)  /* LPI Tx Enable */
 #define DW_VR_MII_EEE_LRX_EN			BIT(1)  /* LPI Rx Enable */
-- 
2.27.0


