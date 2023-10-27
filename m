Return-Path: <netdev+bounces-44837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B147DA12A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1C61C2032A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478833D3B1;
	Fri, 27 Oct 2023 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nje795Ha"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF13D3AE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 19:10:04 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FFE1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:10:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7c7262d5eso18387967b3.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433801; x=1699038601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFzNOTKyqREwFnzSabRhKpTozkYFxyw+8i73/F1Vdm0=;
        b=Nje795HaelETFs3JU9DZUjD26QnIIFqTcX+VGjPFVsqd5jdvvJAbb0FMF6Sv2GHF+w
         bi1oILXNmxeUhH+dIhFCLp19r0ndK1RhCRkQknocjprqPlvHRKfpb5WmnE4nbpyLSeq5
         zn0beS99lripVsGciqrw/V8H0JeNwPnD3uhfJR7TCxyTNPSFXbGX4ZVsK6DvFLTwWo+0
         OSxKvt4UFRhkUJ/ermQvHWzOlQn+erZidWgaV9gqQbwKIAxuk6gqurSYae1qi1btetY4
         4DSg3eyx6XDpPW105rjLpYfbKHFTWxaOAZNygrvUEsOOMFsIi466eUt5cIo4NgGhKSbI
         XocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433801; x=1699038601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFzNOTKyqREwFnzSabRhKpTozkYFxyw+8i73/F1Vdm0=;
        b=szlRr4WidfplUXZ3vGoT+p9osWSvvX2PAkTJ6a/TT3I0B2WxuOttITZvqUXoqomcus
         xHtN6Uec+oDuQSjpe2w7FJQZgFeQrS4+71RaQapD6L8SQ+Mu5I5iB9EKCusPMpIS6bI9
         6uKYBEF8wyQh8/+OkaXQeVw8QpB7qRSePG4tmW96pSUC6/ENfk28+SRh3b+xZy2fER07
         XFErtR0maKW3vkEMvjmN+NR4FHMF85fuKVhYpLc0CnwVBu+aRHL5spXB/1LQq27OW8Yw
         l3mX6tQhxXEyXHixER9LerDwiGcwC/1ulKec8bUksN4IMrrNCSevca8xUFn1BSlV16JN
         5+LA==
X-Gm-Message-State: AOJu0YxJBsENF+fOVAKh/Vsa67gA5ffX/xY++Clruy63sAwvD58dKJ7D
	psBtcpnsfvW5sDyMYjHocV4cZP6LImSYQQ==
X-Google-Smtp-Source: AGHT+IGuX1apouIbbqfkrqv89kk25tO2cQ7WHRBcVgRc1CrZgt6Yf75+9Dx+qidOcjOPz74BDxZTKQ==
X-Received: by 2002:a81:400c:0:b0:5a7:b8a5:1474 with SMTP id l12-20020a81400c000000b005a7b8a51474mr3521401ywn.22.1698433800757;
        Fri, 27 Oct 2023 12:10:00 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id g190-20020a8152c7000000b0059c8387f673sm958696ywb.51.2023.10.27.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:10:00 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v2 3/3] net: dsa: realtek: support reset controller
Date: Fri, 27 Oct 2023 16:00:57 -0300
Message-ID: <20231027190910.27044-4-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027190910.27044-1-luizluca@gmail.com>
References: <20231027190910.27044-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'reset-gpios' will not work when the switch reset is controlled by a
reset controller.

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset state was asserted, the driver will
not detect it.

The reset controller will take precedence over the reset GPIO.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek-mdio.c | 51 ++++++++++++++++++++++----
 drivers/net/dsa/realtek/realtek-smi.c  | 49 ++++++++++++++++++++++---
 drivers/net/dsa/realtek/realtek.h      |  2 +
 3 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 292e6d087e8b..aad94e49d4c9 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -140,6 +140,40 @@ static const struct regmap_config realtek_mdio_nolock_regmap_config = {
 	.disable_locking = true,
 };
 
+static void realtek_mdio_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_assert(priv->reset_ctl);
+		if (ret)
+			dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
+				 ret);
+
+		return;
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, true);
+}
+
+static void realtek_mdio_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_deassert(priv->reset_ctl);
+		if (ret)
+			dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
+				 ret);
+
+		return;
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, false);
+}
+
 static int realtek_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct realtek_priv *priv;
@@ -194,20 +228,24 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
 
 	dev_set_drvdata(dev, priv);
 
-	/* TODO: if power is software controlled, set up any regulators here */
 	priv->leds_disabled = of_property_read_bool(np, "realtek,disable-leds");
 
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		return dev_err_probe(dev, ret, "failed to get reset control\n");
+	}
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(priv->reset);
 	}
-
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		realtek_mdio_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		realtek_mdio_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -246,8 +284,7 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
 	dsa_unregister_switch(priv->ds);
 
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_mdio_reset_assert(priv);
 }
 
 static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index bfd11591faf4..a99e53b5b662 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -408,6 +408,40 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	return ret;
 }
 
+static void realtek_smi_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_assert(priv->reset_ctl);
+		if (ret)
+			dev_warn(priv->dev, "Failed to assert the switch reset control. Error: %i",
+				 ret);
+
+		return;
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, true);
+}
+
+static void realtek_smi_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	if (priv->reset_ctl) {
+		ret = reset_control_deassert(priv->reset_ctl);
+		if (ret)
+			dev_warn(priv->dev, "Failed to deassert the switch reset control. Error: %i",
+				 ret);
+
+		return;
+	}
+
+	if (priv->reset)
+		gpiod_set_value(priv->reset, false);
+}
+
 static int realtek_smi_probe(struct platform_device *pdev)
 {
 	const struct realtek_variant *var;
@@ -457,18 +491,22 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 	spin_lock_init(&priv->lock);
 
-	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		return dev_err_probe(dev, ret, "failed to get reset control\n");
+	}
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(priv->reset);
 	}
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		realtek_smi_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		realtek_smi_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -518,8 +556,7 @@ static void realtek_smi_remove(struct platform_device *pdev)
 		of_node_put(priv->slave_mii_bus->dev.of_node);
 
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	realtek_smi_reset_assert(priv);
 }
 
 static void realtek_smi_shutdown(struct platform_device *pdev)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 4fa7c6ba874a..516450837b74 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#include <linux/reset.h>
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -48,6 +49,7 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+	struct reset_control    *reset_ctl;
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
-- 
2.42.0


