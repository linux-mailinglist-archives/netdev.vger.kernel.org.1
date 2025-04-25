Return-Path: <netdev+bounces-186068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FDA9CF44
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5144B4E307E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DB1F37CE;
	Fri, 25 Apr 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOSPvxRN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE81F09B0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601034; cv=none; b=Wwl7iqFDVSlRWFJgNbO+D4Xp5JnZBaMVMYZm7ieKHCWawe1cO+PBmH7lckOwm6Qv53lsIxLh1sls/mCNGGKiXSaFC0kWo/1qMjQZ1f5A+ShCfQU+1jFZVp7ntqIsbW/gkQUaJbX1xTo2tUmAk6GsewLCDsrxhIfVAb+aMj9nOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601034; c=relaxed/simple;
	bh=FbyloRG52sZ0U76WwGC8yGVG3hkmBvPUf49uGXd3KDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HucOu2cu5KiZqHgHGsjDidf0+2AZ2glp5+rc8DBg8cE+zxrAMPmPbn07Ou4vsBdCTcXWes5UnYZz2ynHXuOSCmcoMwogduuyhe40VnRy7bUUDsC3DyB6e0sXWeVhVJv5iVjmroANQM9ilzws+kPOseWIP4D5VWjVf74k8cGDr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOSPvxRN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745601031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E++EP/qyhBhnU78F8YJ3hqy4YXPQ7IU7/6PY2ABXPtw=;
	b=cOSPvxRNLD/TQqW8w5FRMmvEgo9ufPgkvx7Hes7a+01YQ3hAhIzqjLH2P44xX5I1RHlH4g
	j5sSiddNsCykG4U8Uv/qnG89Cgq5HZTdjKSeT/Mu8PYjkwPzIJIRYNen2beyg+OEgMXjCT
	dNi6aweUyVmiqMRjyfINVTGLsjQZ6g4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-m4D3ng92OneawdUQoySZzQ-1; Fri,
 25 Apr 2025 13:10:26 -0400
X-MC-Unique: m4D3ng92OneawdUQoySZzQ-1
X-Mimecast-MFC-AGG-ID: m4D3ng92OneawdUQoySZzQ_1745601024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 325511800876;
	Fri, 25 Apr 2025 17:10:24 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E8CB1800D9D;
	Fri, 25 Apr 2025 17:10:19 +0000 (UTC)
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
Subject: [PATCH net-next v5 8/8] mfd: zl3073x: Register DPLL sub-device during init
Date: Fri, 25 Apr 2025 19:09:35 +0200
Message-ID: <20250425170935.740102-9-ivecera@redhat.com>
In-Reply-To: <20250425170935.740102-1-ivecera@redhat.com>
References: <20250425170935.740102-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Register DPLL sub-devices to expose the functionality provided
by ZL3073x chip family. Each sub-device represents one of
the available DPLL channels.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* use static mfd cells
---
 drivers/mfd/zl3073x-core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 41a874480758a..54b614d542d11 100644
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
@@ -752,6 +753,14 @@ static void zl3073x_devlink_unregister(void *ptr)
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
@@ -823,6 +832,16 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
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


