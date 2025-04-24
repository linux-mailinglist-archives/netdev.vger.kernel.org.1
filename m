Return-Path: <netdev+bounces-185632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51AA9B2E3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC9163609
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DB92820BD;
	Thu, 24 Apr 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5dqWpe0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FD27F74E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509680; cv=none; b=td/A5LjiDOF7nfONnZmN6ksIMoE47MN2W8BemoJjAwP5O+iut545WxOeHfrjzT1QUvoSA4ybST8ebfIsMYycFYmHZaPvq+OkyS1iyOQcJjXpKKmI+DFmPGbHbonT2AUtPegVCF/tsvOngRt3LvcawaLkEOr/XnWu+9qP+d2iO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509680; c=relaxed/simple;
	bh=GFEaRbrbNgv7J6aJRigp6IKeFfA7bHGQDdr/KCGjM0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6o00bFEj60mbAUt3QZq+kggRnSm4sQ990IafsUwoxwoh7acznwDhz/lzrLHP5jw/gUDSljDW+Wv1dEe7XW5VEF3HMECFvZV1+qGiRX3uri6UdFTLjuGpq55Qj6VDx2A5KrRR8eZBlvdhItCt4lj0CPZZ4wJR2Bm/C8LfSM7xSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5dqWpe0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i7qEDnvSNFpBeLdwrx62R+GLGtS6F6wI724h9o5XIEU=;
	b=R5dqWpe08qkUsJX4SV6guH02oFF8gpnKRVqyxraXWu+kvjKoy3ZLMwy8aJUNpnYKsD0N7s
	lHXUtSUZ37ejmEpV9GKcvNh4O5+1Y1HoAXG+f5RTIsFGE04weP2CNx2htjx3Pu3pQJXbEj
	isrKOM3w04VYPKFakUT6tusO/Uw55ek=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-4lVceLhyMDeqgAw9r7GDrg-1; Thu,
 24 Apr 2025 11:47:52 -0400
X-MC-Unique: 4lVceLhyMDeqgAw9r7GDrg-1
X-Mimecast-MFC-AGG-ID: 4lVceLhyMDeqgAw9r7GDrg_1745509670
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39F271956096;
	Thu, 24 Apr 2025 15:47:50 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EF7C19560A3;
	Thu, 24 Apr 2025 15:47:45 +0000 (UTC)
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
Subject: [PATCH net-next v4 4/8] mfd: zl3073x: Add support for devlink device info
Date: Thu, 24 Apr 2025 17:47:18 +0200
Message-ID: <20250424154722.534284-5-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Use devlink_alloc() to allocate zl3073x_dev structure, register
the device as a devlink device, and add devlink callback to provide
device info.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* pass error code from devm_add_action_or_reset() call

v2->v3:
* merged devlink device allocation, registration and device info
  callback

v1->v2:
* dependency on NET moved to MFD_ZL3073X_CORE in Kconfig
* devlink register managed way
---
 drivers/mfd/Kconfig        |   2 +
 drivers/mfd/zl3073x-core.c | 108 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7d7902ec1d89a..e4eca15af175d 100644
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
index f30091ae48eca..28cc25b7412e9 100644
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
 
@@ -167,6 +170,83 @@ zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg, void *val)
 	return rc;
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
+	rc = zl3073x_read_reg(zldev, ZL_REG_ID, &id);
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
+	rc = zl3073x_read_reg(zldev, ZL_REG_REVISION, &revision);
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
+	rc = zl3073x_read_reg(zldev, ZL_REG_FW_VER, &fw_ver);
+	if (rc)
+		return rc;
+
+	snprintf(buf, sizeof(buf), "%u", fw_ver);
+	rc = devlink_info_version_fixed_put(req,
+					    DEVLINK_INFO_VERSION_GENERIC_FW,
+					    buf);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_reg(zldev, ZL_REG_CUSTOM_CONFIG_VER, &cfg_ver);
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
@@ -178,11 +258,19 @@ zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg, void *val)
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
 
@@ -202,6 +290,11 @@ void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg)
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
@@ -215,6 +308,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		      const struct zl3073x_chip_info *chip_info)
 {
 	u16 id, revision, fw_ver;
+	struct devlink *devlink;
 	unsigned int i;
 	u32 cfg_ver;
 	int rc;
@@ -255,6 +349,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
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


