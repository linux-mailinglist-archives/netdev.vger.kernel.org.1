Return-Path: <netdev+bounces-237717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8BC4F63E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7418E3BED49
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B133730E4;
	Tue, 11 Nov 2025 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckxenhMo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675636CE0C
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884800; cv=none; b=pGoz5Bvahi9A1zg1d39pJRdfJ8eBm0lExR6XzYaN679EfGDd/B3dFWlk+ECyq8i8KW8/Opv5zf15gjB7ZDl098KqfCjDpCgtFfM/2+P+m9B4+AGfIzpvyGk+omkiPPFGtH59sx9llLGMgi8bX1gLBv0RaH0D2eOjcxWhcjcA15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884800; c=relaxed/simple;
	bh=O3QsYRJE44QVq9Tpp/0am+Ne68IX6wk4KmzUjQkljcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPMyEIpDwKWNTtGYCf9i9BMjnZ7Q39skIsUw+XzkV9im+s83kRQANAUeP7kMwXrjns2I0rKKQNKc2OrSTaOAz9puihH9/jThbCMKHfZJQjPbPvNKyOxtlVsJqs3fMxeAz3Y/WEMM+9AwJ6Vczi+0Kc9iJjDBSNIPlVRCHhCPmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckxenhMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QqntytoBUPhzeNeS9m8PMu4HfR1n/tg0WIazAd3EsY4=;
	b=ckxenhMoshVezr88dQnViIVhGzZdz9woVXBforc7CGn2hQrf1pNINZU43JOuxPmG2EunFJ
	fK8ALUSd6v/r1cegK6cItGr5qJcl2U45yGP4gw8Rk9yC2p/l26kdEqwNXlkCOVxn0SPJJG
	4moAZfF2S3XInY5dkv71EXipfmGE7cs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-3QbH6ByjPFG9LjcAj3OjRQ-1; Tue,
 11 Nov 2025 13:13:12 -0500
X-MC-Unique: 3QbH6ByjPFG9LjcAj3OjRQ-1
X-Mimecast-MFC-AGG-ID: 3QbH6ByjPFG9LjcAj3OjRQ_1762884791
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B6EE195608F;
	Tue, 11 Nov 2025 18:13:11 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62161800269;
	Tue, 11 Nov 2025 18:13:05 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/6] dpll: zl3073x: Cache reference monitor status
Date: Tue, 11 Nov 2025 19:12:40 +0100
Message-ID: <20251111181243.4570-4-ivecera@redhat.com>
In-Reply-To: <20251111181243.4570-1-ivecera@redhat.com>
References: <20251111181243.4570-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Changes:
v2:
- added .mon_status field description
---
 drivers/dpll/zl3073x/core.c | 18 +++++++
 drivers/dpll/zl3073x/core.h | 15 ++++++
 drivers/dpll/zl3073x/dpll.c | 96 ++++++++-----------------------------
 drivers/dpll/zl3073x/ref.h  | 14 ++++++
 4 files changed, 68 insertions(+), 75 deletions(-)

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
index e72f2c8750876..c4931e545d24d 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -14,10 +14,12 @@ struct zl3073x_dev;
  * struct zl3073x_ref - input reference state
  * @ffo: current fractional frequency offset
  * @config: reference config
+ * @mon_status: reference monitor status
  */
 struct zl3073x_ref {
 	s64	ffo;
 	u8	config;
+	u8	mon_status;
 };
 
 int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index);
@@ -63,4 +65,16 @@ zl3073x_ref_is_enabled(const struct zl3073x_ref *ref)
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


