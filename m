Return-Path: <netdev+bounces-220764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1FB488B7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0830341D3B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC92F746F;
	Mon,  8 Sep 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt6Vccp6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD652F0C61
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324389; cv=none; b=aP7pDQFAgsgHXW/XknDtHrRm2OnhMivXDgoqO7UKCcM/gdYdv9+3JpwEn2oUZLZE7igb+Xb0H/5YNwI15doLgumk9I84ri/qqt49K7t0cOriWiX4BcZD0ZRlcRhYjXSvxkkagvYsxcsTSxM8BCicF9S5iKWtnb/Vv0b/0fkc1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324389; c=relaxed/simple;
	bh=YMrJ00MCd/YqK1cjYnDiH5SJ8AafaLC+/hfxuOuzRlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mzgu2p5MSO/Q4PEh8t0cYGX/f9wkSbN49e8mgFuil39wpX6tz7D0XEckLoskK58a8xsy9LhF7rvNGJcrNM29GBSsOOewJAIJAg5sp+7xfs995W9wC8BtycI5hKb4EYgH+xqoxKnP6yo6DAQV63i3Y0nYNfwBzhZsyRhSFdeHLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt6Vccp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757324386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoxqP/qpc47J8G2Ah+nRQ626epoJdFgaLLbvDDbBHhk=;
	b=Xt6Vccp6ZK6nI4ATH78HwpkYcRW7bBDEz7CcbwUCeWZcQhCxL1J/eQ7Zy/aauEMb7bJk3F
	zIs6y5WByZNmvhhguQ9aSDk/ID7Dyu8sk73ndBSHoQNSZdfIDcY4kmlFvg6phNGYYG2ag1
	vY3VZ5v7nRmwOq1/wCwaPK4nGSNrZuQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-IpmCQpE6P---1QluGQRcTg-1; Mon,
 08 Sep 2025 05:39:42 -0400
X-MC-Unique: IpmCQpE6P---1QluGQRcTg-1
X-Mimecast-MFC-AGG-ID: IpmCQpE6P---1QluGQRcTg_1757324381
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07BE219560A1;
	Mon,  8 Sep 2025 09:39:41 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 235CB18003FC;
	Mon,  8 Sep 2025 09:39:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v5 2/5] dpll: zl3073x: Add low-level flash functions
Date: Mon,  8 Sep 2025 11:39:21 +0200
Message-ID: <20250908093924.1952317-3-ivecera@redhat.com>
In-Reply-To: <20250908093924.1952317-1-ivecera@redhat.com>
References: <20250908093924.1952317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

To implement the devlink device flash functionality, the driver needs
to access both the device memory and the internal flash memory. The flash
memory is accessed using a device-specific program (called the flash
utility). This flash utility must be downloaded by the driver into
the device memory and then executed by the device CPU. Once running,
the flash utility provides a flash API to access the flash memory itself.

During this operation, the normal functionality provided by the standard
firmware is not available. Therefore, the driver must ensure that DPLL
callbacks and monitoring functions are not executed during the flash
operation.

Add all necessary functions for downloading the utility to device memory,
entering and exiting flash mode, and performing flash operations.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v5:
* fixed documentation for zl3073x_flash_download()
* removed some simple comments
* using get_unaligned() in zl3073x_flash_download()
* using time_is_{before,after}_jiffies() instead of time_{after,before}()
* renamed 'timeout' to 'check_time' in zl3073x_flash_download()
* fixed return code in zl3073x_flash_mode_enter() in case of error
v4:
* removed duplication of error messages into the logs
v3:
* added ZL_ prefix for some local macros
* removed extra comments
* removed duplicated variable initialization
* used SZ_4K & SZ_64K instead of direct values
* refactored common parts of zl3073x_flash_sectors() and
  zl3073x_flash_page() into zl3073x_flash_block()
* removed unnecessary clearing of bit ZL_HOST_CONTROL_ENABLE
v2:
* extended 'comp_str' to 32 chars to avoid warnings related to snprintf
* added additional includes
---
 drivers/dpll/zl3073x/Makefile  |   2 +-
 drivers/dpll/zl3073x/devlink.c |   9 +
 drivers/dpll/zl3073x/devlink.h |   3 +
 drivers/dpll/zl3073x/flash.c   | 665 +++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/flash.h   |  29 ++
 drivers/dpll/zl3073x/regs.h    |  39 ++
 6 files changed, 746 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dpll/zl3073x/flash.c
 create mode 100644 drivers/dpll/zl3073x/flash.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index c3e2f02f319dc..9894513f67dd3 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
-zl3073x-objs			:= core.o devlink.o dpll.o prop.o
+zl3073x-objs			:= core.o devlink.o dpll.o flash.o prop.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index 7e7fe726ee37a..f3ca973a4d416 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -138,6 +138,15 @@ zl3073x_devlink_reload_up(struct devlink *devlink,
 	return 0;
 }
 
+void zl3073x_devlink_flash_notify(struct zl3073x_dev *zldev, const char *msg,
+				  const char *component, u32 done, u32 total)
+{
+	struct devlink *devlink = priv_to_devlink(zldev);
+
+	devlink_flash_update_status_notify(devlink, msg, component, done,
+					   total);
+}
+
 static const struct devlink_ops zl3073x_devlink_ops = {
 	.info_get = zl3073x_devlink_info_get,
 	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT),
diff --git a/drivers/dpll/zl3073x/devlink.h b/drivers/dpll/zl3073x/devlink.h
index 037720db204fc..63dfd6fa1cd60 100644
--- a/drivers/dpll/zl3073x/devlink.h
+++ b/drivers/dpll/zl3073x/devlink.h
@@ -9,4 +9,7 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
 
 int zl3073x_devlink_register(struct zl3073x_dev *zldev);
 
+void zl3073x_devlink_flash_notify(struct zl3073x_dev *zldev, const char *msg,
+				  const char *component, u32 done, u32 total);
+
 #endif /* _ZL3073X_DEVLINK_H */
diff --git a/drivers/dpll/zl3073x/flash.c b/drivers/dpll/zl3073x/flash.c
new file mode 100644
index 0000000000000..1471a598d8596
--- /dev/null
+++ b/drivers/dpll/zl3073x/flash.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+#include <linux/netlink.h>
+#include <linux/sched/signal.h>
+#include <linux/sizes.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <net/devlink.h>
+
+#include "core.h"
+#include "devlink.h"
+#include "flash.h"
+
+#define ZL_FLASH_ERR_PFX "FW update failed: "
+#define ZL_FLASH_ERR_MSG(_extack, _msg, ...)				\
+	NL_SET_ERR_MSG_FMT_MOD((_extack), ZL_FLASH_ERR_PFX _msg,	\
+			       ## __VA_ARGS__)
+
+/**
+ * zl3073x_flash_download - Download image block to device memory
+ * @zldev: zl3073x device structure
+ * @image: image to be downloaded
+ * @start: start position (in 32-bit words)
+ * @size: size to download (in 32-bit words)
+ * @extack: netlink extack pointer to report errors
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
+		       u32 addr, const void *data, size_t size,
+		       struct netlink_ext_ack *extack)
+{
+#define ZL_CHECK_DELAY	5000 /* Check for interrupt each 5 seconds */
+	unsigned long check_time;
+	const void *ptr, *end;
+	int rc = 0;
+
+	dev_dbg(zldev->dev, "Downloading %zu bytes to device memory at 0x%0x\n",
+		size, addr);
+
+	check_time = jiffies + msecs_to_jiffies(ZL_CHECK_DELAY);
+
+	for (ptr = data, end = data + size; ptr < end; ptr += 4, addr += 4) {
+		/* Write current word to HW memory */
+		rc = zl3073x_write_hwreg(zldev, addr,
+					 get_unaligned((u32 *)ptr));
+		if (rc) {
+			ZL_FLASH_ERR_MSG(extack,
+					 "failed to write to memory at 0x%0x",
+					 addr);
+			return rc;
+		}
+
+		if (time_is_before_jiffies(check_time)) {
+			if (signal_pending(current)) {
+				ZL_FLASH_ERR_MSG(extack,
+						 "Flashing interrupted");
+				return -EINTR;
+			}
+
+			check_time = jiffies + msecs_to_jiffies(ZL_CHECK_DELAY);
+		}
+
+		/* Report status each 1 kB block */
+		if ((ptr - data) % 1024 == 0)
+			zl3073x_devlink_flash_notify(zldev, "Downloading image",
+						     component, ptr - data,
+						     size);
+	}
+
+	zl3073x_devlink_flash_notify(zldev, "Downloading image", component,
+				     ptr - data, size);
+
+	dev_dbg(zldev->dev, "%zu bytes downloaded to device memory\n", size);
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_error_check - Check for flash utility errors
+ * @zldev: zl3073x device structure
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function checks for errors detected by the flash utility and
+ * reports them if any were found.
+ *
+ * Return: 0 on success, -EIO when errors are detected
+ */
+static int
+zl3073x_flash_error_check(struct zl3073x_dev *zldev,
+			  struct netlink_ext_ack *extack)
+{
+	u32 count, cause;
+	int rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_ERROR_COUNT, &count);
+	if (rc)
+		return rc;
+	else if (!count)
+		return 0; /* No error */
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_ERROR_CAUSE, &cause);
+	if (rc)
+		return rc;
+
+	/* Report errors */
+	ZL_FLASH_ERR_MSG(extack,
+			 "utility error occurred: count=%u cause=0x%x", count,
+			 cause);
+
+	return -EIO;
+}
+
+/**
+ * zl3073x_flash_wait_ready - Check or wait for utility to be ready to flash
+ * @zldev: zl3073x device structure
+ * @timeout_ms: timeout for the waiting
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_flash_wait_ready(struct zl3073x_dev *zldev, unsigned int timeout_ms)
+{
+#define ZL_FLASH_POLL_DELAY_MS	100
+	unsigned long timeout;
+	int rc, i;
+
+	dev_dbg(zldev->dev, "Waiting for flashing to be ready\n");
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+
+	for (i = 0; time_is_after_jiffies(timeout); i++) {
+		u8 value;
+
+		/* Check for interrupt each 1s */
+		if (i > 9) {
+			if (signal_pending(current))
+				return -EINTR;
+			i = 0;
+		}
+
+		rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
+		if (rc)
+			return rc;
+
+		value = FIELD_GET(ZL_WRITE_FLASH_OP, value);
+
+		if (value == ZL_WRITE_FLASH_OP_DONE)
+			return 0; /* Successfully done */
+
+		msleep(ZL_FLASH_POLL_DELAY_MS);
+	}
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * zl3073x_flash_cmd_wait - Perform flash operation and wait for finish
+ * @zldev: zl3073x device structure
+ * @operation: operation to perform
+ * @extack: netlink extack pointer to report errors
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_flash_cmd_wait(struct zl3073x_dev *zldev, u32 operation,
+		       struct netlink_ext_ack *extack)
+{
+#define ZL_FLASH_PHASE1_TIMEOUT_MS 60000	/* up to 1 minute */
+#define ZL_FLASH_PHASE2_TIMEOUT_MS 120000	/* up to 2 minutes */
+	u8 value;
+	int rc;
+
+	dev_dbg(zldev->dev, "Sending flash command: 0x%x\n", operation);
+
+	rc = zl3073x_flash_wait_ready(zldev, ZL_FLASH_PHASE1_TIMEOUT_MS);
+	if (rc)
+		return rc;
+
+	/* Issue the requested operation */
+	rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
+	if (rc)
+		return rc;
+
+	value &= ~ZL_WRITE_FLASH_OP;
+	value |= FIELD_PREP(ZL_WRITE_FLASH_OP, operation);
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_WRITE_FLASH, value);
+	if (rc)
+		return rc;
+
+	/* Wait for command completion */
+	rc = zl3073x_flash_wait_ready(zldev, ZL_FLASH_PHASE2_TIMEOUT_MS);
+	if (rc)
+		return rc;
+
+	return zl3073x_flash_error_check(zldev, extack);
+}
+
+/**
+ * zl3073x_flash_get_sector_size - Get flash sector size
+ * @zldev: zl3073x device structure
+ * @sector_size: sector size returned by the function
+ *
+ * The function reads the flash sector size detected by flash utility and
+ * stores it into @sector_size.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_flash_get_sector_size(struct zl3073x_dev *zldev, size_t *sector_size)
+{
+	u8 flash_info;
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_FLASH_INFO, &flash_info);
+	if (rc)
+		return rc;
+
+	switch (FIELD_GET(ZL_FLASH_INFO_SECTOR_SIZE, flash_info)) {
+	case ZL_FLASH_INFO_SECTOR_4K:
+		*sector_size = SZ_4K;
+		break;
+	case ZL_FLASH_INFO_SECTOR_64K:
+		*sector_size = SZ_64K;
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_block - Download and flash memory block
+ * @zldev: zl3073x device structure
+ * @component: component name
+ * @operation: flash operation to perform
+ * @page: destination flash page
+ * @addr: device memory address to load data
+ * @data: pointer to data to be flashed
+ * @size: size of data
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function downloads the memory block given by the @data pointer and
+ * the size @size and flashes it into internal memory on flash page @page.
+ * The internal flash operation performed by the firmware is specified by
+ * the @operation parameter.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_flash_block(struct zl3073x_dev *zldev, const char *component,
+		    u32 operation, u32 page, u32 addr, const void *data,
+		    size_t size, struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	/* Download block to device memory */
+	rc = zl3073x_flash_download(zldev, component, addr, data, size, extack);
+	if (rc)
+		return rc;
+
+	/* Set address to flash from */
+	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
+	if (rc)
+		return rc;
+
+	/* Set size of block to flash */
+	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, size);
+	if (rc)
+		return rc;
+
+	/* Set destination page to flash */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
+	if (rc)
+		return rc;
+
+	/* Set filling pattern */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
+	if (rc)
+		return rc;
+
+	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, 0,
+				     size);
+
+	dev_dbg(zldev->dev, "Flashing %zu bytes to page %u\n", size, page);
+
+	/* Execute sectors flash operation */
+	rc = zl3073x_flash_cmd_wait(zldev, operation, extack);
+	if (rc)
+		return rc;
+
+	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, size,
+				     size);
+
+	return 0;
+}
+
+/**
+ * zl3073x_flash_sectors - Flash sectors
+ * @zldev: zl3073x device structure
+ * @component: component name
+ * @page: destination flash page
+ * @addr: device memory address to load data
+ * @data: pointer to data to be flashed
+ * @size: size of data
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function flashes given @data with size of @size to the internal flash
+ * memory block starting from page @page. The function uses sector flash
+ * method and has to take into account the flash sector size reported by
+ * flashing utility. Input data are spliced into blocks according this
+ * sector size and each block is flashed separately.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_flash_sectors(struct zl3073x_dev *zldev, const char *component,
+			  u32 page, u32 addr, const void *data, size_t size,
+			  struct netlink_ext_ack *extack)
+{
+#define ZL_FLASH_MAX_BLOCK_SIZE	0x0001E000
+#define ZL_FLASH_PAGE_SIZE	256
+	size_t max_block_size, block_size, sector_size;
+	const void *ptr, *end;
+	int rc;
+
+	/* Get flash sector size */
+	rc = zl3073x_flash_get_sector_size(zldev, &sector_size);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "Failed to get flash sector size");
+		return rc;
+	}
+
+	/* Determine max block size depending on sector size */
+	max_block_size = ALIGN_DOWN(ZL_FLASH_MAX_BLOCK_SIZE, sector_size);
+
+	for (ptr = data, end = data + size; ptr < end; ptr += block_size) {
+		char comp_str[32];
+
+		block_size = min_t(size_t, max_block_size, end - ptr);
+
+		/* Add suffix '-partN' if the requested component size is
+		 * greater than max_block_size.
+		 */
+		if (max_block_size < size)
+			snprintf(comp_str, sizeof(comp_str), "%s-part%zu",
+				 component, (ptr - data) / max_block_size + 1);
+		else
+			strscpy(comp_str, component);
+
+		/* Flash the memory block */
+		rc = zl3073x_flash_block(zldev, comp_str,
+					 ZL_WRITE_FLASH_OP_SECTORS, page, addr,
+					 ptr, block_size, extack);
+		if (rc)
+			goto finish;
+
+		/* Move to next page */
+		page += block_size / ZL_FLASH_PAGE_SIZE;
+	}
+
+finish:
+	zl3073x_devlink_flash_notify(zldev,
+				     rc ?  "Flashing failed" : "Flashing done",
+				     component, 0, 0);
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_page - Flash page
+ * @zldev: zl3073x device structure
+ * @component: component name
+ * @page: destination flash page
+ * @addr: device memory address to load data
+ * @data: pointer to data to be flashed
+ * @size: size of data
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function flashes given @data with size of @size to the internal flash
+ * memory block starting with page @page.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_flash_page(struct zl3073x_dev *zldev, const char *component,
+		       u32 page, u32 addr, const void *data, size_t size,
+		       struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	/* Flash the memory block */
+	rc = zl3073x_flash_block(zldev, component, ZL_WRITE_FLASH_OP_PAGE, page,
+				 addr, data, size, extack);
+
+	zl3073x_devlink_flash_notify(zldev,
+				     rc ?  "Flashing failed" : "Flashing done",
+				     component, 0, 0);
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_page_copy - Copy flash page
+ * @zldev: zl3073x device structure
+ * @component: component name
+ * @src_page: source page to copy
+ * @dst_page: destination page
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function copies one flash page specified by @src_page into the flash
+ * page specified by @dst_page.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_flash_page_copy(struct zl3073x_dev *zldev, const char *component,
+			    u32 src_page, u32 dst_page,
+			    struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	/* Set source page to be copied */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_READ, src_page);
+	if (rc)
+		return rc;
+
+	/* Set destination page for the copy */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, dst_page);
+	if (rc)
+		return rc;
+
+	/* Perform copy operation */
+	rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_COPY_PAGE, extack);
+	if (rc)
+		ZL_FLASH_ERR_MSG(extack, "Failed to copy page %u to page %u",
+				 src_page, dst_page);
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_mode_verify - Check flash utility
+ * @zldev: zl3073x device structure
+ *
+ * Return: 0 if the flash utility is ready, <0 on error
+ */
+static int
+zl3073x_flash_mode_verify(struct zl3073x_dev *zldev)
+{
+	u8 family, release;
+	u32 hash;
+	int rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_FLASH_HASH, &hash);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_FLASH_FAMILY, &family);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_FLASH_RELEASE, &release);
+	if (rc)
+		return rc;
+
+	dev_dbg(zldev->dev,
+		"Flash utility check: hash 0x%08x, fam 0x%02x, rel 0x%02x\n",
+		hash, family, release);
+
+	/* Return success for correct family */
+	return (family == 0x21) ? 0 : -ENODEV;
+}
+
+static int
+zl3073x_flash_host_ctrl_enable(struct zl3073x_dev *zldev)
+{
+	u8 host_ctrl;
+	int rc;
+
+	/* Enable host control */
+	rc = zl3073x_read_u8(zldev, ZL_REG_HOST_CONTROL, &host_ctrl);
+	if (rc)
+		return rc;
+
+	host_ctrl |= ZL_HOST_CONTROL_ENABLE;
+
+	return zl3073x_write_u8(zldev, ZL_REG_HOST_CONTROL, host_ctrl);
+}
+
+/**
+ * zl3073x_flash_mode_enter - Switch the device to flash mode
+ * @zldev: zl3073x device structure
+ * @util_ptr: buffer with flash utility
+ * @util_size: size of buffer with flash utility
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function prepares and switches the device into flash mode.
+ *
+ * The procedure:
+ * 1) Stop device CPU by specific HW register sequence
+ * 2) Download flash utility to device memory
+ * 3) Resume device CPU by specific HW register sequence
+ * 4) Check communication with flash utility
+ * 5) Enable host control necessary to access flash API
+ * 6) Check for potential error detected by the utility
+ *
+ * The API provided by normal firmware is not available in flash mode
+ * so the caller has to ensure that this API is not used in this mode.
+ *
+ * After performing flash operation the caller should call
+ * @zl3073x_flash_mode_leave to return back to normal operation.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int zl3073x_flash_mode_enter(struct zl3073x_dev *zldev, const void *util_ptr,
+			     size_t util_size, struct netlink_ext_ack *extack)
+{
+	/* Sequence to be written prior utility download */
+	static const struct zl3073x_hwreg_seq_item pre_seq[] = {
+		HWREG_SEQ_ITEM(0x80000400, 1, BIT(0), 0),
+		HWREG_SEQ_ITEM(0x80206340, 1, BIT(4), 0),
+		HWREG_SEQ_ITEM(0x10000000, 1, BIT(2), 0),
+		HWREG_SEQ_ITEM(0x10000024, 0x00000001, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10000020, 0x00000001, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10000000, 1, BIT(10), 1000),
+	};
+	/* Sequence to be written after utility download */
+	static const struct zl3073x_hwreg_seq_item post_seq[] = {
+		HWREG_SEQ_ITEM(0x10400004, 0x000000C0, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10400008, 0x00000000, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10400010, 0x20000000, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10400014, 0x20000004, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10000000, 1, GENMASK(10, 9), 0),
+		HWREG_SEQ_ITEM(0x10000020, 0x00000000, U32_MAX, 0),
+		HWREG_SEQ_ITEM(0x10000000, 0, BIT(0), 1000),
+	};
+	int rc;
+
+	zl3073x_devlink_flash_notify(zldev, "Prepare flash mode", "utility",
+				     0, 0);
+
+	/* Execure pre-load sequence */
+	rc = zl3073x_write_hwreg_seq(zldev, pre_seq, ARRAY_SIZE(pre_seq));
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "cannot execute pre-load sequence");
+		goto error;
+	}
+
+	/* Download utility image to device memory */
+	rc = zl3073x_flash_download(zldev, "utility", 0x20000000, util_ptr,
+				    util_size, extack);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "cannot download flash utility");
+		goto error;
+	}
+
+	/* Execute post-load sequence */
+	rc = zl3073x_write_hwreg_seq(zldev, post_seq, ARRAY_SIZE(post_seq));
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "cannot execute post-load sequence");
+		goto error;
+	}
+
+	/* Check that utility identifies itself correctly */
+	rc = zl3073x_flash_mode_verify(zldev);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "flash utility check failed");
+		goto error;
+	}
+
+	/* Enable host control */
+	rc = zl3073x_flash_host_ctrl_enable(zldev);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "cannot enable host control");
+		goto error;
+	}
+
+	zl3073x_devlink_flash_notify(zldev, "Flash mode enabled", "utility",
+				     0, 0);
+
+	return 0;
+
+error:
+	zl3073x_flash_mode_leave(zldev, extack);
+
+	return rc;
+}
+
+/**
+ * zl3073x_flash_mode_leave - Leave flash mode
+ * @zldev: zl3073x device structure
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function instructs the device to leave the flash mode and
+ * to return back to normal operation.
+ *
+ * The procedure:
+ * 1) Set reset flag
+ * 2) Reset the device CPU by specific HW register sequence
+ * 3) Wait for the device to be ready
+ * 4) Check the reset flag was cleared
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_flash_mode_leave(struct zl3073x_dev *zldev,
+			     struct netlink_ext_ack *extack)
+{
+	/* Sequence to be written after flash */
+	static const struct zl3073x_hwreg_seq_item fw_reset_seq[] = {
+		HWREG_SEQ_ITEM(0x80000404, 1, BIT(0), 0),
+		HWREG_SEQ_ITEM(0x80000410, 1, BIT(0), 0),
+	};
+	u8 reset_status;
+	int rc;
+
+	zl3073x_devlink_flash_notify(zldev, "Leaving flash mode", "utility",
+				     0, 0);
+
+	/* Read reset status register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_RESET_STATUS, &reset_status);
+	if (rc)
+		return rc;
+
+	/* Set reset bit */
+	reset_status |= ZL_REG_RESET_STATUS_RESET;
+
+	/* Update reset status register */
+	rc = zl3073x_write_u8(zldev, ZL_REG_RESET_STATUS, reset_status);
+	if (rc)
+		return rc;
+
+	/* We do not check the return value here as the sequence resets
+	 * the device CPU and the last write always return an error.
+	 */
+	zl3073x_write_hwreg_seq(zldev, fw_reset_seq, ARRAY_SIZE(fw_reset_seq));
+
+	/* Wait for the device to be ready */
+	msleep(500);
+
+	/* Read again the reset status register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_RESET_STATUS, &reset_status);
+	if (rc)
+		return rc;
+
+	/* Check the reset bit was cleared */
+	if (reset_status & ZL_REG_RESET_STATUS_RESET) {
+		dev_err(zldev->dev,
+			"Reset not confirmed after switch to normal mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/dpll/zl3073x/flash.h b/drivers/dpll/zl3073x/flash.h
new file mode 100644
index 0000000000000..effe1b16b3591
--- /dev/null
+++ b/drivers/dpll/zl3073x/flash.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ZL3073X_FLASH_H
+#define __ZL3073X_FLASH_H
+
+#include <linux/types.h>
+
+struct netlink_ext_ack;
+struct zl3073x_dev;
+
+int zl3073x_flash_mode_enter(struct zl3073x_dev *zldev, const void *util_ptr,
+			     size_t util_size, struct netlink_ext_ack *extack);
+
+int zl3073x_flash_mode_leave(struct zl3073x_dev *zldev,
+			     struct netlink_ext_ack *extack);
+
+int zl3073x_flash_page(struct zl3073x_dev *zldev, const char *component,
+		       u32 page, u32 addr, const void *data, size_t size,
+		       struct netlink_ext_ack *extack);
+
+int zl3073x_flash_page_copy(struct zl3073x_dev *zldev, const char *component,
+			    u32 src_page, u32 dst_page,
+			    struct netlink_ext_ack *extack);
+
+int zl3073x_flash_sectors(struct zl3073x_dev *zldev, const char *component,
+			  u32 page, u32 addr, const void *data, size_t size,
+			  struct netlink_ext_ack *extack);
+
+#endif /* __ZL3073X_FLASH_H */
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 80922987add34..19a25325bd9c7 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -72,6 +72,9 @@
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
 #define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
 
+#define ZL_REG_RESET_STATUS			ZL_REG(0, 0x18, 1)
+#define ZL_REG_RESET_STATUS_RESET		BIT(0)
+
 /*************************
  * Register Page 2, Status
  *************************/
@@ -272,4 +275,40 @@
 #define ZL_REG_HWREG_WRITE_DATA			ZL_REG(0xff, 0x08, 4)
 #define ZL_REG_HWREG_READ_DATA			ZL_REG(0xff, 0x0c, 4)
 
+/*
+ * Registers available in flash mode
+ */
+#define ZL_REG_FLASH_HASH			ZL_REG(0, 0x78, 4)
+#define ZL_REG_FLASH_FAMILY			ZL_REG(0, 0x7c, 1)
+#define ZL_REG_FLASH_RELEASE			ZL_REG(0, 0x7d, 1)
+
+#define ZL_REG_HOST_CONTROL			ZL_REG(1, 0x02, 1)
+#define ZL_HOST_CONTROL_ENABLE			BIT(0)
+
+#define ZL_REG_IMAGE_START_ADDR			ZL_REG(1, 0x04, 4)
+#define ZL_REG_IMAGE_SIZE			ZL_REG(1, 0x08, 4)
+#define ZL_REG_FLASH_INDEX_READ			ZL_REG(1, 0x0c, 4)
+#define ZL_REG_FLASH_INDEX_WRITE		ZL_REG(1, 0x10, 4)
+#define ZL_REG_FILL_PATTERN			ZL_REG(1, 0x14, 4)
+
+#define ZL_REG_WRITE_FLASH			ZL_REG(1, 0x18, 1)
+#define ZL_WRITE_FLASH_OP			GENMASK(2, 0)
+#define ZL_WRITE_FLASH_OP_DONE			0x0
+#define ZL_WRITE_FLASH_OP_SECTORS		0x2
+#define ZL_WRITE_FLASH_OP_PAGE			0x3
+#define ZL_WRITE_FLASH_OP_COPY_PAGE		0x4
+
+#define ZL_REG_FLASH_INFO			ZL_REG(2, 0x00, 1)
+#define ZL_FLASH_INFO_SECTOR_SIZE		GENMASK(3, 0)
+#define ZL_FLASH_INFO_SECTOR_4K			0
+#define ZL_FLASH_INFO_SECTOR_64K		1
+
+#define ZL_REG_ERROR_COUNT			ZL_REG(2, 0x04, 4)
+#define ZL_REG_ERROR_CAUSE			ZL_REG(2, 0x08, 4)
+
+#define ZL_REG_OP_STATE				ZL_REG(2, 0x14, 1)
+#define ZL_OP_STATE_NO_COMMAND			0
+#define ZL_OP_STATE_PENDING			1
+#define ZL_OP_STATE_DONE			2
+
 #endif /* _ZL3073X_REGS_H */
-- 
2.49.1


