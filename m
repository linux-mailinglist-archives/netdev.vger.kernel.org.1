Return-Path: <netdev+bounces-181994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8483A87486
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FB416ECB1
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E71F30BB;
	Sun, 13 Apr 2025 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Gf6MVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBD1E5215;
	Sun, 13 Apr 2025 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584343; cv=none; b=YwXlB/uc7bxrJurTc+JuNl7ClbwiHrk4Kwvr8iQyounu4IOPyH2k+JQOIf0ocDISXjpXNQaqwyvNbCYK04shmS+U8v0pryfIB8qWJYS+bUXcVf8+GmEyoMQk33jCdU2Yc2dfdqQyxuC7FLGxoi0G/bDswCoZ4Efs1j8U2Ls8mlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584343; c=relaxed/simple;
	bh=tgBKFs4mjjqy0jH1NKNLjstVRkJPGbEFPB7Uc+1VYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9r0PqG92OVcOymP8TO8OPmm3w2mi6C14CYJBh4a1SL/d3G1zz4lGWIDmpV+WGObqQ8ytPTg0nBCLopSfUhIE53wRa84Tb7MK+J3t8RlHS37ajUh6nkkZzWyZ/PdVsQIvgkebQjnm3agTrnPPjU5Y3cwBDGJ7Ry5m7JUcNe0HF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Gf6MVe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c7913bab2cso373432585a.0;
        Sun, 13 Apr 2025 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744584340; x=1745189140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh63/3O8DJ0AMhBHTeTn6n+OIaLKyrEbfZMtQSeGAQ8=;
        b=A4Gf6MVe2p9erDqsLp1Yut2uPgpU5m96WwOAf1OkCcbgzQFJkdu5XMH1OjHe1s475N
         NrfHuB9CQpXhfrjAzj0Ye1Bgi3BtChHWgRefLaDr8lbD4z5vt3BXLmeF9LJLOaAaN065
         ZbYetD55/UsZY6LwlE5/1mwswlTUd3ibWHvP9I+4kcM5clD24cNXJeK4dsXFA+qwb+hZ
         B93uswVUrQgBm6xUazIeneD09ZVnZqGTHUjvd7cdvc586ruzYWrG0Vp/onC964M9aAcJ
         gpYPeWPD1Ax2XYvarDoHdT7f4dWCWgW8kbjr0cl7d/2FCKkQ0+G7LgvfzfMDcV0xGGPF
         bHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584340; x=1745189140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh63/3O8DJ0AMhBHTeTn6n+OIaLKyrEbfZMtQSeGAQ8=;
        b=L4rgJ+Vs+PfPG3TYGuXqqq1PYcTXGXjavq8tcP2QhgYU4LaZjbfnogV1NMwS8rui0m
         8O9FqrIlWqIKDv1ZORN4ebe8UDmF3KfhJw6isvT/EpsrJcAYduqbcYofcOj/V9g7kme0
         2fO0V6lM+o4GqJUiRc63M1GbMWFCh+jgzf1IqpKaUpPuWF44D9tldlR3VwrBVkphLBjn
         JWKB+wb7T/WT8jo1PoKNByiIS00Emih95I5oO1BL2YnuqJy8du99tNk2/TQ/QaoIkhLd
         NLLiAe7mc0/L2hLi0Pku5oZY7veJuWJIjrCnQlEbdRlIw+HhWt3+4M/eqa8eJW/XlDl1
         H4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtnWv3DwV28muA+5sCCxn7QFdmpmLNK+Ul46yYw8jO4t2ejvn5WW8N6rvfgyzeaLW3j4z08OovtjGC@vger.kernel.org, AJvYcCUwn2GuWpKZG3ICG8WTK0riziElCmsgcvVPOFlflNxI4VyCjXrIdKUedLw4H8W3/C7Zw7pB7XCw@vger.kernel.org, AJvYcCXvjS1C5CcgrLsJbh4YoL+TdFCM4hMEuWkLXWNPAcHuhZPc22qdk4wgRP8JzGrXqcem8r7MOZDlHJ5IprYq@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUZqh9Dzz6rjV5JSvFvHncBBnyuyHmYDUWqkZuSOxGsTI183p
	zwUdEClrZlWIVJYZyhnKbIpSuCS4s0Geuxs+pzrgvlkelISgYVQi
X-Gm-Gg: ASbGncvmHOYxHeobe4SeCCmGatP6lzeAfr/k4Q+YWx6c7JrKZe5Y/P4RaMJs/dqyRUV
	gAfESbCTXtpc3dnJEBgCDScPlOMAq30dW5s06bmJv+BUsuRoOntd8xkg1cLG3qQqpgOhCUm7Lb4
	6uA5HMtEfHIfE+i6tYe18x0hn+eOkXxVB3Fp8LWVloN8r6Bq91UsCSKTNS2DebSyQZiWjYKdWtD
	35OZzxPJeqWyhtv+fNkMgOS6KCYod+ja/PVF5FBjJ5cL8kSalKlTxCF7KDpofLJv6koQoGdoO5+
	jhvFcwlQgjuHaR4i0W5mKYUDUGo=
X-Google-Smtp-Source: AGHT+IGPkOq+aW1xOSstUBVfkd7f5veHxmYuq86JO/7QxDtXjPe2HsusNOEdc8ZIbqHJ6p7GgaZyWg==
X-Received: by 2002:a05:620a:454f:b0:7c5:b90a:54a6 with SMTP id af79cd13be357-7c7af12e786mr1719995785a.13.1744584340354;
        Sun, 13 Apr 2025 15:45:40 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7b7d914b6sm298036385a.59.2025.04.13.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 15:45:40 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 2/5] soc: sophgo: sg2044: Add support for SG2044 TOP syscon device
Date: Mon, 14 Apr 2025 06:44:46 +0800
Message-ID: <20250413224450.67244-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413224450.67244-1-inochiama@gmail.com>
References: <20250413224450.67244-1-inochiama@gmail.com>
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


