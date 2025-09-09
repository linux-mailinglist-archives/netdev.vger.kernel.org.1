Return-Path: <netdev+bounces-221140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB85B4A7A4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B780916784E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657A30C621;
	Tue,  9 Sep 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUhRfjj3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D230BB84
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409365; cv=none; b=svOYaIxz+8u3nDbkUIj/gFew3pNDmM0K5UiF8ylC71pZRhWWYp3LG9+QseGlx3vNxuyv4MgKMZ/VsF86O4VKCuIyFLVriM3E7tNGRvydIkK8wBWcllJ6LjZShI7+dlHHJEP3qZ5DBuo3Du9h4lKUl7TRVYkb064GhIFSidouxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409365; c=relaxed/simple;
	bh=Q94FZDmaYo0Q+kN/ERxd3PoUEzzy2FQEfsEXXL8McgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kexSHJ7XJak6O3bJCIq1fxyj2MoEXen4i2W/+3ooEG3HRXo8ctzRj3evAkliccGSDCDBwRSntIkdubAYeiwgRlnswj3nm5LinxhXrrc4s7hTglnCzMJ2dzJpSI0q/hQgGbIfJTiursPNnj686g4mj4KajmK70XmxIPmhYQ2mEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUhRfjj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757409361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X4gjdfHoGOjc0ayt/oAGODhuCY/fH5GnPsZmcC+mm+Y=;
	b=iUhRfjj3WrF+6+hrg6UPk0LU8TyUNbJQq1ejdhJ99HMVBLGTgbLmzB4DYUFCVVHKU5vPSI
	ns2x3Lx2MuW7iwtIzU4OxBiYCehX+mqepAMsm67K0XcCodZlCY3vft3r/0vI+DRkJnerY7
	sOAgLw3tUkaWYF4htYbsr/sx+lGBZxc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-fnP7xP4ZNUORubexJ3Ou4g-1; Tue,
 09 Sep 2025 05:15:57 -0400
X-MC-Unique: fnP7xP4ZNUORubexJ3Ou4g-1
X-Mimecast-MFC-AGG-ID: fnP7xP4ZNUORubexJ3Ou4g_1757409355
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BF0119560B7;
	Tue,  9 Sep 2025 09:15:55 +0000 (UTC)
Received: from p16v.. (unknown [10.43.2.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0612F19560B4;
	Tue,  9 Sep 2025 09:15:51 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v6 4/5] dpll: zl3073x: Refactor DPLL initialization
Date: Tue,  9 Sep 2025 11:15:31 +0200
Message-ID: <20250909091532.11790-5-ivecera@redhat.com>
In-Reply-To: <20250909091532.11790-1-ivecera@redhat.com>
References: <20250909091532.11790-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Refactor DPLL initialization and move DPLL (de)registration, monitoring
control, fetching device invariant parameters and phase offset
measurement block setup to separate functions.

Use these new functions during device probe and teardown functions and
during changes to the clock_id devlink parameter.

These functions will also be used in the next patch implementing devlink
flash, where this functionality is likewise required.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed warning with uninitialized 'mask'
---
 drivers/dpll/zl3073x/core.c    | 207 +++++++++++++++++++++------------
 drivers/dpll/zl3073x/core.h    |   3 +
 drivers/dpll/zl3073x/devlink.c |  18 +--
 3 files changed, 142 insertions(+), 86 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 86c26edc90462..e96095baac657 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -956,21 +956,142 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(500));
 }
 
+/**
+ * zl3073x_dev_phase_meas_setup - setup phase offset measurement
+ * @zldev: pointer to zl3073x_dev structure
+ *
+ * Enable phase offset measurement block, set measurement averaging factor
+ * and enable DPLL-to-its-ref phase measurement for all DPLLs.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+static int
+zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev)
+{
+	struct zl3073x_dpll *zldpll;
+	u8 dpll_meas_ctrl, mask = 0;
+	int rc;
+
+	/* Read DPLL phase measurement control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Setup phase measurement averaging factor */
+	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
+	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
+
+	/* Enable DPLL measurement block */
+	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
+
+	/* Update phase measurement control register */
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Enable DPLL-to-connected-ref measurement for each channel */
+	list_for_each_entry(zldpll, &zldev->dplls, list)
+		mask |= BIT(zldpll->id);
+
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
+}
+
+/**
+ * zl3073x_dev_start - Start normal operation
+ * @zldev: zl3073x device pointer
+ * @full: perform full initialization
+ *
+ * The function starts normal operation, which means registering all DPLLs and
+ * their pins, and starting monitoring. If full initialization is requested,
+ * the function additionally initializes the phase offset measurement block and
+ * fetches hardware-invariant parameters.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full)
+{
+	struct zl3073x_dpll *zldpll;
+	int rc;
+
+	if (full) {
+		/* Fetch device state */
+		rc = zl3073x_dev_state_fetch(zldev);
+		if (rc)
+			return rc;
+
+		/* Setup phase offset measurement block */
+		rc = zl3073x_dev_phase_meas_setup(zldev);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to setup phase measurement\n");
+			return rc;
+		}
+	}
+
+	/* Register all DPLLs */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		rc = zl3073x_dpll_register(zldpll);
+		if (rc) {
+			dev_err_probe(zldev->dev, rc,
+				      "Failed to register DPLL%u\n",
+				      zldpll->id);
+			return rc;
+		}
+	}
+
+	/* Perform initial firmware fine phase correction */
+	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc,
+			      "Failed to init fine phase correction\n");
+		return rc;
+	}
+
+	/* Start monitoring */
+	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
+
+	return 0;
+}
+
+/**
+ * zl3073x_dev_stop - Stop normal operation
+ * @zldev: zl3073x device pointer
+ *
+ * The function stops the normal operation that mean deregistration of all
+ * DPLLs and their pins and stop monitoring.
+ *
+ * Return: 0 on success, <0 on error
+ */
+void zl3073x_dev_stop(struct zl3073x_dev *zldev)
+{
+	struct zl3073x_dpll *zldpll;
+
+	/* Stop monitoring */
+	kthread_cancel_delayed_work_sync(&zldev->work);
+
+	/* Unregister all DPLLs */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		if (zldpll->dpll_dev)
+			zl3073x_dpll_unregister(zldpll);
+	}
+}
+
 static void zl3073x_dev_dpll_fini(void *ptr)
 {
 	struct zl3073x_dpll *zldpll, *next;
 	struct zl3073x_dev *zldev = ptr;
 
-	/* Stop monitoring thread */
+	/* Stop monitoring and unregister DPLLs */
+	zl3073x_dev_stop(zldev);
+
+	/* Destroy monitoring thread */
 	if (zldev->kworker) {
-		kthread_cancel_delayed_work_sync(&zldev->work);
 		kthread_destroy_worker(zldev->kworker);
 		zldev->kworker = NULL;
 	}
 
-	/* Release DPLLs */
+	/* Free all DPLLs */
 	list_for_each_entry_safe(zldpll, next, &zldev->dplls, list) {
-		zl3073x_dpll_unregister(zldpll);
 		list_del(&zldpll->list);
 		zl3073x_dpll_free(zldpll);
 	}
@@ -986,7 +1107,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 
 	INIT_LIST_HEAD(&zldev->dplls);
 
-	/* Initialize all DPLLs */
+	/* Allocate all DPLLs */
 	for (i = 0; i < num_dplls; i++) {
 		zldpll = zl3073x_dpll_alloc(zldev, i);
 		if (IS_ERR(zldpll)) {
@@ -996,25 +1117,9 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 			goto error;
 		}
 
-		rc = zl3073x_dpll_register(zldpll);
-		if (rc) {
-			dev_err_probe(zldev->dev, rc,
-				      "Failed to register DPLL%u\n", i);
-			zl3073x_dpll_free(zldpll);
-			goto error;
-		}
-
 		list_add_tail(&zldpll->list, &zldev->dplls);
 	}
 
-	/* Perform initial firmware fine phase correction */
-	rc = zl3073x_dpll_init_fine_phase_adjust(zldev);
-	if (rc) {
-		dev_err_probe(zldev->dev, rc,
-			      "Failed to init fine phase correction\n");
-		goto error;
-	}
-
 	/* Initialize monitoring thread */
 	kthread_init_delayed_work(&zldev->work, zl3073x_dev_periodic_work);
 	kworker = kthread_run_worker(0, "zl3073x-%s", dev_name(zldev->dev));
@@ -1022,9 +1127,14 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 		rc = PTR_ERR(kworker);
 		goto error;
 	}
-
 	zldev->kworker = kworker;
-	kthread_queue_delayed_work(zldev->kworker, &zldev->work, 0);
+
+	/* Start normal operation */
+	rc = zl3073x_dev_start(zldev, true);
+	if (rc) {
+		dev_err_probe(zldev->dev, rc, "Failed to start device\n");
+		goto error;
+	}
 
 	/* Add devres action to release DPLL related resources */
 	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
@@ -1039,46 +1149,6 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	return rc;
 }
 
-/**
- * zl3073x_dev_phase_meas_setup - setup phase offset measurement
- * @zldev: pointer to zl3073x_dev structure
- * @num_channels: number of DPLL channels
- *
- * Enable phase offset measurement block, set measurement averaging factor
- * and enable DPLL-to-its-ref phase measurement for all DPLLs.
- *
- * Returns: 0 on success, <0 on error
- */
-static int
-zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev, int num_channels)
-{
-	u8 dpll_meas_ctrl, mask;
-	int i, rc;
-
-	/* Read DPLL phase measurement control register */
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
-	if (rc)
-		return rc;
-
-	/* Setup phase measurement averaging factor */
-	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
-
-	/* Enable DPLL measurement block */
-	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
-
-	/* Update phase measurement control register */
-	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
-	if (rc)
-		return rc;
-
-	/* Enable DPLL-to-connected-ref measurement for each channel */
-	for (i = 0, mask = 0; i < num_channels; i++)
-		mask |= BIT(i);
-
-	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
-}
-
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -1146,17 +1216,6 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
 
-	/* Fetch device state */
-	rc = zl3073x_dev_state_fetch(zldev);
-	if (rc)
-		return rc;
-
-	/* Setup phase offset measurement block */
-	rc = zl3073x_dev_phase_meas_setup(zldev, chip_info->num_channels);
-	if (rc)
-		return dev_err_probe(zldev->dev, rc,
-				     "Failed to setup phase measurement\n");
-
 	/* Register DPLL channels */
 	rc = zl3073x_devm_dpll_init(zldev, chip_info->num_channels);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 16e750d77e1dd..128fb899cafc3 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -112,6 +112,9 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
 int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		      const struct zl3073x_chip_info *chip_info);
 
+int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full);
+void zl3073x_dev_stop(struct zl3073x_dev *zldev);
+
 /**********************
  * Registers operations
  **********************/
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index f3ca973a4d416..d0f6d9cd4a68e 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -86,14 +86,12 @@ zl3073x_devlink_reload_down(struct devlink *devlink, bool netns_change,
 			    struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dev *zldev = devlink_priv(devlink);
-	struct zl3073x_dpll *zldpll;
 
 	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
 		return -EOPNOTSUPP;
 
-	/* Unregister all DPLLs */
-	list_for_each_entry(zldpll, &zldev->dplls, list)
-		zl3073x_dpll_unregister(zldpll);
+	/* Stop normal operation */
+	zl3073x_dev_stop(zldev);
 
 	return 0;
 }
@@ -107,7 +105,6 @@ zl3073x_devlink_reload_up(struct devlink *devlink,
 {
 	struct zl3073x_dev *zldev = devlink_priv(devlink);
 	union devlink_param_value val;
-	struct zl3073x_dpll *zldpll;
 	int rc;
 
 	if (action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
@@ -125,13 +122,10 @@ zl3073x_devlink_reload_up(struct devlink *devlink,
 		zldev->clock_id = val.vu64;
 	}
 
-	/* Re-register all DPLLs */
-	list_for_each_entry(zldpll, &zldev->dplls, list) {
-		rc = zl3073x_dpll_register(zldpll);
-		if (rc)
-			dev_warn(zldev->dev,
-				 "Failed to re-register DPLL%u\n", zldpll->id);
-	}
+	/* Restart normal operation */
+	rc = zl3073x_dev_start(zldev, false);
+	if (rc)
+		dev_warn(zldev->dev, "Failed to re-start normal operation\n");
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
 
-- 
2.49.1


