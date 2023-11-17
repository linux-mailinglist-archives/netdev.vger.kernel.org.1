Return-Path: <netdev+bounces-48862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD557EFC48
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE81281417
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7A47763;
	Fri, 17 Nov 2023 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO2l5d3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3902292
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1939775b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700265148; x=1700869948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyVbG5VmZUH+XmjhsyZuY/N3YPHIeOO3qsa4EJahHUM=;
        b=PO2l5d3npx3KP9vo4o4lRxNhx4q4jeV+RjApaP7I2o2a2MZCBgXBzpZodJ1uMtlwMs
         uyN+BlSH9NZLLKBMGXUR5L7c3fN6wVmulCh3g69o2n/FKM+hwsqJpKIoOtxJouevumpB
         1hnniUJtOFVztvOvelr5kzR3bbCXX7gJlsvwfm6Lm7XqyK4y71KEKjhy+VllNjfkskhv
         akPgIaoi0liBl3IoJOTcPWCbipmtbHI61ZhPwMK0NoYLr7VxyHRX+WqdDmwdM9Vk26hN
         kMu9LQ7j9mkOXpAF+KqjZruxTATnmC4l6xS+yZU+AvB85GYNuL6dI4r4j3nCwYpTjl0Y
         l/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265148; x=1700869948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyVbG5VmZUH+XmjhsyZuY/N3YPHIeOO3qsa4EJahHUM=;
        b=N+5o4mXUF+4ovYMb1fmpByP48e/xtOGhCTtangXOCTs3XPsvu4R4bUq2R+X8IdhiGT
         3ZyG0qUkNb6LfL+uGYyoW+VCgj/x6W47Ql1TzfYcjtgVBW+LuPG2QmSdUNcisZ0yjuFa
         BNZsW6mExPJW3Glb61uOgfDirXMvd5Dcf/g6Fjzcp9asRcwrdQCD9J2g9hH9I2yguPDy
         HKcOzmpnpD0OUnxUH//wnZ3IXll/OlgLHqOCQuMbyjB44WC5cR7Z49bhftbeBpmj5Rn5
         Mmj1I1c/Ghp2GQeQGX+ounarNP7LzI7My0LBwXaNPnqdCA6yoNu+GjaM15Sr9NAJz9Aa
         1dYQ==
X-Gm-Message-State: AOJu0YyeSYtGvVZFRuvkANWUvTG2mjLOmRikGdwOEKJL6XB5I++mNXrP
	R8gHsxXnUUmo+/FiiLzw1c+xlW0Fdfxw5g==
X-Google-Smtp-Source: AGHT+IEkugJuPfGfb1G6o1NTQ3RmODekfWovxvSaMhEaivOunxyPAC4uW3D9LCQCc4ZdpNfOLCytaA==
X-Received: by 2002:a05:6a00:93a0:b0:6c4:d615:2169 with SMTP id ka32-20020a056a0093a000b006c4d6152169mr10038257pfb.10.1700265147574;
        Fri, 17 Nov 2023 15:52:27 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id b23-20020a056a0002d700b0066a4e561beesm2001993pft.173.2023.11.17.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:52:27 -0800 (PST)
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
Subject: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Date: Fri, 17 Nov 2023 20:50:01 -0300
Message-ID: <20231117235140.1178-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117235140.1178-1-luizluca@gmail.com>
References: <20231117235140.1178-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

realtek-common had a hard dependency on both switch variants. As a
result, it was not possible to selectively load only one model at
runtime. Now, variants are registered in the realtek-common module, and
interface modules look for a variant using the compatible string.

The variant modules use the same compatible string as the module alias.
This way, an interface module can use the matching compatible string to
both load the module and get the variant reference.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-common.c | 107 ++++++++++++++++++++---
 drivers/net/dsa/realtek/realtek-common.h |  33 +++++++
 drivers/net/dsa/realtek/realtek-mdio.c   |   9 +-
 drivers/net/dsa/realtek/realtek-smi.c    |  21 +++--
 drivers/net/dsa/realtek/realtek.h        |   3 -
 drivers/net/dsa/realtek/rtl8365mb.c      |   4 +-
 drivers/net/dsa/realtek/rtl8366rb.c      |   4 +-
 7 files changed, 154 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
index 1b733ac56560..cdd8d77c20d9 100644
--- a/drivers/net/dsa/realtek/realtek-common.c
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -1,10 +1,72 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 #include "realtek.h"
 #include "realtek-common.h"
 
+static LIST_HEAD(realtek_variants_list);
+static DEFINE_MUTEX(realtek_variants_lock);
+
+void realtek_variant_register(struct realtek_variant_entry *variant_entry)
+{
+	mutex_lock(&realtek_variants_lock);
+	list_add_tail(&variant_entry->list, &realtek_variants_list);
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_register);
+
+void realtek_variant_unregister(struct realtek_variant_entry *variant_entry)
+{
+	mutex_lock(&realtek_variants_lock);
+	list_del(&variant_entry->list);
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_unregister);
+
+const struct realtek_variant *realtek_variant_get(const char *compatible)
+{
+	const struct realtek_variant *variant = ERR_PTR(-ENOENT);
+	struct realtek_variant_entry *variant_entry;
+
+	request_module(compatible);
+
+	mutex_lock(&realtek_variants_lock);
+	list_for_each_entry(variant_entry, &realtek_variants_list, list) {
+		if (strcmp(compatible, variant_entry->compatible))
+			continue;
+
+		if (!try_module_get(variant_entry->owner))
+			break;
+
+		variant = variant_entry->variant;
+		break;
+	}
+	mutex_unlock(&realtek_variants_lock);
+
+	return variant;
+}
+EXPORT_SYMBOL_GPL(realtek_variant_get);
+
+void realtek_variant_put(const struct realtek_variant *var)
+{
+	struct realtek_variant_entry *variant_entry;
+
+	mutex_lock(&realtek_variants_lock);
+	list_for_each_entry(variant_entry, &realtek_variants_list, list) {
+		if (variant_entry->variant != var)
+			continue;
+
+		if (variant_entry->owner)
+			module_put(variant_entry->owner);
+
+		break;
+	}
+	mutex_unlock(&realtek_variants_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_variant_put);
+
 void realtek_common_lock(void *ctx)
 {
 	struct realtek_priv *priv = ctx;
@@ -25,18 +87,30 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 		struct regmap_config rc, struct regmap_config rc_nolock)
 {
 	const struct realtek_variant *var;
+	const struct of_device_id *match;
 	struct realtek_priv *priv;
 	struct device_node *np;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	if (!var)
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match)
 		return ERR_PTR(-EINVAL);
 
+	var = realtek_variant_get(match->compatible);
+	if (IS_ERR(var)) {
+		ret = PTR_ERR(var);
+		dev_err_probe(dev, ret,
+			      "failed to get module for alias '%s'",
+			      match->compatible);
+		goto err_variant_put;
+	}
+
 	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
 			    GFP_KERNEL);
-	if (!priv)
-		return ERR_PTR(-ENOMEM);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_variant_put;
+	}
 
 	mutex_init(&priv->map_lock);
 
@@ -45,14 +119,14 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	if (IS_ERR(priv->map)) {
 		ret = PTR_ERR(priv->map);
 		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ERR_PTR(ret);
+		goto err_variant_put;
 	}
 
 	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
 	if (IS_ERR(priv->map_nolock)) {
 		ret = PTR_ERR(priv->map_nolock);
 		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ERR_PTR(ret);
+		goto err_variant_put;
 	}
 
 	/* Link forward and backward */
@@ -69,11 +143,11 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
-
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
+		ret = PTR_ERR(priv->reset);
 		dev_err(dev, "failed to get RESET GPIO\n");
-		return ERR_CAST(priv->reset);
+		goto err_variant_put;
 	}
 	if (priv->reset) {
 		gpiod_set_value(priv->reset, 1);
@@ -85,13 +159,20 @@ struct realtek_priv *realtek_common_probe(struct device *dev,
 	}
 
 	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return ERR_PTR(-ENOMEM);
+	if (!priv->ds) {
+		ret = -ENOMEM;
+		goto err_variant_put;
+	}
 
 	priv->ds->dev = dev;
 	priv->ds->priv = priv;
 
 	return priv;
+
+err_variant_put:
+	realtek_variant_put(var);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(realtek_common_probe);
 
@@ -104,6 +185,8 @@ void realtek_common_remove(struct realtek_priv *priv)
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
 
+	realtek_variant_put(priv->variant);
+
 	/* leave the device reset asserted */
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
@@ -112,10 +195,10 @@ EXPORT_SYMBOL(realtek_common_remove);
 
 const struct of_device_id realtek_common_of_match[] = {
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+	{ .compatible = "realtek,rtl8366rb", },
 #endif
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
+	{ .compatible = "realtek,rtl8365mb", },
 #endif
 	{ /* sentinel */ },
 };
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
index 90a949386518..6de4991d8b5c 100644
--- a/drivers/net/dsa/realtek/realtek-common.h
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -5,6 +5,37 @@
 
 #include <linux/regmap.h>
 
+struct realtek_variant_entry {
+	const struct realtek_variant *variant;
+	const char *compatible;
+	struct module *owner;
+	struct list_head list;
+};
+
+#define module_realtek_variant(__variant, __compatible)			\
+static struct realtek_variant_entry __variant ## _entry = {		\
+	.compatible = __compatible,					\
+	.variant = &(__variant),					\
+	.owner = THIS_MODULE,						\
+};									\
+static int __init realtek_variant_module_init(void)			\
+{									\
+	realtek_variant_register(&__variant ## _entry);			\
+	return 0;							\
+}									\
+module_init(realtek_variant_module_init)				\
+									\
+static void __exit realtek_variant_module_exit(void)			\
+{									\
+	realtek_variant_unregister(&__variant ## _entry);		\
+}									\
+module_exit(realtek_variant_module_exit);				\
+									\
+MODULE_ALIAS(__compatible)
+
+void realtek_variant_register(struct realtek_variant_entry *variant_entry);
+void realtek_variant_unregister(struct realtek_variant_entry *variant_entry);
+
 extern const struct of_device_id realtek_common_of_match[];
 
 void realtek_common_lock(void *ctx);
@@ -12,5 +43,7 @@ void realtek_common_unlock(void *ctx);
 struct realtek_priv *realtek_common_probe(struct device *dev,
 		struct regmap_config rc, struct regmap_config rc_nolock);
 void realtek_common_remove(struct realtek_priv *priv);
+const struct realtek_variant *realtek_variant_get(const char *compatible);
+void realtek_variant_put(const struct realtek_variant *var);
 
 #endif
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index b865e11955ca..c447dd815a59 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -145,7 +145,7 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 	ret = priv->ops->detect(priv);
 	if (ret) {
 		dev_err(dev, "unable to detect switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	priv->ds->ops = priv->variant->ds_ops_mdio;
@@ -154,10 +154,15 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
 		dev_err_probe(dev, ret, "unable to register switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	return 0;
+
+err_variant_put:
+	realtek_variant_put(priv->variant);
+
+	return ret;
 }
 
 static void realtek_mdio_remove(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 2aebcbe0425f..e50b3c6203e6 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -408,12 +408,16 @@ static int realtek_smi_probe(struct platform_device *pdev)
 
 	/* Fetch MDIO pins */
 	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdc))
-		return PTR_ERR(priv->mdc);
+	if (IS_ERR(priv->mdc)) {
+		ret = PTR_ERR(priv->mdc);
+		goto err_variant_put;
+	}
 
 	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->mdio))
-		return PTR_ERR(priv->mdio);
+	if (IS_ERR(priv->mdio)) {
+		ret = PTR_ERR(priv->mdc);
+		goto err_variant_put;
+	}
 
 	priv->setup_interface = realtek_smi_setup_mdio;
 	priv->write_reg_noack = realtek_smi_write_reg_noack;
@@ -421,7 +425,7 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	ret = priv->ops->detect(priv);
 	if (ret) {
 		dev_err(dev, "unable to detect switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	priv->ds->ops = priv->variant->ds_ops_smi;
@@ -430,10 +434,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
 		dev_err_probe(dev, ret, "unable to register switch\n");
-		return ret;
+		goto err_variant_put;
 	}
 
 	return 0;
+
+err_variant_put:
+	realtek_variant_put(priv->variant);
+
+	return ret;
 }
 
 static void realtek_smi_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index fbbdf538908e..267a1dc02080 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -143,7 +143,4 @@ void rtl8366_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 int rtl8366_get_sset_count(struct dsa_switch *ds, int port, int sset);
 void rtl8366_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data);
 
-extern const struct realtek_variant rtl8366rb_variant;
-extern const struct realtek_variant rtl8365mb_variant;
-
 #endif /*  _REALTEK_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 9b18774e988c..fb214dd717f0 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -2164,7 +2164,7 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.phy_write = rtl8365mb_phy_write,
 };
 
-const struct realtek_variant rtl8365mb_variant = {
+static const struct realtek_variant rtl8365mb_variant = {
 	.ds_ops_smi = &rtl8365mb_switch_ops_smi,
 	.ds_ops_mdio = &rtl8365mb_switch_ops_mdio,
 	.ops = &rtl8365mb_ops,
@@ -2173,7 +2173,7 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
 };
-EXPORT_SYMBOL_GPL(rtl8365mb_variant);
+module_realtek_variant(rtl8365mb_variant, "realtek,rtl8365mb");
 
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 1ac2fd098242..143c57c69ace 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -1912,7 +1912,7 @@ static const struct realtek_ops rtl8366rb_ops = {
 	.phy_write	= rtl8366rb_phy_write,
 };
 
-const struct realtek_variant rtl8366rb_variant = {
+static const struct realtek_variant rtl8366rb_variant = {
 	.ds_ops_smi = &rtl8366rb_switch_ops_smi,
 	.ds_ops_mdio = &rtl8366rb_switch_ops_mdio,
 	.ops = &rtl8366rb_ops,
@@ -1921,7 +1921,7 @@ const struct realtek_variant rtl8366rb_variant = {
 	.cmd_write = 0xa8,
 	.chip_data_sz = sizeof(struct rtl8366rb),
 };
-EXPORT_SYMBOL_GPL(rtl8366rb_variant);
+module_realtek_variant(rtl8366rb_variant, "realtek,rtl8366rb");
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");
-- 
2.42.1


