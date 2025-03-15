Return-Path: <netdev+bounces-175068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C579A62F87
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867EB17794D
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F892207E0A;
	Sat, 15 Mar 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5ShvonS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8786204C03;
	Sat, 15 Mar 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053501; cv=none; b=CseEwO+uDSzPcWX/OoIoEEl3nIXwuUG4iKIwMp1vBNwkHuZTPZ9kB3St/Kh/blzdPc93rCBDDhnjcr8ndYo6SVymPu688qofHLSQG7yYORnvPiaq/CqSGves0CvvsA8LeyWxy015aaCYpInwgS9grNTYcMURHrB3+pPJTxBwi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053501; c=relaxed/simple;
	bh=/tp5Egme2xGMsBlKG2RjIczk1H8J/tQhdVs+bg52lco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SglChLwjvyzokmPybpWyNeikCx7boE2ZN8I/y52Y0Ouya+K6EVl8iIXvGtILu/t7TB3fNHdfv5R1auOybMhaJCDvmN+bmRq9sPSTnQ/Ibo5XV3CA94kTZySk7uj3IO3zqSJN9u/9kd7ehxIyWN0Jb8LYe36XRtcL6sGb3JYcNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5ShvonS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0782d787so4706715e9.0;
        Sat, 15 Mar 2025 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053498; x=1742658298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4y4aJLpRHg93RygCDV746A0LLkmeQjNEa/sOSVLGr8=;
        b=d5ShvonSeaaA6oVb6oVeDLAOOI8g06B15EudtWpPNVXjdpPiseCSF3a9TzkuMVT5In
         qGWVAJNOcbLktyk0HZAdFt0xi1CvK3sTMCQRjwxtNYbLvz0oZufaUIEfS8IoL21iQyp2
         +lqJgPpeRY6/ntYoLxaZVJTTPeL5n4hNc22lAsK/c5fGVfLajgb1AOzdPIgwOCXIsPWY
         Kpyr+CKRmUFgiCAaW46TnvkLRkzn+BhDB5F5UiYr6HQfR4/bQmdNzC5zaWNqXaAg/axn
         03Mrn9dsTS/17erOr+2jPfSzvDaXu1J2lND2tcR23FEeDa3XXv2Zt4dd0VEA4URGlxss
         awjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053498; x=1742658298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4y4aJLpRHg93RygCDV746A0LLkmeQjNEa/sOSVLGr8=;
        b=GlqxN0WN8Qkmjix1Bn9IICGrxSWh3GLCXlk7bGpg1klj+h1bLzJkr53eAt5aOYvh6f
         b8ElFEUpD+Qfb76En+bZzrl+J6Os1kYi9c9AGCpTfiyXzg7Bvrk9+krP4Wy4tOFmpKex
         UMGAgUYNOW29O8OSuiFw5DuzkK5apxt+WoJ1Cn/NWX9OPkRSl77pXIdHQBocchUHMW/z
         ElopxwGzcmwk9OaoH9YySIta3rfVLisrc0GpaMm9CxarkaU7wyzRbd1LcR51ajLf5Rft
         lGZoZceH410mS5IEv0AVv4fNSp5YunZ9jUlU510p1DgwsGQHGewwFOYJpJJ0e88RTOU1
         20Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVFqf/lQ1iMPdpubBZaYoqeWJ3sSXYX3bbVWwSfyY511RrI1ubtulPsqSOUCNDwUJZ4pXEhpoG5KQp5NBL+@vger.kernel.org, AJvYcCVy+Dy2QmqpJy7LlArfsNavDXn1zJ0oLjZtp/bRE8AqkrjW4/OhWcNKFVPV8rZe5xyz7paC02bRl8V+@vger.kernel.org, AJvYcCX61MhMahq6neO2luiHz7nAu5WahSBFhDMJTXCGD7DtgZrwqCL1sUET0rdtq4+at7ECY7FEtv4v@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7QhWjn7tNAneIYuumDv4RFh2qQBCnGXO4AIRiyp1UYLJnM/M
	zfQpBIpWMOx6yLoriQv1a59gpwAgZdAkO72e6OFNJXlwBnd3MXwU
X-Gm-Gg: ASbGncv9q3UUBNxUmWOiNYNhIAA0ufJ1Lv0Wi72dklm4dUxCzx43b5eNkCy1rLlZfKQ
	oVf6zAj7K31ql9y3RA7ufKJRl5EpX4nRG4fWS3UuD7f3L1rPF9FxVZWp0nkUXq9C5BxzlSw4atA
	0JoRE8tr3GV8QVoqys/V/Xdf9BqipBljTLX0W4D9zf2XpiFQJJ2CA09R2L5aWvU1WE68d1ZB+wO
	cghyMm2+kSgioa6U1TI3my2SfKI4mr6ZF6Ilgqzgx+wWIHOWIc1WEIzTLZFk/JKCJDEVeNJdkBu
	q2dCqeZfoS+GIk6WYD4dPUiZA6zcVOrG2iZwJaA2c3KoGjgZhnpFArVNWnBBm3CiwZ92q4eRvXF
	wAf20D6gDyJRrJGfqDwQ0WcSl
X-Google-Smtp-Source: AGHT+IHdZpkFNBjA6COduNegwovJkZNCckMp9sNMex24ZFcOREOSr4DDptLMW0v+z79ptMTJ93Mulg==
X-Received: by 2002:a05:600c:4f46:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-43d1ed0ea8dmr86614825e9.31.1742053497868;
        Sat, 15 Mar 2025 08:44:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:56 -0700 (PDT)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 11/14] net: mdio: Add Airoha AN8855 Switch MDIO Passtrough
Date: Sat, 15 Mar 2025 16:43:51 +0100
Message-ID: <20250315154407.26304-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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
 MAINTAINERS                    |  1 +
 drivers/net/mdio/Kconfig       | 10 +++++++
 drivers/net/mdio/Makefile      |  1 +
 drivers/net/mdio/mdio-an8855.c | 49 ++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aec293953382..f4c8054d3980 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -731,6 +731,7 @@ F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/mdio/mdio-an8855.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
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


