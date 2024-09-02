Return-Path: <netdev+bounces-124221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F5968A0D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CF41C2279E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A719F10C;
	Mon,  2 Sep 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d5e7LwE1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF61A263B;
	Mon,  2 Sep 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287740; cv=none; b=CCwMJtH99DzibGd2kVlYBNySGhTcEEy84dE4lma9BnpIpz6/LzPULS2Cr23jFHJUFmjF0TldKoyO+IDehbS/C+t1jjnzFE7DQ9vEhLXs4clOZer5F9JxaI9uBRbMLHFr4YgvqFYtw9ZQiIlylI8xlGI169fTBAV6ex3SRNkgspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287740; c=relaxed/simple;
	bh=5px0TPG7pxSjjFn4eWgZQ1LdggjEDeH1x9iwLLDoH/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAIV3cjwDq1UUVSmf+RxG2X7Q9nzNKMllBwKc35N+A7DjcY6XiJBtjAJZI9soPOLwHWMRiszmVldv91PkF010/lNShA6e8H8xRs6LXyTDWpqPf9dtTOpRnhv33XNksqszqiIBwsC2xjOsHz6qDYe7bfZ58UyFum+Yz6L6hnckEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d5e7LwE1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287738; x=1756823738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5px0TPG7pxSjjFn4eWgZQ1LdggjEDeH1x9iwLLDoH/k=;
  b=d5e7LwE1rnau7LJf5L13Oau0yRsW5uTUX+dN+fljyjNmXdQ3XrQWyXJb
   YTehwAweG3sv/j1hRld/Y9hKhV/+zWAx/oEYfpSKdrpJNWtL+ItJQWMKs
   obvRkpRkcZ9Uq7NdmfFPWjqLRMHLzzYPoJ0X2TkLUvMGmotSKS4z3MZOW
   ybD9iIWR8wAePodFJciv613lctjgJvFgbl4/D6uTk1h+7mh79oDOaI3un
   gXpSsUd3Pgj67zRVRJqoY51oxJsLbyxQUCqCxHQVfs2+opoAg+WM5y3gj
   BKmEODnQWVDlHkZO6AsmPpY6BnEu2fLNKE9jJy7RQstPGaduwqCrzilzB
   Q==;
X-CSE-ConnectionGUID: ocGO3RCOTkuOSmOfjK4K+g==
X-CSE-MsgGUID: aEJ+lSxsTVOKAojtXDkg2g==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34270502"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:35:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:15 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:11 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 2/7] net: phy: microchip_t1s: update new initial settings for LAN865X Rev.B0
Date: Mon, 2 Sep 2024 20:04:53 +0530
Message-ID: <20240902143458.601578-3-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch configures the new/improved initial settings from the latest
configuration application note AN1760 released for LAN8650/1 Rev.B0
Revision F (DS60001760G - June 2024).
https://www.microchip.com/en-us/application-notes/an1760

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 119 ++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 0110f3357489..fb651cfa3ee0 100644
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
@@ -163,59 +181,88 @@ static int lan865x_write_cfg_params(struct phy_device *phydev,
 	return 0;
 }
 
-static int lan865x_setup_cfgparam(struct phy_device *phydev)
+static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
 {
 	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
 	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
-	s8 offsets[2];
 	int ret;
 
-	ret = lan865x_generate_cfg_offsets(phydev, offsets);
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
 
-	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), (9 + offsets[0]) & 0x3F) |
+			 FIELD_PREP(GENMASK(15, 4), (14 + offsets[0]) & 0x3F) |
+			 0x03;
+	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), (40 + offsets[1]) & 0x3F);
+
+	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+					cfg_results, ARRAY_SIZE(cfg_results));
+}
+
+static int lan865x_setup_sqi_cfgparam(struct phy_device *phydev, s8 offsets[])
+{
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
+	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_sqi_fixup_cfg_regs)];
+	int ret;
+
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_sqi_fixup_cfg_regs,
 				      cfg_params, ARRAY_SIZE(cfg_params));
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
+	cfg_results[0] = FIELD_PREP(GENMASK(15, 8), (5 + offsets[0]) & 0x3F) |
+			 ((9 + offsets[0]) & 0x3F);
+	cfg_results[1] = FIELD_PREP(GENMASK(15, 8), (9 + offsets[0]) & 0x3F) |
+			 ((14 + offsets[0]) & 0x3F);
+	cfg_results[2] = FIELD_PREP(GENMASK(15, 8), (17 + offsets[0]) & 0x3F) |
+			 ((22 + offsets[0]) & 0x3F);
 
-	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+	return lan865x_write_cfg_params(phydev,
+					lan865x_revb0_sqi_fixup_cfg_regs,
 					cfg_results, ARRAY_SIZE(cfg_results));
 }
 
 static int lan865x_revb0_config_init(struct phy_device *phydev)
 {
+	s8 offsets[2];
 	int ret;
 
 	/* Reference to AN1760
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8650-1-Configuration-60001760.pdf
 	 */
+	ret = lan865x_generate_cfg_offsets(phydev, offsets);
+	if (ret)
+		return ret;
+
 	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_registers); i++) {
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
 				    lan865x_revb0_fixup_registers[i],
 				    lan865x_revb0_fixup_values[i]);
 		if (ret)
 			return ret;
+
+		if (i == 1) {
+			ret = lan865x_setup_cfgparam(phydev, offsets);
+			if (ret)
+				return ret;
+		}
 	}
-	/* Function to calculate and write the configuration parameters in the
-	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
-	 */
-	return lan865x_setup_cfgparam(phydev);
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


