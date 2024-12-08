Return-Path: <netdev+bounces-149937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846279E82E5
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2741882D5F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514414601C;
	Sun,  8 Dec 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNYCTfP0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F1E545;
	Sun,  8 Dec 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733617322; cv=none; b=ZUlkFOwQ1LWJCTQS1MgH6dnS0j54rGn3PCcmRYJ/+/fYkMI31c4zbNHIH4Z2NHlFNdrks28BxIXbHJVu+p2Y/KWUq+nlXZuAThawyFadx+65wymCkxJYbXYAMzzlc4tHKAeccYANb66oTJPawU+jlWzgFGIriK/ir569YsGyvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733617322; c=relaxed/simple;
	bh=R4VQkKFyWkaq95UGbtMocOY/Pr83Ejbx1+MwFeH5FXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvKVSnwSWbnH+HeDO+4IkcrIaaeFPQFExKJci7A1UZeSjNh1pYiPxjLmcvuv3ohVpP36GGmiTSg9N0bl3WjtiqxyLidVmSLTuFzKsGtv0fMf6CsiRmufBzszGCS9KFZBri2LaWzLq+9w74NkPGJ0z7d/jICgAIEcUq2QB6BsG3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNYCTfP0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434f09d18e2so5017025e9.0;
        Sat, 07 Dec 2024 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733617318; x=1734222118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5jmD11PWNeZDLqwGfXpBO8z0RHdtHLmNHFwpPU8zIg=;
        b=MNYCTfP04HtURLUzjMVET/YrZZz+3R9PaO0aB443dq6rq1LBuxHROBi35u+PxcwpA3
         ZH4upwF+F9WrMfc+odGjcQxLZk+sRUfth3Ut5y26nb9OH5khsgaRynMOrtyVT+SyMSOI
         Xhf8dn25M+2+aYJipGl3ysIAcIgV3soF7mLXicjZG9JKHlL0VC4P5PatEkqVGBQ+YIjr
         jQ9jr53tGb4fbNfPIV4BgUxOiuMJ54zbLnz4QxgC6BoXvtbcu76gfdzQKSySbKN0N5bd
         XCuTWRi/1sP6URFlNagVV82flYP+QpZF4E8eNMPDgnTzdygBy7FbDiLizUMz5I6J1sVi
         /r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733617318; x=1734222118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5jmD11PWNeZDLqwGfXpBO8z0RHdtHLmNHFwpPU8zIg=;
        b=T1Ki8gKEvWyMdHujaDP4rOCCbG1/YeSRtQ0aATi0t4WUGHFoFhJm+GgZxFOKyRyAec
         GJa2aCZ/Je1szjzdTIh/4shIckXPUzuzQhb70FuRVnobo4zp6DfJF0lugDbKtV/5c6rR
         TdDKJMsnP7YxOxJbgVWKMEz28ZcpT6JgtwgEpBdLe9CSiB6ToTCDBpzXSytXMn7GYmzE
         6t+bney7sQ47GYT2E58Zr3rIS6Hu19+MSBQZK4nL+SN0xsCc2r2OWR2UR2ySsCkdA4Bj
         sWOszNqmGf7GuYu8oW5b+UXPS2smwPUqGdjS/TkkT5kJ5kmQsX6mJTyNL7usgwxN/u7D
         kMkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8KQdT3+dIVQM2ZwmPiVPeqJkYP8YsWtNydIz7Zq/AQD4KX/kp+I2FtnMt1b1Nc0LtDrpX7RB4@vger.kernel.org, AJvYcCVg7/U/dZd56MmDLf95P7cQETUhLqZUMy6S0nscs3mqcQXWOqRT2zJW/HtFeW/Nlq8usMQL1tBl+Bms2h+9@vger.kernel.org, AJvYcCXn9xQTG/6tQy9mW+Q8z9zHQRZaPilZakplvrX/3ieSOTl7JnaNQewxMeyiQ4tDZcI30JRke1vi79AY@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnr76SaquMDGOOUMhPva+lSwUEGorqcC3HqsbfEpJOgQKUZI7
	HwsIO1gDrddZkkciCR1NkoeTnwLMxP2PTFVFyIDrrHqlR68yfWPe
X-Gm-Gg: ASbGnctv492NdnmaeqFV2aPNtpQ+npVETf7rAB7ncArv+73m1JOgwL98O7e70OyTz6Y
	FT/OUXTXWbIg7pgoNeffcEz/efqmv73oRJsCiJnuUpkVawzM/5V4C5iElfQx3p2ywEcei8gYQKq
	86RknjvvqA/fBHByYcb1Wbgev8wBYr20Db2zoJJB9PhgDfvByXFkbg5epF+hljNrBpgtk4EBnjx
	x2/fRXHWxDHKxa8nltDamSwJYwDB4jL6tJUWtHkB6h8pgVSnC992VZM/4FP389YhK8Wsz+a2xb9
	SoQw7i018+gCWqUswI0=
X-Google-Smtp-Source: AGHT+IGlPxkhjBZU1P+ViteFWg8IjOymFmWAF0Cioi7pkGseebSWl4/7ZlAniruzdMwAXUnW8MNN4A==
X-Received: by 2002:a05:600c:310c:b0:434:a962:2aa0 with SMTP id 5b1f17b1804b1-434ddedbb7fmr58050725e9.32.1733617318340;
        Sat, 07 Dec 2024 16:21:58 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38621909644sm8719170f8f.76.2024.12.07.16.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:21:57 -0800 (PST)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v10 7/9] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Sun,  8 Dec 2024 01:20:42 +0100
Message-ID: <20241208002105.18074-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208002105.18074-1-ansuelsmth@gmail.com>
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
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
index 38c7b2362c92..a67d147276a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -723,6 +723,7 @@ F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 F:	drivers/mfd/airoha-an8855.c
 F:	drivers/net/mdio/mdio-an8855.c
+F:	drivers/nvmem/an8855-efuse.c
 
 AIROHA ETHERNET DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b9..599014970c22 100644
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
+	  be called nvmem-apple-efuse.
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
index 000000000000..cdb7654bf694
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
+	an8855_nvmem_config.priv = dev_get_regmap(dev->parent, NULL);
+	an8855_nvmem_config.dev = dev;
+	nvmem = devm_nvmem_register(dev, &an8855_nvmem_config);
+
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id an8855_efuse_of_match[] = {
+	{ .compatible = "airoha,an8855-efuse", },
+	{/* sentinel */},
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
2.45.2


