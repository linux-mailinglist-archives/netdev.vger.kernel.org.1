Return-Path: <netdev+bounces-59281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32181A346
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF128284C04
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8A41848;
	Wed, 20 Dec 2023 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLu3Cejp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81241758
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEB8C433C8;
	Wed, 20 Dec 2023 15:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087748;
	bh=574Q5WY6nEhF+i8W6zW70DuyAHWLKf6J5HFpzxgr+tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLu3CejpfWauN4R34zDUUJ9jl6pGZFNVaES7s25vhhNZXYuP5WruoMDaSAWC6igBD
	 snKc87/2u+rCS11UHQ+qsb5X4nwKmqpzzHohfwb/x8xu5BXuJMS0C1HkUdTGAz9dxC
	 bopThn8rACuSq4y3eaLnNOKCI1BYrBrQVFKzvq67SOaBYXjCuyjcJgwW82Fp1mDOSk
	 qDs07jJbRTzsGYuGqItSORxkTktqGwwUyOB3Gm6KKoUACHUZi5ANDQBkTQbGs9tdWm
	 +4s7geyvV8sPw74NPJqlUMM/nNoH4uictLfRQd95KU3dkSCBL/hsVnQ6CBOjDFz36B
	 Xfi/khtJrMjVg==
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
Subject: [PATCH net-next 08/15] net: phy: realtek: use generic clause 45 feature reading for rtl822x PHYs
Date: Wed, 20 Dec 2023 16:55:11 +0100
Message-ID: <20231220155518.15692-9-kabel@kernel.org>
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
accessing all MMD registers, drop the .get_features() method so that
phy_probe() will use the generic genphy_c45_pma_read_abilities(),
which works properly on these trasceivers.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index c621ce9378c5..66515981d2aa 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -648,24 +648,6 @@ static int rtl822x_probe(struct phy_device *phydev)
 	return 0;
 }
 
-static int rtl822x_get_features(struct phy_device *phydev)
-{
-	int val;
-
-	val = phy_read_paged(phydev, 0xa61, 0x13);
-	if (val < 0)
-		return val;
-
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
-			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
-			 phydev->supported, val & MDIO_PMA_SPEED_5G);
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-			 phydev->supported, val & MDIO_SPEED_10G);
-
-	return genphy_read_abilities(phydev);
-}
-
 static int rtl822x_config_aneg(struct phy_device *phydev)
 {
 	int ret = 0;
@@ -974,7 +956,6 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226 2.5Gbps PHY",
 		.match_phy_device = rtl8226_match_phy_device,
 		.probe		= rtl822x_probe,
-		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
@@ -987,7 +968,6 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc840),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
@@ -1000,7 +980,6 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1013,7 +992,6 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1026,7 +1004,6 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1039,7 +1016,6 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc84a),
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.probe		= rtl822x_probe,
-		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
-- 
2.41.0


