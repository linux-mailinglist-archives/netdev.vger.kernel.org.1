Return-Path: <netdev+bounces-180799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2516A8289C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B031709C6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCF26869D;
	Wed,  9 Apr 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKdyzXNO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8562267F77
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209802; cv=none; b=kSwHNjGvSANVBOlFROHggb4pUxtpZZPi05aG+AjbMmHs//SfntJIksRlp3iwTK/+Ic5NAAz50v7ua2ZyU6Md2qZKKg5C97qQD0GPc9q7TrerfMElMt02fPHIBiyVggXcikkeciXHEUQecrVyJ52lnspy4nc2V2IkrBBe5Br6igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209802; c=relaxed/simple;
	bh=eb/GjR0cCgVPzsLiu0oRo074oGDwBaVvbW/KIehKOhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCdRS3qjzAINbOh+jidRHKqsWTXi+PuFUvG6xXOwlbtcABktkZaq3oubG2eDBvK7APkRgpkQqJhlmp8ThabW5U3hrGjLlBDT2Z8cN2JVJ6Kz8llKMpb1V2uPrRonlajFb2B78l/pa+Fv0jC62yHeL78WBJrv+6kKI+VOg3BmGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKdyzXNO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl+RdYplTTH5ZOj64MJV3ghsQC5eKx3POMcKx6ssQvg=;
	b=PKdyzXNO7IjP8v2lL3Mphv8n2LaWZ1r2wOFW7Y0BJ/DS1km6ZK0h7Tj2BPYioVTw6/ikaO
	hj1eOkef2EaaVR3DyB5y8/akP2hrGLCsfqoRPbQUWDi62HlN4IiZxNxPbso8jxlRJEREit
	cDbDXTAwdHP9qguva9Ew9OPgxJGIzXE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-bMw7kZfOM0e41u9ivgpKzA-1; Wed,
 09 Apr 2025 10:43:14 -0400
X-MC-Unique: bMw7kZfOM0e41u9ivgpKzA-1
X-Mimecast-MFC-AGG-ID: bMw7kZfOM0e41u9ivgpKzA_1744209792
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 009711955DCF;
	Wed,  9 Apr 2025 14:43:12 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE5151801766;
	Wed,  9 Apr 2025 14:43:07 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 03/14] mfd: Add Microchip ZL3073x support
Date: Wed,  9 Apr 2025 16:42:39 +0200
Message-ID: <20250409144250.206590-4-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add base MFD driver for Microchip Azurite ZL3073x chip family.
These chips provide DPLL and PHC (PTP) functionality and they can
be connected over I2C or SPI bus.

The MFD driver provide basic communication and synchronization
over the bus and common functionality that are used by the DPLL
driver (later in this series) and by the PTP driver (will be
added later).

The chip family is characterized by following properties:
* 2 separate DPLL units (channels)
* 5 synthesizers
* 10 input pins (references)
* 10 outputs
* 20 output pins (output pin pair shares one output)
* Each reference and output can act in differential or single-ended
  mode (reference or output in differential mode consumes 2 pins)
* Each output is connected to one of the synthesizers
* Each synthesizer is driven by one of the DPLL unit

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
v1->v2:
* fixed header issues
* removed usage of of_match_ptr
* added check for devm_mutex_init
* removed commas after sentinels
* removed variable initialization in zl3073x_i2c_probe()
* moved device tables closer to their users
* renamed zl3073x_dev_alloc() to zl3073x_devm_alloc()
* removed empty zl3073x_dev_exit()
* spidev renamed to spi
* squashed together with device DT bindings
* used dev_err_probe() instead of dev_err() during probe
* added some function documentation
DT bindings:
* spliced to separate files for i2c and spi
* fixed property order in DT bindings' examples
* added description
---
 MAINTAINERS                 |   9 ++++
 drivers/mfd/Kconfig         |  30 +++++++++++
 drivers/mfd/Makefile        |   5 ++
 drivers/mfd/zl3073x-core.c  | 101 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c   |  58 +++++++++++++++++++++
 drivers/mfd/zl3073x-spi.c   |  58 +++++++++++++++++++++
 drivers/mfd/zl3073x.h       |  14 +++++
 include/linux/mfd/zl3073x.h |  23 ++++++++
 8 files changed, 298 insertions(+)
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0742a10e87c88..5c086e945b148 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15996,6 +15996,15 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/
 
+MICROCHIP ZL3073X DRIVER
+M:	Ivan Vecera <ivecera@redhat.com>
+M:	Prathosh Satish <Prathosh.Satish@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/dpll/microchip,zl3073x*.yaml
+F:	drivers/mfd/zl3073x*
+F:	include/linux/mfd/zl3073x.h
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	UNGLinuxDriver@microchip.com
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b9363100394..30b36e3ee8f7f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2422,5 +2422,35 @@ config MFD_UPBOARD_FPGA
 	  To compile this driver as a module, choose M here: the module will be
 	  called upboard-fpga.
 
+config MFD_ZL3073X_CORE
+	tristate
+	select MFD_CORE
+
+config MFD_ZL3073X_I2C
+	tristate "Microchip Azurite DPLL/PTP/SyncE with I2C"
+	depends on I2C
+	select MFD_ZL3073X_CORE
+	select REGMAP_I2C
+	help
+	  Support for Microchip Azurite DPLL/PTP/SyncE chip family. This option
+	  supports I2C as the control interface.
+
+	  This driver provides common support for accessing the device.
+	  Additional drivers must be enabled in order to use the functionality
+	  of the device.
+
+config MFD_ZL3073X_SPI
+	tristate "Microchip Azurite DPLL/PTP/SyncE with SPI"
+	depends on SPI
+	select MFD_ZL3073X_CORE
+	select REGMAP_SPI
+	help
+	  Support for Microchip Azurite DPLL/PTP/SyncE chip family. This option
+	  supports SPI as the control interface.
+
+	  This driver provides common support for accessing the device.
+	  Additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42a18b..76e2babc1538f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -290,3 +290,8 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
 
 obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
+
+zl3073x-y			:= zl3073x-core.o
+obj-$(CONFIG_MFD_ZL3073X_CORE)	+= zl3073x.o
+obj-$(CONFIG_MFD_ZL3073X_I2C)	+= zl3073x-i2c.o
+obj-$(CONFIG_MFD_ZL3073X_SPI)	+= zl3073x-spi.o
diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
new file mode 100644
index 0000000000000..ccb6987d04a20
--- /dev/null
+++ b/drivers/mfd/zl3073x-core.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "zl3073x.h"
+
+/*
+ * Regmap ranges
+ */
+#define ZL3073x_PAGE_SIZE	128
+#define ZL3073x_NUM_PAGES	16
+#define ZL3073x_PAGE_SEL	0x7F
+
+/*
+ * Regmap range configuration
+ *
+ * The device uses 7-bit addressing and has 16 register pages with
+ * range 0x00-0x7f. The register 0x7f in each page acts as page
+ * selector where bits 0-3 contains currently selected page.
+ */
+static const struct regmap_range_cfg zl3073x_regmap_ranges[] = {
+	{
+		.range_min	= 0,
+		.range_max	= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
+		.selector_reg	= ZL3073x_PAGE_SEL,
+		.selector_mask	= GENMASK(3, 0),
+		.selector_shift	= 0,
+		.window_start	= 0,
+		.window_len	= ZL3073x_PAGE_SIZE,
+	},
+};
+
+/*
+ * Regmap config
+ */
+const struct regmap_config zl3073x_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.max_register		= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
+	.ranges			= zl3073x_regmap_ranges,
+	.num_ranges		= ARRAY_SIZE(zl3073x_regmap_ranges),
+};
+
+/**
+ * zl3073x_get_regmap_config - return pointer to regmap config
+ *
+ * Return: pointer to regmap config
+ */
+const struct regmap_config *zl3073x_get_regmap_config(void)
+{
+	return &zl3073x_regmap_config;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
+
+/**
+ * zl3073x_devm_alloc - allocates zl3073x device structure
+ * @dev: pointer to device structure
+ *
+ * Allocates zl3073x device structure as device resource.
+ *
+ * Return: pointer to zl3073x device structure
+ */
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
+{
+	struct zl3073x_dev *zldev;
+
+	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
+
+/**
+ * zl3073x_dev_init - initialize zl3073x device
+ * @zldev: pointer to zl3073x device
+ *
+ * Common initialization of zl3073x device structure.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_dev_init(struct zl3073x_dev *zldev)
+{
+	int rc;
+
+	rc = devm_mutex_init(zldev->dev, &zldev->lock);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc, "Failed to initialize mutex\n");
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x-i2c.c b/drivers/mfd/zl3073x-i2c.c
new file mode 100644
index 0000000000000..461b583e536b7
--- /dev/null
+++ b/drivers/mfd/zl3073x-i2c.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "zl3073x.h"
+
+static int zl3073x_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (!zldev)
+		return -ENOMEM;
+
+	zldev->dev = dev;
+	zldev->regmap = devm_regmap_init_i2c(client, zl3073x_get_regmap_config());
+	if (IS_ERR(zldev->regmap)) {
+		dev_err_probe(dev, PTR_ERR(zldev->regmap),
+			      "Failed to initialize register map\n");
+		return PTR_ERR(zldev->regmap);
+	}
+
+	i2c_set_clientdata(client, zldev);
+
+	return zl3073x_dev_init(zldev);
+}
+
+static const struct i2c_device_id zl3073x_i2c_id[] = {
+	{ "zl3073x-i2c" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);
+
+static const struct of_device_id zl3073x_i2c_of_match[] = {
+	{ .compatible = "microchip,zl3073x-i2c" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zl3073x_i2c_of_match);
+
+static struct i2c_driver zl3073x_i2c_driver = {
+	.driver = {
+		.name = "zl3073x-i2c",
+		.of_match_table = zl3073x_i2c_of_match,
+	},
+	.probe = zl3073x_i2c_probe,
+	.id_table = zl3073x_i2c_id,
+};
+module_i2c_driver(zl3073x_i2c_driver);
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x I2C driver");
+MODULE_IMPORT_NS("ZL3073X");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x-spi.c b/drivers/mfd/zl3073x-spi.c
new file mode 100644
index 0000000000000..db976aef74917
--- /dev/null
+++ b/drivers/mfd/zl3073x-spi.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include "zl3073x.h"
+
+static int zl3073x_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (!zldev)
+		return -ENOMEM;
+
+	zldev->dev = dev;
+	zldev->regmap = devm_regmap_init_spi(spi, zl3073x_get_regmap_config());
+	if (IS_ERR(zldev->regmap)) {
+		dev_err_probe(dev, PTR_ERR(zldev->regmap),
+			      "Failed to initialize register map\n");
+		return PTR_ERR(zldev->regmap);
+	}
+
+	spi_set_drvdata(spi, zldev);
+
+	return zl3073x_dev_init(zldev);
+}
+
+static const struct spi_device_id zl3073x_spi_id[] = {
+	{ "zl3073x-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
+
+static const struct of_device_id zl3073x_spi_of_match[] = {
+	{ .compatible = "microchip,zl3073x-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
+
+static struct spi_driver zl3073x_spi_driver = {
+	.driver = {
+		.name = "zl3073x-spi",
+		.of_match_table = zl3073x_spi_of_match,
+	},
+	.probe = zl3073x_spi_probe,
+	.id_table = zl3073x_spi_id,
+};
+module_spi_driver(zl3073x_spi_driver);
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x SPI driver");
+MODULE_IMPORT_NS("ZL3073X");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x.h b/drivers/mfd/zl3073x.h
new file mode 100644
index 0000000000000..8e8ffa961e4ca
--- /dev/null
+++ b/drivers/mfd/zl3073x.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ZL3073X_CORE_H
+#define __ZL3073X_CORE_H
+
+struct device;
+struct regmap_config;
+struct zl3073x_dev;
+
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
+int zl3073x_dev_init(struct zl3073x_dev *zldev);
+const struct regmap_config *zl3073x_get_regmap_config(void);
+
+#endif /* __ZL3073X_CORE_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
new file mode 100644
index 0000000000000..f3f33ef8bfa18
--- /dev/null
+++ b/include/linux/mfd/zl3073x.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_MFD_ZL3073X_H
+#define __LINUX_MFD_ZL3073X_H
+
+#include <linux/mutex.h>
+
+struct device;
+struct regmap;
+
+/**
+ * struct zl3073x_dev - zl3073x device
+ * @dev: pointer to device
+ * @regmap: regmap to access HW registers
+ * @lock: lock to be held during access to HW registers
+ */
+struct zl3073x_dev {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct mutex		lock;
+};
+
+#endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1


