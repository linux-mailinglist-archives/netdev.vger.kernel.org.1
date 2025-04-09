Return-Path: <netdev+bounces-180800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D984BA828A2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD13717236D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4C268C7D;
	Wed,  9 Apr 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DddGgENY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C55268C40
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209805; cv=none; b=dtPukUCeFCOcf5daKfWUSVSxvmYvXTIqMoJx1hkexzbAHaNExLPcKG/0hmGgX5qmC8Poe66smwBw2PEQu5EZfR+GrxeF8OgFFlvZBXX5JLTAVsKUOmvOMLMtSI9G/HPq85IwZElm2AMXtMSqifTLuUIDrnnj1zDboBuej0hx1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209805; c=relaxed/simple;
	bh=cyVWJiESR6+ddF3hk2p72+BYjghIjU6b3CLJ4+lQg0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu1XD9HDWDNULKbqRGorqfDn769bebeEm4zMmCs/65xXX7hLS0XU/J7WoT5o6vY+2DKalg1OZYpDD992yq9u3qjAz0aNen8k8DBsRfulsJjqELOn8GQghyoXWnHa+T+vi0GRLOMD+VjXnoiVRI4t94njrsZ6xa+SGBPSKeOrAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DddGgENY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPfUA5BWs8R/De+l5pzd9CJqVt44oZhdUA/jGokvVSs=;
	b=DddGgENYIF7Hk5ZXo0LDU5IwdBRSVdAHI6ceuzmYXWCZEvyzrXvhNWoXKPYku7PwweVSKm
	xzuG+5wMK8y3OtQjDK5bOg4jbPWp0iflVnKQUv6O4XMzJ/HCnlmvwEknbCnXNZ8waL7LmL
	F+DgKx85oTw97NthANF1qNY7Fxol5A4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-K9GxGEO2NAudOrSY5XnXcw-1; Wed,
 09 Apr 2025 10:43:18 -0400
X-MC-Unique: K9GxGEO2NAudOrSY5XnXcw-1
X-Mimecast-MFC-AGG-ID: K9GxGEO2NAudOrSY5XnXcw_1744209796
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CFC419560B8;
	Wed,  9 Apr 2025 14:43:16 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6606918009BC;
	Wed,  9 Apr 2025 14:43:12 +0000 (UTC)
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
Subject: [PATCH v2 04/14] mfd: zl3073x: Register itself as devlink device
Date: Wed,  9 Apr 2025 16:42:40 +0200
Message-ID: <20250409144250.206590-5-ivecera@redhat.com>
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

Use devlink_alloc() to alloc zl3073x_dev structure and register
the device as a devlink device. Follow-up patches add support for
devlink device info reporting and devlink flash interface will
be later used for flashing firmware and configuration.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v2:
- dependency on NET moved to MFD_ZL3073X_CORE in Kconfig
- devlink register managed way
---
 drivers/mfd/Kconfig        |  2 ++
 drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 30b36e3ee8f7f..3c54b9e2b8003 100644
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
index ccb6987d04a20..116c6dd9eebc7 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <net/devlink.h>
 #include "zl3073x.h"
 
 /*
@@ -58,6 +59,14 @@ const struct regmap_config *zl3073x_get_regmap_config(void)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
 
+static const struct devlink_ops zl3073x_devlink_ops = {
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
@@ -68,12 +77,25 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_get_regmap_config, "ZL3073X");
  */
 struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
 {
-	struct zl3073x_dev *zldev;
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&zl3073x_devlink_ops,
+				sizeof(struct zl3073x_dev), dev);
+	if (!devlink)
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, zl3073x_devlink_free, devlink))
+		return NULL;
 
-	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+	return devlink_priv(devlink);
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
 
+static void zl3073x_devlink_unregister(void *ptr)
+{
+	devlink_unregister(ptr);
+}
+
 /**
  * zl3073x_dev_init - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -84,6 +106,7 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
  */
 int zl3073x_dev_init(struct zl3073x_dev *zldev)
 {
+	struct devlink *devlink;
 	int rc;
 
 	rc = devm_mutex_init(zldev->dev, &zldev->lock);
@@ -92,6 +115,14 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev)
 		return rc;
 	}
 
+	devlink = priv_to_devlink(zldev);
+	devlink_register(devlink);
+
+	rc = devm_add_action_or_reset(zldev->dev, zl3073x_devlink_unregister,
+				      devlink);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
-- 
2.48.1


