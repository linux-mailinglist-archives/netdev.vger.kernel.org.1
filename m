Return-Path: <netdev+bounces-212474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21FB20C6F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499EE16AF52
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9F2DE6E7;
	Mon, 11 Aug 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpqoq4pC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE12E06C3
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923234; cv=none; b=DuMXtqz6zHFy8SADnDzva+sYqYyzIfBCIBS8aOuFt8IckRK08xnPY2WQnA3l/CbwhlypqACRg6QbZVjka5emG07jE1eG29qPB9qeE+Yix0y2noyUh6I/7Pbfm77UJujOMM9FRr0enZwOuCyQ89gOPqjsjD2FQDYeQ/bAflUkclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923234; c=relaxed/simple;
	bh=YGsv4hrAUj5MV2gXnw5EXfvR4sIXnlt2UY9oCtVzx84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUkAIoI4At1cVMXlbVD6BYRhLpP5VqLsZFUK7nqXCCT7bIzgOybLNfC9JD+9p+Cr8UoyFB80wKSoxTYisHQGmc5tatthhkSrepph8eu7tH/u8pItatICcyARpYWy/Mizb0iF7ip2QjrkGfUlAQYuZZqbsnWxA/ykvNVh8MW7kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fpqoq4pC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4pOCSe/Pr6bqIk5y6gM76oOJ6GM++25gRVyqraUqPw=;
	b=Fpqoq4pCFtajYVYcHyVTEHU1n/eORtOqzbXmJ/lJAeLmCc8FL6fxcHOcHl0hECduLtV4M6
	ZHUyIY+wfBcShD+85yLUUeM1vl/z6fJlr32zlSRlU+OkODtEw3lBipOlGhKFteVVJtz/o/
	njM3MObwuUgz1hyXtYVWj2Ii+t8RPXg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-xhhj3Ao0OYCzBLZV7tDRIA-1; Mon,
 11 Aug 2025 10:40:27 -0400
X-MC-Unique: xhhj3Ao0OYCzBLZV7tDRIA-1
X-Mimecast-MFC-AGG-ID: xhhj3Ao0OYCzBLZV7tDRIA_1754923225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03BFB1800561;
	Mon, 11 Aug 2025 14:40:25 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.225.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A383300145A;
	Mon, 11 Aug 2025 14:40:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
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
Subject: [PATCH net-next v2 2/5] dpll: zl3073x: Add low-level flash functions
Date: Mon, 11 Aug 2025 16:40:06 +0200
Message-ID: <20250811144009.2408337-3-ivecera@redhat.com>
In-Reply-To: <20250811144009.2408337-1-ivecera@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* extended 'comp_str' to 32 chars to avoid warnings related to snprintf
* added additional includes
---
 drivers/dpll/zl3073x/Makefile  |   2 +-
 drivers/dpll/zl3073x/devlink.c |   9 +
 drivers/dpll/zl3073x/devlink.h |   3 +
 drivers/dpll/zl3073x/flash.c   | 684 +++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/flash.h   |  29 ++
 drivers/dpll/zl3073x/regs.h    |  39 ++
 6 files changed, 765 insertions(+), 1 deletion(-)
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
index 0000000000000..df27e892e8c29
--- /dev/null
+++ b/drivers/dpll/zl3073x/flash.c
@@ -0,0 +1,684 @@
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
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+
+#include "core.h"
+#include "devlink.h"
+#include "flash.h"
+
+#define ZL_FLASH_ERR_PFX "FW update failed: "
+#define ZL_FLASH_ERR_MSG(_zldev, _extack, _msg, ...)			\
+	do {								\
+		dev_err((_zldev)->dev, ZL_FLASH_ERR_PFX _msg "\n",	\
+			## __VA_ARGS__);				\
+		NL_SET_ERR_MSG_FMT_MOD((_extack), ZL_FLASH_ERR_PFX _msg,\
+				       ## __VA_ARGS__);			\
+	} while (0)
+
+/**
+ * zl3073x_flash_download_block - Download image block to device memory
+ * @zldev: zl3073x device structure
+ * @image: image to be downloaded
+ * @start: start position (in 32-bit words)
+ * @size: size to download (in 32-bit words)
+ * @extack: netlink extack pointer to report errors
+ *
+ * Returns 0 in case of success or negative value otherwise.
+ */
+static int
+zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
+		       u32 addr, const void *data, size_t size,
+		       struct netlink_ext_ack *extack)
+{
+#define CHECK_DELAY	5000 /* Check for interrupt each 5 seconds */
+	unsigned long timeout;
+	const void *ptr, *end;
+	int rc = 0;
+
+	dev_dbg(zldev->dev, "Downloading %zu bytes to device memory at 0x%0x\n",
+		size, addr);
+
+	timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
+
+	for (ptr = data, end = data + size; ptr < end; ptr += 4, addr += 4) {
+		/* Write current word to HW memory */
+		rc = zl3073x_write_hwreg(zldev, addr, *(const u32 *)ptr);
+		if (rc) {
+			ZL_FLASH_ERR_MSG(zldev, extack,
+					 "failed to write to memory at 0x%0x",
+					 addr);
+			return rc;
+		}
+
+		/* Check for pending interrupt each 5 seconds */
+		if (time_after(jiffies, timeout)) {
+			if (signal_pending(current)) {
+				ZL_FLASH_ERR_MSG(zldev, extack,
+						 "Flashing interrupted");
+				return -EINTR;
+			}
+
+			timeout = jiffies + msecs_to_jiffies(CHECK_DELAY);
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
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_ERROR_CAUSE, &cause);
+	if (rc)
+		return rc;
+
+	/* Return if no error occurred */
+	if (!count)
+		return 0;
+
+	/* Report errors */
+	ZL_FLASH_ERR_MSG(zldev, extack,
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
+	for (i = 0, timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	     time_before(jiffies, timeout);
+	     i++) {
+		u8 value;
+
+		/* Check for interrupt each 1s */
+		if (i > 9) {
+			if (signal_pending(current))
+				return -EINTR;
+			i = 0;
+		}
+
+		/* Read write_flash register value */
+		rc = zl3073x_read_u8(zldev, ZL_REG_WRITE_FLASH, &value);
+		if (rc)
+			return rc;
+
+		value = FIELD_GET(ZL_WRITE_FLASH_OP, value);
+
+		/* Check if the current operation was done */
+		if (value == ZL_WRITE_FLASH_OP_DONE)
+			return 0; /* Operation was successfully done */
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
+#define FLASH_PHASE1_TIMEOUT_MS 60000	/* up to 1 minute */
+#define FLASH_PHASE2_TIMEOUT_MS 120000	/* up to 2 minutes */
+	u8 value;
+	int rc;
+
+	dev_dbg(zldev->dev, "Sending flash command: 0x%x\n", operation);
+
+	/* Wait for access */
+	rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE1_TIMEOUT_MS);
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
+	rc = zl3073x_flash_wait_ready(zldev, FLASH_PHASE2_TIMEOUT_MS);
+	if (rc)
+		return rc;
+
+	/* Check for utility errors */
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
+		*sector_size = 0x1000;
+		break;
+	case ZL_FLASH_INFO_SECTOR_64K:
+		*sector_size = 0x10000;
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
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "Failed to get flash sector size");
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
+		/* Download block to device memory */
+		rc = zl3073x_flash_download(zldev, comp_str, addr, ptr,
+					    block_size, extack);
+		if (rc)
+			goto finish;
+
+		/* Set address to flash from */
+		rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
+		if (rc)
+			goto finish;
+
+		/* Set size of block to flash */
+		rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, block_size);
+		if (rc)
+			goto finish;
+
+		/* Set destination page to flash */
+		rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
+		if (rc)
+			goto finish;
+
+		/* Set filling pattern */
+		rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
+		if (rc)
+			goto finish;
+
+		zl3073x_devlink_flash_notify(zldev, "Flashing image", comp_str,
+					     0, 0);
+
+		dev_dbg(zldev->dev, "Flashing %zu bytes to page %u\n",
+			block_size, page);
+
+		/* Execute sectors flash operation */
+		rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_SECTORS,
+					    extack);
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
+	/* Download component to device memory */
+	rc = zl3073x_flash_download(zldev, component, addr, data, size, extack);
+	if (rc)
+		goto finish;
+
+	/* Set address to flash from */
+	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_START_ADDR, addr);
+	if (rc)
+		goto finish;
+
+	/* Set size of block to flash */
+	rc = zl3073x_write_u32(zldev, ZL_REG_IMAGE_SIZE, size);
+	if (rc)
+		goto finish;
+
+	/* Set destination page to flash */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FLASH_INDEX_WRITE, page);
+	if (rc)
+		goto finish;
+
+	/* Set filling pattern */
+	rc = zl3073x_write_u32(zldev, ZL_REG_FILL_PATTERN, U32_MAX);
+	if (rc)
+		goto finish;
+
+	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, 0,
+				     size);
+
+	/* Execute sectors flash operation */
+	rc = zl3073x_flash_cmd_wait(zldev, ZL_WRITE_FLASH_OP_PAGE, extack);
+	if (rc)
+		goto finish;
+
+	zl3073x_devlink_flash_notify(zldev, "Flashing image", component, size,
+				     size);
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
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "Failed to copy page %u to page %u", src_page,
+				 dst_page);
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
+	/* Read host control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_HOST_CONTROL, &host_ctrl);
+	if (rc)
+		return rc;
+
+	/* Enable host control */
+	host_ctrl &= ~ZL_HOST_CONTROL_ENABLE;
+	host_ctrl |= ZL_HOST_CONTROL_ENABLE;
+
+	/* Update host control register */
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
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "cannot execute pre-load sequence");
+		goto error;
+	}
+
+	/* Download utility image to device memory */
+	rc = zl3073x_flash_download(zldev, "utility", 0x20000000, util_ptr,
+				    util_size, extack);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "cannot download flash utility");
+		goto error;
+	}
+
+	/* Execute post-load sequence */
+	rc = zl3073x_write_hwreg_seq(zldev, post_seq, ARRAY_SIZE(post_seq));
+	if (rc) {
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "cannot execute post-load sequence");
+		goto error;
+	}
+
+	/* Check that utility identifies itself correctly */
+	rc = zl3073x_flash_mode_verify(zldev);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(zldev, extack, "flash utility check failed");
+		goto error;
+	}
+
+	/* Enable host control */
+	rc = zl3073x_flash_host_ctrl_enable(zldev);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(zldev, extack, "cannot enable host control");
+		goto error;
+	}
+
+	zl3073x_devlink_flash_notify(zldev, "Flash mode enabled", "utility",
+				     0, 0);
+
+	return 0;
+
+error:
+	rc = zl3073x_flash_mode_leave(zldev, extack);
+	if (rc)
+		ZL_FLASH_ERR_MSG(zldev, extack,
+				 "failed to switch back to normal mode");
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


