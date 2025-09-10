Return-Path: <netdev+bounces-221727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E8B51ADC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF064638F2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B933472B;
	Wed, 10 Sep 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SR17GPLm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3533438B
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516158; cv=none; b=q/xG5IzOprckXZHMJrb2559WVppRiPH0IP68iBQqaNmWGQL70HFtAjftqP1k9C3k6Trychd1jJwAgS+Fse+HoCFvX7nYPn74a1D02WXhRSu9Tg7PUNWK0CAMdUteldepUJ9eaMtWEY44pYXiB6f00CjF3KwIXxa9z35X0flmamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516158; c=relaxed/simple;
	bh=NRsUrwsfDBVIR7zlW4wHZ1hxvm6bFw8otTg0Io2tZxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfkT6np7oqx8ocFuUVJc7BK6S/0SjBNEuCWgmbsRQ0zOv4vJtiPEOHHtkkkdIp7KlEU1tpeq1ntIenrvspNnb8XIFbIjPf0oAWgygPX6I9uJeyOt8uBhjp/UwGovsSYK2/pOO2D8ZIpSGkc6KMtLijaL23YxzlgxCobFjhvz8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SR17GPLm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2500BC6B3AC;
	Wed, 10 Sep 2025 14:55:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E687D606D4;
	Wed, 10 Sep 2025 14:55:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 538D3102F2982;
	Wed, 10 Sep 2025 16:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757516154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XoKGOrO1Ey6obEn8h5SKfYR6XgUo5CImp+vP8RhoOl8=;
	b=SR17GPLmDx/c2f6RuJqn2RxWzsFXKEER0zSR2+bmcdGZ+UhJ1QrmQYZHs2WSlr5ahyrtyy
	3GJN92WhvJsJOTNPXZgd1g6H2DpiDnrAKlAgkyUI7QiNSu+rMxcxcAwlAr48Nvj1paHPH9
	2fXlio33TrE0+47FH2SmCJ+sDMn8Lz42oNIhUVd2wU1N0c9QHfuO45szMDJNR0mPuh6a9v
	ey1dNrnC7HqAjiqED3LcdFYwNU4NsdcRtqPe3t5O9WMtcbnL1Sd+6O/UjCisPzgCT7q5jl
	ndbghqSiW+PFpghc/iXaLxSgwbMjBJ7sVrbjsaq2qAVkz0wm19Ue2OFN8bpynA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 10 Sep 2025 16:55:25 +0200
Subject: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
In-Reply-To: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, 
 Woojung Huh <Woojung.Huh@microchip.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

At reset, some KSZ switches use strap based configuration. If the
required pull-ups/pull-downs are missing (by mistake or by design to
save power) the pins may float and the configuration can go wrong.

Introduce a configure_strap() function, called during the device reset.
It relies on the 'strap-gpios' OF property and the 'reset' pinmux
configuration to drive the configuration pins to the proper state.
Support the KSZ8463's strap configuration that enforces SPI as
communication bus, since it is the only bus supported by the driver.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7cac3a0d88bb51339cc287f56ca1d1f..0ab201a3c336b99ba92d87c003ba48f7f82a098a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -23,6 +23,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <net/dsa.h>
 #include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
@@ -5338,6 +5339,44 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 	return 0;
 }
 
+static int ksz_configure_strap(struct ksz_device *dev)
+{
+	struct pinctrl_state *state = NULL;
+	struct pinctrl *pinctrl;
+	int ret;
+
+	if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
+		struct gpio_desc *rxd0;
+		struct gpio_desc *rxd1;
+
+		rxd0 = devm_gpiod_get_index_optional(dev->dev, "strap", 0, GPIOD_OUT_LOW);
+		if (IS_ERR(rxd0))
+			return PTR_ERR(rxd0);
+
+		rxd1 = devm_gpiod_get_index_optional(dev->dev, "strap", 1, GPIOD_OUT_HIGH);
+		if (IS_ERR(rxd1))
+			return PTR_ERR(rxd1);
+
+		/* If at least one strap definition is missing we don't do anything */
+		if (!rxd0 || !rxd1)
+			return 0;
+
+		pinctrl = devm_pinctrl_get(dev->dev);
+		if (IS_ERR(pinctrl))
+			return PTR_ERR(pinctrl);
+
+		state = pinctrl_lookup_state(pinctrl, "reset");
+		if (IS_ERR(state))
+			return PTR_ERR(state);
+
+		ret = pinctrl_select_state(pinctrl, state);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
@@ -5353,10 +5392,18 @@ int ksz_switch_register(struct ksz_device *dev)
 		return PTR_ERR(dev->reset_gpio);
 
 	if (dev->reset_gpio) {
+		ret = ksz_configure_strap(dev);
+		if (ret)
+			return ret;
+
 		gpiod_set_value_cansleep(dev->reset_gpio, 1);
 		usleep_range(10000, 12000);
 		gpiod_set_value_cansleep(dev->reset_gpio, 0);
 		msleep(100);
+
+		ret = pinctrl_select_default_state(dev->dev);
+		if (ret)
+			return ret;
 	}
 
 	mutex_init(&dev->dev_mutex);

-- 
2.51.0


