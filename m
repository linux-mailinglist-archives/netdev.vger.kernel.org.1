Return-Path: <netdev+bounces-104607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E6290D9D7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8284CB36B47
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979F7768E1;
	Tue, 18 Jun 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyDAb0pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A174D8AE;
	Tue, 18 Jun 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727260; cv=none; b=E6R7tTXXexLmccCYJC5d5m9Q/K+6SZxY/oDL/xTxl2qJUjVYBym3rBmtFc7nr2DbV9o/sfKhJzhfhz/7iC4Fwc0nBx9dXOirrN3Tc+kXo64sZpb+h1Og7exqcvyyjh/8rkgzSoJtBOhe0pumrv0ykagV8MYRei/5n+0phnMftNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727260; c=relaxed/simple;
	bh=5Vz9jlrwAmFS/i7i4UdpG/kbUUAplJoY3vdQYb/FEG0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KPFJHn9q6VXyKULU3biTVx9B/APsOTACHNxW46cWN39vCRUv8v7iH/0eKxIwIZThN+zirCSIQjrrT+Lkzyn89EfgLK8XFyaPrKFGzrDouepOGqU2pq7UG8OeiRpnyEbTx1KV+Zu55DGmXLdUVi4ZN+Pd9+I/SVgQacsy5sqcZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyDAb0pf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso6587535a12.2;
        Tue, 18 Jun 2024 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718727257; x=1719332057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MHpqHwSy4KYPzb2c3Q3KXN0Mser02EbTTG6K/yRuAZs=;
        b=gyDAb0pfZ1M0Gv7GNwdDJCGcUyLIljET4oMRNJ5NX9m7HUGMAVTS/VqAV89vOkeBHI
         bm2PvC8Fp7fGlipS6Z8Q+qGvw8lPdr9836yJRN9dXcJO+vhHGf1Wl2HHuUSVoSur92KT
         s0g7Btc4Mf2KsnzEkOT2mp6NtIgSJY3W6EMAeWCF/Rj86P2IjvbER3cEn8kYzfbCRLR3
         UuE4mJA4s81IwWcCPsyLAyBekLvzNaBM8MS9ScizNdOGqsFPoQNVYdrFrUCT1dvh4udW
         5+Hho8e0w0Uf69JdQlmv/BJcAMlfgI9aB5oFuRoDoheV1/4c//iZsFXqGX5TfxwaPWjL
         b5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718727257; x=1719332057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHpqHwSy4KYPzb2c3Q3KXN0Mser02EbTTG6K/yRuAZs=;
        b=CnmGRJQywy8ZS8JMuw8JBhVE7LjiZaxB8PIcH4p1sIm5Kq6uAbCbCLfhyyDo+uunL1
         2KpberKGp/5EcmnByAyJcj7aKcpAdO48FAqwg/PaG2GtmamVdfIGlm0WdQyFlSbh3Ruz
         7HTnXEmVshUpt0KIEXtqWi32gMz+Z0daRGJ6GRhRIH/TVgjC0YIS5rFAg0nrFXYVSV+O
         6QhN7UYZnlRWWvj81tbezPvp72rjMA0b/uTltb3MoOle/3gQKtVBvXDJGqMM0XRgkjN+
         PRX6OkKDg8NgaR+riH5G5IYU0HdSuQ9Eb1PqV+42EeLllY5KprL79cpLuvRElKHgNMIo
         OrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyiFhnnLZt77bcbCfuDoAcY6us3z3uNrUGNeHLtm489GDpIP+GTY4V5DoI/FQf/wnxoMqyY9Mipd2ZOxMI6n/Ltz5YmWiVVnVyfYE1ovrcVyH+QYu8adPIjhJNKOhHwE2ay/hFL8UW7TUMK0iSOltu3Hc+qiK/Wu5N4yqM2slhjQ==
X-Gm-Message-State: AOJu0YzU5lCLDQUiHM9PJOGRI5LFP4/q7aVxzpTHayCG02z3H+JL5YUQ
	RzfiVoqOtGMXU8N9gcoIGzD3cEdOSzr8np/oG+GquGivBG05wPN9
X-Google-Smtp-Source: AGHT+IF4qoy4FyZNZ33sBu4xEJ8HsHgXiY6yT6ylLh0f4gldGPhBoCPwJwT5u2HAE/GzMi5jYzStSw==
X-Received: by 2002:a50:bb4b:0:b0:57c:f091:f607 with SMTP id 4fb4d7f45d1cf-57cf091f624mr3009163a12.29.1718727256750;
        Tue, 18 Jun 2024 09:14:16 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e992dsm7870062a12.48.2024.06.18.09.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 09:14:16 -0700 (PDT)
Message-ID: <10d8576f-a5da-4445-b841-98ceb338da0d@gmail.com>
Date: Tue, 18 Jun 2024 18:14:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] net: ethernet: arc: remove emac_arc driver
To: heiko@sntech.de
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Language: en-US
In-Reply-To: <0b889b87-5442-4fd4-b26f-8d5d67695c77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The last real user nSIM_700 of the "snps,arc-emac" compatible string in
a driver was removed in 2019. The use of this string in the combined DT of
rk3066a/rk3188 as place holder has also been replaced, so
remove emac_arc.c to clean up some code.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

[PATCH 8/8] ARC: nSIM_700: remove unused network options
https://lore.kernel.org/all/20191023124417.5770-9-Eugeniy.Paltsev@synopsys.com/
---
 drivers/net/ethernet/arc/Kconfig    | 10 ----
 drivers/net/ethernet/arc/Makefile   |  1 -
 drivers/net/ethernet/arc/emac_arc.c | 88 -----------------------------
 3 files changed, 99 deletions(-)
 delete mode 100644 drivers/net/ethernet/arc/emac_arc.c

diff --git a/drivers/net/ethernet/arc/Kconfig b/drivers/net/ethernet/arc/Kconfig
index 0a67612af228..0d400a7d8d91 100644
--- a/drivers/net/ethernet/arc/Kconfig
+++ b/drivers/net/ethernet/arc/Kconfig
@@ -23,16 +23,6 @@ config ARC_EMAC_CORE
 	select PHYLIB
 	select CRC32

-config ARC_EMAC
-	tristate "ARC EMAC support"
-	select ARC_EMAC_CORE
-	depends on OF_IRQ
-	depends on ARC || COMPILE_TEST
-	help
-	  On some legacy ARC (Synopsys) FPGA boards such as ARCAngel4/ML50x
-	  non-standard on-chip ethernet device ARC EMAC 10/100 is used.
-	  Say Y here if you have such a board.  If unsure, say N.
-
 config EMAC_ROCKCHIP
 	tristate "Rockchip EMAC support"
 	select ARC_EMAC_CORE
diff --git a/drivers/net/ethernet/arc/Makefile b/drivers/net/ethernet/arc/Makefile
index d63ada577c8e..23586eefec44 100644
--- a/drivers/net/ethernet/arc/Makefile
+++ b/drivers/net/ethernet/arc/Makefile
@@ -5,5 +5,4 @@

 arc_emac-objs := emac_main.o emac_mdio.o
 obj-$(CONFIG_ARC_EMAC_CORE) += arc_emac.o
-obj-$(CONFIG_ARC_EMAC) += emac_arc.o
 obj-$(CONFIG_EMAC_ROCKCHIP) += emac_rockchip.o
diff --git a/drivers/net/ethernet/arc/emac_arc.c b/drivers/net/ethernet/arc/emac_arc.c
deleted file mode 100644
index a3afddb23ee8..000000000000
--- a/drivers/net/ethernet/arc/emac_arc.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/**
- * DOC: emac_arc.c - ARC EMAC specific glue layer
- *
- * Copyright (C) 2014 Romain Perier
- *
- * Romain Perier  <romain.perier@gmail.com>
- */
-
-#include <linux/etherdevice.h>
-#include <linux/module.h>
-#include <linux/of_net.h>
-#include <linux/platform_device.h>
-
-#include "emac.h"
-
-#define DRV_NAME    "emac_arc"
-
-static int emac_arc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct arc_emac_priv *priv;
-	phy_interface_t interface;
-	struct net_device *ndev;
-	int err;
-
-	if (!dev->of_node)
-		return -ENODEV;
-
-	ndev = alloc_etherdev(sizeof(struct arc_emac_priv));
-	if (!ndev)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, ndev);
-	SET_NETDEV_DEV(ndev, dev);
-
-	priv = netdev_priv(ndev);
-	priv->drv_name = DRV_NAME;
-
-	err = of_get_phy_mode(dev->of_node, &interface);
-	if (err) {
-		if (err == -ENODEV)
-			interface = PHY_INTERFACE_MODE_MII;
-		else
-			goto out_netdev;
-	}
-
-	priv->clk = devm_clk_get(dev, "hclk");
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to retrieve host clock from device tree\n");
-		err = -EINVAL;
-		goto out_netdev;
-	}
-
-	err = arc_emac_probe(ndev, interface);
-out_netdev:
-	if (err)
-		free_netdev(ndev);
-	return err;
-}
-
-static void emac_arc_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-
-	arc_emac_remove(ndev);
-	free_netdev(ndev);
-}
-
-static const struct of_device_id emac_arc_dt_ids[] = {
-	{ .compatible = "snps,arc-emac" },
-	{ /* Sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, emac_arc_dt_ids);
-
-static struct platform_driver emac_arc_driver = {
-	.probe = emac_arc_probe,
-	.remove_new = emac_arc_remove,
-	.driver = {
-		.name = DRV_NAME,
-		.of_match_table  = emac_arc_dt_ids,
-	},
-};
-
-module_platform_driver(emac_arc_driver);
-
-MODULE_AUTHOR("Romain Perier <romain.perier@gmail.com>");
-MODULE_DESCRIPTION("ARC EMAC platform driver");
-MODULE_LICENSE("GPL");
--
2.39.2


