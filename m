Return-Path: <netdev+bounces-59280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5381A345
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0841A1C245AB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC444175B;
	Wed, 20 Dec 2023 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjsAg00g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E0B41758
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA59C433C9;
	Wed, 20 Dec 2023 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087745;
	bh=4wi0Pzg5Dp9u/oU82+P5NtJx5wTvAIqnpsYLXhis7M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjsAg00g+cjGNh5I3zGGL61PvyWv2wu30ZftFW8y7vCJ3ghbJZB7D/c7Pwz4d0d6I
	 VXHpgTG9BrtJRgnImGPMKRN33gAG6J9HyQs30uIc3oFlqQAzC0fO5NV5BjzkR7P4dJ
	 KESVjJxDgFmZWvfwpTwemafAO3WU46pALWXJDA6lw55kR1C3IRwYoC6M29baF4ymvH
	 Fk3/iEA8JJHd7FjegnMhJY5GrYyCcy3pAcwamlPX77Kb9ni5rt0ud3kUXfGo10T7Gd
	 gEdDz5YN2Y8EFWiByhs+XH3fJlKkx2tz2TxHjXbl5q9Dm8CiSHvrj6t8Dh2jKuKlaI
	 ZnMq1TBUYDECQ==
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
Subject: [PATCH net-next 07/15] net: phy: realtek: set is_c45 and fill in c45 IDs in PHY probe for rtl822x PHYs
Date: Wed, 20 Dec 2023 16:55:10 +0100
Message-ID: <20231220155518.15692-8-kabel@kernel.org>
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

If the rtl822x was probed via clause 22 addressing, we need to set
phydev->is_c45 and fill in phydev->c45_ids so that genphy_c45_*
functions will work properly.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/realtek.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 52a7022d6a64..c621ce9378c5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -636,6 +636,18 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int dev, u16 reg,
 	return rtl821x_write_page(phydev, 0) ?: ret;
 }
 
+static int rtl822x_probe(struct phy_device *phydev)
+{
+	/* if the PHY was probed via c22, set is_c45 and fill in c45 IDs */
+	if (!phydev->is_c45) {
+		phydev->is_c45 = true;
+
+		return phy_get_c45_ids(phydev);
+	}
+
+	return 0;
+}
+
 static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
@@ -961,6 +973,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.name		= "RTL8226 2.5Gbps PHY",
 		.match_phy_device = rtl8226_match_phy_device,
+		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
@@ -973,6 +986,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc840),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.read_status	= rtl822x_read_status,
@@ -985,6 +999,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -997,6 +1012,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1009,6 +1025,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
@@ -1021,6 +1038,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc84a),
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-- 
2.41.0


