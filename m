Return-Path: <netdev+bounces-180803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92FA828AF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1604657DC
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94126A0A0;
	Wed,  9 Apr 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5zRqi4+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E1269CF8
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209820; cv=none; b=CE6b057w/ImiKjzxeXbKZGdb4qI/efg2+9XFvAw8XWCWNQU/3vfnzbxFz0tIU1UYg5w0JiDUMs3kD6Z1zTsh677fIcWxliITAjXkrpZ1eruSa7QWbpg6zHo8YG4tu5fISu3Vd9XR1HmGldmjomCmF9peprO3294AQcOorRLS7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209820; c=relaxed/simple;
	bh=LnmXHOldZ0TYsKPgT5TEohZtqmTrKQg6hg565221k78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UROfxlIGY9EVGPLNFroXJqBvPAJP2PnYnxpPG05xq2Htj3/saHbAa1fyTKVb9E5P0tuktjl5kRjeR+2CcdDZRQcXs6W8PhZP1UFSMPh5AxnTyfqkvouBPOXYU2O+R2TBMr3vY6Qbcd3/IqIuHbsZ7rKTXIM/ZOr7fAHYcQqh4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5zRqi4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdIKTPVXiaLu/t49S8AKqbyHpycMLUeXpsIXBRDTNr8=;
	b=U5zRqi4+0G5+U0qHHFSlqDHzauiojJMMqXPvaHYtmLngLhrLLwckiHRaq82sBvXe82sfws
	wYJBfSp8UL/xanPOMJ8O5pVmlVlCmDhKvGlekGTw8XTs5Av0B7QXvFlVlpdPU+C2Q8Nkom
	PE7//dFxJh/f85N7SN1flae/OWdSOL4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-6H4c8wLqPRivm2B0garblQ-1; Wed,
 09 Apr 2025 10:43:33 -0400
X-MC-Unique: 6H4c8wLqPRivm2B0garblQ-1
X-Mimecast-MFC-AGG-ID: 6H4c8wLqPRivm2B0garblQ_1744209811
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D980018001E6;
	Wed,  9 Apr 2025 14:43:30 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9210418009BC;
	Wed,  9 Apr 2025 14:43:26 +0000 (UTC)
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
Subject: [PATCH v2 07/14] mfd: zl3073x: Add components versions register defs
Date: Wed,  9 Apr 2025 16:42:43 +0200
Message-ID: <20250409144250.206590-8-ivecera@redhat.com>
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

Add register definitions for components versions and report them
during probe.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index f0d85f77a7a76..28f28d00da1cc 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -13,6 +15,14 @@
 #include <net/devlink.h>
 #include "zl3073x.h"
 
+/*
+ * Register Map Page 0, General
+ */
+ZL3073X_REG16_DEF(id,			0x0001);
+ZL3073X_REG16_DEF(revision,		0x0003);
+ZL3073X_REG16_DEF(fw_ver,		0x0005);
+ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
+
 /*
  * Regmap ranges
  */
@@ -196,7 +206,9 @@ static void zl3073x_devlink_unregister(void *ptr)
  */
 int zl3073x_dev_init(struct zl3073x_dev *zldev)
 {
+	u16 id, revision, fw_ver;
 	struct devlink *devlink;
+	u32 cfg_ver;
 	int rc;
 
 	rc = devm_mutex_init(zldev->dev, &zldev->lock);
@@ -205,6 +217,30 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev)
 		return rc;
 	}
 
+	/* Take device lock */
+	scoped_guard(zl3073x, zldev) {
+		rc = zl3073x_read_id(zldev, &id);
+		if (rc)
+			return rc;
+		rc = zl3073x_read_revision(zldev, &revision);
+		if (rc)
+			return rc;
+		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
+		if (rc)
+			return rc;
+		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
+		if (rc)
+			return rc;
+	}
+
+	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
+		 id, revision, fw_ver);
+	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
+		 FIELD_GET(GENMASK(31, 24), cfg_ver),
+		 FIELD_GET(GENMASK(23, 16), cfg_ver),
+		 FIELD_GET(GENMASK(15, 8), cfg_ver),
+		 FIELD_GET(GENMASK(7, 0), cfg_ver));
+
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
 
-- 
2.48.1


