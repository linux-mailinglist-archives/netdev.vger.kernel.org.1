Return-Path: <netdev+bounces-65233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A8839B56
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDC11C20B53
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741B3BB38;
	Tue, 23 Jan 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWX5zCtu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51848CCC
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046305; cv=none; b=krazT4hduXFnNT5AoyRBOeaTggnJ3UFgqs7cYCqAJzG0Y7lIRCFU/q7S0c0xpxSLDWeOdT8aDJy0m0x9CpBT7mNkqavqu0TaYhkBVzJ2ffCpDZ72CzVSo6e0Yv6sEFkubcGKyWcfT/MPQDZVo16AF5xLQ1qXkRasB5/chxQlI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046305; c=relaxed/simple;
	bh=w74fOcwrINSkbZMdiX9RtKnM4jtf3uz6a5JcZn2ZHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKi1iL8A2ZEFuI5y2xAPWhy1wyVzhPXNFAa7PA0nB/ScgxQIcSDnbx/AhO+S+vX1UXdcJ1rXay9gmvX1TIXHEjqM8nmbnv9PjjZaQYrsiGlubA4JUAYJqCe6HY2XLfiUMF+Gbw3z04RZM/RaKHQYxAD5u/Biz9tTEvsRcctv440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWX5zCtu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d751bc0c15so23104225ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046302; x=1706651102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up5tu1AXyDQ5HW0X8xCfGNx0W8oL51e+Y390jsXpzwI=;
        b=ZWX5zCtubZ4Cqwj8jsp/p0PkDteviPKchRNBEwXwDBJxOOOhELlb3Luau6AF0lf/J+
         /0/1dsXURqdd+0quSUZMdkxuIJX0oN3Y6+hOXztbIZcW0n0rkgK1tQZhIQir6mRrrMQ2
         wWsXr2Mb/OB4tRC5GS0ItRKE7z6GqEcm6isvt54CZ+BF5/sXgk0cUOyeWVO3JTt3hTWa
         8oELUhKw/Yj/NS5N9jOwSMfpNVAb90wsLWOsPcp1hGpiK78HKELNfAasC1CUvcvk3mU+
         mI7uouzFTUC3cI1fxq3Zjs2/H5bQdZpdqPb9P1vEIybAkWz6n7pYI/MFqAiJpaJJ42jx
         ZMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046302; x=1706651102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up5tu1AXyDQ5HW0X8xCfGNx0W8oL51e+Y390jsXpzwI=;
        b=nnqUZCSzAZKabqZ1EpggYtxSrYSnRFldbL78CpgSEdksj7aqUO73iUTAdw0R8yJPsM
         BugXGHWwCvDtmmObGbRQHd4Ejalb0uVv0/RZ+akPxQ059/F1JgXSbRthcCh5fbQTdGzQ
         vryiVHEU+RVTpACnlOYDJIFhAWi/egJhBsHdoj7pvNzDeIKXe/7vtAczNumlM72n0PcC
         /ay5QwKuRYZ08PVS9pi4XZMEzz69kqekBYhX5MOteQ3NNuuRcQ+hPt+2q7U5mT91nC/L
         FrVFYyRvFFzib/xdjwBG6nwsTINdyHf9XAg0yDCqGPFJLne58ev+MFzh4VzKmJKZmgxr
         MqKQ==
X-Gm-Message-State: AOJu0YxDvKzXfQzA65SHvr3F0RBG+Aar/FgGsQ8v2V0zqi0vGMyHzU4c
	drb51tqZCe0sr8SxdW/JfzZzJhvxAZedYt/W1EW6zxb8WNj9tQxwhbKUOKwaR5w=
X-Google-Smtp-Source: AGHT+IFD/6YmHn07zUaV+BjpIlDtRD/1KzfQfLAXvDHzLvjpCPOqHPzGioDV/W3DK6Kq4quiA/0D5g==
X-Received: by 2002:a17:902:db02:b0:1d7:467b:f488 with SMTP id m2-20020a170902db0200b001d7467bf488mr5648466plx.114.1706046302192;
        Tue, 23 Jan 2024 13:45:02 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:45:01 -0800 (PST)
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
Subject: [PATCH 08/11] net: dsa: realtek: clean user_mii_bus setup
Date: Tue, 23 Jan 2024 18:44:16 -0300
Message-ID: <20240123214420.25716-9-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
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


