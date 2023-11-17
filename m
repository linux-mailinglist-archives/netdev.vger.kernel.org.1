Return-Path: <netdev+bounces-48861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FA7EFC47
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F970B20A19
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DAE4655F;
	Fri, 17 Nov 2023 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfrNhUms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CD85
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2615682b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700265144; x=1700869944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKPy3A4kIykatsMbZIQW8bS69DkjF5GKBwfXEww/wio=;
        b=NfrNhUmsktuPX2QgpTRDfH1xHu7hJ24rLEyj+aw21hkqMWcYoVRZtpXd6oPUyW+bsI
         e2ARwL4rbk9giUA4+XCj9sQsi+uW/a2KDhAgACEmQTQJTUwHWGAF44KcpFd5gyIwJSDl
         zGY5l2o6sl4UlTG30I3YZdem8ekvMh6VqshfqM5WIi2R5qLrGTDJPLk+LfY10ajPefoo
         cfmgldwrV/WKB6+HNIvw57ljf3UV1LAEygg99OLh0BB2OCck73vbJWAaV1cNrbSQ+qXu
         9e5NaXzsQgl3nn1m+3GmQNEvHWx4Z7Z4oDDwlQUTZMDEuUMbMoClbGad8HEf/fggLUIf
         9WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265144; x=1700869944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKPy3A4kIykatsMbZIQW8bS69DkjF5GKBwfXEww/wio=;
        b=SNvoCQ95HZ9nKyepqpDq+bEJCTq3i+LzpEajAKFbirveeIZ01UTL6LhSbvH8k9rng/
         EnfjE+lSgohylP2e5ygmjnw0mhYmSYrJni8w0PSzYKRmEccRieA39NSKRf4ftVHBQqXl
         8rUcR61vFydEB07GDR+DB4jjnGzOfwNX7jhvMAIg1fFLU5eSu6CSt/yDeJmNJNqPlXo+
         MRnJn520fLnh+7e2xcQO5YHxXKcXotIqmOBiQBxnph+CNPj6dDxIQmkXVwZ4fjdUi7yY
         Uoa8kw0Vnm73/nNmWTEIwz7lsfblAnKF5MN/XqjG+ht8RqbqSRgwPNkDCLk1vJSq6nbH
         6K6Q==
X-Gm-Message-State: AOJu0YxoN3GqYs0xdkMQICXMgUqHRMGRt03P7UmA8fRex2fKvcADBglw
	K68WByeWmP2skU0X9DYF6NMCR3KAdx3+Bw==
X-Google-Smtp-Source: AGHT+IH0SG/GMDCHkqSM9171mqah+jv/hYU0AcmpyBORfwNDY3OBWbtUiBnz1jARJtgIFRPkQPOCsQ==
X-Received: by 2002:a05:6a00:8c04:b0:68a:5cf8:dac5 with SMTP id ih4-20020a056a008c0400b0068a5cf8dac5mr1056781pfb.22.1700265143827;
        Fri, 17 Nov 2023 15:52:23 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id b23-20020a056a0002d700b0066a4e561beesm2001993pft.173.2023.11.17.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 15:52:23 -0800 (PST)
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
Subject: [net-next 1/2] net: dsa: realtek: create realtek-common
Date: Fri, 17 Nov 2023 20:50:00 -0300
Message-ID: <20231117235140.1178-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117235140.1178-1-luizluca@gmail.com>
References: <20231117235140.1178-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code can be shared between both interface modules (MDIO and SMI)
and among variants. Currently, these interface functions are shared:

- realtek_common_lock
- realtek_common_unlock
- realtek_common_probe
- realtek_common_remove

The reset during probe was moved to the last moment before a variant
detects the switch. This way, we avoid a reset if anything else fails.

The symbols from variants used in of_match_table are now in a single
match table in realtek-common, used by both interfaces.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/Makefile         |   1 +
 drivers/net/dsa/realtek/realtek-common.c | 127 +++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-common.h |  16 +++
 drivers/net/dsa/realtek/realtek-mdio.c   | 115 +++-----------------
 drivers/net/dsa/realtek/realtek-smi.c    | 127 +++--------------------
 drivers/net/dsa/realtek/realtek.h        |   5 +-
 drivers/net/dsa/realtek/rtl8365mb.c      |   9 +-
 drivers/net/dsa/realtek/rtl8366rb.c      |   9 +-
 8 files changed, 185 insertions(+), 224 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/realtek-common.c
 create mode 100644 drivers/net/dsa/realtek/realtek-common.h

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..5e0c1ef200a3 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-common.o
 obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
 obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
new file mode 100644
index 000000000000..1b733ac56560
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/module.h>
+
+#include "realtek.h"
+#include "realtek-common.h"
+
+void realtek_common_lock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_lock(&priv->map_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_common_lock);
+
+void realtek_common_unlock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_unlock(&priv->map_lock);
+}
+EXPORT_SYMBOL_GPL(realtek_common_unlock);
+
+struct realtek_priv *realtek_common_probe(struct device *dev,
+		struct regmap_config rc, struct regmap_config rc_nolock)
+{
+	const struct realtek_variant *var;
+	struct realtek_priv *priv;
+	struct device_node *np;
+	int ret;
+
+	var = of_device_get_match_data(dev);
+	if (!var)
+		return ERR_PTR(-EINVAL);
+
+	priv = devm_kzalloc(dev, size_add(sizeof(*priv), var->chip_data_sz),
+			    GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&priv->map_lock);
+
+	rc.lock_arg = priv;
+	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
+	if (IS_ERR(priv->map)) {
+		ret = PTR_ERR(priv->map);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc_nolock);
+	if (IS_ERR(priv->map_nolock)) {
+		ret = PTR_ERR(priv->map_nolock);
+		dev_err(dev, "regmap init failed: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* Link forward and backward */
+	priv->dev = dev;
+	priv->variant = var;
+	priv->ops = var->ops;
+	priv->chip_data = (void *)priv + sizeof(*priv);
+
+	dev_set_drvdata(dev, priv);
+	spin_lock_init(&priv->lock);
+
+	np = dev->of_node;
+
+	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
+
+	/* TODO: if power is software controlled, set up any regulators here */
+
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return ERR_CAST(priv->reset);
+	}
+	if (priv->reset) {
+		gpiod_set_value(priv->reset, 1);
+		dev_dbg(dev, "asserted RESET\n");
+		msleep(REALTEK_HW_STOP_DELAY);
+		gpiod_set_value(priv->reset, 0);
+		msleep(REALTEK_HW_START_DELAY);
+		dev_dbg(dev, "deasserted RESET\n");
+	}
+
+	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return ERR_PTR(-ENOMEM);
+
+	priv->ds->dev = dev;
+	priv->ds->priv = priv;
+
+	return priv;
+}
+EXPORT_SYMBOL(realtek_common_probe);
+
+void realtek_common_remove(struct realtek_priv *priv)
+{
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(priv->ds);
+	if (priv->user_mii_bus)
+		of_node_put(priv->user_mii_bus->dev.of_node);
+
+	/* leave the device reset asserted */
+	if (priv->reset)
+		gpiod_set_value(priv->reset, 1);
+}
+EXPORT_SYMBOL(realtek_common_remove);
+
+const struct of_device_id realtek_common_of_match[] = {
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
+	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+#endif
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
+	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
+#endif
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, realtek_common_of_match);
+EXPORT_SYMBOL_GPL(realtek_common_of_match);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_DESCRIPTION("Realtek DSA switches common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
new file mode 100644
index 000000000000..90a949386518
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_INTERFACE_H
+#define _REALTEK_INTERFACE_H
+
+#include <linux/regmap.h>
+
+extern const struct of_device_id realtek_common_of_match[];
+
+void realtek_common_lock(void *ctx);
+void realtek_common_unlock(void *ctx);
+struct realtek_priv *realtek_common_probe(struct device *dev,
+		struct regmap_config rc, struct regmap_config rc_nolock);
+void realtek_common_remove(struct realtek_priv *priv);
+
+#endif
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..b865e11955ca 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -99,20 +100,6 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
 	return ret;
 }
 
-static void realtek_mdio_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_mdio_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
 static const struct regmap_config realtek_mdio_regmap_config = {
 	.reg_bits = 10, /* A4..A0 R4..R0 */
 	.val_bits = 16,
@@ -123,8 +110,8 @@ static const struct regmap_config realtek_mdio_regmap_config = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_mdio_lock,
-	.unlock = realtek_mdio_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_mdio_nolock_regmap_config = {
@@ -142,94 +129,31 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 
 static int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
-	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
-	const struct realtek_variant *var;
-	struct regmap_config rc;
-	struct device_node *np;
+	struct realtek_priv *priv;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	if (!var)
-		return -EINVAL;
-
-	priv = devm_kzalloc(&mdiodev->dev,
-			    size_add(sizeof(*priv), var->chip_data_sz),
-			    GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_mdio_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	rc = realtek_mdio_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
+	priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
+				    realtek_mdio_nolock_regmap_config);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	priv->mdio_addr = mdiodev->addr;
 	priv->bus = mdiodev->bus;
-	priv->dev = &mdiodev->dev;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
-	priv->ops = var->ops;
-
 	priv->write_reg_noack = realtek_mdio_write;
 
-	np = dev->of_node;
-
-	dev_set_drvdata(dev, priv);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
-
 	ret = priv->ops->detect(priv);
 	if (ret) {
 		dev_err(dev, "unable to detect switch\n");
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
+	priv->ds->ops = priv->variant->ds_ops_mdio;
 	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
-	priv->ds->ops = var->ds_ops_mdio;
 
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
-		dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
+		dev_err_probe(dev, ret, "unable to register switch\n");
 		return ret;
 	}
 
@@ -243,11 +167,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
-
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 
 static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
@@ -262,21 +182,10 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
 
-static const struct of_device_id realtek_mdio_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
-
 static struct mdio_driver realtek_mdio_driver = {
 	.mdiodrv.driver = {
 		.name = "realtek-mdio",
-		.of_match_table = realtek_mdio_of_match,
+		.of_match_table = realtek_common_of_match,
 	},
 	.probe  = realtek_mdio_probe,
 	.remove = realtek_mdio_remove,
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 755546ed8db6..2aebcbe0425f 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -40,12 +40,13 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -208,7 +209,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -249,7 +250,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -310,20 +311,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
 	return realtek_smi_read_reg(priv, reg, val);
 }
 
-static void realtek_smi_lock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_lock(&priv->map_lock);
-}
-
-static void realtek_smi_unlock(void *ctx)
-{
-	struct realtek_priv *priv = ctx;
-
-	mutex_unlock(&priv->map_lock);
-}
-
 static const struct regmap_config realtek_smi_regmap_config = {
 	.reg_bits = 10, /* A4..A0 R4..R0 */
 	.val_bits = 16,
@@ -334,8 +321,8 @@ static const struct regmap_config realtek_smi_regmap_config = {
 	.reg_read = realtek_smi_read,
 	.reg_write = realtek_smi_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_smi_lock,
-	.unlock = realtek_smi_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_smi_nolock_regmap_config = {
@@ -410,78 +397,26 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 
 static int realtek_smi_probe(struct platform_device *pdev)
 {
-	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
 	struct realtek_priv *priv;
-	struct regmap_config rc;
-	struct device_node *np;
 	int ret;
 
-	var = of_device_get_match_data(dev);
-	np = dev->of_node;
-
-	priv = devm_kzalloc(dev, sizeof(*priv) + var->chip_data_sz, GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	mutex_init(&priv->map_lock);
-
-	rc = realtek_smi_regmap_config;
-	rc.lock_arg = priv;
-	priv->map = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map)) {
-		ret = PTR_ERR(priv->map);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	rc = realtek_smi_nolock_regmap_config;
-	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
-	if (IS_ERR(priv->map_nolock)) {
-		ret = PTR_ERR(priv->map_nolock);
-		dev_err(dev, "regmap init failed: %d\n", ret);
-		return ret;
-	}
-
-	/* Link forward and backward */
-	priv->dev = dev;
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
-	priv->ops = var->ops;
-
-	priv->setup_interface = realtek_smi_setup_mdio;
-	priv->write_reg_noack = realtek_smi_write_reg_noack;
-
-	dev_set_drvdata(dev, priv);
-	spin_lock_init(&priv->lock);
-
-	/* TODO: if power is software controlled, set up any regulators here */
-
-	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return PTR_ERR(priv->reset);
-	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
-		dev_dbg(dev, "asserted RESET\n");
-		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
-		msleep(REALTEK_HW_START_DELAY);
-		dev_dbg(dev, "deasserted RESET\n");
-	}
+	priv = realtek_common_probe(dev, realtek_smi_regmap_config,
+				    realtek_smi_nolock_regmap_config);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	/* Fetch MDIO pins */
 	priv->mdc = devm_gpiod_get_optional(dev, "mdc", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->mdc))
 		return PTR_ERR(priv->mdc);
+
 	priv->mdio = devm_gpiod_get_optional(dev, "mdio", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->mdio))
 		return PTR_ERR(priv->mdio);
 
-	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
+	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->write_reg_noack = realtek_smi_write_reg_noack;
 
 	ret = priv->ops->detect(priv);
 	if (ret) {
@@ -489,20 +424,15 @@ static int realtek_smi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
+	priv->ds->ops = priv->variant->ds_ops_smi;
 	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
 
-	priv->ds->ops = var->ds_ops_smi;
 	ret = dsa_register_switch(priv->ds);
 	if (ret) {
 		dev_err_probe(dev, ret, "unable to register switch\n");
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -513,13 +443,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	dsa_unregister_switch(priv->ds);
-	if (priv->user_mii_bus)
-		of_node_put(priv->user_mii_bus->dev.of_node);
-
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 
 static void realtek_smi_shutdown(struct platform_device *pdev)
@@ -534,27 +458,10 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
-static const struct of_device_id realtek_smi_of_match[] = {
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB)
-	{
-		.compatible = "realtek,rtl8366rb",
-		.data = &rtl8366rb_variant,
-	},
-#endif
-#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
-	{
-		.compatible = "realtek,rtl8365mb",
-		.data = &rtl8365mb_variant,
-	},
-#endif
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
-
 static struct platform_driver realtek_smi_driver = {
 	.driver = {
 		.name = "realtek-smi",
-		.of_match_table = realtek_smi_of_match,
+		.of_match_table = realtek_common_of_match,
 	},
 	.probe  = realtek_smi_probe,
 	.remove_new = realtek_smi_remove,
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..fbbdf538908e 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -58,9 +58,6 @@ struct realtek_priv {
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
-	unsigned int		clk_delay;
-	u8			cmd_read;
-	u8			cmd_write;
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
 	struct irq_domain	*irqdomain;
@@ -79,6 +76,8 @@ struct realtek_priv {
 	int			vlan_enabled;
 	int			vlan4k_enabled;
 
+	const struct realtek_variant *variant;
+
 	char			buf[4096];
 	void			*chip_data; /* Per-chip extra variant data */
 };
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 0875e4fc9f57..9b18774e988c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -101,6 +101,7 @@
 #include <linux/if_vlan.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -689,7 +690,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -722,7 +723,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	*data = val & 0xFFFF;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
@@ -733,7 +734,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -764,7 +765,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index b39b719a5b8f..1ac2fd098242 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-common.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1705,7 +1706,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_READ);
@@ -1733,7 +1734,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 		phy, regnum, reg, val);
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
@@ -1747,7 +1748,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_WRITE);
@@ -1764,7 +1765,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
-- 
2.42.1


