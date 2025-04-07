Return-Path: <netdev+bounces-179784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C67A7E844
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5335E3B92F7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963A121765B;
	Mon,  7 Apr 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNZnEXUH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CF11CA0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046964; cv=none; b=JZLBJfr2V8sJw+IqP1ToCNe69751MddgIYOQOjRfuIeWtepK0I+Tq15wLV7f3/yNwXNLMY28jsLX/eMeVuV0+hWJUS/YfExI2bhpOvzwgf2Kb6vJaJZ6IirfdQQegazwZuQlEylf0apv6IjYP1pgeQEgJne6AAzRybtokID5BQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046964; c=relaxed/simple;
	bh=oAp3VLk2xI6TpYWJRVO7zF8yUPRew6W+2d4xf3krwNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXwD1bvVsskwKaxqIvtOlUzX/e+49dUuRC96evF9dERPGQUCzG5I5f0md355AWjmbbKVVAzWN0ze78qx1C+guqWnehz8xgCjTIi1rZTh4gN082Uxrs73w3hgTN/FDyCHsE2F/zYdifPWphW9VQT09ybbEJXUlCX8/IQ1DcwaS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNZnEXUH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43gtAzCXCfH36WcXLnzg04XdMF3g7xE31FVf+kgcQlk=;
	b=ZNZnEXUHTjTM6wl+LoAi2LTigqhBCdzBSbppG8CPZsqgpio56S4mynfkX0E89DlmRlK8nH
	a1VZnwV2rERzOFuxVrImA/3FOgqg8+jKrto4rZJhy3LL+5TA2oYc1w+wzooZIZfRDYgQ9k
	OfvnbmoGnKVJK6FTyaiZg5gMecj+vrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-BYAmFcKmPTahssuxqrowXA-1; Mon,
 07 Apr 2025 13:29:18 -0400
X-MC-Unique: BYAmFcKmPTahssuxqrowXA-1
X-Mimecast-MFC-AGG-ID: BYAmFcKmPTahssuxqrowXA_1744046956
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1344C1800265;
	Mon,  7 Apr 2025 17:29:16 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEE8C180B488;
	Mon,  7 Apr 2025 17:29:09 +0000 (UTC)
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
Subject: [PATCH 05/28] mfd: zl3073x: Add components versions register defs
Date: Mon,  7 Apr 2025 19:28:32 +0200
Message-ID: <20250407172836.1009461-6-ivecera@redhat.com>
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

Add register definitions for components versions and report them
during probe.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 39d4c8608a740..b3091b00cffa8 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -1,10 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
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
@@ -159,10 +168,36 @@ EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
 
 int zl3073x_dev_init(struct zl3073x_dev *zldev)
 {
+	u16 id, revision, fw_ver;
 	struct devlink *devlink;
+	u32 cfg_ver;
+	int rc;
 
 	devm_mutex_init(zldev->dev, &zldev->lock);
 
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


