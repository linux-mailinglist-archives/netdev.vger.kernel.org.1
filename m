Return-Path: <netdev+bounces-65247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0E839B97
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E0AB22883
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE84F206;
	Tue, 23 Jan 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H462F2bG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6F48CCF
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047047; cv=none; b=DHwx2Tz6yf8ZwALLu0bGg5CCxt9m9kRyaSw4nLCYQlLNMPVlA53A8S6iYXcYuiTxQlNLj+PGTWn9bZ6AgmZRPoK3ViC1VM/hOBN2sKnt9vIJT2ZNMTJbrJ2VGyTXyq3XNZHpyJpPsNIIxgXlvIdSLiPn9x/A75+D0oUtH75wDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047047; c=relaxed/simple;
	bh=w74fOcwrINSkbZMdiX9RtKnM4jtf3uz6a5JcZn2ZHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyAhSiTEyapwhXPoTgf/+cvbaYR7F9e7QqG7xOxM+MatTVkVmzNXjURJNfkTWjUJdU4PoSoNnLoWumxF6s+GeXD1mIZcCWul8UolkNBmjQCjjM8mvaUCDa6Uoyjb2RpC9azhvvEXVFMjTv9HLEQu3nzUNGl+AQrWp5Y+0w4EUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H462F2bG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71207524dso19774495ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047044; x=1706651844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up5tu1AXyDQ5HW0X8xCfGNx0W8oL51e+Y390jsXpzwI=;
        b=H462F2bG8RIcLGZD0/yWofuAe+/P4EreluhUMX8QOJFfGnZbNvrP7EPB/1v38wVbBF
         041mZ5rE2D7HylkovyB40AWocdATIDTwn6n/WN+GecHuQBWg4BoMG21uwzwwmxRX4ZYC
         zdeaPDIEzfI25Cho4wlAxupdmtK8DpDDDsQnNGbrmtCPZHyXipsyKuT1HROl5SKEShYY
         ZQtkx+LXV1/tLIJzoyQjmxnFu+E+d+R2vZ3djph1n4s6GdE4C5kPUTs+RS9JdSl0af66
         mlXFca8Z3Vg2+IGR51YWSMEMKoC/z9xgI9MMzz3nf6ZjOT2Gb/XyQvdoBcl1sRyEtz1i
         UuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047044; x=1706651844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up5tu1AXyDQ5HW0X8xCfGNx0W8oL51e+Y390jsXpzwI=;
        b=MhubvjidXeW8HrCgG0TORIQr5G8wE0mFsu1CL3BR87CRSUzAAbzV4XwgaXDMl9D/+/
         zJZyeOUP2pqxD59tvicEzyqpzM3+oLAPidlmLXG+4n7ZjLFmASAuGf4l6x5YcMLbCrV7
         onKUHg5ZFl+/9CtMvSDGbxUW3c/k50EBM3OWIhvGZzdnME8Uk+NVi4J0Z+SJ0n7a+ZHJ
         48pN7P3x7WwzK57MCGnnVH9BFFo7upWsxLoR6zAAA12tEnEUAIPX0+kQJUdcTAvLSdqS
         MqfSSeubDck7desHKErfCRe2qFV1EXEBcxIobooEcT5zBFzPmyvX/iZUfN3bJ8pSKD8Y
         Pq+A==
X-Gm-Message-State: AOJu0YzR+0O7kpN9pErb9lo7STTrOaqYj1nWAMJE4xkEq2AypdfwE40s
	dJo0PPkCgq86sPZDxbzdeHi/PH4jGEXvzkN2JS2LDXI/K8KyQwiuhG64/RLburQ=
X-Google-Smtp-Source: AGHT+IF28k30B49XISUgaqwcAVHeYaS8ehw/hVXw90mf7T16C4QAsN7Z704hTrGtuPRsk4TOo+nvXg==
X-Received: by 2002:a17:902:ea01:b0:1d3:eea7:9268 with SMTP id s1-20020a170902ea0100b001d3eea79268mr5176227plg.97.1706047044326;
        Tue, 23 Jan 2024 13:57:24 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:23 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus setup
Date: Tue, 23 Jan 2024 18:56:00 -0300
Message-ID: <20240123215606.26716-9-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123215606.26716-1-luizluca@gmail.com>
References: <20240123215606.26716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The line assigning dev.of_node in mdio_bus has been removed since the
subsequent of_mdiobus_register will always overwrite it.

ds->user_mii_bus is not assigned anymore[1]. It should work as before as
long as the switch ports have a valid phy-handle property.

Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
to mdiobus"), we can put the "mdio" node just after the MDIO bus
registration. The switch unregistration was moved into
realtek_common_remove() as both interfaces now use the same code path.

[1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
 drivers/net/dsa/realtek/realtek-smi.c  | 15 ++-------------
 drivers/net/dsa/realtek/rtl83xx.c      |  2 ++
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 0171185ec665..c75b4550802c 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -158,11 +158,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
-	if (!priv)
-		return;
-
-	dsa_unregister_switch(priv->ds);
-
 	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 0ccb2a6059a6..a89813e527d2 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -331,7 +331,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv =  ds->priv;
 	struct device_node *mdio_np;
-	int ret;
+	int ret = 0;
 
 	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
@@ -344,15 +344,14 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		ret = -ENOMEM;
 		goto err_put_node;
 	}
+
 	priv->user_mii_bus->priv = priv;
 	priv->user_mii_bus->name = "SMI user MII";
 	priv->user_mii_bus->read = realtek_smi_mdio_read;
 	priv->user_mii_bus->write = realtek_smi_mdio_write;
 	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
 		 ds->index);
-	priv->user_mii_bus->dev.of_node = mdio_np;
 	priv->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus = priv->user_mii_bus;
 
 	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
 	if (ret) {
@@ -361,8 +360,6 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		goto err_put_node;
 	}
 
-	return 0;
-
 err_put_node:
 	of_node_put(mdio_np);
 
@@ -434,14 +431,6 @@ void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
-	if (!priv)
-		return;
-
-	dsa_unregister_switch(priv->ds);
-
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
 	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 3d07c5662fa4..53bacbacc82e 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -190,6 +190,8 @@ void rtl83xx_remove(struct realtek_priv *priv)
 	if (!priv)
 		return;
 
+	dsa_unregister_switch(priv->ds);
+
 	/* leave the device reset asserted */
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
-- 
2.43.0


