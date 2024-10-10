Return-Path: <netdev+bounces-134110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11F99805E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701782830A4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7F1CC8A3;
	Thu, 10 Oct 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XiTJ78tf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B31CBEA2;
	Thu, 10 Oct 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548595; cv=none; b=RVF6d7K/0KpbjpsQ5vR91RPgkJ/YZDOFqKswpAf5T90IrnrfrRNTTSg502sVndodCx8UHO1dzgJk64x3o9iwUbhvgM74LqVAG01yvJ+jB7Ns+1N0JndwHPXeaOYr39fq9c5A0Y34Nki4z9tF4BDkNkY8vPkgvgggKW3m/l9Vfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548595; c=relaxed/simple;
	bh=OPB33RxIcAJc1nA2saT41xUIZEzqfmb784/ecQrtH6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuUeXlWR5fjeSX48jJx569Ll12gkeeuM5lRMGPkU8LGvS52Ta4ruxM3gMmlECsvdNWgNFCeW8iypwK41q8/FD5MLMnMCWAxzQljOge5k5Bd3xxjhyAn2myuPbYBwPHNLMNYSOMpflZGDasP8S5TRcB2fFHfNPWcgshFKYhV1ujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XiTJ78tf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728548592; x=1760084592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPB33RxIcAJc1nA2saT41xUIZEzqfmb784/ecQrtH6w=;
  b=XiTJ78tfNbMliTTGJ1eTYorT+gg7nJM71lumpviJQNrT/1K0e5ZuYhfA
   5Ebpb6fzr6dYOii5UyEr5Xtxs4Yaud2oynamKEq44sOZeyEJHxcwL2N65
   8cVq5NR4nRbACN4Nwh1DLg6v8RENs3Fyb8777f82DDNJDD3l9PhdDMZig
   Vh41uxXEXu3b3JHov1e68Ye+azXRclRI2Xd/10mW3N7DLVfROh+rPw2hr
   pP4FriD8tyOjNHwQKKAGGLINZkMmosZjn1WmQRqRyZUowNazZaTHJCXUR
   CbqK/pOC4k89B2mQwXq33zZeOVbJT0xK8/rRpccv6Kd+JUyuRLn7l7Ah+
   g==;
X-CSE-ConnectionGUID: D165IrQCQQaSZj0APvNNjA==
X-CSE-MsgGUID: N8xW6fgkS6WsnLDlVCLdlw==
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="36163262"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2024 01:23:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 10 Oct 2024 01:22:48 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 10 Oct 2024 01:22:44 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v4 5/7] net: phy: microchip_t1s: add support for Microchip's LAN867X Rev.C1
Date: Thu, 10 Oct 2024 13:52:03 +0530
Message-ID: <20241010082205.221493-6-parthiban.veerasooran@microchip.com>
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

Add support for LAN8670/1/2 Rev.C1 as per the latest configuration note
AN1699 released (Revision E (DS60001699F - June 2024)).
https://www.microchip.com/en-us/application-notes/an1699

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/Kconfig         |  2 +-
 drivers/net/phy/microchip_t1s.c | 66 ++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index f18defab70cf..04f605606a8a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -292,7 +292,7 @@ config MICREL_PHY
 config MICROCHIP_T1S_PHY
 	tristate "Microchip 10BASE-T1S Ethernet PHYs"
 	help
-	  Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
+	  Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
 	  Internal PHYs.
 
 config MICROCHIP_PHY
diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index d9814a09a026..f4081886ac1e 100644
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
 
@@ -291,6 +292,58 @@ static int lan867x_check_reset_complete(struct phy_device *phydev)
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
+	 * Refer the below links for the comparison.
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
@@ -371,6 +424,16 @@ static struct phy_driver microchip_t1s_driver[] = {
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
@@ -389,6 +452,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB) },
 	{ }
 };
-- 
2.34.1


