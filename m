Return-Path: <netdev+bounces-19402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674FC75A96B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238DC281B67
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1881BB56;
	Thu, 20 Jul 2023 08:30:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118118AF9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7877C00920;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841798;
	bh=7ySSkKjStDzOOF2fqFcYk8v1kG5xvtpuW9ZxOz+/+PE=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=NTWC2x7TAA6A6YWRGbQk9dCszLVteUxRbYuA+vKHAfVb07HVFGu/x9H8MaLhuBGA7
	 /lAMj6tpNr6IJspv8B8ce3m3zdfzeHC4iUQLI/siH22iNoHtTUEDJEV/cEeO+yk1uM
	 W24VAJ7IKoiTZwcI/sqjZwbjPfxIvcqlJ29vdXXUYOaj20cCuoLUWBUPlraQdoRYO7
	 Xj3vv+Ey378rbDzDdCeE3oGxhqLn7BIh9AU3BZSWgkzbmTDd8LuQQX1k6/g8cPy7P0
	 TiBK2FmydUwdNn11aYnqMcKW2eelMHqb6Xwj6L3cxWfu7D3k4ZwB7ePHRh5epYCQ1k
	 dwJkTcLVRBsVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E1C3DA49;
	Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:38 +0300
Subject: [PATCH v3 38/42] ata: pata_ep93xx: remove legacy pinctrl use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-38-3d63a5f1103e@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852591; l=5097;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Yfth7RCqN3bk1KCE0VD4AFUcLhcPkJPGr6wnRBug0VU=; =?utf-8?q?b=3DW+4pFo+57mpE?=
 =?utf-8?q?IkWI1WzLCkq37SkZsYf4y7isLCOQvX/Ldu6/JyH2OIR89vTIxSjEltpb3VQc3pyS?=
 qGEHOS81BAaTyJ/XxCrpq82upkbLGgt0aSedWJ1W7uOJj3KQJ2ru
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Drop legacy acquire/release since we are using pinctrl for this now.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/core.c       | 72 ---------------------------------------
 drivers/ata/pata_ep93xx.c         | 25 ++++----------
 include/linux/soc/cirrus/ep93xx.h |  4 ---
 3 files changed, 6 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 9afc6095d1c1..66dba9b4a6f9 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -778,78 +778,6 @@ void __init ep93xx_register_ide(void)
 	platform_device_register(&ep93xx_ide_device);
 }
 
-int ep93xx_ide_acquire_gpio(struct platform_device *pdev)
-{
-	int err;
-	int i;
-
-	err = gpio_request(EP93XX_GPIO_LINE_EGPIO2, dev_name(&pdev->dev));
-	if (err)
-		return err;
-	err = gpio_request(EP93XX_GPIO_LINE_EGPIO15, dev_name(&pdev->dev));
-	if (err)
-		goto fail_egpio15;
-	for (i = 2; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_E(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_e;
-	}
-	for (i = 4; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_G(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_g;
-	}
-	for (i = 0; i < 8; i++) {
-		err = gpio_request(EP93XX_GPIO_LINE_H(i), dev_name(&pdev->dev));
-		if (err)
-			goto fail_gpio_h;
-	}
-
-	/* GPIO ports E[7:2], G[7:4] and H used by IDE */
-	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
-				 EP93XX_SYSCON_DEVCFG_GONIDE |
-				 EP93XX_SYSCON_DEVCFG_HONIDE);
-	return 0;
-
-fail_gpio_h:
-	for (--i; i >= 0; --i)
-		gpio_free(EP93XX_GPIO_LINE_H(i));
-	i = 8;
-fail_gpio_g:
-	for (--i; i >= 4; --i)
-		gpio_free(EP93XX_GPIO_LINE_G(i));
-	i = 8;
-fail_gpio_e:
-	for (--i; i >= 2; --i)
-		gpio_free(EP93XX_GPIO_LINE_E(i));
-	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
-fail_egpio15:
-	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
-	return err;
-}
-EXPORT_SYMBOL(ep93xx_ide_acquire_gpio);
-
-void ep93xx_ide_release_gpio(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 2; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_E(i));
-	for (i = 4; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_G(i));
-	for (i = 0; i < 8; i++)
-		gpio_free(EP93XX_GPIO_LINE_H(i));
-	gpio_free(EP93XX_GPIO_LINE_EGPIO15);
-	gpio_free(EP93XX_GPIO_LINE_EGPIO2);
-
-
-	/* GPIO ports E[7:2], G[7:4] and H used by GPIO */
-	ep93xx_devcfg_set_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
-			       EP93XX_SYSCON_DEVCFG_GONIDE |
-			       EP93XX_SYSCON_DEVCFG_HONIDE);
-}
-EXPORT_SYMBOL(ep93xx_ide_release_gpio);
-
 /*************************************************************************
  * EP93xx ADC
  *************************************************************************/
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index a88824dfc5fa..22f9852715f1 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -928,28 +928,18 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 	void __iomem *ide_base;
 	int err;
 
-	err = ep93xx_ide_acquire_gpio(pdev);
-	if (err)
-		return err;
-
 	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		err = irq;
-		goto err_rel_gpio;
-	}
+	if (irq < 0)
+		return irq;
 
 	ide_base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
-	if (IS_ERR(ide_base)) {
-		err = PTR_ERR(ide_base);
-		goto err_rel_gpio;
-	}
+	if (IS_ERR(ide_base))
+		return PTR_ERR(ide_base);
 
 	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		err = -ENOMEM;
-		goto err_rel_gpio;
-	}
+	if (!drv_data)
+		return -ENXIO;
 
 	drv_data->pdev = pdev;
 	drv_data->ide_base = ide_base;
@@ -1006,8 +996,6 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
 
 err_rel_dma:
 	ep93xx_pata_release_dma(drv_data);
-err_rel_gpio:
-	ep93xx_ide_release_gpio(pdev);
 	return err;
 }
 
@@ -1019,7 +1007,6 @@ static int ep93xx_pata_remove(struct platform_device *pdev)
 	ata_host_detach(host);
 	ep93xx_pata_release_dma(drv_data);
 	ep93xx_pata_clear_regs(drv_data->ide_base);
-	ep93xx_ide_release_gpio(pdev);
 	return 0;
 }
 
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index ed94e4390b98..77490fe466c6 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -12,15 +12,11 @@ struct regmap;
 #define EP93XX_CHIP_REV_E2	7
 
 #if defined(CONFIG_EP93XX_SOC_COMMON)
-int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
-void ep93xx_ide_release_gpio(struct platform_device *pdev);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 unsigned int ep93xx_chip_revision(void);
 
 #else
-static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
 

-- 
2.39.2


