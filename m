Return-Path: <netdev+bounces-59997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C5A81D0DD
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 01:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26082856A1
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5B7384;
	Sat, 23 Dec 2023 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVqI+clt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EB1110
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d408d0bb87so16169535ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703292826; x=1703897626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45eQ2vRqi5Unnn+xLQEFxVBYomT3D7XbZEnfBHzEl9U=;
        b=BVqI+clt+YnyQurJJvn2ZHEJaAn4Cbh9FcgtIXXVQu4IHCagTIDcySmSHZ09ju5Ed/
         g18LswSs3E6ao7WgJvI/TGTjwrg4jW/CZd/XVClpSwCV/RKlTc40n1P2ioph3zwhz/Me
         nSAijKXuXJGswwQt87rNE+pixF4ShxvLGXOA0BXv7QADeBDxKy+1QHEPdnbIHUy1T5oc
         RFr6+lZy/2LwgBSU/CcWDddLtMVdodo4YgsjEDqH//9yk9XTiQWy2ilKs4U61A10v3AG
         Klf1anWK961iOv7BapujHiqvbHFGDrX0Tk1oXj3IKaU1n4NawQUP3gca6sgTEL8C2nh/
         NdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703292826; x=1703897626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45eQ2vRqi5Unnn+xLQEFxVBYomT3D7XbZEnfBHzEl9U=;
        b=j5QrE+a8+LAuWv20/m9xShtSyzBoj7vWO/gRTdSr9U2eDBUwtB+yaC1tTL2t6D5b0s
         IlfoqqsWA81XHnhllTpmThoHxGhNidxiEhOVVIZvyjk4cx1vndlos/fqy74mNoAKDqhi
         X3qT4R6uS/zNzs4CPOUFWQOK/oUuFLTengJlFO0YbycuFDv6spg1ZY9F+x+Cg4ZIlB9S
         q8CO1xY0Teii+xAcxL3/AffdNLarugjrIhjMuBWuFlKsCZzPfefm9FS3HJ7ngEZfVUKy
         AuYu2m1ovtfRffkhfNO4n31OrwjevBe1JVZZFfWVUixo7gwAFVY94LSUKTRtSpcY/n0u
         N2Yg==
X-Gm-Message-State: AOJu0Yww7xXMDPmNThjQ+QOQ92/Awfqg3mhOCxKJt7rsokGuX75P9a7S
	Wz4UQJfZ7s9GEAWrQrTI4letagDCmhdGCl2t
X-Google-Smtp-Source: AGHT+IGz6DMkWQ2BCacMCach+veA+DwcPxhwPZWS2nVPbgfEjAF1uJmY9oOtDdWaT+JUHPEKkVL1HQ==
X-Received: by 2002:a17:902:b193:b0:1d0:6ffd:9e24 with SMTP id s19-20020a170902b19300b001d06ffd9e24mr2074554plr.118.1703292825902;
        Fri, 22 Dec 2023 16:53:45 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm4028257plb.100.2023.12.22.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 16:53:45 -0800 (PST)
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
Subject: [PATCH net-next v3 2/8] net: dsa: realtek: convert variants into real drivers
Date: Fri, 22 Dec 2023 21:46:30 -0300
Message-ID: <20231223005253.17891-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223005253.17891-1-luizluca@gmail.com>
References: <20231223005253.17891-1-luizluca@gmail.com>
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
 drivers/net/dsa/realtek/Kconfig        | 20 +++-------
 drivers/net/dsa/realtek/realtek-mdio.c | 33 ++++------------
 drivers/net/dsa/realtek/realtek-mdio.h | 48 +++++++++++++++++++++++
 drivers/net/dsa/realtek/realtek-smi.c  | 38 ++++--------------
 drivers/net/dsa/realtek/realtek-smi.h  | 48 +++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb.c    | 54 +++++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8366rb.c    | 54 +++++++++++++++++++++++++-
 7 files changed, 222 insertions(+), 73 deletions(-)
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
index 292e6d087e8b..58966d0625c8 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-mdio.h"
 
 /* Read/write via mdiobus */
 #define REALTEK_MDIO_CTRL0_REG		31
@@ -140,7 +141,7 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
-static int realtek_mdio_probe(struct mdio_device *mdiodev)
+int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv;
 	struct device *dev = &mdiodev->dev;
@@ -235,8 +236,9 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(realtek_mdio_probe);
 
-static void realtek_mdio_remove(struct mdio_device *mdiodev)
+void realtek_mdio_remove(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -249,8 +251,9 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_GPL(realtek_mdio_remove);
 
-static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
+void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
 
@@ -261,29 +264,7 @@ static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 
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
+EXPORT_SYMBOL_GPL(realtek_mdio_shutdown);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
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
index 755546ed8db6..31ac409acfd0 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -40,6 +40,7 @@
 #include <linux/if_bridge.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
 
 #define REALTEK_SMI_ACK_RETRY_COUNT		5
 
@@ -408,7 +409,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
-static int realtek_smi_probe(struct platform_device *pdev)
+int realtek_smi_probe(struct platform_device *pdev)
 {
 	const struct realtek_variant *var;
 	struct device *dev = &pdev->dev;
@@ -505,8 +506,9 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(realtek_smi_probe);
 
-static void realtek_smi_remove(struct platform_device *pdev)
+void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -521,8 +523,9 @@ static void realtek_smi_remove(struct platform_device *pdev)
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
 }
+EXPORT_SYMBOL_GPL(realtek_smi_remove);
 
-static void realtek_smi_shutdown(struct platform_device *pdev)
+void realtek_smi_shutdown(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
@@ -533,34 +536,7 @@ static void realtek_smi_shutdown(struct platform_device *pdev)
 
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
+EXPORT_SYMBOL_GPL(realtek_smi_shutdown);
 
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
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
index 0875e4fc9f57..a4d0abd5a6bf 100644
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
index b39b719a5b8f..cc2fd636ec23 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -22,6 +22,8 @@
 #include <linux/regmap.h>
 
 #include "realtek.h"
+#include "realtek-smi.h"
+#include "realtek-mdio.h"
 
 #define RTL8366RB_PORT_NUM_CPU		5
 #define RTL8366RB_NUM_PORTS		6
@@ -1920,7 +1922,57 @@ const struct realtek_variant rtl8366rb_variant = {
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


