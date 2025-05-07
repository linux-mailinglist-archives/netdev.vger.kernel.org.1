Return-Path: <netdev+bounces-188622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BED1AADF9A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EB31B61B97
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5B286D6B;
	Wed,  7 May 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TALcyt52"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266E38DDB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621907; cv=none; b=SwY6+j2BiR/mtvh2YYou0tnOF+pCtGoqRu6T01Q4NjYJSqLonaNpnguzlDxgKgAPAYCtYtBSMplaDqCtkFKJQ2iR0W4oM9jyIGnMlr3By3MeatM0HNBQqkBGV7cndP0rJWGv0rC5fZqC8BkAt6dcM/nkYNGkIZR6ddI8Njdz5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621907; c=relaxed/simple;
	bh=TbzrYfmyzI6C0xH/0j9Dg2raj7qVnH1i701skA3+aVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6uaK4lDdfMZxY6QCQr44S5eVvCKHwbuC1PxMC9d+6WC0z6vkTVx0OBhzP0UaAfScMeR3xYImOpWsktNceVNmfiNdFWnasX6qO4i6/mmSr8BE1wluJcLHyeBqCTjOBxmsKxdo/BwEpKYeI4xIszOoLAlVUmxOq6xSnDI3IU8eBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TALcyt52; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746621904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgekxUyiPgct8SXXkXAWg3zPV4PoWGSUco9eigXND9s=;
	b=TALcyt52UKxAS1xaxb3mJmPt8iAcJ2llBrBMP/p3ikfGW+B15IZ1RgqzOF/oQo3CjekdHV
	5lWUYVulyl0WWNZOuvj+QTajvtvKEbFR1XT61thmm4wOJMGb21w2mKjKKpDX5XDQVz3Y1V
	fouW8zDtevVHYXBXSMgNe8ySuMuQgrY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-dri_yXGlPi68ni6-mEzCAg-1; Wed,
 07 May 2025 08:45:01 -0400
X-MC-Unique: dri_yXGlPi68ni6-mEzCAg-1
X-Mimecast-MFC-AGG-ID: dri_yXGlPi68ni6-mEzCAg_1746621899
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FC4C19560AF;
	Wed,  7 May 2025 12:44:59 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6498719560A7;
	Wed,  7 May 2025 12:44:54 +0000 (UTC)
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
Subject: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device during init
Date: Wed,  7 May 2025 14:43:58 +0200
Message-ID: <20250507124358.48776-9-ivecera@redhat.com>
In-Reply-To: <20250507124358.48776-1-ivecera@redhat.com>
References: <20250507124358.48776-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Register DPLL sub-devices to expose the functionality provided
by ZL3073x chip family. Each sub-device represents one of
the available DPLL channels.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v6->v7:
* use platform data to pass the channel to use
v4->v6:
* no change
v3->v4:
* use static mfd cells
---
 drivers/mfd/zl3073x-core.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h |  9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 0bea696a46b8..ebbad87354fd 100644
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
@@ -755,6 +756,26 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
+	{ .channel = 0, },
+	{ .channel = 1, },
+	{ .channel = 2, },
+	{ .channel = 3, },
+	{ .channel = 4, },
+};
+
+#define ZL3073X_CELL(_name, _channel)				\
+	MFD_CELL_BASIC(_name, NULL, &zl3073x_pdata[_channel],	\
+		       sizeof(struct zl3073x_pdata), 0)
+
+static const struct mfd_cell zl3073x_devs[] = {
+	ZL3073X_CELL("zl3073x-dpll", 0),
+	ZL3073X_CELL("zl3073x-dpll", 1),
+	ZL3073X_CELL("zl3073x-dpll", 2),
+	ZL3073X_CELL("zl3073x-dpll", 3),
+	ZL3073X_CELL("zl3073x-dpll", 4),
+};
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -826,6 +847,15 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
+	/* Add DPLL sub-device cell for each DPLL channel */
+	rc = devm_mfd_add_devices(zldev->dev, PLATFORM_DEVID_AUTO, zl3073x_devs,
+				  chip_info->num_channels, NULL, 0, NULL);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to add DPLL sub-device\n");
+		return rc;
+	}
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 4dc68013b69f..cf4663cab72a 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -12,6 +12,7 @@ struct regmap;
 /*
  * Hardware limits for ZL3073x chip family
  */
+#define ZL3073X_MAX_CHANNELS	5
 #define ZL3073X_NUM_INPUTS	10
 #define ZL3073X_NUM_OUTPUTS	10
 #define ZL3073X_NUM_SYNTHS	5
@@ -48,6 +49,14 @@ struct zl3073x_synth {
 	u8	dpll;
 };
 
+/**
+ * struct zl3073x_pdata - zl3073x sub-device platform data
+ * @channel: channel to use
+ */
+struct zl3073x_pdata {
+	u8	channel;
+};
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
-- 
2.49.0


