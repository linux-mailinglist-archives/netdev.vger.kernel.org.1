Return-Path: <netdev+bounces-117721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5494EEAC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DFA1F21800
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616517CA1B;
	Mon, 12 Aug 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yHmOyKTL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0017BB11;
	Mon, 12 Aug 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470560; cv=none; b=aKjBvlwFnpxgPaG50VB0ZQClCL/UAkRSyLop5eyZeFD40hd1Ft2yUFXMcFHfFl789z5ilrhTiB6yn0wo6ktriyEV+LaRrmggQU7Da9QEWLyEZBB7a+jyJbmwW8jx7Gv39f4Nfz/OGGUaxFcpk/OaTA5QcyODtrIuy9NHsOsH1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470560; c=relaxed/simple;
	bh=FHNigu720O+v7Cjr8tWfS6hV1UQIqom+SF8e1gOZkiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aG7LVec5yhEsb9IIYmeq7gMhEFAPeMX8cFI905NX+5zxFa8lnoX0ke1nODQSWuSdf4s6TDRN18d4YFDgkeIPVF0eqltHdKujlO4QUJ0CG4ozTJwgdR+GDyIm8jFonNci05sSO2uwqv1j8SDdFkVpPO2itSc/Xsn1FPTwPBdTCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yHmOyKTL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470558; x=1755006558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHNigu720O+v7Cjr8tWfS6hV1UQIqom+SF8e1gOZkiY=;
  b=yHmOyKTL1XdunoHU/yNDahB546BO7URvIIHg8DWQPEqt0Fb22vkivCZ2
   NYEY3vbbNnvJ70T745F0ygaAdmn5LXmJlfRS3K0BJKEBahhlxvzvn8fD3
   gpySqYHzgI5fSS9SCJBIKP6ZjOC8l6LDKx5473oiEvzNjUlbSkG6G84Ob
   sh4j2bQ4aumU1GMuazuRfL3sVQaE0pDWCi+vYqSwEqJhiGEokGI5SMCjj
   B1wNShnHqrfYNkBw7O3vX4zx9JXHumgSl8xfBGkBh62+q0U0M9GxnJuhE
   RemW1QPwr71jBq175gOv/NlSvfnIC7iT2DB/GGiltuxGsamo3bDTQ5P5f
   Q==;
X-CSE-ConnectionGUID: kPkSNNkqRiKssk122yqRMw==
X-CSE-MsgGUID: EZFAQzS4TjaxMwd+Am+xpA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="31049503"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:49:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:49:08 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:49:03 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
Date: Mon, 12 Aug 2024 19:18:14 +0530
Message-ID: <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>
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

This patch adds support for LAN8670/1/2 Rev.C1 as per the latest
configuration note AN1699 released (Revision E (DS60001699F - June 2024))
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  2 +-
 drivers/net/phy/microchip_t1s.c | 68 ++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 68db15d52355..63b45544c191 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -282,7 +282,7 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
+	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
 	  Internal PHYs.
 
 config MICROCHIP_PHY
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index d0af02a25d01..62f5ce548c6a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -3,7 +3,7 @@
  * Driver for Microchip 10BASE-T1S PHYs
  *
  * Support: Microchip Phys:
- *  lan8670/1/2 Rev.B1
+ *  lan8670/1/2 Rev.B1/C1
  *  lan8650/1 Rev.B0/B1 Internal PHYs
  */
 
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
+#define PHY_ID_LAN867X_REVC1 0x0007C164
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
@@ -243,7 +244,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
 		if (ret)
 			return ret;
 
-		if (i == 2) {
+		if (i == 1) {
 			ret = lan865x_setup_cfgparam(phydev, offsets);
 			if (ret)
 				return ret;
@@ -290,6 +291,58 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan867x_revc1_config_init(struct phy_device *phydev)
+{
+	s8 offsets[2];
+	int ret;
+
+	ret = lan867x_check_reset_complete(phydev);
+	if (ret)
+		return ret;
+
+	ret = lan865x_generate_cfg_offsets(phydev, offsets);
+	if (ret)
+		return ret;
+
+	/* LAN867x Rev.C1 configuration settings are equal to the first 9
+	 * configuration settings and all the sqi fixup settings from LAN865x
+	 * Rev.B0/B1. So the same fixup registers and values from LAN865x
+	 * Rev.B0/B1 are used for LAN867x Rev.C1 to avoid duplication.
+	 * Refer the below links for the comparision.
+	 * https://www.microchip.com/en-us/application-notes/an1760
+	 * Revision F (DS60001760G - June 2024)
+	 * https://www.microchip.com/en-us/application-notes/an1699
+	 * Revision E (DS60001699F - June 2024)
+	 */
+	for (int i = 0; i < 9; i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb_fixup_registers[i],
+				    lan865x_revb_fixup_values[i]);
+		if (ret)
+			return ret;
+
+		if (i == 1) {
+			ret = lan865x_setup_cfgparam(phydev, offsets);
+			if (ret)
+				return ret;
+		}
+	}
+
+	ret = lan865x_setup_sqi_cfgparam(phydev, offsets);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(lan865x_revb_sqi_fixup_regs); i++) {
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    lan865x_revb_sqi_fixup_regs[i],
+				    lan865x_revb_sqi_fixup_values[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int lan867x_revb1_config_init(struct phy_device *phydev)
 {
 	int err;
@@ -342,6 +395,16 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
+		.name               = "LAN867X Rev.C1",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revc1_config_init,
+		.read_status        = lan86xx_read_status,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
 		.name               = "LAN865X Rev.B0/B1 Internal Phy",
@@ -358,6 +421,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


