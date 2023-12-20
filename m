Return-Path: <netdev+bounces-59144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007E8197C7
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B91C253F3
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED62EBE64;
	Wed, 20 Dec 2023 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Goehta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC872C2D0
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so4147693b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046424; x=1703651224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MegYVyk7jw6IlzfiYihop58rsdOuTuq8Ce0blxachQ=;
        b=W3GoehtaNK26P8TSBA8+2cfDj4phjoTL5NSKpRc4/Le+PwPeAm/p5qtUmIMiVqX4si
         Zpecxk3jb5DI7UbIqP60rH+8U5DLsAkiX+zQZpd+JTzVUfuGuMeXbp3odkLsPEKmPZxD
         hjsZtcFvae/KqHHN5bbjtDlUXUZXvs3TVSl72OQpFIDAWpDUG5toc9Qka+9zl1vWPBUp
         g40mUMXJ+KnUh7QsctTZns7vyf14/ILZ5r35vTVrhNRbR5g5kJY7O6D4a8dviAc86FA9
         TnXbSreJDrQctP5BT8sNv47FjT9BzS2E0pGPwjGkLbFod/yFG6YUQ12Q14ehAEdXBH1c
         QfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046424; x=1703651224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MegYVyk7jw6IlzfiYihop58rsdOuTuq8Ce0blxachQ=;
        b=gMgcSHf2UnJ+63jxRqNucKxVRORdyCI28FvRc0t/HHzKhsyxgBmOs/YRy1MiR4dtXt
         bNQZPn8vIqTMZfd3Qcx2vs491K5S6esZL7V3UmFslN+eyaVgms6KXezK/M1fSXMd7Nm9
         veKcRtFo0EbZtqkrNas1jMK9vp3SshzhbQkPdg2sh0SK9MQx2Vtn68IERXGxPcgSQqK+
         QtZTBHwERQgtOF/An0w6LUuYJzXe4zFtJ+TmKHsHdbuSWIU5rDUU1ZuIxdqFiDCNt7iJ
         Tm+2isGq5H9Kq0FB5mhqIcui61Li2OuzDxM1x/qWnXcFegHTeYGy/Ue9aonzZMIMAwwp
         9rNg==
X-Gm-Message-State: AOJu0YzRbD3zJriiDjG+tk+kHD3H/007Ad24MpPEICrZZUFl4V+kw/An
	7a2Rax7E/1Vx0vQyXNbSG/TT+hcgESl1wLhq
X-Google-Smtp-Source: AGHT+IH7bpoP1NJZXltnCeSz41hlPTIUzYdH34ijJ6LJSVJTjAmEYUlJjTKJZQhE8KYywfPta+6Wsg==
X-Received: by 2002:a05:6808:3c89:b0:3b8:94c0:87fb with SMTP id gs9-20020a0568083c8900b003b894c087fbmr25381714oib.9.1703046424033;
        Tue, 19 Dec 2023 20:27:04 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:27:03 -0800 (PST)
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
Subject: [PATCH net-next v2 3/7] net: dsa: realtek: common realtek-dsa module
Date: Wed, 20 Dec 2023 01:24:26 -0300
Message-ID: <20231220042632.26825-4-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code can be shared between both interface modules (MDIO and SMI)
and among variants. These interface functions migrated to a common
module:

- realtek_common_lock
- realtek_common_unlock
- realtek_common_probe
- realtek_common_register_switch
- realtek_common_remove

The reset during probe was moved to the end of the common probe. This way,
we avoid a reset if anything else fails.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile         |   2 +
 drivers/net/dsa/realtek/realtek-common.c | 137 +++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-common.h |  16 +++
 drivers/net/dsa/realtek/realtek-mdio.c   | 114 +++----------------
 drivers/net/dsa/realtek/realtek-smi.c    | 117 +++----------------
 drivers/net/dsa/realtek/realtek.h        |   6 +-
 drivers/net/dsa/realtek/rtl8365mb.c      |   9 +-
 drivers/net/dsa/realtek/rtl8366rb.c      |   9 +-
 8 files changed, 199 insertions(+), 211 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/realtek-common.c
 create mode 100644 drivers/net/dsa/realtek/realtek-common.h

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..f4f9c6340d5f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
+realtek-dsa-objs			:= realtek-common.o
 obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
 obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
diff --git a/drivers/net/dsa/realtek/realtek-common.c b/drivers/net/dsa/realtek/realtek-common.c
new file mode 100644
index 000000000000..c7507b6cdcdd
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.c
@@ -0,0 +1,137 @@
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
+/* sets up driver private data struct, sets up regmaps, parse common device-tree
+ * properties and finally issues a hardware reset.
+ */
+struct realtek_priv *
+realtek_common_probe(struct device *dev, struct regmap_config rc,
+		     struct regmap_config rc_nolock)
+{
+	const struct realtek_variant *var;
+	struct realtek_priv *priv;
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
+	priv->leds_disabled = of_property_read_bool(dev->of_node,
+						    "realtek,disable-leds");
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
+	return priv;
+}
+EXPORT_SYMBOL(realtek_common_probe);
+
+/* Detects the realtek switch id/version and registers the dsa switch.
+ */
+int realtek_common_register_switch(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = priv->ops->detect(priv);
+	if (ret) {
+		dev_err_probe(priv->dev, ret, "unable to detect switch\n");
+		return ret;
+	}
+
+	priv->ds = devm_kzalloc(priv->dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->priv = priv;
+	priv->ds->dev = priv->dev;
+	priv->ds->ops = priv->ds_ops;
+	priv->ds->num_ports = priv->num_ports;
+
+	ret = dsa_register_switch(priv->ds);
+	if (ret) {
+		dev_err_probe(priv->dev, ret, "unable to register switch\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(realtek_common_register_switch);
+
+void realtek_common_remove(struct realtek_priv *priv)
+{
+	if (!priv)
+		return;
+
+	/* leave the device reset asserted */
+	if (priv->reset)
+		gpiod_set_value(priv->reset, 1);
+}
+EXPORT_SYMBOL(realtek_common_remove);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_DESCRIPTION("Realtek DSA switches common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/realtek-common.h b/drivers/net/dsa/realtek/realtek-common.h
new file mode 100644
index 000000000000..518d091ff496
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_COMMON_H
+#define _REALTEK_COMMON_H
+
+#include <linux/regmap.h>
+
+void realtek_common_lock(void *ctx);
+void realtek_common_unlock(void *ctx);
+struct realtek_priv *
+realtek_common_probe(struct device *dev, struct regmap_config rc,
+		     struct regmap_config rc_nolock);
+int realtek_common_register_switch(struct realtek_priv *priv);
+void realtek_common_remove(struct realtek_priv *priv);
+
+#endif /* _REALTEK_COMMON_H */
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 58966d0625c8..1eed09ab3aa1 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -26,6 +26,7 @@
 
 #include "realtek.h"
 #include "realtek-mdio.h"
+#include "realtek-common.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -100,20 +101,6 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
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
@@ -124,8 +111,8 @@ static const struct regmap_config realtek_mdio_regmap_config = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_mdio_lock,
-	.unlock = realtek_mdio_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_mdio_nolock_regmap_config = {
@@ -143,96 +130,23 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 
 int realtek_mdio_probe(struct mdio_device *mdiodev)
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
+	priv = realtek_common_probe(dev, realtek_mdio_regmap_config,
+				    realtek_mdio_nolock_regmap_config);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
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
-
-	priv->mdio_addr = mdiodev->addr;
 	priv->bus = mdiodev->bus;
-	priv->dev = &mdiodev->dev;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	priv->clk_delay = var->clk_delay;
-	priv->cmd_read = var->cmd_read;
-	priv->cmd_write = var->cmd_write;
-	priv->ops = var->ops;
-
+	priv->mdio_addr = mdiodev->addr;
 	priv->write_reg_noack = realtek_mdio_write;
+	priv->ds_ops = priv->variant->ds_ops_mdio;
 
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
-	ret = priv->ops->detect(priv);
-	if (ret) {
-		dev_err(dev, "unable to detect switch\n");
-		return ret;
-	}
-
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
-
-	priv->ds->dev = dev;
-	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
-	priv->ds->ops = var->ds_ops_mdio;
-
-	ret = dsa_register_switch(priv->ds);
-	if (ret) {
-		dev_err(priv->dev, "unable to register switch ret = %d\n", ret);
+	ret = realtek_common_register_switch(priv);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -247,9 +161,7 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
 
 	dsa_unregister_switch(priv->ds);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 EXPORT_SYMBOL_GPL(realtek_mdio_remove);
 
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 31ac409acfd0..fc54190839cf 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -41,12 +41,13 @@
 
 #include "realtek.h"
 #include "realtek-smi.h"
+#include "realtek-common.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
 static inline void realtek_smi_clk_delay(struct realtek_priv *priv)
 {
-	ndelay(priv->clk_delay);
+	ndelay(priv->variant->clk_delay);
 }
 
 static void realtek_smi_start(struct realtek_priv *priv)
@@ -209,7 +210,7 @@ static int realtek_smi_read_reg(struct realtek_priv *priv, u32 addr, u32 *data)
 	realtek_smi_start(priv);
 
 	/* Send READ command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_read);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_read);
 	if (ret)
 		goto out;
 
@@ -250,7 +251,7 @@ static int realtek_smi_write_reg(struct realtek_priv *priv,
 	realtek_smi_start(priv);
 
 	/* Send WRITE command */
-	ret = realtek_smi_write_byte(priv, priv->cmd_write);
+	ret = realtek_smi_write_byte(priv, priv->variant->cmd_write);
 	if (ret)
 		goto out;
 
@@ -311,20 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
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
@@ -335,8 +322,8 @@ static const struct regmap_config realtek_smi_regmap_config = {
 	.reg_read = realtek_smi_read,
 	.reg_write = realtek_smi_write,
 	.cache_type = REGCACHE_NONE,
-	.lock = realtek_smi_lock,
-	.unlock = realtek_smi_unlock,
+	.lock = realtek_common_lock,
+	.unlock = realtek_common_unlock,
 };
 
 static const struct regmap_config realtek_smi_nolock_regmap_config = {
@@ -411,99 +398,32 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 
 int realtek_smi_probe(struct platform_device *pdev)
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
+	priv->write_reg_noack = realtek_smi_write_reg_noack;
+	priv->setup_interface = realtek_smi_setup_mdio;
+	priv->ds_ops = priv->variant->ds_ops_smi;
 
-	ret = priv->ops->detect(priv);
-	if (ret) {
-		dev_err(dev, "unable to detect switch\n");
+	ret = realtek_common_register_switch(priv);
+	if (ret)
 		return ret;
-	}
-
-	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
-	if (!priv->ds)
-		return -ENOMEM;
 
-	priv->ds->dev = dev;
-	priv->ds->num_ports = priv->num_ports;
-	priv->ds->priv = priv;
-
-	priv->ds->ops = var->ds_ops_smi;
-	ret = dsa_register_switch(priv->ds);
-	if (ret) {
-		dev_err_probe(dev, ret, "unable to register switch\n");
-		return ret;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(realtek_smi_probe);
@@ -516,12 +436,11 @@ void realtek_smi_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(priv->ds);
+
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_common_remove(priv);
 }
 EXPORT_SYMBOL_GPL(realtek_smi_remove);
 
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index e9ee778665b2..fbd0616c1df3 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -58,11 +58,9 @@ struct realtek_priv {
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
-	unsigned int		clk_delay;
-	u8			cmd_read;
-	u8			cmd_write;
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
+	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
@@ -79,6 +77,8 @@ struct realtek_priv {
 	int			vlan_enabled;
 	int			vlan4k_enabled;
 
+	const struct realtek_variant *variant;
+
 	char			buf[4096];
 	void			*chip_data; /* Per-chip extra variant data */
 };
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 1ace2239934a..58ec057b6c32 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -103,6 +103,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "realtek-common.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -691,7 +692,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -724,7 +725,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	*data = val & 0xFFFF;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
@@ -735,7 +736,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -766,7 +767,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index cc2fd636ec23..e60a0a81d426 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -24,6 +24,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "realtek-common.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1707,7 +1708,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_READ);
@@ -1735,7 +1736,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 		phy, regnum, reg, val);
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
@@ -1749,7 +1750,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	realtek_common_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_WRITE);
@@ -1766,7 +1767,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	realtek_common_unlock(priv);
 
 	return ret;
 }
-- 
2.43.0


