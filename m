Return-Path: <netdev+bounces-62180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E77826121
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38492282F6D
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D6CA67;
	Sat,  6 Jan 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKr8WoNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6337F4E7
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59496704246so391159eaf.2
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704566837; x=1705171637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtZrYKB5uzDAMWN0sjnqmn2ZcRKrQ5RAQeRItD+zkhk=;
        b=RKr8WoNptLxYGyUvzOVqTlfa9qU/S/BQ0F1itvdDqGwks5U/u5jxuh81ImVEr9ot0s
         nMxa85j7d4l1EVIBAY6utqLpzWiJRh0ATHV9qOK1hzbcDHmDcrpDNDoHRrud/7sMcxrE
         xd73CR7MK/BsviBm0yMe975uCcah7yQ6nwksPivtIybYQemHlGIGND1M0CBT7pydyz1L
         XIUt3tjxi2ATUcaqV7GqBceJvwwJQXbg9kN0FX3WlQD4EIgul4rvnpRcjzwWNTau58oi
         7ZcYM6kjADh7ZZDu93G+nPRiB9w29HZqRTZzE6Ft4qxwXSITDjXSzkTE3jo3b9iWD5eG
         Tjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704566837; x=1705171637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtZrYKB5uzDAMWN0sjnqmn2ZcRKrQ5RAQeRItD+zkhk=;
        b=dilFvgkLVXBapBQia3MyOQW5i36SHT5VJ8L6c0cfcEl5L+uQiQ3m+cjOhtjeOlJaek
         9JASSRaDQceE5N1eMKss7DV0rv+K5Htj8p1np4vDXipt0mXwAtOiVBosdsoSjGwAAksQ
         +FXhYlxDB40XsJ6N2t13OSjS/zPUde6oACC96jhaUuWLsUbhkwYLIJGROxX2jhPWyMGx
         64dt+61cQ6URrB2nwYrvQdZFQXW1r9QJkL1TCtd/Fyobs7ARARKje5IZVGjYL9gVcyGz
         LdglWxA9XnKpv15Evatylalf/G/P4xKDPYPqwlVmTiC6KUVUMjhsCWbUNK1YZpj3z3yM
         nyQA==
X-Gm-Message-State: AOJu0YzM6cn7wjSzb2VfVovyAoUidZl0DrSq6Vx4iL9areXlo0tEnUDA
	xnUNJXi+UEFfSJ93Y08sKLlpfPPuR11jQg==
X-Google-Smtp-Source: AGHT+IEGyr5r57TtEtaYmwBLAwwY670gRD+NGcukEm9qMOXowGOMVUqa4fcc0uylZvmWZbSJIFp6dg==
X-Received: by 2002:a05:6359:1a92:b0:174:b927:5859 with SMTP id rv18-20020a0563591a9200b00174b9275859mr626630rwb.21.1704566836951;
        Sat, 06 Jan 2024 10:47:16 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b0028bdc7e5a15sm3363915pjy.53.2024.01.06.10.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 10:47:16 -0800 (PST)
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
Subject: [RFC net-next 2/2] net: dsa: realtek: add LED drivers for rtl8366rb
Date: Sat,  6 Jan 2024 15:40:47 -0300
Message-ID: <20240106184651.3665-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106184651.3665-1-luizluca@gmail.com>
References: <20240106184651.3665-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces LED drivers for rtl8366rb, allowing LEDs to be
described in the device tree using the same format as qca8k. Each port
can configure up to 4 LEDs.

If LEDs use the default state "keep", they will keep the default
behavior after a reset. Changing the brightness of one LED will cause
the entire LED group to switch to manually controlled LEDs. Once in this
mode, there is no way to revert to hardware-controlled LEDs (except by
resetting the switch).

Software triggers function as expected with manually controlled LEDs.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 269 +++++++++++++++++++++++++---
 1 file changed, 245 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 874e04cf2e0d..f71cb59b8048 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -188,31 +188,21 @@
 	(4 * (led_group))
 #define RTL8366RB_LED_CTRL_MASK(led_group)	\
 	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-#define RTL8366RB_LED_OFF			0x0
-#define RTL8366RB_LED_DUP_COL			0x1
-#define RTL8366RB_LED_LINK_ACT			0x2
-#define RTL8366RB_LED_SPD1000			0x3
-#define RTL8366RB_LED_SPD100			0x4
-#define RTL8366RB_LED_SPD10			0x5
-#define RTL8366RB_LED_SPD1000_ACT		0x6
-#define RTL8366RB_LED_SPD100_ACT		0x7
-#define RTL8366RB_LED_SPD10_ACT			0x8
-#define RTL8366RB_LED_SPD100_10_ACT		0x9
-#define RTL8366RB_LED_FIBER			0xa
-#define RTL8366RB_LED_AN_FAULT			0xb
-#define RTL8366RB_LED_LINK_RX			0xc
-#define RTL8366RB_LED_LINK_TX			0xd
-#define RTL8366RB_LED_MASTER			0xe
-#define RTL8366RB_LED_FORCE			0xf
 
 /* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
  * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
  * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
  */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_3_OFFSET			6
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
 
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
@@ -356,14 +346,44 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
+enum rtl8366_led_mode {
+	RTL8366RB_LED_OFF		= 0x0,
+	RTL8366RB_LED_DUP_COL		= 0x1,
+	RTL8366RB_LED_LINK_ACT		= 0x2,
+	RTL8366RB_LED_SPD1000		= 0x3,
+	RTL8366RB_LED_SPD100		= 0x4,
+	RTL8366RB_LED_SPD10		= 0x5,
+	RTL8366RB_LED_SPD1000_ACT	= 0x6,
+	RTL8366RB_LED_SPD100_ACT	= 0x7,
+	RTL8366RB_LED_SPD10_ACT		= 0x8,
+	RTL8366RB_LED_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LED_FIBER		= 0xa,
+	RTL8366RB_LED_AN_FAULT		= 0xb,
+	RTL8366RB_LED_LINK_RX		= 0xc,
+	RTL8366RB_LED_LINK_TX		= 0xd,
+	RTL8366RB_LED_MASTER		= 0xe,
+	RTL8366RB_LED_FORCE		= 0xf,
+
+	__RTL8366RB_LED_MAX
+};
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
 /**
  * struct rtl8366rb - RTL8366RB-specific data
  * @max_mtu: per-port max MTU setting
  * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
  */
 struct rtl8366rb {
 	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
 	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
 };
 
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
@@ -806,6 +826,207 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
+static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+				      u8 led_group,
+				      enum rtl8366_led_mode mode)
+{
+	int ret;
+	u32 val;
+
+	val = mode << RTL8366RB_LED_CTRL_OFFSET(led_group);
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_CTRL_REG,
+				 RTL8366RB_LED_CTRL_MASK(led_group),
+				 val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
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
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_err(priv->dev, "Invalid LED group %d for port %d",
+			led_group, port_num);
+		return -EINVAL;
+	}
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
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_err(priv->dev, "Invalid LED group %d for port %d",
+			led_group, port_num);
+		return -EINVAL;
+	}
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
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group, RTL8366RB_LED_FORCE);
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
+	struct rtl8366rb_led *led;
+	enum led_default_state state;
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
+			rb8366rb_get_port_led(led, 1);
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
+static int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct device_node *leds_np, *led_np;
+	struct dsa_port *dp;
+	int ret;
+
+	dsa_switch_for_each_port(dp, priv->ds) {
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
+		for_each_child_of_node(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret) {
+				of_node_put(led_np);
+				break;
+			}
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -814,7 +1035,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	u32 chip_ver = 0;
 	u32 chip_id = 0;
 	int jam_size;
-	u32 val;
 	int ret;
 	int i;
 
@@ -1014,14 +1234,15 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 				   0);
 
 		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
-			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
-			ret = regmap_update_bits(priv->map,
-						 RTL8366RB_LED_CTRL_REG,
-						 RTL8366RB_LED_CTRL_MASK(i),
-						 val);
+			ret = rb8366rb_set_ledgroup_mode(priv, i,
+							 RTL8366RB_LED_OFF);
 			if (ret)
 				return ret;
 		}
+	} else {
+		ret = rtl8366rb_setup_leds(priv);
+		if (ret)
+			return ret;
 	}
 
 	ret = rtl8366_reset_vlan(priv);
-- 
2.43.0


