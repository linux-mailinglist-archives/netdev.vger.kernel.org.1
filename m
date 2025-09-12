Return-Path: <netdev+bounces-222481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57018B546B4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E63D582DEF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44512285049;
	Fri, 12 Sep 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v1TaEspG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DD27EC7C;
	Fri, 12 Sep 2025 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668598; cv=none; b=mrCLIJH831I1sapUmx//QckvAhcNrjLzIVan/dFcrIEqWfew7a6PgYxWrjE4nadFpoNGzEkOK6Oju7B9p/GnTfrdZ3XEY2R4JX7bihyHhqaSTdSheU0q/t4srk2skZuGi+klz5Cpj3v2ZqKS1GRsMVXsrjZpUI7B1DpVrNiLqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668598; c=relaxed/simple;
	bh=M6H4vuC1kEo4E+gLt9fSDpwP8uZAqmIgNGYQto3FN6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYbDug5gjKOQqKZf4TEN2MMGauDq1lHoE7/p2sG2P7fKIQFUecOb0C3pJS+ny1htebMU0C0AoP1+IXvvrfOVOiBgygXtzvzLgjvS5fg+2ScL+fI9taen0IJc5GhaDEzZ1antvwI9/J8KviC/qF9If+2W6zfNxhPbQTIo3XnmZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v1TaEspG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE04E4E40CA2;
	Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92B5660638;
	Fri, 12 Sep 2025 09:16:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C311102F29F0;
	Fri, 12 Sep 2025 11:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757668593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WrEpjzQG6DNyDJzeGBdcuqSqyOJS2DKBX8gv90YD2t4=;
	b=v1TaEspGpxrRVy9CAufNd7nysVTGp7WzDeWJbuYbWq3jSgdOAofV8kjtAU0R+M9hk98xCH
	Vgo0qNsz2WFp5siWvHSRuxqjYl1sAFXUhgeClNLb01j7ZKDjU8BNX2FEXos1iO24Ih/HkH
	gFpN82nVW/ut3i4opQ2pu5rlkuMyYwHSjXsU8YthPAVVfrU9P9kqmTHadi9oc+gHQ1ty3+
	fHLoQHu/2BoYKFRFWmgBoA/A4xxCvXTUsIPyRLhS0OZ1I5esjbpDPqZ4JsM9zzrIJEHPCW
	evYSdH77Ge6oA9BQ909yIKT3TTDwNuB69pI+BuwXOFdjvHRJsPXrw5TUoM1hvg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 12 Sep 2025 11:09:14 +0200
Subject: [PATCH net-next v2 3/3] net: dsa: microchip: Set SPI as bus
 interface during reset for KSZ8463
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-ksz-strap-pins-v2-3-6d97270c6926@bootlin.com>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
In-Reply-To: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
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

At reset, the KSZ8463 uses a strap-based configuration to set SPI as
bus interface. SPI is the only bus supported by the driver. If the
required pull-ups/pull-downs are missing (by mistake or by design to
save power) the pins may float and the configuration can go wrong
preventing any communication with the switch.

Introduce a ksz8463_configure_straps_spi() function called during the
device reset. It relies on the 'strap-rxd*-gpios' OF properties and the
'reset' pinmux configuration to enforce SPI as bus interface.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7cac3a0d88bb51339cc287f56ca1d1f..ac05dd25b4863a61b15ac1131587b2b4df11ec41 100644
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
@@ -5338,6 +5339,38 @@ static int ksz_parse_drive_strength(struct ksz_device *dev)
 	return 0;
 }
 
+static int ksz8463_configure_straps_spi(struct ksz_device *dev)
+{
+	struct pinctrl *pinctrl;
+	struct gpio_desc *rxd0;
+	struct gpio_desc *rxd1;
+
+	rxd0 = devm_gpiod_get_optional(dev->dev, "strap-rxd0", GPIOD_OUT_LOW);
+	if (IS_ERR(rxd0))
+		return PTR_ERR(rxd0);
+
+	rxd1 = devm_gpiod_get_optional(dev->dev, "strap-rxd1", GPIOD_OUT_HIGH);
+	if (IS_ERR(rxd1))
+		return PTR_ERR(rxd1);
+
+	if (!rxd0 && !rxd1)
+		return 0;
+
+	if ((rxd0 && !rxd1) || (rxd1 && !rxd0))
+		return -EINVAL;
+
+	pinctrl = devm_pinctrl_get_select(dev->dev, "reset");
+	if (IS_ERR(pinctrl))
+		return PTR_ERR(pinctrl);
+
+	return 0;
+}
+
+static int ksz8463_release_straps_spi(struct ksz_device *dev)
+{
+	return pinctrl_select_default_state(dev->dev);
+}
+
 int ksz_switch_register(struct ksz_device *dev)
 {
 	const struct ksz_chip_data *info;
@@ -5353,10 +5386,22 @@ int ksz_switch_register(struct ksz_device *dev)
 		return PTR_ERR(dev->reset_gpio);
 
 	if (dev->reset_gpio) {
+		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
+			ret = ksz8463_configure_straps_spi(dev);
+			if (ret)
+				return ret;
+		}
+
 		gpiod_set_value_cansleep(dev->reset_gpio, 1);
 		usleep_range(10000, 12000);
 		gpiod_set_value_cansleep(dev->reset_gpio, 0);
 		msleep(100);
+
+		if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
+			ret = ksz8463_release_straps_spi(dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	mutex_init(&dev->dev_mutex);

-- 
2.51.0


