Return-Path: <netdev+bounces-198225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A17ADBAC1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D00174E65
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B828C86E;
	Mon, 16 Jun 2025 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0TRa3gC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049428A72F
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104915; cv=none; b=q8ZA2jxMFYQo3NMd1W+3IkOOFgxJISVHmtUvETX6ngT51ApwlaOoNkf388yaxNH6u/xyMqnsXapZd4CKVKHBYuxf8q2s+1ARQxxW9AH9fQUP+pv877h0cUTp6gFP6px6jKGFqJsSRGAtxhFExEc2/H6Ev3pTrtaCF08Trqez5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104915; c=relaxed/simple;
	bh=oHZbb1rJLMK/tA9SmXNvYNtEnDhZ66dzgATbWxqSwxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg1AxyeisBG/udpqQbvuFGWT1uoDJwwMFN/bfXMqppUEYVHMPkjrmxcqEvvFSri3ABBWsPSJInTrtCLsUW2INBtc8ZkrzkcMUILNX5rZKHn4v3PVkAyT4ozYvQdgb35CeXSMStOVBpjjPZP/j6wUOkF8C4A91ZbMiNxtWOWUteg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0TRa3gC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750104911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTJH2oEMnZkAgKTN2kihe9Bkl6Baj4XXA5GAcS4y8jg=;
	b=b0TRa3gC0iB67/7DzmvQCfhLmFFEHbPWm4IWqCs6L3euJ6f4D5Isb1VV2XuFT71pS8tVxX
	obvTkjnAtgYpU5J3yWC7TcnGbMT+vEmnU7V/3iFIPbSTuBiov4k88OJ3Plf4ZtX0iNkXmz
	XZJiN5Rod0apslP6lvpkqblLYENtx7c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-N4jgjWktN4ykds3D4sJ9uA-1; Mon,
 16 Jun 2025 16:15:08 -0400
X-MC-Unique: N4jgjWktN4ykds3D4sJ9uA-1
X-Mimecast-MFC-AGG-ID: N4jgjWktN4ykds3D4sJ9uA_1750104905
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC15B18089B8;
	Mon, 16 Jun 2025 20:15:05 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BD0130044DA;
	Mon, 16 Jun 2025 20:14:59 +0000 (UTC)
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
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v11 07/14] dpll: zl3073x: Add clock_id field
Date: Mon, 16 Jun 2025 22:13:57 +0200
Message-ID: <20250616201404.1412341-8-ivecera@redhat.com>
In-Reply-To: <20250616201404.1412341-1-ivecera@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add .clock_id to zl3073x_dev structure that will be used by later
commits introducing DPLL feature. The clock ID is required for DPLL
device registration.

To generate this ID, use chip ID read during device initialization.
In case where multiple zl3073x based chips are present, the chip ID
is shifted and lower bits are filled by an unique value - using
the I2C device address for I2C connections and the chip-select value
for SPI connections.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 6 +++++-
 drivers/dpll/zl3073x/core.h | 4 +++-
 drivers/dpll/zl3073x/i2c.c  | 4 +++-
 drivers/dpll/zl3073x/spi.c  | 4 +++-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 9d9d1403645f3..ab578c729ac40 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -737,13 +737,14 @@ static void zl3073x_devlink_unregister(void *ptr)
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
@@ -787,6 +788,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Use chip ID and given dev ID as clock ID */
+	zldev->clock_id = ((u64)id << 8) | dev_id;
+
 	/* Initialize mutex for operations where multiple reads, writes
 	 * and/or polls are required to be done atomically.
 	 */
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 0d052c02065e5..fcf142f3f8cb6 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -57,6 +57,7 @@ struct zl3073x_synth {
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
+ * @clock_id: clock id of the device
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -65,6 +66,7 @@ struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
+	u64			clock_id;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -91,7 +93,7 @@ extern const struct regmap_config zl3073x_regmap_config;
 
 struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
 int zl3073x_dev_probe(struct zl3073x_dev *zldev,
-		      const struct zl3073x_chip_info *chip_info);
+		      const struct zl3073x_chip_info *chip_info, u8 dev_id);
 
 /**********************
  * Registers operations
diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
index bca1cd729895c..82cc929e543d7 100644
--- a/drivers/dpll/zl3073x/i2c.c
+++ b/drivers/dpll/zl3073x/i2c.c
@@ -24,7 +24,9 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(zldev->regmap);
 	}
 
-	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
+	/* Initialize device and use I2C address as dev ID */
+	return zl3073x_dev_probe(zldev, i2c_get_match_data(client),
+				 client->addr);
 }
 
 static const struct i2c_device_id zl3073x_i2c_id[] = {
diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
index 219676da71b78..6327d4c9c8d94 100644
--- a/drivers/dpll/zl3073x/spi.c
+++ b/drivers/dpll/zl3073x/spi.c
@@ -24,7 +24,9 @@ static int zl3073x_spi_probe(struct spi_device *spi)
 		return PTR_ERR(zldev->regmap);
 	}
 
-	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
+	/* Initialize device and use SPI chip select value as dev ID */
+	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi),
+				 spi_get_chipselect(spi, 0));
 }
 
 static const struct spi_device_id zl3073x_spi_id[] = {
-- 
2.49.0


