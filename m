Return-Path: <netdev+bounces-247806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9DCFF228
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A57F318DC59
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC023A1A55;
	Wed,  7 Jan 2026 15:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798683A1A46;
	Wed,  7 Jan 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800371; cv=none; b=soMrTKt/R8PYKmvBX2iQX2dWy9IhOigwB58pZkbrtNWA0u11kaUvIt4iSKNF4oQSU9l+UjZSx5R3aDkgugMc2LPhW2wprTHqoXOr1YpPQrc+fH84Rv2hK4Vnuo/BzGFJBhZ1krTFUeyNKAyuDG/BlcNOLXITXmeL2oQtZnu6Noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800371; c=relaxed/simple;
	bh=Sp/NhXLAav+jPIZJo5b7ARAl5er/M0zjvIggZw9DWB0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Acf/XoqQvuc2v2RZGpP1yKn4VwG5r5ouYTgJScvmhtNQqougVTsBfpo0EokpbbakQ2wXEjza4FT0yIdOBnBDQ+l38h/wqrooFBzciC6cay/Q+KQsV85qEj/cLxTaZsB1Ph6yScNpgwKA0Vfa+hFVRLtoSmTVRUST64I0unT98zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vdVd1-000000004j9-3uZ8;
	Wed, 07 Jan 2026 15:39:20 +0000
Date: Wed, 7 Jan 2026 15:39:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mxl-gpy: implement SGMII in-band
 configuration
Message-ID: <70f07e46dd96e239a9711e6073e8c04c1d8672d4.1767800226.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

SGMII in-band autonegotiation was previously kept untouched (and restored
after switching back from 2500Base-X to SGMII). Now that the kernel offers
a way to announce in-band capabilities and nable/disable in-band AN,
implement the .inband_caps and .config_inband driver ops.
This moves the responsibility to configure SGMII in-band AN from the PHY
driver to phylink.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 61 ++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 8e2fd6b942b64..5f99766fb64c3 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -603,20 +603,6 @@ static int gpy_update_interface(struct phy_device *phydev)
 	case SPEED_100:
 	case SPEED_10:
 		phydev->interface = PHY_INTERFACE_MODE_SGMII;
-		if (gpy_sgmii_aneg_en(phydev))
-			break;
-		/* Enable and restart SGMII ANEG for 10/100/1000Mbps link speed
-		 * if ANEG is disabled (in 2500-BaseX mode).
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_SGMII_CTRL,
-				     VSPEC1_SGMII_ANEN_ANRS,
-				     VSPEC1_SGMII_ANEN_ANRS);
-		if (ret < 0) {
-			phydev_err(phydev,
-				   "Error: Enable of SGMII ANEG failed: %d\n",
-				   ret);
-			return ret;
-		}
 		break;
 	}
 
@@ -1060,6 +1046,27 @@ static int gpy_led_polarity_set(struct phy_device *phydev, int index,
 	return -EINVAL;
 }
 
+static unsigned int gpy_inband_caps(struct phy_device *phydev,
+				    phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE;
+	default:
+		return 0;
+	}
+}
+
+static int gpy_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_SGMII_CTRL,
+			      VSPEC1_SGMII_ANEN_ANRS,
+			      (modes == LINK_INBAND_DISABLE) ? 0 :
+			      VSPEC1_SGMII_ANEN_ANRS);
+}
+
 static struct phy_driver gpy_drivers[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY2xx),
@@ -1067,6 +1074,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1090,6 +1099,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1112,6 +1123,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1135,6 +1148,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1157,6 +1172,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1179,6 +1196,8 @@ static struct phy_driver gpy_drivers[] = {
 		.name		= "Maxlinear Ethernet GPY212B",
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -1202,6 +1221,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1225,6 +1246,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1247,6 +1270,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1269,6 +1294,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1286,6 +1313,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1303,6 +1332,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
@@ -1320,6 +1351,8 @@ static struct phy_driver gpy_drivers[] = {
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy_config_init,
 		.probe		= gpy_probe,
+		.inband_caps	= gpy_inband_caps,
+		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.config_aneg	= gpy_config_aneg,
-- 
2.52.0

