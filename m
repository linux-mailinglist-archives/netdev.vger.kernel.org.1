Return-Path: <netdev+bounces-188710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA06AAE4C4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5CB1C42957
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023528BA91;
	Wed,  7 May 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzxmvMKo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF328BA84
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631567; cv=none; b=r9cdk7uAaM4izy+9SNtQGpZaHoPTWzLj7L8wn8maHjYXwvz4syrPz+KUO8hihkr4rvDAblsLeb1PG9oweBKvPuv8k+rPw4nmLTyvJt6oAKX1RJ1+9k6/tg5djJqxmyELTuYlD+Vdp3nAeob2nyQg5TS6jjnDu3AfhC+0XdubaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631567; c=relaxed/simple;
	bh=sKo4FtZtdnOcvr1oQuz2XBroEwdboLpu4/AAykZ6Geg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4MWsHA7w1ojPQwomJ+NfH4PxOM56i37oxqbLyJfsBMM6QCZ+H9PvYQ2IQqt1WIv/7N06BU1EOVgMdL19eysfyWf33mJxiqbfr330e0Hz9+ZlhjKzkeJYsw6y7Z+OX8+z1hEnwzjc5fkDZeIKTQZvYe+IbXNNR6gdM3VqYVx624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzxmvMKo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7rsTQVkWdVuIH2kV4e5IulN3mEFFY4EL8PR2r1zcwQ=;
	b=UzxmvMKoGlNxwPndtyU/XrK/iccDlJjYx2n7gmIBgWOs9sqwYTNQY/F5UyeJs4eC8icrj8
	a8cEq546XjBWr7bd63KHoueRPasayK/dhGlY25tOrGAfn9DA1/UhO3CqF1De7NQz+DOU5l
	RvoecMR24Cf5bdPLx0laGUYgxRsRWiU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-NNlbYunAN0qPtBkYUzqRVg-1; Wed,
 07 May 2025 11:26:01 -0400
X-MC-Unique: NNlbYunAN0qPtBkYUzqRVg-1
X-Mimecast-MFC-AGG-ID: NNlbYunAN0qPtBkYUzqRVg_1746631559
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB2E195608C;
	Wed,  7 May 2025 15:25:59 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46E9230001AA;
	Wed,  7 May 2025 15:25:54 +0000 (UTC)
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
Subject: [PATCH net-next v8 8/8] mfd: zl3073x: Register DPLL sub-device during init
Date: Wed,  7 May 2025 17:25:04 +0200
Message-ID: <20250507152504.85341-9-ivecera@redhat.com>
In-Reply-To: <20250507152504.85341-1-ivecera@redhat.com>
References: <20250507152504.85341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Register DPLL sub-devices to expose the functionality provided
by ZL3073x chip family. Each sub-device represents one of
the available DPLL channels.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v7->v8:
* replaced zl3073x_pdata array ZL3073X_PDATA macro
v6->v7:
* use platform data to pass the channel to use
v4->v6:
* no change
v3->v4:
* use static mfd cells
---
 drivers/mfd/zl3073x-core.c  | 27 +++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h |  9 +++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 0bea696a46b8..7b140b614a63 100644
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
@@ -755,6 +756,23 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+#define ZL3073X_PDATA(_channel)			\
+	(&(const struct zl3073x_pdata) {	\
+		.channel = _channel,		\
+	})
+
+#define ZL3073X_CELL(_name, _channel)				\
+	MFD_CELL_BASIC(_name, NULL, ZL3073X_PDATA(_channel),	\
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
@@ -826,6 +844,15 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
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


