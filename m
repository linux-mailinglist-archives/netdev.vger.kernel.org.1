Return-Path: <netdev+bounces-65234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819E839B57
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5777A285CA3
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3AE4D12D;
	Tue, 23 Jan 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJYRYX1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E854A987
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046309; cv=none; b=e0vgFO3FhyvfizSjyk8AFQeJVzlqsjrt60M66NLG1fdkazElRNMK2yJ44mc+nu9LR4Ow5hT5nDZZCW4eOwx802R4e9Y2gnebsRe3uS5K/JNb6JD6CjPsnpnZrX3H0ZU72tvk39R6AHgokuxFDCP8FA+eSmy2r1YfjmWG2DcKhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046309; c=relaxed/simple;
	bh=J3Nh1N/06LdYOJxcnZT42tewbtJ1miuDdNVw8UlyqGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvOwR7YY2fCH6dk/H68Hr19XVOaMpaPJQC0s8DYVk3sE07TFWeFh7iCsJa+R8TW/bJxaDMSHCkKDSOzGjY6TAg/A9beoqERVxM0cz/pdGfmonAulmPDtL7PmCDm4QxJ5THDkaLHJm0oSMbEkXV1CZqLQp+TraH8XLp7Z2SGJ7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJYRYX1W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d70b0e521eso34965615ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046307; x=1706651107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8D+hyr3W1+WSBWvCgRlvhdImoyDjgQTkdmQzjRW/9U=;
        b=FJYRYX1Wkw89GG3P6Nl4/26YbRBD3AKOeMfaYdon6EVqXv+qdE7N3vO8DAoJfHtbhj
         WKpv5/oNQyRKJ5JKLVi+Fdo7kpEM40rPFEQ+IQ5ZadrFfOfijXfKMe1pLwb0GIOc2oFy
         k2drosnlmrfm9cZNhcbYEtRBc+1fMM7mAzoiPii47kahVLVjuFW1VJ460izapn++grGm
         k+FUK8/jOvdxsAzicfWYIpWVQHVFkqLkH5dbJvM8rjWSCJUc4V3FrBWw7S1og1pWiNIx
         Uedd5SNjq8+mzwhzVGPhbK8VqmNXKBJQobZxQfYFJ+FzvVVvkbXbZTqvgA5nzCZoCGEk
         TFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046307; x=1706651107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8D+hyr3W1+WSBWvCgRlvhdImoyDjgQTkdmQzjRW/9U=;
        b=noTRsrOEs/Z17UIuzoJysaKO4DuwLqegOapG87wIwEgHUYP08vgsQrgowhQkSX/Z9n
         KH42cDMNVVWV9uhI0OdieonHoqQTbwcPAYysi3WrkxJn4Ji7TusXHZS0Swh+tYZUPInw
         rjZ15iju+Fzt7yLkFHKmw71FykofCE7tj+ia40BSVPLI+k+BUhgAlwx+QAwtb73Fv60l
         UbmY3fu6J0gy8Lapx2QbCK4/e6QX6BYxwd+9saFMRxb0iTFiBwydy0QIVVX1xQ855IEQ
         rhV7P5jmHHHuJCrXdpOVluQrCYuylHDT9ZsV6g+uwjA+pC0Z2He23zJtP6TkrJw2UWQx
         8z7A==
X-Gm-Message-State: AOJu0Yyaj9XWIRb6PxoIBgk3WlGC6zdojl2nOUZyITofUQdnbtnikznX
	nEHZXYWj8mu+BGJSDqbI+sk5SV4FlXyu7yMx0iRBOWiiSOLDiCQSnHXJ3vW0kdo=
X-Google-Smtp-Source: AGHT+IEDIvgsrgm/zjsOH22L7ltuahXhwsVpexSWl738Q2CkVzwTT/c80sEkaznUrihzjVzbtN8HiQ==
X-Received: by 2002:a17:902:f684:b0:1d7:3100:9f8a with SMTP id l4-20020a170902f68400b001d731009f8amr8280302plg.43.1706046306744;
        Tue, 23 Jan 2024 13:45:06 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:45:06 -0800 (PST)
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
Subject: [PATCH 09/11] net: dsa: realtek: migrate user_mii_bus setup to realtek-dsa
Date: Tue, 23 Jan 2024 18:44:17 -0300
Message-ID: <20240123214420.25716-10-luizluca@gmail.com>
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


