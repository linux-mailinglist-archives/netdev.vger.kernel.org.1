Return-Path: <netdev+bounces-180132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF71A7FA7F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4DD17F163
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182A2690D7;
	Tue,  8 Apr 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2cYk1g4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F82268FFB;
	Tue,  8 Apr 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105954; cv=none; b=n52WsLIt2VYlIMnbbptTYBZG7Ku5lUhFFfFCrdiWOwgc5vZgZPHrm8di62z1ENro/JN9BqHXCMq7XQXqGdYmYI5Udcce/DcW4qaQz9m8DcyI4gQmDHdwpQWt+fWwqvEEu1O5wvHDqjXfUn1rNeWeCRwUlHPZhbI251jLHORJ8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105954; c=relaxed/simple;
	bh=0j5PF56HQ4B3Au1Nft9H3QRxVjHbIBpRO2Nt7/QS4uI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZri/HvfiB4z3X67rzqYhqtv3cDrK6qUwVP5zlUYXRMzFISYQaLr53RT2WOzCOFw4B2zGe4vsKnx1gWT2S6L1+d2KkTG0e/LrpIzEbtP3zcATbsVlJvmjWSFRSuS7vq6VSuxxpyB8qD5qvlLEbw9K2TQ0c3DRUqrTWfD9/fnaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2cYk1g4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so4295929f8f.2;
        Tue, 08 Apr 2025 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105950; x=1744710750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6eFHR/+HwP+QVEyAdkJj9R1VCVx1cbNXlZ7PvgU5mg=;
        b=C2cYk1g42RQvQ+gfqRoa7Q4IaXfhaWqb+vneMzEkKpYnv71SsWwUqvTmo1eHvYHbfm
         NCycvsiMv//O+AvzVeFza4giKS63FAXf7maJ9G373DRu/ZTm4YciYp50cFn/dnFRA0l9
         d8DXGTho2oe0gsZ0j/YTSH/wCrYwaGv7vMHGnnXv8kGjvYMCClgzSNsn5fA6fpQBP191
         qlRiPe8I4Bo/y2ZaPgf1zblmgn/inK9KldK+EZ2ZGLxjWuYJrWfB2W0/hC/bLx9aVPzY
         bqqTQyCSCRj1snDXo7W1zEu3hDNg13VwjUX8HUmSuqQG2YCAHobB0kShw1MBt/0SjjAB
         WXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105950; x=1744710750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6eFHR/+HwP+QVEyAdkJj9R1VCVx1cbNXlZ7PvgU5mg=;
        b=YSBn1wcTkwLxxGDZxQQ6zPNP9SueKixpk35VxczX0q6YIGT75JEGCDPmpGpKvzle1Z
         zWAbMWLLgPZ9kutTm5kGF74Y7uq3UlgwOMV7Alw9j/0bAecyZRJO83K9rNVElSIPRcQR
         8pTfN1Cf3mf1W7gWKU6xmtuSDy/qCcHyyWjtamRJCbJN5/WSpEpEZ7hOky6iZogBOYNC
         +K4yT2Jal0Cypu1S4a4Bm3FMrYL4oV2e/kIRoThs2sRSf9ZWKzREgPKaoUUgydjhiv5R
         Gl3yyDn7PaVD58NqLwzoKIrx4axawa7TsERXjaJK2P/Y/zFmVGpskbB3312BWslfa3nU
         eCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgtjvuW4JizLEd9sctvGdmXABEJkqYiV5WZqLn6C3Su6XhXWNywStn+B0TG0FiJqyehhw8bXeZ@vger.kernel.org, AJvYcCUwPATCfEFcAydKCfnHSXWLekVigfujDaDQCwZhOGkpxt51nCP5OrjWcqwuKy4UDmHUJ1iIx1gbsfOfCYl3@vger.kernel.org, AJvYcCXWPDiqek7s/2S0NjBN2VnN0rlJxzn53UYTmgQNpm8+EwMJO+tdhb/6OEfh4XEtfiA0gwtJzk/bjxKI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wKPjOlxXvR+QYz0krhWhDRqO8G2FDVxm2nGgmSix20iXjjZV
	wD6NFM1LF9aWPUk/y8W/Q3bZ8Q15MPyVwe2oCwPMfVPNxcA3Ft/Y
X-Gm-Gg: ASbGncuE+kHG6MBHe5VrAi6CJMlJkhZ7X9LpnA6heauuJKsLxjTz53EU/DVx3gTppPt
	btjT/6PxcjECcv9xnrq/6zNB4eZiJY5A5I6R1E0SGNYLZXXG2LZ1/65ZnlH+d5KMMdIAuBpIcnH
	/Z4tdK3YbhGbDuXc29nPlkdZXkDKJ7LZWCmf75GeXEJloNrm3KJVJgGUa+hVRGnL0iOObCc7Fbr
	4VFArd0XvTtiIKlbhzT9susylt0ZWfmtPgKKiCG8MJsO1qgOsfvzIDXHju/aVZuj3XfmCo5WDsl
	Y/G92wudx6YD+bR+YzS3SqA8iOjH+3rt9GCLqRp5cov5iIOiaKg0xV7O/zI+LsUltu0rYFijNWs
	+VQ82YnLvuNuZKz6fjwgMTVFd
X-Google-Smtp-Source: AGHT+IGnYUhJy/g8TudXJhkOLcfaktByFDYkfaf3ydBwVqRyzcsHcERQeIuA1I+0QEB3ctl78R0VKg==
X-Received: by 2002:a05:6000:4203:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-39d0de28771mr13511876f8f.24.1744105949782;
        Tue, 08 Apr 2025 02:52:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:29 -0700 (PDT)
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
Subject: [net-next PATCH v14 12/16] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Tue,  8 Apr 2025 11:51:19 +0200
Message-ID: <20250408095139.51659-13-ansuelsmth@gmail.com>
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

Add support for Airoha AN8855 Switch EFUSE. These EFUSE might be used
for calibration data for the internal switch PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvmem/Kconfig        | 11 +++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/an8855-efuse.c | 63 ++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/nvmem/an8855-efuse.c

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


