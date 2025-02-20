Return-Path: <netdev+bounces-168195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2759A3DFFB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8DDB7A8767
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B41D63D0;
	Thu, 20 Feb 2025 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cV/GMWdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F39282F5
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067348; cv=none; b=rRIOCrgAJTYRiqwdaeXy+tZpFzBpuoEJnAEiGp4UQql3FfT+0GQcfh/ev/wDDVdsO9+Xx88Nfr786RrxgBK04t46SauINVv4yw99ThXHdsDqoyJ4fXNmYHvIMhFdemivBZALnDx0/NuuJFJUzoOKLsp/8VneI9cOO6F6dPqmI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067348; c=relaxed/simple;
	bh=lEb1TRNIM3hUsgR48ZoJa7blly8E3HRfnh9NVJpz8b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EzoAbtXFlBQseZoA1FqPuStFnORQBLVlfmyvG1QVCxTF0qdkZU2GE0phei4rhUXwyzseNnFHeKeltJyNSLhKk8YCsWr/xVHiykF/6HJVe/X5w2egVJBepnAu1vxiSgNE56TAhzH57UZC9pWU+OCQzdi3sS0FqkIrWhnAb8MvHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cV/GMWdD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307c13298eeso13271321fa.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740067344; x=1740672144; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R955gh5NtnvWzUIX+6TIfl4K5Y4iCqClseJ+CimRmeY=;
        b=cV/GMWdDslLWosyHw8x/+9u4btuXo6rPQhr1chMl/yy+2yyDoLIrAEiVkIHzCwicuy
         x1xcIkoh9ntROPUOcnj+Ms+MM0YrRd3LngSQ9N9YULHNVS2f8USlfOfFt6re7bZDAEX7
         go3S0gGU0ISAT1LCH2yXukovxbpPlbDb8Z6gHoNTVeXnAL5v+itk5gvSIHJBkjASUi3K
         V1Wm6wQAiPKe2xH6oKVi+MFJFUBNWDcgHJWuNST1wAmhTTsfqRBcOhFU3WmzOxLOj7VN
         Kx6RGXt6Cyb1h56P0yQceETYInaAZtQSVKH933j5YUKcHLlSUbbqvMd9qx4c8NB4ibzw
         cd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067344; x=1740672144;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R955gh5NtnvWzUIX+6TIfl4K5Y4iCqClseJ+CimRmeY=;
        b=YP7VWMOQFojfLi/p5cBFk/l9oVvuBNjIZw4aWhDFaXDBobvM7tsckqXT92AljzNQ8P
         gy9l49fahAE9QHlk+zEVN1CxEyGbco41fF3g7ZWTpILS0aXv/1TWdoQTa5nN3GPm1a2P
         /10c+64ct3tqbJEXzy7pkmmVFID2cHW/GdC83Pcpd1GI5j5YfBYxV2ehHM22Pw87lW08
         fuFy6kt5zV/XUYgesyG5709VnMdQsWJf+vOuwfM2K7CuF2QnLkvsQ1BB3pFHQ710i7bI
         NrIw6jtJXZyN+E4lCc4LYTzz2tz+7U0JEptcflPCCbMGJbT32MnOh65n2/6r9cvogGnf
         44GA==
X-Gm-Message-State: AOJu0YzqS9X+lF5H2dNiIQyyCSq2lnCzDX3lygmO16vrS98BwXjC3qa4
	rbIJMliow1QZrDH6vobo2ygw4q3UTNt07XsALiCND6lH25vVmXxcA7Ea7Gd/wNg=
X-Gm-Gg: ASbGncuuxA11ljjGnIjJ6TROw+IuYJjU/zSycN6xuDlja+oNX1PcmMrEb7iSijpgZ17
	H4zHsWXpV+9bM7n6laYPZxCoBdg1zdEnNzg0jBmrmUK4BDbOiDcQN+rESKo5PYiVRkgOiQK5pSq
	w4coNqIwPj6zrvgl2s3TrjWRhCzPdtnSieBSu/WKBIw1jdpkbASauPtWsVNdrj4Ohnd/ip9hCBS
	Uh5ZuOcnLx+x0UzMSt24lJml463IVExSrDTd8MOS3rBBEeABPBynVsDTZE64NQDYwbLWKajRVsd
	1AqTG/M5lPZbeBsihPHYTXsboA==
X-Google-Smtp-Source: AGHT+IGTdplLgEUzaHj++WxSgR/8FVuv19P5QlQIl7xtaB9cskRz3IWJoYPUV0KdnEji/0VKKaRtgg==
X-Received: by 2002:a2e:9bd5:0:b0:309:271d:711a with SMTP id 38308e7fff4ca-30a50610b0emr15225181fa.13.1740067343653;
        Thu, 20 Feb 2025 08:02:23 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3b06d16asm9732781fa.91.2025.02.20.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:02:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Feb 2025 17:02:21 +0100
Subject: [PATCH v2] net: dsa: rtl8366rb: Fix compilation problem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAxSt2cC/33NTQrCMBCG4auUWRtp0h+CK+8hXcRk2g7EpszUo
 pTe3Vhw6/L9GJ7ZQJAJBS7FBowrCaUphzkV4Ec3Dago5AZTmqY0ulK8RFu1Ld9VxCDKp8dMMV+
 JPFEFH4yvfFP22EMmZsaeXgd/63KPJEvi9/Ft1d/1B9f/4VUrrXztrEFsbWPtNdLkOJ0TD9Dt+
 /4BsN+jP8kAAAA=
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

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Create a separate compilation unit for the LED code instead
  of using ifdefs
- Split out a new local header with all shared definitions for
  this code.
- Link to v1: https://lore.kernel.org/r/20250214-rtl8366rb-leds-compile-issue-v1-1-c4a82ee68588@linaro.org
---
 drivers/net/dsa/realtek/Makefile         |   3 +
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 177 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8366rb.c      | 258 +------------------------------
 drivers/net/dsa/realtek/rtl8366rb.h      | 107 +++++++++++++
 4 files changed, 293 insertions(+), 252 deletions(-)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 35491dc20d6d6ed54855cbf62a0107b13b2a8fda..2fb362bbbc183584317b4bc7792ee638c40fa6a1 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -12,4 +12,7 @@ endif
 
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
+ifdef CONFIG_LEDS_CLASS
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
index 0000000000000000000000000000000000000000..c184e56822d5fb78139d4e9b6e8081fe7eba9c7e
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
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
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
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
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


