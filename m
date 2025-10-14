Return-Path: <netdev+bounces-229047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C0BD781C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291574E7271
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10357308F09;
	Tue, 14 Oct 2025 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVw2TnHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D92253A1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421755; cv=none; b=cAb1ZUX2WznEFgqrHPJsgB0wlnyqe52vu3p3IWJO1YC2Dcv53pa+A03v1+bxwD6fAECnGssKYbJkYqAiWogExIpaY3kkZ98F1MKMoRKdzelCRljuvOqTj1a2HxDpyWOvZD+SV1GS3w2SiQ5elsYO0QOzKCnSyJGS81YHXkfrxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421755; c=relaxed/simple;
	bh=+WvPH/mTUVsGMPv5CMilL+BtFHN+XNHyFqUjLMz9ufI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DLUZ/GBTPCYSDzHk/5VtE/8H/C7udGqFFdSm56WuEs5tA/DF0s5q0TrNu5l6lm0k+1a08eabYqVADfy6LjwSwS8R9+lZjGo25OQgwdpD4mzijCz3sXr2h3h3LVADqFy7Yd39AltMXFX2scjnLBvD6YOU5KvLayktBRbHeUgwOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVw2TnHv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso7246388a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421752; x=1761026552; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxIuoKPmbsQGFRUq9Uz0pwlu09QSHSAsCPW55HSmNHs=;
        b=gVw2TnHvZh8h+qk/p5y6yWJhMozPafYfOCm6jEHOdhTx0xklB3N10G+wuQGmTWFNTY
         3KHhqnaNMAIuBHq+2xMs0kkwCgsxNahA+B4BEcVHEq+dBK7kbkQvA1J8/6J/qcbRc0T2
         HgFMbw1Fk1KB0zDRPqRDmNNnz4/+W2A6wWiPlJv4E0byJlkhS/fdSqAXeTRx2DHamvGn
         vVDPUe/1NyM+bIFvzItn1sC+dw75viaPiAhUqDEGMSwpclVrki4WTmNOjs/r70X6XDpa
         Pr++CYoOlbV2nJUaGoIb0k9mGZu10yiQ3FJwmXMjmHu0/JbpYgKh3zLnhQntmEZsnB9p
         pC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421752; x=1761026552;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxIuoKPmbsQGFRUq9Uz0pwlu09QSHSAsCPW55HSmNHs=;
        b=i7TFlLn82vWAEt9cg6kJUiLCUDyhQvgBQRURgZnnkVUHExZqetCMpSKWKHJyIRBqX7
         ivv2Xxl/D5qtGAUT81j1yBpKAz3WKcYWlgYVDefDDjZ2S0+7DZ6GsPYX9prKNXtCc78J
         alLqqlyAJLhnTy1VQpAuD2G8HXMbQIx71pJJtiGd/ujYdbgWY5I3tfKq/aDO3Z/WnvYp
         iqrq3tEe6GS3hJX+WcIYwGOUCu6mZMq93x3NLqXGqxQquRiPXxz8OeGTrr74tOIJWYGh
         f2saJXD/VETcHdVah0Ai+Wa7F/88TFCgLlS2RoQru6FzDSt8ogVcSUO9dN4Ttqhk1tMw
         KENQ==
X-Gm-Message-State: AOJu0YybUg6eAZNxRT/tYCOX+D6XG2Xd4fHwqBmQ1nUXXApxqThFQCzH
	kAohq2VQBY00PbA5MYpKjTMvp9XAIGy53wcZEwPnRT9OhPfWF4WRu4auuAPsfQ==
X-Gm-Gg: ASbGncs/nJCvNStMxR22onlkb6WyO63uXEKCxzt6hyjl5bPaaw+9en9YBuBnLP5KXpC
	uhBHj0bSud5NyfNXlp1CpDZ+rAVcmYmiFDKWXutT3bRgTDKnRqBjpr90vgpsyWLuNQHH5bhkMgF
	OPuDfQciy3w8Ghw1TfWbLujKxEFdx7K/rgIdP+LCkLaQFhSKbifiELpxu8uPOkWTpl2CYYuAdUe
	I3Y0TTnRC8uGhObTGFy2OIq1l3v2/x1B/yHevxUkf4EwU8CsAkX2u5cNM2KDNCiWJdnhFy6K06T
	XoQRlmU7WOYrL7NcvWGTLjUUCGFLYW4oEF+fjIIgeFnmzpH/09aO2syzLfeD1G+joujGw/h7t+z
	ad331VJs4uVtJKd4sSOeW1vbdVdJ5c7KEkDM+/h1r/8yOUK0n/FH/sLIqFW1mZnsGpP3qQeFJy4
	ww33ZXyd44j5kfm9E7byD5es/PvdiClbDGtbH/ugLLcr85qgdzB93b0jRYynKcSndW06R+4LR3N
	ISdhQ5g
X-Google-Smtp-Source: AGHT+IGR0EearOhxXIr0J+wNFghRbIPnFCvYklBmj3prjq+bOqw1A+0PGFFoJ9k9+Rf79uEZnCdRaA==
X-Received: by 2002:a05:6402:2787:b0:639:e04d:b0c4 with SMTP id 4fb4d7f45d1cf-639e04db4dbmr19356514a12.33.1760421752057;
        Mon, 13 Oct 2025 23:02:32 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f27:2e00:4c84:392f:3bb3:e763? (p200300ea8f272e004c84392f3bb3e763.dip0.t-ipconnect.de. [2003:ea:8f27:2e00:4c84:392f:3bb3:e763])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-63b616d12fesm9868669a12.24.2025.10.13.23.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:02:31 -0700 (PDT)
Message-ID: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
Date: Tue, 14 Oct 2025 08:02:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: bcmgenet: remove unused platform code
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This effectively reverts b0ba512e25d7 ("net: bcmgenet: enable driver to
work without a device tree"). There has never been an in-tree user of
struct bcmgenet_platform_data, all devices use OF or ACPI.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 MAINTAINERS                                   |  1 -
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 20 ++---
 drivers/net/ethernet/broadcom/genet/bcmmii.c  | 75 +------------------
 include/linux/platform_data/bcmgenet.h        | 19 -----
 4 files changed, 7 insertions(+), 108 deletions(-)
 delete mode 100644 include/linux/platform_data/bcmgenet.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 07363437c..cf00f6327 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5111,7 +5111,6 @@ F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
 F:	drivers/net/ethernet/broadcom/genet/
 F:	drivers/net/ethernet/broadcom/unimac.h
 F:	drivers/net/mdio/mdio-bcm-unimac.c
-F:	include/linux/platform_data/bcmgenet.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 
 BROADCOM IPROC ARM ARCHITECTURE
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 98971ae4f..d99ef92fe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -35,7 +35,6 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/phy.h>
-#include <linux/platform_data/bcmgenet.h>
 
 #include <linux/unaligned.h>
 
@@ -3926,7 +3925,6 @@ MODULE_DEVICE_TABLE(of, bcmgenet_match);
 
 static int bcmgenet_probe(struct platform_device *pdev)
 {
-	struct bcmgenet_platform_data *pd = pdev->dev.platform_data;
 	const struct bcmgenet_plat_data *pdata;
 	struct bcmgenet_priv *priv;
 	struct net_device *dev;
@@ -4010,9 +4008,6 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		priv->version = pdata->version;
 		priv->dma_max_burst_length = pdata->dma_max_burst_length;
 		priv->flags = pdata->flags;
-	} else {
-		priv->version = pd->genet_version;
-		priv->dma_max_burst_length = DMA_MAX_BURST_LENGTH;
 	}
 
 	priv->clk = devm_clk_get_optional(&priv->pdev->dev, "enet");
@@ -4062,16 +4057,13 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (device_get_phy_mode(&pdev->dev) == PHY_INTERFACE_MODE_INTERNAL)
 		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
 
-	if (pd && !IS_ERR_OR_NULL(pd->mac_address))
-		eth_hw_addr_set(dev, pd->mac_address);
-	else
-		if (device_get_ethdev_address(&pdev->dev, dev))
-			if (has_acpi_companion(&pdev->dev)) {
-				u8 addr[ETH_ALEN];
+	if (device_get_ethdev_address(&pdev->dev, dev))
+		if (has_acpi_companion(&pdev->dev)) {
+			u8 addr[ETH_ALEN];
 
-				bcmgenet_get_hw_addr(priv, addr);
-				eth_hw_addr_set(dev, addr);
-			}
+			bcmgenet_get_hw_addr(priv, addr);
+			eth_hw_addr_set(dev, addr);
+		}
 
 	if (!is_valid_ether_addr(dev->dev_addr)) {
 		dev_warn(&pdev->dev, "using random Ethernet MAC\n");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 573e8b279..ce60b7330 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
-#include <linux/platform_data/bcmgenet.h>
 #include <linux/platform_data/mdio-bcm-unimac.h>
 
 #include "bcmgenet.h"
@@ -436,23 +435,6 @@ static struct device_node *bcmgenet_mii_of_find_mdio(struct bcmgenet_priv *priv)
 	return priv->mdio_dn;
 }
 
-static void bcmgenet_mii_pdata_init(struct bcmgenet_priv *priv,
-				    struct unimac_mdio_pdata *ppd)
-{
-	struct device *kdev = &priv->pdev->dev;
-	struct bcmgenet_platform_data *pd = kdev->platform_data;
-
-	if (pd->phy_interface != PHY_INTERFACE_MODE_MOCA && pd->mdio_enabled) {
-		/*
-		 * Internal or external PHY with MDIO access
-		 */
-		if (pd->phy_address >= 0 && pd->phy_address < PHY_MAX_ADDR)
-			ppd->phy_mask = 1 << pd->phy_address;
-		else
-			ppd->phy_mask = 0;
-	}
-}
-
 static int bcmgenet_mii_wait(void *wait_func_data)
 {
 	struct bcmgenet_priv *priv = wait_func_data;
@@ -467,7 +449,6 @@ static int bcmgenet_mii_wait(void *wait_func_data)
 static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 {
 	struct platform_device *pdev = priv->pdev;
-	struct bcmgenet_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *dn = pdev->dev.of_node;
 	struct unimac_mdio_pdata ppd;
 	struct platform_device *ppdev;
@@ -511,8 +492,6 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	ppdev->dev.parent = &pdev->dev;
 	if (dn)
 		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
-	else if (pdata)
-		bcmgenet_mii_pdata_init(priv, &ppd);
 	else
 		ppd.phy_mask = ~0;
 
@@ -594,58 +573,6 @@ static int bcmgenet_mii_of_init(struct bcmgenet_priv *priv)
 	return 0;
 }
 
-static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
-{
-	struct device *kdev = &priv->pdev->dev;
-	struct bcmgenet_platform_data *pd = kdev->platform_data;
-	char phy_name[MII_BUS_ID_SIZE + 3];
-	char mdio_bus_id[MII_BUS_ID_SIZE];
-	struct phy_device *phydev;
-
-	snprintf(mdio_bus_id, MII_BUS_ID_SIZE, "%s-%d",
-		 UNIMAC_MDIO_DRV_NAME, priv->pdev->id);
-
-	if (pd->phy_interface != PHY_INTERFACE_MODE_MOCA && pd->mdio_enabled) {
-		snprintf(phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT,
-			 mdio_bus_id, pd->phy_address);
-
-		/*
-		 * Internal or external PHY with MDIO access
-		 */
-		phydev = phy_attach(priv->dev, phy_name, pd->phy_interface);
-		if (IS_ERR(phydev)) {
-			dev_err(kdev, "failed to register PHY device\n");
-			return PTR_ERR(phydev);
-		}
-	} else {
-		/*
-		 * MoCA port or no MDIO access.
-		 * Use fixed PHY to represent the link layer.
-		 */
-		struct fixed_phy_status fphy_status = {
-			.link = 1,
-			.speed = pd->phy_speed,
-			.duplex = pd->phy_duplex,
-			.pause = 0,
-			.asym_pause = 0,
-		};
-
-		phydev = fixed_phy_register(&fphy_status, NULL);
-		if (IS_ERR(phydev)) {
-			dev_err(kdev, "failed to register fixed PHY device\n");
-			return PTR_ERR(phydev);
-		}
-
-		/* Make sure we initialize MoCA PHYs with a link down */
-		phydev->link = 0;
-
-	}
-
-	priv->phy_interface = pd->phy_interface;
-
-	return 0;
-}
-
 static int bcmgenet_mii_bus_init(struct bcmgenet_priv *priv)
 {
 	struct device *kdev = &priv->pdev->dev;
@@ -656,7 +583,7 @@ static int bcmgenet_mii_bus_init(struct bcmgenet_priv *priv)
 	else if (has_acpi_companion(kdev))
 		return bcmgenet_phy_interface_init(priv);
 	else
-		return bcmgenet_mii_pd_init(priv);
+		return -EINVAL;
 }
 
 int bcmgenet_mii_init(struct net_device *dev)
diff --git a/include/linux/platform_data/bcmgenet.h b/include/linux/platform_data/bcmgenet.h
deleted file mode 100644
index d8f873862..000000000
--- a/include/linux/platform_data/bcmgenet.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_PLATFORM_DATA_BCMGENET_H__
-#define __LINUX_PLATFORM_DATA_BCMGENET_H__
-
-#include <linux/types.h>
-#include <linux/if_ether.h>
-#include <linux/phy.h>
-
-struct bcmgenet_platform_data {
-	bool		mdio_enabled;
-	phy_interface_t	phy_interface;
-	int		phy_address;
-	int		phy_speed;
-	int		phy_duplex;
-	u8		mac_address[ETH_ALEN];
-	int		genet_version;
-};
-
-#endif
-- 
2.51.0


