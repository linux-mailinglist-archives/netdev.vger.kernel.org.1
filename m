Return-Path: <netdev+bounces-179789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3AA7E857
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB973BA552
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE57221DA1;
	Mon,  7 Apr 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jv2U1Srn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7B22172F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046988; cv=none; b=i2au/wwJctj/GlHE3o+Ji941TZvVGzSk7DCW71o9H0rvpf/Yin2VUSLK6Oz+V+fnxkC1/rsz3jj1hJ8WNvK527OLNuy0eYqeszq2NpcrnUaiizNENkGdPHRowd7SFNZ34NkQTDGQspW4T4sZJFqIT4CiReYAy2IMM2MMGQMJLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046988; c=relaxed/simple;
	bh=IZDE0Uw0REW2EC3YQAqzGRfFqccTqKOe6rIV8GxvYuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSKHyb6UlIKuTYYRdxX6atNvqdLvu2fiizZs6+OPAE3ESfCi2qbpxDDmVgU/bGmxqH6jZJnNWafrRE4vjC5i8pELfLAjGA9tKUHdaPCSSr3zSqUNuFWMxCkhTua4CmGSyTj/9qfuUpewUox2SKWRH6fppWqlg3iWXFocUGa34Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jv2U1Srn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ytfag6avHkUgxMB2gcbfrMctmdRXvNMuEhL6eCeBh8c=;
	b=Jv2U1Srn5dKxVMszbhN7xd8caDZvIGvVy6622P8LyJhzs1AJGzREsVzHblWnzyYPAx0FDC
	Y1WR9oX3MvnHwUAzaYWK34CiClufZr8++9WacGvMh+mRl84rbjI8sQf65ZmlGiEuuHWv/s
	TL3l519ibP09jvtW/azw75UNH22kHgA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-bek0G_IQM-mH5jKEpyPM1w-1; Mon,
 07 Apr 2025 13:29:43 -0400
X-MC-Unique: bek0G_IQM-mH5jKEpyPM1w-1
X-Mimecast-MFC-AGG-ID: bek0G_IQM-mH5jKEpyPM1w_1744046981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4296195608B;
	Mon,  7 Apr 2025 17:29:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19686180A803;
	Mon,  7 Apr 2025 17:29:34 +0000 (UTC)
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
Subject: [PATCH 09/28] mfd: zl3073x: Add clock_id field
Date: Mon,  7 Apr 2025 19:28:36 +0200
Message-ID: <20250407172836.1009461-10-ivecera@redhat.com>
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

Later commits that add support for DPLL functionality need a clock ID
for DPLL device registration. To generate such ID use chip ID read
during device initialization for this. For the case where are
multiple zl3073x based chips the chip ID is shifted and lower
bits are filled by an unique value. For I2C case it is I2C device
address and for SPI case it is chip-select value.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c  | 5 ++++-
 drivers/mfd/zl3073x-i2c.c   | 3 ++-
 drivers/mfd/zl3073x-spi.c   | 3 ++-
 drivers/mfd/zl3073x.h       | 2 +-
 include/linux/mfd/zl3073x.h | 1 +
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index feb139b550571..5570de58c46e4 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -424,7 +424,7 @@ struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_alloc, "ZL3073X");
 
-int zl3073x_dev_init(struct zl3073x_dev *zldev)
+int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 {
 	u16 id, revision, fw_ver;
 	struct devlink *devlink;
@@ -448,6 +448,9 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev)
 			return rc;
 	}
 
+	/* Use chip ID and given dev ID as clock ID */
+	zldev->clock_id = ((u64)id << 8) | dev_id;
+
 	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
 		 id, revision, fw_ver);
 	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
diff --git a/drivers/mfd/zl3073x-i2c.c b/drivers/mfd/zl3073x-i2c.c
index 8c8b2ba176766..ae7079d9359c1 100644
--- a/drivers/mfd/zl3073x-i2c.c
+++ b/drivers/mfd/zl3073x-i2c.c
@@ -41,7 +41,8 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, zldev);
 
-	return zl3073x_dev_init(zldev);
+	/* Initialize device and use I2C address as dev ID */
+	return zl3073x_dev_init(zldev, client->addr);
 }
 
 static void zl3073x_i2c_remove(struct i2c_client *client)
diff --git a/drivers/mfd/zl3073x-spi.c b/drivers/mfd/zl3073x-spi.c
index a6b9a366a7585..6877ca1664111 100644
--- a/drivers/mfd/zl3073x-spi.c
+++ b/drivers/mfd/zl3073x-spi.c
@@ -42,7 +42,8 @@ static int zl3073x_spi_probe(struct spi_device *spidev)
 
 	spi_set_drvdata(spidev, zldev);
 
-	return zl3073x_dev_init(zldev);
+	/* Initialize device and use SPI chip select value as dev ID */
+	return zl3073x_dev_init(zldev, spi_get_chipselect(spidev, 0));
 }
 
 static void zl3073x_spi_remove(struct spi_device *spidev)
diff --git a/drivers/mfd/zl3073x.h b/drivers/mfd/zl3073x.h
index 582cb40d681d3..04612313d32a9 100644
--- a/drivers/mfd/zl3073x.h
+++ b/drivers/mfd/zl3073x.h
@@ -6,7 +6,7 @@
 #include <linux/mfd/zl3073x.h>
 
 struct zl3073x_dev *zl3073x_dev_alloc(struct device *dev);
-int zl3073x_dev_init(struct zl3073x_dev *zldev);
+int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id);
 void zl3073x_dev_exit(struct zl3073x_dev *zldev);
 const struct regmap_config *zl3073x_get_regmap_config(void);
 
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 436f79f2fda63..a18eddbc03709 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -9,6 +9,7 @@
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
+	u64			clock_id;
 	struct mutex		lock;
 };
 
-- 
2.48.1


