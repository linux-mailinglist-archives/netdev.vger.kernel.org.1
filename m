Return-Path: <netdev+bounces-231568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18CBFA9EE
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EE9421B9A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF892FD68F;
	Wed, 22 Oct 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M5W3DVxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154902FCBF7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118727; cv=none; b=cM+uCTg6wlzIXdLcXhfWyG2Z7PYBIlFbptecLKdDBv/ulHOCeJjnI6l7kAG/Br5UxNpUcXo4U7qlCU5CE7Ymn/6KKbVpHBoFVKuJJYc9ZhKGYqFETBbqaOcAFihNW6VAPDo/q7WENovS4gQ52qzXAwp3WPWowab12y9COhucBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118727; c=relaxed/simple;
	bh=1ZeIIsp8tJcHFQgz2Xfvqz7CZIB2p2BXgkSO/2IVTog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixkTR3sa7Dj5sWPZpVPu11O+zFuE3GHhfLrtNBj4Hw+ZS7tqBqpdy2MpPkSnO71gOgxV+rY5YYVv01yTYFdOwmtSjwI3MrQvm7jmUSRrCS23SPQg1nXunIl+tz/W2XqWa9chPljqBcUQ6jZsqbLQfvf68nGtQP/7Nd5zxX9H4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M5W3DVxt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DF657C0B8B9;
	Wed, 22 Oct 2025 07:38:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F65D606DC;
	Wed, 22 Oct 2025 07:38:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2841E102F242A;
	Wed, 22 Oct 2025 09:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZZVaF5BoYgXRmfee23HnDH9NWUBGz7WnOPiHHT4qsbo=;
	b=M5W3DVxtTPW4ls9GZh6bRhB2ZbmMT71AAQO4/IdCCAKp6t+hq2RgM2GkQ1vYqFQSX7uxH5
	Rg8WZoepgg1vQAWIaXMoeHeFkkRjcIk+EVUnlNyVhsY+4lUnnSsdBjLo17vXU6Rf4jJzZl
	t/oiIBtTEPx16xIo6pQwudCoYgEDeyz9ymdriOcXXQjx9MDqBWswcRH5/4ufnAMujXuI3S
	YLtdF5wSGf4GK6M5DbuzWc6CdwKESykkLre3ktSGgBhLpC/ktYr49aCVHHJt8lbPTWYZJX
	DOoygNMoAPyNBC4FTFryRBOcJBCBxD0XOuHrFPtgk+IEmymMupbxyqMT3n/IBQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 22 Oct 2025 09:38:14 +0200
Subject: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
In-Reply-To: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
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

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 914677f30f2c..c45c6a7f42e6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2963,6 +2963,10 @@ static int macb_open(struct net_device *dev)
 
 	macb_init_hw(bp);
 
+	err = phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface);
+	if (err)
+		goto reset_hw;
+
 	err = phy_power_on(bp->phy);
 	if (err)
 		goto reset_hw;
@@ -5187,6 +5191,28 @@ static int init_reset_optional(struct platform_device *pdev)
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
@@ -5341,6 +5367,17 @@ static const struct macb_config versal_config = {
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
@@ -5372,6 +5409,7 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
+	{ .compatible = "mobileye,eyeq5-gem", .data = &eyeq5_config },
 	{ .compatible = "raspberrypi,rp1-gem", .data = &raspberrypi_rp1_config },
 	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
 	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },

-- 
2.51.1


