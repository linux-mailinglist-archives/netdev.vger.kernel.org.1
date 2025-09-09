Return-Path: <netdev+bounces-221011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C147EB49E35
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6451BC5A42
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A451239E97;
	Tue,  9 Sep 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9JpJzXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D00233134;
	Tue,  9 Sep 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378646; cv=none; b=QkzBh6YeCgOts+KCIy+aT4JX/1WQEJwyh/RHALBgihtD5kw2oaHQQxQglBlXXy02qYnQNkioT1Ve7DG+0pc2BRlSZ+VPM0jZvLgntree10UiHiVLDrqL6HE1Jm0GcVpEyeBCNHoBljnH7WrHDXRlYWRMzqQOz/QMeVfS6P/r428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378646; c=relaxed/simple;
	bh=uvVLxJiZpVUVYcaS/6wXhQ1QCCor3VuPPCgSg73s0/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjOborrKlsE72iE1r3u/CsiFCXZBZbtq+jEVLT+6Aof9Mw8PE4CvFOokRApxH24qTXRMbiNE0h41Cf1l5eIFLDLp9dC9rNkrfRX9F+9hsEpE3wn5DAz343pxI/nmSPlzpCUL45ISUpfALmBK5xco4rxpc12MuiOi3YZJEU+PPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9JpJzXq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5492350so32269025e9.1;
        Mon, 08 Sep 2025 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378643; x=1757983443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8ZxWh8QbSoPIVp/7cwB8nhVxGRfzfajbCEssA2+7fk=;
        b=G9JpJzXqkfewCj/H+AdDz93v/O715uzHOjBk0xQjy5nU6/bwO/QI9OvSscwh8wtgfs
         KMABtXhmObs3Ur6XKkO6LgeQlC7OldTvB1odaUgUclxSFc7AJ/C+RaPIBEUO+WheFlRv
         OqWtNbuszxurJVyMgF/ne7OWrNOcvxswCsfW/kSJkMCj62B+nCz7aFcw+ZZieIerN05y
         6BHSW+0czWrV7nk20K0Llg4Qwk6WvcITdnak0oOeKNvl4avjt9cawyzRYX+a/BJtgL1L
         oYlRrATKPWwk/O7pr7ID5BU+4IkFTZacsvBFvE/Suy/mw32C9rY2br/s9SnRqESyl/nw
         S7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378643; x=1757983443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8ZxWh8QbSoPIVp/7cwB8nhVxGRfzfajbCEssA2+7fk=;
        b=L+rvOD9fG3FvbQ4cJuuapr4wQ41XxiFqHzt1jLON6FhKVX45fiVxdogYsOPZhA+11K
         VLkqS2aalJk1zWa9cNJtgGQgvjEGJX6G1VbuAy55jnndN7nR1MPmKWDwK3qCuLys+Mx2
         QpiwrAxusMvoiiJY/Is/YX79KqQ0jX5loAgZLHpEbh9/BMsMWT53sMhmeObuGWN1K+4B
         cIjh9jcVNOVyzIUrHST2iybRFRGfVEnbwJPWLeY1WnRbZggWxeOIsqVP1AB7iw7J4hue
         zhhDbenrpxig01RRhARvWON2Qapz8YHXxcDwQiFf7NFdJR2Pt7IGoKlk7g78Tn6GIGeF
         CVmA==
X-Forwarded-Encrypted: i=1; AJvYcCVtCSkYxGxXDxnXvfROMnnwEzvoXDHSzVBuVI5Aif5K1tLrdTUbxbeeMhYzlfj+X8Qg7E3zkqAB@vger.kernel.org, AJvYcCWNmq4YZHR9AiJv2CnFvskiAZ5vm6iC7aWAtuXSIbbGkFtV2uUjg3c3I8qBKesRUOne5Pmq9jN9BWHZC5Lv@vger.kernel.org, AJvYcCXXo16sFbz37+GK72JFWZdRaw8EkNuUFBEyzbYkGS6ofrReaMqohaEjGM9ZQkcl7ZT01uGpYB2DcQ1B@vger.kernel.org
X-Gm-Message-State: AOJu0YwBH54BRFclR1rk3iYIQ6EFMpT9mUpMIib++jPHKwo13VaqOGKj
	0f6Itedi8wiJ0x3cLFm7vevYmJx5+Z9mgHMjinCADqWlnpQbgwu1t9XD
X-Gm-Gg: ASbGnctAxOjIKpHx8OFwMjaV6gGVWD2tbniAg2yLEhojm9k792bAbabMaS2PS5loiBu
	ajcmswmKjVOqe6qSMZpHMhVAg/uMc0OhEAnAGUQrLBV0M5nTzjWd2HyQNDWurty1bFkMDgBT09U
	0fiulq7s2CWNSWlYWmL9dPz3rIwwwmCOejTY4oaKx6PRjq+WVrc3C/NYj+ZGOuEA9jbLF6T+9ec
	/O85ZEXEqFZXbdiKyBgYwJYzotgSZW/tUj8v1lYnkvwdLG2CLiTPbPc+xVkGdinSi6hrS86GJ7U
	OpIQAnFeuXNtmffZ5s+F2Zq2nQQ6X4F3Boq7DCVQltt5tI3/jzA1xfjFrEEAARXoQztlrFTu9Ae
	Pvl5paEYjJ5OdEskExqEqsYgRsOXzMQ4kbDWIcCsmGmDJ3639YiKz8Z5mY6KjNA82edbWmnw=
X-Google-Smtp-Source: AGHT+IH2QZT//ViKYRYMV5MXicqqc5U2Nniw6K5/BIDkRECDDT9hG2C49l/NAs8DHGYP02QVVHvpTg==
X-Received: by 2002:a05:600c:3113:b0:45c:b5e0:2cf5 with SMTP id 5b1f17b1804b1-45dddee9c4cmr90116085e9.24.1757378642688;
        Mon, 08 Sep 2025 17:44:02 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:44:02 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v16 05/10] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Tue,  9 Sep 2025 02:43:36 +0200
Message-ID: <20250909004343.18790-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
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
 drivers/nvmem/Kconfig        | 11 ++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/an8855-efuse.c | 68 ++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/nvmem/an8855-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index edd811444ce5..446818a875da 100644
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
index 2021d59688db..5c9e6e450181 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
 obj-y				+= layouts/
 
 # Devices
+obj-$(CONFIG_NVMEM_AN8855_EFUSE)	+= nvmem-an8855-efuse.o
+nvmem-an8855-efuse-y 			:= an8855-efuse.o
 obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
 nvmem-apple-efuses-y 			:= apple-efuses.o
 obj-$(CONFIG_NVMEM_APPLE_SPMI)		+= apple_nvmem_spmi.o
diff --git a/drivers/nvmem/an8855-efuse.c b/drivers/nvmem/an8855-efuse.c
new file mode 100644
index 000000000000..d1afde6f623f
--- /dev/null
+++ b/drivers/nvmem/an8855-efuse.c
@@ -0,0 +1,68 @@
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
+	struct regmap *regmap;
+
+	/* Assign NVMEM priv to MFD regmap */
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENOENT;
+
+	an8855_nvmem_config.priv = regmap;
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
2.51.0


