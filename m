Return-Path: <netdev+bounces-65228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50D839B4E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722F81C21860
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A983D570;
	Tue, 23 Jan 2024 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4ZyHfwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F63D566
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046284; cv=none; b=Sdazm7Cq9WKQvAd3Odt88W5cikFoevNB9uABQHJRQpCfYYFVoCsUqYPsYxExX5pM0kzpusLK2OBitzdSafACndLNeWWP/W0Fs8py3F8LZi4pz2bGSH4aqVCPuGz998XUakG392SfAwzYFB2JVrVGKLyIqx+t81HoS4Ry4BUcdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046284; c=relaxed/simple;
	bh=5aALzbuhfhobesH+1J/zCqBKWfr8+X/99JULSE4qCD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8GxoqiSCwfhneIJJL4MFvWMiACS7OQX3kf3kAkoeRw/0f3/mq1W/8/Li39LkQW0kQ6IfuudphMihFY1w46xJIIIMupug0xSKUS7lQEhez+qf/qwJJlQPQiJCvPvLYp6JDvwaAGgScrzxLislmwWQVsYEfpqPCJ7oR/YVUJIAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4ZyHfwA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d731314e67so14621435ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046281; x=1706651081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8l162FyL7BsSvEnm9+5KTuz+1GnUBpR9xqcqVw78Y8=;
        b=c4ZyHfwA29T1i9J+JMwcd/VmUmrmVPjZYFscVsazpzgPlHHg0AVDEnF2DTmtk8oyHg
         sIjfNRuFPAw5DkXLPlisRTADIsccpPA1c4hNR8LTb6ba7H3SFTqB2FKfShJTennuke76
         lTKUjfmM67K6j4W7lstluj8FuYnMe6bgYJ1cdxO2S0BoeGcVlsyM7DOrfRjPfzbjgGyK
         Ef2SzE1GJ3hodNVwLSk/2UxbMha9CZWbasncEH3fp8wu4M773lwaCMCmz7en23LO4Wxj
         nx/5/21tBb7mocihRYxs/Mqanrw1c46Q2LsVSNoisxs4LleIvWge53Qa/HylghiVYfh5
         7sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046281; x=1706651081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8l162FyL7BsSvEnm9+5KTuz+1GnUBpR9xqcqVw78Y8=;
        b=A/jnfTsnaSWUQpu/gNLtxiuWxYcYiET4+oTsRHcqHZOYoL1j7x6ALxjAFD8JGB0WCy
         0+9VPR2VzuSpSgoo1dl3EGlslHEs2+ZKLcMmn4JIjghl3lV2gVBinOBTobEegJ/a+X8j
         bqKYfBp9AIXh8W94wSwEetFjbDAbVUCU4fzCbjh7UzvnnlRgiXa/LCdMw1ptVCSJwRjh
         y6qkP9n/1PIrVl4ocnc8isfFgMpJVFfeFtryOE1vIPLvyuP2dL9c/zRShjcG++RxQcM4
         8uQCDcsg68nvH2HUtfgRvQnvbRw5Z9VehFAR8jxk5fViJgjDWE2ChL2jOMFPqOBpAlqB
         B4iw==
X-Gm-Message-State: AOJu0Yxc7AMahheNs4nGSu/LtgMretC2BBCxwX00COWQITVU/Jm1Yqm4
	Qk0FVH7oFNB8h7NdfqCLoMS7/m8bVWjf4UEkgnEIUcT5MdNxZua2unJmu+5JD3s=
X-Google-Smtp-Source: AGHT+IHIcorwJ3QO0GQe3dFO8/ZwyKlp4iF/JQOjHttRNWzdviCibMnTz1u3fXq7yJSMLZu9zY3+YA==
X-Received: by 2002:a17:902:9344:b0:1d4:98fd:376d with SMTP id g4-20020a170902934400b001d498fd376dmr3120813plp.139.1706046280742;
        Tue, 23 Jan 2024 13:44:40 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8108858plz.176.2024.01.23.13.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:40 -0800 (PST)
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
Subject: [PATCH 03/11] net: dsa: realtek: convert variants into real drivers
Date: Tue, 23 Jan 2024 18:44:11 -0300
Message-ID: <20240123214420.25716-4-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123214420.25716-1-luizluca@gmail.com>
References: <20240123214420.25716-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, the interface modules realtek-smi and realtek-mdio served as
a platform and an MDIO driver, respectively. Each interface module
redundantly specified the same compatible strings for both variants and
referenced symbols from the variants.

Now, each variant module has been transformed into a unified driver
serving both as a platform and an MDIO driver. This modification
reverses the relationship between the interface and variant modules,
with the variant module now utilizing symbols from the interface
modules.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Kconfig        | 20 ++-----
 drivers/net/dsa/realtek/realtek-mdio.c | 71 ++++++++++++++----------
 drivers/net/dsa/realtek/realtek-mdio.h | 48 ++++++++++++++++
 drivers/net/dsa/realtek/realtek-smi.c  | 76 +++++++++++++++-----------
 drivers/net/dsa/realtek/realtek-smi.h  | 48 ++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb.c    | 54 +++++++++++++++++-
 drivers/net/dsa/realtek/rtl8366rb.c    | 54 +++++++++++++++++-
 7 files changed, 294 insertions(+), 77 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/realtek-mdio.h
 create mode 100644 drivers/net/dsa/realtek/realtek-smi.h

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 060165a85fb7..9d182fde11b4 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,37 +16,29 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface driver"
+	tristate "Realtek MDIO interface support"
 	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface driver"
+	tristate "Realtek SMI interface support"
 	depends on OF
-	depends on NET_DSA_REALTEK_RTL8365MB || NET_DSA_REALTEK_RTL8366RB
-	depends on NET_DSA_REALTEK_RTL8365MB || !NET_DSA_REALTEK_RTL8365MB
-	depends on NET_DSA_REALTEK_RTL8366RB || !NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for registering switches connected
 	  through SMI.
 
 config NET_DSA_REALTEK_RTL8365MB
-	tristate "Realtek RTL8365MB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	tristate "Realtek RTL8365MB switch driver"
+	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL8_4
 	help
 	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
 
 config NET_DSA_REALTEK_RTL8366RB
-	tristate "Realtek RTL8366RB switch subdriver"
-	imply NET_DSA_REALTEK_SMI
-	imply NET_DSA_REALTEK_MDIO
+	tristate "Realtek RTL8366RB switch driver"
+	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL4_A
 	help
 	  Select to enable support for Realtek RTL8366RB.
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index df214b2f60d1..22a63f41e3f2 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-mdio.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -140,7 +141,20 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
-static int realtek_mdio_probe(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_probe() - Probe a platform device for an MDIO-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .probe in an mdio_driver. It
+ * initializes realtek_priv and read data from the device-tree node. The switch
+ * is hard resetted if a method is provided. It checks the switch chip ID and,
+ * finally, a DSA switch is registered.
+ *
+ * Context: Any context. Takes and releases priv->map_lock.
+ * Return: Returns 0 on success, a negative error on failure.
+ *
+ */
+int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
@@ -235,8 +249,21 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_probe, REALTEK_DSA);
 
-static void realtek_mdio_remove(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_remove() - Remove the driver of an MDIO-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .remove_new in an mdio_driver. First
+ * it unregisters the DSA switch and cleans internal data. If a method is
+ * provided, the hard reset is asserted to avoid traffic leakage.
+ *
+ * Context: Any context.
+ * Return: Nothing.
+ *
+ */
+void realtek_mdio_remove(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -249,8 +276,20 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
 
-static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
+/**
+ * realtek_mdio_shutdown() - Shutdown the driver of a MDIO-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .shutdown in an mdio_driver. It shuts
+ * down the DSA switch and cleans the platform driver data.
+ *
+ * Context: Any context.
+ * Return: Nothing.
+ *
+ */
+void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -261,32 +300,8 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
 }
-
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
-static struct mdio_driver realtek_mdio_driver = {
-	.mdiodrv.driver = {
-		.name = "realtek-mdio",
-		.of_match_table = realtek_mdio_of_match,
-	},
-	.probe  = realtek_mdio_probe,
-	.remove = realtek_mdio_remove,
-	.shutdown = realtek_mdio_shutdown,
-};
-
-mdio_module_driver(realtek_mdio_driver);
+EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
-
diff --git a/drivers/net/dsa/realtek/realtek-mdio.h b/drivers/net/dsa/realtek/realtek-mdio.h
new file mode 100644
index 000000000000..ee70f6a5b8ff
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-mdio.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_MDIO_H
+#define _REALTEK_MDIO_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO)
+
+static inline int realtek_mdio_driver_register(struct mdio_driver *drv)
+{
+	return mdio_driver_register(drv);
+}
+
+static inline void realtek_mdio_driver_unregister(struct mdio_driver *drv)
+{
+	mdio_driver_unregister(drv);
+}
+
+int realtek_mdio_probe(struct mdio_device *mdiodev);
+void realtek_mdio_remove(struct mdio_device *mdiodev);
+void realtek_mdio_shutdown(struct mdio_device *mdiodev);
+
+#else /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO) */
+
+static inline int realtek_mdio_driver_register(struct mdio_driver *drv)
+{
+	return 0;
+}
+
+static inline void realtek_mdio_driver_unregister(struct mdio_driver *drv)
+{
+}
+
+static inline int realtek_mdio_probe(struct mdio_device *mdiodev)
+{
+	return -ENOENT;
+}
+
+static inline void realtek_mdio_remove(struct mdio_device *mdiodev)
+{
+}
+
+static inline void realtek_mdio_shutdown(struct mdio_device *mdiodev)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_MDIO) */
+
+#endif /* _REALTEK_MDIO_H */
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index f628b54de538..618547befa13 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -408,7 +409,20 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
-static int realtek_smi_probe(struct platform_device *pdev)
+/**
+ * realtek_smi_probe() - Probe a platform device for an SMI-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .probe in a platform_driver. It
+ * initializes realtek_priv and read data from the device-tree node. The switch
+ * is hard resetted if a method is provided. It checks the switch chip ID and,
+ * finally, a DSA switch is registered.
+ *
+ * Context: Any context. Takes and releases priv->map_lock.
+ * Return: Returns 0 on success, a negative error on failure.
+ *
+ */
+int realtek_smi_probe(struct platform_device *pdev)
 {
 	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
@@ -505,8 +519,21 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(realtek_smi_probe, REALTEK_DSA);
 
-static void realtek_smi_remove(struct platform_device *pdev)
+/**
+ * realtek_smi_remove() - Remove the driver of a SMI-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .remove_new in a platform_driver. First
+ * it unregisters the DSA switch and cleans internal data. If a method is
+ * provided, the hard reset is asserted to avoid traffic leakage.
+ *
+ * Context: Any context.
+ * Return: Nothing.
+ *
+ */
+void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -521,8 +548,20 @@ static void realtek_smi_remove(struct platform_device *pdev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
 
-static void realtek_smi_shutdown(struct platform_device *pdev)
+/**
+ * realtek_smi_shutdown() - Shutdown the driver of a SMI-connected switch
+ * @pdev: platform_device to probe on.
+ *
+ * This function should be used as the .shutdown in a platform_driver. It shuts
+ * down the DSA switch and cleans the platform driver data.
+ *
+ * Context: Any context.
+ * Return: Nothing.
+ *
+ */
+void realtek_smi_shutdown(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -533,37 +572,8 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 }
-
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
-static struct platform_driver realtek_smi_driver = {
-	.driver = {
-		.name = "realtek-smi",
-		.of_match_table = realtek_smi_of_match,
-	},
-	.probe  = realtek_smi_probe,
-	.remove_new = realtek_smi_remove,
-	.shutdown = realtek_smi_shutdown,
-};
-module_platform_driver(realtek_smi_driver);
+EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
-
diff --git a/drivers/net/dsa/realtek/realtek-smi.h b/drivers/net/dsa/realtek/realtek-smi.h
new file mode 100644
index 000000000000..ea49a2edd3c8
--- /dev/null
+++ b/drivers/net/dsa/realtek/realtek-smi.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _REALTEK_SMI_H
+#define _REALTEK_SMI_H
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI)
+
+static inline int realtek_smi_driver_register(struct platform_driver *drv)
+{
+	return platform_driver_register(drv);
+}
+
+static inline void realtek_smi_driver_unregister(struct platform_driver *drv)
+{
+	platform_driver_unregister(drv);
+}
+
+int realtek_smi_probe(struct platform_device *pdev);
+void realtek_smi_remove(struct platform_device *pdev);
+void realtek_smi_shutdown(struct platform_device *pdev);
+
+#else /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI) */
+
+static inline int realtek_smi_driver_register(struct platform_driver *drv)
+{
+	return 0;
+}
+
+static inline void realtek_smi_driver_unregister(struct platform_driver *drv)
+{
+}
+
+static inline int realtek_smi_probe(struct platform_device *pdev)
+{
+	return -ENOENT;
+}
+
+static inline void realtek_smi_remove(struct platform_device *pdev)
+{
+}
+
+static inline void realtek_smi_shutdown(struct platform_device *pdev)
+{
+}
+
+#endif /* IS_ENABLED(CONFIG_NET_DSA_REALTEK_SMI) */
+
+#endif  /* _REALTEK_SMI_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 462d5a9a280e..bd76bcf5fa44 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -101,6 +101,8 @@
 #include <linux/if_vlan.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
+#include "realtek-mdio.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -2172,7 +2174,57 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
 };
-EXPORT_SYMBOL_GPL(rtl8365mb_variant);
+
+static const struct of_device_id rtl8365mb_of_match[] = {
+	{ .compatible = "realtek,rtl8365mb", .data = &rtl8365mb_variant, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
+
+static struct platform_driver rtl8365mb_smi_driver = {
+	.driver = {
+		.name = "rtl8365mb-smi",
+		.of_match_table = rtl8365mb_of_match,
+	},
+	.probe  = realtek_smi_probe,
+	.remove_new = realtek_smi_remove,
+	.shutdown = realtek_smi_shutdown,
+};
+
+static struct mdio_driver rtl8365mb_mdio_driver = {
+	.mdiodrv.driver = {
+		.name = "rtl8365mb-mdio",
+		.of_match_table = rtl8365mb_of_match,
+	},
+	.probe  = realtek_mdio_probe,
+	.remove = realtek_mdio_remove,
+	.shutdown = realtek_mdio_shutdown,
+};
+
+static int rtl8365mb_init(void)
+{
+	int ret;
+
+	ret = realtek_mdio_driver_register(&rtl8365mb_mdio_driver);
+	if (ret)
+		return ret;
+
+	ret = realtek_smi_driver_register(&rtl8365mb_smi_driver);
+	if (ret) {
+		realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(rtl8365mb_init);
+
+static void __exit rtl8365mb_exit(void)
+{
+	realtek_smi_driver_unregister(&rtl8365mb_smi_driver);
+	realtek_mdio_driver_unregister(&rtl8365mb_mdio_driver);
+}
+module_exit(rtl8365mb_exit);
 
 MODULE_AUTHOR("Alvin Šipraga <alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC ethernet switch");
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index baeab5445d99..74e14b73a1ec 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -23,6 +23,8 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
+#include "realtek-mdio.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1933,7 +1935,57 @@ const struct realtek_variant rtl8366rb_variant = {
 	.cmd_write = 0xa8,
 	.chip_data_sz = sizeof(struct rtl8366rb),
 };
-EXPORT_SYMBOL_GPL(rtl8366rb_variant);
+
+static const struct of_device_id rtl8366rb_of_match[] = {
+	{ .compatible = "realtek,rtl8366rb", .data = &rtl8366rb_variant, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rtl8366rb_of_match);
+
+static struct platform_driver rtl8366rb_smi_driver = {
+	.driver = {
+		.name = "rtl8366rb-smi",
+		.of_match_table = rtl8366rb_of_match,
+	},
+	.probe  = realtek_smi_probe,
+	.remove_new = realtek_smi_remove,
+	.shutdown = realtek_smi_shutdown,
+};
+
+static struct mdio_driver rtl8366rb_mdio_driver = {
+	.mdiodrv.driver = {
+		.name = "rtl8366rb-mdio",
+		.of_match_table = rtl8366rb_of_match,
+	},
+	.probe  = realtek_mdio_probe,
+	.remove = realtek_mdio_remove,
+	.shutdown = realtek_mdio_shutdown,
+};
+
+static int rtl8366rb_init(void)
+{
+	int ret;
+
+	ret = realtek_mdio_driver_register(&rtl8366rb_mdio_driver);
+	if (ret)
+		return ret;
+
+	ret = realtek_smi_driver_register(&rtl8366rb_smi_driver);
+	if (ret) {
+		realtek_mdio_driver_unregister(&rtl8366rb_mdio_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(rtl8366rb_init);
+
+static void __exit rtl8366rb_exit(void)
+{
+	realtek_smi_driver_unregister(&rtl8366rb_smi_driver);
+	realtek_mdio_driver_unregister(&rtl8366rb_mdio_driver);
+}
+module_exit(rtl8366rb_exit);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for RTL8366RB ethernet switch");
-- 
2.43.0


