Return-Path: <netdev+bounces-183384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB067A908A9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5404447C4A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3152135D1;
	Wed, 16 Apr 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duHGDwLd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADF2135BC
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820539; cv=none; b=uMeNxKTVKkf5/IKJzN6Yt260oYNSPpKCDsVJQfiR4nCx44YIiFRLLtQm+gLEXJSjZTccRW20+zP2pSWZdbXz32RNdWrwms9nlNBzYU5oGOtuTRR18cuZyyTgptKnMvZpx+gR1AjT2a+++KYoG0mCYn12UnU82+MkhBQfNmUU4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820539; c=relaxed/simple;
	bh=T55z9sc/d4/6bLn4CQV8/tIT2cm47S8kd9/1wjb6Ej0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DooeHh4fhZA8Chu1eVua3+s3KVu88+WFn75gJaRPnPgT/Vul5sOlluADYNREXmduqTCtAuSrI7otVX5w7CvpK6rMb7Rw2cfbX4qCeJn1P+L/AOdHiKfwuVufVHff/hKflQg/rBYgA+G+yR2jC4A9eSMWK8ErbYuknNREkDQ//5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duHGDwLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XxcqG/4fYZlHnCMo/LifOl8siUw/d7QSk0+ya0B1EY=;
	b=duHGDwLdvTmzNFJa7e+55lAeuqyXK7E7w8/zYWPcY1FT1pmTZ6lkwU7Tk4oW+g+0wDKFJY
	xvxGdG5n7WgOHf2IM8+cqPANt46z1P80L1CK5E+2hx68q0DqdU6DnbjPpeyzQ9zDICBujG
	xJYoKs+HzO9Kzi0oM+cWHA9l0+QDDEc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-H-lVoIc3PSetCr9wNUK0Cw-1; Wed,
 16 Apr 2025 12:22:09 -0400
X-MC-Unique: H-lVoIc3PSetCr9wNUK0Cw-1
X-Mimecast-MFC-AGG-ID: H-lVoIc3PSetCr9wNUK0Cw_1744820527
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 550541800981;
	Wed, 16 Apr 2025 16:22:07 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49332180094C;
	Wed, 16 Apr 2025 16:22:02 +0000 (UTC)
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
Subject: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Date: Wed, 16 Apr 2025 18:21:39 +0200
Message-ID: <20250416162144.670760-4-ivecera@redhat.com>
In-Reply-To: <20250416162144.670760-1-ivecera@redhat.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
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
driver (in the part 2) and by the PTP driver (will be added later).

The chip family is characterized by following properties:
* up to 5 separate DPLL units (channels)
* 5 synthesizers
* 10 input pins (references)
* 10 outputs
* 20 output pins (output pin pair shares one output)
* Each reference and output can act in differential or single-ended
  mode (reference or output in differential mode consumes 2 pins)
* Each output is connected to one of the synthesizers
* Each synthesizer is driven by one of the DPLL unit

The device uses 7-bit addresses and 8-bits for values. It exposes 8-, 16-,
32- and 48-bits registers in address range <0x000,0x77F>. Due to 7bit
addressing the range is organized into pages of size 128 and each page
contains page selector register (0x7F). To read/write multi-byte registers
the device supports bulk transfers.

There are 2 kinds of registers, simple ones that are present at register
pages 0..9 and mailbox ones that are present at register pages 10..14.

To access mailbox type registers a caller has to take mailbox_mutex that
ensures the reading and committing mailbox content is done atomically.
More information about it in later patch from the series.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2->v3:
* added chip_info with valid chip ids and num of DPLLs for compatibles
* regmap is using implicit locking
* mailbox registers requires extra mutex to be held
* added helpers to access registers
* report device firmware and config version using dev_dbg
* fixed regmap ranges
* enabled rbtree regcache for page selector

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
 MAINTAINERS                      |   9 ++
 drivers/mfd/Kconfig              |  30 +++++
 drivers/mfd/Makefile             |   5 +
 drivers/mfd/zl3073x-core.c       | 218 +++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c        |  68 ++++++++++
 drivers/mfd/zl3073x-spi.c        |  68 ++++++++++
 drivers/mfd/zl3073x.h            |  31 +++++
 include/linux/mfd/zl3073x.h      |  50 +++++++
 include/linux/mfd/zl3073x_regs.h | 105 +++++++++++++++
 9 files changed, 584 insertions(+)
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f645ef38d2224..cf050f59696e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15992,6 +15992,15 @@ L:	linux-wireless@vger.kernel.org
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
index 22b9363100394..7d7902ec1d89a 100644
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
+	  Say Y here if you want to build I2C support for the Microchip
+	  Azurite DPLL/PTP/SyncE chip family.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called zl3073x_i2c and you will also get zl3073x for
+	  the core module.
+
+config MFD_ZL3073X_SPI
+	tristate "Microchip Azurite DPLL/PTP/SyncE with SPI"
+	depends on SPI
+	select MFD_ZL3073X_CORE
+	select REGMAP_SPI
+	help
+	  Say Y here if you want to build SPI support for the Microchip
+	  Azurite DPLL/PTP/SyncE chip family.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called zl3073x_spi and you will also get zl3073x for
+	  the core module.
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
index 0000000000000..0455d6ae37da5
--- /dev/null
+++ b/drivers/mfd/zl3073x-core.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/mfd/zl3073x_regs.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "zl3073x.h"
+
+/* Chip IDs for zl30731 */
+static const u16 zl30731_ids[] = {
+	0x0E93,
+	0x1E93,
+	0x2E93,
+};
+
+/* Chip IDs for zl30732 */
+static const u16 zl30732_ids[] = {
+	0x0E30,
+	0x0E94,
+	0x1E94,
+	0x1F60,
+	0x2E94,
+	0x3FC4,
+};
+
+/* Chip IDs for zl30733 */
+static const u16 zl30733_ids[] = {
+	0x0E95,
+	0x1E95,
+	0x2E95,
+};
+
+/* Chip IDs for zl30734 */
+static const u16 zl30734_ids[] = {
+	0x0E96,
+	0x1E96,
+	0x2E96,
+};
+
+/* Chip IDs for zl30735 */
+static const u16 zl30735_ids[] = {
+	0x0E97,
+	0x1E97,
+	0x2E97,
+};
+
+const struct zl3073x_chip_info zl3073x_chip_info[] = {
+	[ZL30731] = {
+		.ids = zl30731_ids,
+		.num_ids = ARRAY_SIZE(zl30731_ids),
+		.num_channels = 1,
+	},
+	[ZL30732] = {
+		.ids = zl30732_ids,
+		.num_ids = ARRAY_SIZE(zl30732_ids),
+		.num_channels = 2,
+	},
+	[ZL30733] = {
+		.ids = zl30733_ids,
+		.num_ids = ARRAY_SIZE(zl30733_ids),
+		.num_channels = 3,
+	},
+	[ZL30734] = {
+		.ids = zl30734_ids,
+		.num_ids = ARRAY_SIZE(zl30734_ids),
+		.num_channels = 4,
+	},
+	[ZL30735] = {
+		.ids = zl30735_ids,
+		.num_ids = ARRAY_SIZE(zl30735_ids),
+		.num_channels = 5,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(zl3073x_chip_info, "ZL3073X");
+
+#define ZL_NUM_PAGES		15
+#define ZL_NUM_SIMPLE_PAGES	10
+#define ZL_PAGE_SEL		0x7F
+#define ZL_PAGE_SEL_MASK	GENMASK(3, 0)
+#define ZL_NUM_REGS		(ZL_NUM_PAGES * ZL_PAGE_SIZE)
+
+/* Regmap range configuration */
+static const struct regmap_range_cfg zl3073x_regmap_range = {
+	.range_min	= ZL_RANGE_OFF,
+	.range_max	= ZL_RANGE_OFF + ZL_NUM_REGS - 1,
+	.selector_reg	= ZL_PAGE_SEL,
+	.selector_mask	= ZL_PAGE_SEL_MASK,
+	.selector_shift	= 0,
+	.window_start	= 0,
+	.window_len	= ZL_PAGE_SIZE,
+};
+
+static bool
+zl3073x_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* Only page selector is non-volatile */
+	return (reg != ZL_PAGE_SEL);
+}
+
+static const struct regmap_config zl3073x_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= ZL_RANGE_OFF + ZL_NUM_REGS - 1,
+	.ranges		= &zl3073x_regmap_range,
+	.num_ranges	= 1,
+	.cache_type	= REGCACHE_RBTREE,
+	.volatile_reg	= zl3073x_is_volatile_reg,
+};
+
+/**
+ * zl3073x_devm_alloc - allocates zl3073x device structure
+ * @dev: pointer to device structure
+ *
+ * Allocates zl3073x device structure as device resource and initializes
+ * regmap_mutex.
+ *
+ * Return: pointer to zl3073x device on success, error pointer on error
+ */
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
+{
+	struct zl3073x_dev *zldev;
+	int rc;
+
+	zldev = devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+	if (!zldev)
+		return ERR_PTR(-ENOMEM);
+
+	zldev->dev = dev;
+
+	/* We have to initialize regmap mutex here because during
+	 * zl3073x_dev_probe() is too late as the regmaps are already
+	 * initialized.
+	 */
+	rc = devm_mutex_init(zldev->dev, &zldev->mailbox_lock);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc, "Failed to initialize mutex\n");
+		return ERR_PTR(rc);
+	}
+
+	return zldev;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
+
+/**
+ * zl3073x_dev_init_regmap_config - initialize regmap config
+ * @regmap_cfg: regmap_config structure to fill
+ *
+ * Initializes regmap config common for I2C and SPI.
+ */
+void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg)
+{
+	*regmap_cfg = zl3073x_regmap_config;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init_regmap_config, "ZL3073X");
+
+/**
+ * zl3073x_dev_probe - initialize zl3073x device
+ * @zldev: pointer to zl3073x device
+ * @chip_info: chip info based on compatible
+ *
+ * Common initialization of zl3073x device structure.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_dev_probe(struct zl3073x_dev *zldev,
+		      const struct zl3073x_chip_info *chip_info)
+{
+	u16 id, revision, fw_ver;
+	u32 cfg_ver;
+	int i, rc;
+
+	/* Read chip ID */
+	rc = zl3073x_read_id(zldev, &id);
+	if (rc)
+		return rc;
+
+	/* Check it matches */
+	for (i = 0; i < chip_info->num_ids; i++) {
+		if (id == chip_info->ids[i])
+			break;
+	}
+
+	if (i == chip_info->num_ids) {
+		dev_err(zldev->dev, "Unknown or non-match chip ID: 0x%0x\n", id);
+		return -ENODEV;
+	}
+
+	/* Read revision, firmware version and custom config version */
+	rc = zl3073x_read_revision(zldev, &revision);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_fw_ver(zldev, &fw_ver);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
+	if (rc)
+		return rc;
+
+	dev_dbg(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n", id,
+		revision, fw_ver);
+	dev_dbg(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
+		FIELD_GET(GENMASK(31, 24), cfg_ver),
+		FIELD_GET(GENMASK(23, 16), cfg_ver),
+		FIELD_GET(GENMASK(15, 8), cfg_ver),
+		FIELD_GET(GENMASK(7, 0), cfg_ver));
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_dev_probe, "ZL3073X");
+
+MODULE_AUTHOR("Ivan Vecera <ivecera@redhat.com>");
+MODULE_DESCRIPTION("Microchip ZL3073x core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/zl3073x-i2c.c b/drivers/mfd/zl3073x-i2c.c
new file mode 100644
index 0000000000000..76bc9a0463180
--- /dev/null
+++ b/drivers/mfd/zl3073x-i2c.c
@@ -0,0 +1,68 @@
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
+	struct regmap_config regmap_cfg;
+	struct device *dev = &client->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (IS_ERR(zldev))
+		return PTR_ERR(zldev);
+
+	i2c_set_clientdata(client, zldev);
+
+	zl3073x_dev_init_regmap_config(&regmap_cfg);
+
+	zldev->regmap = devm_regmap_init_i2c(client, &regmap_cfg);
+	if (IS_ERR(zldev->regmap)) {
+		dev_err_probe(dev, PTR_ERR(zldev->regmap),
+			      "Failed to initialize regmap\n");
+		return PTR_ERR(zldev->regmap);
+	}
+
+	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
+}
+
+static const struct i2c_device_id zl3073x_i2c_id[] = {
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731] },
+	{ "zl30732", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732] },
+	{ "zl30733", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733] },
+	{ "zl30734", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734] },
+	{ "zl30735", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735] },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);
+
+static const struct of_device_id zl3073x_i2c_of_match[] = {
+	{ .compatible = "microchip,zl30731", .data = &zl3073x_chip_info[ZL30731] },
+	{ .compatible = "microchip,zl30732", .data = &zl3073x_chip_info[ZL30732] },
+	{ .compatible = "microchip,zl30733", .data = &zl3073x_chip_info[ZL30733] },
+	{ .compatible = "microchip,zl30734", .data = &zl3073x_chip_info[ZL30734] },
+	{ .compatible = "microchip,zl30735", .data = &zl3073x_chip_info[ZL30735] },
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
index 0000000000000..d0fc2d2221c0d
--- /dev/null
+++ b/drivers/mfd/zl3073x-spi.c
@@ -0,0 +1,68 @@
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
+	struct regmap_config regmap_cfg;
+	struct device *dev = &spi->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (IS_ERR(zldev))
+		return PTR_ERR(zldev);
+
+	spi_set_drvdata(spi, zldev);
+
+	zl3073x_dev_init_regmap_config(&regmap_cfg);
+
+	zldev->regmap = devm_regmap_init_spi(spi, &regmap_cfg);
+	if (IS_ERR(zldev->regmap)) {
+		dev_err_probe(dev, PTR_ERR(zldev->regmap),
+			      "Failed to initialize regmap\n");
+		return PTR_ERR(zldev->regmap);
+	}
+
+	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
+}
+
+static const struct spi_device_id zl3073x_spi_id[] = {
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731] },
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732] },
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733] },
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734] },
+	{ "zl30731", .driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735] },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
+
+static const struct of_device_id zl3073x_spi_of_match[] = {
+	{ .compatible = "microchip,zl30731", .data = &zl3073x_chip_info[ZL30731] },
+	{ .compatible = "microchip,zl30732", .data = &zl3073x_chip_info[ZL30732] },
+	{ .compatible = "microchip,zl30733", .data = &zl3073x_chip_info[ZL30733] },
+	{ .compatible = "microchip,zl30734", .data = &zl3073x_chip_info[ZL30734] },
+	{ .compatible = "microchip,zl30735", .data = &zl3073x_chip_info[ZL30735] },
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
index 0000000000000..3a2fea61cf579
--- /dev/null
+++ b/drivers/mfd/zl3073x.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ZL3073X_CORE_H
+#define __ZL3073X_CORE_H
+
+struct device;
+struct regmap_config;
+struct zl3073x_dev;
+
+enum zl3073x_chip_type {
+	ZL30731,
+	ZL30732,
+	ZL30733,
+	ZL30734,
+	ZL30735,
+};
+
+struct zl3073x_chip_info {
+	const u16	*ids;
+	size_t		num_ids;
+	int		num_channels;
+};
+
+extern const struct zl3073x_chip_info zl3073x_chip_info[];
+
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
+void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg);
+int zl3073x_dev_probe(struct zl3073x_dev *zldev,
+		      const struct zl3073x_chip_info *chip_info);
+
+#endif /* __ZL3073X_CORE_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
new file mode 100644
index 0000000000000..b68481dcf77a5
--- /dev/null
+++ b/include/linux/mfd/zl3073x.h
@@ -0,0 +1,50 @@
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
+ * @regmap: regmap to access device registers
+ * @mailbox_lock: mutex protecting an access to mailbox registers
+ */
+struct zl3073x_dev {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct mutex		mailbox_lock;
+};
+
+/**
+ * zl3073x_mailbox_lock - Lock the device mailbox registers
+ * @zldev: zl3073x device pointer
+ *
+ * Caller has to held this lock when it needs to access device mailbox
+ * registers.
+ */
+static inline void zl3073x_mailbox_lock(struct zl3073x_dev *zldev)
+{
+	mutex_lock(&zldev->mailbox_lock);
+}
+
+/**
+ * zl3073x_mailbox_unlock - Unlock the device mailbox registers
+ * @zldev: zl3073x device pointer
+ *
+ * Caller has to unlock this lock when it finishes accessing device mailbox
+ * registers.
+ */
+static inline void zl3073x_mailbox_unlock(struct zl3073x_dev *zldev)
+{
+	mutex_unlock(&zldev->mailbox_lock);
+}
+
+DEFINE_GUARD(zl3073x_mailbox, struct zl3073x_dev *, zl3073x_mailbox_lock(_T),
+	     zl3073x_mailbox_unlock(_T));
+
+#endif /* __LINUX_MFD_ZL3073X_H */
diff --git a/include/linux/mfd/zl3073x_regs.h b/include/linux/mfd/zl3073x_regs.h
new file mode 100644
index 0000000000000..453a5da8ac63f
--- /dev/null
+++ b/include/linux/mfd/zl3073x_regs.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_MFD_ZL3073X_REGS_H
+#define __LINUX_MFD_ZL3073X_REGS_H
+
+#include <asm/byteorder.h>
+#include <linux/lockdep.h>
+#include <linux/mfd/zl3073x.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+/* Registers are mapped at offset 0x100 */
+#define ZL_RANGE_OFF	       0x100
+#define ZL_PAGE_SIZE	       0x80
+#define ZL_REG_ADDR(_pg, _off) (ZL_RANGE_OFF + (_pg) * ZL_PAGE_SIZE + (_off))
+
+/**************************
+ * Register Page 0, General
+ **************************/
+
+/*
+ * Register 'id'
+ * Page: 0, Offset: 0x01, Size: 16 bits
+ */
+#define ZL_REG_ID ZL_REG_ADDR(0, 0x01)
+
+static inline __maybe_unused int
+zl3073x_read_id(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_ID, &temp, sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'revision'
+ * Page: 0, Offset: 0x03, Size: 16 bits
+ */
+#define ZL_REG_REVISION ZL_REG_ADDR(0, 0x03)
+
+static inline __maybe_unused int
+zl3073x_read_revision(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_REVISION, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'fw_ver'
+ * Page: 0, Offset: 0x05, Size: 16 bits
+ */
+#define ZL_REG_FW_VER ZL_REG_ADDR(0, 0x05)
+
+static inline __maybe_unused int
+zl3073x_read_fw_ver(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_FW_VER, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'custom_config_ver'
+ * Page: 0, Offset: 0x07, Size: 32 bits
+ */
+#define ZL_REG_CUSTOM_CONFIG_VER ZL_REG_ADDR(0, 0x07)
+
+static inline __maybe_unused int
+zl3073x_read_custom_config_ver(struct zl3073x_dev *zldev, u32 *value)
+{
+	__be32 temp;
+	int rc;
+
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_CUSTOM_CONFIG_VER, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be32_to_cpu(temp);
+	return rc;
+}
+
+#endif /* __LINUX_MFD_ZL3073X_REGS_H */
-- 
2.48.1


