Return-Path: <netdev+bounces-150270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC959E9B72
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A367028217B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75B14A60F;
	Mon,  9 Dec 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lSiWm8o/"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6497513D638;
	Mon,  9 Dec 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761235; cv=none; b=RL6ig0NdWSc6ZOurOLUMK7qDjKDyZzoMpACdTw3WOQ4x6TBZU7g5dWsP8o31BXNZi4D33zKFwbZ4SvpqHjjFvjgqZIJsQpFW2P/lRcl+HJXX0X82nplAoErFxc32LS0jYlRqd9MV7lLz0QmFxfTXjj9sYdjvnkwalX/qsI8g228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761235; c=relaxed/simple;
	bh=zEM5sGwnK8jbcNCd30OlcreC3ZV9KvdarCeo9ahvO/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX2iqFpZjNezkMyihQ4STZyQxwI1oMzrXfVctaJS9dj5Vi6ZoK0EGGGp7BOtMuWXczBAd3mn49u1NI+DueB7pVUnMsznqb2d4jyMfc9p3h8dy6R1dA+EFGevYndFBl2nvNCbK0q2KKZenkFcv41yO8g63bTw4qJAsVTMkOn1C7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lSiWm8o/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733761234; x=1765297234;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=zEM5sGwnK8jbcNCd30OlcreC3ZV9KvdarCeo9ahvO/I=;
  b=lSiWm8o/MLrgxgmpzwE9xka8AA0JIzzOQIP+lv6rlxszxpsizvWw9VUq
   WHxkMBSeMWzAG1GX9ZJUGTJZfR0BV4lW0XPpGNt8GafDP3pQ6qo2y3cIl
   PVO5eiRVnr9cPyOqOQLiEbf8V7Vi2m+WdYXyvOzSEaVd6wVNm8TX95/l5
   foKqOLRdl82QJFUDf0rKDqFU7ryvHkgFO64YCgTah0ZTIUIj3CoVQA0n9
   EHm3OtdJ6lhtrwl8AgFXzMLMrsj+ZE83BqCaheGFHtMx3EcD1aa80EAbm
   DglpLvPv1+bA4CraZGkEcM0DjSc9sbKYiefwLOLU5l+Bgm8US98KFMU9k
   A==;
X-CSE-ConnectionGUID: JLL7S6y7ROGYO+q1cU6U3w==
X-CSE-MsgGUID: wDpFiZV9RvSP4oWuRd5a1A==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35311727"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 09:20:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 09:20:25 -0700
Received: from HYD-DK-UNGSW20.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 09:20:22 -0700
From: Tarun Alle <Tarun.Alle@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion support for LAN887x T1 phy
Date: Mon, 9 Dec 2024 21:44:27 +0530
Message-ID: <20241209161427.3580256-3-Tarun.Alle@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Adds auto-negotiation support for lan887x T1 phy.

Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 147 +++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index b17bf6708003..b8e65cb7d29e 100644
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
 
@@ -1344,25 +1344,34 @@ static int lan887x_phy_setup(struct phy_device *phydev)
 
 static int lan887x_100M_setup(struct phy_device *phydev)
 {
+	static const struct lan887x_regwr_map phy_comm_cfg[] = {
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
+		{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x0038},
+		{MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100, 0x000f},
+	};
 	int ret;
 
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
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		if (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
+		    phydev->master_slave_set ==
+		    MASTER_SLAVE_CFG_MASTER_PREFERRED) {
+			ret = lan887x_phy_config(phydev, phy_comm_cfg,
+						 ARRAY_SIZE(phy_comm_cfg));
+		} else {
+			static const struct lan887x_regwr_map phy_cfg[] = {
+				{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4,
+				 0x0038},
+				{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100,
+				 0x0014},
+			};
+
+			ret = lan887x_phy_config(phydev, phy_cfg,
+						 ARRAY_SIZE(phy_cfg));
+		}
 	} else {
-		static const struct lan887x_regwr_map phy_cfg[] = {
-			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x0038},
-			{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100, 0x0014},
-		};
-
-		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+		ret = lan887x_phy_config(phydev, phy_comm_cfg,
+					 ARRAY_SIZE(phy_comm_cfg));
 	}
 	if (ret < 0)
 		return ret;
@@ -1384,8 +1393,16 @@ static int lan887x_1000M_setup(struct phy_device *phydev)
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
@@ -1407,6 +1424,11 @@ static int lan887x_phy_reset(struct phy_device *phydev)
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
@@ -1435,23 +1457,68 @@ static int lan887x_phy_reset(struct phy_device *phydev)
 				    5000, 10000, true);
 }
 
+/* LAN887X Errata: 100M master issue. Dual speed in Aneg is not supported. */
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
@@ -2058,6 +2125,34 @@ static int lan887x_get_sqi(struct phy_device *phydev)
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
@@ -2106,7 +2201,7 @@ static struct phy_driver microchip_t1_phy_driver[] = {
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


