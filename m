Return-Path: <netdev+bounces-205856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16116B00775
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B62172391
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DF279DBC;
	Thu, 10 Jul 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDvidHWG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15C27990B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161951; cv=none; b=kSghQ5Rg4Vlka0vfgbcXGXwhhaoi5yP2EmYybnRAAiic0yHwOYncmExhYKN0Dmlou4+g5mSt6ZYDIvOsbHORelW8QbdiHRyh3pO6lDj53+pPUyF6E5fqBplV7hoA/ZQOTLovMPIQPmOxWwgbKvqaFvmsj9lToCK7w9jMtC1uZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161951; c=relaxed/simple;
	bh=fDTCLEcoLTEYLrqhScu3MiK/4bZ/utt039W2mQR94LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwMDlrPnGGhakcy8aAhkcXximuOWbgL2xYPEh3LHsLq+rnMb0wDv6Yx8vVooxQHxUAhV595Cd9jJdlNJQtnN7KdFtcjM7cPxjqZ/fOK6bgNgudZ1Q7T0j9a0+3WBspQH/I9tfjbwNH0+azBaj2fcyETVCMUuDaOkB819+udPHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDvidHWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752161948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tewXCl7aPES6lAsQMFoyqNd1rcWypSmm5JQyoOpONic=;
	b=dDvidHWG2zqa0J+0isymXlxY5Y2Ero0DR8BZVLo6i+PAxq4BXoZFopiIE4HA+ptsgWMaEm
	9vIBG0RARdsB0LMY053FsUNPr1CSKX0NnzPMioroFf4kIF/9MhYAVq6BNzhNBpk7nW+MKw
	fNlrIWjrCVOA2bZ9M4wdnD9SExBjQmo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-trqHGjyMNTi7TanHC5wPYQ-1; Thu,
 10 Jul 2025 11:39:03 -0400
X-MC-Unique: trqHGjyMNTi7TanHC5wPYQ-1
X-Mimecast-MFC-AGG-ID: trqHGjyMNTi7TanHC5wPYQ_1752161941
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CE9719560B0;
	Thu, 10 Jul 2025 15:39:01 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C57B71956094;
	Thu, 10 Jul 2025 15:38:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 2/5] dpll: zl3073x: Add support to get phase offset on connected input pin
Date: Thu, 10 Jul 2025 17:38:45 +0200
Message-ID: <20250710153848.928531-3-ivecera@redhat.com>
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add support to get phase offset for the connected input pin. Implement
the appropriate callback and function that performs DPLL to connected
reference phase error measurement and notifies DPLL core about changes.

The measurement is performed internally by device on background 40 times
per second but the measured value is read each second and compared with
previous value.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c |  86 +++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.c | 105 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h |   2 +
 drivers/dpll/zl3073x/regs.h |  16 ++++++
 4 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index f2d58e1a56726..c980c85e7ac51 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -669,12 +669,52 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+/**
+ * zl3073x_ref_phase_offsets_update - update reference phase offsets
+ * @zldev: pointer to zl3073x_dev structure
+ *
+ * Ask device to update phase offsets latch registers with the latest
+ * measured values.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev)
+{
+	int rc;
+
+	/* Per datasheet we have to wait for 'dpll_ref_phase_err_rqst_rd'
+	 * to be zero to ensure that the measured data are coherent.
+	 */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
+				  ZL_REF_PHASE_ERR_READ_RQST_RD);
+	if (rc)
+		return rc;
+
+	/* Request to update phase offsets measurement values */
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
+			      ZL_REF_PHASE_ERR_READ_RQST_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for finish */
+	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_PHASE_ERR_READ_RQST,
+				    ZL_REF_PHASE_ERR_READ_RQST_RD);
+}
+
 static void
 zl3073x_dev_periodic_work(struct kthread_work *work)
 {
 	struct zl3073x_dev *zldev = container_of(work, struct zl3073x_dev,
 						 work.work);
 	struct zl3073x_dpll *zldpll;
+	int rc;
+
+	/* Update DPLL-to-connected-ref phase offsets registers */
+	rc = zl3073x_ref_phase_offsets_update(zldev);
+	if (rc)
+		dev_warn(zldev->dev, "Failed to update phase offsets: %pe\n",
+			 ERR_PTR(rc));
 
 	list_for_each_entry(zldpll, &zldev->dplls, list)
 		zl3073x_dpll_changes_check(zldpll);
@@ -767,6 +807,46 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	return rc;
 }
 
+/**
+ * zl3073x_dev_phase_meas_setup - setup phase offset measurement
+ * @zldev: pointer to zl3073x_dev structure
+ * @num_channels: number of DPLL channels
+ *
+ * Enable phase offset measurement block, set measurement averaging factor
+ * and enable DPLL-to-its-ref phase measurement for all DPLLs.
+ *
+ * Returns: 0 on success, <0 on error
+ */
+static int
+zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev, int num_channels)
+{
+	u8 dpll_meas_ctrl, mask;
+	int i, rc;
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
+	for (i = 0, mask = 0; i < num_channels; i++)
+		mask |= BIT(i);
+
+	return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
+}
+
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -839,6 +919,12 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
+	/* Setup phase offset measurement block */
+	rc = zl3073x_dev_phase_meas_setup(zldev, chip_info->num_channels);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to setup phase measurement\n");
+
 	/* Register DPLL channels */
 	rc = zl3073x_devm_dpll_init(zldev, chip_info->num_channels);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 2af20532b1ca0..1a1d4de5b9de5 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -36,6 +36,7 @@
  * @selectable: pin is selectable in automatic mode
  * @esync_control: embedded sync is controllable
  * @pin_state: last saved pin state
+ * @phase_offset: last saved pin phase offset
  */
 struct zl3073x_dpll_pin {
 	struct list_head	list;
@@ -48,6 +49,7 @@ struct zl3073x_dpll_pin {
 	bool			selectable;
 	bool			esync_control;
 	enum dpll_pin_state	pin_state;
+	s64			phase_offset;
 };
 
 /*
@@ -496,6 +498,50 @@ zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 	return 0;
 }
 
+static int
+zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv, s64 *phase_offset,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 conn_ref, ref, ref_status;
+	int rc;
+
+	/* Get currently connected reference */
+	rc = zl3073x_dpll_connected_ref_get(zldpll, &conn_ref);
+	if (rc)
+		return rc;
+
+	/* Report phase offset only for currently connected pin */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	if (ref != conn_ref) {
+		*phase_offset = 0;
+
+		return 0;
+	}
+
+	/* Get this pin monitor status */
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref), &ref_status);
+	if (rc)
+		return rc;
+
+	/* Report phase offset only if the input pin signal is present */
+	if (ref_status != ZL_REF_MON_STATUS_OK) {
+		*phase_offset = 0;
+
+		return 0;
+	}
+
+	/* Report the latest measured phase offset for the connected ref */
+	*phase_offset = pin->phase_offset * DPLL_PHASE_OFFSET_DIVIDER;
+
+	return rc;
+}
+
 /**
  * zl3073x_dpll_ref_prio_get - get priority for given input pin
  * @pin: pointer to pin
@@ -1296,6 +1342,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.esync_set = zl3073x_dpll_input_pin_esync_set,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
+	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
@@ -1666,6 +1713,51 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 	zldpll->dpll_dev = NULL;
 }
 
+/**
+ * zl3073x_dpll_pin_phase_offset_check - check for pin phase offset change
+ * @pin: pin to check
+ *
+ * Check for the change of DPLL to connected pin phase offset change.
+ *
+ * Return: true on phase offset change, false otherwise
+ */
+static bool
+zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	s64 phase_offset;
+	int rc;
+
+	/* Do not check phase offset if the pin is not connected one */
+	if (pin->pin_state != DPLL_PIN_STATE_CONNECTED)
+		return false;
+
+	/* Read DPLL-to-connected-ref phase offset measurement value */
+	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id),
+			      &phase_offset);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to read ref phase offset: %pe\n",
+			ERR_PTR(rc));
+
+		return false;
+	}
+
+	/* Convert to ps */
+	phase_offset = div_s64(sign_extend64(phase_offset, 47), 100);
+
+	/* Compare with previous value */
+	if (phase_offset != pin->phase_offset) {
+		dev_dbg(zldev->dev, "%s phase offset changed: %lld -> %lld\n",
+			pin->label, pin->phase_offset, phase_offset);
+		pin->phase_offset = phase_offset;
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * zl3073x_dpll_changes_check - check for changes and send notifications
  * @zldpll: pointer to zl3073x_dpll structure
@@ -1684,6 +1776,8 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	struct zl3073x_dpll_pin *pin;
 	int rc;
 
+	zldpll->check_count++;
+
 	/* Get current lock status for the DPLL */
 	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
 					  &lock_status, NULL, NULL);
@@ -1708,6 +1802,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		enum dpll_pin_state state;
+		bool pin_changed = false;
 
 		/* Output pins change checks are not necessary because output
 		 * states are constant.
@@ -1727,8 +1822,16 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 			dev_dbg(dev, "%s state changed: %u->%u\n", pin->label,
 				pin->pin_state, state);
 			pin->pin_state = state;
-			dpll_pin_change_ntf(pin->dpll_pin);
+			pin_changed = true;
 		}
+
+		/* Check for phase offset change once per second */
+		if (zldpll->check_count % 2 == 0)
+			if (zl3073x_dpll_pin_phase_offset_check(pin))
+				pin_changed = true;
+
+		if (pin_changed)
+			dpll_pin_change_ntf(pin->dpll_pin);
 	}
 }
 
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index db7388cc377fd..2e84e56f8c9e1 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -15,6 +15,7 @@
  * @id: DPLL index
  * @refsel_mode: reference selection mode
  * @forced_ref: selected reference in forced reference lock mode
+ * @check_count: periodic check counter
  * @dpll_dev: pointer to registered DPLL device
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
@@ -25,6 +26,7 @@ struct zl3073x_dpll {
 	u8				id;
 	u8				refsel_mode;
 	u8				forced_ref;
+	u8				check_count;
 	struct dpll_device		*dpll_dev;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 64bb43bbc3168..8dde92e623f76 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -94,6 +94,13 @@
 #define ZL_DPLL_REFSEL_STATUS_STATE		GENMASK(6, 4)
 #define ZL_DPLL_REFSEL_STATUS_STATE_LOCK	4
 
+/**********************
+ * Register Page 4, Ref
+ **********************/
+
+#define ZL_REG_REF_PHASE_ERR_READ_RQST		ZL_REG(4, 0x0f, 1)
+#define ZL_REF_PHASE_ERR_READ_RQST_RD		BIT(0)
+
 /***********************
  * Register Page 5, DPLL
  ***********************/
@@ -108,6 +115,15 @@
 #define ZL_DPLL_MODE_REFSEL_MODE_NCO		4
 #define ZL_DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
 
+#define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
+#define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
+#define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
+
+#define ZL_REG_DPLL_PHASE_ERR_READ_MASK		ZL_REG(5, 0x54, 1)
+
+#define ZL_REG_DPLL_PHASE_ERR_DATA(_idx)				\
+	ZL_REG_IDX(_idx, 5, 0x55, 6, ZL3073X_MAX_CHANNELS, 6)
+
 /***********************************
  * Register Page 9, Synth and Output
  ***********************************/
-- 
2.49.0


