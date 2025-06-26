Return-Path: <netdev+bounces-201685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AADAEA8C8
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3325F189AC95
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D266285058;
	Thu, 26 Jun 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbmX6uI4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109D277031;
	Thu, 26 Jun 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973046; cv=none; b=BeyyPGqkiiqYQIaibLODls+eS3JzsPL6ZdnL/qBgG0KuoAb2GEubLZ/Acqsc+Oq52jQiV+l+F/s7Jv8WhRz8fKVyDR+5Z00o1y4oAw+hpkovXYTgPVXK2a9QUz8Zv5LW98HO5IpNng3kgamWW3ATyz4DRJ5pGwys1kE/P+DQYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973046; c=relaxed/simple;
	bh=JFw7TrPsCT0OFXmIGmyZgDpgghjWJZKpxZeoG+2gAJE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBUDenzG3xdWeSG+1nOpwbcDei/9reKROB2pHTMyyUU30eNAYxQx1U+b78dBsRD0aHWRpvdFoOg0IdMd7PlpDSHUvr908Ttw9VAsV7JawA3lCXJo/YSb49BxAsAs7LqPt2HWNEIu0te8oWy9TQixnv3btIVd43SlQPGJ+3K/f94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbmX6uI4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453398e90e9so10655125e9.1;
        Thu, 26 Jun 2025 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973042; x=1751577842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIOMFqyNUBF162fetCo3wyfrnMMJk+JlU3hf3FfA/ng=;
        b=jbmX6uI4EUeLLtUMN/cUDyY3MuFaSPKMipIG6YR2h5O8Q6CZZ8e0A58Mt0sOOv9+Fr
         Tz2Wj1ykz1ZeomdtablXWO/ZKlrE24TQFS9AhAlwYfQYzNuwv3gxmiHlHX59i0KLKyt1
         lDj2dtVZbD+NcIaEzrWYt/2qVudr6wRJSuVC+xtK2ImX/ifB/41pFZuB4b8fH++hR5kh
         XG499g5MJHXv3eb6K6asFOuVbJ302w9vYb84PG7hMn+6cHKhFFPHFjFlLMi/RJokQjJy
         8VxAU+d2oNYW2ZC5/+PFYftglUdHXw9wIlO6cJUvrlA+1dSeP2p66H1WV+1D0/rGSh9B
         /b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973042; x=1751577842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIOMFqyNUBF162fetCo3wyfrnMMJk+JlU3hf3FfA/ng=;
        b=D0YjSjgq3903OQ5NK/6HhjLaFIrgutK4Ltnu+gM76NvTYPbBnvgCaNIfb0TmZ1kt3E
         JQLC8n1VFrRR0c32GLNGbbzO9gT0l1oKHDNQ1hTZvewBbLUZI+lU7t2/uAIab2nGY8Vy
         BJnQ3FItVXAEjeBt2j36E71AgWEYU5v7e2dmOv3ZaUisYYWIKbPmgpGFVy9Bb7lnTZx5
         WMDnryYBidB5P7jPafLbRl58dNpQOk9XAXEiAgHudVSmY0NJ1FEOobSK/Q4nG5BVRh9M
         JNUiGlMdZISizSr3wKRHeVwxBh5UgnIdhXHzMDTG3nzZxkwcD+mwDZh6m6WUL9Laukgz
         X1ow==
X-Forwarded-Encrypted: i=1; AJvYcCUDd1JG5NOVKI5hHPujhnAFKz2GxduwQOdpv6N5bURZ0DXtO/jiIGO3Fu4Vjt1DjMmhtDV1lQx8RnPJdcvv@vger.kernel.org, AJvYcCVrCcUDM2xIzSfLKZvtxmu3xE0u1rTNoxARKMlmF+xEqxHOTkj1n7Ot1hjG+pXWc5hYWGYxjEaA@vger.kernel.org, AJvYcCWZTXZ7y+6NokMh+An64onQXFfOvCJZwZOVMeJd6qoIg8CAATsuDyOsnzaUNM5lQxTSfdiYiIIsVTPu@vger.kernel.org
X-Gm-Message-State: AOJu0YzFs69CKNPLlJEc8mHHVuvy05gqOXGSOEaibe4bcdz3ToGgFC5x
	CHoQF2G4Ily9WceW6luG7hMqdUuvzTY/5uiuLncIJFTuY0L9PSq1X/JZ
X-Gm-Gg: ASbGncsI0eq5KQV2e7WWv5NbaMwN3EQ/DigY0EOa0k/+YE8fbNMVEG5KqQEU8YonDEt
	mDEBq09TWkUg39pHiIK6Hpu1lS7W8kEPDlMH1ch4LZdhVrUNqsaABjK0+krgIFoMjP+5CcieKqk
	JzAlL/zjEj20rd+3hNOLBTt2f9FD+STzUBsxf4aFP37VYqy7PP/5u4anSNwrCpcjhMobbdJXmpE
	wffaA3ZcvLNYP/Jlgl3gUiyBHXq2E59KjGinqCnlTMUpjf2RbCZDo0D5wEX45K6h0YSYJwNemHb
	3AcoytpI6WmrR4jLgHc1SLcFgtlQEyXkE0ua2sQQRPv0FJQH03ziecuGHkdsIOSe0psc876Beff
	01kvUNBwlzfqoe/kDfQuP3hXwuGhAl9M=
X-Google-Smtp-Source: AGHT+IGYoTCE2ejOG9HTcWhAHwI4ndhvI/OD/F9Oaq0DjE5kPHJxe/T8XEsB2iQptOTFDVbPGZnj9Q==
X-Received: by 2002:a05:600c:828f:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-4538fdfbd9amr488595e9.0.1750973042423;
        Thu, 26 Jun 2025 14:24:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:24:02 -0700 (PDT)
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
Subject: [net-next PATCH v15 07/12] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Thu, 26 Jun 2025 23:23:06 +0200
Message-ID: <20250626212321.28114-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
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
index d370b2ad11e7..8fb1a0efd431 100644
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
2.48.1


