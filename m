Return-Path: <netdev+bounces-237285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D8C48724
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146491890DCD
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8BD30FC18;
	Mon, 10 Nov 2025 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipJNQtqS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89430DED0
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797521; cv=none; b=T0gUAhQgiYOWzhJCe1OySxW02vBaBb1D7Yl5ZQbRdZFlQMAQyYv2VNO40OM1aN2bPQHxcFl4iytWvJpIQ15WClWfcacpXZg9oNFvmJwYY7Rfyqo0RbWUkmwWja7c0m6uWnFA0OGsiviJx0qdvBqrl3RokrsnW0i9v689drrEiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797521; c=relaxed/simple;
	bh=iAz+9LMy6ouSjunfp3oRpwLJ5raY4/EUH255IhGSThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwU1Gx+fQBiQoFiekbKwhTNbCKCj8/NJxgBgV28ccvHYuetx4YepdOfjkRo1lEwUVn0oDgh59yN1xSLULwmxbJP9D/LpiGBZUGZ3M4nGwe9oHaBjTd0qlAYsYpwBXSYt/+0AkPRnGcbW0FX1IvVW2737SlIRP5ebpRvXTs23lTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipJNQtqS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762797518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNDk+Jkn9Bp4Hfi5MSOuWur5zajAFR5gvOSE8KTpCN0=;
	b=ipJNQtqSaHtTfOnEBjXuBnS4bosT3wu3jAjH9OhVftFIpvFFSTfi1ljpq3Ps5Yx9B16r2Q
	U82IisbHDcdNsm+2a2r30zR+VVBJG5nGPVzw+7Ct9t8drv9ISS8djpEBpwYRJcpuOTGUPw
	FvXaWPBa3lcrEgtxRuk3KvNGOEeK1+g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-Q7oKjkWTPM2YxHXvYroFuQ-1; Mon,
 10 Nov 2025 12:58:35 -0500
X-MC-Unique: Q7oKjkWTPM2YxHXvYroFuQ-1
X-Mimecast-MFC-AGG-ID: Q7oKjkWTPM2YxHXvYroFuQ_1762797514
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD329195605C;
	Mon, 10 Nov 2025 17:58:33 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.193])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D0AE1800367;
	Mon, 10 Nov 2025 17:58:30 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] dpll: zl3073x: Cache reference monitor status
Date: Mon, 10 Nov 2025 18:58:15 +0100
Message-ID: <20251110175818.1571610-4-ivecera@redhat.com>
In-Reply-To: <20251110175818.1571610-1-ivecera@redhat.com>
References: <20251110175818.1571610-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Instead of reading the ZL_REG_REF_MON_STATUS register every time
the reference status is needed, cache this value in the zl3073x_ref
struct.

This is achieved by:
* Adding a mon_status field to struct zl3073x_ref
* Introducing zl3073x_dev_ref_status_update() to read the status for
  all references into this new cache field
* Calling this update function from the periodic work handler
* Adding zl3073x_ref_is_status_ok() and zl3073x_dev_ref_is_status_ok()
  helpers to check the cached value
* Refactoring all callers in dpll.c to use the new
  zl3073x_dev_ref_is_status_ok() helper, removing direct register reads

This change consolidates all status register reads into a single periodic
function and reduces I/O bus traffic in dpll callbacks.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 18 +++++++
 drivers/dpll/zl3073x/core.h | 15 ++++++
 drivers/dpll/zl3073x/dpll.c | 96 ++++++++-----------------------------
 drivers/dpll/zl3073x/ref.h  | 13 +++++
 4 files changed, 67 insertions(+), 75 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 2f340f7eb9ec3..383e2397dd033 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -591,6 +591,21 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+static void
+zl3073x_dev_ref_status_update(struct zl3073x_dev *zldev)
+{
+	int i, rc;
+
+	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
+		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(i),
+				     &zldev->ref[i].mon_status);
+		if (rc)
+			dev_warn(zldev->dev,
+				 "Failed to get REF%u status: %pe\n", i,
+				 ERR_PTR(rc));
+	}
+}
+
 /**
  * zl3073x_ref_phase_offsets_update - update reference phase offsets
  * @zldev: pointer to zl3073x_dev structure
@@ -710,6 +725,9 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	struct zl3073x_dpll *zldpll;
 	int rc;
 
+	/* Update input references status */
+	zl3073x_dev_ref_status_update(zldev);
+
 	/* Update DPLL-to-connected-ref phase offsets registers */
 	rc = zl3073x_ref_phase_offsets_update(zldev, -1);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fe779fc77dd09..4148580d1f343 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -227,6 +227,21 @@ zl3073x_dev_ref_is_enabled(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_ref_is_enabled(ref);
 }
 
+/*
+ * zl3073x_dev_ref_is_status_ok - check the given input reference status
+ * @zldev: pointer to zl3073x device
+ * @index: input reference index
+ *
+ * Return: true if the status is ok, false otherwise
+ */
+static inline bool
+zl3073x_dev_ref_is_status_ok(struct zl3073x_dev *zldev, u8 index)
+{
+	const struct zl3073x_ref *ref = zl3073x_ref_state_get(zldev, index);
+
+	return zl3073x_ref_is_status_ok(ref);
+}
+
 /**
  * zl3073x_dev_synth_dpll_get - get DPLL ID the synth is driven by
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 62996f26e065f..20c921d6f42cb 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -497,19 +497,10 @@ zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 	if (rc)
 		return rc;
 
-	if (ZL3073X_DPLL_REF_IS_VALID(*ref)) {
-		u8 ref_status;
-
-		/* Read the reference monitor status */
-		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(*ref),
-				     &ref_status);
-		if (rc)
-			return rc;
-
-		/* If the monitor indicates an error nothing is connected */
-		if (ref_status != ZL_REF_MON_STATUS_OK)
-			*ref = ZL3073X_DPLL_REF_NONE;
-	}
+	/* If the monitor indicates an error nothing is connected */
+	if (ZL3073X_DPLL_REF_IS_VALID(*ref) &&
+	    !zl3073x_dev_ref_is_status_ok(zldev, *ref))
+		*ref = ZL3073X_DPLL_REF_NONE;
 
 	return 0;
 }
@@ -524,7 +515,7 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 conn_ref, ref, ref_status;
+	u8 conn_ref, ref;
 	s64 ref_phase;
 	int rc;
 
@@ -537,21 +528,9 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	 * monitor feature is disabled.
 	 */
 	ref = zl3073x_input_pin_ref_get(pin->id);
-	if (!zldpll->phase_monitor && ref != conn_ref) {
-		*phase_offset = 0;
-
-		return 0;
-	}
-
-	/* Get this pin monitor status */
-	rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref), &ref_status);
-	if (rc)
-		return rc;
-
-	/* Report phase offset only if the input pin signal is present */
-	if (ref_status != ZL_REF_MON_STATUS_OK) {
+	if ((!zldpll->phase_monitor && ref != conn_ref) ||
+	    !zl3073x_dev_ref_is_status_ok(zldev, ref)) {
 		*phase_offset = 0;
-
 		return 0;
 	}
 
@@ -777,7 +756,7 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 ref, ref_conn, status;
+	u8 ref, ref_conn;
 	int rc;
 
 	ref = zl3073x_input_pin_ref_get(pin->id);
@@ -797,20 +776,9 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 	 * pin as selectable.
 	 */
 	if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    pin->selectable) {
-		/* Read reference monitor status */
-		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref),
-				     &status);
-		if (rc)
-			return rc;
-
-		/* If the monitor indicates errors report the reference
-		 * as disconnected
-		 */
-		if (status == ZL_REF_MON_STATUS_OK) {
-			*state = DPLL_PIN_STATE_SELECTABLE;
-			return 0;
-		}
+	    zl3073x_dev_ref_is_status_ok(zldev, ref) && pin->selectable) {
+		*state = DPLL_PIN_STATE_SELECTABLE;
+		return 0;
 	}
 
 	/* Otherwise report the pin as disconnected */
@@ -2036,37 +2004,23 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 
 	ref = zl3073x_input_pin_ref_get(pin->id);
 
+	/* No phase offset if the ref monitor reports signal errors */
+	if (!zl3073x_dev_ref_is_status_ok(zldev, ref))
+		return false;
+
 	/* Select register to read phase offset value depending on pin and
 	 * phase monitor state:
 	 * 1) For connected pin use dpll_phase_err_data register
 	 * 2) For other pins use appropriate ref_phase register if the phase
-	 *    monitor feature is enabled and reference monitor does not
-	 *    report signal errors for given input pin
+	 *    monitor feature is enabled.
 	 */
-	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED) {
+	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED)
 		reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
-	} else if (zldpll->phase_monitor) {
-		u8 status;
-
-		/* Get reference monitor status */
-		rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref),
-				     &status);
-		if (rc) {
-			dev_err(zldev->dev,
-				"Failed to read %s refmon status: %pe\n",
-				pin->label, ERR_PTR(rc));
-
-			return false;
-		}
-
-		if (status != ZL_REF_MON_STATUS_OK)
-			return false;
-
+	else if (zldpll->phase_monitor)
 		reg = ZL_REG_REF_PHASE(ref);
-	} else {
+	else
 		/* The pin is not connected or phase monitor disabled */
 		return false;
-	}
 
 	/* Read measured phase offset value */
 	rc = zl3073x_read_u48(zldev, reg, &phase_offset);
@@ -2105,22 +2059,14 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 ref, status;
 	s64 ffo;
-	int rc;
+	u8 ref;
 
 	/* Get reference monitor status */
 	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref), &status);
-	if (rc) {
-		dev_err(zldev->dev, "Failed to read %s refmon status: %pe\n",
-			pin->label, ERR_PTR(rc));
-
-		return false;
-	}
 
 	/* Do not report ffo changes if the reference monitor report errors */
-	if (status != ZL_REF_MON_STATUS_OK)
+	if (!zl3073x_dev_ref_is_status_ok(zldev, ref))
 		return false;
 
 	/* Get the latest measured ref's ffo */
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index e72f2c8750876..7cd44c377f51f 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -18,6 +18,7 @@ struct zl3073x_dev;
 struct zl3073x_ref {
 	s64	ffo;
 	u8	config;
+	u8	mon_status;
 };
 
 int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index);
@@ -63,4 +64,16 @@ zl3073x_ref_is_enabled(const struct zl3073x_ref *ref)
 	return !!FIELD_GET(ZL_REF_CONFIG_ENABLE, ref->config);
 }
 
+/**
+ * zl3073x_ref_is_status_ok - check the given input reference status
+ * @ref: pointer to ref state
+ *
+ * Return: true if the status is ok, false otherwise
+ */
+static inline bool
+zl3073x_ref_is_status_ok(const struct zl3073x_ref *ref)
+{
+	return ref->mon_status == ZL_REF_MON_STATUS_OK;
+}
+
 #endif /* _ZL3073X_REF_H */
-- 
2.51.0


