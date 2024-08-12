Return-Path: <netdev+bounces-117724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A1E94EEB2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19E1B22E95
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC1181B88;
	Mon, 12 Aug 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fWBO1gSc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5517D340;
	Mon, 12 Aug 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470562; cv=none; b=AvTYbDT6fCUOBHeYHKB3G78wfiddjllLP38UYsP+A1WUvqV+RmAsIARQDm0VOnq2Rxpb9JJ0YyM+qkAnUltRZMOVq/B/HnuTKBXH4pA7Qsqc4K3Odc6+DkWqdHJNwJpyufnR/Ieg8bGBLzyY/+piSg/XfWwO/mk+PSql0jjn9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470562; c=relaxed/simple;
	bh=F5WoBmjv/zik1MXMlE2eFHaufB7YwWNOuyEevw2AAXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+IxMnRvth1xfIrfFfc/RdysUbiqenauqwHCQuj9grDKj2A1G+rk4AagU9zDBXw1BQPNwlyv0OGVWayqa8Gged40nmc4h6kmHZdia8+a8nTSBrPNdKA+eKevBIJV8JV9KGKmtol1FRIf0cQr97vyK873RemSe/kVkPAUn/9/Gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fWBO1gSc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470560; x=1755006560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F5WoBmjv/zik1MXMlE2eFHaufB7YwWNOuyEevw2AAXs=;
  b=fWBO1gSc93IkGA6efJPQfkMF1Biv71T2gkM4WvJKNwwFC9vdvU2cEaWJ
   6M4TefpfmVSzJiYWfJ6qhdwpv7S9JBzevbFNtQSur0Z4QqUPT4CS19VYG
   pHdltkluH4VaR9dHUr6pSF6dNbqoVAmmExNMDoodtjY2+lS+dt/uz7QkE
   kVYUlMYIWh0jIlyDrdnYmleBE5Z1dz2x5VTuvkrnbSFozNb+FGJojCN3o
   5FWJnW/D9hsB8pAHIa9B9X2ukmpC0hZwTAbqutDrTIMOw5VPHczIWONDB
   VwwEuVsMspy2zAwhACMyQpx2cRhFxU0SIgbBY2igjA4TUR6gWQ36QW9Vf
   Q==;
X-CSE-ConnectionGUID: yI+1XPNJS2+OYumvWzLkww==
X-CSE-MsgGUID: Xq2ba6JoSMyo37qJDjg+Cw==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="31049519"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:49:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:49:12 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:49:08 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 6/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
Date: Mon, 12 Aug 2024 19:18:15 +0530
Message-ID: <20240812134816.380688-7-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds support for LAN8670/1/2 Rev.C2 as per the latest
configuration note AN1699 released (Revision E (DS60001699F - June 2024))
for Rev.C1 is also applicable for Rev.C2. Refer hardware revisions list
in the latest AN1699 Revision E (DS60001699F - June 2024).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  4 ++--
 drivers/net/phy/microchip_t1s.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 63b45544c191..cf6ddb7072d7 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -282,8 +282,8 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
-	  Internal PHYs.
+	  Currently supports the LAN8670/1/2 Rev.B1/C1/C2 and
+	  LAN8650/1 Rev.B0/B1 Internal PHYs.
 
 config MICROCHIP_PHY
 	tristate "Microchip PHYs"
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 62f5ce548c6a..bd0c768df0af 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -3,7 +3,7 @@
  * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
- *  lan8670/1/2 Rev.B1/C1
+ *  lan8670/1/2 Rev.B1/C1/C2
  *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
@@ -13,6 +13,7 @@
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
 #define PHY_ID_LAN867X_REVC1 0x0007C164
+#define PHY_ID_LAN867X_REVC2 0x0007C165
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
@@ -291,7 +292,7 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
 	return 0;
 }
 
-static int lan867x_revc1_config_init(struct phy_device *phydev)
+static int lan867x_revc_config_init(struct phy_device *phydev)
 {
 	s8 offsets[2];
 	int ret;
@@ -304,10 +305,10 @@ static int lan867x_revc1_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	/* LAN867x Rev.C1 configuration settings are equal to the first 9
+	/* LAN867x Rev.C1/C2 configuration settings are equal to the first 9
 	 * configuration settings and all the sqi fixup settings from LAN865x
 	 * Rev.B0/B1. So the same fixup registers and values from LAN865x
-	 * Rev.B0/B1 are used for LAN867x Rev.C1 to avoid duplication.
+	 * Rev.B0/B1 are used for LAN867x Rev.C1/C2 to avoid duplication.
 	 * Refer the below links for the comparision.
 	 * https://www.microchip.com/en-us/application-notes/an1760
 	 * Revision F (DS60001760G - June 2024)
@@ -399,7 +400,17 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
 		.name               = "LAN867X Rev.C1",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
-		.config_init        = lan867x_revc1_config_init,
+		.config_init        = lan867x_revc_config_init,
+		.read_status        = lan86xx_read_status,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2),
+		.name               = "LAN867X Rev.C2",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
@@ -422,6 +433,7 @@ module_phy_driver(microchip_t1s_driver);
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


