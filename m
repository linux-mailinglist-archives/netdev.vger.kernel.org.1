Return-Path: <netdev+bounces-234644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06561C24FBC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFA0A350F22
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A06347FD7;
	Fri, 31 Oct 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UkUNUh8c"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FE2E1743;
	Fri, 31 Oct 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913474; cv=none; b=Fk9WNGtBpKbx2C/iL7jS5iegkwp8KLcdlXug7f2TqLchcCddcbzkuWv1REH3dCi6RxnSWQmkITpLzcPmUeETz2hQxCxi/byi9Qtg2cWrhUUdDRp/MZ1hXY7FN7t31swLx0+2e0FCOKg+fga1jSgo0Fj+sOUu63pfrprfQvcreOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913474; c=relaxed/simple;
	bh=2Nt4r/eYanNf5cDgEn1QKK+iWGBoitcY9r7UXIB3y4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNbzs1bIsBwveAfKkQ0I0bPfppMussDMVO7y2RzIHOmd0weAd0CQSEg5JCwFgQKWi8cKlhlkrkZY8PdE3Rx7zMgdDaaZB7xRICexDElxj+/GdPgnjnTEtSQVnH1ZjNjLRe4PdPnGV9vQ1i9S8Agd5Cys4HqRLvZg0xMa1LC6Wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UkUNUh8c; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761913473; x=1793449473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Nt4r/eYanNf5cDgEn1QKK+iWGBoitcY9r7UXIB3y4g=;
  b=UkUNUh8c9gg9KCTr5N5Lbd+2H7Zm5767R0FTk9MbCLyASOitbwIxUTku
   pV5CrCUPPSDZxDgXfPN5izGhjz8CDp9gPd9hIy8pbRgZvYOWRrHPWIRny
   mQIFa4pKJtYmesgvuMzv/RZohNFnQTgNe+foR5SRfs01ZPwqZEUrW0zi6
   la4L0Hc3UmBsdckiC3qrCOPkCU8Dv6jd8MPNOQJqB7za38FQc6ixAHuOf
   xT2MUyQxvvyjqVPzFJNH5p26blRG9t2BkpyYMUQ9M+Uv3ZOm/mKkXDACG
   28dihNVHbsle5+0fRzmOenM3Xw6FzKh5Uoa2BMGSCX5mGmsRVojySHcRf
   w==;
X-CSE-ConnectionGUID: q2s9GN/sQTOoIfDSnWmHng==
X-CSE-MsgGUID: tyuglKZiToCp+KniprnHRg==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="47883659"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:24:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 31 Oct 2025 05:23:46 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 05:23:44 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 2/2] net: phy: micrel: lan8842 errata
Date: Fri, 31 Oct 2025 13:16:29 +0100
Message-ID: <20251031121629.814935-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031121629.814935-1-horatiu.vultur@microchip.com>
References: <20251031121629.814935-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add errata for lan8842. The errata document can be found here [1].
This is fixing the module 7 ("1000BASE-T PMA EEE TX wake timer is
non-compliant")

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 1fa56d4c17937..6a1a424e3b30f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -5965,6 +5965,9 @@ static int lan8842_probe(struct phy_device *phydev)
 
 #define LAN8814_POWER_MGMT_VAL5		LAN8814_POWER_MGMT_B_C_D
 
+#define LAN8814_EEE_WAKE_TX_TIMER			0x0e
+#define LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL		0x1f
+
 static const struct lanphy_reg_data short_center_tap_errata[] = {
 	{ LAN8814_PAGE_POWER_REGS,
 	  LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
@@ -6004,6 +6007,12 @@ static const struct lanphy_reg_data short_center_tap_errata[] = {
 	  LAN8814_POWER_MGMT_VAL4 },
 };
 
+static const struct lanphy_reg_data waketx_timer_errata[] = {
+	{ LAN8814_PAGE_EEE,
+	  LAN8814_EEE_WAKE_TX_TIMER,
+	  LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL },
+};
+
 static int lanphy_write_reg_data(struct phy_device *phydev,
 				 const struct lanphy_reg_data *data,
 				 size_t num)
@@ -6022,8 +6031,15 @@ static int lanphy_write_reg_data(struct phy_device *phydev,
 
 static int lan8842_erratas(struct phy_device *phydev)
 {
-	return lanphy_write_reg_data(phydev, short_center_tap_errata,
+	int ret;
+
+	ret = lanphy_write_reg_data(phydev, short_center_tap_errata,
 				    ARRAY_SIZE(short_center_tap_errata));
+	if (ret)
+		return ret;
+
+	return lanphy_write_reg_data(phydev, waketx_timer_errata,
+				     ARRAY_SIZE(waketx_timer_errata));
 }
 
 static int lan8842_config_init(struct phy_device *phydev)
-- 
2.34.1


