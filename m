Return-Path: <netdev+bounces-117719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD594EEA8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7E1F2109A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA26E17C230;
	Mon, 12 Aug 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KjRs5GXy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005B17B43F;
	Mon, 12 Aug 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470558; cv=none; b=RZDDDGeJgLy9nIAtWZiY8ewEbjznSVYpNcnKNLGI5rwrASMT8Ewmtx0Pk1teGu1Bxrp2Rm+D0qhzno0ZjDjZT4+LYfAUtyCNCPFbLqQJr4jaBkmlo7b7f3hq6bIf4ks/46CrwKdRlILFWo4O4KX5IuxFuplwVcl57tfyo20AbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470558; c=relaxed/simple;
	bh=qJvFk7/dLkH9pUjzhXC38WRDHiuSnNUM7hFPIYxK5sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uubY62PVmM3fEMruPMgLj5y33HN2raZ9sp1GgpWF/4Wu7SBlLgTtQeWUID/cmNGLMZ+ysvZTSyUjjz8KBJ1hAOPyY5dXFUtWOBGYenvu2L6aRCFMdb21lxN3nyrB4ma8LMdepRA0Zk3L4Ux12GDcCMVFqamEoQw8edJFAuqoKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KjRs5GXy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470556; x=1755006556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJvFk7/dLkH9pUjzhXC38WRDHiuSnNUM7hFPIYxK5sg=;
  b=KjRs5GXys/E53BcuScEJJ8eOgGdCESxr3xP/N1oNlJmlkiu94fDVkxjL
   qkrO3HZt8EzqOPNMSiwkHM9FbF4FXCYC/dD/CkNIehNTbeFGTRtcipZes
   JZHGJW9pVd3dMMc16fcOjmVAxg4aYaREibMFNCJQgJEbjwmfXweZd33SH
   xQ+kF32wIgXuYaLnT5GgRork8gSIY0N22d0BJNsjxuCCgAzspiEKnOt3a
   pdiHP/Apbn9/rxRKewdCbN0z91VotfyIQVED3bIa8E4bodpRuo9b0AA4W
   KmbO7OLTnRgY8Zw6Ne5VcjZUEq0A+Z/etCZugCKTgNst1sRoA42cMVC5e
   Q==;
X-CSE-ConnectionGUID: kPkSNNkqRiKssk122yqRMw==
X-CSE-MsgGUID: vJZ6G1iQRXW0TzG2O+F7QA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="31049488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:49:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:48:48 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:48:44 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 1/7] net: phy: microchip_t1s: restructure cfg read/write functions arguments
Date: Mon, 12 Aug 2024 19:18:10 +0530
Message-ID: <20240812134816.380688-2-Parthiban.Veerasooran@microchip.com>
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

This patch restructures lan865x_write_cfg_params() and
lan865x_read_cfg_params() functions arguments to more generic which will
be useful for the next patch which updates the improved initial
configuration for LAN8650/1 Rev.B0 published in the Configuration Note.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 41 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 534ca7d1b061..373a8b8da5ee 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -112,7 +112,7 @@ static int lan865x_revb0_indirect_read(struct phy_device *phydev, u16 addr)
 /* This is pulled straight from AN1760 from 'calculation of offset 1' &
  * 'calculation of offset 2'
  */
-static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2])
+static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[])
 {
 	const u16 fixup_regs[2] = {0x0004, 0x0008};
 	int ret;
@@ -130,13 +130,15 @@ static int lan865x_generate_cfg_offsets(struct phy_device *phydev, s8 offsets[2]
 	return 0;
 }
 
-static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_read_cfg_params(struct phy_device *phydev,
+				   const u16 cfg_regs[], u16 cfg_params[],
+				   u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
+	for (int i = 0; i < count; i++) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2,
-				   lan865x_revb0_fixup_cfg_regs[i]);
+				   cfg_regs[i]);
 		if (ret < 0)
 			return ret;
 		cfg_params[i] = (u16)ret;
@@ -145,13 +147,14 @@ static int lan865x_read_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
+static int lan865x_write_cfg_params(struct phy_device *phydev,
+				    const u16 cfg_regs[], u16 cfg_params[],
+				    u8 count)
 {
 	int ret;
 
-	for (int i = 0; i < ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs); i++) {
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
-				    lan865x_revb0_fixup_cfg_regs[i],
+	for (int i = 0; i < count; i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, cfg_regs[i],
 				    cfg_params[i]);
 		if (ret)
 			return ret;
@@ -160,18 +163,14 @@ static int lan865x_write_cfg_params(struct phy_device *phydev, u16 cfg_params[])
 	return 0;
 }
 
-static int lan865x_setup_cfgparam(struct phy_device *phydev)
+static int lan865x_setup_cfgparam(struct phy_device *phydev, s8 offsets[])
 {
+	u16 cfg_results[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
 	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
-	u16 cfg_results[5];
-	s8 offsets[2];
 	int ret;
 
-	ret = lan865x_generate_cfg_offsets(phydev, offsets);
-	if (ret)
-		return ret;
-
-	ret = lan865x_read_cfg_params(phydev, cfg_params);
+	ret = lan865x_read_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+				      cfg_params, ARRAY_SIZE(cfg_params));
 	if (ret)
 		return ret;
 
@@ -190,16 +189,22 @@ static int lan865x_setup_cfgparam(struct phy_device *phydev)
 			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
 			  (22 + offsets[0]);
 
-	return lan865x_write_cfg_params(phydev, cfg_results);
+	return lan865x_write_cfg_params(phydev, lan865x_revb0_fixup_cfg_regs,
+					cfg_results, ARRAY_SIZE(cfg_results));
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
@@ -210,7 +215,7 @@ static int lan865x_revb0_config_init(struct phy_device *phydev)
 	/* Function to calculate and write the configuration parameters in the
 	 * 0x0084, 0x008A, 0x00AD, 0x00AE and 0x00AF registers (from AN1760)
 	 */
-	return lan865x_setup_cfgparam(phydev);
+	return lan865x_setup_cfgparam(phydev, offsets);
 }
 
 static int lan867x_revb1_config_init(struct phy_device *phydev)
-- 
2.34.1


