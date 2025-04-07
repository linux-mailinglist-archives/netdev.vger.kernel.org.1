Return-Path: <netdev+bounces-179796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A9A7E86F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498D3189152C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D67221573;
	Mon,  7 Apr 2025 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI1PEqFj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8721D3D1
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047151; cv=none; b=VG9FjMuqBmM+Y71Vz0Dz+WfIfnax7F6JROPSvYwZXqoHPKFqoajHl1/qWgOZfo686B6jnJR1f8oGGVahgY7DgCQuqEXmGtyhF5tqrv5Xhf0RaAws6zUhJ6OdHFSfpAXzuwy6QjEVIW7E4v9gxctb9oD02JTI15WizxUt9MlnKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047151; c=relaxed/simple;
	bh=KemroqypPAQNOLl43rDGjpI5YHw232i4a9JYpzF0eYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okWSRoAT6xAa9Zs0MIs8KQF9AL61T06O55FFsRz9q4kZXv3ZF0tjFT4JRUlPbYpxySJJMYAQ6e7YoNMhO85ZJnwvKS811OBURDUYiefZcr5mtq6LHy0KHDqmDHw+GFPNM/gYs076Nd1VpYJpl7UEKMo/7NaFLLy/+4VMuWmTEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XI1PEqFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd9a9J+XCd9rjw5P99I+tp6pt4tvqQ0bA86sip24B8=;
	b=XI1PEqFjn2X1SoOGqerS8uBC0Rv+uJqm4Lu9r/e8M/a3+T05JTekhQN2erltxMJ6RdlROo
	+lNn2bLBtETWRekWU7onSpiK0VYrdiSroleeuH4YUH65Wgs7aj5jFh1WdeMThe46pKGEMd
	vzoHw7BuJ0aFpt5p9RHNOpNpHmbi/MU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-CyFlr7aKP6GTIsHNNPqHOw-1; Mon,
 07 Apr 2025 13:32:24 -0400
X-MC-Unique: CyFlr7aKP6GTIsHNNPqHOw-1
X-Mimecast-MFC-AGG-ID: CyFlr7aKP6GTIsHNNPqHOw_1744047142
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10D6F1809CA3;
	Mon,  7 Apr 2025 17:32:22 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CF9E1956094;
	Mon,  7 Apr 2025 17:32:16 +0000 (UTC)
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
Subject: [PATCH 14/28] mfd: zl3073x: Register DPLL sub-device during init
Date: Mon,  7 Apr 2025 19:31:44 +0200
Message-ID: <20250407173149.1010216-5-ivecera@redhat.com>
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

Register DPLL sub-devices to expose this functionality provided
by ZL3073x chip family. Each sub-device represents one of the provided
DPLL channels.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 9ed405a62fa86..8ac59133bc54a 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/bitfield.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/unaligned.h>
 #include <net/devlink.h>
@@ -760,6 +761,11 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+static const struct mfd_cell zl3073x_devs[] = {
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("zl3073x-dpll", NULL, NULL, 0, 1),
+};
+
 int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 {
 	u16 id, revision, fw_ver;
@@ -805,6 +811,16 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 		 FIELD_GET(GENMASK(15, 8), cfg_ver),
 		 FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Add DPLL sub-device cells */
+	rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO, zl3073x_devs,
+				  ARRAY_SIZE(zl3073x_devs), NULL, 0, NULL);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to add sub-devices: %pe\n",
+			ERR_PTR(rc));
+
+		return rc;
+	}
+
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
 
-- 
2.48.1


