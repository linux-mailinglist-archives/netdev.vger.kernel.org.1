Return-Path: <netdev+bounces-234291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE20C1EDC2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52F04E763E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6683396FD;
	Thu, 30 Oct 2025 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CSKX94O2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DD338584;
	Thu, 30 Oct 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810781; cv=none; b=h7+rZoIrbds5RsEgFfyF8IysBBuI1Jaj3sfU0Bbj+xIdP6MuS7a+V81AVOwDHHSDJusLhgklS23cYzHeaT1v8Lv5eRL05G0tC/y8IOyGohsK+AS6is1qkPUo0yCa5hxZsEToxWBTbE2B+CuRYljqC1/79V0rPf4eTq2rmSXoiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810781; c=relaxed/simple;
	bh=VzTHB6uwUrUYHIbZ6C1sj1SfLBTRnPQuiLbkWA/dx0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gviwemcsARl2uWrRKzHGRRoRiptNhwqwe6MdLN8eSeAhZBr4Uw8clHM/RtNcJZGBcW7fCC98LqyXpNjD/O2khfLjnG/+tnWVsCQ+hsKjN8w4TMsbOKrqVHz/Hpwnys7BIZWUJT3RkhIeys4Ojg4IPIP6OVgk5QLu743NrbR5n+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CSKX94O2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761810780; x=1793346780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VzTHB6uwUrUYHIbZ6C1sj1SfLBTRnPQuiLbkWA/dx0A=;
  b=CSKX94O2NB7A49yrLqrRoZetCqbIHJJ4PHNXlPcPXVCCnKigCXcvPw0B
   HVMZLDEaeFjnDxLwhza90ZDZweuWw5qWnMx1qzGm856e7+z4h0diNj/bh
   /TouUdh1kqOau28MrC0DRoH52VNqr8622+j3Lb9K97qdhpdmI91ekOrQl
   QsQfP8FTuaUaygoFXTIoJqQi/HXtLys0FEWzTM3Au0OSJb0rkS7JEXl8O
   9/owHZSpv8DYv8SCNqqJrwas/vjtzgVavLIYGTG0wAEPEcmiRH4s1ERGP
   suv4mDQmuBnmesaOcQQe4vwvsOV4O3nM9mk2ddE6AABsIQ0NNOrcoEfhi
   g==;
X-CSE-ConnectionGUID: hWk4P1TPRtmfKCCnTJHFMw==
X-CSE-MsgGUID: CYXbvUIvSlySK+4RULBSVw==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="48455738"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2025 00:52:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Oct 2025 00:52:28 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 00:52:26 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v3 1/2] net: phy: micrel: lan8842 errata
Date: Thu, 30 Oct 2025 08:49:40 +0100
Message-ID: <20251030074941.611454-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030074941.611454-1-horatiu.vultur@microchip.com>
References: <20251030074941.611454-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add errata for lan8842. The errata document can be found here [1].
This is fixing the module 2 ("Analog front-end not optimized for
PHY-side shorted center taps").

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 604b5de0c1581..504c715b7db90 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2853,6 +2853,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
  */
 #define LAN8814_PAGE_PORT_REGS 5
 
+/**
+ * LAN8814_PAGE_POWER_REGS - Selects Extended Page 28.
+ *
+ * This page contains analog control registers and power mode registers.
+ */
+#define LAN8814_PAGE_POWER_REGS 28
+
 /**
  * LAN8814_PAGE_SYSTEM_CTRL - Selects Extended Page 31.
  *
@@ -5884,6 +5891,143 @@ static int lan8842_probe(struct phy_device *phydev)
 	return 0;
 }
 
+#define LAN8814_POWER_MGMT_MODE_3_ANEG_MDI		0x13
+#define LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX		0x14
+#define LAN8814_POWER_MGMT_MODE_5_10BT_MDI		0x15
+#define LAN8814_POWER_MGMT_MODE_6_10BT_MDIX		0x16
+#define LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN		0x17
+#define LAN8814_POWER_MGMT_MODE_8_100BT_MDI		0x18
+#define LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX	0x19
+#define LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX	0x1a
+#define LAN8814_POWER_MGMT_MODE_11_100BT_MDIX		0x1b
+#define LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX	0x1c
+#define LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX	0x1d
+#define LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX	0x1e
+
+#define LAN8814_POWER_MGMT_DLLPD_D			BIT(0)
+#define LAN8814_POWER_MGMT_ADCPD_D			BIT(1)
+#define LAN8814_POWER_MGMT_PGAPD_D			BIT(2)
+#define LAN8814_POWER_MGMT_TXPD_D			BIT(3)
+#define LAN8814_POWER_MGMT_DLLPD_C			BIT(4)
+#define LAN8814_POWER_MGMT_ADCPD_C			BIT(5)
+#define LAN8814_POWER_MGMT_PGAPD_C			BIT(6)
+#define LAN8814_POWER_MGMT_TXPD_C			BIT(7)
+#define LAN8814_POWER_MGMT_DLLPD_B			BIT(8)
+#define LAN8814_POWER_MGMT_ADCPD_B			BIT(9)
+#define LAN8814_POWER_MGMT_PGAPD_B			BIT(10)
+#define LAN8814_POWER_MGMT_TXPD_B			BIT(11)
+#define LAN8814_POWER_MGMT_DLLPD_A			BIT(12)
+#define LAN8814_POWER_MGMT_ADCPD_A			BIT(13)
+#define LAN8814_POWER_MGMT_PGAPD_A			BIT(14)
+#define LAN8814_POWER_MGMT_TXPD_A			BIT(15)
+
+#define LAN8814_POWER_MGMT_C_D		(LAN8814_POWER_MGMT_DLLPD_D | \
+					 LAN8814_POWER_MGMT_ADCPD_D | \
+					 LAN8814_POWER_MGMT_PGAPD_D | \
+					 LAN8814_POWER_MGMT_DLLPD_C | \
+					 LAN8814_POWER_MGMT_ADCPD_C | \
+					 LAN8814_POWER_MGMT_PGAPD_C)
+
+#define LAN8814_POWER_MGMT_B_C_D	(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_DLLPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_B)
+
+#define LAN8814_POWER_MGMT_VAL1		(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_A | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL2		LAN8814_POWER_MGMT_C_D
+
+#define LAN8814_POWER_MGMT_VAL3		(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_DLLPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL4		(LAN8814_POWER_MGMT_B_C_D | \
+					 LAN8814_POWER_MGMT_ADCPD_A | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL5		LAN8814_POWER_MGMT_B_C_D
+
+static int lan8842_erratas(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Magjack center tapped ports */
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_5_10BT_MDI,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_6_10BT_MDIX,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN,
+				    LAN8814_POWER_MGMT_VAL2);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_8_100BT_MDI,
+				    LAN8814_POWER_MGMT_VAL3);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX,
+				    LAN8814_POWER_MGMT_VAL3);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_11_100BT_MDIX,
+				    LAN8814_POWER_MGMT_VAL5);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX,
+				    LAN8814_POWER_MGMT_VAL5);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				     LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+				     LAN8814_POWER_MGMT_VAL4);
+}
+
 static int lan8842_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -5896,6 +6040,11 @@ static int lan8842_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Apply the erratas for this device */
+	ret = lan8842_erratas(phydev);
+	if (ret < 0)
+		return ret;
+
 	/* Even if the GPIOs are set to control the LEDs the behaviour of the
 	 * LEDs is wrong, they are not blinking when there is traffic.
 	 * To fix this it is required to set extended LED mode
-- 
2.34.1


