Return-Path: <netdev+bounces-173342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C968A58637
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952333AD1BC
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9F21507D;
	Sun,  9 Mar 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giPkexBI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A11EDA2F;
	Sun,  9 Mar 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541293; cv=none; b=QHfnZDAVniRP/DC0mSIdN9dP0Qo6uqQvUS2/OxGcsSlLkFDHYSp+2DAu/DepK0/4b+JC+bHny4p1hsHYF7RraqEl2TqOjkLRMrcOsQTBFUwxqtgftwUy0PGy+BbPFTy45FyAV4XQ2VC5Ve9eIU5thQwTPxrb8fu4B5cuPbv1J+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541293; c=relaxed/simple;
	bh=V1RpA6zANbM6piiWYDBd8fT4vm0hP0xoCkkgLzKqD3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+S+LW16fejeAiiYjrpHXt4IFH7Vql8ySHMJ/R0PeY7TomltzOJsHIHIOhOk7UWD2ViBGDpSwRwucSJhraIwWCj4suvAFOG0UMvZjirvODYPjD9+S8zpL0qgXCAh59bwmpjhhK1kxiH1mOrUfCcB6Mz/K7X3TXm7qB965umrDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giPkexBI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc1f6so2481726f8f.1;
        Sun, 09 Mar 2025 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541288; x=1742146088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1JyU+UUO9hCdIjOoey819GpAJ67w+5u6uyc4KB2ttE=;
        b=giPkexBICBwbeKB0HJNTzxCSAX/6sk3ZLnDw6K7xx2DQSVn6/1Yv9ZVMGJf66q+mXn
         6ddUNaBhZAnLIRqJ+hd9NTnSL9hf5nVOVRmispR20rDTcbtE/NxqCFT/bnST/+7GJjU2
         e9zRnpKoTsooT6u+Exladb8yOhSBUKmuy0xRsYe6IcHgjQnVBjYxBgCXAX9SYn+xS8+5
         1d6HvAUcq+IwrqnVx23YhG6DlFEwt6QlGv559Zki3u1SJeSjKDfjdn5XTorfNiE19uWn
         Maj/YPyHXYPBMyxYaWanCAuLCi6CEbUSAbzsyyltNcSbZB8+l8Z+mRyesSCoav+o+ltU
         n7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541288; x=1742146088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1JyU+UUO9hCdIjOoey819GpAJ67w+5u6uyc4KB2ttE=;
        b=ZviD5D2c9wmErzpTvCjsRW1i7F40wL06grVjzMLj4i2PvnJfWhimjIVBR61bafeDh3
         jq3hH98wLUxmUqVVwLDUoxs+NHUJ+jIrAvC4o7pylIy7MG5UaSg4HKqyp1CnjjMSxNuR
         XX/Zu9I7o6d11D78Au20XX8MJzu8r7Au88+kWoqae2aYpN/lhntgoLl6fEmni625CkLc
         u+F77JiDX6UtG8zl1orEFJE+nS9kXL5oJk3JstG1xMCo3PPzxVV1NNbjgznU5jt9sAfX
         YUMj/7Rv9DqyO0/IdCd1/KoAu+0C2DDZi81p4z37r+CeZgSwrO/JHvA0cjAHNFvyDJ7+
         WehA==
X-Forwarded-Encrypted: i=1; AJvYcCV6kai1Bp67dP796gvoGU5vgCbCe15mzEfvOEEnUOe7jqOhQRDOS9Q2jjloDMBVQS2JzmidvOvW1aXgD91J@vger.kernel.org, AJvYcCWlIuC0AjLhO3NbKDXLi0j3YNNlUxGL+NQ6XVG9lqWaaFGKN8kc8K45/e0IjOu8GTMAnX9Vf3uI+haQ@vger.kernel.org, AJvYcCWzDoBxbGNTM0IyI4gsVCt/JMItqgq+08LLPh2gPKYySNGFtGt/dsPOfoEmRme08gWpaovSPByE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rZi/OHJLEHUy9QSNp/+rMDdB9dp+ViCvkchGpFJRoR996cji
	nKKSoxk9jHVBnXhoZ+g3fSm0FwBUqojlXCaMFvuyBGsz72CoWhRV
X-Gm-Gg: ASbGnctqCE7uKnxEPBQ0q5nCBodLO2GPg8dYclv/p6B4ja6txqNOQgnq3ldY18FrdG8
	XtuZ2PH4t9dDQnmzBFXUUf8yPdRTs7H9UyTUJ1yYHKlycpeB1imFchtbXyBNa1XA+R0ovY3ajzv
	7JXOL0iRxztNhZx5t8lS3Fw1uBNzUMEnMrbnHRUDY3SRQgzsUFqIzwiKAGJ0nFU32J7diBp5Lz4
	Z1k+Xc8zP0iAdfffFrSUhQm8p20o5sdj3lVdDqVTwbOoOB7sJjMnEuHZ7d09SbUOo8DLxovufpr
	ptl17Ak1N2b2ZPdyn7YQYdWYlRfkq1Ype9x5RodnwZVcctT1lRHF1t1vYtBJGnS7ZzCV5sk/Fum
	KNCltDDV5so6Zjw==
X-Google-Smtp-Source: AGHT+IGNhikt/NsxmJGdqtqwlToXHAZwvEm+PC/3tUA9VKA/p27tdDCPNBTEMFW0n6AxaZPDiTn/kQ==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-39132db8f39mr7875008f8f.50.1741541287684;
        Sun, 09 Mar 2025 10:28:07 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:28:07 -0700 (PDT)
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
Subject: [net-next PATCH v12 11/13] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Sun,  9 Mar 2025 18:26:56 +0100
Message-ID: <20250309172717.9067-12-ansuelsmth@gmail.com>
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
index 8c83c446a69d..938b81767862 100644
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


