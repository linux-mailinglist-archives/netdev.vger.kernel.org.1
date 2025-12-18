Return-Path: <netdev+bounces-245409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B09CCCFED
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D4C3034A0B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB7313E2D;
	Thu, 18 Dec 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vDgQwhoI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H0Q4xzxA"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66E313520;
	Thu, 18 Dec 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079474; cv=none; b=Jimx22BMyhpQRjZtgcUOm8bAkw3yq1Q1sVQhDWwjgHGGlD0uGen3zTv5ov75+ZR60PSwB8kmJapVxscnEuBC8ReQ8p4o9QfF7SqNHyBX0iSBrFTmJB73HIUOWcYCtTv3JpgJnDft7FjoC0hIOytDKQBRrgqmLpgwfE8gJOzdAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079474; c=relaxed/simple;
	bh=v6Xm4PS53pUiB9setquq1/S3Ilo9lNKv7mpN5jBrr/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZJMVPjpC8nJPDnBMEpcUNLHBRlU+dW1qcgR3JnLxv8wBPWg2ZtSkvZuNRrXx1cnkNerWZxWw/v2kU5f8bxYcCeKPzqWcqo177P14q2kv5oY56nDpTAADWJHAkpKWoqddfRhCFgn1Ue1c5OK5RzpNGhViPKYPjSKjW8r8Z4oZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vDgQwhoI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H0Q4xzxA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dXHtk487dz9tKy;
	Thu, 18 Dec 2025 18:37:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GESOPhLoPY5H8Y4GPrFSfh6RpDq26pJaRGI/HTOijc=;
	b=vDgQwhoIvoat1/fivX5AVt+mldXme4ob/pphlDm4JMITvCeyOlLelBDWBpArhW3Rtt+BDz
	VSDZ/NCvEiG1S2jBiJs2CmVzysPhN9/uVIU7LTswjgnnp0KZXlBMY9n9A4wPKB976cQhKu
	FgNOxqSjv43A07KrkrmmyuMql05Gs+IeEv09hTQSSQmNkfRmw468I0oFn/Koyg8CeakVUz
	hl5QWZH5OsXO0r15cvGF2N9OH1jy/Em8n91fU3psVyJbD0OQiLa3jrRdkoIgP1SmCmTiVE
	Zd3O8LSOOWRqTymlqfroSO/hoc6yI25LELaxB1ad4Y/R+2hxvGJjrh64NhKP2g==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GESOPhLoPY5H8Y4GPrFSfh6RpDq26pJaRGI/HTOijc=;
	b=H0Q4xzxAkMXKTXPijpNWsFTWX/b3bWA/bdZbRgjRGfaXq5L58VuYo5/o/ppXFbvxYTFwfE
	fxVHZowL9J0/s576NqSDmU71Pri0xlCaWb/TXZl6QmMh9atMR0B4eD7vAZe511RE4BwFxx
	93Qa2rV1KtLsv17Vl374CPnnzJK7cn4O5W8vttA9y9TwBq8bo2ce6hIJ+xD163Su5oTvNv
	vwcoAcxpguCJDCyH2Ow2exJV94H921VCf+GBZpZKrTq/z1x5Qv1dewcCrjHpgFP450HCxJ
	me50Bnvhh3xi9iixtnecR0l6fRY7jnqkT3ojRLOlsqKY1D5uk1IwTLrA25gAOg==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v3 3/3] net: phy: realtek: Add property to enable SSC
Date: Thu, 18 Dec 2025 18:36:14 +0100
Message-ID: <20251218173718.12878-3-marek.vasut@mailbox.org>
In-Reply-To: <20251218173718.12878-1-marek.vasut@mailbox.org>
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f7f77bd255d112aec40
X-MBO-RS-META: 3tymohztdo55oqojh8dau6qohsc41i54

Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
follows EMI improvement application note Rev. 1.2 for these PHYs.

The current implementation enables SSC for both RXC and SYSCLK clock
signals. Introduce DT properties 'realtek,clkout-ssc-enable',
'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
signals.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
V3: Update RTL8211FVD PHYCR2 comment to state this PHY has PHYCR2 register,
    but SSC configuration is not supported due to different layout.
---
 drivers/net/phy/realtek/realtek_main.c | 133 +++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 67ecf3d4af2b1..15d1de1339845 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -74,11 +74,19 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
 
 #define RTL8211F_INSR_PAGE			0xa43
 #define RTL8211F_INSR				0x1d
 
+/* RTL8211F SSC settings */
+#define RTL8211F_SSC_PAGE			0xc44
+#define RTL8211F_SSC_RXC			0x13
+#define RTL8211F_SSC_SYSCLK			0x17
+#define RTL8211F_SSC_CLKOUT			0x19
+
 /* RTL8211F LED configuration */
 #define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
@@ -203,6 +211,9 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_clkout_ssc;
+	bool enable_rxc_ssc;
+	bool enable_sysclk_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,6 +277,12 @@ static int rtl821x_probe(struct phy_device *phydev)
 						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
+	priv->enable_clkout_ssc = of_property_read_bool(dev->of_node,
+							"realtek,clkout-ssc-enable");
+	priv->enable_rxc_ssc = of_property_read_bool(dev->of_node,
+						     "realtek,rxc-ssc-enable");
+	priv->enable_sysclk_ssc = of_property_read_bool(dev->of_node,
+							"realtek,sysclk-ssc-enable");
 
 	phydev->priv = priv;
 
@@ -700,6 +717,110 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
 				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
 }
 
+static int rtl8211f_config_clkout_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_clkout_ssc)
+		return 0;
+
+	/* RTL8211FVD has PHYCR2 register, but configuration of CLKOUT SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	/* Unnamed registers from EMI improvement parameters application note 1.2 */
+	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC initialization failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_CLKOUT, 0x38c3);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * Enable CLKOUT SSC using PHYCR2 bit 7 , this step is missing from the
+	 * EMI improvement parameters application note 1.2 section 2.3
+	 */
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+			       RTL8211F_CLKOUT_SSC_EN, RTL8211F_CLKOUT_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8211f_config_rxc_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_rxc_ssc)
+		return 0;
+
+	/* RTL8211FVD has PHYCR2 register, but configuration of RXC SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_RXC, 0x5f00);
+	if (ret < 0) {
+		dev_err(dev, "RXC SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8211f_config_sysclk_ssc(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_sysclk_ssc)
+		return 0;
+
+	/* RTL8211FVD has PHYCR2 register, but configuration of SYSCLK SSC
+	 * is not currently supported by this driver due to different bit
+	 * layout.
+	 */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	ret = phy_write_paged(phydev, RTL8211F_SSC_PAGE, RTL8211F_SSC_SYSCLK, 0x4f00);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable SSC */
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+			       RTL8211F_SYSCLK_SSC_EN, RTL8211F_SYSCLK_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SCC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -723,6 +844,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
+	ret = rtl8211f_config_clkout_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_rxc_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_sysclk_ssc(phydev);
+	if (ret)
+		return ret;
+
 	return rtl8211f_config_phy_eee(phydev);
 }
 
-- 
2.51.0


