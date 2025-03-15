Return-Path: <netdev+bounces-175069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2235BA62F89
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27DA178C45
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57BC2080EB;
	Sat, 15 Mar 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9KC5vjM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01561207E15;
	Sat, 15 Mar 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053503; cv=none; b=toT98hlZZIk3wfqImFMIe6suDpTQM2dROmzZan1iXkACVzwR7EoYYNtZSFiQaGDs6Zx5vCfcLDcSZLJZ8clbMhL02iRemAs+wBovj1JlgYuou8G8ga5S85zhk5p3Zm2pgbMTGgrKQLaUzYBu61xtOKK+Fbzmd1JEyZOMB6mz/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053503; c=relaxed/simple;
	bh=Z35ZnIKoReguzK20X8IXHFFEaBZBmnqsnu4YCuxkgsk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCBQ7oHikQ90QtUQsg++b0TFygVX/YtEyOdKg8iZzzuY/p/JenSIEF5wL2uhWnGBbrwvUCEzAXk1i4hpG4nuOxfhX6xFrm5oEL/YcQfcchfBkFtdtdzxk44NyjFbc9m5cWuJa+srxK1QMH95T0Ivrlxn/jWgA0c/XsJ9x3oFa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9KC5vjM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso7158795e9.0;
        Sat, 15 Mar 2025 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053500; x=1742658300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLADOhZLwHgDJvwkej1GksyyIBUmhIAfbT2mkxjXrtg=;
        b=P9KC5vjM03KlHpAc1yTVBVH7qdDqAFXfv7kb3ltZuoifzk2tJkmAqszVEBPdYtscSM
         gFYuTV1m9MMM972HVKe2OHDG3kFic4NR6nxZx+6ynywQHoyWGHKavpVLaJEsOvo3KJxC
         1NDQk7paNIphlRDgsNcxbxUndNpKlMKskVjIa+vCHy1r8gBCW2VLIXXIkmC18oK77ZQ+
         MNQ4gFOdx6NNOOydGjE7y+u8ij0JozXuaoNeC440i9ULG+XHZD8UfQyNpfrUALW4qtbJ
         yJuZCPBL5SrelEIh1mYLjrfuDer9tJfAGbDlrO6z4lvLGnArgI3u+ooZntcyBnyixKW2
         n5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053500; x=1742658300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLADOhZLwHgDJvwkej1GksyyIBUmhIAfbT2mkxjXrtg=;
        b=P8hvesOOhC9XLRem4C6P0fFJgMWSdXH0oMY/Sh8G4T91/kj+GuVk6RREjqXMztru6r
         mv4nXQzANU2vbL+cwa9wqTGBUdOkTDSN1dCQr7eSThHEsDYTjQooJzNaW3b5HK+H2V7E
         ROqb4E2DKxDn7K3NE0gh6yw//VGiZRuLsw752yfTFKD2Y4WvANvjgxblXXeNPW+7gIEE
         qpdQhgnByad7CcK8CGdzAsZb/hI/yuawnTNHM6KoURemrg6XxWBQfOvziIDwM/WSabk7
         nHJITPV0fPwNKG+fEOKkE/vB+0tnFLp2Yb9UyZCAPnlWefj6uwRur9MnByPYg7OXeqDp
         /MVA==
X-Forwarded-Encrypted: i=1; AJvYcCW59gQoS0WP+F6f+/lWyr411OfjOtzUHzugssijTmkUtVJ1Tjyr2bfcPOwy33/eICwPl87O/4Dc@vger.kernel.org, AJvYcCX68vVSJRLtJwZ6yTZsVkGXZ1bZAugCSngZh03a1it92iwrItbQ2V45C+k6YmEn6ZpFwxC3gwD26frkQMCH@vger.kernel.org, AJvYcCXm3zDyZhYYnzlRNcZJbtMZj4i3SE+rubQ2vlAah+zy/z6wBI09v8W3BQ6YLFDH4CfqbpDtToFVPMkw@vger.kernel.org
X-Gm-Message-State: AOJu0YymVAlbJ89F0zK919eL9LTeJRF23eQo3oviAH8GYxy/UQd5genf
	0geZOaY34zHiveO8t9mDLJN7v0JOeQLUb75HfqL8h9cdW77MsOPJ
X-Gm-Gg: ASbGncv7v6PnlsOlYu0SMCWMLiEsh6C0zSHm4mvzi+jcX3yoc2PPpLrX2LkwWRhWkJ/
	ewquz5Q/gLZTp45reW6AsVohUhNgOJUnU48PvSFtGUpNDOzFr65+HPpk5koQyNGbnVQomsgp5da
	UDeq7+ukWV6jSblhX/AmHpp3JtaOxj3Jmhd8GHJkjXaxDqobhpB07ixfIelTg9vB4HjgUTly35x
	NumyOEnekiP3QLBmFGIXtsPZwhUA14X9sKmvEy3bYvXYJxtPO30SuSPfb0JeM6MoZwKVAuyTW7t
	Pb8dD61gLJ43q80+CUlgSh2ABynkk9x7F/nDIvBcLhgqFh3kC7T7nuLhShLcMEIKiiKQKxiNksm
	4cf3VSqGw7uSL2Q==
X-Google-Smtp-Source: AGHT+IHw40EB6m3XbCZVxnXK0drFuLtBU4zju5WbN9CNTainjG2Tg6Im/75POmqbfCbDd2b7v424dg==
X-Received: by 2002:a05:600c:358c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43d1ecc31admr77024235e9.20.1742053499835;
        Sat, 15 Mar 2025 08:44:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:58 -0700 (PDT)
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
Subject: [net-next PATCH v13 12/14] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Sat, 15 Mar 2025 16:43:52 +0100
Message-ID: <20250315154407.26304-13-ansuelsmth@gmail.com>
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

Add support for Airoha AN8855 Switch EFUSE. These EFUSE might be used
for calibration data for the internal switch PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                  |  1 +
 drivers/nvmem/Kconfig        | 11 +++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/an8855-efuse.c | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 drivers/nvmem/an8855-efuse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f4c8054d3980..2cc8871186d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -732,6 +732,7 @@ F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 F:	drivers/mfd/airoha-an8855.c
 F:	drivers/net/mdio/mdio-an8855.c
+F:	drivers/nvmem/an8855-efuse.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b9..ca96c6ea685a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -28,6 +28,17 @@ source "drivers/nvmem/layouts/Kconfig"
 
 # Devices
 
+config NVMEM_AN8855_EFUSE
+	tristate "Airoha AN8855 eFuse support"
+	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
+	help
+	  Say y here to enable support for reading eFuses on Airoha AN8855
+	  Switch. These are e.g. used to store factory programmed
+	  calibration data required for the PHY.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called nvmem-an8855-efuse.
+
 config NVMEM_APPLE_EFUSES
 	tristate "Apple eFuse support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5b77bbb6488b..c732132c0e45 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
+obj-$(CONFIG_NVMEM_AN8855_EFUSE)	+= nvmem-an8855-efuse.o
+nvmem-an8855-efuse-y 			:= an8855-efuse.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o
diff --git a/drivers/nvmem/an8855-efuse.c b/drivers/nvmem/an8855-efuse.c
new file mode 100644
index 000000000000..cd1564379098
--- /dev/null
+++ b/drivers/nvmem/an8855-efuse.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Airoha AN8855 Switch EFUSE Driver
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define AN8855_EFUSE_CELL		50
+
+#define AN8855_EFUSE_DATA0		0x1000a500
+#define   AN8855_EFUSE_R50O		GENMASK(30, 24)
+
+static int an8855_efuse_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct regmap *regmap = context;
+
+	return regmap_bulk_read(regmap, AN8855_EFUSE_DATA0 + offset,
+				val, bytes / sizeof(u32));
+}
+
+static int an8855_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_config an8855_nvmem_config = {
+		.name = "an8855-efuse",
+		.size = AN8855_EFUSE_CELL * sizeof(u32),
+		.stride = sizeof(u32),
+		.word_size = sizeof(u32),
+		.reg_read = an8855_efuse_read,
+	};
+	struct device *dev = &pdev->dev;
+	struct nvmem_device *nvmem;
+
+	/* Assign NVMEM priv to MFD regmap */
+	an8855_nvmem_config.priv = dev_get_regmap(dev->parent, "switch");
+	an8855_nvmem_config.dev = dev;
+	nvmem = devm_nvmem_register(dev, &an8855_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id an8855_efuse_of_match[] = {
+	{ .compatible = "airoha,an8855-efuse", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an8855_efuse_of_match);
+
+static struct platform_driver an8855_efuse_driver = {
+	.probe = an8855_efuse_probe,
+	.driver = {
+		.name = "an8855-efuse",
+		.of_match_table = an8855_efuse_of_match,
+	},
+};
+module_platform_driver(an8855_efuse_driver);
+
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("Driver for AN8855 Switch EFUSE");
+MODULE_LICENSE("GPL");
-- 
2.48.1


