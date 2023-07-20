Return-Path: <netdev+bounces-19383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363EC75A957
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584EA1C212E2
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DD182A4;
	Thu, 20 Jul 2023 08:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A202174F0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8496C4E670;
	Thu, 20 Jul 2023 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689841796;
	bh=Icc0A/kj6yGqYeaOj4SJjOewb0mc8Woa4wczTJOoFwo=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:Reply-To:
	 From;
	b=e0uKYqNVqnMW7v1S4ZnwZbhakubhgeHsmxXOi4ur2uoAlIYAkT6QLG4SU9UhgdAe0
	 kAGXAGkii9/ECrZAG7pdHHgYJc2tjp6V3pfiVsq7pnxSkfpd3+17mEdK/YxN7icYCU
	 6Yl34bzaDwTEcALvrAJR8NvlBgjIAqQQn2UjMd1TBU3n7ysTOQYaX16/VWTwq1UUN0
	 F+Uv2iWEMD76OgsGdznqwiGHxw35O4LvzkMBM5ELL5DdLolxsRQvEilozTb1BWf+pL
	 n2uReCm8+Mdgek2VJVr1nse92N8XS1gdz+2owMIO/+xZ0gKQsIoxLOfEXN0W9bIu20
	 fRBY+TfeQfnqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8557FC0015E;
	Thu, 20 Jul 2023 08:29:56 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 20 Jul 2023 14:29:07 +0300
Subject: [PATCH v3 07/42] soc: Add SoC driver for Cirrus ep93xx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230605-ep93xx-v3-7-3d63a5f1103e@maquefel.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689852590; l=11384;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=hdAydcSmJdWTCsh9yNDgwo1kPIf17UX/m4OJVEY7qN4=; =?utf-8?q?b=3DKIYngc1oJbho?=
 =?utf-8?q?J3zNeKRkvNqM18Cfr+rAd7yueRxLazdHd5qw4z/g9gwaK3HzDy8suoitNbUl5g62?=
 ka3ygVV1Bu1FV4rg5Oo2ge6sFuLM4xCaEEj8JqCEvqdoxGml93VB
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

This adds an SoC driver for the ep93xx. Currently there
is only one thing not fitting into any other framework,
and that is the swlock setting.

It's used for clock settings and restart.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/cirrus/Kconfig        |  12 ++
 drivers/soc/cirrus/Makefile       |   2 +
 drivers/soc/cirrus/soc-ep93xx.c   | 231 ++++++++++++++++++++++++++++++++++++++
 include/linux/soc/cirrus/ep93xx.h |  18 ++-
 6 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 4e176280113a..16327b63b773 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -8,6 +8,7 @@ source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
+source "drivers/soc/cirrus/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..b76a03fe808e 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -9,6 +9,7 @@ obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
 obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_EP93XX_SOC)        += cirrus/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
new file mode 100644
index 000000000000..408f3343a265
--- /dev/null
+++ b/drivers/soc/cirrus/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+if ARCH_EP93XX
+
+config EP93XX_SOC
+	bool "Cirrus EP93xx chips SoC"
+	select SOC_BUS
+	default y if !EP93XX_SOC_COMMON
+	help
+	  Support SoC for Cirrus EP93xx chips.
+
+endif
diff --git a/drivers/soc/cirrus/Makefile b/drivers/soc/cirrus/Makefile
new file mode 100644
index 000000000000..ed6752844c6f
--- /dev/null
+++ b/drivers/soc/cirrus/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y	+= soc-ep93xx.o
diff --git a/drivers/soc/cirrus/soc-ep93xx.c b/drivers/soc/cirrus/soc-ep93xx.c
new file mode 100644
index 000000000000..2fd48d900f24
--- /dev/null
+++ b/drivers/soc/cirrus/soc-ep93xx.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SoC driver for Cirrus EP93xx chips.
+ * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/core.c
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
+ *
+ * Thanks go to Michael Burian and Ray Lehtiniemi for their key
+ * role in the ep93xx Linux community
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/soc/cirrus/ep93xx.h>
+
+#define EP93XX_EXT_CLK_RATE		14745600
+
+#define EP93XX_SYSCON_DEVCFG		0x80
+
+#define EP93XX_SWLOCK_MAGICK		0xaa
+#define EP93XX_SYSCON_SWLOCK		0xc0
+#define EP93XX_SYSCON_SYSCFG		0x9c
+#define EP93XX_SYSCON_SYSCFG_REV_MASK	0xf0000000
+#define EP93XX_SYSCON_SYSCFG_REV_SHIFT	28
+
+#define EP93XX_SYSCON_CLKSET1		0x20
+#define EP93XX_SYSCON_CLKSET1_NBYP1	BIT(23)
+#define EP93XX_SYSCON_CLKSET2		0x24
+#define EP93XX_SYSCON_CLKSET2_NBYP2	BIT(19)
+#define EP93XX_SYSCON_CLKSET2_PLL2_EN	BIT(18)
+
+static DEFINE_SPINLOCK(ep93xx_swlock);
+
+/* EP93xx System Controller software locked register write */
+void ep93xx_syscon_swlocked_write(struct regmap *map, unsigned int reg, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ep93xx_swlock, flags);
+
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, reg, val);
+
+	spin_unlock_irqrestore(&ep93xx_swlock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(ep93xx_syscon_swlocked_write, EP93XX_SOC);
+
+void ep93xx_devcfg_set_clear(struct regmap *map, unsigned int set_bits, unsigned int clear_bits)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&ep93xx_swlock, flags);
+
+	regmap_read(map, EP93XX_SYSCON_DEVCFG, &val);
+	val &= ~clear_bits;
+	val |= set_bits;
+	regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+	regmap_write(map, EP93XX_SYSCON_DEVCFG, val);
+
+	spin_unlock_irqrestore(&ep93xx_swlock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(ep93xx_devcfg_set_clear, EP93XX_SOC);
+
+void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int reg,
+				 unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+	unsigned int tmp, orig;
+
+	spin_lock_irqsave(&ep93xx_swlock, flags);
+
+	regmap_read(map, EP93XX_SYSCON_DEVCFG, &orig);
+	tmp = orig & ~mask;
+	tmp |= val & mask;
+	if (tmp != orig) {
+		regmap_write(map, EP93XX_SYSCON_SWLOCK, EP93XX_SWLOCK_MAGICK);
+		regmap_write(map, reg, tmp);
+	}
+
+	spin_unlock_irqrestore(&ep93xx_swlock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(ep93xx_swlocked_update_bits, EP93XX_SOC);
+
+unsigned int __init ep93xx_chip_revision(struct regmap *map)
+{
+	unsigned int val;
+
+	regmap_read(map, EP93XX_SYSCON_SYSCFG, &val);
+	val &= EP93XX_SYSCON_SYSCFG_REV_MASK;
+	val >>= EP93XX_SYSCON_SYSCFG_REV_SHIFT;
+	return val;
+}
+
+static const char __init *ep93xx_get_soc_rev(struct regmap *map)
+{
+	int rev = ep93xx_chip_revision(map);
+
+	switch (rev) {
+	case EP93XX_CHIP_REV_D0:
+		return "D0";
+	case EP93XX_CHIP_REV_D1:
+		return "D1";
+	case EP93XX_CHIP_REV_E0:
+		return "E0";
+	case EP93XX_CHIP_REV_E1:
+		return "E1";
+	case EP93XX_CHIP_REV_E2:
+		return "E2";
+	default:
+		return "unknown";
+	}
+}
+
+/*
+ * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
+ */
+static unsigned long __init calc_pll_rate(u64 rate, u32 config_word)
+{
+	rate *= ((config_word >> 11) & GENMASK(4, 0)) + 1;	/* X1FBD */
+	rate *= ((config_word >> 5) & GENMASK(5, 0)) + 1;	/* X2FBD */
+	do_div(rate, (config_word & GENMASK(4, 0)) + 1);	/* X2IPD */
+	rate >>= ((config_word >> 16) & 3);			/* PS */
+
+	return rate;
+}
+
+static int __init ep93xx_soc_init(void)
+{
+	struct soc_device_attribute *attrs;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	struct regmap *map;
+	struct clk_hw *hw;
+	unsigned long clk_pll1_rate, clk_pll2_rate;
+	unsigned int clk_f_div, clk_h_div, clk_p_div, clk_usb_div;
+	const char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
+	const char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
+	const char pclk_divisors[] = { 1, 2, 4, 8 };
+	const char *machine = NULL;
+	u32 value;
+
+	/* Multiplatform guard, only proceed on ep93xx */
+	if (!of_machine_is_compatible("cirrus,ep9301"))
+		return 0;
+
+	map = syscon_regmap_lookup_by_compatible("cirrus,ep9301-syscon");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/* Determine the bootloader configured pll1 rate */
+	regmap_read(map, EP93XX_SYSCON_CLKSET1, &value);
+	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
+		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
+	else
+		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	/* Initialize the pll1 derived clocks */
+	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
+	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
+	clk_p_div = pclk_divisors[(value >> 18) & 0x3];
+
+	hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	/* Determine the bootloader configured pll2 rate */
+	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
+	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
+		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
+	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
+		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+	else
+		clk_pll2_rate = 0;
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	regmap_read(map, EP93XX_SYSCON_CLKSET2, &value);
+	clk_usb_div = (((value >> 28) & GENMASK(3, 0)) + 1);
+	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &machine);
+	if (machine)
+		attrs->machine = kstrdup(machine, GFP_KERNEL);
+	of_node_put(np);
+
+	attrs->family = "Cirrus Logic EP93xx";
+	attrs->revision = ep93xx_get_soc_rev(map);
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev)) {
+		kfree(attrs->soc_id);
+		kfree(attrs->serial_number);
+		kfree(attrs);
+		return PTR_ERR(soc_dev);
+	}
+
+	pr_info("EP93xx SoC revision %s\n", attrs->revision);
+
+	return 0;
+}
+core_initcall(ep93xx_soc_init);
diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..f38937a6f08c 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -3,6 +3,7 @@
 #define _SOC_EP93XX_H
 
 struct platform_device;
+struct regmap;
 
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
@@ -10,7 +11,7 @@ struct platform_device;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
-#ifdef CONFIG_ARCH_EP93XX
+#if defined(CONFIG_EP93XX_SOC_COMMON)
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
@@ -30,7 +31,22 @@ static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { ret
 static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
 static inline int ep93xx_i2s_acquire(void) { return 0; }
 static inline void ep93xx_i2s_release(void) {}
+
+#if defined(CONFIG_EP93XX_SOC)
+void ep93xx_syscon_swlocked_write(struct regmap *map, unsigned int reg, unsigned int val);
+void ep93xx_devcfg_set_clear(struct regmap *map, unsigned int set_bits, unsigned int clear_bits);
+void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int reg,
+				 unsigned int mask, unsigned int val);
+#else
+static inline void ep93xx_syscon_swlocked_write(struct regmap *map, unsigned int reg,
+						unsigned int val) { }
+static inline void ep93xx_devcfg_set_clear(struct regmap *map, unsigned int set_bits,
+						unsigned int clear_bits) { }
+
+void ep93xx_swlocked_update_bits(struct regmap *map, unsigned int reg,
+				unsigned int mask, unsigned int val) { }
 static inline unsigned int ep93xx_chip_revision(void) { return 0; }
+#endif
 
 #endif
 

-- 
2.39.2


