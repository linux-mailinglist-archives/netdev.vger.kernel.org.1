Return-Path: <netdev+bounces-202269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91832AECFEB
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A09D3A9D2C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966123D2BB;
	Sun, 29 Jun 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFrdLAhA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC223AE83
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751224298; cv=none; b=bioAJX3H7XPjcAp0kWZRtcptIlwKmSF0Ukc67rtGK032sw4taWYjqSl1PeJjtE0d2Up8LaYlGv2x0Okk61X8tsJMl7KAgWBQA+SzJLiGdu3Ld4HZALKK3KgWRYDjzzrYWZncqh+cTBtKIvjehL85dweeHyFIbP44qsSX+wqa8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751224298; c=relaxed/simple;
	bh=jFVihXMltNq4Rf690+c5lKfSlVhTE9PM2v97vzC1cOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBjWHC4lBrkMfrFC3YswT9V2Gu4l1sia931Y7UcgLgLuspJ16/L2FlD2GTFwVBwtQeusjJQ5vV2z6JbMFX7obGASN9cQrijFcyL8IEXMqqjlWk0qqt/2T4NjkWgYiqfBGcpcoi5Ni4SGCnw+fJz+/m357ckH9+FD9dC5OoPvGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFrdLAhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751224294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgiP0K2H++JM1ku4nOOk9vX4Ksz86TNRe6ZkTVl/LUE=;
	b=XFrdLAhAxb6RdcwHxBa71i7l96Z1DzJJ5+1J7YWncAczeZa40of5yAG8IisWuXeTXNw/L+
	jy4O8r7apGeTfYhdmf+HeFVOhA2qm/wMvGqhGXf0idYRzNQEY68dBEX/KuXhKMR3RtxP5d
	0GGZc0T69IV+EO9hozQeq5ZkMJkjAf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-pLjcc0-PNau6xuaK1fowUQ-1; Sun,
 29 Jun 2025 15:11:31 -0400
X-MC-Unique: pLjcc0-PNau6xuaK1fowUQ-1
X-Mimecast-MFC-AGG-ID: pLjcc0-PNau6xuaK1fowUQ_1751224288
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCEBA1801BD8;
	Sun, 29 Jun 2025 19:11:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50DE2180045B;
	Sun, 29 Jun 2025 19:11:22 +0000 (UTC)
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
Subject: [PATCH net-next v12 04/14] dpll: zl3073x: Add support for devlink device info
Date: Sun, 29 Jun 2025 21:10:39 +0200
Message-ID: <20250629191049.64398-5-ivecera@redhat.com>
In-Reply-To: <20250629191049.64398-1-ivecera@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use devlink_alloc() to allocate zl3073x_dev structure, register
the device as a devlink device, and add devlink callback to provide
device info.

Sample output:
 # devlink dev info
 i2c/1-0070:
   driver zl3073x-i2c
   versions:
       fixed:
         asic.id 1E94
         asic.rev 300
       running:
         fw 7006

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/zl3073x.rst |  37 +++++++
 drivers/dpll/zl3073x/Kconfig                 |   2 +
 drivers/dpll/zl3073x/core.c                  | 108 ++++++++++++++++++-
 4 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/networking/devlink/zl3073x.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933d..250ae71f40236 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -98,3 +98,4 @@ parameters, info versions, and other features it supports.
    iosm
    octeontx2
    sfc
+   zl3073x
diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
new file mode 100644
index 0000000000000..9a6744fb2e866
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
diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 217160df0f49a..8f3056b727aa0 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -2,7 +2,9 @@
 
 config ZL3073X
 	tristate "Microchip Azurite DPLL/PTP/SyncE devices"
+	depends on NET
 	select DPLL
+	select NET_DEVLINK
 	help
 	  This driver supports Microchip Azurite DPLL/PTP/SyncE devices.
 
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index e26b17ccbaaf2..f43e463142435 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -7,8 +7,11 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/netlink.h>
 #include <linux/regmap.h>
+#include <linux/sprintf.h>
 #include <linux/unaligned.h>
+#include <net/devlink.h>
 
 #include "core.h"
 #include "regs.h"
@@ -373,6 +376,83 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
 					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
 }
 
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
@@ -384,11 +464,19 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
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
 
@@ -396,6 +484,11 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
 
+static void zl3073x_devlink_unregister(void *ptr)
+{
+	devlink_unregister(ptr);
+}
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -409,6 +502,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		      const struct zl3073x_chip_info *chip_info)
 {
 	u16 id, revision, fw_ver;
+	struct devlink *devlink;
 	unsigned int i;
 	u32 cfg_ver;
 	int rc;
@@ -449,6 +543,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
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


