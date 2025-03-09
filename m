Return-Path: <netdev+bounces-173341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B146CA58632
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A63E7A2F79
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA32213E7F;
	Sun,  9 Mar 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZQVRXUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40AD20297C;
	Sun,  9 Mar 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541290; cv=none; b=lD1FXMUAakxQIU2pL9edxxqEb+MS/syQf1EyxvJhNYi27fJXbrXmE29B3ezCpFIuS55zeeD1zgphfA1sQMAnOJttkZ2rDMpmOF0a7ENbrNFTmljl29k50XulVd/Ee+8OPSL+4Z/FdevN6GoHezMSobN9WLNDfUOxV0w62hbare8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541290; c=relaxed/simple;
	bh=qABqRCt39dPxQYX4EbWSbjexl8ALTWtBf0uTCt9NmHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcEt2hU5kdCKqPJgOn7zkeTr6RqCmkxYHSkmjwOOWgRUWS5Lp67+WKlfBl9ZFLIvRgB7xYDC6VMGgPojWu0BVzWoP4S9+5F3iaQQbSdd+ne33XWlLNThIo6Bw/GRF8XgpJsd1c5W2kPxbXmJGEpaDNBy2E65gNP9xWP/pfUfJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZQVRXUx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so36432485e9.0;
        Sun, 09 Mar 2025 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541286; x=1742146086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqRbWNLMFpR9KPwcpB1f2ftjk4mnZES8t+O0jPBCDUI=;
        b=MZQVRXUx5apNgNuh6/OMY8fqmgjPkTduHRKT8viyfhedpnGUigNtGEZRAt+I8Y9EEI
         fHsv9GBSJ40ggnTfTxqBmi7RZZLa+zCLAlaXTXFCE9TMeSB0DrOh0mOyYoi/e2mddWCF
         GMGB01SL+2Lx5kqeJPYRtMp99aIV2d2cPDY6Wzq53p1Xn6jC0/yaLIYI+bRVUt8wrMTf
         qmU+ZRGCccZO+IDk7sTVyB9cuS2T7jcst9A1eWb+963n7XGLPJJ0uHR82AOx8ot6Iur0
         6oLQnf1E53vCvBVVoNmVrxQM/wGbkv1j/6ohrz0REg4YQ2Nx+L7w9PgPG/ydxFZhhA/H
         z8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541286; x=1742146086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqRbWNLMFpR9KPwcpB1f2ftjk4mnZES8t+O0jPBCDUI=;
        b=vdWCa0ibv9Gqgk0kHcw3Bk8QnNdWF4uOqKi3e6t37VPGxw8J2nw1OhMBlDHcchWsMU
         V+wO7MG5hl0MF3HQFqNfX5lvvfc/VLAOd/bRiMb4P3WBD1K7v5lEGLezHX2H2+Qrz7f8
         TYhYGNUsjy/x/KbJqpqNq2xXmGaW6SOBsq1k+22BlQ0Dv1TxX9uxSnCYIJ5cTEzATXBt
         aWwtpalwXp68PxF4z0moJ2zlTq4kuxJ5ks5HtObd0oVHYdhpgWMXr4q7VKWP4Kwzs+rD
         RfY158Hynnxx0jHlYKZ46Yi/6NK/0kytwRSi9Z/JaC4PpTpuqF07WHClxLWDFxcZUvnE
         mCdw==
X-Forwarded-Encrypted: i=1; AJvYcCV2dv0MJ0CyWsk2o6opWeOeKM8wGtoCr7dyjheOC/IyLi6Ras7R98fgIK98V9MCGrnn3fPkaGZe@vger.kernel.org, AJvYcCVHXJObaSYZ1jIRiHDc0EGv9SQ9PL4nF86t2TAPPF8k8PYcA4toiUWinGOzib3F94ZtdQj4p/yS9a7D@vger.kernel.org, AJvYcCWXVfdNApfFGn1TlWyDQJbh10id/s+ftJRjuZHecYtMDxn3wC2gPoqthoubB8s8i4oF6Nq84RvjIfpJwqlO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yXz5tVmtA4uMHoQTxTX0vGz2CmXKs9TBiz1Wn0BOTKkb7/Re
	J4p8KAvy2KBpRTLK37hi/8egRAdTooyeesNUQrNE306XlN66+Va+
X-Gm-Gg: ASbGnctA232/0Pc99JjvtvHKr98XGnHwofoIBY5AG+eLPqbjfs4kpvsibLhNu5I85LL
	2N8SH2SC24Ew8wcgpVlShqwuJC/11/xS2Ez7boVnHCLTst41I+EZWPvuQ8oJAuCaFaGg4leO4Wp
	tZKd2Zb/4bKlVY4MmBoTIdPwE4FDKXYAMJsT8nQePQL7hTZOaZHXniOn2GeI8XRZ9G71+nXDGXa
	k8+Sfu/ta1UahikHne4NVeaerLIO+RSfdtbkgrJgzAAeCf7H6i83UjdNelA9CYZq4cdRjOV4z5O
	xRKNcJWlsiYZHKH/2CCvTazhFeWC6wzmXVsH3JYEsXtY5KofJmhDubNjxeJ4GQscCjs7IkMutkI
	YVxsSwqOKt1Lnrg==
X-Google-Smtp-Source: AGHT+IFD6AOwaOvthj1obMUkhcjcWW9Lb99/pnRyiMlPx5q3ab4zfTAV4SciIOYGcWdGBwDwsHL3cQ==
X-Received: by 2002:a05:600c:4fc5:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43cf9691636mr3314145e9.29.1741541285689;
        Sun, 09 Mar 2025 10:28:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:28:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 10/13] net: mdio: Add Airoha AN8855 Switch MDIO Passtrough
Date: Sun,  9 Mar 2025 18:26:55 +0100
Message-ID: <20250309172717.9067-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
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
 drivers/net/mdio/mdio-an8855.c | 48 ++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-an8855.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5844addbda2b..8c83c446a69d 100644
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
index 000000000000..d45f71c4b0b1
--- /dev/null
+++ b/drivers/net/mdio/mdio-an8855.c
@@ -0,0 +1,48 @@
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


