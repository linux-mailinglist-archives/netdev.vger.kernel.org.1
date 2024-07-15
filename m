Return-Path: <netdev+bounces-111441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73C931019
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D321F2204B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03618628C;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5y9Gi9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839ED185E7F;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032804; cv=none; b=Y00tHAaSV8PEnJvE7bFfe0Z/4e/Fxj++9ILf894/uvPL5xBFdubk6KLjExoHAwBOpNyzn7BxHxx6TWYDAJo1JMrekBCzeTB4E+oWeJwDscdXFPhpw0QFAWvMYr2L7NJvUJSwhRqcyMHGlfdpQsRQdtDncnnyvAnVX06Svv5o2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032804; c=relaxed/simple;
	bh=hu+7JHtL6Prd6V/S2TJxZvc5nnlMUcfi+uYAd+zwbqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4lsb0r7FCxQSsXBMuUG9a69qLIpqoP3E30/TvazF031YYkad3twv0OgnzYfK2hOez5FOt3Lzo5xamwsK5jcc2mtVAsc883fE7eVf+4Nmv7PZZNFFBK+Y85S4bT2WNwA1PNrQHo8nPyAI34oHLWSA1YwvjtGMoiPkVLMdCHn8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5y9Gi9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D36C3C4DE07;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032803;
	bh=hu+7JHtL6Prd6V/S2TJxZvc5nnlMUcfi+uYAd+zwbqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m5y9Gi9NoHE9iAcMYXWAerQd7GwouDwHIAA/bSsxf7m1cMcDZ7FIgaU4KENubXCjp
	 KW01Vx/KE/Cvy5HxNU67NROWO7k9Ay4e5wdAkYRCd+PskOFKRbFW6FHTvKxtEiQMIe
	 jwwzCO3bdX+P4PhCL4PtQCepXJfNvdZj9fdfb9QvNVIIWXouNgov8B8wFFCJShbUmM
	 26V4VeNjxOWbdTBK6AF1fuRWp/aoyqcGJx5VD14LR2OXT9nkD4WExsqwT1Be0t1yBh
	 X0MBpNhexEfuZdBlnMlTszTJvzghW2Xfoo2xRx72B+CQfDvtkeCekR7haQj74bY+EX
	 BbgeP+0ajWgQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8896C2BD09;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:21 +0300
Subject: [PATCH v11 17/38] net: cirrus: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-17-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=4277;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=b1GOTD5HubzYgxiOB7lYJxNswjw8j/5q0+HrSptbhew=;
 b=rKabVJ2eVAk5cAgCA0iDMlooaUUDvBHdd9owdLmcit71rrco09VSAxRewR9Sddc4di01P3+XGmus
 GH3En/IxBnWAKgdyOQh0k5hpONEAaIsyEga8q4Sns4B8lPrZViVE
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

- add OF ID match table
- get phy_id from the device tree, as part of mdio
- copy_addr is now always used, as there is no SoC/board that aren't
- dropped platform header

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 63 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 1f495cfd7959..2523d9c9d1b8 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -16,13 +16,12 @@
 #include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <linux/platform_data/eth-ep93xx.h>
-
 #define DRV_MODULE_NAME		"ep93xx-eth"
 
 #define RX_QUEUE_ENTRIES	64
@@ -738,25 +737,6 @@ static const struct net_device_ops ep93xx_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
-static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
-{
-	struct net_device *dev;
-
-	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
-	if (dev == NULL)
-		return NULL;
-
-	eth_hw_addr_set(dev, data->dev_addr);
-
-	dev->ethtool_ops = &ep93xx_ethtool_ops;
-	dev->netdev_ops = &ep93xx_netdev_ops;
-
-	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
-
-	return dev;
-}
-
-
 static void ep93xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
@@ -786,27 +766,47 @@ static void ep93xx_eth_remove(struct platform_device *pdev)
 
 static int ep93xx_eth_probe(struct platform_device *pdev)
 {
-	struct ep93xx_eth_data *data;
 	struct net_device *dev;
 	struct ep93xx_priv *ep;
 	struct resource *mem;
+	void __iomem *base_addr;
+	struct device_node *np;
+	u32 phy_id;
 	int irq;
 	int err;
 
 	if (pdev == NULL)
 		return -ENODEV;
-	data = dev_get_platdata(&pdev->dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!mem || irq < 0)
 		return -ENXIO;
 
-	dev = ep93xx_dev_alloc(data);
+	base_addr = ioremap(mem->start, resource_size(mem));
+	if (!base_addr)
+		return dev_err_probe(&pdev->dev, -EIO, "Failed to ioremap ethernet registers\n");
+
+	np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
+	if (!np)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Please provide \"phy-handle\"\n");
+
+	err = of_property_read_u32(np, "reg", &phy_id);
+	of_node_put(np);
+	if (err)
+		return dev_err_probe(&pdev->dev, -ENOENT, "Failed to locate \"phy_id\"\n");
+
+	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
 	if (dev == NULL) {
 		err = -ENOMEM;
 		goto err_out;
 	}
+
+	eth_hw_addr_set(dev, base_addr + 0x50);
+	dev->ethtool_ops = &ep93xx_ethtool_ops;
+	dev->netdev_ops = &ep93xx_netdev_ops;
+	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
+
 	ep = netdev_priv(dev);
 	ep->dev = dev;
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -822,15 +822,10 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	ep->base_addr = ioremap(mem->start, resource_size(mem));
-	if (ep->base_addr == NULL) {
-		dev_err(&pdev->dev, "Failed to ioremap ethernet registers\n");
-		err = -EIO;
-		goto err_out;
-	}
+	ep->base_addr = base_addr;
 	ep->irq = irq;
 
-	ep->mii.phy_id = data->phy_id;
+	ep->mii.phy_id = phy_id;
 	ep->mii.phy_id_mask = 0x1f;
 	ep->mii.reg_num_mask = 0x1f;
 	ep->mii.dev = dev;
@@ -857,12 +852,18 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct of_device_id ep93xx_eth_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-eth" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_eth_of_ids);
 
 static struct platform_driver ep93xx_eth_driver = {
 	.probe		= ep93xx_eth_probe,
 	.remove_new	= ep93xx_eth_remove,
 	.driver		= {
 		.name	= "ep93xx-eth",
+		.of_match_table = ep93xx_eth_of_ids,
 	},
 };
 

-- 
2.43.2



