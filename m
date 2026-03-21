Return-Path: <netdev+bounces-270240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOJpJCTovmnIiwMAu9opvQ
	(envelope-from <netdev+bounces-270240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8A2E6D91
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFEA9301AA5F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADE2DF128;
	Sat, 21 Mar 2026 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FYn7oRDE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ay72O8SH"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4A23B62C;
	Sat, 21 Mar 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118922; cv=none; b=ahypEsJIHzVPRazRS25Yb0CHLCz0TJHLfdGaIot8ahuXyJ3x5/4KZxITT+Oh8ju3lFGZDcWxCXa3BHQDx6mcOR13VyNIf4KPio3VDiU3ozG2uFrLg1mBsit5GzCoFCBJurvroLyg+9XQslAu5czlxynxkyp2UhUus5CiioN+8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118922; c=relaxed/simple;
	bh=0KqYfsYZSrdbkM8KdcIEsgjriIC0RDC3XteXsTKk2Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIfqyyxUyzK2O2gcsGczlTi1vAxI+4BmTrbkFV/553uGBV7EaIbmkxGBSi8oslN2CSFvsnUtBU7UEkrZYUCCGnI7CS3x06h/sVQQSYM05ETmrWtsZCakTfmGZkLcyjgifV+nUus21NnpAGB+XbJsdZNz7MaH53Ty5RWcR7lcUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FYn7oRDE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ay72O8SH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fdT3N6G5vz9tPq;
	Sat, 21 Mar 2026 19:48:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y1qDyLVTzAAF3kBioTqKGFvG6BxKpsgBu/bq6pJODo=;
	b=FYn7oRDEBCwrYZkrCRWYpAJI1xuLZ6U7BfoHrfkXLZm3aRlBTw6YLG1TPKmD/C+GmT7t/t
	kWAAdurt7tMRfM/Q6W7h/LdCrbVso0iyA/L1SbcjUi9HmvZHLHBkB2E30ohvyww0eEyVmR
	7sFyQPlh793LiiddXEgaFGFBPNW/wU1soTGyWqAUVrZjVQv8SH+vKq3IfDAu73gX2O5wUN
	MOIpEyc6AYAaH8pbBk1cVEiFXfqyi+JrP9R8RUO/wtuIKWPvWkElBmD7T9huXBqTJLUFjI
	YEtVmcLOl8VC6PBCP7EKZ5h40wLpw9lqAO+drlNPBdrsn5SlID0bb4SYg3tR4g==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y1qDyLVTzAAF3kBioTqKGFvG6BxKpsgBu/bq6pJODo=;
	b=ay72O8SHxz2ggpealUy2CYNSWSPOvCWAJ8T9BLdkQnEKStakI0x4QOD3AISK5RH9DpeocC
	BhP0e0jvrgKvZ9zP4hgBBq2yI1X8Kym/LkIAigWGyrq+Q0NiEcxhH5RuoNPyxj8j8+mrwX
	sRCZxHOjBzKtve0V64shok34zrwrnd4CGnq5pWME3WEeEJK+4CRI+VGUKwF5ICFUCBO+kC
	YeGxRM1bDBLNixuFLLYGYYOO7+76ffzXLLBV5wzH6kKRF910P4xag5mn+uVovw/g7ez2DG
	2PusE3ln+SU7u4urFuVdF3/fpjcv7bnoB3SiFFozIxFoIvleQf76Yt6mrivy2Q==
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
Subject: [net-next,PATCH v4 3/3] net: phy: realtek: Add property to enable SSC
Date: Sat, 21 Mar 2026 19:47:43 +0100
Message-ID: <20260321184815.148485-3-marek.vasut@mailbox.org>
In-Reply-To: <20260321184815.148485-1-marek.vasut@mailbox.org>
References: <20260321184815.148485-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5ef24e033605f00af06
X-MBO-RS-META: zu9h4i8taxc54bc9i8ptdxeer5m79fjq
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-270240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3C8A2E6D91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
V4: - Perform all SSC configuration before disabling CLKOUT
    - Perform all SSC configuration in the same order as in the SSC appnote
    - Rebase on current next, retest using spectrum analyzer again
---
 drivers/net/phy/realtek/realtek_main.c | 131 +++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 530b4e26d16ef..1dc64bf2ec73d 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -75,10 +75,18 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
 
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
@@ -212,6 +220,9 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_clkout_ssc;
+	bool enable_rxc_ssc;
+	bool enable_sysclk_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -275,6 +286,12 @@ static int rtl821x_probe(struct phy_device *phydev)
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
 
@@ -704,6 +721,108 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
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
+	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SCC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * Enable CLKOUT SSC using PHYCR2 bit 7 , this step is missing from the
+	 * EMI improvement parameters application note 1.2 section 2.3
+	 */
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2, RTL8211F_CLKOUT_SSC_EN);
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
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2, RTL8211F_SYSCLK_SSC_EN);
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
@@ -720,6 +839,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = rtl8211f_config_rxc_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_sysclk_ssc(phydev);
+	if (ret)
+		return ret;
+
+	ret = rtl8211f_config_clkout_ssc(phydev);
+	if (ret)
+		return ret;
+
 	ret = rtl8211f_config_clk_out(phydev);
 	if (ret) {
 		dev_err(dev, "clkout configuration failed: %pe\n",
-- 
2.53.0


