Return-Path: <netdev+bounces-55181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D03809B33
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E04B281E38
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2515231;
	Fri,  8 Dec 2023 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GliKuIyG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C210DF
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:52:04 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9e6262fccso505562b6e.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 20:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011124; x=1702615924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaLuLAvvhJHcsb9yo6DwDQL3NLBHLYnwTPlqBlfiIYo=;
        b=GliKuIyGMkRCMtlAkNn2wTdWMvFuyKTT5oULKdKZi8YgCrf3zAmD/sNSu/Cnq4JAba
         eHOpUJbBKtF1ngvxwBEC1IWj4smCXjR0IDv48nuM7deL+4rE3xg8E7ISqjn8RLQwGM+i
         jOLB8e6CdNUnelj9qW1XKBD/DQM8DL7Zj1uFbCrWAyAekBNzbf5fdBt24K+ZAZYhkIN+
         MAz1l0JZwK5vfRX9d0d0jH1+MlHiF5QdRvMTkHrQZYvwhuHxG5vOJhBGxe0cesitInp5
         wXyOhykuRw3rMEzUb54XzWGmQzxFdmcTnV7irnvpB0J+qARFv9lUlIb3xETVR8pg7tuB
         RYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011124; x=1702615924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaLuLAvvhJHcsb9yo6DwDQL3NLBHLYnwTPlqBlfiIYo=;
        b=ezHBuU06s4nrTled4O/rule4dA+7JtiLnIiMcTe11ezmedZXa0nHKUpG5AIkyd+if7
         0tPdrbIRs9kO73AysA3L2msytDGGTlzr8MiHRTvv4sHrYrqsFOJJ8MpHTHxAxXA9UOlN
         OKQS9LIjsjsbNfbsonZuqNYuguyV70LodE/0I5tJu0sRy4AHlS8kXGUuhpX6kpSf6MKZ
         njA6TmvGFOIRRKCfmLW2iRPHfw7j8lFhNp8K2qVdLvjHwqICAYwlQ3azLjDnna/euZm+
         7NhQdqpyleMtAf1i2MWZ+3baiO84uAy/G5J6djd6X2WQfQ3DDfj1giDlAi4Ijbw/T0Hz
         O86A==
X-Gm-Message-State: AOJu0Yz4xC5Nx7ZN3RyRS8lqpjCB7IRrajoYVtXdQLoA7o+d57efUwbF
	gyEtNBb58LJE9eiSjdHcWUg0oxtEijQdQdwJ
X-Google-Smtp-Source: AGHT+IGizaBXvO2zagkwxnbAeIA91QDveLCjsbxmmJ1ylOjk8qizP/0fLB96qvQC2Km9rw5QIDXTVg==
X-Received: by 2002:a54:4483:0:b0:3b9:dd4d:721b with SMTP id v3-20020a544483000000b003b9dd4d721bmr2132687oiv.65.1702011123733;
        Thu, 07 Dec 2023 20:52:03 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b006cbae51f335sm657865pfe.144.2023.12.07.20.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:52:03 -0800 (PST)
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
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 6/7] net: dsa: realtek: migrate user_mii setup to common
Date: Fri,  8 Dec 2023 01:41:42 -0300
Message-ID: <20231208045054.27966-7-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208045054.27966-1-luizluca@gmail.com>
References: <20231208045054.27966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although there are many mentions to SMI in in the user mdio driver,
including its compatible string, there is nothing special about the SMI
interface in the user mdio bus. That way, the code was migrated to the
common module.

All references to SMI were removed, except for the compatible string
that will still work but warn about using the mdio node name instead.

The variant ds_ops_{smi,mdio} fields were rename to, respectively,
ds_ops_custom_user_mdio and ds_ops_default_user_mdio.

The priv->setup_interface() is also gone. If the ds_ops defines
phy_read/write, it means DSA will handle the user_mii_bus. We don't need
to check in another place. Also, with the function that would define
setup_interface() in common, we can call it directly.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 67 ++++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-common.h |  1 +
 drivers/net/dsa/realtek/realtek-mdio.c   |  2 +-
 drivers/net/dsa/realtek/realtek-smi.c    | 61 +--------------------
 drivers/net/dsa/realtek/realtek.h        |  5 +-
 drivers/net/dsa/realtek/rtl8365mb.c      | 12 ++---
 drivers/net/dsa/realtek/rtl8366rb.c      | 12 ++---
 7 files changed, 84 insertions(+), 76 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 73c25d114dd3..64a55cb1ea05 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
+#include <linux/of_mdio.h>
 
 #include "realtek.h"
 #include "realtek-common.h"
@@ -21,6 +22,72 @@ void realtek_common_unlock(void *ctx)
 }
 EXPORT_SYMBOL_GPL(realtek_common_unlock);
 
+static int realtek_common_user_mdio_read(struct mii_bus *bus, int addr,
+					 int regnum)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_read(priv, addr, regnum);
+}
+
+static int realtek_common_user_mdio_write(struct mii_bus *bus, int addr,
+					  int regnum, u16 val)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_write(priv, addr, regnum, val);
+}
+
+int realtek_common_setup_user_mdio(struct dsa_switch *ds)
+{
+	struct realtek_priv *priv =  ds->priv;
+	struct device_node *mdio_np;
+	const char compatible = "realtek,smi-mdio";
+	int ret;
+
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
+	if (!mdio_np) {
+		mdio_np = of_get_compatible_child(priv->dev->of_node, compatible);
+		if (!mdio_np) {
+			dev_err(priv->dev, "no MDIO bus node\n");
+			return -ENODEV;
+		}
+		dev_warn(priv->dev,
+			 "Rename node '%s' to 'mdio' and remove compatible '%s'",
+			 mdio_np->name, compatible);
+	}
+
+	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
+	if (!priv->user_mii_bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+	priv->user_mii_bus->priv = priv;
+	priv->user_mii_bus->name = "Realtek user MII";
+	priv->user_mii_bus->read = realtek_common_user_mdio_read;
+	priv->user_mii_bus->write = realtek_common_user_mdio_write;
+	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "Realtek-%d",
+		 ds->index);
+	priv->user_mii_bus->parent = priv->dev;
+	ds->user_mii_bus = priv->user_mii_bus;
+
+	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
+	of_node_put(mdio_np);
+	if (ret) {
+		dev_err(priv->dev, "unable to register MDIO bus %s\n",
+			priv->user_mii_bus->id);
+		return ret;
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(mdio_np);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(realtek_common_setup_user_mdio);
+
 struct realtek_priv *
 realtek_common_probe_pre(struct device *dev, struct regmap_config rc,
 			 struct regmap_config rc_nolock)
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 405bd0d85d2b..4f8c66167b15 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -7,6 +7,7 @@
 
 void realtek_common_lock(void *ctx);
 void realtek_common_unlock(void *ctx);
+int realtek_common_setup_user_mdio(struct dsa_switch *ds);
 struct realtek_priv *
 realtek_common_probe_pre(struct device *dev, struct regmap_config rc,
 			 struct regmap_config rc_nolock);
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index bb5bff719ae9..37a41bab20b4 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -141,7 +141,7 @@ int realtek_mdio_probe(struct mdio_device *mdiodev)
 	priv->bus = mdiodev->bus;
 	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
-	priv->ds_ops = priv->variant->ds_ops_mdio;
+	priv->ds_ops = priv->variant->ds_ops_default_user_mdio;
 
 	return realtek_common_probe_post(priv);
 
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 1ca2aa784d24..84dde2123b09 100644
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
@@ -339,63 +338,6 @@ static const struct regmap_config realtek_smi_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
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
-	int ret;
-
-	mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
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
-	priv->user_mii_bus->priv = priv;
-	priv->user_mii_bus->name = "SMI user MII";
-	priv->user_mii_bus->read = realtek_smi_mdio_read;
-	priv->user_mii_bus->write = realtek_smi_mdio_write;
-	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
-		 ds->index);
-	priv->user_mii_bus->parent = priv->dev;
-	ds->user_mii_bus = priv->user_mii_bus;
-
-	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
-	of_node_put(mdio_np);
-	if (ret) {
-		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-			priv->user_mii_bus->id);
-		return ret;
-	}
-
-	return 0;
-
-err_put_node:
-	of_node_put(mdio_np);
-
-	return ret;
-}
-
 int realtek_smi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -416,8 +358,7 @@ int realtek_smi_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mdio);
 
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
-	priv->setup_interface = realtek_smi_setup_mdio;
-	priv->ds_ops = priv->variant->ds_ops_smi;
+	priv->ds_ops = priv->variant->ds_ops_custom_user_mdio;
 
 	return realtek_common_probe_post(priv);
 }
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index fbd0616c1df3..3fa8479c396f 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -71,7 +71,6 @@ struct realtek_priv {
 	struct rtl8366_mib_counter *mib_counters;
 
 	const struct realtek_ops *ops;
-	int			(*setup_interface)(struct dsa_switch *ds);
 	int			(*write_reg_noack)(void *ctx, u32 addr, u32 data);
 
 	int			vlan_enabled;
@@ -115,8 +114,8 @@ struct realtek_ops {
 };
 
 struct realtek_variant {
-	const struct dsa_switch_ops *ds_ops_smi;
-	const struct dsa_switch_ops *ds_ops_mdio;
+	const struct dsa_switch_ops *ds_ops_default_user_mdio;
+	const struct dsa_switch_ops *ds_ops_custom_user_mdio;
 	const struct realtek_ops *ops;
 	unsigned int clk_delay;
 	u8 cmd_read;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index ac848b965f84..a52fb07504b5 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2017,8 +2017,8 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	if (ret)
 		goto out_teardown_irq;
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
+	if (!priv->ds_ops->phy_read) {
+		ret = realtek_common_setup_user_mdio(ds);
 		if (ret) {
 			dev_err(priv->dev, "could not set up MDIO bus\n");
 			goto out_teardown_irq;
@@ -2116,7 +2116,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops_custom_user_mdio = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2137,7 +2137,7 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops_smi = {
 	.port_max_mtu = rtl8365mb_port_max_mtu,
 };
 
-static const struct dsa_switch_ops rtl8365mb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8365mb_switch_ops_default_user_mdio = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
@@ -2167,8 +2167,8 @@ static const struct realtek_ops rtl8365mb_ops = {
 };
 
 const struct realtek_variant rtl8365mb_variant = {
-	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
+	.ds_ops_default_user_mdio = &rtl8365mb_switch_ops_default_user_mdio,
+	.ds_ops_custom_user_mdio = &rtl8365mb_switch_ops_custom_user_mdio,
 	.ops = &rtl8365mb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xb9,
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 1cc4de3cf54f..9b6997574d2c 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1027,8 +1027,8 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		dev_info(priv->dev, "no interrupt support\n");
 
-	if (priv->setup_interface) {
-		ret = priv->setup_interface(ds);
+	if (!priv->ds_ops->phy_read) {
+		ret = realtek_common_setup_user_mdio(ds);
 		if (ret) {
 			dev_err(priv->dev, "could not set up MDIO bus\n");
 			return -ENODEV;
@@ -1848,7 +1848,7 @@ static int rtl8366rb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops_custom_user_mdio = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
 	.phylink_get_caps = rtl8366rb_phylink_get_caps,
@@ -1872,7 +1872,7 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops_smi = {
 	.port_max_mtu = rtl8366rb_max_mtu,
 };
 
-static const struct dsa_switch_ops rtl8366rb_switch_ops_mdio = {
+static const struct dsa_switch_ops rtl8366rb_switch_ops_default_user_mdio = {
 	.get_tag_protocol = rtl8366_get_tag_protocol,
 	.setup = rtl8366rb_setup,
 	.phy_read = rtl8366rb_dsa_phy_read,
@@ -1915,8 +1915,8 @@ static const struct realtek_ops rtl8366rb_ops = {
 };
 
 const struct realtek_variant rtl8366rb_variant = {
-	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
-	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
+	.ds_ops_default_user_mdio = &rtl8366rb_switch_ops_default_user_mdio,
+	.ds_ops_custom_user_mdio = &rtl8366rb_switch_ops_custom_user_mdio,
 	.ops = &rtl8366rb_ops,
 	.clk_delay = 10,
 	.cmd_read = 0xa9,
-- 
2.43.0


