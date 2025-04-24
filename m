Return-Path: <netdev+bounces-185635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF0A9B2F0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AF31BA10D9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B536289342;
	Thu, 24 Apr 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5KoM/yv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA927FD6C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509694; cv=none; b=dUKpu0vGSPNj7PmlnrBCUkj5UITLiEt7QJp+w6Xo2axvTdLpwtGV9H3tk7iO44LSTL6b2v18+sYyIyBq9CN4vm5OOBZnWey22mvxFaLHEDxozo1hMMn0TNxxN6ZXX0Bg7yUyWIZRMP8yvTrvbJ2sP2Xa29iVRyKS9wsWEWKL7vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509694; c=relaxed/simple;
	bh=uSxfYU+alZ+sYCvxTB+/8v0JU7I2q/gK2ZemiaPNsK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA60yOBlYeLCvonooJtUzc47pfoncd9+qWliey5gaBBLb0/go4G99iJ9JMSo7L8y2HMB4LDAEs9MDP9jRu8idnCdlP8AVmdAhzhamIlwIbZG6P54ttn2NAQwx+zFiSI8gbMbgK3v8eFOhg2Fu/kRHB5k7++uCDjvkPQ0InKjvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5KoM/yv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ3ESh836Q1m0vn5b+38c3tvO5uha8Mw417YRBDXs/M=;
	b=b5KoM/yvDscMlUK4qcTDWKkuRV1phm6sWL6c0GvR3K/jeLG+Y+bAuBnRlgNd9M4y/dMCHh
	BeaRsLY75Kzdi3eZuASh9cWlWY4JhoHDMiRoWRVnjBmUuOP0lXIQYW9BaEGKegI2Wo8py1
	O48cA+vzHeNkzPyxAxrJ74y4bn6O4As=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-xrNaEUdpMQeva-BySMvYZA-1; Thu,
 24 Apr 2025 11:48:08 -0400
X-MC-Unique: xrNaEUdpMQeva-BySMvYZA-1
X-Mimecast-MFC-AGG-ID: xrNaEUdpMQeva-BySMvYZA_1745509686
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB5251800980;
	Thu, 24 Apr 2025 15:48:05 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4343C19560A3;
	Thu, 24 Apr 2025 15:48:01 +0000 (UTC)
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
Subject: [PATCH net-next v4 7/8] mfd: zl3073x: Add clock_id field
Date: Thu, 24 Apr 2025 17:47:21 +0200
Message-ID: <20250424154722.534284-8-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add .clock_id to zl3073x_dev structure that will be used by later
commits introducing DPLL driver. The clock ID is required for DPLL
device registration.
To generate this ID, use chip ID read during device initialization.
In case where multiple zl3073x based chips are present, the chip ID
is shifted and lower bits are filled by an unique value - using
the I2C device address for I2C connections and the chip-select value
for SPI connections.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c  | 6 +++++-
 drivers/mfd/zl3073x-i2c.c   | 4 +++-
 drivers/mfd/zl3073x-spi.c   | 4 +++-
 drivers/mfd/zl3073x.h       | 2 +-
 include/linux/mfd/zl3073x.h | 2 ++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index b6058de04f954..d0022dfb0236c 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -914,13 +914,14 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
  * @chip_info: chip info based on compatible
+ * @dev_id: device ID to be used as part of clock ID
  *
  * Common initialization of zl3073x device structure.
  *
  * Returns: 0 on success, <0 on error
  */
 int zl3073x_dev_probe(struct zl3073x_dev *zldev,
-		      const struct zl3073x_chip_info *chip_info)
+		      const struct zl3073x_chip_info *chip_info, u8 dev_id)
 {
 	u16 id, revision, fw_ver;
 	struct devlink *devlink;
@@ -964,6 +965,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Use chip ID and given dev ID as clock ID */
+	zldev->clock_id = ((u64)id << 8) | dev_id;
+
 	/* Fetch device state */
 	rc = zl3073x_dev_state_fetch(zldev);
 	if (rc)
diff --git a/drivers/mfd/zl3073x-i2c.c b/drivers/mfd/zl3073x-i2c.c
index da8bbd702d76c..e00277f87de92 100644
--- a/drivers/mfd/zl3073x-i2c.c
+++ b/drivers/mfd/zl3073x-i2c.c
@@ -27,7 +27,9 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(zldev->regmap);
 	}
 
-	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
+	/* Initialize device and use I2C address as dev ID */
+	return zl3073x_dev_probe(zldev, i2c_get_match_data(client),
+				 client->addr);
 }
 
 static const struct i2c_device_id zl3073x_i2c_id[] = {
diff --git a/drivers/mfd/zl3073x-spi.c b/drivers/mfd/zl3073x-spi.c
index 962b6845c0325..368001ae19db9 100644
--- a/drivers/mfd/zl3073x-spi.c
+++ b/drivers/mfd/zl3073x-spi.c
@@ -27,7 +27,9 @@ static int zl3073x_spi_probe(struct spi_device *spi)
 		return PTR_ERR(zldev->regmap);
 	}
 
-	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
+	/* Initialize device and use SPI chip select value as dev ID */
+	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi),
+				 spi_get_chipselect(spi, 0));
 }
 
 static const struct spi_device_id zl3073x_spi_id[] = {
diff --git a/drivers/mfd/zl3073x.h b/drivers/mfd/zl3073x.h
index 3a2fea61cf579..abd1ab9a56ded 100644
--- a/drivers/mfd/zl3073x.h
+++ b/drivers/mfd/zl3073x.h
@@ -26,6 +26,6 @@ extern const struct zl3073x_chip_info zl3073x_chip_info[];
 struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
 void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg);
 int zl3073x_dev_probe(struct zl3073x_dev *zldev,
-		      const struct zl3073x_chip_info *chip_info);
+		      const struct zl3073x_chip_info *chip_info, u8 dev_id);
 
 #endif /* __ZL3073X_CORE_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 43171246093f2..ca6785ff9ecc9 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -51,6 +51,7 @@ struct zl3073x_synth {
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
+ * @clock_id: clock id of the device
  * @input: array of inputs' invariants
  * @output: array of outputs' invariants
  * @synth: array of synthesizers' invariants
@@ -58,6 +59,7 @@ struct zl3073x_synth {
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
+	u64			clock_id;
 
 	/* Invariants */
 	struct zl3073x_input	input[ZL3073X_NUM_INPUTS];
-- 
2.49.0


