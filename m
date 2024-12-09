Return-Path: <netdev+bounces-150212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7B9E97AB
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5DD166C35
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862531C5CA7;
	Mon,  9 Dec 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+7FQ7G5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566641A2392;
	Mon,  9 Dec 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751953; cv=none; b=ltZwl9mSWMmMSgS27QfoLevYl46QSHCUSwiIvBVcztrVMU7d3gAC5fb/dOpqz8/eK7K/84zJS8KjoooC8dvmgAJhHYEq0pdeuP/uki/cqldnKQjrp7kkreYa/aygfxXtwXYqDB2RW0/RZRg5+0IBMx8vATvSFEiaEN/NTK0d9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751953; c=relaxed/simple;
	bh=MgY8g3lBOFFnJ+fOdlUu+6vevhJcL9rG0/PqESUyWP4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDbMoi+EGbiSO51/vvJejdtcPGSZwxTGFN07F5OPBtBeWuiNPy4gedj9v0PAt9Gn0LkHpTGU5KzsqumIdxRhy54UDi6r1KYqcRDZMornJge3Et0WT/4BzqhWcqZKy5952zeI4jhvKBrpTWlVDTPd1qfkxvcjl3jwOWzFIOj0kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+7FQ7G5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a044dce2so47658365e9.2;
        Mon, 09 Dec 2024 05:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751950; x=1734356750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAoRbpj/I9KHjqRNCxcAOoeExD7CWt0cTY6Bc2WE4B4=;
        b=d+7FQ7G5rPPW5d36gt8JgaIjrqyDJ7Sb04Y++EZOBhdDRVWVR9jxMAWLEY2h31Sl87
         iLHq7rHT7VZgaJXEbmuEiWHPKLLANe0UBKAfdXvqNwfLmXgmIV/QteV2EV/Z52D0Kv7p
         giBI694V9XCZtFjJjP2FwzzxdwMbbG8VK/YVCmln29DFxT8GGWUPA7Z8qOH/hMTc44WJ
         R49VaRFtyRjqyP6mGh0DJrZ34ln9Ip9xiBluS53g8DUVAsEN80aPXpp3uSt+X+USaG/d
         iYqjnkz3+BAkicDRvDMNt5hmu02+xST4c6E92q2UIZqYWw8aSKFMtKrar7FETJGOzKSU
         UMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751950; x=1734356750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAoRbpj/I9KHjqRNCxcAOoeExD7CWt0cTY6Bc2WE4B4=;
        b=AvR88L0PfCoGbr9MbNuXqHIB6LlLtoUDhd3O7WWChwFBSHn4PRPeKesmn4sz4j9DwH
         zZzA7F/WK5wc6MCmdM1TYtcM8lNl4sD3+TAC9zs1UPmg1OAVGTYHGyBJfQQv3zuEdHee
         J7XH/U2dR8O6QwjOv+fn1xPIGMed9tfn27IsrviXVZlYU8eIRf67yCUKWPripVT6QaAZ
         +0MhqOTAab5LQ87WS3eT/ADU/2zDPdG5nlIuoolzjb70jR6ZvLM+yQ43wew97OrPVQfm
         5qaTq52Rxw0GaSbUCRdRk7SD3caeAUt4PY5JOyGNMouP53TuEEkcw6dH6i6QAwDaHuqp
         UkKw==
X-Forwarded-Encrypted: i=1; AJvYcCVioyv+XAuu7qp1nBeQUqjsKNtwO57daam4iqplTwkY59XYYBwYu+u3eF+p7ryTSbGzmQa3tl99@vger.kernel.org, AJvYcCXMqf31ckEUwl3pjceT6ohho9grsKtpidWRQWBeJAO/Phsmkire7Wwgwpk10CuHPPYlODJQYo/jtbth@vger.kernel.org, AJvYcCXnFbjef4lcVjWgD7a5WCpEP2pJUBzdqgEh7H/dVUoIkvfmj9ZLAgeUDbjT0i6FZaF4Ng2TYGvJNPXjLGi2@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsL8brCLQ7A4iC8LOE2EnV3voMdB9LC25+Eo6QRP92s3FDoFI
	cxhhjNPb1f73RE6DQ76fwvHs/TH54XZ7HRhZjzKX+VMw34V0ChXX
X-Gm-Gg: ASbGncssMAcC1zqvPKAapmPSK3WB7HDgQde3gmXd8+/wYYbG+M1MAwprBusGbNcKyZw
	+wMN+Kpao4W4vTEyTEepE8J8KRCe6zhkwL8u2jJOk1fuN6bwn7D7bxTs+xLiBOPBHUkfrVeOjA4
	uKxlKt6sAjcpeaaeGzf6AovfrsyARU5Tf/YV9uM/O9lbZDYR/BtXVMT++0TCj69W8lhyrDSPQ7v
	aIbySBqzYYuISO3T90ZnFBORinOl4YR9GtnFoMMuox57R4jf59rn0IB2kWSAeRigj6oKxszsbiq
	3Y95bf52i1dkYS7/NfE=
X-Google-Smtp-Source: AGHT+IFnJqIAyRA3SpMKzCKWGti35qLZlCEBlzZyV4S0XM++5A+ijfnInJHHTpme99QqdYPh2M13xQ==
X-Received: by 2002:a05:600c:3b99:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-434fff41467mr5994205e9.11.1733751949475;
        Mon, 09 Dec 2024 05:45:49 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:49 -0800 (PST)
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
Subject: [net-next PATCH v11 7/9] nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE
Date: Mon,  9 Dec 2024 14:44:24 +0100
Message-ID: <20241209134459.27110-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
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
index 000000000000..7940453d6e58
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
2.45.2


