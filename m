Return-Path: <netdev+bounces-134105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984EE998054
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3356E282C1F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402C1CB50C;
	Thu, 10 Oct 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PFoz/cVm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4E1C3F1F;
	Thu, 10 Oct 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548589; cv=none; b=s1mo0DjF/HN3nF2NzXiPqI5oxDeFI7FsDQu/TaCezTiSB+HgKdpmL5fXDDxM3E1Dx9jBWHetXfAWOWoeK0wtMmalI15RQImwiUtfpmjkhGLm/jO4/VbEkdCBXvCz/Sy48ntBaq/F3jKX134Bi1kQfgoFJn+Hg4e1WOJUr46j6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548589; c=relaxed/simple;
	bh=fo/wWHcKo9hotlOVtm6sGvRu1sRZxRlb7OZ5dfVpazA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlTwDhR/YG80YtZTCqNIuvs2jZb/uU8eCttokpqQS3XakTriS/Lj+UPXA3h0ITH95is4Rkk71BZjQscaLGR5BGt8jph4GXr7DDlzBJ+WMEMRwVrj7i+3OLJYbeS01qD5KdBrPT8kOuzCE4QMwYq4OXe6AUfn1qXj12T1TclZIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PFoz/cVm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548587; x=1760084587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fo/wWHcKo9hotlOVtm6sGvRu1sRZxRlb7OZ5dfVpazA=;
  b=PFoz/cVmv/eavKFEaWCn9L89mFZrbYxi0YeSU0GzI+LHx4mv6f/3W5u6
   pI1NZrF/AgU5OiAEH1ghD3rj/32J1rka9kPFSdZCE4uoaKL5WOeP3ruL+
   hdE529u9cH2S1/piIUXUIvj0ITavQrZdmAHOCPllyamrcQaEevljdFx6/
   UHwcoep6dEMkl/V1OkFM/XF0YhwgcaooKQQ1qqN20ZjChk7XVfPWs/+xs
   uqWRRyggKN6h14Lr9LYkAVjKJfJ2EF8P3ydXl3+th//IFkBTBfUue2wY5
   PmgQarkelifXsksf0pjv19vcBVzJ+Oq5F2dkHY+FpiNkveo5uVC7SUHDR
   A==;
X-CSE-ConnectionGUID: x5SKfw9ZTYWBZMz1Nje/Ew==
X-CSE-MsgGUID: zBma5BA4TrOyS0nymw/o7g==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:22:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:34 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:30 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 2/7] net: phy: microchip_t1s: update new initial settings for LAN865X Rev.B0
Date: Thu, 10 Oct 2024 13:52:00 +0530
Message-ID: <20241010082205.221493-3-parthiban.veerasooran@microchip.com>
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

Update the new/improved initial settings from the latest configuration
application note AN1760 released for LAN8650/1 Rev.B0 Revision F
(DS60001760G - June 2024).
https://www.microchip.com/en-us/application-notes/an1760

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 120 ++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 24f992aba7d7..12f6678e3188 100644
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
@@ -121,6 +137,9 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 		ret = lan865x_revb0_indirect_read(phydev, fixup_regs[i]);
 		if (ret < 0)
 			return ret;
+
+		/* 5-bit signed value, sign extend */
+		ret &= GENMASK(4, 0);
 		if (ret & BIT(4))
 			offsets[i] = ret | 0xE0;
 		else
@@ -163,59 +182,88 @@ static int lan865x_write_cfg_params(struct phy_device *phydev,
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
+	cfg_results[0] = FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
+			 FIELD_PREP(GENMASK(9, 4), 14 + offsets[0]) |
+			 0x03;
+	cfg_results[1] = FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
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
+	cfg_results[0] = FIELD_PREP(GENMASK(13, 8), 5 + offsets[0]) |
+			 (9 + offsets[0]);
+	cfg_results[1] = FIELD_PREP(GENMASK(13, 8), 9 + offsets[0]) |
+			 (14 + offsets[0]);
+	cfg_results[2] = FIELD_PREP(GENMASK(13, 8), 17 + offsets[0]) |
+			 (22 + offsets[0]);
 
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


