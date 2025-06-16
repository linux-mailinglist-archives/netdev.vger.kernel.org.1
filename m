Return-Path: <netdev+bounces-198221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D74BADBAB4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8903D3B67AC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571F289E3C;
	Mon, 16 Jun 2025 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSdpUGkJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD69289E2B
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104887; cv=none; b=blQJwukDHdRdeE55GIHeKPLkKL9R/ZWGeMwrqED0OlgzuMuppzKlNv+mQ1255nWoti3tijXJ7QFwTNeYwlIZo2vRhejJZi7AD6q6ILxytwm11tfv6phUIBQbfVmlkPJSMZk0/xObcfM0bcG7CeLZBx28mDW9stw+CMsCjTSCojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104887; c=relaxed/simple;
	bh=0wjbF2cHKB/+wEv2qRk84wH5/cjQgG3yfvtIkZoW1/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCHohWtLNKNvpHM06stemhV8U4CvTQZcvTbeswmf26pSJEGhkHI8Z4x9Fu5s5EcZbeOTpSBWOn0P8yi2ZL0ZpUWdWx9CY1BOZGqiAN8fDDitN9kcklDFTkdn9p5I8isLrsfO1enaPnWmv5IGSMD51OBwduKKZdd9M/5bocMNtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSdpUGkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750104883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bg0C6asPJ9i+3Won723rnqBSU17v7kBOFpnWvMchk3w=;
	b=eSdpUGkJnRyhPRVhpp/+4A1iIEF87r10EYLqQ6HokTZzyUOdmujhPdCjA7aNzVhjuR0ARM
	XofQmNJwkGZ9p3UP9il/BPV4uir3Ml8++rE+8Q4H4WLrU8w9gjZPd1QLFEsvz/g56MheeD
	XDsr7dhWPCEyvWzzwClEgnzxEfYl1L8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-awqBxb9GP_iddCMKWY4Rkw-1; Mon,
 16 Jun 2025 16:14:40 -0400
X-MC-Unique: awqBxb9GP_iddCMKWY4Rkw-1
X-Mimecast-MFC-AGG-ID: awqBxb9GP_iddCMKWY4Rkw_1750104877
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF6241800281;
	Mon, 16 Jun 2025 20:14:37 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 683F630044D8;
	Mon, 16 Jun 2025 20:14:30 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v11 03/14] dpll: Add basic Microchip ZL3073x support
Date: Mon, 16 Jun 2025 22:13:53 +0200
Message-ID: <20250616201404.1412341-4-ivecera@redhat.com>
In-Reply-To: <20250616201404.1412341-1-ivecera@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Microchip Azurite ZL3073x represents chip family providing DPLL
and optionally PHC (PTP) functionality. The chips can be connected
be connected over I2C or SPI bus.

They have the following characteristics:
* up to 5 separate DPLL units (channels)
* 5 synthesizers
* 10 input pins (references)
* 10 outputs
* 20 output pins (output pin pair shares one output)
* Each reference and output can operate in either differential or
  single-ended mode (differential mode uses 2 pins)
* Each output is connected to one of the synthesizers
* Each synthesizer is driven by one of the DPLL unit

The device uses 7-bit addresses and 8-bits values. It exposes 8-, 16-,
32- and 48-bits registers in address range <0x000,0x77F>. Due to 7bit
addressing, the range is organized into pages of 128 bytes, with each
page containing a page selector register at address 0x7F.
For reading/writing multi-byte registers, the device supports bulk
transfers.

Add basic functionality to access device registers and probe
functionality for both I2C and SPI cases.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 MAINTAINERS                   |   8 +
 drivers/Kconfig               |   4 +-
 drivers/dpll/Kconfig          |   6 +
 drivers/dpll/Makefile         |   2 +
 drivers/dpll/zl3073x/Kconfig  |  34 +++
 drivers/dpll/zl3073x/Makefile |  10 +
 drivers/dpll/zl3073x/core.c   | 452 ++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.h   |  56 +++++
 drivers/dpll/zl3073x/i2c.c    |  93 +++++++
 drivers/dpll/zl3073x/regs.h   |  75 ++++++
 drivers/dpll/zl3073x/spi.c    |  93 +++++++
 11 files changed, 831 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/Kconfig
 create mode 100644 drivers/dpll/zl3073x/Makefile
 create mode 100644 drivers/dpll/zl3073x/core.c
 create mode 100644 drivers/dpll/zl3073x/core.h
 create mode 100644 drivers/dpll/zl3073x/i2c.c
 create mode 100644 drivers/dpll/zl3073x/regs.h
 create mode 100644 drivers/dpll/zl3073x/spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b90ac03f39d..f3cdfa79b79ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16465,6 +16465,14 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/microchip/
 
+MICROCHIP ZL3073X DRIVER
+M:	Ivan Vecera <ivecera@redhat.com>
+M:	Prathosh Satish <Prathosh.Satish@microchip.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+F:	drivers/dpll/zl3073x/
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	UNGLinuxDriver@microchip.com
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7c556c5ac4fdd..3d8c902c25610 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -77,6 +77,8 @@ source "drivers/pps/Kconfig"
 
 source "drivers/ptp/Kconfig"
 
+source "drivers/dpll/Kconfig"
+
 source "drivers/pinctrl/Kconfig"
 
 source "drivers/gpio/Kconfig"
@@ -245,6 +247,4 @@ source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
 
-source "drivers/dpll/Kconfig"
-
 endmenu
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index 20607ed542435..ade872c915ac6 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -3,5 +3,11 @@
 # Generic DPLL drivers configuration
 #
 
+menu "DPLL device support"
+
 config DPLL
 	bool
+
+source "drivers/dpll/zl3073x/Kconfig"
+
+endmenu
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
index 2e5b278501105..9e7a3a3e592e8 100644
--- a/drivers/dpll/Makefile
+++ b/drivers/dpll/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_DPLL)      += dpll.o
 dpll-y                  += dpll_core.o
 dpll-y                  += dpll_netlink.o
 dpll-y                  += dpll_nl.o
+
+obj-$(CONFIG_ZL3073X)	+= zl3073x/
diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
new file mode 100644
index 0000000000000..217160df0f49a
--- /dev/null
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config ZL3073X
+	tristate "Microchip Azurite DPLL/PTP/SyncE devices"
+	select DPLL
+	help
+	  This driver supports Microchip Azurite DPLL/PTP/SyncE devices.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called zl3073x.
+
+config ZL3073X_I2C
+	tristate "I2C bus implementation for Microchip Azurite devices"
+	depends on I2C && ZL3073X
+	select REGMAP_I2C
+	default m
+	help
+	  This is I2C bus implementation for Microchip Azurite DPLL/PTP/SyncE
+	  devices.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called zl3073x_i2c.
+
+config ZL3073X_SPI
+	tristate "SPI bus implementation for Microchip Azurite devices"
+	depends on SPI && ZL3073X
+	select REGMAP_SPI
+	default m
+	help
+	  This is SPI bus implementation for Microchip Azurite DPLL/PTP/SyncE
+	  devices.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called zl3073x_spi.
diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
new file mode 100644
index 0000000000000..8760f358f5447
--- /dev/null
+++ b/drivers/dpll/zl3073x/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_ZL3073X)		+= zl3073x.o
+zl3073x-objs			:= core.o
+
+obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
+zl3073x_i2c-objs		:= i2c.o
+
+obj-$(CONFIG_ZL3073X_SPI)	+= zl3073x_spi.o
+zl3073x_spi-objs		:= spi.o
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
new file mode 100644
index 0000000000000..5af053d3e199d
--- /dev/null
+++ b/drivers/dpll/zl3073x/core.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/unaligned.h>
+
+#include "core.h"
+#include "regs.h"
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
+#define ZL_RANGE_OFFSET		0x80
+#define ZL_PAGE_SIZE		0x80
+#define ZL_NUM_PAGES		15
+#define ZL_PAGE_SEL		0x7F
+#define ZL_PAGE_SEL_MASK	GENMASK(3, 0)
+#define ZL_NUM_REGS		(ZL_NUM_PAGES * ZL_PAGE_SIZE)
+
+/* Regmap range configuration */
+static const struct regmap_range_cfg zl3073x_regmap_range = {
+	.range_min	= ZL_RANGE_OFFSET,
+	.range_max	= ZL_RANGE_OFFSET + ZL_NUM_REGS - 1,
+	.selector_reg	= ZL_PAGE_SEL,
+	.selector_mask	= ZL_PAGE_SEL_MASK,
+	.selector_shift	= 0,
+	.window_start	= 0,
+	.window_len	= ZL_PAGE_SIZE,
+};
+
+static bool
+zl3073x_is_volatile_reg(struct device *dev __maybe_unused, unsigned int reg)
+{
+	/* Only page selector is non-volatile */
+	return reg != ZL_PAGE_SEL;
+}
+
+const struct regmap_config zl3073x_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= ZL_RANGE_OFFSET + ZL_NUM_REGS - 1,
+	.ranges		= &zl3073x_regmap_range,
+	.num_ranges	= 1,
+	.cache_type	= REGCACHE_MAPLE,
+	.volatile_reg	= zl3073x_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS_GPL(zl3073x_regmap_config, "ZL3073X");
+
+static bool
+zl3073x_check_reg(struct zl3073x_dev *zldev, unsigned int reg, size_t size)
+{
+	/* Check the index is in valid range for indexed register */
+	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
+		dev_err(zldev->dev, "Index out of range for reg 0x%04lx\n",
+			ZL_REG_ADDR(reg));
+		return false;
+	}
+	/* Check the requested size corresponds to register size */
+	if (ZL_REG_SIZE(reg) != size) {
+		dev_err(zldev->dev, "Invalid size %zu for reg 0x%04lx\n",
+			size, ZL_REG_ADDR(reg));
+		return false;
+	}
+
+	return true;
+}
+
+static int
+zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg, void *val,
+		 size_t size)
+{
+	int rc;
+
+	if (!zl3073x_check_reg(zldev, reg, size))
+		return -EINVAL;
+
+	/* Map the register address to virtual range */
+	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
+
+	rc = regmap_bulk_read(zldev->regmap, reg, val, size);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to read reg 0x%04x: %pe\n", reg,
+			ERR_PTR(rc));
+		return rc;
+	}
+
+	return 0;
+}
+
+static int
+zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg, const void *val,
+		  size_t size)
+{
+	int rc;
+
+	if (!zl3073x_check_reg(zldev, reg, size))
+		return -EINVAL;
+
+	/* Map the register address to virtual range */
+	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
+
+	rc = regmap_bulk_write(zldev->regmap, reg, val, size);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to write reg 0x%04x: %pe\n", reg,
+			ERR_PTR(rc));
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_read_u8 - read value from 8bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Reads value from given 8bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val)
+{
+	return zl3073x_read_reg(zldev, reg, val, sizeof(*val));
+}
+
+/**
+ * zl3073x_write_u8 - write value to 16bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Writes value into given 8bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_write_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 val)
+{
+	return zl3073x_write_reg(zldev, reg, &val, sizeof(val));
+}
+
+/**
+ * zl3073x_read_u16 - read value from 16bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Reads value from given 16bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val)
+{
+	int rc;
+
+	rc = zl3073x_read_reg(zldev, reg, val, sizeof(*val));
+	if (!rc)
+		be16_to_cpus(val);
+
+	return rc;
+}
+
+/**
+ * zl3073x_write_u16 - write value to 16bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Writes value into given 16bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val)
+{
+	cpu_to_be16s(&val);
+
+	return zl3073x_write_reg(zldev, reg, &val, sizeof(val));
+}
+
+/**
+ * zl3073x_read_u32 - read value from 32bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Reads value from given 32bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_read_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 *val)
+{
+	int rc;
+
+	rc = zl3073x_read_reg(zldev, reg, val, sizeof(*val));
+	if (!rc)
+		be32_to_cpus(val);
+
+	return rc;
+}
+
+/**
+ * zl3073x_write_u32 - write value to 32bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Writes value into given 32bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val)
+{
+	cpu_to_be32s(&val);
+
+	return zl3073x_write_reg(zldev, reg, &val, sizeof(val));
+}
+
+/**
+ * zl3073x_read_u48 - read value from 48bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Reads value from given 48bit register.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_read_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 *val)
+{
+	u8 buf[6];
+	int rc;
+
+	rc = zl3073x_read_reg(zldev, reg, buf, sizeof(buf));
+	if (!rc)
+		*val = get_unaligned_be48(buf);
+
+	return rc;
+}
+
+/**
+ * zl3073x_write_u48 - write value to 48bit register
+ * @zldev: zl3073x device pointer
+ * @reg: register to write to
+ * @val: value to write
+ *
+ * Writes value into given 48bit register.
+ * The value must be from the interval -S48_MIN to U48_MAX.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val)
+{
+	u8 buf[6];
+
+	/* Check the value belongs to <S48_MIN, U48_MAX>
+	 * Any value >= S48_MIN has bits 47..63 set.
+	 */
+	if (val > GENMASK_ULL(47, 0) && val < GENMASK_ULL(63, 47)) {
+		dev_err(zldev->dev, "Value 0x%0llx out of range\n", val);
+		return -EINVAL;
+	}
+
+	put_unaligned_be48(val, buf);
+
+	return zl3073x_write_reg(zldev, reg, buf, sizeof(buf));
+}
+
+/**
+ * zl3073x_poll_zero_u8 - wait for register to be cleared by device
+ * @zldev: zl3073x device pointer
+ * @reg: register to poll (has to be 8bit register)
+ * @mask: bit mask for polling
+ *
+ * Waits for bits specified by @mask in register @reg value to be cleared
+ * by the device.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
+{
+	/* Register polling sleep & timeout */
+#define ZL_POLL_SLEEP_US   10
+#define ZL_POLL_TIMEOUT_US 2000000
+	unsigned int val;
+
+	/* Check the register is 8bit */
+	if (ZL_REG_SIZE(reg) != 1) {
+		dev_err(zldev->dev, "Invalid reg 0x%04lx size for polling\n",
+			ZL_REG_ADDR(reg));
+		return -EINVAL;
+	}
+
+	/* Map the register address to virtual range */
+	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
+
+	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
+					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
+}
+
+/**
+ * zl3073x_devm_alloc - allocates zl3073x device structure
+ * @dev: pointer to device structure
+ *
+ * Allocates zl3073x device structure as device resource.
+ *
+ * Return: pointer to zl3073x device on success, error pointer on error
+ */
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
+{
+	struct zl3073x_dev *zldev;
+
+	zldev = devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+	if (!zldev)
+		return ERR_PTR(-ENOMEM);
+
+	zldev->dev = dev;
+	dev_set_drvdata(zldev->dev, zldev);
+
+	return zldev;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
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
+	unsigned int i;
+	u32 cfg_ver;
+	int rc;
+
+	/* Read chip ID */
+	rc = zl3073x_read_u16(zldev, ZL_REG_ID, &id);
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
+		return dev_err_probe(zldev->dev, -ENODEV,
+				     "Unknown or non-match chip ID: 0x%0x\n",
+				     id);
+	}
+
+	/* Read revision, firmware version and custom config version */
+	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_FW_VER, &fw_ver);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u32(zldev, ZL_REG_CUSTOM_CONFIG_VER, &cfg_ver);
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
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
new file mode 100644
index 0000000000000..75f68bc9a52ee
--- /dev/null
+++ b/drivers/dpll/zl3073x/core.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_H
+#define _ZL3073X_H
+
+#include <linux/types.h>
+
+struct device;
+struct regmap;
+
+/**
+ * struct zl3073x_dev - zl3073x device
+ * @dev: pointer to device
+ * @regmap: regmap to access device registers
+ */
+struct zl3073x_dev {
+	struct device		*dev;
+	struct regmap		*regmap;
+};
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
+extern const struct regmap_config zl3073x_regmap_config;
+
+struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
+int zl3073x_dev_probe(struct zl3073x_dev *zldev,
+		      const struct zl3073x_chip_info *chip_info);
+
+/**********************
+ * Registers operations
+ **********************/
+
+int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
+int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val);
+int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val);
+int zl3073x_read_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 *val);
+int zl3073x_read_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 *val);
+int zl3073x_write_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 val);
+int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val);
+int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val);
+int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
+
+#endif /* _ZL3073X_H */
diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
new file mode 100644
index 0000000000000..bca1cd729895c
--- /dev/null
+++ b/drivers/dpll/zl3073x/i2c.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "core.h"
+
+static int zl3073x_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (IS_ERR(zldev))
+		return PTR_ERR(zldev);
+
+	zldev->regmap = devm_regmap_init_i2c(client, &zl3073x_regmap_config);
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
+	{
+		.name = "zl30731",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731],
+	},
+	{
+		.name = "zl30732",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732],
+	},
+	{
+		.name = "zl30733",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733],
+	},
+	{
+		.name = "zl30734",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734],
+	},
+	{
+		.name = "zl30735",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735],
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);
+
+static const struct of_device_id zl3073x_i2c_of_match[] = {
+	{
+		.compatible = "microchip,zl30731",
+		.data = &zl3073x_chip_info[ZL30731],
+	},
+	{
+		.compatible = "microchip,zl30732",
+		.data = &zl3073x_chip_info[ZL30732],
+	},
+	{
+		.compatible = "microchip,zl30733",
+		.data = &zl3073x_chip_info[ZL30733],
+	},
+	{
+		.compatible = "microchip,zl30734",
+		.data = &zl3073x_chip_info[ZL30734],
+	},
+	{
+		.compatible = "microchip,zl30735",
+		.data = &zl3073x_chip_info[ZL30735],
+	},
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
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
new file mode 100644
index 0000000000000..08bf595935ea1
--- /dev/null
+++ b/drivers/dpll/zl3073x/regs.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_REGS_H
+#define _ZL3073X_REGS_H
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
+/*
+ * Register address structure:
+ * ===========================
+ *  25        19 18  16 15     7 6           0
+ * +------------------------------------------+
+ * | max_offset | size |  page  | page_offset |
+ * +------------------------------------------+
+ *
+ * page_offset ... <0x00..0x7F>
+ * page .......... HW page number
+ * size .......... register byte size (1, 2, 4 or 6)
+ * max_offset .... maximal offset for indexed registers
+ *                 (for non-indexed regs max_offset == page_offset)
+ */
+
+#define ZL_REG_OFFSET_MASK	GENMASK(6, 0)
+#define ZL_REG_PAGE_MASK	GENMASK(15, 7)
+#define ZL_REG_SIZE_MASK	GENMASK(18, 16)
+#define ZL_REG_MAX_OFFSET_MASK	GENMASK(25, 19)
+#define ZL_REG_ADDR_MASK	GENMASK(15, 0)
+
+#define ZL_REG_OFFSET(_reg)	FIELD_GET(ZL_REG_OFFSET_MASK, _reg)
+#define ZL_REG_PAGE(_reg)	FIELD_GET(ZL_REG_PAGE_MASK, _reg)
+#define ZL_REG_MAX_OFFSET(_reg)	FIELD_GET(ZL_REG_MAX_OFFSET_MASK, _reg)
+#define ZL_REG_SIZE(_reg)	FIELD_GET(ZL_REG_SIZE_MASK, _reg)
+#define ZL_REG_ADDR(_reg)	FIELD_GET(ZL_REG_ADDR_MASK, _reg)
+
+/**
+ * ZL_REG_IDX - define indexed register
+ * @_idx: index of register to access
+ * @_page: register page
+ * @_offset: register offset in page
+ * @_size: register byte size (1, 2, 4 or 6)
+ * @_items: number of register indices
+ * @_stride: stride between items in bytes
+ *
+ * All parameters except @_idx should be constant.
+ */
+#define ZL_REG_IDX(_idx, _page, _offset, _size, _items, _stride)	\
+	(FIELD_PREP(ZL_REG_OFFSET_MASK,					\
+		    (_offset) + (_idx) * (_stride))		|	\
+	 FIELD_PREP_CONST(ZL_REG_PAGE_MASK, _page)		|	\
+	 FIELD_PREP_CONST(ZL_REG_SIZE_MASK, _size)		|	\
+	 FIELD_PREP_CONST(ZL_REG_MAX_OFFSET_MASK,			\
+			  (_offset) + ((_items) - 1) * (_stride)))
+
+/**
+ * ZL_REG - define simple (non-indexed) register
+ * @_page: register page
+ * @_offset: register offset in page
+ * @_size: register byte size (1, 2, 4 or 6)
+ *
+ * All parameters should be constant.
+ */
+#define ZL_REG(_page, _offset, _size)					\
+	ZL_REG_IDX(0, _page, _offset, _size, 1, 0)
+
+/**************************
+ * Register Page 0, General
+ **************************/
+
+#define ZL_REG_ID				ZL_REG(0, 0x01, 2)
+#define ZL_REG_REVISION				ZL_REG(0, 0x03, 2)
+#define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
+#define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
+
+#endif /* _ZL3073X_REGS_H */
diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
new file mode 100644
index 0000000000000..219676da71b78
--- /dev/null
+++ b/drivers/dpll/zl3073x/spi.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "core.h"
+
+static int zl3073x_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct zl3073x_dev *zldev;
+
+	zldev = zl3073x_devm_alloc(dev);
+	if (IS_ERR(zldev))
+		return PTR_ERR(zldev);
+
+	zldev->regmap = devm_regmap_init_spi(spi, &zl3073x_regmap_config);
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
+	{
+		.name = "zl30731",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30731],
+	},
+	{
+		.name = "zl30732",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30732],
+	},
+	{
+		.name = "zl30733",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30733],
+	},
+	{
+		.name = "zl30734",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30734],
+	},
+	{
+		.name = "zl30735",
+		.driver_data = (kernel_ulong_t)&zl3073x_chip_info[ZL30735]
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
+
+static const struct of_device_id zl3073x_spi_of_match[] = {
+	{
+		.compatible = "microchip,zl30731",
+		.data = &zl3073x_chip_info[ZL30731]
+	},
+	{
+		.compatible = "microchip,zl30732",
+		.data = &zl3073x_chip_info[ZL30732]
+	},
+	{
+		.compatible = "microchip,zl30733",
+		.data = &zl3073x_chip_info[ZL30733]
+	},
+	{
+		.compatible = "microchip,zl30734",
+		.data = &zl3073x_chip_info[ZL30734]
+	},
+	{
+		.compatible = "microchip,zl30735",
+		.data = &zl3073x_chip_info[ZL30735]
+	},
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
-- 
2.49.0


