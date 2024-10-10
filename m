Return-Path: <netdev+bounces-134106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF6998056
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C4D1C20B76
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DD1CBE8E;
	Thu, 10 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qXMvAsNr"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD6B1CB53C;
	Thu, 10 Oct 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548592; cv=none; b=kfNDpB+8xfF65Kakm05rEJGaoNFY31zfrHRcIAXQsc3lEuR3bwKtxKmDOnDxFa7liH1r2tWm8O3K3L9tRft/OBIs4p+hfiAkbE5QDNZKjUf8emMP/wwyc3lamqUjWl1dKguvkbdKsxPl7lK/kRs0fT7AujXc4pH/zxBcZm9wmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548592; c=relaxed/simple;
	bh=xjWITKMdJwma0xuP1toKsHFNBiHhBDAzMfxcs54zxk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpiD8G5/WryW2ueE8fVogwr6OWje4Op+kDmKjnLIGp+Q/G/aGxaoEBmDPaOPM543eZm92liH4k4T3aEirnf6EqicBYWUZiwvKaETK9bRfHf+Ll8k4kG5hsGpYuJKU8Z5vV3+RCAi7L25kKxoMeLyBBmGOJHeHV+TT65LpsandCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qXMvAsNr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548590; x=1760084590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjWITKMdJwma0xuP1toKsHFNBiHhBDAzMfxcs54zxk0=;
  b=qXMvAsNrFLLOhul/IN52HjG5MW7jFWur0/4zVj1GwaJmfvJ+U3Pvx7yZ
   DrSU4g7sNuWWYsX53c8slS9a017X4yv4JFIIFRHQNewysCRiohu/eR4wU
   C0uVyUP/VY/HX9mudBb6zuh3rpo7haJqifuWiOumCdUMjObz8tNqEUD+2
   OOwEpss+e96C09LVKfd32IDTc+zR5JY3iJZwjbFo0i9x+ks6NCB4ZPhS1
   AzGH2WEoKSQu16nUqEUCYdgRcNX4IF9kbF+2IsRsca1Pjm4gtTJhgKoa0
   nIyhij9MK0Mg5lXk9LQSK59wkGqVugKJRGenPVYeDCRftf1XAJDsNTtl1
   Q==;
X-CSE-ConnectionGUID: D165IrQCQQaSZj0APvNNjA==
X-CSE-MsgGUID: bE6hHEomSHSHLBdYZAaTMQ==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163256"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:23:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:39 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:35 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 3/7] net: phy: microchip_t1s: add support for Microchip's LAN865X Rev.B1
Date: Thu, 10 Oct 2024 13:52:01 +0530
Message-ID: <20241010082205.221493-4-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
References: <20241010082205.221493-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for LAN8650/1 Rev.B1. As per the latest configuration note
AN1760 released (Revision F (DS60001760G - June 2024)) for Rev.B0 is also
applicable for Rev.B1. Refer hardware revisions list in the latest AN1760
Revision F (DS60001760G - June 2024).
https://www.microchip.com/en-us/application-notes/an1760

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  4 +--
 drivers/net/phy/microchip_t1s.c | 62 ++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 01b235b3bb7e..f18defab70cf 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -292,8 +292,8 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0 Internal
-	  PHYs.
+	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
+	  Internal PHYs.
 
 config MICROCHIP_PHY
 	tristate "Microchip PHYs"
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 12f6678e3188..b21f5acb4468 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -4,7 +4,7 @@
  *
  * Support: Microchip Phys:
  *  lan8670/1/2 Rev.B1
- *  lan8650/1 Rev.B0 Internal PHYs
+ *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
 #include <linux/kernel.h>
@@ -12,7 +12,8 @@
 #include <linux/phy.h>
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
-#define PHY_ID_LAN865X_REVB0 0x0007C1B3
+/* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
+#define PHY_ID_LAN865X_REVB 0x0007C1B3
 
 #define LAN867X_REG_STS2 0x0019
 
@@ -59,12 +60,12 @@ static const u16 lan867x_revb1_fixup_masks[12] = {
 	0x0600, 0x7F00, 0x2000, 0xFFFF,
 };
 
-/* LAN865x Rev.B0 configuration parameters from AN1760
+/* LAN865x Rev.B0/B1 configuration parameters from AN1760
  * As per the Configuration Application Note AN1760 published in the below link,
  * https://www.microchip.com/en-us/application-notes/an1760
  * Revision F (DS60001760G - June 2024)
  */
-static const u32 lan865x_revb0_fixup_registers[17] = {
+static const u32 lan865x_revb_fixup_registers[17] = {
 	0x00D0, 0x00E0, 0x00E9, 0x00F5,
 	0x00F4, 0x00F8, 0x00F9, 0x0081,
 	0x0091, 0x0043, 0x0044, 0x0045,
@@ -72,7 +73,7 @@ static const u32 lan865x_revb0_fixup_registers[17] = {
 	0x0050,
 };
 
-static const u16 lan865x_revb0_fixup_values[17] = {
+static const u16 lan865x_revb_fixup_values[17] = {
 	0x3F31, 0xC000, 0x9E50, 0x1CF8,
 	0xC020, 0xB900, 0x4E53, 0x0080,
 	0x9660, 0x00FF, 0xFFFF, 0x0000,
@@ -80,23 +81,23 @@ static const u16 lan865x_revb0_fixup_values[17] = {
 	0x0002,
 };
 
-static const u16 lan865x_revb0_fixup_cfg_regs[2] = {
+static const u16 lan865x_revb_fixup_cfg_regs[2] = {
 	0x0084, 0x008A,
 };
 
-static const u32 lan865x_revb0_sqi_fixup_regs[12] = {
+static const u32 lan865x_revb_sqi_fixup_regs[12] = {
 	0x00B0, 0x00B1, 0x00B2, 0x00B3,
 	0x00B4, 0x00B5, 0x00B6, 0x00B7,
 	0x00B8, 0x00B9, 0x00BA, 0x00BB,
 };
 
-static const u16 lan865x_revb0_sqi_fixup_values[12] = {
+static const u16 lan865x_revb_sqi_fixup_values[12] = {
 	0x0103, 0x0910, 0x1D26, 0x002A,
 	0x0103, 0x070D, 0x1720, 0x0027,
 	0x0509, 0x0E13, 0x1C25, 0x002B,
 };
 
-static const u16 lan865x_revb0_sqi_fixup_cfg_regs[3] = {
+static const u16 lan865x_revb_sqi_fixup_cfg_regs[3] = {
 	0x00AD, 0x00AE, 0x00AF,
 };
 
@@ -108,7 +109,7 @@ static const u16 lan865x_revb0_sqi_fixup_cfg_regs[3] = {
  *
  * 0x4 refers to memory map selector 4, which maps to MDIO_MMD_VEND2
  */
-static int lan865x_revb0_indirect_read(struct phy_device *phydev, u16 addr)
+static int lan865x_revb_indirect_read(struct phy_device *phydev, u16 addr)
 {
 	int ret;
 
@@ -134,7 +135,7 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 	int ret;
 
 	for (int i = 0; i < ARRAY_SIZE(fixup_regs); i++) {
-		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
+		ret = lan865x_revb_indirect_read(phydev, fixup_regs[i]);
 		if (ret < 0)
 			return ret;
 
@@ -184,11 +185,11 @@ static int lan865x_write_cfg_params(struct phy_device *phydev,
 
 static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
 {
-	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
-	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb_fixup_cfg_regs)];
+	u16 cfg_params[ARRAY_SIZE(lan865x_revb_fixup_cfg_regs)];
 	int ret;
 
-	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb_fixup_cfg_regs,
 				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
@@ -198,17 +199,17 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
 			 0x03;
 	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
 
-	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+	return lan865x_write_cfg_params(phydev, lan865x_revb_fixup_cfg_regs,
 					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
 static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
 {
-	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
-	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb_sqi_fixup_cfg_regs)];
+	u16 cfg_params[ARRAY_SIZE(lan865x_revb_sqi_fixup_cfg_regs)];
 	int ret;
 
-	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_sqi_fixup_cfg_regs,
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb_sqi_fixup_cfg_regs,
 				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
@@ -220,12 +221,11 @@ static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
 	cfg_results[2] = FIELD_PREP(GENMASK(13, 8), 17 + offsets[0]) |
 			 (22 + offsets[0]);
 
-	return lan865x_write_cfg_params(phydev,
-					lan865x_revb0_sqi_fixup_cfg_regs,
+	return lan865x_write_cfg_params(phydev, lan865x_revb_sqi_fixup_cfg_regs,
 					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
-static int lan865x_revb0_config_init(struct phy_device *phydev)
+static int lan865x_revb_config_init(struct phy_device *phydev)
 {
 	s8 offsets[2];
 	int ret;
@@ -237,10 +237,10 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb_fixup_registers); i++) {
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_fixup_registers[i],
-				    lan865x_revb0_fixup_values[i]);
+				    lan865x_revb_fixup_registers[i],
+				    lan865x_revb_fixup_values[i]);
 		if (ret)
 			return ret;
 
@@ -255,10 +255,10 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_sqi_fixup_regs); i++) {
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb_sqi_fixup_regs); i++) {
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_sqi_fixup_regs[i],
-				    lan865x_revb0_sqi_fixup_values[i]);
+				    lan865x_revb_sqi_fixup_regs[i],
+				    lan865x_revb_sqi_fixup_values[i]);
 		if (ret)
 			return ret;
 	}
@@ -361,10 +361,10 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
-		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0),
-		.name               = "LAN865X Rev.B0 Internal Phy",
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
+		.name               = "LAN865X Rev.B0/B1 Internal Phy",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
-		.config_init        = lan865x_revb0_config_init,
+		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
 		.read_mmd           = lan865x_phy_read_mmd,
 		.write_mmd          = lan865x_phy_write_mmd,
@@ -378,7 +378,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
-	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
 
-- 
2.34.1


