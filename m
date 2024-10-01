Return-Path: <netdev+bounces-130857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88CE98BC53
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086381C22960
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C21C3F3C;
	Tue,  1 Oct 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ib9nmE1X"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637D1C2DB2;
	Tue,  1 Oct 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786307; cv=none; b=i3Ft7/nD/efCT7v7OWBG4g2W+vg2p4IOfPycCV7mUC/Bw6k23By5RCT5i3Tre0pwRoJ/XMSrtW4u0ONydJYobgkDSwQg0j7RpqI694sddqYxk2PsmKYf/dGlgi9g5XurCZ9MiGvCd/Gm787j8wmeX0RuzpL25+zxmPxmzoeMyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786307; c=relaxed/simple;
	bh=QJnQHOl83foUP3f80cMzXj2IXjQTCRVqeawZx1hWHQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BStw3E4e7lf17d7gKOK8RN9GdLuImDVsJrZ8cwr5HoTNANyjfnojQ0mL98EttIv6TNKG8zYYtaLrIh9zu8tBx6AlXi+u/2XBYoCyAfVfedh9WLKDQgrC/sevGlJaGHho61x2ZYAr7q7Gr1cNz1hlU2Hal4vH7oHx2a17i1R85rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ib9nmE1X; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727786305; x=1759322305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJnQHOl83foUP3f80cMzXj2IXjQTCRVqeawZx1hWHQw=;
  b=Ib9nmE1Xs8RZvEpkU39NGOZjehIOOUm5vkdH09x43uPz+Yb+f9+m3gOq
   /cclOvOxN2RZZgSDySACifJ35DJ1KalK7nwsLSbODtTXD7/Y0wpDkxwHD
   xno0UuGTTPyrQ0IROt/dZzYoW6OTw0wjOeN3nvHlJkliqD+FYuRCmzwne
   w8lQfcphKNXuasy+S1Ap3uwvZCRNXaECvOITdaxTgDzLEDIzX1xRBJCxp
   zfPgQJdUFTPsS01cad9FzKpfFoHYrUaUTj4ZlJnIlaIJdyJtpfEH8cP7L
   +kHJr4I8zfx3cMpkxDIt+NypOIjYQsSxaWlefYnwZ1btiH35KasqRKkYG
   g==;
X-CSE-ConnectionGUID: F9WgwppkTm6IvTcz3axUkw==
X-CSE-MsgGUID: ZWrm+slTTQqMptkTz8vf/A==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33054353"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 05:38:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 05:38:12 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 05:38:08 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v3 6/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C2
Date: Tue, 1 Oct 2024 18:07:33 +0530
Message-ID: <20241001123734.1667581-7-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8670/1/2 Rev.C2 as per the latest configuration note
AN1699 released (Revision E (DS60001699F - June 2024)) for Rev.C1 is also
applicable for Rev.C2. Refer hardware revisions list in the latest AN1699
Revision E (DS60001699F - June 2024).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  4 ++--
 drivers/net/phy/microchip_t1s.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 04f605606a8a..ee3ea0b56d48 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -292,8 +292,8 @@ config MICREL_PHY
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
index 003aecaf35b2..8a24913702ac 100644
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
 	 * Refer the below links for the comparison.
 	 * https://www.microchip.com/en-us/application-notes/an1760
 	 * Revision F (DS60001760G - June 2024)
@@ -427,7 +428,17 @@ static struct phy_driver microchip_t1s_driver[] = {
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
@@ -452,6 +463,7 @@ module_phy_driver(microchip_t1s_driver);
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


