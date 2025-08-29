Return-Path: <netdev+bounces-218297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C130B3BCDF
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E782A16ABD1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859F31AF3E;
	Fri, 29 Aug 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gCEglMmj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB92E3360;
	Fri, 29 Aug 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475610; cv=none; b=JrkSUEsMtswnMk+Nm2CXYuKSqGry6Hs+OB+NTyT/gc4b/7tmim+a8acdQReyIND9c3nHtBAry2vncTBAhIyPmoD/5M4svLrvHVFSYEdbvroTENTCL5ALLhiqitcPyvNSoqgADTcwrNd9d82tPLPbkRTVD8p/veAHxLr38gw6bCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475610; c=relaxed/simple;
	bh=AFWhYvVgpgAiMCIcIxtGHIsRYd0mJgdTWOe6P9JXb2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jd4fxrWbXx8mBFNzNSrsfQE7JS3c7DkmGPGDuQRc9KLHeJ2H4HYM8WxPKdKe6Fk6YEEOAgi2/adIkBqiowhM3OCq3hi/aaUaCn4BUs6JqKBzN1gRH/N/R34ggLPA1rqWsBY8URIv7/x/iaLDPjHqTuHWYNvL+fKp0Q+nK6gcSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gCEglMmj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756475609; x=1788011609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFWhYvVgpgAiMCIcIxtGHIsRYd0mJgdTWOe6P9JXb2c=;
  b=gCEglMmjeQFI5de/lKkl19OWv5lZDerbD6kBZyfr3iSTuu0Y7ZBZ9iFQ
   QgpBv7xDzPlV8Z5bGp73fWLls3KS95Esw3bt1oi6BXg9oQ/YS5kzsUEiV
   CFV9bVko7RFvdPMgPC+ww1/pjzAkp4kAnhTh16dn5QXDXACtaTe4Mwy3a
   DfT0vB77VkU9zK3Y80msunu7HNQruOHinc3CNyaoniBgCrhn0eOH1qOfE
   zgqG7K3zRznqDZBX79OX5ljag/OGvDtfsgomTIY07zW/7EO0S7DNxfEuG
   3q+jGOUvddnDI5Kcezt/E1MOiSGXTqUQAFplOUttQ/i7GoB1aKhvbVP0Q
   Q==;
X-CSE-ConnectionGUID: Q33CIQ4WQVyVutAOxwUlrg==
X-CSE-MsgGUID: 0fAoSTf2Sl2pEB5mPIuByQ==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="45811694"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 06:53:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 06:52:34 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 06:52:32 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 2/2] net: phy: micrel: Add PTP support for lan8842
Date: Fri, 29 Aug 2025 15:48:36 +0200
Message-ID: <20250829134836.1024588-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It has the same PTP IP block as lan8814, only the number of GPIOs is
different, all the other functionality is the same. So reuse the same
functions as lan8814 for lan8842.
There is a revision of lan8842 called lan8832 which doesn't have the PTP
IP block. So make sure in that case the PTP is not initialized.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9a90818481320..628f21ad262ce 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -457,6 +457,8 @@ struct lan8842_phy_stats {
 
 struct lan8842_priv {
 	struct lan8842_phy_stats phy_stats;
+	struct kszphy_ptp_priv ptp_priv;
+	u16 rev;
 };
 
 static const struct kszphy_type lan8814_type = {
@@ -5786,6 +5788,17 @@ static int ksz9131_resume(struct phy_device *phydev)
 	return kszphy_resume(phydev);
 }
 
+#define LAN8842_PTP_GPIO_NUM 16
+
+static int lan8842_ptp_probe_once(struct phy_device *phydev)
+{
+	return __lan8814_ptp_probe_once(phydev, "lan8842_ptp_pin",
+					LAN8842_PTP_GPIO_NUM);
+}
+
+#define LAN8842_STRAP_REG			0 /* 0x0 */
+#define LAN8842_STRAP_REG_PHYADDR_MASK		GENMASK(4, 0)
+#define LAN8842_SKU_REG				11 /* 0x0b */
 #define LAN8842_SELF_TEST			14 /* 0x0e */
 #define LAN8842_SELF_TEST_RX_CNT_ENA		BIT(8)
 #define LAN8842_SELF_TEST_TX_CNT_ENA		BIT(4)
@@ -5793,6 +5806,7 @@ static int ksz9131_resume(struct phy_device *phydev)
 static int lan8842_probe(struct phy_device *phydev)
 {
 	struct lan8842_priv *priv;
+	int addr;
 	int ret;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -5817,6 +5831,43 @@ static int lan8842_probe(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Revision lan8832 doesn't have support for PTP, therefore don't add
+	 * any PTP clocks
+	 */
+	ret = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				   LAN8842_SKU_REG);
+	if (ret < 0)
+		return ret;
+
+	priv->rev = ret;
+	if (priv->rev == 0x8832)
+		return 0;
+
+	/* As the lan8814 and lan8842 has the same IP for the PTP block, the
+	 * only difference is the number of the GPIOs, then make sure that the
+	 * lan8842 initialized also the shared data pointer as this is used in
+	 * all the PTP functions for lan8814. The lan8842 doesn't have multiple
+	 * PHYs in the same package.
+	 */
+	addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				    LAN8842_STRAP_REG);
+	if (addr < 0)
+		return addr;
+	addr &= LAN8842_STRAP_REG_PHYADDR_MASK;
+
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, addr,
+				    sizeof(struct lan8814_shared_priv));
+	if (ret)
+		return ret;
+
+	if (phy_package_init_once(phydev)) {
+		ret = lan8842_ptp_probe_once(phydev);
+		if (ret)
+			return ret;
+	}
+
+	lan8814_ptp_init(phydev);
+
 	return 0;
 }
 
@@ -5896,8 +5947,34 @@ static int lan8842_config_inband(struct phy_device *phydev, unsigned int modes)
 				      enable ? LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA : 0);
 }
 
+static void lan8842_handle_ptp_interrupt(struct phy_device *phydev, u16 status)
+{
+	struct kszphy_ptp_priv *ptp_priv;
+	struct lan8842_priv *priv;
+
+	priv = phydev->priv;
+	ptp_priv = &priv->ptp_priv;
+
+	if (status & PTP_TSU_INT_STS_PTP_TX_TS_EN_)
+		lan8814_get_tx_ts(ptp_priv);
+
+	if (status & PTP_TSU_INT_STS_PTP_RX_TS_EN_)
+		lan8814_get_rx_ts(ptp_priv);
+
+	if (status & PTP_TSU_INT_STS_PTP_TX_TS_OVRFL_INT_) {
+		lan8814_flush_fifo(phydev, true);
+		skb_queue_purge(&ptp_priv->tx_queue);
+	}
+
+	if (status & PTP_TSU_INT_STS_PTP_RX_TS_OVRFL_INT_) {
+		lan8814_flush_fifo(phydev, false);
+		skb_queue_purge(&ptp_priv->rx_queue);
+	}
+}
+
 static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
 {
+	struct lan8842_priv *priv = phydev->priv;
 	int ret = IRQ_NONE;
 	int irq_status;
 
@@ -5912,6 +5989,26 @@ static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	/* Phy revision lan8832 doesn't have support for PTP threrefore there is
+	 * not need to check the PTP and GPIO interrupts
+	 */
+	if (priv->rev == 0x8832)
+		goto out;
+
+	while (true) {
+		irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+						  PTP_TSU_INT_STS);
+		if (!irq_status)
+			break;
+
+		lan8842_handle_ptp_interrupt(phydev, irq_status);
+		ret = IRQ_HANDLED;
+	}
+
+	if (!lan8814_handle_gpio_interrupt(phydev, irq_status))
+		ret = IRQ_HANDLED;
+
+out:
 	return ret;
 }
 
-- 
2.34.1


