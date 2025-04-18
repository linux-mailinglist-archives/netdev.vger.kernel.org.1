Return-Path: <netdev+bounces-184031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE8A92FA7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A4E1B61F34
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6372676FC;
	Fri, 18 Apr 2025 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JII0WQpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF572676E3;
	Fri, 18 Apr 2025 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941819; cv=none; b=s/6MiEHoQXBXCDQXPbNGbQZAJ/uP6g8OM1qfMlh/FeXr4OAa+z6/PjpPzC1fEHyzRq0aMXrFKZTIZWzE75BBMga7Z2i3tPyCIElqoAVZHJVGnWq/kdeb/wRXwM9mJZ3Zy1+o75TtnVMv30Z4gqyWMoIi1aFmtM3KgvYVBztWFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941819; c=relaxed/simple;
	bh=tgBKFs4mjjqy0jH1NKNLjstVRkJPGbEFPB7Uc+1VYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W442YQPhZANqtk5PbzfVyQq9BTa0DRazP356ur0+YeGYGyIg2+dp/SYQ3tEj03/s3YltVkq1Df8gJ6n/jl0jIOhWlLsRqfrZTD4dR8zc2gLpM0pPRzSYaRvvI4W5u1wekj1eiHtdPYy2aPu7/k6VybnI7toaFQoX9GJlCdzY2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JII0WQpz; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5e1b40f68so148332985a.1;
        Thu, 17 Apr 2025 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744941817; x=1745546617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh63/3O8DJ0AMhBHTeTn6n+OIaLKyrEbfZMtQSeGAQ8=;
        b=JII0WQpz2+t1A/tZ6++75xUC8kuEJ0fbqSQRyD+CiBEBHHWnFdUPN0ZmvapAz/Sweh
         aoppKw+RrJxcfZOBcMu8DfSkmAEZuqV4ZDjiAj+NTaHz6hV2RO+rHkNlgLcEkd6SktZQ
         3MmxNJImcOno4P2DYyyFVgPVmEtBQ/4m0B1EFbF9orimeIBsgtUEiHJXTvR74g2Um2hq
         7ZA7XuiBCPrVulVefVOB/1OEm1fnx2MJUxDG4SYWDxvqla8HifJex3fLv4VyL73Gc1KW
         5RXOpW0u4iu1oGVlTiv76xhZbs/QThWxEatVarAvGQ5U86MA8mehpQyb+zs6xPg/DPmL
         SMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744941817; x=1745546617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh63/3O8DJ0AMhBHTeTn6n+OIaLKyrEbfZMtQSeGAQ8=;
        b=BpxQouT4FUA8hUZOXdFAvwSKEyqzuwA8AwRdVwvRgea1SjAM6ftZHvFslVXuJ7begh
         I/sOdEYt6A/GUZCXYiH/Cl9LS4Iu331swHOaEm4GpMOO6WAXiXRSTILbLzIeErfX0Zyb
         RaX+Z3ji1sa6R5I0PvNMVg0ZEYF+m16LnmVEpDExpVYN6YNmZmMWdr3lOZ5XDSHkmftZ
         xb9yC4PrEL2YDWi5aM9OniA2Ng3ZvVOlB4leHeXgEz8GqVBrZM8SxuoXTBCWkkNFZsrv
         bXSWBFv8RBS5VbxG9zxIMq/8MNoqfjuGfi46QkFcs84mLXG8yqq6A3KYtr0OOX9tRSSL
         VgCg==
X-Forwarded-Encrypted: i=1; AJvYcCVrX6+bo+35Ux8xFXffwKfSquhjH06hv7bm63011aKoWESahiQqaJaLmdV/fFrkjpk/rgT131pe@vger.kernel.org, AJvYcCWezZynx9G4g1CtSa8TR0PPmGopttxa1KMiNXfW3uj9s4kcfS5tOE99+yXDUXgElynFsy+AmSVUbtlS0+1s@vger.kernel.org, AJvYcCXY2g/+jaVB8f9CWEGg2XdA68b224HfTSjp0xbuRpeHaqtyzzYXUAWQTLXYqOzH5mFMptTqO3ddPB39@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnlCsl5IgBfPfjDhNv4On5/6STXiGGaileBehSHQkOnNUykh+
	zdXvN+pSeywfgWZSTJ+WppELRvE1t+nzgHDuifvQYunUn0/zKmrl
X-Gm-Gg: ASbGncv1wN9pvwz6i4hur6M4cn6pbrExNv9hRYt0BqnlWAtioSg+EtlwSIrzbK4b0FA
	hyf5/KhymyVULZqfOFKkdEQBylg89baVTKE35D1KRifsm6ulDyZYa3CxPxQKfF7HcjZLePaXeN8
	XL2AxE5JeUKuSjlmdLi2zBUh3sET78s03MIPD4a5InTZeP4nl5kfrji8i7P6/UrMz35G8NCwG7K
	mX+1pDq07I4lw/oqfU1DTd19tB5i9UdY8txvR6XVFBpmL1k3sPKWZcJoM2M0gpbWdT7i1NQqe/b
	TcIzVtL+1MEp0c0e
X-Google-Smtp-Source: AGHT+IGt6cgriWdw1rXQhHBTfC5DxaFTz/L+44zx6+z+bVDbjk+lg9rrw0J84BJX1QCTaQhEwNnaKw==
X-Received: by 2002:a05:620a:4415:b0:7c5:6410:3a6 with SMTP id af79cd13be357-7c927fb6a1cmr194704285a.27.1744941816794;
        Thu, 17 Apr 2025 19:03:36 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925b75c8dsm55892185a.111.2025.04.17.19.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:03:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 2/5] soc: sophgo: sg2044: Add support for SG2044 TOP syscon device
Date: Fri, 18 Apr 2025 10:03:21 +0800
Message-ID: <20250418020325.421257-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>
References: <20250418020325.421257-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SG2044 TOP device provide PLL clock function in its area.
Add a mfd definition for it.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/soc/Kconfig                |  1 +
 drivers/soc/Makefile               |  1 +
 drivers/soc/sophgo/Kconfig         | 21 ++++++++++++++
 drivers/soc/sophgo/Makefile        |  3 ++
 drivers/soc/sophgo/sg2044-topsys.c | 45 ++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+)
 create mode 100644 drivers/soc/sophgo/Kconfig
 create mode 100644 drivers/soc/sophgo/Makefile
 create mode 100644 drivers/soc/sophgo/sg2044-topsys.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 6a8daeb8c4b9..11e2383c0654 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -23,6 +23,7 @@ source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
+source "drivers/soc/sophgo/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2037a8695cb2..0381a0abdec8 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -29,6 +29,7 @@ obj-y				+= qcom/
 obj-y				+= renesas/
 obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
+obj-y				+= sophgo/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
diff --git a/drivers/soc/sophgo/Kconfig b/drivers/soc/sophgo/Kconfig
new file mode 100644
index 000000000000..d97de4a41d5e
--- /dev/null
+++ b/drivers/soc/sophgo/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Sophgo SoC drivers
+#
+
+if ARCH_SOPHGO || COMPILE_TEST
+menu "Sophgo SoC drivers"
+
+config SOPHGO_SG2044_TOPSYS
+	tristate "Sophgo SG2044 TOP syscon driver"
+	select MFD_CORE
+	help
+	  This is the core driver for the Sophgo SG2044 TOP system
+	  controller device. This driver provide PLL clock device
+	  for the SoC.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sg2044-topsys.
+
+endmenu
+endif
diff --git a/drivers/soc/sophgo/Makefile b/drivers/soc/sophgo/Makefile
new file mode 100644
index 000000000000..171a2922d75b
--- /dev/null
+++ b/drivers/soc/sophgo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SOPHGO_SG2044_TOPSYS)	+= sg2044-topsys.o
diff --git a/drivers/soc/sophgo/sg2044-topsys.c b/drivers/soc/sophgo/sg2044-topsys.c
new file mode 100644
index 000000000000..179f2620b2a9
--- /dev/null
+++ b/drivers/soc/sophgo/sg2044-topsys.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sophgo SG2044 multi-function system controller driver
+ *
+ * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/resource.h>
+
+static const struct mfd_cell sg2044_topsys_subdev[] = {
+	{
+		.name = "sg2044-pll",
+	},
+};
+
+static int sg2044_topsys_probe(struct platform_device *pdev)
+{
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+				    sg2044_topsys_subdev,
+				    ARRAY_SIZE(sg2044_topsys_subdev),
+				    NULL, 0, NULL);
+}
+
+static const struct of_device_id sg2044_topsys_of_match[] = {
+	{ .compatible = "sophgo,sg2044-top-syscon" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sg2044_topsys_of_match);
+
+static struct platform_driver sg2044_topsys_driver = {
+	.probe = sg2044_topsys_probe,
+	.driver = {
+		.name = "sg2044-topsys",
+		.of_match_table = sg2044_topsys_of_match,
+	},
+};
+module_platform_driver(sg2044_topsys_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
+MODULE_DESCRIPTION("Sophgo SG2044 multi-function system controller driver");
+MODULE_LICENSE("GPL");
-- 
2.49.0


