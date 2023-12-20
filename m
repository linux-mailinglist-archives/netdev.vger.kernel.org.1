Return-Path: <netdev+bounces-59283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D395F81A34A
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612151F22A0B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2DC47782;
	Wed, 20 Dec 2023 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEK+O7c3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A484777F
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D0C433C8;
	Wed, 20 Dec 2023 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087754;
	bh=uN2oOY2uytuDyvfPFC7ZMgbdRr3OXmf+hM/f9Zp1z70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEK+O7c3IqEPGs+EapbwHmbTtm5s98EvlHC3AThMOQL4ISbIF454Igypnnql98IhD
	 Y5Frg7YrR4l69aOipg0AB/wgz5K0C5kR9SJ0pJFI26vZ32WGBaoobMpcw+6D18SPQC
	 L27f+F0rho1VCm9Tez/xZE/WnGwovQNnBDo6ma4TMB7KXoqafNYbo5apZeGxqFKlKz
	 ukwxtuny+PHh/vbj2y4/UJDY7dOOFRyAT2L3PyaXSp+Ju3+aIsSyyIWEbBea0dt1Rn
	 LHrTBi2F6Iw34iib1FYpSDE00+NpzyYW3w1XIaSD2tiiQVB8Gj6whMGVd59yp3cHKl
	 /9nwp5t5i97Cw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	=?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
	=?UTF-8?q?Maximili=C3=A1n=20Maliar?= <maximilian.maliar@nic.cz>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next 10/15] net: phy: realtek: use generic c45 AN config with 1000baseT vendor extension for rtl822x
Date: Wed, 20 Dec 2023 16:55:13 +0100
Message-ID: <20231220155518.15692-11-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
References: <20231220155518.15692-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that rtl822x PHYs .read_mmd() and .write_mmd() methods support
accessing all MMD registers, use the generic clause 45 functions
genphy_c45_an_config_aneg() and genphy_c45_pma_setup_forced() instead
of the clause 22 for configuring autonegotiation for the rtl822x
series.

Because 802.3-2018 does not define MMD registers for configuring
1000baseT autonegotiation, use vendor specific MMD register for this,
similar to how the marvell10g driver does it.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 0bb56d89157a..592de975248f 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -54,6 +54,8 @@
 						 RTL8201F_ISR_LINK)
 #define RTL8201F_IER				0x13
 
+#define RTL8221_GBCR				0xa412
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -650,23 +652,28 @@ static int rtl822x_probe(struct phy_device *phydev)
 
 static int rtl822x_config_aneg(struct phy_device *phydev)
 {
-	int ret = 0;
+	bool changed = false;
+	u16 val;
+	int ret;
 
-	if (phydev->autoneg == AUTONEG_ENABLE) {
-		u16 adv2500 = 0;
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
 
-		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-				      phydev->advertising))
-			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
 
-		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
-					       MDIO_AN_10GBT_CTRL_ADV2_5G,
-					       adv2500);
-		if (ret < 0)
-			return ret;
-	}
+	val = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, RTL8221_GBCR,
+				     ADVERTISE_1000FULL, val);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
 
-	return __genphy_config_aneg(phydev, ret);
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 
 static int rtl822x_read_status(struct phy_device *phydev)
-- 
2.41.0


