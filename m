Return-Path: <netdev+bounces-175912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA2A67F50
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E6C8849E5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E421421D;
	Tue, 18 Mar 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCD+boeI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA22066FF;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335638; cv=none; b=F4hBMezdgaHchsfM3M6aSn441DuKtYe2nonGOMNc+MSQXm00RIp6XLLZhSgUkdBKp4pTWY/F7zQ9x9o7lB61pgodVuCE6/zxjTE366Y+twhYVujfOj1vYWLNJoFLQx4F5ty+QjcjQ/YlBaufFGm2JmIdF4pIZNx3ecJcvJ4AlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335638; c=relaxed/simple;
	bh=RwxhfF8LyQu3rrtS2AK58FFCF1ul2y+qQzbpO8e2MAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5wJ/DhIGMLOn8XnaUvIGY92GbAmH819dFbOPFw0c5iUYZZkJm+IRVGoHVDhGBhoXq3cTgGmR+wQjuDYbTNWKpIQb5qmkBv20AA5OUR4dX7Q7/ynd1hVD9v+2bFnG+oh7NuX1YKPxHxybujHOHuHXpSkG61OPajrLliTOi3p6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCD+boeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69A88C4CEF5;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335638;
	bh=RwxhfF8LyQu3rrtS2AK58FFCF1ul2y+qQzbpO8e2MAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aCD+boeIvse/7bb39/0aNmlHX1baeZwzZaJdcKGVIkJUrlDdERs9ONe5HL6c7e0rP
	 R+pnm1pSa7zE0cZ0VJBdKwHdrMgCZmahOC6cEN4iNoYTtF0ZGFGBZSY5z/IACBgwcf
	 tzqXfOU8tAlkAem6nEBaxHOX0ursWxFO6ZG1kVlp1Flg64856QWWlugrLexHclYknv
	 80EWgQNSzES8x2El60pLabVJTXtBymJdADU2CKxSH6GfsDsh2g3YUnqBLZMWtt1rR0
	 TK2/lrFDneqKP67kRTS+wxawzOAm6rmHAyggdU9ZzYUR1VoxxsQkfeVda7qTwtb933
	 sMrVc98P/1nKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61936C35FF3;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 18 Mar 2025 23:06:55 +0100
Subject: [PATCH net-next v6 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-tn9510-v3a-v6-4-808a9089d24b@gmx.net>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
In-Reply-To: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742335636; l=8764;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=/eA6SDWVHD3SADXqLt2kQjcqtjSVgIlrVW1BBWTFIvY=;
 b=nnh5GDoVac3ptJYnt9TaGoadUXJB3nRKUZ6IDFTtEf1fp6WmbIjiarTPcCOeUM6majVPhLn7V
 1Csf4ZzIHDTB/wcSPgMlDid6pErGEsLINsA/RMiHjzcKKEHLJeLynaI
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
cards with aqr105 PHY, and use code from aqr107 functions wherever it
seemed to make sense.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/phy/aquantia/aquantia_main.c | 239 ++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 86b0e63de5d88fa1050919a8826bdbec4bbcf8ba..ce479b588a34ff4c705a7c9bf770d8864ea0d77a 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -50,6 +50,7 @@
 #define MDIO_AN_VEND_PROV_1000BASET_HALF	BIT(14)
 #define MDIO_AN_VEND_PROV_5000BASET_FULL	BIT(11)
 #define MDIO_AN_VEND_PROV_2500BASET_FULL	BIT(10)
+#define MDIO_AN_VEND_PROV_EXC_PHYID_INFO	BIT(6)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_EN		BIT(4)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
@@ -333,6 +334,238 @@ static int aqr_read_status(struct phy_device *phydev)
 	return genphy_c45_read_status(phydev);
 }
 
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
+static int aqr105_config_speed(struct phy_device *phydev)
+{
+	int vend = MDIO_AN_VEND_PROV_EXC_PHYID_INFO;
+	int ctrl10 = 0;
+	int adv = ADVERTISE_CSMA;
+	int ret;
+
+	switch (phydev->speed) {
+	case SPEED_100:
+		adv |= ADVERTISE_100FULL;
+		break;
+	case SPEED_1000:
+		adv |= ADVERTISE_NPAGE;
+		if (phydev->duplex == DUPLEX_FULL)
+			vend |= MDIO_AN_VEND_PROV_1000BASET_FULL;
+		else
+			vend |= MDIO_AN_VEND_PROV_1000BASET_HALF;
+		break;
+	case SPEED_2500:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
+		vend |= MDIO_AN_VEND_PROV_2500BASET_FULL;
+		break;
+	case SPEED_5000:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
+		vend |= MDIO_AN_VEND_PROV_5000BASET_FULL;
+		break;
+	case SPEED_10000:
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
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
+static int aqr105_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	u16 reg;
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
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	/* Clause 45 has no standardized support for 1000BaseT, therefore
+	 * use vendor registers for this mode.
+	 */
+	reg = 0;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_VEND_PROV_1000BASET_FULL;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_VEND_PROV_1000BASET_HALF;
+
+	/* Handle the case when the 2.5G and 5G speeds are not advertised */
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_VEND_PROV_2500BASET_FULL;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_VEND_PROV_5000BASET_FULL;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV,
+				     MDIO_AN_VEND_PROV_1000BASET_HALF |
+				     MDIO_AN_VEND_PROV_1000BASET_FULL |
+				     MDIO_AN_VEND_PROV_2500BASET_FULL |
+				     MDIO_AN_VEND_PROV_5000BASET_FULL, reg);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+static int aqr105_read_rate(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1);
+	if (val < 0)
+		return val;
+
+	if (val & MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX)
+		phydev->duplex = DUPLEX_FULL;
+	else
+		phydev->duplex = DUPLEX_HALF;
+
+	switch (FIELD_GET(MDIO_AN_TX_VEND_STATUS1_RATE_MASK, val)) {
+	case MDIO_AN_TX_VEND_STATUS1_10BASET:
+		phydev->speed = SPEED_10;
+		break;
+	case MDIO_AN_TX_VEND_STATUS1_100BASETX:
+		phydev->speed = SPEED_100;
+		break;
+	case MDIO_AN_TX_VEND_STATUS1_1000BASET:
+		phydev->speed = SPEED_1000;
+		break;
+	case MDIO_AN_TX_VEND_STATUS1_2500BASET:
+		phydev->speed = SPEED_2500;
+		break;
+	case MDIO_AN_TX_VEND_STATUS1_5000BASET:
+		phydev->speed = SPEED_5000;
+		break;
+	case MDIO_AN_TX_VEND_STATUS1_10GBASET:
+		phydev->speed = SPEED_10000;
+		break;
+	default:
+		phydev->speed = SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int aqr105_read_status(struct phy_device *phydev)
+{
+	int ret;
+	int val;
+
+	ret = aqr_read_status(phydev);
+	if (ret)
+		return ret;
+
+	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
+	/**
+	 * The status register is not immediately correct on line side link up.
+	 * Poll periodically until it reflects the correct ON state.
+	 * Only return fail for read error, timeout defaults to OFF state.
+	 */
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
+					MDIO_PHYXS_VEND_IF_STATUS, val,
+					(FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val) !=
+					MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF),
+					AQR107_OP_IN_PROG_SLEEP,
+					AQR107_OP_IN_PROG_TIMEOUT, false);
+	if (ret && ret != -ETIMEDOUT)
+		return ret;
+
+	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
+		phydev->interface = PHY_INTERFACE_MODE_10GKR;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KX:
+		phydev->interface = PHY_INTERFACE_MODE_1000BASEKX;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XFI:
+		phydev->interface = PHY_INTERFACE_MODE_10GBASER;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USXGMII:
+		phydev->interface = PHY_INTERFACE_MODE_USXGMII;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI:
+		phydev->interface = PHY_INTERFACE_MODE_XAUI;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII:
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI:
+		phydev->interface = PHY_INTERFACE_MODE_RXAUI;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		break;
+	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
+	default:
+		phydev->link = false;
+		phydev->interface = PHY_INTERFACE_MODE_NA;
+		break;
+	}
+
+	/* Read rate from vendor register */
+	return aqr105_read_rate(phydev);
+}
+
 static int aqr107_read_rate(struct phy_device *phydev)
 {
 	u32 config_reg;
@@ -911,11 +1144,13 @@ static struct phy_driver aqr_driver[] = {
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
2.47.2



