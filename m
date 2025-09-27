Return-Path: <netdev+bounces-226872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC5BA5BA0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0A01C01073
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712712D7DC7;
	Sat, 27 Sep 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBBj4no1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261E2D73AE
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962986; cv=none; b=EgnBnQeue/Yv9xEqNcUYRAFTSjTTFuofqzycnsV9pratJylG2MIC2bAPWXeCBLExO2ZYxjGwmltO9e4VQiqLrnMXjFSgbWdWXrELKsxZXpySkSRmYojR2xaptWZtY+WB+KWapPYMRU3A6gRJ62MwUmeiYRR7h4pX28TXcB5mTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962986; c=relaxed/simple;
	bh=/IgQnJCnGX6fG3NdzsNmxjlgcsRzIXp0vXJ8NzAyuSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7yK80MCTNZkJVVfeUaei2CJSZ1IEmw5xC1MDfbJ01xO2P6+ueJIqMjkUGHYv7DynqXtqPke0YFdvDe64nn7VgliUd5PVAV2DRxY6FDt3XmsBHbw/fsQ/MlviL3jBHKPToEESQWg84L5IBGePGuJI2iU7a4ow8oFSeZQm6SVHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBBj4no1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758962983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8T4PaaPN7zfedDHydP2IIt2YeJgWHExSLyVVowMgVM=;
	b=EBBj4no1vAVc8yXHmAAxU2allb50AVTBBkVqmqpRXpEpcO+7XHmAXApOGGTg014E4WC+tO
	Q93GrAbaFcnXTS9H2M5CIWZDWjhGL7iolC9d3sD60kPi9Pe+3SMb9+oO1P5yH3FPs8R6i3
	IlNbYAjNzWy2bGQ5dBElmzLXzSdrenI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-RbjiFlwVNxiemWPmJgzSQA-1; Sat,
 27 Sep 2025 04:49:40 -0400
X-MC-Unique: RbjiFlwVNxiemWPmJgzSQA-1
X-Mimecast-MFC-AGG-ID: RbjiFlwVNxiemWPmJgzSQA_1758962978
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C949719560BB;
	Sat, 27 Sep 2025 08:49:37 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 871F019560A2;
	Sat, 27 Sep 2025 08:49:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 3/3] dpll: zl3073x: Allow to configure phase offset averaging factor
Date: Sat, 27 Sep 2025 10:49:12 +0200
Message-ID: <20250927084912.2343597-4-ivecera@redhat.com>
In-Reply-To: <20250927084912.2343597-1-ivecera@redhat.com>
References: <20250927084912.2343597-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The DPLL phase measurement block uses an exponential moving average with
a configurable averaging factor. Measurements are taken at approximately
40 Hz or at the reference frequency, whichever is lower.

Currently, factor=2 is used to prioritize fast response for dynamic
phase changes. For applications needing a stable, precise average phase
offset where rapid changes are unlikely, a higher factor is recommended.

Implement the .phase_offset_avg_factor_get/set callbacks to allow a user
to adjust this factor.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* INIT_WORK moved to zl3073x_dpll_alloc()
---
 drivers/dpll/zl3073x/core.c | 38 +++++++++++++++++++++---
 drivers/dpll/zl3073x/core.h | 15 ++++++++--
 drivers/dpll/zl3073x/dpll.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.h |  2 ++
 4 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index e96095baac657..092e7027948a4 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -956,6 +956,32 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(500));
 }
 
+int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor)
+{
+	u8 dpll_meas_ctrl, value;
+	int rc;
+
+	/* Read DPLL phase measurement control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Convert requested factor to register value */
+	value = (factor + 1) & 0x0f;
+
+	/* Update phase measurement control register */
+	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
+	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, value);
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Save the new factor */
+	zldev->phase_avg_factor = factor;
+
+	return 0;
+}
+
 /**
  * zl3073x_dev_phase_meas_setup - setup phase offset measurement
  * @zldev: pointer to zl3073x_dev structure
@@ -972,15 +998,16 @@ zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev)
 	u8 dpll_meas_ctrl, mask = 0;
 	int rc;
 
+	/* Setup phase measurement averaging factor */
+	rc = zl3073x_dev_phase_avg_factor_set(zldev, zldev->phase_avg_factor);
+	if (rc)
+		return rc;
+
 	/* Read DPLL phase measurement control register */
 	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
 	if (rc)
 		return rc;
 
-	/* Setup phase measurement averaging factor */
-	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
-
 	/* Enable DPLL measurement block */
 	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
 
@@ -1208,6 +1235,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	 */
 	zldev->clock_id = get_random_u64();
 
+	/* Default phase offset averaging factor */
+	zldev->phase_avg_factor = 2;
+
 	/* Initialize mutex for operations where multiple reads, writes
 	 * and/or polls are required to be done atomically.
 	 */
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 128fb899cafc3..1dca4ddcf2350 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -68,19 +68,19 @@ struct zl3073x_synth {
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
- * @clock_id: clock id of the device
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
  * @dplls: list of DPLLs
  * @kworker: thread for periodic work
  * @work: periodic work
+ * @clock_id: clock id of the device
+ * @phase_avg_factor: phase offset measurement averaging factor
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
-	u64			clock_id;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -93,6 +93,10 @@ struct zl3073x_dev {
 	/* Monitor */
 	struct kthread_worker		*kworker;
 	struct kthread_delayed_work	work;
+
+	/* Devlink parameters */
+	u64			clock_id;
+	u8			phase_avg_factor;
 };
 
 struct zl3073x_chip_info {
@@ -115,6 +119,13 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full);
 void zl3073x_dev_stop(struct zl3073x_dev *zldev);
 
+static inline u8 zl3073x_dev_phase_avg_factor_get(struct zl3073x_dev *zldev)
+{
+	return zldev->phase_avg_factor;
+}
+
+int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor);
+
 /**********************
  * Registers operations
  **********************/
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 3e42e9e7fd272..93dc93eec79ed 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1576,6 +1576,59 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_phase_offset_avg_factor_get(const struct dpll_device *dpll,
+					 void *dpll_priv, u32 *factor,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	*factor = zl3073x_dev_phase_avg_factor_get(zldpll->dev);
+
+	return 0;
+}
+
+static void
+zl3073x_dpll_change_work(struct work_struct *work)
+{
+	struct zl3073x_dpll *zldpll;
+
+	zldpll = container_of(work, struct zl3073x_dpll, change_work);
+	dpll_device_change_ntf(zldpll->dpll_dev);
+}
+
+static int
+zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
+					 void *dpll_priv, u32 factor,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *item, *zldpll = dpll_priv;
+	int rc;
+
+	if (factor > 15) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Phase offset average factor has to be from range <0,15>");
+		return -EINVAL;
+	}
+
+	rc = zl3073x_dev_phase_avg_factor_set(zldpll->dev, factor);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Failed to set phase offset averaging factor");
+		return rc;
+	}
+
+	/* The averaging factor is common for all DPLL channels so after change
+	 * we have to send a notification for other DPLL devices.
+	 */
+	list_for_each_entry(item, &zldpll->dev->dplls, list) {
+		if (item != zldpll)
+			schedule_work(&item->change_work);
+	}
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 				      void *dpll_priv,
@@ -1635,6 +1688,8 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.lock_status_get = zl3073x_dpll_lock_status_get,
 	.mode_get = zl3073x_dpll_mode_get,
+	.phase_offset_avg_factor_get = zl3073x_dpll_phase_offset_avg_factor_get,
+	.phase_offset_avg_factor_set = zl3073x_dpll_phase_offset_avg_factor_set,
 	.phase_offset_monitor_get = zl3073x_dpll_phase_offset_monitor_get,
 	.phase_offset_monitor_set = zl3073x_dpll_phase_offset_monitor_set,
 };
@@ -1983,6 +2038,8 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 {
 	WARN(!zldpll->dpll_dev, "DPLL device is not registered\n");
 
+	cancel_work_sync(&zldpll->change_work);
+
 	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
 			       zldpll);
 	dpll_device_put(zldpll->dpll_dev);
@@ -2258,6 +2315,7 @@ zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
 	zldpll->dev = zldev;
 	zldpll->id = ch;
 	INIT_LIST_HEAD(&zldpll->pins);
+	INIT_WORK(&zldpll->change_work, zl3073x_dpll_change_work);
 
 	return zldpll;
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 304910ffc9c07..e8c39b44b356c 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -20,6 +20,7 @@
  * @dpll_dev: pointer to registered DPLL device
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
+ * @change_work: device change notification work
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -32,6 +33,7 @@ struct zl3073x_dpll {
 	struct dpll_device		*dpll_dev;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
+	struct work_struct		change_work;
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
-- 
2.49.1


