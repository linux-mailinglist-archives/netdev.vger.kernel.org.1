Return-Path: <netdev+bounces-59287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56C81A34E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEBB21832
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2246436;
	Wed, 20 Dec 2023 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwQRC6h5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1146431
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C6C433C8;
	Wed, 20 Dec 2023 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087766;
	bh=fJOcoCrVnWHXJUhYt4sGGXvqJoVC1RYLBBH/bRdKu3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwQRC6h5oemXqN+K/N263s5plu9XyoQtBmA+QXdHGMcGFqk0Y0Qq2b91xK/+N+ooF
	 /2YganDC4lNuMlf2uq66LT1pHgFYSYIQTvTk7zDNbgw1oUpICia+QfB7kKYV8oPhW7
	 sbI1L5NKFFhB1e9AltvmizbkaCgJ/mC2LP4EdNvbkOHrr84LQEbmCYk+zJpqCVgNUp
	 4i+Vy9sqOla+7GJ47s+/7NM0/4YFAA5CdC35YYemaWuJJ+Vpo6Syz3s1bv7kH7gZep
	 SLLe1atpe9F3LEDFtOVwrNES3rqxjLT+Wmo0rou/xzG616sPb5w2C8R4VcuPW7KThk
	 zzqrPE6JXyPTg==
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
Subject: [PATCH net-next 14/15] net: phy: realtek: configure SerDes mode for rtl822x PHYs
Date: Wed, 20 Dec 2023 16:55:17 +0100
Message-ID: <20231220155518.15692-15-kabel@kernel.org>
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

From: Alexander Couzens <lynxis@fe80.eu>

The rtl822x series support switching SerDes mode between 2500base-x and
sgmii based on the negotiated copper speed.

Configure this switching mode according to SerDes modes supported by
host.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
[ refactored, dropped HiSGMII mode and changed commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 97 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index e2f68ac4b005..5d03c5b7afb5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -54,6 +54,11 @@
 						 RTL8201F_ISR_LINK)
 #define RTL8201F_IER				0x13
 
+#define RTL822X_VND1_SERDES_OPTION			0x697a
+#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII	0
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX	2
+
 #define RTL8221_GBCR				0xa412
 #define RTL8221_GANLPAR				0xa414
 
@@ -663,6 +668,60 @@ static int rtl822x_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_config_init(struct phy_device *phydev)
+{
+	bool has_2500, has_sgmii;
+	u16 mode;
+	int ret;
+
+	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    phydev->host_interfaces) ||
+		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
+
+	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
+			     phydev->host_interfaces) ||
+		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
+
+	if (!has_2500 && !has_sgmii)
+		return 0;
+
+	/* fill in possible interfaces */
+	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
+		     has_2500);
+	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
+		     has_sgmii);
+
+	/* determine SerDes option mode */
+	if (has_2500 && !has_sgmii)
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
+	else
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
+				     RTL822X_VND1_SERDES_OPTION,
+				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
+				     mode);
+	if (ret < 0)
+		return ret;
+
+	/* the following 3 writes into SerDes control are needed for 2500base-x
+	 * mode to work properly
+	 */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
+}
+
 static int rtl822x_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -689,9 +748,31 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 
+static void rtl822x_update_interface(struct phy_device *phydev)
+{
+	/* PHY changes SerDes mode between 2500base-x and sgmii based on
+	 * copper speed, if sgmii is supported
+	 */
+	if (!test_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces))
+		return;
+
+	switch (phydev->speed) {
+	case SPEED_2500:
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		break;
+	case SPEED_1000:
+	case SPEED_100:
+	case SPEED_10:
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		break;
+	default:
+		break;
+	}
+}
+
 static int rtl822x_read_status(struct phy_device *phydev)
 {
-	int val;
+	int ret, val;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8221_GANLPAR);
@@ -701,7 +782,13 @@ static int rtl822x_read_status(struct phy_device *phydev)
 		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
 	}
 
-	return genphy_c45_read_status(phydev);
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	rtl822x_update_interface(phydev);
+
+	return 0;
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
@@ -959,6 +1046,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226 2.5Gbps PHY",
 		.match_phy_device = rtl8226_match_phy_device,
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
@@ -969,6 +1057,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc840),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
@@ -979,6 +1068,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
@@ -989,6 +1079,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
@@ -999,6 +1090,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
@@ -1009,6 +1101,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc84a),
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
+		.config_init	= rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend	= genphy_c45_pma_suspend,
-- 
2.41.0


