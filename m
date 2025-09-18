Return-Path: <netdev+bounces-212475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F13B20C4A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E302B7A8F04
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704A2E0917;
	Mon, 11 Aug 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bh9u+QdW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821152DE6EF
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923238; cv=none; b=QHShqyJJhjrhjQ7iqFUGusDKurk2KDNEQk66IDd3qeYO1+VWVM6h+okJ8K4BdkecHe3RSeLM/fnKUMgvW337gNJvshHQklYmkw6G5CJlrFAWYotDAMmdhGT+Nxgthw1DltEYsmEFTH3Q9yYoQ4MC6LxDGNh4gFV44B9ZhLDIyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923238; c=relaxed/simple;
	bh=dq0KAotgaGHjCti+dx5ivStThdo8gwQxQK4PT3dNJIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2FN2Nz33J2UvFUU63NRsDNcyydDMpcJVt+EMRVF+lPgMg/T62TRScZ8aCh/suUquPj1D88T97lJ/QGet8eNT17z0iRf7BxQH/b7K4UEHGfMFfs9D7LAnyy/IOHiNv2MMeiaOaniRnj2uK/QvDfjvP2M9+Lk3qYw0xINiLELTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bh9u+QdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9dUv7a2kjXQ2A7K4Ae5EG2RRH4Y9mHE/r4WqLxSD0Q=;
	b=bh9u+QdWPl6vdcBR/GUJQT58QCeYKu6Z3yEV6+jqQIcZnlT0ShfK6Rbm2M9MGn/IHh0ayy
	T8XTc1duGqaKV9O3BrX230ihEj4BwF87sf9OybYuiuZhVlm0wT6DexGqJxYQag0A+0wBZt
	6E8QIH3ZfKnNWUgi36vbVUu8zkh6Cvk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-Kk4JRd1HNWu393XIIu6w_Q-1; Mon,
 11 Aug 2025 10:40:31 -0400
X-MC-Unique: Kk4JRd1HNWu393XIIu6w_Q-1
X-Mimecast-MFC-AGG-ID: Kk4JRd1HNWu393XIIu6w_Q_1754923229
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B39A818004A7;
	Mon, 11 Aug 2025 14:40:29 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.225.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78C69300145B;
	Mon, 11 Aug 2025 14:40:25 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/5] dpll: zl3073x: Add firmware loading functionality
Date: Mon, 11 Aug 2025 16:40:07 +0200
Message-ID: <20250811144009.2408337-4-ivecera@redhat.com>
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

Add functionality for loading firmware files provided by the vendor
to be flashed into the device's internal flash memory. The firmware
consists of several components, such as the firmware executable itself,
chip-specific customizations, and configuration files.

The firmware file contains at least a flash utility, which is executed
on the device side, and one or more flashable components. Each component
has its own specific properties, such as the address where it should be
loaded during flashing, one or more destination flash pages, and
the flashing method that should be used.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* added additional includes
* removed empty line
* '*(dst+len)' -> '*(dst + len)'
* 'Santity' -> 'Sanity'
* fixed smatch warning about uninitialized 'rc'
---
 drivers/dpll/zl3073x/Makefile |   2 +-
 drivers/dpll/zl3073x/fw.c     | 498 ++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/fw.h     |  52 ++++
 3 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dpll/zl3073x/fw.c
 create mode 100644 drivers/dpll/zl3073x/fw.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index 9894513f67dd3..84e22aae57e5f 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
-zl3073x-objs			:= core.o devlink.o dpll.o flash.o prop.o
+zl3073x-objs			:= core.o devlink.o dpll.o flash.o fw.o prop.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
new file mode 100644
index 0000000000000..5599b075bdf83
--- /dev/null
+++ b/drivers/dpll/zl3073x/fw.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/netlink.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "flash.h"
+#include "fw.h"
+
+#define ZL3073X_FW_ERR_PFX "FW load failed: "
+#define ZL3073X_FW_ERR_MSG(_zldev, _extack, _msg, ...)			\
+	do {								\
+		dev_err((_zldev)->dev, ZL3073X_FW_ERR_PFX _msg "\n",	\
+			## __VA_ARGS__);				\
+		NL_SET_ERR_MSG_FMT_MOD((_extack),			\
+				       ZL3073X_FW_ERR_PFX _msg,		\
+				       ## __VA_ARGS__);			\
+	} while (0)
+
+enum zl3073x_flash_type {
+	ZL3073X_FLASH_TYPE_NONE = 0,
+	ZL3073X_FLASH_TYPE_SECTORS,
+	ZL3073X_FLASH_TYPE_PAGE,
+	ZL3073X_FLASH_TYPE_PAGE_AND_COPY,
+};
+
+struct zl3073x_fw_component_info {
+	const char		*name;
+	size_t			max_size;
+	enum zl3073x_flash_type	flash_type;
+	u32			load_addr;
+	u32			dest_page;
+	u32			copy_page;
+};
+
+static const struct zl3073x_fw_component_info component_info[] = {
+	[ZL_FW_COMPONENT_UTIL] = {
+		.name		= "utility",
+		.max_size	= 0x2300,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_NONE,
+	},
+	[ZL_FW_COMPONENT_FW1] = {
+		.name		= "firmware1",
+		.max_size	= 0x35000,
+		.load_addr	= 0x20002000,
+		.flash_type	= ZL3073X_FLASH_TYPE_SECTORS,
+		.dest_page	= 0x020,
+	},
+	[ZL_FW_COMPONENT_FW2] = {
+		.name		= "firmware2",
+		.max_size	= 0x0040,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE_AND_COPY,
+		.dest_page	= 0x3e0,
+		.copy_page	= 0x000,
+	},
+	[ZL_FW_COMPONENT_FW3] = {
+		.name		= "firmware3",
+		.max_size	= 0x0248,
+		.load_addr	= 0x20000400,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE_AND_COPY,
+		.dest_page	= 0x3e4,
+		.copy_page	= 0x004,
+	},
+	[ZL_FW_COMPONENT_CFG0] = {
+		.name		= "config0",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x3d0,
+	},
+	[ZL_FW_COMPONENT_CFG1] = {
+		.name		= "config1",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x3c0,
+	},
+	[ZL_FW_COMPONENT_CFG2] = {
+		.name		= "config2",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x3b0,
+	},
+	[ZL_FW_COMPONENT_CFG3] = {
+		.name		= "config3",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x3a0,
+	},
+	[ZL_FW_COMPONENT_CFG4] = {
+		.name		= "config4",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x390,
+	},
+	[ZL_FW_COMPONENT_CFG5] = {
+		.name		= "config5",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x380,
+	},
+	[ZL_FW_COMPONENT_CFG6] = {
+		.name		= "config6",
+		.max_size	= 0x1000,
+		.load_addr	= 0x20000000,
+		.flash_type	= ZL3073X_FLASH_TYPE_PAGE,
+		.dest_page	= 0x370,
+	},
+};
+
+/* Sanity check */
+static_assert(ARRAY_SIZE(component_info) == ZL_FW_NUM_COMPONENTS);
+
+/**
+ * zl3073x_fw_readline - Read next line from firmware
+ * @dst: destination buffer
+ * @dst_sz: destination buffer size
+ * @psrc: source buffer
+ * @psrc_sz: source buffer size
+ *
+ * The function read next line from the firmware buffer specified by @psrc
+ * and @psrc_sz and stores it into buffer specified by @dst and @dst_sz.
+ * The pointer @psrc and remaining bytes in @psrc_sz are updated accordingly.
+ *
+ * Return: number of characters read on success, -EINVAL on error
+ */
+static ssize_t
+zl3073x_fw_readline(char *dst, size_t dst_sz, const char **psrc,
+		    size_t *psrc_sz)
+{
+	const char *ptr = *psrc;
+	size_t len;
+
+	/* Skip any existing new-lines at the beginning */
+	ptr = memchr_inv(*psrc, '\n', *psrc_sz);
+	if (ptr) {
+		*psrc_sz -= ptr - *psrc;
+		*psrc = ptr;
+	}
+
+	/* Now look for the next new-line in the source */
+	ptr = memscan((void *)*psrc, '\n', *psrc_sz);
+	len = ptr - *psrc;
+
+	/* Return error if the source line is too long for destination */
+	if (len >= dst_sz)
+		return -EINVAL;
+
+	/* Copy the line from source and append NUL char  */
+	memcpy(dst, *psrc, len);
+	*(dst + len) = '\0';
+
+	*psrc = ptr;
+	*psrc_sz -= len;
+
+	/* Return number of read chars */
+	return len;
+}
+
+/**
+ * zl3073x_fw_component_alloc - Alloc structure to hold firmware component
+ * @size: size of buffer to store data
+ *
+ * Return: pointer to allocated component structure or NULL on error.
+ */
+static struct zl3073x_fw_component *
+zl3073x_fw_component_alloc(size_t size)
+{
+	struct zl3073x_fw_component *comp;
+
+	comp = kzalloc(sizeof(*comp), GFP_KERNEL);
+	if (!comp)
+		return NULL;
+
+	comp->size = size;
+	comp->data = kzalloc(size, GFP_KERNEL);
+	if (!comp->data) {
+		kfree(comp);
+		return NULL;
+	}
+
+	return comp;
+}
+
+/**
+ * zl3073x_fw_component_free - Free allocated component structure
+ * @comp: pointer to allocated component
+ */
+static void
+zl3073x_fw_component_free(struct zl3073x_fw_component *comp)
+{
+	if (comp)
+		kfree(comp->data);
+
+	kfree(comp);
+}
+
+/**
+ * zl3073x_fw_component_id_get - Get ID for firmware component name
+ * @name: input firmware component name
+ *
+ * Return:
+ * - ZL3073X_FW_COMPONENT_* ID for known component name
+ * - ZL3073X_FW_COMPONENT_INVALID if the given name is unknown
+ */
+static enum zl3073x_fw_component_id
+zl3073x_fw_component_id_get(const char *name)
+{
+	enum zl3073x_fw_component_id id;
+
+	for (id = ZL_FW_COMPONENT_UTIL; id < ZL_FW_NUM_COMPONENTS; id++)
+		if (!strcasecmp(name, component_info[id].name))
+			return id;
+
+	return ZL_FW_COMPONENT_INVALID;
+}
+
+/**
+ * zl3073x_fw_component_load - Load component from firmware source
+ * @zldev: zl3073x device structure
+ * @pcomp: pointer to loaded component
+ * @psrc: data pointer to load component from
+ * @psize: remaining bytes in buffer
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function allocates single firmware component and loads the data from
+ * the buffer specified by @psrc and @psize. Pointer to allocated component
+ * is stored in output @pcomp. Source data pointer @psrc and remaining bytes
+ * @psize are updated accordingly.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static ssize_t
+zl3073x_fw_component_load(struct zl3073x_dev *zldev,
+			  struct zl3073x_fw_component **pcomp,
+			  const char **psrc, size_t *psize,
+			  struct netlink_ext_ack *extack)
+{
+	const struct zl3073x_fw_component_info *info;
+	struct zl3073x_fw_component *comp = NULL;
+	struct device *dev = zldev->dev;
+	enum zl3073x_fw_component_id id;
+	ssize_t len, count;
+	u32 comp_size;
+	char line[32];
+	int rc;
+
+	/* Fetch image name from input */
+	len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
+	if (len < 0) {
+		rc = len;
+		goto err_unexpected;
+	} else if (!len) {
+		/* No more data */
+		return 0;
+	}
+
+	dev_dbg(dev, "Firmware component '%s' found\n", line);
+
+	id = zl3073x_fw_component_id_get(line);
+	if (id == ZL_FW_COMPONENT_INVALID) {
+		ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] unknown component type",
+				   line);
+		return -EINVAL;
+	}
+
+	info = &component_info[id];
+
+	/* Fetch image size from input */
+	len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
+	if (len < 0) {
+		rc = len;
+		goto err_unexpected;
+	} else if (!len) {
+		ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing size",
+				   info->name);
+		return -ENODATA;
+	}
+
+	rc = kstrtou32(line, 10, &comp_size);
+	if (rc) {
+		ZL3073X_FW_ERR_MSG(zldev, extack,
+				   "[%s] invalid size value '%s'", info->name,
+				   line);
+		return rc;
+	}
+
+	comp_size *= sizeof(u32); /* convert num of dwords to bytes */
+
+	/* Check image size validity */
+	if (comp_size > component_info[id].max_size) {
+		ZL3073X_FW_ERR_MSG(zldev, extack,
+				   "[%s] component is too big (%u bytes)\n",
+				   info->name, comp_size);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "Indicated component image size: %u bytes\n", comp_size);
+
+	/* Alloc component */
+	comp = zl3073x_fw_component_alloc(comp_size);
+	if (!comp) {
+		ZL3073X_FW_ERR_MSG(zldev, extack, "failed to alloc memory");
+		return -ENOMEM;
+	}
+	comp->id = id;
+
+	/* Load component data from firmware source */
+	for (count = 0; count < comp_size; count += 4) {
+		len = zl3073x_fw_readline(line, sizeof(line), psrc, psize);
+		if (len < 0) {
+			rc = len;
+			goto err_unexpected;
+		} else if (!len) {
+			ZL3073X_FW_ERR_MSG(zldev, extack, "[%s] missing data",
+					   info->name);
+			rc = -ENODATA;
+			goto err;
+		}
+
+		rc = kstrtou32(line, 16, comp->data + count);
+		if (rc) {
+			ZL3073X_FW_ERR_MSG(zldev, extack,
+					   "[%s] invalid data: '%s'",
+					   info->name, line);
+			goto err;
+		}
+	}
+
+	*pcomp = comp;
+
+	return 1;
+
+err_unexpected:
+	ZL3073X_FW_ERR_MSG(zldev, extack, "unexpected input");
+err:
+	zl3073x_fw_component_free(comp);
+
+	return rc;
+}
+
+/**
+ * zl3073x_fw_free - Free allocated firmware
+ * @fw: firmware pointer
+ *
+ * The function frees existing firmware allocated by @zl3073x_fw_load.
+ */
+void zl3073x_fw_free(struct zl3073x_fw *fw)
+{
+	size_t i;
+
+	if (!fw)
+		return;
+
+	for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++)
+		zl3073x_fw_component_free(fw->component[i]);
+
+	kfree(fw);
+}
+
+/**
+ * zl3073x_fw_load - Load all components from source
+ * @zldev: zl3073x device structure
+ * @data: source buffer pointer
+ * @size: size of source buffer
+ * @extack: netlink extack pointer to report errors
+ *
+ * The functions allocate firmware structure and loads all components from
+ * the given buffer specified by @data and @size.
+ *
+ * Return: pointer to firmware on success, error pointer on error
+ */
+struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
+				   size_t size, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_fw_component *comp;
+	enum zl3073x_fw_component_id id;
+	struct zl3073x_fw *fw;
+	ssize_t rc;
+
+	/* Allocate firmware structure */
+	fw = kzalloc(sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return ERR_PTR(-ENOMEM);
+
+	do {
+		/* Load single component */
+		rc = zl3073x_fw_component_load(zldev, &comp, &data, &size,
+					       extack);
+		if (rc <= 0)
+			/* Everything was read or error occurred */
+			break;
+
+		id = comp->id;
+
+		/* Report error if the given component is present twice
+		 * or more.
+		 */
+		if (fw->component[id]) {
+			ZL3073X_FW_ERR_MSG(zldev, extack,
+					   "duplicate component '%s' detected",
+					   component_info[id].name);
+			zl3073x_fw_component_free(comp);
+			rc = -EINVAL;
+			break;
+		}
+
+		fw->component[id] = comp;
+	} while (1);
+
+	if (rc) {
+		/* Free allocated firmware in case of error */
+		zl3073x_fw_free(fw);
+		return ERR_PTR(rc);
+	}
+
+	return fw;
+}
+
+/**
+ * zl3073x_flash_bundle_flash - Flash all components
+ * @zldev: zl3073x device structure
+ * @components: pointer to components array
+ * @extack: netlink extack pointer to report errors
+ *
+ * Returns 0 in case of success or negative number otherwise.
+ */
+static int
+zl3073x_fw_component_flash(struct zl3073x_dev *zldev,
+			   struct zl3073x_fw_component *comp,
+			   struct netlink_ext_ack *extack)
+{
+	const struct zl3073x_fw_component_info *info;
+	int rc;
+
+	info = &component_info[comp->id];
+
+	switch (info->flash_type) {
+	case ZL3073X_FLASH_TYPE_NONE:
+		/* Non-flashable component - used for utility */
+		return 0;
+	case ZL3073X_FLASH_TYPE_SECTORS:
+		rc = zl3073x_flash_sectors(zldev, info->name, info->dest_page,
+					   info->load_addr, comp->data,
+					   comp->size, extack);
+		break;
+	case ZL3073X_FLASH_TYPE_PAGE:
+		rc = zl3073x_flash_page(zldev, info->name, info->dest_page,
+					info->load_addr, comp->data, comp->size,
+					extack);
+		break;
+	case ZL3073X_FLASH_TYPE_PAGE_AND_COPY:
+		rc = zl3073x_flash_page(zldev, info->name, info->dest_page,
+					info->load_addr, comp->data, comp->size,
+					extack);
+		if (!rc)
+			rc = zl3073x_flash_page_copy(zldev, info->name,
+						     info->dest_page,
+						     info->copy_page, extack);
+		break;
+	}
+	if (rc)
+		ZL3073X_FW_ERR_MSG(zldev, extack,
+				   "Failed to flash component '%s'",
+				   info->name);
+
+	return rc;
+}
+
+int zl3073x_fw_flash(struct zl3073x_dev *zldev, struct zl3073x_fw *zlfw,
+		     struct netlink_ext_ack *extack)
+{
+	int i, rc = 0;
+
+	for (i = 0; i < ZL_FW_NUM_COMPONENTS; i++) {
+		if (!zlfw->component[i])
+			continue; /* Component is not present */
+
+		rc = zl3073x_fw_component_flash(zldev, zlfw->component[i],
+						extack);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
diff --git a/drivers/dpll/zl3073x/fw.h b/drivers/dpll/zl3073x/fw.h
new file mode 100644
index 0000000000000..242d3f9433a18
--- /dev/null
+++ b/drivers/dpll/zl3073x/fw.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_FW_H
+#define _ZL3073X_FW_H
+
+/*
+ * enum zl3073x_fw_component_id - Identifiers for possible flash components
+ */
+enum zl3073x_fw_component_id {
+	ZL_FW_COMPONENT_INVALID = -1,
+	ZL_FW_COMPONENT_UTIL = 0,
+	ZL_FW_COMPONENT_FW1,
+	ZL_FW_COMPONENT_FW2,
+	ZL_FW_COMPONENT_FW3,
+	ZL_FW_COMPONENT_CFG0,
+	ZL_FW_COMPONENT_CFG1,
+	ZL_FW_COMPONENT_CFG2,
+	ZL_FW_COMPONENT_CFG3,
+	ZL_FW_COMPONENT_CFG4,
+	ZL_FW_COMPONENT_CFG5,
+	ZL_FW_COMPONENT_CFG6,
+	ZL_FW_NUM_COMPONENTS,
+};
+
+/**
+ * struct zl3073x_fw_component - Firmware component
+ * @id: Flash component ID
+ * @size: Size of the buffer
+ * @data: Pointer to buffer with component data
+ */
+struct zl3073x_fw_component {
+	enum zl3073x_fw_component_id	id;
+	size_t				size;
+	void				*data;
+};
+
+/**
+ * struct zl3073x_fw - Firmware bundle
+ * @component: firmware components array
+ */
+struct zl3073x_fw {
+	struct zl3073x_fw_component	*component[ZL_FW_NUM_COMPONENTS];
+};
+
+struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
+				   size_t size, struct netlink_ext_ack *extack);
+void zl3073x_fw_free(struct zl3073x_fw *fw);
+
+int zl3073x_fw_flash(struct zl3073x_dev *zldev, struct zl3073x_fw *zlfw,
+		     struct netlink_ext_ack *extack);
+
+#endif /* _ZL3073X_FW_H */
-- 
2.49.1


