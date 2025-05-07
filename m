Return-Path: <netdev+bounces-188619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4563AADF8B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114A83B9759
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FA284B3B;
	Wed,  7 May 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeM+BgCu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3D284674
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621886; cv=none; b=hILJ/bVeZQDAPZyZwBPA+Pg1dbfTGgCw+zecQaM4mqSZ8Fhf4vCmVxocDiXyZ9K5EeZwGerOCZRdpcpefBXdwRPEtDSb8KfwA7oTURiFflBuiuV5B740vREAOWA8DiKTJdlmHcKSfDUodCCFrgH1z+NyOPW3MeTNitGrvFLM41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621886; c=relaxed/simple;
	bh=1GKVhGZIeSHrSFM1p8A1ycOlC+iuZov0PlsyJeC6Fh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+mUvTSOkWV5pJlMotGjTTkfkTHvPHTIzDphiZ9SVZNcnkdkuiph4WhFB9oyP88/u8kkxJ+R+6W0uJNEMKsB5eGTlytRS2O5b8H52LebSVr9cwqcK8VD74ycwodxffXMvfP1T4kphBPYQ5leMN49MBjqlyj4VEq5wvWIBAV1D38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeM+BgCu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746621882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XulpVzxDO61vMU5Om1r000qWddaCZ+Y+tGIvosGypbI=;
	b=KeM+BgCu0P0TklYY7vrhHG8Z0pw0iGFaOTSkO5IqhmMCo88gbPogVZ6jFDJTzNu8s3oBBk
	tGAIQTRBhiE9D4gptJyT2nRUs1Gs+PzM/uTbXmVZmNogv2I36VvGRNa5d8o3qkJZfd8uAM
	/PtWVgEaUPyvTJSdFWqrekGGA9iSvqg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HMrLiIHsPGS_uVXPrbzRAQ-1; Wed,
 07 May 2025 08:44:38 -0400
X-MC-Unique: HMrLiIHsPGS_uVXPrbzRAQ-1
X-Mimecast-MFC-AGG-ID: HMrLiIHsPGS_uVXPrbzRAQ_1746621876
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D55F19560AA;
	Wed,  7 May 2025 12:44:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E9CC19560A7;
	Wed,  7 May 2025 12:44:30 +0000 (UTC)
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
Subject: [PATCH net-next v7 4/8] mfd: zl3073x: Add support for devlink device info
Date: Wed,  7 May 2025 14:43:54 +0200
Message-ID: <20250507124358.48776-5-ivecera@redhat.com>
In-Reply-To: <20250507124358.48776-1-ivecera@redhat.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use devlink_alloc() to allocate zl3073x_dev structure, register
the device as a devlink device, and add devlink callback to provide
device info.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
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


