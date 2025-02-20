Return-Path: <netdev+bounces-168251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC78A3E42C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8390189C847
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA7262D28;
	Thu, 20 Feb 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+RYnJRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165271E3761
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077306; cv=none; b=oyj3FmslehIjLKwgNk8wR5GvWk0f765CShv/DKwmks0rYrkdqyZwP37VRsUeEVL/O6Ogpvplv6VcmugWCJ3Qi1oIzMYzK46BH1Rt3lLxbWHp6SqTtUnNfH6kBbwodGMxxXeonLuptGceU4JW0lZGihBmewlWXyJTR657lN8IqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077306; c=relaxed/simple;
	bh=ALVKWAYI/rO2RaxclCkCVhF2c8x0g/AfB1J6kLEN/ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f/aikvBtXfrjPXKcjwsAwoWw4I/4g3/JcrJCp5IhKxMmUCa9sAQQOZySW3wDH0BYnmeH+ONdv3myvpIUE/LOsKXZJO5oYjy9W4v7zLj2YOAc7gSwn8T4EspF9DXgno9O57LvhrCS2+o/xRdchsMm8OH0Ax4smCfZdGb3kI2YyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+RYnJRc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5439e331cceso1413483e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740077302; x=1740682102; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wksjJf5D/KFQLzw0uZ4ShJDddgV8o7G60QS70nBoV7U=;
        b=V+RYnJRcLJaU+mG6La3NoYnlJhrji1P589REQalcl0h5MIKnYrD+gUk93u6s7xNF5+
         e3oJIofVisY3vWVPCgiCi4yZEH+n90vdJ6KDatEkQxYCjjZahCLhj5odsL2YFHQL66nf
         rlGrSoRcjMdHbNm8dLL5Oi8Ry7nL4FNRCM3H/mcJz9Nm7CZdPKnO4R5OnR7kl1iGSJxB
         kwVagCauEx6TbrL8g6flJ2hGSugZBY1IL/0N67ZetbXRWWlzJZkKtTJYDAt7p1mg2csW
         E/ta8hi63lYexkRRoQVVne8oJZPOwbPZSjNcQVB09Vx6GvXud1i2PW3FPP3WP4A8u9NW
         zKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077302; x=1740682102;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wksjJf5D/KFQLzw0uZ4ShJDddgV8o7G60QS70nBoV7U=;
        b=I3vDdVHy8wE5koQIhEb0iiZ8DHFLGNM8DmvOGsKPPi9axbYJcD5jVu0YnQGp6sqsBg
         rdQbpX9jnaMJLz4cZ/rDduwDStod3V1b5es49QRxF5p2CP9ESRORIzfKLoIyN+0vKciB
         ABnxsnDqa3UPvRjBn9R0+m9eFf5KPYvNBQ275aNgsjJip66pvdStChC6BmMN6syt2Ax0
         sQn/kSnT1JUnvtrdJvnCjfnQDwjSaeCtleCii8Xo48Z5ljehVeYPrOBPxQpV8NkPphn7
         EbVs2J/r7zPJWHFzFVxK09m8qehoej0s3ufB7eByLVDe8Vu0C5lsDFRUAyabcHr3exfx
         az1g==
X-Gm-Message-State: AOJu0Yw0x8+6TstNS2jBiAc7tqv2k92OmragRsdn+Xm0QJnlOX+esrof
	flqc/ziB6amZq9ejXfZGALdYc4J1qgZD9kntcGGx1abJVPzUt5mg3vIrcyClpTQ=
X-Gm-Gg: ASbGncsM82BYKhu30VtrKeselIhCaCOhUOC8yBVYNIR/th5eZByt44i7BPQFk0xEFa2
	1Hw1lHGv6E/l2YATr8iPRKwuv3CIEKo6++7+oNcMz/9iBzS3uTTNuBQlmC27kY7QnaFCMe1O25K
	8pzRhF7DjtC3xIvachjJh8tRoGEAkA1Vg1PLIUr58rzAyp8x6sWazdlpUnypOFLHLB8/NfUluPQ
	RYJngoBygno+fES1RuiYak0Ca1smEvkzJSKtlOq72VuL37L08XjKGMRnfPLB3geqhiCh/VuuYhQ
	o2QFoSs18oEdT8SE1pAnoTUxaA==
X-Google-Smtp-Source: AGHT+IHmu8C/3IFJw5aqIrhIZ30mDBCqNPDIrnN+klrWf94x2DyoLdfqJuZodfJHPn5svcNkDXZOcQ==
X-Received: by 2002:a19:2d0d:0:b0:545:fad:dba9 with SMTP id 2adb3069b0e04-54838ef5df3mr34479e87.27.1740077301878;
        Thu, 20 Feb 2025 10:48:21 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461a4c5d48sm1644122e87.147.2025.02.20.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:48:21 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Feb 2025 19:48:15 +0100
Subject: [PATCH v3] net: dsa: rtl8366rb: Fix compilation problem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO54t2cC/4XN0QrCIBTG8VcZXmfocQ7pqveILkyPm2AzdEkx9
 u65QVA3dfk/fPzOTDImj5kcmpkkLD77ONYQu4aYQY89Um9rE2AgGXBB0xSU6Lp0oQFtpiZebz7
 UVc53pNZYMMJI5tCRStwSOv/Y+NO59uDzFNNz+1b4en3D7W+4cMqpabUCxE5JpY7BjzrFfUw9W
 eUCHxqwPxpUTTmFTmrh6v5LW5blBSs9nfQXAQAA
X-Change-ID: 20250213-rtl8366rb-leds-compile-issue-dcd2c3c50fef
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

When the kernel is compiled without LED framework support the
rtl8366rb fails to build like this:

rtl8366rb.o: in function `rtl8366rb_setup_led':
rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
  undefined reference to `led_init_default_state_get'
rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
  undefined reference to `devm_led_classdev_register_ext'

As this is constantly coming up in different randconfig builds,
bite the bullet and create a separate file for the offending
code, split out a header with all stuff needed both in the
core driver and the leds code.

Add a new bool Kconfig option for the LED compile target, such
that it depends on LEDS_CLASS=y || LEDS_CLASS=RTL8366RB
which make LED support always available when LEDS_CLASS is
compiled into the kernel and enforce that if the LEDS_CLASS
is a module, then the RTL8366RB driver needs to be a module
as well so that modprobe can resolve the dependencies.

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Create a new NET_DSA_REALTEK_RTL8366RB_LEDS symbol and make
  it resolve the compiled-in vs compiled-as-module dependencies.
- Link to v2: https://lore.kernel.org/r/20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org

Changes in v2:
- Create a separate compilation unit for the LED code instead
  of using ifdefs
- Split out a new local header with all shared definitions for
  this code.
- Link to v1: https://lore.kernel.org/r/20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org
---
 drivers/net/dsa/realtek/Kconfig          |   6 +
 drivers/net/dsa/realtek/Makefile         |   3 +
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 177 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8366rb.c      | 258 +------------------------------
 drivers/net/dsa/realtek/rtl8366rb.h      | 107 +++++++++++++
 5 files changed, 299 insertions(+), 252 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 6989972eebc3062e4caca902db4d3d44624b3fd4..10687722d14c0878e67d8c5f1011d95561f63211 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -43,4 +43,10 @@ config NET_DSA_REALTEK_RTL8366RB
 	help
 	  Select to enable support for Realtek RTL8366RB.
 
+config NET_DSA_REALTEK_RTL8366RB_LEDS
+	bool "Support RTL8366RB LED control"
+	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
+	depends on NET_DSA_REALTEK_RTL8366RB
+	default NET_DSA_REALTEK_RTL8366RB
+
 endif
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 35491dc20d6d6ed54855cbf62a0107b13b2a8fda..17367bcba496c164a06e193fdb371dfa8de62359 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -12,4 +12,7 @@ endif
 
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
+ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
+rtl8366-objs 				+= rtl8366rb-leds.o
+endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
new file mode 100644
index 0000000000000000000000000000000000000000..99c890681ae6079c67f62130bb5a0f673864def3
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+#include "rtl83xx.h"
+#include "rtl8366rb.h"
+
+static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
+{
+	switch (led_group) {
+	case 0:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 1:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 2:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 3:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	default:
+		return 0;
+	}
+}
+
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
+			  &val);
+	if (ret) {
+		dev_err(priv->dev, "error reading LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
+}
+
+static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
+				 rtl8366rb_led_group_port_mask(led_group,
+							       port_num),
+				 enable ? 0xffff : 0);
+	if (ret) {
+		dev_err(priv->dev, "error updating LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	/* Change the LED group to manual controlled LEDs if required */
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
+					 RTL8366RB_LEDGROUP_FORCE);
+
+	if (ret) {
+		dev_err(priv->dev, "error updating LED GROUP group %d\n",
+			led_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
+				       enum led_brightness brightness)
+{
+	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
+						 cdev);
+
+	return rb8366rb_set_port_led(led, brightness == LED_ON);
+}
+
+static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
+			       struct fwnode_handle *led_fwnode)
+{
+	struct rtl8366rb *rb = priv->chip_data;
+	struct led_init_data init_data = { };
+	enum led_default_state state;
+	struct rtl8366rb_led *led;
+	u32 led_group;
+	int ret;
+
+	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
+	if (ret)
+		return ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
+			 led_group, dp->index);
+		return -EINVAL;
+	}
+
+	led = &rb->leds[dp->index][led_group];
+	led->port_num = dp->index;
+	led->led_group = led_group;
+	led->priv = priv;
+
+	state = led_init_default_state_get(led_fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = 1;
+		rb8366rb_set_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness =
+			rb8366rb_get_port_led(led);
+		break;
+	case LEDS_DEFSTATE_OFF:
+	default:
+		led->cdev.brightness = 0;
+		rb8366rb_set_port_led(led, 0);
+	}
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_set_blocking =
+		rtl8366rb_cled_brightness_set_blocking;
+	init_data.fwnode = led_fwnode;
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
+					 dp->ds->index, dp->index, led_group);
+	if (!init_data.devicename)
+		return -ENOMEM;
+
+	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to init LED %d for port %d",
+			 led_group, dp->index);
+		return ret;
+	}
+
+	return 0;
+}
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	struct device_node *leds_np;
+	struct dsa_port *dp;
+	int ret = 0;
+
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np) {
+			dev_dbg(priv->dev, "No leds defined for port %d",
+				dp->index);
+			continue;
+		}
+
+		for_each_child_of_node_scoped(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret)
+				break;
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 4c4a95d4380ce2a8a88a6d564cc16eab5a82dbc8..f54771cab56d4f380f1048e4caf60203fe795104 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -27,11 +27,7 @@
 #include "realtek-smi.h"
 #include "realtek-mdio.h"
 #include "rtl83xx.h"
-
-#define RTL8366RB_PORT_NUM_CPU		5
-#define RTL8366RB_NUM_PORTS		6
-#define RTL8366RB_PHY_NO_MAX		4
-#define RTL8366RB_PHY_ADDR_MAX		31
+#include "rtl8366rb.h"
 
 /* Switch Global Configuration register */
 #define RTL8366RB_SGCR				0x0000
@@ -176,39 +172,6 @@
  */
 #define RTL8366RB_VLAN_INGRESS_CTRL2_REG	0x037f
 
-/* LED control registers */
-/* The LED blink rate is global; it is used by all triggers in all groups. */
-#define RTL8366RB_LED_BLINKRATE_REG		0x0430
-#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
-#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
-#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
-#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
-#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
-#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
-#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
-
-/* LED trigger event for each group */
-#define RTL8366RB_LED_CTRL_REG			0x0431
-#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
-	(4 * (led_group))
-#define RTL8366RB_LED_CTRL_MASK(led_group)	\
-	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-
-/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
- * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
- * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
- */
-#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
-	((led_group) <= 1 ? \
-		RTL8366RB_LED_0_1_CTRL_REG : \
-		RTL8366RB_LED_2_3_CTRL_REG)
-#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
-#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
-#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
-
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
 #define RTL8366RB_MIB_COUNTER_PORT_OFFSET	0x0050
@@ -244,7 +207,6 @@
 #define RTL8366RB_PORT_STATUS_AN_MASK		0x0080
 
 #define RTL8366RB_NUM_VLANS		16
-#define RTL8366RB_NUM_LEDGROUPS		4
 #define RTL8366RB_NUM_VIDS		4096
 #define RTL8366RB_PRIORITYMAX		7
 #define RTL8366RB_NUM_FIDS		8
@@ -351,46 +313,6 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
-enum rtl8366_ledgroup_mode {
-	RTL8366RB_LEDGROUP_OFF			= 0x0,
-	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
-	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
-	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
-	RTL8366RB_LEDGROUP_SPD100		= 0x4,
-	RTL8366RB_LEDGROUP_SPD10		= 0x5,
-	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
-	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
-	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
-	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
-	RTL8366RB_LEDGROUP_FIBER		= 0xa,
-	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
-	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
-	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
-	RTL8366RB_LEDGROUP_MASTER		= 0xe,
-	RTL8366RB_LEDGROUP_FORCE		= 0xf,
-
-	__RTL8366RB_LEDGROUP_MODE_MAX
-};
-
-struct rtl8366rb_led {
-	u8 port_num;
-	u8 led_group;
-	struct realtek_priv *priv;
-	struct led_classdev cdev;
-};
-
-/**
- * struct rtl8366rb - RTL8366RB-specific data
- * @max_mtu: per-port max MTU setting
- * @pvid_enabled: if PVID is set for respective port
- * @leds: per-port and per-ledgroup led info
- */
-struct rtl8366rb {
-	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
-	bool pvid_enabled[RTL8366RB_NUM_PORTS];
-	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
-};
-
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
 	{ 0,  0, 4, "IfInOctets"				},
 	{ 0,  4, 4, "EtherStatsOctets"				},
@@ -831,9 +753,10 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
-static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
-				      u8 led_group,
-				      enum rtl8366_ledgroup_mode mode)
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode)
 {
 	int ret;
 	u32 val;
@@ -850,144 +773,7 @@ static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
 	return 0;
 }
 
-static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
-{
-	switch (led_group) {
-	case 0:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 1:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 2:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	case 3:
-		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
-	default:
-		return 0;
-	}
-}
-
-static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-	u32 val;
-
-	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
-			  &val);
-	if (ret) {
-		dev_err(priv->dev, "error reading LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
-}
-
-static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
-{
-	struct realtek_priv *priv = led->priv;
-	u8 led_group = led->led_group;
-	u8 port_num = led->port_num;
-	int ret;
-
-	ret = regmap_update_bits(priv->map,
-				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
-				 rtl8366rb_led_group_port_mask(led_group,
-							       port_num),
-				 enable ? 0xffff : 0);
-	if (ret) {
-		dev_err(priv->dev, "error updating LED on port %d group %d\n",
-			led_group, port_num);
-		return ret;
-	}
-
-	/* Change the LED group to manual controlled LEDs if required */
-	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
-					 RTL8366RB_LEDGROUP_FORCE);
-
-	if (ret) {
-		dev_err(priv->dev, "error updating LED GROUP group %d\n",
-			led_group);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int
-rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
-				       enum led_brightness brightness)
-{
-	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
-						 cdev);
-
-	return rb8366rb_set_port_led(led, brightness == LED_ON);
-}
-
-static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
-			       struct fwnode_handle *led_fwnode)
-{
-	struct rtl8366rb *rb = priv->chip_data;
-	struct led_init_data init_data = { };
-	enum led_default_state state;
-	struct rtl8366rb_led *led;
-	u32 led_group;
-	int ret;
-
-	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
-	if (ret)
-		return ret;
-
-	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
-		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
-			 led_group, dp->index);
-		return -EINVAL;
-	}
-
-	led = &rb->leds[dp->index][led_group];
-	led->port_num = dp->index;
-	led->led_group = led_group;
-	led->priv = priv;
-
-	state = led_init_default_state_get(led_fwnode);
-	switch (state) {
-	case LEDS_DEFSTATE_ON:
-		led->cdev.brightness = 1;
-		rb8366rb_set_port_led(led, 1);
-		break;
-	case LEDS_DEFSTATE_KEEP:
-		led->cdev.brightness =
-			rb8366rb_get_port_led(led);
-		break;
-	case LEDS_DEFSTATE_OFF:
-	default:
-		led->cdev.brightness = 0;
-		rb8366rb_set_port_led(led, 0);
-	}
-
-	led->cdev.max_brightness = 1;
-	led->cdev.brightness_set_blocking =
-		rtl8366rb_cled_brightness_set_blocking;
-	init_data.fwnode = led_fwnode;
-	init_data.devname_mandatory = true;
-
-	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
-					 dp->ds->index, dp->index, led_group);
-	if (!init_data.devicename)
-		return -ENOMEM;
-
-	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
-	if (ret) {
-		dev_warn(priv->dev, "Failed to init LED %d for port %d",
-			 led_group, dp->index);
-		return ret;
-	}
-
-	return 0;
-}
-
+/* This code is used also with LEDs disabled */
 static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 {
 	int ret = 0;
@@ -1008,38 +794,6 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 	return ret;
 }
 
-static int rtl8366rb_setup_leds(struct realtek_priv *priv)
-{
-	struct dsa_switch *ds = &priv->ds;
-	struct device_node *leds_np;
-	struct dsa_port *dp;
-	int ret = 0;
-
-	dsa_switch_for_each_port(dp, ds) {
-		if (!dp->dn)
-			continue;
-
-		leds_np = of_get_child_by_name(dp->dn, "leds");
-		if (!leds_np) {
-			dev_dbg(priv->dev, "No leds defined for port %d",
-				dp->index);
-			continue;
-		}
-
-		for_each_child_of_node_scoped(leds_np, led_np) {
-			ret = rtl8366rb_setup_led(priv, dp,
-						  of_fwnode_handle(led_np));
-			if (ret)
-				break;
-		}
-
-		of_node_put(leds_np);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.h b/drivers/net/dsa/realtek/rtl8366rb.h
new file mode 100644
index 0000000000000000000000000000000000000000..685ff3275faa177eede99cb785e46a48d6c16ffe
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8366rb.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _RTL8366RB_H
+#define _RTL8366RB_H
+
+#include "realtek.h"
+
+#define RTL8366RB_PORT_NUM_CPU		5
+#define RTL8366RB_NUM_PORTS		6
+#define RTL8366RB_PHY_NO_MAX		4
+#define RTL8366RB_NUM_LEDGROUPS		4
+#define RTL8366RB_PHY_ADDR_MAX		31
+
+/* LED control registers */
+/* The LED blink rate is global; it is used by all triggers in all groups. */
+#define RTL8366RB_LED_BLINKRATE_REG		0x0430
+#define RTL8366RB_LED_BLINKRATE_MASK		0x0007
+#define RTL8366RB_LED_BLINKRATE_28MS		0x0000
+#define RTL8366RB_LED_BLINKRATE_56MS		0x0001
+#define RTL8366RB_LED_BLINKRATE_84MS		0x0002
+#define RTL8366RB_LED_BLINKRATE_111MS		0x0003
+#define RTL8366RB_LED_BLINKRATE_222MS		0x0004
+#define RTL8366RB_LED_BLINKRATE_446MS		0x0005
+
+/* LED trigger event for each group */
+#define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
+ */
+#define RTL8366RB_LED_0_1_CTRL_REG		0x0432
+#define RTL8366RB_LED_2_3_CTRL_REG		0x0433
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
+
+enum rtl8366_ledgroup_mode {
+	RTL8366RB_LEDGROUP_OFF			= 0x0,
+	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
+	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
+	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
+	RTL8366RB_LEDGROUP_SPD100		= 0x4,
+	RTL8366RB_LEDGROUP_SPD10		= 0x5,
+	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
+	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
+	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
+	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LEDGROUP_FIBER		= 0xa,
+	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
+	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
+	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
+	RTL8366RB_LEDGROUP_MASTER		= 0xe,
+	RTL8366RB_LEDGROUP_FORCE		= 0xf,
+
+	__RTL8366RB_LEDGROUP_MODE_MAX
+};
+
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
+int rtl8366rb_setup_leds(struct realtek_priv *priv);
+
+#else
+
+static inline int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	return 0;
+}
+
+#endif /* IS_ENABLED(CONFIG_LEDS_CLASS) */
+
+/**
+ * struct rtl8366rb - RTL8366RB-specific data
+ * @max_mtu: per-port max MTU setting
+ * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
+ */
+struct rtl8366rb {
+	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
+	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+#if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS)
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
+#endif
+};
+
+/* This code is used also with LEDs disabled */
+int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+			       u8 led_group,
+			       enum rtl8366_ledgroup_mode mode);
+
+#endif /* _RTL8366RB_H */

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250213-rtl8366rb-leds-compile-issue-dcd2c3c50fef

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


