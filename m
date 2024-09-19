Return-Path: <netdev+bounces-129011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11F97CEA5
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C101F23C26
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278C14EC7E;
	Thu, 19 Sep 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r0V4uwao"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676315099B
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779709; cv=none; b=mlu16d6eUt3FZ3A49fRgJENgO6hAt5J27TnNdpib1Po3q+Lg+XdfuXsPwhWzRx/HlECfwYpkxuSzOwbV1FTJIB3d9vxqaFjmJSNdEesrWuMKki8Gwz4LNcDzL8j8o2fo0U98SS+FsI/TYlOQZYlCREt1+riRNEDl8xaKF0JtEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779709; c=relaxed/simple;
	bh=UjpUEzofDtzfX4jPzVJiEajGAhUBn9CYfcjwzaKDtwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKpYSDCC7mw9cqIe1aArA1Heq9fi9LGxUjxqNltZq46n2WOLvT+V3u49DDM87hIWkfLxdCSfJcrh2/AAItriiQk34IL4CL3k2bp37/JEQUv8+W57rgYwk5fF51LAOY1C1cqtDk8+fd9qRCh90SqnG6jTc8aHcT4XwGwsCugGGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r0V4uwao; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1a9v094501;
	Thu, 19 Sep 2024 16:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779696;
	bh=HdQFHmCwu3LAF5bbEh4FxPiz8BJdBoNyUTkgYd15MUE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r0V4uwaoDvqYfKH57721o5BGua2jp2GbgNvsEcugYHLlr8iZTV1PheHD9RcuDurA8
	 Y7xE9h79tCDEwGOY5dUan6z7mJT8BWDiK5pUQXRVbnr12YMp6uNTSb4NGVbeTygI5t
	 gNjMXl9CguPfKKlhdhCw1hpTlkMm58V7qzKbG0JU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JL1aFj064411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 16:01:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:35 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC9098001;
	Thu, 19 Sep 2024 16:01:35 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 5/5] net: phy: dp83tg720: fixed Linux coding standards issues
Date: Thu, 19 Sep 2024 14:01:19 -0700
Message-ID: <dcf72baf9ff9a82799edd40f06c8d255f5c71b1c.1726263095.git.a-reyes1@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1726263095.git.a-reyes1@ti.com>
References: <cover.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Driver patches was checked against the linux coding standards using scripts/checkpatch.pl.

This patch meets the standards checked by the script.

Signed-off-by: Alvaro (Al-vuh-roe) Reyes <a-reyes1@ti.com>
---
 drivers/net/phy/dp83tg720.c | 71 +++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 4df6713c51e3..1135dcf5efe6 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -10,7 +10,7 @@
 
 #include "open_alliance_helpers.h"
 
-#define DP83TG720_CS_1_1_PHY_ID				0x2000a284
+#define DP83TG720_CS_1_1_PHY_ID			0x2000a284
 #define DP83TG721_CS_1_0_PHY_ID			0x2000a290
 #define MMD1F							0x1f
 #define MMD1							0x1
@@ -349,10 +349,10 @@ static int dp83tg720_reset(struct phy_device *phydev, bool hw_reset)
 
 	if (hw_reset)
 		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
-				DP83TG720_HW_RESET);
+				    DP83TG720_HW_RESET);
 	else
 		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
-				DP83TG720_SW_RESET);
+				    DP83TG720_SW_RESET);
 	if (ret)
 		return ret;
 
@@ -377,16 +377,17 @@ static int dp83tg720_phy_reset(struct phy_device *phydev)
 }
 
 static int DP83TG720_write_seq(struct phy_device *phydev,
-			     const struct DP83TG720_init_reg *init_data, int size)
+			       const struct DP83TG720_init_reg *init_data,
+			       int size)
 {
 	int ret;
 	int i;
 
 	for (i = 0; i < size; i++) {
-			ret = phy_write_mmd(phydev, init_data[i].MMD, init_data[i].reg,
-				init_data[i].val);
-			if (ret)
-					return ret;
+		ret = phy_write_mmd(phydev, init_data[i].MMD, init_data[i].reg,
+				    init_data[i].val);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -635,20 +636,20 @@ static int dp83tg720_chip_init(struct phy_device *phydev)
 	ret = dp83tg720_reset(phydev, true);
 	if (ret)
 		return ret;
-	
+
 	phydev->autoneg = AUTONEG_DISABLE;
-    phydev->speed = SPEED_1000;
+	phydev->speed = SPEED_1000;
 	phydev->duplex = DUPLEX_FULL;
-    linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
 
 	switch (DP83TG720->chip) {
 	case DP83TG720_CS1_1:
 		if (DP83TG720->is_master)
 			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_master_init,
-						ARRAY_SIZE(DP83TG720_cs1_1_master_init));
+						  ARRAY_SIZE(DP83TG720_cs1_1_master_init));
 		else
 			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_slave_init,
-						ARRAY_SIZE(DP83TG720_cs1_1_slave_init));
+						  ARRAY_SIZE(DP83TG720_cs1_1_slave_init));
 
 		ret = dp83tg720_reset(phydev, false);
 
@@ -656,10 +657,10 @@ static int dp83tg720_chip_init(struct phy_device *phydev)
 	case DP83TG721_CS1:
 		if (DP83TG720->is_master)
 			ret = DP83TG720_write_seq(phydev, DP83TG721_cs1_master_init,
-						ARRAY_SIZE(DP83TG721_cs1_master_init));
+						  ARRAY_SIZE(DP83TG721_cs1_master_init));
 		else
 			ret = DP83TG720_write_seq(phydev, DP83TG721_cs1_slave_init,
-						ARRAY_SIZE(DP83TG721_cs1_slave_init));
+						  ARRAY_SIZE(DP83TG721_cs1_slave_init));
 
 		ret = dp83tg720_reset(phydev, false);
 
@@ -736,7 +737,7 @@ static int dp83tg720_probe(struct phy_device *phydev)
 	int ret;
 
 	DP83TG720 = devm_kzalloc(&phydev->mdio.dev, sizeof(*DP83TG720),
-			       GFP_KERNEL);
+				 GFP_KERNEL);
 	if (!DP83TG720)
 		return -ENOMEM;
 
@@ -760,33 +761,33 @@ static int dp83tg720_probe(struct phy_device *phydev)
 	return dp83tg720_config_init(phydev);
 }
 
-#define DP83TG720_PHY_DRIVER(_id, _name)                                \
-{                                                                       \
-    PHY_ID_MATCH_EXACT(_id),                                            \
-    .name                   = (_name),                                  \
-    .probe                  = dp83tg720_probe,                          \
-	.soft_reset				= dp83tg720_phy_reset,						\
-    .flags                  = PHY_POLL_CABLE_TEST,                      \
-    .config_aneg            = dp83tg720_config_aneg,                    \
-    .read_status            = dp83tg720_read_status,                    \
-    .get_features           = genphy_c45_pma_read_ext_abilities,        \
-    .config_init            = dp83tg720_config_init,                    \
-    .get_sqi                = dp83tg720_get_sqi,                        \
-    .get_sqi_max            = dp83tg720_get_sqi_max,                    \
-    .cable_test_start       = dp83tg720_cable_test_start,               \
-    .cable_test_get_status  = dp83tg720_cable_test_get_status,          \
-    .suspend                = genphy_suspend,                           \
-    .resume                 = genphy_resume,                            \
+#define DP83TG720_PHY_DRIVER(_id, _name)				\
+{									\
+	PHY_ID_MATCH_EXACT(_id),					\
+	.name                   = (_name),				\
+	.probe                  = dp83tg720_probe,			\
+	.soft_reset		= dp83tg720_phy_reset,			\
+	.flags                  = PHY_POLL_CABLE_TEST,			\
+	.config_aneg            = dp83tg720_config_aneg,		\
+	.read_status            = dp83tg720_read_status,		\
+	.get_features           = genphy_c45_pma_read_ext_abilities,	\
+	.config_init            = dp83tg720_config_init,		\
+	.get_sqi                = dp83tg720_get_sqi,			\
+	.get_sqi_max            = dp83tg720_get_sqi_max,		\
+	.cable_test_start       = dp83tg720_cable_test_start,		\
+	.cable_test_get_status  = dp83tg720_cable_test_get_status,	\
+	.suspend                = genphy_suspend,			\
+	.resume                 = genphy_resume,			\
 }
 
 static struct phy_driver dp83tg720_driver[] = {
-    DP83TG720_PHY_DRIVER(DP83TG720_CS_1_1_PHY_ID, "TI DP83TG720CS1.1"),
+	DP83TG720_PHY_DRIVER(DP83TG720_CS_1_1_PHY_ID, "TI DP83TG720CS1.1"),
 	DP83TG720_PHY_DRIVER(DP83TG721_CS_1_0_PHY_ID, "TI DP83TG721CS1.0"),
 };
 module_phy_driver(dp83tg720_driver);
 
 static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
-    { PHY_ID_MATCH_EXACT(DP83TG720_CS_1_1_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(DP83TG720_CS_1_1_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(DP83TG721_CS_1_0_PHY_ID) },
 	{ },
 };
-- 
2.17.1


