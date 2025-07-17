Return-Path: <netdev+bounces-207978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020DB092E7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB6E16F119
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFDE2FE367;
	Thu, 17 Jul 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENwZTOCi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05C2FE307
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772281; cv=none; b=Lrl6fnTcQ/lekKE+QsMOcMNvsQCiGws91WuCdzQH41ZZZrV/nTnBuzeFPK/NlEVpXhVR477Zs4Ao5WyyNV3r4Icmxx9f3DzeUGJF9+a/evcpzKc/fr5Ylhpp+Fpt3LUf7/1V7paKUoRPHjTtNPt0MxeFEUITnug3lIMUh+dRKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772281; c=relaxed/simple;
	bh=DmkylwdM0lAAqKm4MO7YG+O67QtSLYCbav0RyGbAzYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tenDrAgTdBrkad9pYR0mntC0Fiue0Fd1bNrMYNJgZiTGhTYYlhQDBPanuvOblHXqIDN8qNY6RIbnUVmsdrLhjsEyg160gnmdrCnbp47sSa5skeAwurfBnzyFhGQTYrpsVwXjEc/Rbdhr3AMC16RFpnizztq5KZdUQRxqFquCb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENwZTOCi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752772279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SRtS+ULHXF2aDS6IuTFJjw62D9Wnccq0o5WziuZyN4=;
	b=ENwZTOCisOiIX04XG9QkAJS6ERmQICSd+yyq2VhYF0Tg5gH1p/SRu7xoB9X/Q6fkOGg7Rh
	1rhoGJEtDwahHAXQhpXGusIo50Db9nZr3hMHndKQZMVTs3QQkx+gq7uiBu3cz3lFhgcaej
	IJitk7b43LrDFD/0DyfH19pbzQp+iaw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-nd641XWnOjCk8vLbP9iwNA-1; Thu,
 17 Jul 2025 13:11:15 -0400
X-MC-Unique: nd641XWnOjCk8vLbP9iwNA-1
X-Mimecast-MFC-AGG-ID: nd641XWnOjCk8vLbP9iwNA_1752772274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D847D19560BE;
	Thu, 17 Jul 2025 17:11:13 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0EE1195608D;
	Thu, 17 Jul 2025 17:11:09 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <prathosh.satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 2/2] dpll: zl3073x: Initialize clock ID from device property
Date: Thu, 17 Jul 2025 19:11:00 +0200
Message-ID: <20250717171100.2245998-3-ivecera@redhat.com>
In-Reply-To: <20250717171100.2245998-1-ivecera@redhat.com>
References: <20250717171100.2245998-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The clock ID value can be specified by the platform via 'clock-id'
property. Use this property value to initialize clock ID and if it
is not specified generate random one as fallback.

Tested-by: Prathosh Satish <prathosh.satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7ebcfc5ec1f09..f5245225f1d3b 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -9,6 +9,8 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
+#include <linux/property.h>
+#include <linux/random.h>
 #include <linux/regmap.h>
 #include <linux/sprintf.h>
 #include <linux/string_choices.h>
@@ -932,6 +934,29 @@ zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev, int num_channels)
 	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
 }
 
+/**
+ * zl3073x_dev_clock_id_init - initialize clock ID
+ * @zldev: pointer to zl3073x device
+ *
+ * Initializes clock ID using device property if it is provided or
+ * generates random one.
+ */
+static void
+zl3073x_dev_clock_id_init(struct zl3073x_dev *zldev)
+{
+	u64 clock_id;
+	int rc;
+
+	/* Try to read clock ID from device property */
+	rc = device_property_read_u64(zldev->dev, "clock-id", &clock_id);
+
+	/* Generate random id if the property does not exist or value is zero */
+	if (rc || !clock_id)
+		clock_id = get_random_u64();
+
+	zldev->clock_id = clock_id;
+}
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -985,11 +1010,8 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
-	/* Generate random clock ID as the device has not such property that
-	 * could be used for this purpose. A user can later change this value
-	 * using devlink.
-	 */
-	zldev->clock_id = get_random_u64();
+	/* Initialize clock ID */
+	zl3073x_dev_clock_id_init(zldev);
 
 	/* Initialize mutex for operations where multiple reads, writes
 	 * and/or polls are required to be done atomically.
-- 
2.49.1


