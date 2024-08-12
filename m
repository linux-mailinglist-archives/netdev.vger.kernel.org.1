Return-Path: <netdev+bounces-117722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EAE94EEAD
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85453B22659
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D717D35C;
	Mon, 12 Aug 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2bXY5xZT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152D17C7C3;
	Mon, 12 Aug 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470560; cv=none; b=izsWckkRmUuC2ROtdVVRHx74HFP8A3egptknUqJtOAp44vWk5+J0kDFDXHdu2+p/MaQwzkpBC/kW1LBfXgqvj/4JggtxL4C9K1+fdVC5Nqk7L/4Da4hQVUjzPlh1dEoDAvkChCtA8pPn+M6SlHBqJWRpbbeYljwDtegBnoyGz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470560; c=relaxed/simple;
	bh=/0YnrPpmUH0LJwT6fzjnwcXMpBw5sOORlHDR4sXN6lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8Ewnklov9y7PAQsxn+Wc25tQbNg2fPPAj4zpMjulYwJgAHItecmK7DRAgaWTFH5I7XLRkkM+SAWDJUBJEJEakzyhMjYJxwNNh77yHkNcqi6IJ7DL+bb+ojRomaOjMRWKidx1hXPNjxZlYsv4fHiJasQ2Zjsp3ZcLPdE1kl0LRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2bXY5xZT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470559; x=1755006559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/0YnrPpmUH0LJwT6fzjnwcXMpBw5sOORlHDR4sXN6lc=;
  b=2bXY5xZTih4zJYgG9wwi0rHQv1ct1am0Xk1BOr1INjfk4CKZwAj03Igp
   vONkfvAb2p+6qOcNMPgAMV6VhJ6AjU3KZBmvlV1pjpXQiJ+EzWR7y6Z2n
   G/SXsBqNAgRNa1030bT/6r0LM0cRJI9ZRdbPB+cHkCFtLBZf/2ze/NaE2
   M8UD0aD7eBZMlrC2LgIaos4bDKhXSHrQtEAHKnYcCGo+cxgC87ErZIuh3
   BF7+CWyw5fyt+Yt+Z4HfhaYjVJolQQ8QAZisFSodaaW7gQYKGrUBans8f
   rzCywoaj14WFtMFfpU2rMqQRuqM2BZBH/HALEhM/r4dJLzN+/YL3SbYGb
   Q==;
X-CSE-ConnectionGUID: yI+1XPNJS2+OYumvWzLkww==
X-CSE-MsgGUID: kSgf8UN+Rriw6bpyTas3KA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="31049504"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:49:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:48:53 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:48:49 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 2/7] net: phy: microchip_t1s: update new initial settings for LAN865X Rev.B0
Date: Mon, 12 Aug 2024 19:18:11 +0530
Message-ID: <20240812134816.380688-3-Parthiban.Veerasooran@microchip.com>
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

This patch configures the new/improved initial settings from the latest
configuration application note released for LAN8650/1 Rev.B0
Revision F (DS60001760G - June 2024).

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 109 +++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 373a8b8da5ee..51ff97ffad0e 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -59,29 +59,45 @@ static const u16 lan867x_revb1_fixup_masks[12] = {
 	0x0600, 0x7F00, 0x2000, 0xFFFF,
 };
 
-/* LAN865x Rev.B0 configuration parameters from AN1760 */
-static const u32 lan865x_revb0_fixup_registers[28] = {
-	0x0091, 0x0081, 0x0043, 0x0044,
-	0x0045, 0x0053, 0x0054, 0x0055,
-	0x0040, 0x0050, 0x00D0, 0x00E9,
-	0x00F5, 0x00F4, 0x00F8, 0x00F9,
+/* LAN865x Rev.B0 configuration parameters from AN1760
+ * As per the Configuration Application Note AN1760 published in the below link,
+ * https://www.microchip.com/en-us/application-notes/an1760
+ * Revision F (DS60001760G - June 2024)
+ */
+static const u32 lan865x_revb0_fixup_registers[17] = {
+	0x00D0, 0x00E0, 0x00E9, 0x00F5,
+	0x00F4, 0x00F8, 0x00F9, 0x0081,
+	0x0091, 0x0043, 0x0044, 0x0045,
+	0x0053, 0x0054, 0x0055, 0x0040,
+	0x0050,
+};
+
+static const u16 lan865x_revb0_fixup_values[17] = {
+	0x3F31, 0xC000, 0x9E50, 0x1CF8,
+	0xC020, 0xB900, 0x4E53, 0x0080,
+	0x9660, 0x00FF, 0xFFFF, 0x0000,
+	0x00FF, 0xFFFF, 0x0000, 0x0002,
+	0x0002,
+};
+
+static const u16 lan865x_revb0_fixup_cfg_regs[2] = {
+	0x0084, 0x008A,
+};
+
+static const u32 lan865x_revb0_sqi_fixup_regs[12] = {
 	0x00B0, 0x00B1, 0x00B2, 0x00B3,
 	0x00B4, 0x00B5, 0x00B6, 0x00B7,
 	0x00B8, 0x00B9, 0x00BA, 0x00BB,
 };
 
-static const u16 lan865x_revb0_fixup_values[28] = {
-	0x9660, 0x00C0, 0x00FF, 0xFFFF,
-	0x0000, 0x00FF, 0xFFFF, 0x0000,
-	0x0002, 0x0002, 0x5F21, 0x9E50,
-	0x1CF8, 0xC020, 0x9B00, 0x4E53,
+static const u16 lan865x_revb0_sqi_fixup_values[12] = {
 	0x0103, 0x0910, 0x1D26, 0x002A,
 	0x0103, 0x070D, 0x1720, 0x0027,
 	0x0509, 0x0E13, 0x1C25, 0x002B,
 };
 
-static const u16 lan865x_revb0_fixup_cfg_regs[5] = {
-	0x0084, 0x008A, 0x00AD, 0x00AE, 0x00AF
+static const u16 lan865x_revb0_sqi_fixup_cfg_regs[3] = {
+	0x00AD, 0x00AE, 0x00AF,
 };
 
 /* Pulled from AN1760 describing 'indirect read'
@@ -121,6 +137,8 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
 		if (ret < 0)
 			return ret;
+
+		ret &= 0x1F;
 		if (ret & BIT(4))
 			offsets[i] = ret | 0xE0;
 		else
@@ -174,25 +192,38 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
 	if (ret)
 		return ret;
 
-	cfg_results[0] = (cfg_params[0] & 0x000F) |
-			  FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
-			  FIELD_PREP(GENMASK(15, 4), 14 + offsets[0]);
-	cfg_results[1] = (cfg_params[1] & 0x03FF) |
-			  FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
-	cfg_results[2] = (cfg_params[2] & 0xC0C0) |
-			  FIELD_PREP(GENMASK(15, 8), 5 + offsets[0]) |
-			  (9 + offsets[0]);
-	cfg_results[3] = (cfg_params[3] & 0xC0C0) |
-			  FIELD_PREP(GENMASK(15, 8), 9 + offsets[0]) |
-			  (14 + offsets[0]);
-	cfg_results[4] = (cfg_params[4] & 0xC0C0) |
-			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
-			  (22 + offsets[0]);
+	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
+			 FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
+			 0x03;
+	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);
 
 	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
 					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
+static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
+{
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
+	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
+	int ret;
+
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_sqi_fixup_cfg_regs,
+				      cfg_params, ARRAY_SIZE(cfg_params));
+	if (ret)
+		return ret;
+
+	cfg_results[0] = FIELD_PREP(GENMASK(15, 8), (5 + offsets[0]) & 0x3F) |
+			 ((9 + offsets[0]) & 0x3F);
+	cfg_results[1] = FIELD_PREP(GENMASK(15, 8), (9 + offsets[0]) & 0x3F) |
+			 ((14 + offsets[0]) & 0x3F);
+	cfg_results[2] = FIELD_PREP(GENMASK(15, 8), (17 + offsets[0]) & 0x3F) |
+			 ((22 + offsets[0]) & 0x3F);
+
+	return lan865x_write_cfg_params(phydev,
+					lan865x_revb0_sqi_fixup_cfg_regs,
+					cfg_results, ARRAY_SIZE(cfg_results));
+}
+
 static int lan865x_revb0_config_init(struct phy_device *phydev)
 {
 	s8 offsets[2];
@@ -211,11 +242,27 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 				    lan865x_revb0_fixup_values[i]);
 		if (ret)
 			return ret;
+
+		if (i == 2) {
+			ret = lan865x_setup_cfgparam(phydev, offsets);
+			if (ret)
+				return ret;
+		}
 	}
-	/* Function to calculate and write the configuration parameters in the
-	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
-	 */
-	return lan865x_setup_cfgparam(phydev, offsets);
+
+	ret = lan865x_setup_sqi_cfgparam(phydev, offsets);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_sqi_fixup_regs); i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb0_sqi_fixup_regs[i],
+				    lan865x_revb0_sqi_fixup_values[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int lan867x_revb1_config_init(struct phy_device *phydev)
-- 
2.34.1


