Return-Path: <netdev+bounces-19385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AE75A959
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BB2810C9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84385182B6;
	Thu, 20 Jul 2023 08:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D361774A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68AA2C611BB;
	Thu, 20 Jul 2023 08:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841797;
	bh=ct/EpuMvdUCuMjjViIZ5tkc4m9rWwQV30W6wJGWQmXQ=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=f7VetNXkHGEwNxsJGXYEsLDGzhyKv0QX6gOJXr+7h/Yqy7G7z87TpnlfcArekXxHL
	 3a9rGKxCB5FLOtbN6/oOgs116+rebxMeLRMvMU0leLI8gseRJ5tjxDonh4owOR3aI9
	 KEOG78YjnY0n/yKXVuWbivQ9Ihi2+T/fBaKJ/GMePD9QHza8pFOuGfaLQSQP+95Q1H
	 Ji6G3rvf84lvtaTTGNlPSe5xFz8VqBxQ8LyMveMTf5q134+AIDKqzGFKUh02spxKJz
	 TwXRTrPzXdufRD8iHjZdk5RZ90vhr5EjrZ6LwqyoYgcp2NUJamRXE2kFIS9y8r9MK/
	 RZmUtCXEJDZ8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D9C05051;
	Thu, 20 Jul 2023 08:29:57 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:14 +0300
Subject: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
List-Id: <soc.lore.kernel.org>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Lennert Buytenhek <kernel@wantstofly.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, soc@kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>, 
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org, 
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852590; l=4404;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=jarF+KELK7mZorvLAgBXky3sB5pXOZlhQ5qnPmmBEEc=; =?utf-8?q?b=3DsU2/xrwREaEF?=
 =?utf-8?q?hfdVfzNIHKHyeuUxFdGxGcpzUMuQQY86vWK69t09xviiikO7SiDRkSFcdJG9PuZV?=
 hHMf4YqYDw3cUCWElglNk3PsyWdNstIDwmSDzYvqa1AWe2iFMrtc
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Implement the reset behaviour of the various EP93xx SoCS in drivers/power/reset.

It used to be located in arch/arm/mach-ep93xx.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/Kconfig          | 10 +++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/ep93xx-restart.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fff07b2bd77b..9c2aa9218841 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -75,6 +75,16 @@ config POWER_RESET_BRCMSTB
 	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
+config POWER_RESET_EP93XX
+	bool "Cirrus EP93XX reset driver" if COMPILE_TEST
+	depends on MFD_SYSCON
+	default ARCH_EP93XX
+	help
+	  This driver provides restart support for Cirrus EP93XX SoC.
+
+	  Say Y here if you have a Cirrus EP93XX SoC and you wish
+	  to have restart support.
+
 config POWER_RESET_GEMINI_POWEROFF
 	bool "Cortina Gemini power-off driver"
 	depends on ARCH_GEMINI || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index d763e6735ee3..61f4e11619b2 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
+obj-$(CONFIG_POWER_RESET_EP93XX) += ep93xx-restart.o
 obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
diff --git a/drivers/power/reset/ep93xx-restart.c b/drivers/power/reset/ep93xx-restart.c
new file mode 100644
index 000000000000..1f5be7de8719
--- /dev/null
+++ b/drivers/power/reset/ep93xx-restart.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Cirrus EP93xx SoC reset driver
+ *
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/notifier.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_SYSCON_DEVCFG_SWRST	BIT(31)
+
+struct ep93xx_restart {
+	struct regmap *map;
+	struct notifier_block restart_handler;
+};
+
+static int ep93xx_restart_handle(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct ep93xx_restart *priv =
+		container_of(this, struct ep93xx_restart, restart_handler);
+
+	/* Issue the reboot */
+	ep93xx_devcfg_set_clear(priv->map, EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
+	ep93xx_devcfg_set_clear(priv->map, 0x00, EP93XX_SYSCON_DEVCFG_SWRST);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static int ep93xx_reboot_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ep93xx_restart *priv;
+	struct device_node *parent;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	parent = of_get_parent(dev->of_node);
+	if (!parent)
+		return dev_err_probe(dev, -EINVAL, "no syscon parent for reboot node\n");
+
+	priv->map = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, -EINVAL, "no syscon regmap\n");
+
+	priv->restart_handler.notifier_call = ep93xx_restart_handle;
+	priv->restart_handler.priority = 128;
+
+	err = register_restart_handler(&priv->restart_handler);
+	if (err)
+		return dev_err_probe(dev, err, "can't register restart notifier\n");
+
+	return err;
+}
+
+static const struct of_device_id ep93xx_reboot_of_match[] = {
+	{
+		.compatible = "cirrus,ep9301-reboot",
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ep93xx_reboot_driver = {
+	.probe = ep93xx_reboot_probe,
+	.driver = {
+		.name = "ep9301-reboot",
+		.of_match_table = ep93xx_reboot_of_match,
+	},
+};
+builtin_platform_driver(ep93xx_reboot_driver);
+MODULE_IMPORT_NS(EP93XX_SOC);

-- 
2.39.2


