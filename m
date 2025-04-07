Return-Path: <netdev+bounces-179782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40588A7E83E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D55176A1D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA6921771B;
	Mon,  7 Apr 2025 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnIZUjwV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27721770D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046947; cv=none; b=l7Lu302fVfjpgXSHDHAEosbZHQF9gJsF/UZffi6hUg+OY8lYT7zGyAGhh+qUc4x/rPIfuNsKyuvo0cO4JRyegQTjaDavWOYmw8BlaCbgoii6FREMVnoB2G1nPKQcUdymi2El2M2HJ3THbD1l3PbPOmKos03nBv80FAyIhuoX4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046947; c=relaxed/simple;
	bh=v1rM3bKaL5fazId1hGOHxWFqoP2Wtd1q2yFOeLRU448=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI/UxKLv6go45sUXruENCSISBQgfEESeNfLPhv6Jwn3Kc65QTfD7Ni0nRU3BiQyqRTpEJLUimAw1fiIk/fIspm8nPOV/GKjgFyA11w0v+dZ19zhZGaHoHZYARtl7PpR/fccaEna6sXlnZ3EKoCs+zv3M5mI4OHX8TNaoFR7YFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnIZUjwV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=byI/z5EgcgD3KURSrPmsNqBUTi51FgnmC0aRsV45pBE=;
	b=XnIZUjwVypqa8+cselAw305M4qgtwCuT3dJOAMWTHhZZCRb9e5EEvBNc8HvwjLSUzKDpEn
	LSOFXNOdEf6t72N0rX41AcMxz1WLz9Ccu9o/rq5df/cjQe5aVRLnHG4IwO1F146eG0Tkw1
	TUAAdsRO09zch9GtFOVSlOjBKB7j2mk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Eyyn3PRMMCWwXJxKennttQ-1; Mon,
 07 Apr 2025 13:28:59 -0400
X-MC-Unique: Eyyn3PRMMCWwXJxKennttQ-1
X-Mimecast-MFC-AGG-ID: Eyyn3PRMMCWwXJxKennttQ_1744046937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68EE719560B0;
	Mon,  7 Apr 2025 17:28:56 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 891A2180B488;
	Mon,  7 Apr 2025 17:28:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 02/28] mfd: zl3073x: Register itself as devlink device
Date: Mon,  7 Apr 2025 19:28:29 +0200
Message-ID: <20250407172836.1009461-3-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use devlink_alloc() to alloc zl3073x_dev structure and register
the device as a devlink device. Follow-up patches add support for
devlink device info reporting and devlink flash interface will
be later used for flashing firmware and configuration.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/Kconfig        |  3 +++
 drivers/mfd/zl3073x-core.c | 27 +++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 30b36e3ee8f7f..a838d5dca4579 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2424,11 +2424,13 @@ config MFD_UPBOARD_FPGA
 
 config MFD_ZL3073X_CORE
 	tristate
+	select NET_DEVLINK
 	select MFD_CORE
 
 config MFD_ZL3073X_I2C
 	tristate "Microchip Azurite DPLL/PTP/SyncE with I2C"
 	depends on I2C
+	depends on NET
 	select MFD_ZL3073X_CORE
 	select REGMAP_I2C
 	help
@@ -2441,6 +2443,7 @@ config MFD_ZL3073X_I2C
 
 config MFD_ZL3073X_SPI
 	tristate "Microchip Azurite DPLL/PTP/SyncE with SPI"
+	depends on NET
 	depends on SPI
 	select MFD_ZL3073X_CORE
 	select REGMAP_SPI
diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 67a9d5a0e2d8c..71454f683eab0 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/module.h>
+#include <net/devlink.h>
 #include "zl3073x.h"
 
 /*
@@ -44,24 +45,46 @@ const struct regmap_config *zl3073x_get_regmap_config(void)
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
 struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
 {
-	struct zl3073x_dev *zldev;
+	struct devlink *devlink;
 
-	return devm_kzalloc(dev, sizeof(*zldev), GFP_KERNEL);
+	devlink = devlink_alloc(&zl3073x_devlink_ops,
+				sizeof(struct zl3073x_dev), dev);
+	if (!devlink)
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, zl3073x_devlink_free, devlink))
+		return NULL;
+
+	return devlink_priv(devlink);
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
 
 int zl3073x_dev_init(struct zl3073x_dev *zldev)
 {
+	struct devlink *devlink;
+
 	devm_mutex_init(zldev->dev, &zldev->lock);
 
+	devlink = priv_to_devlink(zldev);
+	devlink_register(devlink);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init, "ZL3073X");
 
 void zl3073x_dev_exit(struct zl3073x_dev *zldev)
 {
+	devlink_unregister(priv_to_devlink(zldev));
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_exit, "ZL3073X");
 
-- 
2.48.1


