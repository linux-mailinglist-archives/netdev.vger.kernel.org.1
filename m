Return-Path: <netdev+bounces-207178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF6B061BC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231747A9020
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E6221FA4;
	Tue, 15 Jul 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkwE4tlk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5F218AB3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590826; cv=none; b=f9JAQ8DIH/vYbKqmjSPTvqBS595tigDQaacWWUBKIu3UxuQ1ox4lixtey9QjENtzGM2QuER/z0h0ElcFNLdvHus0EZJB6DR3YLCPtycPdRi3o30/rlmy9Cx1NOuIZI8K4K0GEDQgLrDdiirU8tghhI8TeXWJ/y/P3M0SRyUpVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590826; c=relaxed/simple;
	bh=vDxMeqGrBAQEnneaUfXsfQq5XI+8d26CKgwTcMD1u0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpVgO+yQIxJf74Rm59AL68DGMXdssRKQjv5iLVPrw5GTrreTb4CJIb9nEOnREK+glGTYZsFun2zljGLy/SSL7nwxvFL1E4NQF9OJ9t5grU7IrHxK3ATsegV8R9ARLlKFMSB1P0cH+dTa/FwZDtVvotXV71GVu5xvlgWCR7tLCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkwE4tlk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmXGbR9Jyh1oS0e4YwvPXHJIFmKBjGRDpR9IuDhHXuI=;
	b=bkwE4tlkof+lDZchShujxm6Lv3rnDKbX074s1kGD2Rc0f3vXw6E+L5aK1d+OVkkBmVPPhd
	xmHcXMpq5WVyYKa1ObuFLdSjj40i4FZ+AeH3bXmQhImzd2oNVAlFD/lI/T2UEc1Qc5wQZF
	clsZrPj8cYKSFqe+UNZv6x3ixH6GZ1A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-l4TVytVENr23nfC3MapFpg-1; Tue,
 15 Jul 2025 10:46:57 -0400
X-MC-Unique: l4TVytVENr23nfC3MapFpg-1
X-Mimecast-MFC-AGG-ID: l4TVytVENr23nfC3MapFpg_1752590816
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34F531956086;
	Tue, 15 Jul 2025 14:46:56 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DDB4619560A7;
	Tue, 15 Jul 2025 14:46:51 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Prathosh Satish <prathosh.satish@microchip.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 3/5] dpll: zl3073x: Implement phase offset monitor feature
Date: Tue, 15 Jul 2025 16:46:31 +0200
Message-ID: <20250715144633.149156-4-ivecera@redhat.com>
In-Reply-To: <20250715144633.149156-1-ivecera@redhat.com>
References: <20250715144633.149156-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Implement phase offset monitor feature to allow a user to monitor
phase offsets across all available inputs.

The device firmware periodically performs phase offsets measurements for
all available DPLL channels and input references. The driver can ask
the firmware to fill appropriate latch registers with measured values.

There are 2 sets of latch registers for phase offsets reporting:

1) DPLL-to-connected-ref: up to 5 registers that contain values for
   phase offset between particular DPLL channel and its connected input
   reference.
2) selected-DPLL-to-ref: 10  registers that contain values for phase
   offsets between selected DPLL channel and all available input
   references.

Both are filled with single read request so the driver can read
DPLL-to-connected-ref phase offset for all DPLL channels at once.
This was implemented in the previous patch.

To read selected-DPLL-to-ref registers for all DPLLs a separate read
request has to be sent to device firmware for each DPLL channel.

To implement phase offset monitor feature:
* Extend zl3073x_ref_phase_offsets_update() to select given DPLL channel
  in phase offset read request. The caller can set channel==-1 if it
  will not read Type2 registers.
* Use this extended function to update phase offset latch registers
  during zl3073x_dpll_changes_check() call if phase monitor is enabled
* Extend zl3073x_dpll_pin_phase_offset_check() to check phase offset
  changes for all available input references
* Extend zl3073x_dpll_input_pin_phase_offset_get() to report phase
  offset values for all available input references
* Implement phase offset monitor callbacks to enable/disable this
  feature

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Prathosh Satish <prathosh.satish@microchip.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* changed type of div_factor to s64
---
 drivers/dpll/zl3073x/core.c |  28 ++++++--
 drivers/dpll/zl3073x/core.h |   1 +
 drivers/dpll/zl3073x/dpll.c | 125 +++++++++++++++++++++++++++++++++---
 drivers/dpll/zl3073x/dpll.h |   2 +
 drivers/dpll/zl3073x/regs.h |   6 ++
 5 files changed, 148 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index c980c85e7ac51..eb62a492b1727 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -672,14 +672,25 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 /**
  * zl3073x_ref_phase_offsets_update - update reference phase offsets
  * @zldev: pointer to zl3073x_dev structure
+ * @channel: DPLL channel number or -1
  *
- * Ask device to update phase offsets latch registers with the latest
- * measured values.
+ * The function asks device to update phase offsets latch registers with
+ * the latest measured values. There are 2 sets of latch registers:
+ *
+ * 1) Up to 5 DPLL-to-connected-ref registers that contain phase offset
+ *    values between particular DPLL channel and its *connected* input
+ *    reference.
+ *
+ * 2) 10 selected-DPLL-to-all-ref registers that contain phase offset values
+ *    between selected DPLL channel and all input references.
+ *
+ * If the caller is interested in 2) then it has to pass DPLL channel number
+ * in @channel parameter. If it is interested only in 1) then it should pass
+ * @channel parameter with value of -1.
  *
  * Return: 0 on success, <0 on error
  */
-static int
-zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev)
+int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 {
 	int rc;
 
@@ -691,6 +702,13 @@ zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev)
 	if (rc)
 		return rc;
 
+	/* Select DPLL channel if it is specified */
+	if (channel != -1) {
+		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_IDX, channel);
+		if (rc)
+			return rc;
+	}
+
 	/* Request to update phase offsets measurement values */
 	rc = zl3073x_write_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
 			      ZL_REF_PHASE_ERR_READ_RQST_RD);
@@ -711,7 +729,7 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	int rc;
 
 	/* Update DPLL-to-connected-ref phase offsets registers */
-	rc = zl3073x_ref_phase_offsets_update(zldev);
+	rc = zl3073x_ref_phase_offsets_update(zldev, -1);
 	if (rc)
 		dev_warn(zldev->dev, "Failed to update phase offsets: %pe\n",
 			 ERR_PTR(rc));
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 97b1032e392d6..1a5edc4975735 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -130,6 +130,7 @@ int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
  *****************/
 
 int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
+int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
 
 static inline bool
 zl3073x_is_n_pin(u8 id)
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 90a99cf91816d..11a7c4a58e257 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -509,6 +509,7 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	u8 conn_ref, ref, ref_status;
+	s64 ref_phase;
 	int rc;
 
 	/* Get currently connected reference */
@@ -516,9 +517,11 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	if (rc)
 		return rc;
 
-	/* Report phase offset only for currently connected pin */
+	/* Report phase offset only for currently connected pin if the phase
+	 * monitor feature is disabled.
+	 */
 	ref = zl3073x_input_pin_ref_get(pin->id);
-	if (ref != conn_ref) {
+	if (!zldpll->phase_monitor && ref != conn_ref) {
 		*phase_offset = 0;
 
 		return 0;
@@ -536,8 +539,37 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 		return 0;
 	}
 
-	/* Report the latest measured phase offset for the connected ref */
-	*phase_offset = pin->phase_offset * DPLL_PHASE_OFFSET_DIVIDER;
+	ref_phase = pin->phase_offset;
+
+	/* The DPLL being locked to a higher freq than the current ref
+	 * the phase offset is modded to the period of the signal
+	 * the dpll is locked to.
+	 */
+	if (ZL3073X_DPLL_REF_IS_VALID(conn_ref) && conn_ref != ref) {
+		u32 conn_freq, ref_freq;
+
+		/* Get frequency of connected ref */
+		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, conn_ref,
+							  &conn_freq);
+		if (rc)
+			return rc;
+
+		/* Get frequency of given ref */
+		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref,
+							  &ref_freq);
+		if (rc)
+			return rc;
+
+		if (conn_freq > ref_freq) {
+			s64 conn_period, div_factor;
+
+			conn_period = div_s64(PSEC_PER_SEC, conn_freq);
+			div_factor = div64_s64(ref_phase, conn_period);
+			ref_phase -= conn_period * div_factor;
+		}
+	}
+
+	*phase_offset = ref_phase * DPLL_PHASE_OFFSET_DIVIDER;
 
 	return rc;
 }
@@ -1343,6 +1375,35 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
+				      void *dpll_priv,
+				      enum dpll_feature_state *state,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	if (zldpll->phase_monitor)
+		*state = DPLL_FEATURE_STATE_ENABLE;
+	else
+		*state = DPLL_FEATURE_STATE_DISABLE;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_phase_offset_monitor_set(const struct dpll_device *dpll,
+				      void *dpll_priv,
+				      enum dpll_feature_state state,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	zldpll->phase_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
+
+	return 0;
+}
+
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
@@ -1368,6 +1429,8 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.lock_status_get = zl3073x_dpll_lock_status_get,
 	.mode_get = zl3073x_dpll_mode_get,
+	.phase_offset_monitor_get = zl3073x_dpll_phase_offset_monitor_get,
+	.phase_offset_monitor_set = zl3073x_dpll_phase_offset_monitor_set,
 };
 
 /**
@@ -1733,16 +1796,47 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
+	unsigned int reg;
 	s64 phase_offset;
+	u8 ref;
 	int rc;
 
-	/* Do not check phase offset if the pin is not connected one */
-	if (pin->pin_state != DPLL_PIN_STATE_CONNECTED)
+	ref = zl3073x_input_pin_ref_get(pin->id);
+
+	/* Select register to read phase offset value depending on pin and
+	 * phase monitor state:
+	 * 1) For connected pin use dpll_phase_err_data register
+	 * 2) For other pins use appropriate ref_phase register if the phase
+	 *    monitor feature is enabled and reference monitor does not
+	 *    report signal errors for given input pin
+	 */
+	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED) {
+		reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
+	} else if (zldpll->phase_monitor) {
+		u8 status;
+
+		/* Get reference monitor status */
+		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref),
+				     &status);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to read %s refmon status: %pe\n",
+				pin->label, ERR_PTR(rc));
+
+			return false;
+		}
+
+		if (status != ZL_REF_MON_STATUS_OK)
+			return false;
+
+		reg = ZL_REG_REF_PHASE(ref);
+	} else {
+		/* The pin is not connected or phase monitor disabled */
 		return false;
+	}
 
-	/* Read DPLL-to-connected-ref phase offset measurement value */
-	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id),
-			      &phase_offset);
+	/* Read measured phase offset value */
+	rc = zl3073x_read_u48(zldev, reg, &phase_offset);
 	if (rc) {
 		dev_err(zldev->dev, "Failed to read ref phase offset: %pe\n",
 			ERR_PTR(rc));
@@ -1807,6 +1901,19 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	    zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
 		return;
 
+	/* Update phase offset latch registers for this DPLL if the phase
+	 * offset monitor feature is enabled.
+	 */
+	if (zldpll->phase_monitor) {
+		rc = zl3073x_ref_phase_offsets_update(zldev, zldpll->id);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to update phase offsets: %pe\n",
+				ERR_PTR(rc));
+			return;
+		}
+	}
+
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		enum dpll_pin_state state;
 		bool pin_changed = false;
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 2e84e56f8c9e1..304910ffc9c07 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -16,6 +16,7 @@
  * @refsel_mode: reference selection mode
  * @forced_ref: selected reference in forced reference lock mode
  * @check_count: periodic check counter
+ * @phase_monitor: is phase offset monitor enabled
  * @dpll_dev: pointer to registered DPLL device
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
@@ -27,6 +28,7 @@ struct zl3073x_dpll {
 	u8				refsel_mode;
 	u8				forced_ref;
 	u8				check_count;
+	bool				phase_monitor;
 	struct dpll_device		*dpll_dev;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 8dde92e623f76..9ee2f44a2eec7 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -101,6 +101,9 @@
 #define ZL_REG_REF_PHASE_ERR_READ_RQST		ZL_REG(4, 0x0f, 1)
 #define ZL_REF_PHASE_ERR_READ_RQST_RD		BIT(0)
 
+#define ZL_REG_REF_PHASE(_idx)						\
+	ZL_REG_IDX(_idx, 4, 0x20, 6, ZL3073X_NUM_REFS, 6)
+
 /***********************
  * Register Page 5, DPLL
  ***********************/
@@ -119,6 +122,9 @@
 #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
 #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
 
+#define ZL_REG_DPLL_MEAS_IDX			ZL_REG(5, 0x51, 1)
+#define ZL_DPLL_MEAS_IDX			GENMASK(2, 0)
+
 #define ZL_REG_DPLL_PHASE_ERR_READ_MASK		ZL_REG(5, 0x54, 1)
 
 #define ZL_REG_DPLL_PHASE_ERR_DATA(_idx)				\
-- 
2.49.1


