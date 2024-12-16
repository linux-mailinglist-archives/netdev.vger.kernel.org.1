Return-Path: <netdev+bounces-152274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A109F3547
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7438169DAC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C0176ADE;
	Mon, 16 Dec 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YUxf97R3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9E14264A;
	Mon, 16 Dec 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365118; cv=none; b=NxBCjhyKNAz2lZz3LzU77lRtoPUMOiy82yHPBSx2hNVrPQ157nbEZkH3eooET+ok4P/+RqVt7s+LzQUM/7bJTn58XpKsARKiPxaO+6adLgciOmEYRvh0AqIvbzY0fChz7eM4qqMlmjMEpQZPMvz9AUmpiRs0NmaLmLD9QBBM6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365118; c=relaxed/simple;
	bh=SoPWuP3RpegI1yn9SWwCawdjtKDS6Auas23SpxkrCrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh3IcajNHOc1J9zApKYcTCAuLJ1M4ODzMAFJgYSYh/Ft21OlfNFRr/9d6UVTCsZg01wNYJdt8kTCGChaZO576rHU1mPW9dg9C2ZzETZ0CIRmoN2uHdXIKKJJ8TFX2eZpR30ReswMfShC3L/DzI5rQn8nlJ70tfSr7yxQpwPePsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YUxf97R3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734365116; x=1765901116;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SoPWuP3RpegI1yn9SWwCawdjtKDS6Auas23SpxkrCrI=;
  b=YUxf97R3x6QSQMvdsEwIJ2htHjApwE73O20j9WFR/qY8DhzyhkbA/lUX
   qdyEGvXSH4GMyEpoSL70lol9y/Rf6SQJ7vpgkNqu+FY4gnb9MCVGdwIoL
   9oLD6Jx4thtR1vgcItUCnECcAfRes0O8+NV84rFtevx/CEZlGoIF8/UaQ
   Jks+9ZvtxoHfaiEHd85SXffHk4lE9ZLl9VdKBFD1M43Q09fp3TMhaeI92
   RNIR3tKqbYw8qHjoWrdgvzkXrxVKACaMEpeoLa6c6pm0p/2m3dDnFLD+w
   isC/e3Jst9HQuDObJ7lndCelobBpDWNyZsoXGYrPlHIpk/ny6r08eKAtJ
   w==;
X-CSE-ConnectionGUID: HgADXUGmStKNGYtSiPP8QQ==
X-CSE-MsgGUID: 4v2noHWZTNSBsCdlN2zycw==
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="35271702"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 09:05:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 09:04:36 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Dec 2024 09:04:32 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotiation support for LAN887x
Date: Mon, 16 Dec 2024 21:28:30 +0530
Message-ID: <20241216155830.501596-3-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216155830.501596-1-Tarun.Alle@microchip.com>
References: <20241216155830.501596-1-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds auto-negotiation support for lan887x T1 phy. After this commit,
by default auto-negotiation is on and default advertised speed is 1000M.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
v1 -> v2
- Changed the commit message.
- Elaborated the errata messages.
- Added helper functions for lan887x_100M_setup.
---
 drivers/net/phy/microchip_t1.c | 159 +++++++++++++++++++++++++++------
 1 file changed, 132 insertions(+), 27 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index b17bf6708003..694e001f8a15 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -268,6 +268,11 @@
 /* End offset of samples */
 #define SQI_INLIERS_END (SQI_INLIERS_START + SQI_INLIERS_NUM)
 
+#define LAN887X_VEND_CTRL_STAT_REG		0x8013
+#define LAN887X_AN_LOCAL_CFG_FAULT		BIT(10)
+#define LAN887X_AN_LOCAL_SLAVE			BIT(9)
+#define LAN887X_AN_LOCAL_MASTER			BIT(8)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1259,11 +1264,6 @@ static int lan887x_get_features(struct phy_device *phydev)
 	/* Enable twisted pair */
 	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
 
-	/* First patch only supports 100Mbps and 1000Mbps force-mode.
-	 * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
-	 */
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
-
 	return 0;
 }
 
@@ -1342,28 +1342,44 @@ static int lan887x_phy_setup(struct phy_device *phydev)
 	return lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
 }
 
+static int lan887x_100M_forced_slave_setup(struct phy_device *phydev)
+{
+	static const struct lan887x_regwr_map phy_cfg[] = {
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4,
+		 0x0038},
+		{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100,
+		 0x0014},
+	};
+
+	return lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+}
+
+static int lan887x_100M_common_setup(struct phy_device *phydev)
+{
+	static const struct lan887x_regwr_map phy_comm_cfg[] = {
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
+		{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x0038},
+		{MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100, 0x000f},
+	};
+
+	return lan887x_phy_config(phydev, phy_comm_cfg,
+				  ARRAY_SIZE(phy_comm_cfg));
+}
+
 static int lan887x_100M_setup(struct phy_device *phydev)
 {
+	bool is_master;
 	int ret;
 
+	is_master = (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
+		     phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_PREFERRED);
+
 	/* (Re)configure the speed/mode dependent T1 settings */
-	if (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
-	    phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_PREFERRED){
-		static const struct lan887x_regwr_map phy_cfg[] = {
-			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
-			{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x0038},
-			{MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100, 0x000f},
-		};
-
-		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
-	} else {
-		static const struct lan887x_regwr_map phy_cfg[] = {
-			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x0038},
-			{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100, 0x0014},
-		};
+	if (phydev->autoneg == AUTONEG_ENABLE || is_master)
+		ret = lan887x_100M_common_setup(phydev);
+	else
+		ret = lan887x_100M_forced_slave_setup(phydev);
 
-		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
-	}
 	if (ret < 0)
 		return ret;
 
@@ -1384,8 +1400,16 @@ static int lan887x_1000M_setup(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	return phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, LAN887X_DSP_PMA_CONTROL,
-				LAN887X_DSP_PMA_CONTROL_LNK_SYNC);
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       LAN887X_REG_REG26,
+				       LAN887X_REG_REG26_HW_INIT_SEQ_EN);
+	else
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD,
+				       LAN887X_DSP_PMA_CONTROL,
+				       LAN887X_DSP_PMA_CONTROL_LNK_SYNC);
+
+	return ret;
 }
 
 static int lan887x_link_setup(struct phy_device *phydev)
@@ -1407,6 +1431,11 @@ static int lan887x_phy_reset(struct phy_device *phydev)
 {
 	int ret, val;
 
+	/* Disable aneg */
+	ret = genphy_c45_an_disable_aneg(phydev);
+	if (ret < 0)
+		return ret;
+
 	/* Clear 1000M link sync */
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, LAN887X_DSP_PMA_CONTROL,
 				 LAN887X_DSP_PMA_CONTROL_LNK_SYNC);
@@ -1435,23 +1464,71 @@ static int lan887x_phy_reset(struct phy_device *phydev)
 				    5000, 10000, true);
 }
 
+/* LAN887X Errata: The device may not link in auto-neg when both
+ * 100BASE-T1 and 1000BASE-T1 are advertised. Hence advertising
+ * only one speed. In this case auto-neg to determine Leader/Follower.
+ */
+static int lan887x_config_advert(struct phy_device *phydev)
+{
+	linkmode_and(phydev->advertising, phydev->advertising,
+		     phydev->supported);
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			      phydev->advertising)) {
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				   phydev->advertising);
+		phydev->speed = SPEED_1000;
+	} else if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				     phydev->advertising)) {
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+				   phydev->advertising);
+		phydev->speed = SPEED_100;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int lan887x_phy_reconfig(struct phy_device *phydev)
 {
 	int ret;
 
-	linkmode_zero(phydev->advertising);
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		ret = genphy_c45_an_config_aneg(phydev);
+	else
+		ret = genphy_c45_pma_setup_forced(phydev);
+	if (ret < 0)
+		return ret;
 
-	ret = genphy_c45_pma_setup_forced(phydev);
+	/* For link to comeup, (re)configure the speed/mode
+	 * dependent T1 settings
+	 */
+	ret = lan887x_link_setup(phydev);
 	if (ret < 0)
 		return ret;
 
-	return lan887x_link_setup(phydev);
+	/* Autoneg to be re-started only after all settings are done */
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret = genphy_c45_restart_aneg(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int lan887x_config_aneg(struct phy_device *phydev)
 {
 	int ret;
 
+	/* Reject the not support advertisement settings */
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		ret  = lan887x_config_advert(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* LAN887x Errata: speed configuration changes require soft reset
 	 * and chip soft reset
 	 */
@@ -2058,6 +2135,34 @@ static int lan887x_get_sqi(struct phy_device *phydev)
 	return FIELD_GET(T1_DCQ_SQI_MSK, rc);
 }
 
+static int lan887x_read_status(struct phy_device *phydev)
+{
+	int rc;
+
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	rc = genphy_c45_read_status(phydev);
+	if (rc < 0)
+		return rc;
+
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		/* Fetch resolved mode */
+		rc = phy_read_mmd(phydev, MDIO_MMD_AN,
+				  LAN887X_VEND_CTRL_STAT_REG);
+		if (rc < 0)
+			return rc;
+
+		if (rc & LAN887X_AN_LOCAL_MASTER)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+		else if (rc & LAN887X_AN_LOCAL_SLAVE)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+		else if (rc & LAN887X_AN_LOCAL_CFG_FAULT)
+			phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
+	}
+
+	return 0;
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -2106,7 +2211,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.get_strings    = lan887x_get_strings,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-		.read_status	= genphy_c45_read_status,
+		.read_status	= lan887x_read_status,
 		.cable_test_start = lan887x_cable_test_start,
 		.cable_test_get_status = lan887x_cable_test_get_status,
 		.config_intr    = lan887x_config_intr,
-- 
2.34.1


