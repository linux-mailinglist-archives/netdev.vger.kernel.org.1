Return-Path: <netdev+bounces-180801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AAFA828A3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ACC177622
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77D268C61;
	Wed,  9 Apr 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z48XenTm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F92268690
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209810; cv=none; b=Hv1AKwvGwPo9sW+B77IdEQhko7y86XU3uPM4iYd+3ctRO4p1f9FtoZVF+tt1znK4FHjMR2po1HiRWxePsRkVQbOunpg2ehsh5szPlZV3q/elFf++264Gd0pKQ6HfqJMIURYIBykVRSDKujr9A2eGzugQP/MGEOCsLTL2ovEXojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209810; c=relaxed/simple;
	bh=kQ9GHfesH0VP3UbX5nxEs6wOWpoqClYTSG7LdtlBlS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI1jtvPyGfJaLIho8ZQCCZ4LXsh5q9kjvG3arCrqv71skK5F4sBawSHNgXIP7IXr6giJhO3d+Sz750iWQ0Vd2X02VZRhinJcijdzgaZDuWJ/zq2lWpMpzmBpcqVLUXbKHElDjleljMOyFkBiGimEotDWcWgRqsJeh8Itp0GsIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z48XenTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcivbUEWC4kBHEWoC8mH97RWcHUUu64DZ8iwYH5064E=;
	b=Z48XenTmHc9u9ITCaKATPnMP2l0gQF0oEw8QgqtnlfkGlyd3j9pey9cRqGOAXF6Ux6urvL
	SAOUf0vI5nS03umD/SWfnBcZBnPg5L2lTmDiGRguTBPpJ/6Dbs8rKdZZKgvB0z5W/hkxVn
	TUyxMX+AVVA9T7AQl4KlT/O6jFVf4tY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-B_um9ZZTMveArSVeNO6W7A-1; Wed,
 09 Apr 2025 10:43:23 -0400
X-MC-Unique: B_um9ZZTMveArSVeNO6W7A-1
X-Mimecast-MFC-AGG-ID: B_um9ZZTMveArSVeNO6W7A_1744209801
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CDBA18007E1;
	Wed,  9 Apr 2025 14:43:21 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3BFD18009BC;
	Wed,  9 Apr 2025 14:43:16 +0000 (UTC)
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
Subject: [PATCH v2 05/14] mfd: zl3073x: Add register access helpers
Date: Wed,  9 Apr 2025 16:42:41 +0200
Message-ID: <20250409144250.206590-6-ivecera@redhat.com>
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

Add helpers zl3073x_{read,write}_reg() to access device registers.
These functions have to be called with device lock that can be taken
by zl3073x_{lock,unlock}() or a caller can use defined guard.

Locking mechanism of regmap is not sufficient because sometimes is
necessary to perform several register operations at once. This is
especially a case of register mailboxes (more details in patch 7 & 8).
Disable regmap locking mechanism and use this device lock instead.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v2:
* disabled regmap locking
---
 drivers/mfd/zl3073x-core.c  | 90 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h | 33 ++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 116c6dd9eebc7..f0d85f77a7a76 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -5,9 +5,11 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/lockdep.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/unaligned.h>
 #include <net/devlink.h>
 #include "zl3073x.h"
 
@@ -46,6 +48,7 @@ const struct regmap_config zl3073x_regmap_config = {
 	.max_register		= ZL3073x_NUM_PAGES * ZL3073x_PAGE_SIZE,
 	.ranges			= zl3073x_regmap_ranges,
 	.num_ranges		= ARRAY_SIZE(zl3073x_regmap_ranges),
+	.disable_locking	= true,
 };
 
 /**
@@ -59,6 +62,93 @@ const struct regmap_config *zl3073x_get_regmap_config(void)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
 
+/**
+ * zl3073x_read_reg - Read value from device register
+ * @zldev: pointer to zl3073x device
+ * @reg: register to be read
+ * @len: number of bytes to read
+ * @value: pointer to place to store value read from the register
+ *
+ * Caller has to hold the device lock that can be obtained
+ * by zl3073x_lock().
+ *
+ * Return: 0 on success or <0 on error
+ */
+int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		     unsigned int len, void *value)
+{
+	u8 buf[6];
+	int rc;
+
+	lockdep_assert_held(&zldev->lock);
+
+	rc = regmap_bulk_read(zldev->regmap, reg, buf, len);
+	if (rc)
+		return rc;
+
+	switch (len) {
+	case 1:
+		*(u8 *)value = buf[0];
+		break;
+	case 2:
+		*(u16 *)value = get_unaligned_be16(buf);
+		break;
+	case 4:
+		*(u32 *)value = get_unaligned_be32(buf);
+		break;
+	case 6:
+		*(u64 *)value = get_unaligned_be48(buf);
+		break;
+	default:
+		WARN(true, "Unsupported register size: %u\n", len);
+		break;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(zl3073x_read_reg);
+
+/**
+ * zl3073x_write_reg - Write value to device register
+ * @zldev: pointer to zl3073x device
+ * @reg: register to be written
+ * @len: number of bytes to write
+ * @value: pointer to value to write to the register
+ *
+ * Caller has to hold the device lock that can be obtained
+ * by zl3073x_lock().
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		      unsigned int len, const void *value)
+{
+	u8 buf[6];
+
+	lockdep_assert_held(&zldev->lock);
+
+	switch (len) {
+	case 1:
+		buf[0] = *(u8 *)value;
+		break;
+	case 2:
+		put_unaligned_be16(*(u16 *)value, buf);
+		break;
+	case 4:
+		put_unaligned_be32(*(u32 *)value, buf);
+		break;
+	case 6:
+		put_unaligned_be48(*(u64 *)value, buf);
+		break;
+	default:
+		WARN(true, "Unsupported register size: %u\n", len);
+		break;
+	}
+
+	return regmap_bulk_write(zldev->regmap, reg, buf, len);
+}
+EXPORT_SYMBOL_GPL(zl3073x_write_reg);
+
 static const struct devlink_ops zl3073x_devlink_ops = {
 };
 
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index f3f33ef8bfa18..00dcc73aeeb34 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_MFD_ZL3073X_H
 #define __LINUX_MFD_ZL3073X_H
 
+#include <linux/cleanup.h>
 #include <linux/mutex.h>
 
 struct device;
@@ -20,4 +21,36 @@ struct zl3073x_dev {
 	struct mutex		lock;
 };
 
+/**
+ * zl3073x_lock - Lock the device
+ * @zldev: device structure pointer
+ *
+ * Caller has to take this lock when it needs to access device registers.
+ */
+static inline void zl3073x_lock(struct zl3073x_dev *zldev)
+{
+	mutex_lock(&zldev->lock);
+}
+
+/**
+ * zl3073x_unlock - Unlock the device
+ * @zldev: device structure pointer
+ *
+ * Caller unlocks the device when it does not need to access device
+ * registers anymore.
+ */
+static inline void zl3073x_unlock(struct zl3073x_dev *zldev)
+{
+	mutex_unlock(&zldev->lock);
+}
+
+DEFINE_GUARD(zl3073x, struct zl3073x_dev *, zl3073x_lock(_T),
+	     zl3073x_unlock(_T));
+
+int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		     unsigned int len, void *value);
+
+int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
+		      unsigned int len, const void *value);
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1


