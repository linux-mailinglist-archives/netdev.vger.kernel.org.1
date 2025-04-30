Return-Path: <netdev+bounces-187030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C7AA480D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B874A6D6B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9D125A352;
	Wed, 30 Apr 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhGDSItM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6D25A33A
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007944; cv=none; b=TkSqAF5irrkSyvfEIJKQtHu626IaVUnHyQ76kT8ATZgB4+wfgCgKHdSR5ueDVGvB2G8msPuZI2xKyyjueMfgd6vkM3IeqMkC0pvYAEcN36K+GWJXM/SRVUdvXcFz4CY9Dt3IY1AYuc905Nin738PpgXOxzCUArWpksDZAAsLQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007944; c=relaxed/simple;
	bh=ecy6qqaWhM2xobngJ8fvS5peWhfAmVtAcOtECYDOYpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amg9BG6K/y8S0ry85QBHAJ19LwArjL8Kz60KYIx/ZgZV6vGP+tZCRFb3+hRpiXCVKARP8vqA9AndfP/p3a/X9B9RwF4jz59LSABsXG0OcAqzM7UAW7ZilwTuX+7q3IHZBBe98HKmzomzcivTms7vxfOlVth/2brq5QhpnnygnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhGDSItM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746007941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Djj8tsy+Ba85/DDYqso23/cXw9EWu4CIgtP3vOGRebo=;
	b=RhGDSItMpYmkPNyCfp+yG6ncIx61JE5n+GXHUrE0mo+e1x9/zpyUm5278lyPt0pet7NQhN
	mXlR/6nLLEbCl4lbLX0T0P7EOxYDMKvSL3tMVb6S+/rmeI5gWVwo8BioDIH9iX8eg20JB2
	uPFUwS6v6oXzabkOctNuWFKXRy/NzbM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-UUO7kGRMOp2Up6SB1LyAMg-1; Wed,
 30 Apr 2025 06:12:17 -0400
X-MC-Unique: UUO7kGRMOp2Up6SB1LyAMg-1
X-Mimecast-MFC-AGG-ID: UUO7kGRMOp2Up6SB1LyAMg_1746007935
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 648CC19560AA;
	Wed, 30 Apr 2025 10:12:15 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B53BA1956094;
	Wed, 30 Apr 2025 10:12:10 +0000 (UTC)
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
Subject: [PATCH net-next v6 8/8] mfd: zl3073x: Register DPLL sub-device during init
Date: Wed, 30 Apr 2025 12:11:26 +0200
Message-ID: <20250430101126.83708-9-ivecera@redhat.com>
In-Reply-To: <20250430101126.83708-1-ivecera@redhat.com>
References: <20250430101126.83708-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Register DPLL sub-devices to expose the functionality provided
by ZL3073x chip family. Each sub-device represents one of
the available DPLL channels.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v4->v6:
* no change
v3->v4:
* use static mfd cells
---
 drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 050dc57c90c3..3e665cdf228f 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/math64.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -755,6 +756,14 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+static const struct mfd_cell zl3073x_dpll_cells[] = {
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 2),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 3),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 4),
+};
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -826,6 +835,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
+	/* Add DPLL sub-device cell for each DPLL channel */
+	rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO,
+				  zl3073x_dpll_cells, chip_info->num_channels,
+				  NULL, 0, NULL);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to add DPLL sub-device\n");
+		return rc;
+	}
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
-- 
2.49.0


