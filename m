Return-Path: <netdev+bounces-179799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB01A7E86A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0383B7A4DE5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4B21883F;
	Mon,  7 Apr 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uupe6w+5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D62144A1
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047170; cv=none; b=Ow+czU/sXQDv8A91wcMSvTpuN8tN6K+1sm3az8QYC2Js+kfxBREyEIsPmcSoc7EVIvRfRr7AHL2omh0aSsqZJhudBoVpLBmDkfhhJW72Lv0xPUOFuvYVRfuACZ0GD0Dx+WeB1NvYSWUfD8teXL+6jQ5VYiXmsB5La/mH2UooPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047170; c=relaxed/simple;
	bh=49hqjtrj2Bm53dnC39U3a+ODcKRvAUv40cACSLYXZXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWUEEtW+sIxKMl+txfjvFfjxc0L88KghLJ/QoOJOvXnOoTtS+mtpK7QJO0PfIVU4wTexDGg5UMn2BJEcZR8zVlx3vpBVBLmvZWm5ot5hsITgjZ2m7GXyLRdIaRlLgSwzVU1rgZixKw+AServxURWPG/e6xOYT/MXk9o5Dwujr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uupe6w+5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0A8iBQW4zRukU1o2/FvgbTyI4yoMYUNvrAw++8qJBKw=;
	b=Uupe6w+5y3Y9oDM4hXWPb03iFef88eFXxWa28M+K2af7FT8D9r5oNcDI8CmtCqZNAf1iV+
	mHpmlQ26Q6XNQDCiMloIpjegaiuEdTeTsHZqhTNRXjiEIvvaegFX9ParUnJbjHdZLEa2Sp
	/8xougs1NkZsBqX9vuQDeZC6WahRoJc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-0LC92G_1N72hV6NNAHLWeA-1; Mon,
 07 Apr 2025 13:32:43 -0400
X-MC-Unique: 0LC92G_1N72hV6NNAHLWeA-1
X-Mimecast-MFC-AGG-ID: 0LC92G_1N72hV6NNAHLWeA_1744047160
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A77EC19560B3;
	Mon,  7 Apr 2025 17:32:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FFE11956094;
	Mon,  7 Apr 2025 17:32:35 +0000 (UTC)
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
Subject: [PATCH 17/28] dpll: zl3073x: Read DPLL types from firmware
Date: Mon,  7 Apr 2025 19:31:47 +0200
Message-ID: <20250407173149.1010216-8-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

System firmware (DT, ACPI...) can provide a type for each DPLL. The types
are stored in property 'dpll-types' as string array and possible values
'pps' and 'eec' are mapped to DPLL enums DPLL_TYPE_PPS and DPLL_TYPE_EEC.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 34bd6964fe001..3ff53a333a6e9 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -6,6 +6,7 @@
 #include <linux/mfd/zl3073x.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 /*
  * Register Map Page 2, Status
@@ -825,6 +826,36 @@ zl3073x_dpll_unregister_pins(struct zl3073x_dpll *zldpll)
 		zl3073x_dpll_pin_unregister(&zldpll->pins[i]);
 }
 
+static enum dpll_type
+zl3073x_dpll_type_get(struct zl3073x_dpll *zldpll)
+{
+	const char *types[ZL3073X_NUM_CHANNELS];
+	enum dpll_type type;
+	int rc;
+
+	/* Set default */
+	type = DPLL_TYPE_PPS;
+
+	/* Read dpll types property from firmware */
+	rc = device_property_read_string_array(zldpll->mfd->dev, "dpll-types",
+					       types, ARRAY_SIZE(types));
+
+	/* It is not present or property does not exist, use default */
+	if (rc <= zldpll->id)
+		return type;
+
+	if (!strcmp(types[zldpll->id], "pps"))
+		type = DPLL_TYPE_PPS;
+	else if (!strcmp(types[zldpll->id], "eec"))
+		type = DPLL_TYPE_EEC;
+	else
+		dev_info(zldpll->mfd->dev,
+			 "Unknown dpll type '%s', using default\n",
+			 types[zldpll->id]);
+
+	return type;
+}
+
 static int
 zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 {
@@ -852,7 +883,8 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 	if (IS_ERR(zldpll->dpll_dev))
 		return PTR_ERR(zldpll->dpll_dev);
 
-	rc = dpll_device_register(zldpll->dpll_dev, DPLL_TYPE_PPS,
+	rc = dpll_device_register(zldpll->dpll_dev,
+				  zl3073x_dpll_type_get(zldpll),
 				  &zl3073x_dpll_device_ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev);
-- 
2.48.1


