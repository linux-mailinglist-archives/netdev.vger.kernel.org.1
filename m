Return-Path: <netdev+bounces-275496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLDCBLrw0mm5cQcAu9opvQ
	(envelope-from <netdev+bounces-275496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:31:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA83A0392
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A793006B04
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33E34EEED;
	Sun,  5 Apr 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wj/lqACU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Fcx+0IA6"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AE2DFA4A;
	Sun,  5 Apr 2026 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431832; cv=none; b=IMoW5dR19VGl65dRw9NweB1HhnKnX0z1iqzkf/Ll8FEYionQQ4CdzsfV4eDyMf7msXaZErr9KGidgJ/v7+nOLgYY80GnfZ01SmcR4TpRYRIuPUrn/O9qF2JJJ/19wC8LiT4rPiJw9kK7gdBGodwtGEPq3F7M9RXLbsEyknWug1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431832; c=relaxed/simple;
	bh=EIqS/wy299HVT+M392ZIG44fj9oaUgBGJbrmIS+sL+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMzqENProsVOCFXHDhtVrfqwI9yA9jkWP7zOmIP+Z3rm20xxt1LpgbQP8zkWoHDy/t+RGJLQCiQaZOZbuMD/bgNg1MOH0CLZIZ81E4Kkfu1l+O58sPwgTMigE53LLr5IolfWezS3Mn4RoS7nIGXxoez8m0nUGMiQ4wieW6C3IP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Wj/lqACU; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Fcx+0IA6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fppbk6770z9tYX;
	Mon,  6 Apr 2026 01:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGGs2NiaUZQb+KcVmsGvFT28sKiZnPQuwRMHoqq1xTg=;
	b=Wj/lqACUnG4kIAxPcW7+A+yICeMmvsw2I3X+0FDOXU9Zw3MHh8ypJQJJVfjjAV9r32RIRV
	uyn9veYh5QS3Qu/9ZYHiiub4zcYNfricU5EB232DzElZDm3CsSekL2fTZwG8WtvHhOkdAn
	fUpVt+U3rrp2x4MvezcuEnJ0fr3WuNHU+P1u0gsfvudQttRxRS3pcYUTyINeSb/C2Ws1pG
	wV1Q7DtxNcpm2CYLs1lW+eZCgk6HF+uVRXFZTgh/7u66ZRf5d47z4QT1p8/kmE5+szDJye
	1UTGKN1fc7Ac2ax3t3Dzv2aZfUp/WQks0Qlbp3Irb+HYWJWWumxi9UTSYvVGWw==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGGs2NiaUZQb+KcVmsGvFT28sKiZnPQuwRMHoqq1xTg=;
	b=Fcx+0IA6LSeEQrwQotf93WufKUCDlrWLj0G02aGvLIe00EBCksk+RRRd234JimiZ13i6uY
	J1T1rjWPduGNV7PliAg3+Za7MXmg+3jDKfzSujlN6puCWrCfZZ3tJzDMRxhm4Q0h2AifwH
	jKXq/h1sTGbw6GzUXV3CzJKQx8CcD9wfvhJDm45ZDHnJPdLF6B1BzikaAFz70XaQFbYhyU
	yqaXcR0Pe8AQ/V9q6lTon4HootqcyDaqrlJSkdB6mlMcKPdb6364Ukk530QgYZzhbpNqp7
	yeenAFOhy8FoR7ReOgGXXQvJLoi2/NQpOAaLTw/+/MIlAUugbXvr1ReyDpa0Aw==
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
Subject: [net-next,PATCH v6 3/3] net: phy: realtek: Add property to enable SSC
Date: Mon,  6 Apr 2026 01:29:58 +0200
Message-ID: <20260405233008.148974-3-marek.vasut@mailbox.org>
In-Reply-To: <20260405233008.148974-1-marek.vasut@mailbox.org>
References: <20260405233008.148974-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6469e66c7026fe7bb1a
X-MBO-RS-META: duksatsdw568pcyj1xcaujemr3wawfnm
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
	TAGGED_FROM(0.00)[bounces-275496-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 72EA83A0392
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
V5: s@SCC@SSC@ typo
V6: Drop RTL8211F_SSC_CLKOUT write in favor of setting PHYCR2 bit 7,12,13
---
 drivers/net/phy/realtek/realtek_main.c | 127 +++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 023e47ad605bd..f31969de3ba99 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -75,10 +75,18 @@
 
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
+#define RTL8211F_SYSCLK_SSC_EN			BIT(3)
 #define RTL8211F_PHYCR2_PHY_EEE_ENABLE		BIT(5)
+#define RTL8211F_CLKOUT_SSC_EN			BIT(7)
+#define RTL8211F_CLKOUT_SSC_CAP			GENMASK(13, 12)
 
 #define RTL8211F_INSR				0x1d
 
+/* RTL8211F SSC settings */
+#define RTL8211F_SSC_PAGE			0xc44
+#define RTL8211F_SSC_RXC			0x13
+#define RTL8211F_SSC_SYSCLK			0x17
+
 /* RTL8211F LED configuration */
 #define RTL8211F_LEDCR_PAGE			0xd04
 #define RTL8211F_LEDCR				0x10
@@ -215,6 +223,9 @@ MODULE_LICENSE("GPL");
 struct rtl821x_priv {
 	bool enable_aldps;
 	bool disable_clk_out;
+	bool enable_clkout_ssc;
+	bool enable_rxc_ssc;
+	bool enable_sysclk_ssc;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -278,6 +289,12 @@ static int rtl821x_probe(struct phy_device *phydev)
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
 
@@ -707,6 +724,104 @@ static int rtl8211f_config_phy_eee(struct phy_device *phydev)
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
+		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable CLKOUT SSC and CLKOUT SSC Capability using PHYCR2
+	 * bits 7, 12, 13. This matches the register 25 write 0x38C3
+	 * from the EMI improvement parameters application note 1.2
+	 * section 2.3, without affecting unrelated bits.
+	 */
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2,
+			   RTL8211F_CLKOUT_SSC_CAP | RTL8211F_CLKOUT_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "CLKOUT SSC enable failed: %pe\n", ERR_PTR(ret));
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
+		dev_err(dev, "RXC SSC configuration failed: %pe\n", ERR_PTR(ret));
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
+		dev_err(dev, "SYSCLK SSC configuration failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/* Enable SSC */
+	ret = phy_set_bits(phydev, RTL8211F_PHYCR2, RTL8211F_SYSCLK_SSC_EN);
+	if (ret < 0) {
+		dev_err(dev, "SYSCLK SSC enable failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -723,6 +838,18 @@ static int rtl8211f_config_init(struct phy_device *phydev)
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


