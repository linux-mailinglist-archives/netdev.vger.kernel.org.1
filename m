Return-Path: <netdev+bounces-65248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDF839B98
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30EA28BBCD
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6E4CB4C;
	Tue, 23 Jan 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGn5p1LO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FC48CC5
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047052; cv=none; b=Zq2mxN6gC/ZC75b1hOBngGTcWJa1KYOgJ4BwOHgOTiX7D224dTnxo+GDpqKe8nOT/EWRNIoQfVOYT8dJB+VCkSGElRNYMNuD/xcHgcuvCXcPk4/OoYCEhyFq/KJTrrM7cQYFTn9tnQvppvljIJK+zqB+V7F+64hUwu625TL/Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047052; c=relaxed/simple;
	bh=J3Nh1N/06LdYOJxcnZT42tewbtJ1miuDdNVw8UlyqGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSgdS47/uqhxAqpBhc8A7JltEdYaMaetlRJLZ4qLw35nNpDDNn7vXJWq9wB4RSjIgk2QWStXZ1YCO4iOnEheJW+6C7chUVODHYWACzXbBJ2GYChBXLZRPqcoXUdLEuh/oFwAKbNA2ImHT6tgYeMAp8K2JcIfOklkxJAo90guIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGn5p1LO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dd7debc476so705657b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706047049; x=1706651849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8D+hyr3W1+WSBWvCgRlvhdImoyDjgQTkdmQzjRW/9U=;
        b=EGn5p1LO6bVDsE3A6mIB6DqWSF6sugkOyTVdgMiltk7DPcybAseYBdWQChfy4wnNRK
         GlQagZLRkWaX7hnXrsIdQqPMjtvbWgTnixf24yeKMzK82C3l+5CxmeB+ajv1tGxcLtf9
         u7nMZI42l8GYSonNuHDEIYncpmjQdfscws8MuRAS5E7EI1oBcXnU6out6palLPyLWsdt
         WpoeJXSoOVCLjbNByDzq11nzE4HQ6r+piHZfh3HlL6Fodmp4NE5wcnTkeIW9hk9yBspj
         ej5lR9d70u9PVi0fMKY6RoMdYjigX1dyTaxY88VWeZxA09Dkw7w3SKCUEDfYDn6WaRK8
         QFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047049; x=1706651849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8D+hyr3W1+WSBWvCgRlvhdImoyDjgQTkdmQzjRW/9U=;
        b=LXWcKfE2ONvoOKCVKK7r3cJqNzpAnLdNk1wfMZ+yXh3rqErs6PpIcWFcsEVDJRVtfC
         Ep1csEWN+ntF3bVsk1xZ/fxwJoaTK2qvxoinoxD7tj0cSIA3MNxDsdJdhjZ/VR6UQgDs
         ELWGrPfgpA8/XH098Hn6rkSNzJcga4TXiX311ejdqcohCIKuoJFHK+QDis28zsYVX2KL
         sIPDA7uyP8jrnYhc636dKeS0xE8+hcQWjWLmTrs03DgdX/ivvDOlP8BVFkMykC82JnPw
         MhA7q5qjiarO2ZL2ziXFVRu/kpWi42ZriK3+flicVnuzA1WuXV2NFjfg3qv321IdfysE
         SUVA==
X-Gm-Message-State: AOJu0YwGqto3gu7+LiVX3m9kYxUbv7JhUIev4J9teB4hLrjzRoMQUQQq
	lp7KyTDGbjyWbfXAjeKv8GLxe9fYdSGjdFcMHCLSG6jScYifRQ2x2o2bkmszuZ4=
X-Google-Smtp-Source: AGHT+IH8xMb9bnQwbIiSbX/1Q2ZNSo/A7YoSHmC7RbuQEOcmFfsqZAInE8rR+lwI58mK2/0gMMCdkQ==
X-Received: by 2002:a05:6a20:4315:b0:199:96a4:b6b9 with SMTP id h21-20020a056a20431500b0019996a4b6b9mr4433395pzk.38.1706047048913;
        Tue, 23 Jan 2024 13:57:28 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id q17-20020a637511000000b005d43d5a9678sm693738pgc.35.2024.01.23.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:57:28 -0800 (PST)
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
Subject: [PATCH net-next v4 09/11] net: dsa: realtek: migrate user_mii_bus setup to realtek-dsa
Date: Tue, 23 Jan 2024 18:56:01 -0300
Message-ID: <20240123215606.26716-10-luizluca@gmail.com>
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

In the user MDIO driver, despite numerous references to SMI, including
its compatible string, there's nothing inherently specific about the SMI
interface in the user MDIO bus. Consequently, the code has been migrated
to the rtl83xx module. All references to SMI have been eliminated.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 57 +----------------------
 drivers/net/dsa/realtek/rtl83xx.c     | 67 +++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h     |  1 +
 3 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index a89813e527d2..70f3967e56e8 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -31,7 +31,6 @@
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/of.h>
-#include <linux/of_mdio.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
@@ -312,60 +311,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_read(priv, addr, regnum);
-}
-
-static int realtek_smi_mdio_write(struct mii_bus *bus, int addr, int regnum,
-				  u16 val)
-{
-	struct realtek_priv *priv = bus->priv;
-
-	return priv->ops->phy_write(priv, addr, regnum, val);
-}
-
-static int realtek_smi_setup_mdio(struct dsa_switch *ds)
-{
-	struct realtek_priv *priv =  ds->priv;
-	struct device_node *mdio_np;
-	int ret = 0;
-
-	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
-	if (!mdio_np) {
-		dev_err(priv->dev, "no MDIO bus node\n");
-		return -ENODEV;
-	}
-
-	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
-	if (!priv->user_mii_bus) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-
-	priv->user_mii_bus->priv = priv;
-	priv->user_mii_bus->name = "SMI user MII";
-	priv->user_mii_bus->read = realtek_smi_mdio_read;
-	priv->user_mii_bus->write = realtek_smi_mdio_write;
-	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
-		 ds->index);
-	priv->user_mii_bus->parent = priv->dev;
-
-	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
-	if (ret) {
-		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-			priv->user_mii_bus->id);
-		goto err_put_node;
-	}
-
-err_put_node:
-	of_node_put(mdio_np);
-
-	return ret;
-}
-
 static const struct realtek_interface_info realtek_smi_info = {
 	.reg_read = realtek_smi_read,
 	.reg_write = realtek_smi_write,
@@ -404,7 +349,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->setup_interface = rtl83xx_setup_user_mdio;
 	priv->ds_ops = priv->variant->ds_ops_smi;
 
 	ret = rtl83xx_register_switch(priv);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 53bacbacc82e..525d8c014136 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
+#include <linux/of_mdio.h>
 
 #include "realtek.h"
 #include "rtl83xx.h"
@@ -42,6 +43,72 @@ void rtl83xx_unlock(void *ctx)
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
 
+static int rtl83xx_user_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_read(priv, addr, regnum);
+}
+
+static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
+				   u16 val)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_write(priv, addr, regnum, val);
+}
+
+/**
+ * rtl83xx_setup_user_mdio() - register the user mii bus driver
+ * @ds: DSA switch associated with this user_mii_bus
+ *
+ * This function first gets and mdio node under the dev OF node, aborting
+ * if missing. That mdio node describing an mdio bus is used to register a
+ * new mdio bus.
+ *
+ * Context: Any context.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv =  ds->priv;
+	struct device_node *mdio_np;
+	int ret = 0;
+
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (!mdio_np) {
+		dev_err(priv->dev, "no MDIO bus node\n");
+		return -ENODEV;
+	}
+
+	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
+	if (!priv->user_mii_bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	priv->user_mii_bus->priv = priv;
+	priv->user_mii_bus->name = "Realtek user MII";
+	priv->user_mii_bus->read = rtl83xx_user_mdio_read;
+	priv->user_mii_bus->write = rtl83xx_user_mdio_write;
+	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
+		 ds->index);
+	priv->user_mii_bus->parent = priv->dev;
+
+	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
+	if (ret) {
+		dev_err(priv->dev, "unable to register MDIO bus %s\n",
+			priv->user_mii_bus->id);
+		goto err_put_node;
+	}
+
+err_put_node:
+	of_node_put(mdio_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_user_mdio, REALTEK_DSA);
+
 /**
  * rtl83xx_probe() - probe a Realtek switch
  * @dev: the device being probed
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 9eb8197a58fa..b5d464bb850d 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -12,6 +12,7 @@ struct realtek_interface_info {
 
 void rtl83xx_lock(void *ctx);
 void rtl83xx_unlock(void *ctx);
+int rtl83xx_setup_user_mdio(struct dsa_switch *ds);
 struct realtek_priv *
 rtl83xx_probe(struct device *dev,
 	      const struct realtek_interface_info *interface_info);
-- 
2.43.0


