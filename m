Return-Path: <netdev+bounces-232201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB45C0270A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305273B03D0
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361B33375D;
	Thu, 23 Oct 2025 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PnZNrSW6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B9314B9D;
	Thu, 23 Oct 2025 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236606; cv=none; b=WJzh8LpvzdhxHYrEVh0veatsFRR6jczHhOEq4qH1rZVoquuzcb4LmxmHS9t2vsUEAZvsNMj7H7ssDzpJxfj1+kbybzDsEmf0ASfdldSdM7HrruPcUT9HFpqlTFh840goBp90Tc4gJPtcOiVyMTRs9hDRvAjyL7SqS3XKxiUZEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236606; c=relaxed/simple;
	bh=BoI04ne66BgdO6RQx8tLnItxQ9eDqwU1DrU84iIL4D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUKUX5uWXKmpkfwL3hBSEmIXLxQHqnO3tupba6YEz3ug4fecKpKPzsXwIaWlvN3EgcizJIcWbca3ZqILgy8ilzeD5eRer7uI0sMlOYd5AqTiwkjsTiVlmE8UzxITxzGhrCdIWp60cxEUENoSm2e85xqfPpOgrufUote8bc87qRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PnZNrSW6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A7B401A1619;
	Thu, 23 Oct 2025 16:23:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E275606DE;
	Thu, 23 Oct 2025 16:23:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50C5F102F2475;
	Thu, 23 Oct 2025 18:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761236601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZJv3iwv2xhtLbUdm9xnAIqJx8pCFt3cC26JBlEGXT88=;
	b=PnZNrSW6hlNuyaCxQD0TaSMfii29T1liLZdhZfgXwf3EEcPRWeRETPPMAKz2//807EQBkv
	MvsTg+4Kk26ZQDIvB8HX6WKG0BXY27xHD+PW6UhgWjGyZsq9DH/y0+5q99zevUaR+fX7Vu
	aCtqBK9JwqzDO4/DumTh6iW/gm22JGlfmzoUdzEvS5coJq08hUun7uyBEcX73ySQntomSf
	SAiDWTi6VglIK8NICve4GYgNtSFaYAIVJSARB9jcpD6qoArcylR5hF5/OFh6KoeRM2C/Hk
	tHQpohCaStWu6N77Nr8XbVV44WhPPLRzy7YtkHPG+poT/1Buzx8x4yp8FBxCqw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 23 Oct 2025 18:22:55 +0200
Subject: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
In-Reply-To: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
that must grab a generic PHY and initialise it.

We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
the first users of bp->phy that use it in non-SGMII cases.

The phy_set_mode_ext() call is made unconditionally. It cannot cause
issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
those cases, the call is a no-op (returning zero). From reading
upstream DTS, we can figure out that no platform has a bp->phy and a
PHY driver that has a .set_mode() implementation:
 - cdns,zynqmp-gem: no DTS upstream.
 - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
 - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
 - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
   drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 44188e7eee56..b1ed98d9c438 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2965,6 +2965,10 @@ static int macb_open(struct net_device *dev)
 
 	macb_init_hw(bp);
 
+	err = phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface);
+	if (err)
+		goto reset_hw;
+
 	err = phy_power_on(bp->phy);
 	if (err)
 		goto reset_hw;
@@ -5189,6 +5193,28 @@ static int init_reset_optional(struct platform_device *pdev)
 	return ret;
 }
 
+static int eyeq5_init(struct platform_device *pdev)
+{
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	bp->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(bp->phy))
+		return dev_err_probe(dev, PTR_ERR(bp->phy),
+				     "failed to get PHY\n");
+
+	ret = phy_init(bp->phy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init PHY\n");
+
+	ret = macb_init(pdev);
+	if (ret)
+		phy_exit(bp->phy);
+	return ret;
+}
+
 static const struct macb_usrio_config sama7g5_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5343,6 +5369,17 @@ static const struct macb_config versal_config = {
 	.usrio = &macb_default_usrio,
 };
 
+static const struct macb_config eyeq5_config = {
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
+		MACB_CAPS_NO_LSO,
+	.dma_burst_length = 16,
+	.clk_init = macb_clk_init,
+	.init = eyeq5_init,
+	.jumbo_max_len = 10240,
+	.usrio = &macb_default_usrio,
+};
+
 static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
@@ -5374,6 +5411,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
+	{ .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
 	{ .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
 	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },

-- 
2.51.1


