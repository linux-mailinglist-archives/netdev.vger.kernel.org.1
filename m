Return-Path: <netdev+bounces-230362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9DBE701D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840494261F5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC8257826;
	Fri, 17 Oct 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HSTeB7CI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4B2550D0;
	Fri, 17 Oct 2025 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687472; cv=none; b=OHSz7vKabzvKdvRDgC6UQcicbPiGr5Ml8HyBl0S7wq7Tf7QokydvfKWoggYWtnnx6EN4rKfxQPb5DZzC5nPj5hmCNTvqnAQNEs9hJ3LsY6Y0LQMssPa80ONpfF+Bq6lqS+uWGd1z96sBR55wJbEJ1FjfKOZSfQjl29kEA62uTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687472; c=relaxed/simple;
	bh=Ohdir8G4bdKRBk8kXLJE4lAc2L8SEMcavSSoYnRb65U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbD8m9fScAqjXMkydDj43PHMVrCizF7WC4v1mOX1x0ciImyd+sTrq1cVsD55BnleNKlRmqZE7dNXhEoMByGsp2WlfB5VrMeaFoAH3H9RO4MKpF2TJOfPeeMqZpj0OCjk+xIeEjkcHYWPk21Y/8ByTYS6jemS6sgmLLccc1hj7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HSTeB7CI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760687468; x=1792223468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ohdir8G4bdKRBk8kXLJE4lAc2L8SEMcavSSoYnRb65U=;
  b=HSTeB7CIP/fu1K51iCp3n2s8enoMAbk1j/UegCTA7yj7Np346gz2vNnN
   0OwvLBRk4gGlPlBhIk6gg73l3L4U0l2JBvifLWP3DLgHwyZNo7BFR/H0H
   RFIapC/ziCuftpK1uJwp4AP06t8C3FX6X+nQ1rGwyQKczQlGCB2d68pmH
   nXa9t4do56wdaLJUlRz2noIlhArqGWwXP1VqtSTwOBwd0RTmkvlOAx0jF
   2ezfu3UoeagYbM6R7rNzJzS+ZeIg+XtZXlAlnEhBb/3gB3rgRzBMZlpQZ
   szeNvZ6Rn546OyrCT3tv1w4Dc4wEbt6xqdpfAI9lpJXptosAX4WaKIsJP
   g==;
X-CSE-ConnectionGUID: Tj/HYMSTS3Ky+Q2iytSAMA==
X-CSE-MsgGUID: ZyQTjCbkSoiKO0VDtrwvBA==
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="54080002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2025 00:51:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 17 Oct 2025 00:50:32 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 17 Oct 2025 00:50:30 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs for lan8814
Date: Fri, 17 Oct 2025 09:47:30 +0200
Message-ID: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
disabled. All these SKUs have the same value in the register 2 and 3
meaning we can't differentiate them based on device id therefore check
the SKU register and based on this allow or not to create a PTP device.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 79ce3eb6752b6..16855bf8c3916 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -101,6 +101,8 @@
 #define LAN8814_CABLE_DIAG_VCT_DATA_MASK	GENMASK(7, 0)
 #define LAN8814_PAIR_BIT_SHIFT			12
 
+#define LAN8814_SKUS				0xB
+
 #define LAN8814_WIRE_PAIR_MASK			0xF
 
 /* Lan8814 general Interrupt control/status reg in GPHY specific block. */
@@ -367,6 +369,9 @@
 
 #define LAN8842_REV_8832			0x8832
 
+#define LAN8814_REV_LAN8814			0x8814
+#define LAN8814_REV_LAN8818			0x8818
+
 struct kszphy_hw_stat {
 	const char *string;
 	u8 reg;
@@ -449,6 +454,7 @@ struct kszphy_priv {
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
 	bool clk_enable;
+	bool is_ptp_available;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 	struct kszphy_phy_stats phy_stats;
 };
@@ -4130,6 +4136,17 @@ static int lan8804_config_intr(struct phy_device *phydev)
 	return 0;
 }
 
+/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
+ * some of them support PTP while others don't support it. This function will
+ * return true is the sku supports it, otherwise will return false.
+ */
+static bool lan8814_has_ptp(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	return priv->is_ptp_available;
+}
+
 static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 {
 	int ret = IRQ_NONE;
@@ -4146,6 +4163,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	if (!lan8814_has_ptp(phydev))
+		return ret;
+
 	while (true) {
 		irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 						  PTP_TSU_INT_STS);
@@ -4207,6 +4227,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
 	    !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
 		return;
 
+	if (!lan8814_has_ptp(phydev))
+		return;
+
 	lanphy_write_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
 			      TSU_HARD_RESET, TSU_HARD_RESET_);
 
@@ -4336,6 +4359,9 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
 
 static int lan8814_ptp_probe_once(struct phy_device *phydev)
 {
+	if (!lan8814_has_ptp(phydev))
+		return 0;
+
 	return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
 					LAN8814_PTP_GPIO_NUM);
 }
@@ -4450,6 +4476,18 @@ static int lan8814_probe(struct phy_device *phydev)
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
 			      addr, sizeof(struct lan8814_shared_priv));
 
+	/* There are lan8814 SKUs that don't support PTP. Make sure that for
+	 * those skus no PTP device is created. Here we check if the SKU
+	 * supports PTP.
+	 */
+	err = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				   LAN8814_SKUS);
+	if (err < 0)
+		return err;
+
+	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
+				 err == LAN8814_REV_LAN8818;
+
 	if (phy_package_init_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
-- 
2.34.1


