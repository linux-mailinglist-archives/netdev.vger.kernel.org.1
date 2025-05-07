Return-Path: <netdev+bounces-188707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F85AAE4B8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308189A49AF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6528B4E1;
	Wed,  7 May 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxXPt/w+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A628B41A
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631545; cv=none; b=tTxI1op9lotxNwm1UI3neYZ7bjVcj7YHykv/dwWXUDzBobLH2HvY7WCyvo1Isoa5fO9VDrJQGQHVl7D8RUguxYUIcO9kTX6ow5Q03rPTJ+kos/1K4/2UA1yFcilAmmTdCGPtzsPzYZvqao7kcxAL5DzXdejM63J1IuhNUn4/67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631545; c=relaxed/simple;
	bh=ENEzXWYEBJjTirVfpU7httRoblpC7+WrR/GXm7PT2gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy4OV5bfQvfKGsDTAtH7StiLJLKbvuKxfzB84brQPFnHhAx+NwB5KAVjVXrXcmk3qeR0PesU9qJpN8fm3IaoPg7EBP8tWuarWeZPLTmmdq2mwrNqDbabzEhV1uiZk8+63C+yYUpRU7LCX/DKx8VDKajzdZnlPFteMyzM0L6Hlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxXPt/w+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xONwwyT6D9d/VjBVE7MlYwiyn1lyLwt9wh4CqMxdKtg=;
	b=XxXPt/w++PYQz0ELusisV0QBWbL1DBEYzSy0Lmye86G3s3s93ZAkNkXiz1tqgWb7i1kz/O
	XYq7Kk6doKnFkmkv3zi+btpwxtnr8DM4bD1bGc0OOQ4FA9CQ0gLKwade3bbCIBygunBQKP
	YGTPsTCMLH9ztoXPT7kYHe4Pd/Lj8Z8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-2IUiTI0sPCejD9pabJM82g-1; Wed,
 07 May 2025 11:25:38 -0400
X-MC-Unique: 2IUiTI0sPCejD9pabJM82g-1
X-Mimecast-MFC-AGG-ID: 2IUiTI0sPCejD9pabJM82g_1746631536
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAFD91955DEA;
	Wed,  7 May 2025 15:25:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6247B30001A1;
	Wed,  7 May 2025 15:25:31 +0000 (UTC)
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
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v8 4/8] mfd: zl3073x: Add support for devlink device info
Date: Wed,  7 May 2025 17:25:00 +0200
Message-ID: <20250507152504.85341-5-ivecera@redhat.com>
In-Reply-To: <20250507152504.85341-1-ivecera@redhat.com>
References: <20250507152504.85341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Use devlink_alloc() to allocate zl3073x_dev structure, register
the device as a devlink device, and add devlink callback to provide
device info.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v7->v8:
* no change
v6->v7:
* no change
v5->v6:
* fixed devlink info firmware version to be running instead of fixed
* added documentation for devlink info versions

v4->v5:
* use new register access helpers

v3->v4:
* pass error code from devm_add_action_or_reset() call

v2->v3:
* merged devlink device allocation, registration and device info
  callback

v1->v2:
* dependency on NET moved to MFD_ZL3073X_CORE in Kconfig
* devlink register managed way
---
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/zl3073x.rst |  37 +++++++
 drivers/mfd/Kconfig                          |   2 +
 drivers/mfd/zl3073x-core.c                   | 108 ++++++++++++++++++-
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/networking/devlink/zl3073x.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..250ae71f4023 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -98,3 +98,4 @@ parameters, info versions, and other features it supports.
    iosm
    octeontx2
    sfc
+   zl3073x
diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
new file mode 100644
index 000000000000..9a6744fb2e86
--- /dev/null
+++ b/Documentation/networking/devlink/zl3073x.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+zl3073x devlink support
+=======================
+
+This document describes the devlink features implemented by the ``zl3073x``
+device driver.
+
+Info versions
+=============
+
+The ``zl3073x`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``asic.id``
+      - fixed
+      - 1E94
+      - Chip identification number
+    * - ``asic.rev``
+      - fixed
+      - 300
+      - Chip revision number
+    * - ``fw``
+      - running
+      - 7006
+      - Firmware version number
+    * - ``cfg.custom_ver``
+      - running
+      - 1.3.0.1
+      - Device configuration version customized by OEM
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7d7902ec1d89..e4eca15af175 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2424,6 +2424,8 @@ config MFD_UPBOARD_FPGA
 
 config MFD_ZL3073X_CORE
 	tristate
+	depends on NET
+	select NET_DEVLINK
 	select MFD_CORE
 
 config MFD_ZL3073X_I2C
diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index c408aafb0f8a..079550682510 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -8,8 +8,11 @@
 #include <linux/export.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
+#include <linux/netlink.h>
 #include <linux/regmap.h>
+#include <linux/sprintf.h>
 #include <linux/unaligned.h>
+#include <net/devlink.h>
 #include "zl3073x.h"
 #include "zl3073x-regs.h"
 
@@ -375,6 +378,83 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_poll_zero_u8, "ZL3073X");
 
+/**
+ * zl3073x_devlink_info_get - Devlink device info callback
+ * @devlink: devlink structure pointer
+ * @req: devlink request pointer to store information
+ * @extack: netlink extack pointer to report errors
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_devlink_info_get(struct devlink *devlink,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	u16 id, revision, fw_ver;
+	char buf[16];
+	u32 cfg_ver;
+	int rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_ID, &id);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", id);
+	rc = devlink_info_version_fixed_put(req,
+					    DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+					    buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%X", revision);
+	rc = devlink_info_version_fixed_put(req,
+					    DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+					    buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_FW_VER, &fw_ver);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%u", fw_ver);
+	rc = devlink_info_version_running_put(req,
+					      DEVLINK_INFO_VERSION_GENERIC_FW,
+					      buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_CUSTOM_CONFIG_VER, &cfg_ver);
+	if (rc)
+		return rc;
+
+	/* No custom config version */
+	if (cfg_ver == U32_MAX)
+		return 0;
+
+	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
+		 FIELD_GET(GENMASK(31, 24), cfg_ver),
+		 FIELD_GET(GENMASK(23, 16), cfg_ver),
+		 FIELD_GET(GENMASK(15, 8), cfg_ver),
+		 FIELD_GET(GENMASK(7, 0), cfg_ver));
+
+	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);
+}
+
+static const struct devlink_ops zl3073x_devlink_ops = {
+	.info_get = zl3073x_devlink_info_get,
+};
+
+static void zl3073x_devlink_free(void *ptr)
+{
+	devlink_free(ptr);
+}
+
 /**
  * zl3073x_devm_alloc - allocates zl3073x device structure
  * @dev: pointer to device structure
@@ -386,11 +466,19 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_poll_zero_u8, "ZL3073X");
 struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
 {
 	struct zl3073x_dev *zldev;
+	struct devlink *devlink;
+	int rc;
 
-	zldev = devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
-	if (!zldev)
+	devlink = devlink_alloc(&zl3073x_devlink_ops, sizeof(*zldev), dev);
+	if (!devlink)
 		return ERR_PTR(-ENOMEM);
 
+	/* Add devres action to free devlink device */
+	rc = devm_add_action_or_reset(dev, zl3073x_devlink_free, devlink);
+	if (rc)
+		return ERR_PTR(rc);
+
+	zldev = devlink_priv(devlink);
 	zldev->dev = dev;
 	dev_set_drvdata(zldev->dev, zldev);
 
@@ -410,6 +498,11 @@ void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init_regmap_config, "ZL3073X");
 
+static void zl3073x_devlink_unregister(void *ptr)
+{
+	devlink_unregister(ptr);
+}
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -423,6 +516,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		      const struct zl3073x_chip_info *chip_info)
 {
 	u16 id, revision, fw_ver;
+	struct devlink *devlink;
 	unsigned int i;
 	u32 cfg_ver;
 	int rc;
@@ -463,6 +557,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Register the device as devlink device */
+	devlink = priv_to_devlink(zldev);
+	devlink_register(devlink);
+
+	/* Add devres action to unregister devlink device */
+	rc = devm_add_action_or_reset(zldev->dev, zl3073x_devlink_unregister,
+				      devlink);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_probe, "ZL3073X");
-- 
2.49.0


