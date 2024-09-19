Return-Path: <netdev+bounces-129006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC1397CEA0
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F52D284909
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D9143880;
	Thu, 19 Sep 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oJATPRsr"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA32B9B8
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779705; cv=none; b=oXk1PibSoTGmrTapsa2eit0YlXtex5KVUSxI3L5Cxkmh+uoy7omwqAcUagzTc0z1U5tJy8ABruEhYzsxJLtFyC5VZkED24j8/LBSKgA62ssCx3o1QXdB9YUxck4fc9W5GzsrlXg/ZhQMYrvM52lRbueRK+Op5IsEgce9v8Qxkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779705; c=relaxed/simple;
	bh=Z0TmcmRQqdCXQZTbDarfsv+J8QJO70c973oIg8OKvTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDcLW4Ud604z11HSUKufwyPewOGbVVdZTLu8iPHvasnNCVNaRX58OFS6xc1LGpIJcN6TR1KACZaazo6/0OSVpNSw9Y1RJvZPmuR0/8bnZ5+W0aMOXDt9dGLrldzVfsycKBvNlx0GHc2Jb57ny2K2o4eU7egkZIOj/Egz54w0vFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oJATPRsr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1VZa000585;
	Thu, 19 Sep 2024 16:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779691;
	bh=TVOdrz33n29wIUqur2yFK2PCrNhq20GKd9spX48CWzE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oJATPRsrzaIgex8b2Zy5T4LCDtgyi4IcA6q7a3aiPYLrQ0F4WHE700CtzoHwJpjJn
	 Or0weJlIvey1WKwi38vrEe608hB20Uc8lpN/IuvttP4hSQKenpTpDrZpz3HVw++hOx
	 DgF8aqmes53GVW0XicOlG7MEgqgUzTrqTIc9ySJA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JL1Va0003361
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 16:01:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:30 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC6098001;
	Thu, 19 Sep 2024 16:01:30 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 2/5] net: phy: dp83tg720: Added SGMII Support
Date: Thu, 19 Sep 2024 14:01:16 -0700
Message-ID: <dcb62e7332fae6ca41e55a7698a7011adada6d86.1726263095.git.a-reyes1@ti.com>
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

Adding SGMII Support to driver by checking if SGMII is enabled and
writing to the SGMII registers to ensure PHY is configured correctly.


Signed-off-by: Alvaro (Al-vuh-roe) Reyes <a-reyes1@ti.com>
---
 drivers/net/phy/dp83tg720.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 7e81800cfc5b..a6f90293aa61 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -12,6 +12,9 @@
 
 #define DP83TG720_PHY_ID			0x2000a284
 
+#define MMD1F							0x1f
+#define MMD1							0x1
+
 /* MDIO_MMD_VEND2 registers */
 #define DP83TG720_MII_REG_10			0x10
 #define DP83TG720_STS_MII_INT			BIT(7)
@@ -69,6 +72,13 @@
 
 #define DP83TG720_SQI_MAX			7
 
+/* SGMII CTRL Registers/bits */
+#define DP83TG720_SGMII_CTRL			0x0608
+#define SGMII_CONFIG_VAL				0x027B
+#define DP83TG720_SGMII_AUTO_NEG_EN		BIT(0)
+#define DP83TG720_SGMII_EN				BIT(9)
+
+
 /**
  * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
  * @phydev: Pointer to the phy_device structure.
@@ -306,7 +316,7 @@ static int dp83tg720_config_rgmii_delay(struct phy_device *phydev)
 
 static int dp83tg720_config_init(struct phy_device *phydev)
 {
-	int ret;
+	int value, ret;
 
 	/* Software Restart is not enough to recover from a link failure.
 	 * Using Hardware Reset instead.
@@ -327,6 +337,19 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	value = phy_read_mmd(phydev, MMD1F, DP83TG720_SGMII_CTRL);
+	if (value < 0)
+		return value;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII)
+		value |= DP83TG720_SGMII_EN;
+	else
+		value &= ~DP83TG720_SGMII_EN;
+
+	ret = phy_write_mmd(phydev, MMD1F, DP83TG720_SGMII_CTRL, value);
+	if (ret < 0)
+		return ret;
+
 	/* In case the PHY is bootstrapped in managed mode, we need to
 	 * wake it.
 	 */
-- 
2.17.1


