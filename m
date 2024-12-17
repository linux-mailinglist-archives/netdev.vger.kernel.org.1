Return-Path: <netdev+bounces-152714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E39F5871
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D464F188056F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C81FA8EF;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG2Rlv2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613361FA8E5
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=aoeualbj2UNshBH8OMdd+8GML5WlpTFxKTA6cDaCG3ghesveNMccFdXRIiLjkfuKBLi1bf+azA/wYcQl9Ps9ydUlRTEmtBy2BfhjfylkCoHtOj8T1BFSLNkKgy7lLf7eC96usR7h9Jlpn2Msf4lCszImhB4u5L7b2ZRj9XalfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=AcJSOyIBzMiESsPiZBPHRGeIdC9AC1Kg2n1SPRoVeYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEX9qTQ5xMv6yCiU4AoxZOAKsnUv9w+HNtf9yKDlSzabQPBNwsO0Im+6gD/0Ua3w+YFgyEJDQINl2vTfvqOvSIFYRg3PZPLsVlhg9BGCoYoqdY48JIHTLgMJoysTsqO8avl4qlRVutbb5b95exkLffQQ9yBj627/Ksb/LtUYGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG2Rlv2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08BB4C4CEE3;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469659;
	bh=AcJSOyIBzMiESsPiZBPHRGeIdC9AC1Kg2n1SPRoVeYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZG2Rlv2I+QLDD6U8TuG0AabcddPjdvtLXluZKg5xAZa79H/R9Yh75cvYWYzOAkMBb
	 M7+StddYZvn/EMJxjyt6UWHwSnjf0JsW+sCO3t4YdT8HP3AUvsaa/iWvh8gmuTL5Eu
	 f+3Oy0lEOe4jzMSRw/SfA4TmpGwQ4WzZEwh0sDq8PVqfYP2tGI20hputg9em5B10fx
	 98a3Dk+Qntf04qWAB4PCWNQcwKJqZbkAVlwIDYppazG9OQEN/8ZY+RLdM8PJxfMswf
	 RbTEg5K58lkDtVL6m8GgokVeO4kvvSKQkZUNO5ZZw8xWbnJnz9OL7M1mGSuTwuIe+V
	 L2nN7+7R1OEhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA3E7717F;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:35 +0100
Subject: [PATCH net-next v3 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-4-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=8794;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=ctTiAl4wmGgoj/eQI0xNjdg5Ki78Oas1YQuhYekuf7U=;
 b=DtNmreKSV9fBZlNUyqr2E4il9DPJxSjz+A4HuIby6BVVZ7f+oTjVf0yJaYs0GP5yrVf71Nhgo
 dj3eoJMD9rvAiH0vanLbfvUYo3FfMGRZvO/fSzShloneBqrS04XLdNG
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

This patch makes functions that were provided for aqr107 applicable to
aqr105, or replaces generic functions with specific ones. Since the aqr105
was introduced before NBASE-T was defined (or 802.3bz), there are a number
of vendor specific registers involved in the definition of the
advertisement, in auto-negotiation and in the setting of the speed. The
functions have been written following the downstream driver for TN4010
cards with AQR105 PHY. To avoid duplication of code, aqr_config_aneg was
split in a common part and a specific part for aqr105 and other aqr PHYs.
A similar approach has been chosen for the aqr107_read_status function.
Here, the aqr generation (=1 for aqr105, and =2 for aqr107 and higher) is
used to decide whether aqr107(and up) specific registers can be used. I
know this is not particularly elegant, but it is doing the job.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/phy/aquantia/aquantia_main.c | 168 ++++++++++++++++++++++++++-----
 1 file changed, 144 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 81eeee29ba3e6fb11a476a5b51a8a8be061ca8c3..a112e3473e079822671535c313f3ae816fe186dd 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -33,6 +33,9 @@
 #define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
+#define MDIO_AN_10GBT_CTRL_ADV_LTIM		BIT(0)
+#define ADVERTISE_XNP				BIT(12)
+
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
@@ -50,6 +53,7 @@
 #define MDIO_AN_VEND_PROV_1000BASET_HALF	BIT(14)
 #define MDIO_AN_VEND_PROV_5000BASET_FULL	BIT(11)
 #define MDIO_AN_VEND_PROV_2500BASET_FULL	BIT(10)
+#define MDIO_AN_VEND_PROV_EXC_PHYID_INFO	BIT(6)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_EN		BIT(4)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
@@ -107,6 +111,30 @@
 #define AQR107_OP_IN_PROG_SLEEP		1000
 #define AQR107_OP_IN_PROG_TIMEOUT	100000
 
+static int aqr105_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Normal feature discovery */
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
+	 * here
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->supported);
+
+	/* The AQR105 PHY suppports both RJ45 and SFP+ interfaces */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
+
+	return 0;
+}
+
 static int aqr107_get_sset_count(struct phy_device *phydev)
 {
 	return AQR107_SGMII_STAT_SZ;
@@ -164,6 +192,59 @@ static void aqr107_get_stats(struct phy_device *phydev,
 	}
 }
 
+static int aqr105_config_speed(struct phy_device *phydev)
+{
+	int vend = MDIO_AN_VEND_PROV_EXC_PHYID_INFO;
+	int ctrl10 = MDIO_AN_10GBT_CTRL_ADV_LTIM;
+	int adv = ADVERTISE_CSMA;
+	int ret;
+
+	/* Half duplex is not supported */
+	if (phydev->duplex != DUPLEX_FULL)
+		return -EINVAL;
+
+	switch (phydev->speed) {
+	case SPEED_100:
+		adv |= ADVERTISE_100FULL;
+		break;
+	case SPEED_1000:
+		adv |= ADVERTISE_NPAGE;
+		vend |= MDIO_AN_VEND_PROV_1000BASET_FULL;
+		break;
+	case SPEED_2500:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
+		vend |= MDIO_AN_VEND_PROV_2500BASET_FULL;
+		break;
+	case SPEED_5000:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
+		vend |= MDIO_AN_VEND_PROV_5000BASET_FULL;
+		break;
+	case SPEED_10000:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
+		ctrl10 |= MDIO_AN_10GBT_CTRL_ADV10G;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_ADVERTISE, adv);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV, vend);
+	if (ret < 0)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL, ctrl10);
+	if (ret < 0)
+		return ret;
+
+	/* set by vendor driver, but should be on by default */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_CTRL1,
+			       MDIO_AN_CTRL1_XNP);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_an_disable_aneg(phydev);
+}
+
 static int aqr_set_mdix(struct phy_device *phydev, int mdix)
 {
 	u16 val = 0;
@@ -186,21 +267,11 @@ static int aqr_set_mdix(struct phy_device *phydev, int mdix)
 				      MDIO_AN_RESVD_VEND_PROV_MDIX_MASK, val);
 }
 
-static int aqr_config_aneg(struct phy_device *phydev)
+static int aqr_common_config_aneg(struct phy_device *phydev, bool changed)
 {
-	bool changed = false;
 	u16 reg;
 	int ret;
 
-	ret = aqr_set_mdix(phydev, phydev->mdix_ctrl);
-	if (ret < 0)
-		return ret;
-	if (ret > 0)
-		changed = true;
-
-	if (phydev->autoneg == AUTONEG_DISABLE)
-		return genphy_c45_pma_setup_forced(phydev);
-
 	ret = genphy_c45_an_config_aneg(phydev);
 	if (ret < 0)
 		return ret;
@@ -241,6 +312,40 @@ static int aqr_config_aneg(struct phy_device *phydev)
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 
+static int aqr105_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret;
+
+	ret = aqr_set_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return aqr105_config_speed(phydev);
+
+	return aqr_common_config_aneg(phydev, changed);
+}
+
+static int aqr_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret;
+
+	ret = aqr_set_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	return aqr_common_config_aneg(phydev, changed);
+}
+
 static int aqr_config_intr(struct phy_device *phydev)
 {
 	bool en = phydev->interrupts == PHY_INTERRUPT_ENABLED;
@@ -333,7 +438,7 @@ static int aqr_read_status(struct phy_device *phydev)
 	return genphy_c45_read_status(phydev);
 }
 
-static int aqr107_read_rate(struct phy_device *phydev)
+static int aqr_common_read_rate(struct phy_device *phydev, int aqr_gen)
 {
 	u32 config_reg;
 	int val;
@@ -377,20 +482,22 @@ static int aqr107_read_rate(struct phy_device *phydev)
 		return 0;
 	}
 
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, config_reg);
-	if (val < 0)
-		return val;
+	if (aqr_gen > 1) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, config_reg);
+		if (val < 0)
+			return val;
 
-	if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
-	    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
-		phydev->rate_matching = RATE_MATCH_PAUSE;
-	else
-		phydev->rate_matching = RATE_MATCH_NONE;
+		if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
+		    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
+			phydev->rate_matching = RATE_MATCH_PAUSE;
+		else
+			phydev->rate_matching = RATE_MATCH_NONE;
+	}
 
 	return 0;
 }
 
-static int aqr107_read_status(struct phy_device *phydev)
+static int aqr_common_read_status(struct phy_device *phydev, int aqr_gen)
 {
 	int val, ret;
 
@@ -415,6 +522,7 @@ static int aqr107_read_status(struct phy_device *phydev)
 	if (ret && ret != -ETIMEDOUT)
 		return ret;
 
+	phydev->rate_matching = RATE_MATCH_NONE;
 	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
 	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
 		phydev->interface = PHY_INTERFACE_MODE_10GKR;
@@ -448,7 +556,17 @@ static int aqr107_read_status(struct phy_device *phydev)
 	}
 
 	/* Read possibly downshifted rate from vendor register */
-	return aqr107_read_rate(phydev);
+	return aqr_common_read_rate(phydev, aqr_gen);
+}
+
+static int aqr105_read_status(struct phy_device *phydev)
+{
+	return aqr_common_read_status(phydev, 1);
+}
+
+static int aqr107_read_status(struct phy_device *phydev)
+{
+	return aqr_common_read_status(phydev, 2);
 }
 
 static int aqr107_get_downshift(struct phy_device *phydev, u8 *data)
@@ -911,11 +1029,13 @@ static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
 	.name		= "Aquantia AQR105",
-	.config_aneg    = aqr_config_aneg,
+	.get_features	= aqr105_get_features,
 	.probe		= aqr107_probe,
+	.config_init	= aqr107_config_init,
+	.config_aneg    = aqr105_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr_read_status,
+	.read_status	= aqr105_read_status,
 	.suspend	= aqr107_suspend,
 	.resume		= aqr107_resume,
 },

-- 
2.45.2



