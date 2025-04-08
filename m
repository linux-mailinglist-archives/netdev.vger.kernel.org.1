Return-Path: <netdev+bounces-180131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC419A7FA93
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217E01888366
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DD266B73;
	Tue,  8 Apr 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt7WozAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB4268C42;
	Tue,  8 Apr 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105951; cv=none; b=l08g18X9gSrR5qoT7vyZ/7d8ZUfBkGDFo6gm3zGSjiOhY7hYLvgPzET7UjU5HIrxO6IAdzlE/qlVVBJdN5ZacDIJoV54BZle4Bg2ClXPvzZ5VpkRjlhYihBqfwAdr7b2H9jq143s+Vr5BYbGQ5/PajAXAM8NgjnC/4drLvlhz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105951; c=relaxed/simple;
	bh=F+8Piik4rZMTZ/ojoPW7F9NXvjEEjRWMobu+G6BNiI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzJ7uiW6+Afcw/wL5pGF6Q+YWMEPWINy/PsEiiN8BwQKX5XQXC/R32P9+OCyqGd8tTNkPnPFoAOahzYNFLGnEOXk+/JraRwzlq8zfw8pdFZ5ge3DfKjbvSSV/C31D848wwCNg9nddp39NeFKjhx/qh1/abD79dpqIYxVJtJV9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt7WozAw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so41922415e9.2;
        Tue, 08 Apr 2025 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105948; x=1744710748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3/BY8PYvNQdk6fZrNkLE1hVwik+/X8XgJnJ+/zsRwY=;
        b=Gt7WozAw4dd5C3qd3KJZ/PVH5rMHuia74eqC4der7KtuyL0969mBw9gtYEKG20GUYj
         66MGSpAdH+lh/WLYyYGypjqfxARsY48SY8YdFKIZAzd250VRzFwPRCJ5teJ2hq+ZN9Jm
         YDLdXKQ3bs0Due3I4fPPMLZPlFR9jGeLyHSVwOt/wWK1I8ikZbPyJ5SL/vF4MhWIlUMC
         fEQ8tDyPS5CVxvXbf3H5nI5XFRXLQE3FmIgrRBhPWOUa8+BOoC7MT2I8JHmjj9PMFYIH
         4zeyjjONB1oLIxrwLWKZ4tdtMWc2QsdhssUMcDMgmib/IaMjZJF1EvUWeyYxOfCwmjAB
         HzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105948; x=1744710748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3/BY8PYvNQdk6fZrNkLE1hVwik+/X8XgJnJ+/zsRwY=;
        b=nweYoh6VGyrLtmxu9vJmKq6TC0ED0RWuLpLcP84R2HX2gg/bp3fAjiFIRFNv1Q/n9T
         PSVgX+aqJkntwtMTWmpe2+U9c/xf02EM6qCa8OlHyFETsTc1mjQrArah9NbNcNGVdFEL
         kxsgT33peuL+LkbDppr3P2vnK3Zh8xbhEvcWhef7zg1t4A89Y2Ds4tPxS8wBsb5PpfaH
         moCCSlv4I7kxEbsQSOKvTfQinJv8d/95Q/AAn4XcZy1/X35vFqDhFnpVi+qkfP9chrxG
         lpTIT203aIZTEDGOY9PPKV3E1q8GeT+Q8KhcQDj7q58mG8IDtAfIJtO9Puklt9QljcHn
         ZhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDgNCJieRmVvMO+5T3omn7o4+RHvS+9a0rLYdXqR+MC0YRxJeFjcp1OHT1oKiZxstcpuP5aRtRgnxzMSYV@vger.kernel.org, AJvYcCVQcGRrTihWOrAc309BNcP6UU6X9MUJ9tculfnDD1qorLESc56tkRg7B+zj0O11y5ZwIX29qoXdEiN1@vger.kernel.org, AJvYcCWsIPjnpXDZWLZrxrOnBf16xwphS6sZX8S5OXqKADcQopupBbNQiIcjtlWwotvj3ihcAwswFylD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UzWLtYG20OFvY970gB2i6iw+mtvCXe3aEJ5u3B3Kz4qUSXJi
	upbT/7w3R/mfzOoOTrI9B42XNqEl7Tf0exOe4IEWbN5Se/tTwOZz
X-Gm-Gg: ASbGnctGtV+IGbkJIp3PqH+Hm6IAOk6R4t0o+QQxz4eDMnCN5cAROMfeH7trtllOPMP
	KsWeVRXekj287isf4vi84DpiJbFJ4a54dU3bM0F6HZ4DWSj95BpOvsEn6RgZs6GpuyMR/OlqEfk
	a7sfo6gcgejsJX7JfI4KjU9dprL8QbiMEOCjkfFtS5iq9ku3FmO3NYO8ZidWVBKhmQ4xaHwg21p
	L0hwcoOHlg/9ukusuOK4M9yy9m1Q2BhUfkBa++yyK/AKsvyXDwS1rrDSjtzeCWEQ33p97FQWZ9C
	Wtf0mtgPqRIzRjXp2hM2fA6mml/QwcbEByQhBebQBPcI2Fmff+QMSMZZE3u2hKDjp7s1wXejtut
	EH3eWfyaziF51yA==
X-Google-Smtp-Source: AGHT+IGk6lh9oHKBenBhQXCD5vvAz3tN3/0sAx6/S8ROb2EOxvICxmB1O37yZcrWQXZCVWyacHoQ1g==
X-Received: by 2002:a5d:584e:0:b0:39c:dfa:d33e with SMTP id ffacd0b85a97d-39d0de2567dmr13218213f8f.23.1744105948149;
        Tue, 08 Apr 2025 02:52:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 11/16] net: mdio: Add Airoha AN8855 Switch MDIO Passtrough
Date: Tue,  8 Apr 2025 11:51:18 +0200
Message-ID: <20250408095139.51659-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN8855 Switch driver to register a MDIO passtrough as switch
address is shared with the internal PHYs and require additional page
handling.

This requires the upper Switch MFD to be probed and init to actually
work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/Kconfig       | 10 +++++++
 drivers/net/mdio/Makefile      |  1 +
 drivers/net/mdio/mdio-an8855.c | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-an8855.c

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 4a7a303be2f7..e31a37064934 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -61,6 +61,16 @@ config MDIO_XGENE
 	  This module provides a driver for the MDIO busses found in the
 	  APM X-Gene SoC's.
 
+config MDIO_AN8855
+	tristate "Airoha AN8855 Switch MDIO bus controller"
+	depends on MFD_AIROHA_AN8855
+	depends on OF_MDIO
+	select MDIO_REGMAP
+	help
+	  This module provides a driver for the Airoha AN8855 Switch
+	  that requires a MDIO passtrough as switch address is shared
+	  with the internal PHYs and requires additional page handling.
+
 config MDIO_ASPEED
 	tristate "ASPEED MDIO bus controller"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 1015f0db4531..546c4e55b475 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ACPI_MDIO)		+= acpi_mdio.o
 obj-$(CONFIG_FWNODE_MDIO)	+= fwnode_mdio.o
 obj-$(CONFIG_OF_MDIO)		+= of_mdio.o
 
+obj-$(CONFIG_MDIO_AN8855)		+= mdio-an8855.o
 obj-$(CONFIG_MDIO_ASPEED)		+= mdio-aspeed.o
 obj-$(CONFIG_MDIO_BCM_IPROC)		+= mdio-bcm-iproc.o
 obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
diff --git a/drivers/net/mdio/mdio-an8855.c b/drivers/net/mdio/mdio-an8855.c
new file mode 100644
index 000000000000..22d199942f1c
--- /dev/null
+++ b/drivers/net/mdio/mdio-an8855.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MDIO passthrough driver for Airoha AN8855 Switch
+ */
+
+#include <linux/mdio/mdio-regmap.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static int an8855_mdio_probe(struct platform_device *pdev)
+{
+	struct mdio_regmap_config mrc = { };
+	struct device *dev = &pdev->dev;
+	struct mii_bus *bus;
+
+	mrc.regmap = dev_get_regmap(dev->parent, "phy");
+	mrc.parent = dev;
+	mrc.valid_addr_mask = GENMASK(31, 0);
+	mrc.support_encoded_addr = true;
+	mrc.autoscan = true;
+	mrc.np = dev->of_node;
+	snprintf(mrc.name, MII_BUS_ID_SIZE, KBUILD_MODNAME);
+
+	bus = devm_mdio_regmap_register(dev, &mrc);
+	if (IS_ERR(bus))
+		return dev_err_probe(dev, PTR_ERR(bus), "failed to register MDIO bus\n");
+
+	return 0;
+}
+
+static const struct of_device_id an8855_mdio_of_match[] = {
+	{ .compatible = "airoha,an8855-mdio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_mdio_of_match);
+
+static struct platform_driver an8855_mdio_driver = {
+	.probe	= an8855_mdio_probe,
+	.driver = {
+		.name = "an8855-mdio",
+		.of_match_table = an8855_mdio_of_match,
+	},
+};
+module_platform_driver(an8855_mdio_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for AN8855 MDIO passthrough");
+MODULE_LICENSE("GPL");
-- 
2.48.1


