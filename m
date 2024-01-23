Return-Path: <netdev+bounces-65230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CD839B53
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165AC285DE4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEEC3D566;
	Tue, 23 Jan 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1cdMm3h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B04EB29
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046293; cv=none; b=hyWDxDmziR9fgqa6V3xY8uhTxRw8sDAtbEDwaULSw/nWNl6/2hSA4z/OInuTVKP1VHoOEqtat3RUwKfGec6AvGXIA/bvPuk520wAYtsI5aIf73ID0DymDPTMm63LR8mGDIfyx8kX5F+NR5+jdDJlGmMTMi8bk+yeebLj7BG3aTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046293; c=relaxed/simple;
	bh=pswhXqnecuEGZaOGOSQ8njyGIX8bIkw41ZaBGJlgM5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsUWIMZmt5lxdXP6Vg3GL+RGe9JysZagvy8eyGlA6ORfnfdz545VKc7liObzRmaRqzC8QrPjeBBkAqmwQ61vm7ZnVpjjciKXqstMHtm8GRBHrXsrwbOwP8ViaeCwlbrLe/zA3xu8rCPHw3nNvxrTNCVQPXfgpzBG+eSpdEb23Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1cdMm3h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d750660a0aso13791765ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046289; x=1706651089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALi6K9jI/Xw4oB+TdMlVvsDXkVqF1LgbvaH562oL+Ak=;
        b=D1cdMm3hY8UaapFiAape50Pb1zo1RSrCrCs7vCNheLoOTdHDDr0s8MxbKZ0iZbFiSz
         iKkFh2dWEeezahg9WyP+jNF0g0dBv1KO0wSK1vnR3Cc76Ha1Cx7QZWZ9t7BBv3/2+YAG
         mwJ6Lh7eXmlmY7Urx1AS+CXHe5SyDUp5rFk81Joe86JTT+AA+gZXH2x7HV3RY7FNIRjc
         LrfXT7cy/T4L8yh7DL3+LMuIEUZW2JjlHCfVmMYDqGYJ/VjIf0kZotdRWu6mJATvSOOG
         3CYGwEWM9dvAjRW9AzXtwM4MoBJ4iG0GCSRmMcJ77lw04vLt0/bjrh39FDRyXCnQc8LO
         5Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046289; x=1706651089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALi6K9jI/Xw4oB+TdMlVvsDXkVqF1LgbvaH562oL+Ak=;
        b=WWAG2AJOpnko/S84RDKMzF8L/2+WxbCV7INaxEeLxgjg7qxoSJg+OlWDtT1UXxuIO5
         eS2yWzec/Up4ZohldeJi0yLOQwJBZuh+o77idL/amoMwHqSA378PYxmMbBBzR4bN9bRL
         hFcVlp7rldgC0fThl0I7tPKkzR4uvq9mXcAVTuCo6dKA2KqNXjtVAQ1LB5m2rGHlvcu1
         iszsbhr7Di5zM4u8kWR+9Q1L1riLvtjwk9QraMPrnd5T6YZpjy8Nqg6TZnxHm6BA8pra
         AoSTGLAJYxmpJcOpDZZGz96w6Z8s989K6ddkvhXhebT4MDYInToxdTK561sDlckbaPVI
         ahUA==
X-Gm-Message-State: AOJu0YwDM9eqVQcirhGqUzPmZptbkc+SOWN2KcYtGMvlxmGCCoTlp99t
	ydEZYJHYic7vQDeFcyEO/utM6JZZxlGbYyXNLFCnauCVhAYAvjJTEVLB0lYRRmk=
X-Google-Smtp-Source: AGHT+IEtnHw0Hr8bK5l1hBcWXHxSRd2lCCgyo5//wtA8tehRs/B7PazECxpx3jkOH5g2/jVu873Ebg==
X-Received: by 2002:a17:902:b781:b0:1d4:751d:7bf2 with SMTP id e1-20020a170902b78100b001d4751d7bf2mr3933822pls.35.1706046289157;
        Tue, 23 Jan 2024 13:44:49 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:48 -0800 (PST)
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
Subject: [PATCH 05/11] net: dsa: realtek: common rtl83xx module
Date: Tue, 23 Jan 2024 18:44:13 -0300
Message-ID: <20240123214420.25716-6-luizluca@gmail.com>
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

Some code can be shared between both interface modules (MDIO and SMI)
and among variants. These interface functions migrated to a common
module:

- rtl83xx_lock
- rtl83xx_unlock
- rtl83xx_probe
- rtl83xx_register_switch
- rtl83xx_remove

The reset during probe was moved to the end of the common probe. This way,
we avoid a reset if anything else fails.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile       |   2 +
 drivers/net/dsa/realtek/realtek-mdio.c | 145 +++---------------
 drivers/net/dsa/realtek/realtek-smi.c  | 150 +++---------------
 drivers/net/dsa/realtek/realtek.h      |   1 +
 drivers/net/dsa/realtek/rtl8365mb.c    |   9 +-
 drivers/net/dsa/realtek/rtl8366rb.c    |   9 +-
 drivers/net/dsa/realtek/rtl83xx.c      | 201 +++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h      |  21 +++
 8 files changed, 279 insertions(+), 259 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.c
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.h

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 0aab57252a7c..67b5ee1c43a9 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
+realtek-dsa-objs			:= rtl83xx.o
 obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
 obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 57bd5d8814c2..26b8371ecc87 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -26,6 +26,7 @@
 
 #include "realtek.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -100,55 +101,19 @@ static int realtek_mdio_read(void *ctx, u32 reg, u32 *val)
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
-static const struct regmap_config realtek_mdio_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_mdio_read,
-	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_mdio_lock,
-	.unlock = realtek_mdio_unlock,
-};
-
-static const struct regmap_config realtek_mdio_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
+static const struct realtek_interface_info realtek_mdio_info = {
 	.reg_read = realtek_mdio_read,
 	.reg_write = realtek_mdio_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
 };
 
 /**
  * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
  * @pdev: platform_device to probe on.
  *
- * This function should be used as the .probe in an mdio_driver. It
- * initializes realtek_priv and read data from the device-tree node. The switch
- * is hard resetted if a method is provided. It checks the switch chip ID and,
- * finally, a DSA switch is registered.
+ * This function should be used as the .probe in an mdio_driver. After
+ * calling the common probe function for both interfaces, it initializes the
+ * values specific for MDIO-connected devices. Finally, it calls a common
+ * function to register the DSA switch.
  *
  * Context: Any context. Takes and releases priv->map_lock.
  * Return: Returns 0 on success, a negative error on failure.
@@ -156,94 +121,22 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
  */
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
+	priv = rtl83xx_probe(dev, &realtek_mdio_info);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
-	priv->mdio_addr = mdiodev->addr;
 	priv->bus = mdiodev->bus;
-	priv->dev = &mdiodev->dev;
-	priv->chip_data = (void *)priv + sizeof(*priv);
-
-	priv->variant = var;
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
+	ret = rtl83xx_register_switch(priv);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -254,8 +147,8 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_probe, REALTEK_DSA);
  * @pdev: platform_device to probe on.
  *
  * This function should be used as the .remove_new in an mdio_driver. First
- * it unregisters the DSA switch and cleans internal data. If a method is
- * provided, the hard reset is asserted to avoid traffic leakage.
+ * it unregisters the DSA switch and cleans internal data. Finally, it calls
+ * the common remove function.
  *
  * Context: Any context.
  * Return: Nothing.
@@ -270,9 +163,7 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
 
 	dsa_unregister_switch(priv->ds);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
 
@@ -303,3 +194,5 @@ EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 274dd96b099c..840b1a835d07 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -41,6 +41,7 @@
 
 #include "realtek.h"
 #include "realtek-smi.h"
+#include "rtl83xx.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -311,47 +312,6 @@ static int realtek_smi_read(void *ctx, u32 reg, u32 *val)
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
-static const struct regmap_config realtek_smi_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.lock = realtek_smi_lock,
-	.unlock = realtek_smi_unlock,
-};
-
-static const struct regmap_config realtek_smi_nolock_regmap_config = {
-	.reg_bits = 10, /* A4..A0 R4..R0 */
-	.val_bits = 16,
-	.reg_stride = 1,
-	/* PHY regs are at 0x8000 */
-	.max_register = 0xffff,
-	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.reg_read = realtek_smi_read,
-	.reg_write = realtek_smi_write,
-	.cache_type = REGCACHE_NONE,
-	.disable_locking = true,
-};
-
 static int realtek_smi_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct realtek_priv *priv = bus->priv;
@@ -409,14 +369,19 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static const struct realtek_interface_info realtek_smi_info = {
+	.reg_read = realtek_smi_read,
+	.reg_write = realtek_smi_write,
+};
+
 /**
  * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
  * @pdev: platform_device to probe on.
  *
- * This function should be used as the .probe in a platform_driver. It
- * initializes realtek_priv and read data from the device-tree node. The switch
- * is hard resetted if a method is provided. It checks the switch chip ID and,
- * finally, a DSA switch is registered.
+ * This function should be used as the .probe in a platform_driver. After
+ * calling the common probe function for both interfaces, it initializes the
+ * values specific for SMI-connected devices. Finally, it calls a common
+ * function to register the DSA switch.
  *
  * Context: Any context. Takes and releases priv->map_lock.
  * Return: Returns 0 on success, a negative error on failure.
@@ -424,97 +389,31 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
  */
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
-	priv->variant = var;
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
+	priv = rtl83xx_probe(dev, &realtek_smi_info);
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
+	ret = rtl83xx_register_switch(priv);
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
 EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
@@ -524,8 +423,8 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
  * @pdev: platform_device to probe on.
  *
  * This function should be used as the .remove_new in a platform_driver. First
- * it unregisters the DSA switch and cleans internal data. If a method is
- * provided, the hard reset is asserted to avoid traffic leakage.
+ * it unregisters the DSA switch and cleans internal data. Finally, it calls
+ * the common remove function.
  *
  * Context: Any context.
  * Return: Nothing.
@@ -539,12 +438,11 @@ void realtek_smi_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(priv->ds);
+
 	if (priv->user_mii_bus)
 		of_node_put(priv->user_mii_bus->dev.of_node);
 
-	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_remove(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
 
@@ -575,3 +473,5 @@ EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(REALTEK_DSA);
+
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 0c51b5132c61..fbd0616c1df3 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -60,6 +60,7 @@ struct realtek_priv {
 
 	spinlock_t		lock; /* Locks around command writes */
 	struct dsa_switch	*ds;
+	const struct dsa_switch_ops *ds_ops;
 	struct irq_domain	*irqdomain;
 	bool			leds_disabled;
 
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index bd76bcf5fa44..97a41ba73718 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -103,6 +103,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -691,7 +692,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -724,7 +725,7 @@ static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
 	*data = val & 0xFFFF;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
@@ -735,7 +736,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 	u32 val;
 	int ret;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = rtl8365mb_phy_poll_busy(priv);
 	if (ret)
@@ -766,7 +767,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 74e14b73a1ec..ec7a55d70bad 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -25,6 +25,7 @@
 #include "realtek.h"
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
+#include "rtl83xx.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1720,7 +1721,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_READ);
@@ -1748,7 +1749,7 @@ static int rtl8366rb_phy_read(struct realtek_priv *priv, int phy, int regnum)
 		phy, regnum, reg, val);
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
@@ -1762,7 +1763,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	if (phy > RTL8366RB_PHY_NO_MAX)
 		return -EINVAL;
 
-	mutex_lock(&priv->map_lock);
+	rtl83xx_lock(priv);
 
 	ret = regmap_write(priv->map_nolock, RTL8366RB_PHY_ACCESS_CTRL_REG,
 			   RTL8366RB_PHY_CTRL_WRITE);
@@ -1779,7 +1780,7 @@ static int rtl8366rb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 		goto out;
 
 out:
-	mutex_unlock(&priv->map_lock);
+	rtl83xx_unlock(priv);
 
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
new file mode 100644
index 000000000000..57d185226b03
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/module.h>
+
+#include "realtek.h"
+#include "rtl83xx.h"
+
+/**
+ * rtl83xx_lock() - Locks the mutex used by regmaps
+ * @ctx: realtek_priv pointer
+ *
+ * This function is passed to regmap to be used as the lock function.
+ * It is also used externally to block regmap before executing multiple
+ * operations that must happen in sequence (which will use
+ * realtek_priv.map_nolock instead).
+ *
+ * Context: Any context. Holds priv->map_lock lock.
+ * Return: nothing
+ */
+void rtl83xx_lock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_lock(&priv->map_lock);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_lock, REALTEK_DSA);
+
+/**
+ * rtl83xx_unlock() - Unlocks the mutex used by regmaps
+ * @ctx: realtek_priv pointer
+ *
+ * This function unlocks the lock acquired by rtl83xx_lock.
+ *
+ * Context: Any context. Releases priv->map_lock lock
+ * Return: nothing
+ */
+void rtl83xx_unlock(void *ctx)
+{
+	struct realtek_priv *priv = ctx;
+
+	mutex_unlock(&priv->map_lock);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_unlock, REALTEK_DSA);
+
+/**
+ * rtl83xx_probe() - probe a Realtek switch
+ * @dev: the device being probed
+ * @interface_info: reg read/write methods for a specific management interface.
+ *
+ * This function initializes realtek_priv and read data from the device-tree
+ * node. The switch is hard resetted if a method is provided.
+ *
+ * Context: Any context.
+ * Return: Pointer to the realtek_priv or ERR_PTR() in case of failure.
+ *
+ * The realtek_priv pointer does not need to be freed as it is controlled by
+ * devres.
+ *
+ */
+struct realtek_priv *
+rtl83xx_probe(struct device *dev,
+	      const struct realtek_interface_info *interface_info)
+{
+	const struct realtek_variant *var;
+	struct realtek_priv *priv;
+	struct regmap_config rc = {
+			.reg_bits = 10, /* A4..A0 R4..R0 */
+			.val_bits = 16,
+			.reg_stride = 1,
+			.max_register = 0xffff,
+			.reg_format_endian = REGMAP_ENDIAN_BIG,
+			.reg_read = interface_info->reg_read,
+			.reg_write = interface_info->reg_write,
+			.cache_type = REGCACHE_NONE,
+			.lock = rtl83xx_lock,
+			.unlock = rtl83xx_unlock,
+	};
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
+	rc.disable_locking = true;
+	priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
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
+EXPORT_SYMBOL_NS_GPL(rtl83xx_probe, REALTEK_DSA);
+
+/**
+ * rtl83xx_register_switch() - detects and register a switch
+ * @priv: realtek_priv pointer
+ *
+ * This function first checks the switch chip ID and register a DSA
+ * switch.
+ *
+ * Context: Any context. Takes and releases priv->map_lock.
+ * Return: 0 on success, negative value for failure.
+ */
+int rtl83xx_register_switch(struct realtek_priv *priv)
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
+EXPORT_SYMBOL_NS_GPL(rtl83xx_register_switch, REALTEK_DSA);
+
+/**
+ * rtl83xx_remove() - Cleanup a realtek switch driver
+ * @ctx: realtek_priv pointer
+ *
+ * If a method is provided, this function asserts the hard reset of the switch
+ * in order to avoid leaking traffic when the driver is gone.
+ *
+ * Context: Any context.
+ * Return: nothing
+ */
+void rtl83xx_remove(struct realtek_priv *priv)
+{
+	if (!priv)
+		return;
+
+	/* leave the device reset asserted */
+	if (priv->reset)
+		gpiod_set_value(priv->reset, 1);
+}
+EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
+
+MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_DESCRIPTION("Realtek DSA switches common module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
new file mode 100644
index 000000000000..9eb8197a58fa
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RTL83XX_H
+#define _RTL83XX_H
+
+#include <linux/regmap.h>
+
+struct realtek_interface_info {
+	int (*reg_read)(void *ctx, u32 reg, u32 *val);
+	int (*reg_write)(void *ctx, u32 reg, u32 val);
+};
+
+void rtl83xx_lock(void *ctx);
+void rtl83xx_unlock(void *ctx);
+struct realtek_priv *
+rtl83xx_probe(struct device *dev,
+	      const struct realtek_interface_info *interface_info);
+int rtl83xx_register_switch(struct realtek_priv *priv);
+void rtl83xx_remove(struct realtek_priv *priv);
+
+#endif /* _RTL83XX_H */
-- 
2.43.0


