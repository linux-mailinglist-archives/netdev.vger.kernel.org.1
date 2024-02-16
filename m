Return-Path: <netdev+bounces-72275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB68575BE
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 06:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B251F25DC5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD413ADA;
	Fri, 16 Feb 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q6ooACDT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833B13ADC
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062412; cv=none; b=goew/D3Tjq26t/Iy5p2jfoRbrEtBNN6tyy9Zj6XPNPcQl8nvlmMUeTZv0SaYtfafmtoIckBwgFJv0LyHr/toa1A3yuWmKP8QM3aB1ceVdXXNhlmATHGE2z7Hr9mNeqrDJtchuq0IGwEBJf+/toks8i7Tj1wCt/dOfbdx5qhikYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062412; c=relaxed/simple;
	bh=CIWrwq7S/G4GbLbIyxvPWD4zLkM/mTy+JgH9zBMm0/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXi/vkVKJzmOSz3j6eWjQiIG1El8thnmsXiDWLbb4nI7jyNAe5UetKRSJcMuSwtk3eGC69jke88W13e4y+I8qYxevBT9I1F+UptlUEq7QyKRAIawf51qQ2wYzzEU3vdkk1KKV0Nn3NbS5+tCTjGO9f/F7ntSx4abTxvT+3ZWJB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q6ooACDT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708062410; x=1739598410;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CIWrwq7S/G4GbLbIyxvPWD4zLkM/mTy+JgH9zBMm0/8=;
  b=Q6ooACDT9T6tCsd9X0kDG4ZCZyrpJhKT6exgvDnaQiURfb4sV2XhWCk2
   DiIR2tFXakIPlHchdhQik2Tnq4P9RAJ5HQ/x+vhEdYuqNZPIatTtQXU0j
   nMTuwKn9IiIDylbvgJDuyI6xPQpe3VAksQy0pUeFxHuIjR4IG5kG13vFJ
   ltOVbizfj69NMtqm2vzhtPZguizZ7AZ/Onosqh9FA1WKsZCyFAjBL4a/A
   Iiwg4CzHtqQZOkS4oMmBXe2YUrOZMcyiPvSPBfYApip0xfflLbHfoLX6I
   oZxN3vtmJpNuEoqbUKB8n6SvOR4blbSOiwjzhSypQJ4Z3HQf7aCXelj3l
   Q==;
X-CSE-ConnectionGUID: YylO3keFSu2r7mi4Bl29sQ==
X-CSE-MsgGUID: LspqKTfASzesTVDC4Jffqw==
X-IronPort-AV: E=Sophos;i="6.06,163,1705388400"; 
   d="scan'208";a="183604381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 22:46:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 22:46:27 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 22:46:24 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
	<lxu@maxlinear.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<kuba@kernel.org>
Subject: [PATCH net-next] net: phy: mxl-gpy: fill in possible_interfaces for GPY21x chipset
Date: Fri, 16 Feb 2024 11:14:35 +0530
Message-ID: <20240216054435.22380-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Fill in the possible_interfaces member.
GPY21x phys support the SGMII and 2500base-X interfaces

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/phy/mxl-gpy.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index ea1073adc5a1..b2d36a3a96f1 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -274,6 +274,14 @@ static int gpy_config_init(struct phy_device *phydev)
 	return ret < 0 ? ret : 0;
 }
 
+static int gpy21x_config_init(struct phy_device *phydev)
+{
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces);
+
+	return gpy_config_init(phydev);
+}
+
 static int gpy_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -867,7 +875,7 @@ static struct phy_driver gpy_drivers[] = {
 		.phy_id_mask	= PHY_ID_GPY21xB_MASK,
 		.name		= "Maxlinear Ethernet GPY211B",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -884,7 +892,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY211C),
 		.name		= "Maxlinear Ethernet GPY211C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -902,7 +910,7 @@ static struct phy_driver gpy_drivers[] = {
 		.phy_id_mask	= PHY_ID_GPY21xB_MASK,
 		.name		= "Maxlinear Ethernet GPY212B",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -919,7 +927,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY212C),
 		.name		= "Maxlinear Ethernet GPY212C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -937,7 +945,7 @@ static struct phy_driver gpy_drivers[] = {
 		.phy_id_mask	= PHY_ID_GPYx15B_MASK,
 		.name		= "Maxlinear Ethernet GPY215B",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
@@ -954,7 +962,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_GPY215C),
 		.name		= "Maxlinear Ethernet GPY215C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy_config_init,
+		.config_init	= gpy21x_config_init,
 		.probe		= gpy_probe,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
-- 
2.34.1


