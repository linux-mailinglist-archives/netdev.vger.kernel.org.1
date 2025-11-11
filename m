Return-Path: <netdev+bounces-237718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1725C4F64A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B73A4E6D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF33A5E9B;
	Tue, 11 Nov 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVFiwY+U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69520FA81
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884808; cv=none; b=T7cuVmyrOaXqIMBuWh+bxvsh+LeG8F3YUFAFGu9N/bBojKIGooFC5wgcdsi7b45XYDhQunKos0a4+S9fqbgQn5LMsts2xl/mTAbBGMXg2OWiQ2aKE9gADUkj8QzaGKxEEh5RwxBJB3UQjbWfY9ThAwEZaO2igB7ZftRmmURzTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884808; c=relaxed/simple;
	bh=CRcHRggKsi4qcvDV7aVH5JFmE+qI5bv/KwXU6U5rdnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWQ3cw+APFTemN4gOtgcjQD952xJKJQodbxA/DTZCK1ykOZBYf3q5W5BPOtRv0YW3ohyZ3SZJnMQm0MMCY7ix/HzhdwOga19JsGpxhhdciKSWECnSOphdFDbPyiMu54FNvEFcO4PcXPtXBWgvqxU1ub0bqA4A08mlNBe3Ap55vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVFiwY+U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6tXJ9rSOi3i8HzjDUp5wYo1XlXSDf2fkok3dH7CYDw=;
	b=iVFiwY+UXLA6zFt1iVX8A/qV66f7kJsO2Z9tEjsVmkEpRwEPYU4enYapWM0XPRexGj7ioo
	hNSEKLMsr07SZIteqOt/jVuCvjzxonW/GQN1+10y+MO6Vzc73sBIjktMSmhtsOEngfwL3O
	tMZhM7FqYp7YidUUe9Pwx70Oq40W2eg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-iXDjdfESMOiwxWfQoYYg5Q-1; Tue,
 11 Nov 2025 13:13:19 -0500
X-MC-Unique: iXDjdfESMOiwxWfQoYYg5Q-1
X-Mimecast-MFC-AGG-ID: iXDjdfESMOiwxWfQoYYg5Q_1762884797
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA98C18002C8;
	Tue, 11 Nov 2025 18:13:17 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2001F1800947;
	Tue, 11 Nov 2025 18:13:11 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/6] dpll: zl3073x: Cache all reference properties in zl3073x_ref
Date: Tue, 11 Nov 2025 19:12:41 +0100
Message-ID: <20251111181243.4570-5-ivecera@redhat.com>
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

Expand the zl3073x_ref structure to cache all reference-related
hardware registers, including frequency components, embedded-sync
settings  and phase compensation. Previously, these registers were
read on-demand from various functions in dpll.c leading to frequent
mailbox operations.

Modify zl3073x_ref_state_fetch() to read and populate all these new
fields at once. Refactor all "getter" functions in dpll.c to read
from this new cached state instead of performing direct register
access.

Remove the standalone zl3073x_dpll_input_ref_frequency_get() helper,
as its functionality is now replaced by zl3073x_ref_freq_get() which
operates on the cached state and add a corresponding zl3073x_dev_...
wrapper.

Introduce a new function, zl3073x_ref_state_set(), to handle
writing changes back to the hardware. This function compares the
provided state with the current cached state and writes *only* the
modified register values to the device via a single mailbox sequence
before updating the local cache.

Refactor all dpll "setter" functions to modify a local copy of the
ref state and then call zl3073x_ref_state_set() to commit the changes.

As a cleanup, update callers in dpll.c that already have
a struct zl3073x_ref * to use the direct helpers instead of the
zl3073x_dev_... wrappers.

This change centralizes all reference-related register I/O into ref.c,
significantly reduces bus traffic, and simplifies the logic in dpll.c.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
v2
- removed one set-but-not-used variable
- added new fields' description in zl3073x_ref
- dropped usage of ZL3073X_REF_SYNC_ONE
---
 drivers/dpll/zl3073x/core.h |  15 ++
 drivers/dpll/zl3073x/dpll.c | 308 +++++++++---------------------------
 drivers/dpll/zl3073x/ref.c  |  85 ++++++++++
 drivers/dpll/zl3073x/ref.h  |  54 +++++++
 4 files changed, 231 insertions(+), 231 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 4148580d1f343..fe8b70e25d3cc 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -197,6 +197,21 @@ zl3073x_dev_ref_ffo_get(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_ref_ffo_get(ref);
 }
 
+/**
+ * zl3073x_dev_ref_freq_get - get input reference frequency
+ * @zldev: pointer to zl3073x device
+ * @index: input reference index
+ *
+ * Return: frequency of given input reference
+ */
+static inline u32
+zl3073x_dev_ref_freq_get(struct zl3073x_dev *zldev, u8 index)
+{
+	const struct zl3073x_ref *ref = zl3073x_ref_state_get(zldev, index);
+
+	return zl3073x_ref_freq_get(ref);
+}
+
 /**
  * zl3073x_dev_ref_is_diff - check if the given input reference is differential
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 20c921d6f42cb..e0d696bc1909e 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -100,60 +100,6 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
-/**
- * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
- * @zldpll: pointer to zl3073x_dpll
- * @ref_id: reference id
- * @frequency: pointer to variable to store frequency
- *
- * Reads frequency of given input reference.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
-				     u32 *frequency)
-{
-	struct zl3073x_dev *zldev = zldpll->dev;
-	u16 base, mult, num, denom;
-	int rc;
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read reference configuration */
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref_id));
-	if (rc)
-		return rc;
-
-	/* Read registers to compute resulting frequency */
-	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
-	if (rc)
-		return rc;
-	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
-	if (rc)
-		return rc;
-	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
-	if (rc)
-		return rc;
-	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
-	if (rc)
-		return rc;
-
-	/* Sanity check that HW has not returned zero denominator */
-	if (!denom) {
-		dev_err(zldev->dev,
-			"Zero divisor for ref %u frequency got from device\n",
-			ref_id);
-		return -EINVAL;
-	}
-
-	/* Compute the frequency */
-	*frequency = mul_u64_u32_div(base * mult, num, denom);
-
-	return rc;
-}
-
 static int
 zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 				 void *pin_priv,
@@ -165,39 +111,15 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 ref, ref_sync_ctrl, sync_mode;
-	u32 esync_div, ref_freq;
-	int rc;
-
-	/* Get reference frequency */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_dpll_input_ref_frequency_get(zldpll, pin->id, &ref_freq);
-	if (rc)
-		return rc;
+	const struct zl3073x_ref *ref;
+	u8 ref_id;
 
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read reference configuration into mailbox */
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref));
-	if (rc)
-		return rc;
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
 
-	/* Get ref sync mode */
-	rc = zl3073x_read_u8(zldev, ZL_REG_REF_SYNC_CTRL, &ref_sync_ctrl);
-	if (rc)
-		return rc;
-
-	/* Get esync divisor */
-	rc = zl3073x_read_u32(zldev, ZL_REG_REF_ESYNC_DIV, &esync_div);
-	if (rc)
-		return rc;
-
-	sync_mode = FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref_sync_ctrl);
-
-	switch (sync_mode) {
+	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
 	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
-		esync->freq = (esync_div == ZL_REF_ESYNC_DIV_1HZ) ? 1 : 0;
+		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
 		esync->pulse = 25;
 		break;
 	default:
@@ -209,7 +131,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	/* If the pin supports esync control expose its range but only
 	 * if the current reference frequency is > 1 Hz.
 	 */
-	if (pin->esync_control && ref_freq > 1) {
+	if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
 		esync->range = esync_freq_ranges;
 		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 	} else {
@@ -217,7 +139,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 		esync->range_num = 0;
 	}
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -230,22 +152,11 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 ref, ref_sync_ctrl, sync_mode;
-	int rc;
+	struct zl3073x_ref ref;
+	u8 ref_id, sync_mode;
 
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read reference configuration into mailbox */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref));
-	if (rc)
-		return rc;
-
-	/* Get ref sync mode */
-	rc = zl3073x_read_u8(zldev, ZL_REG_REF_SYNC_CTRL, &ref_sync_ctrl);
-	if (rc)
-		return rc;
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = *zl3073x_ref_state_get(zldev, ref_id);
 
 	/* Use freq == 0 to disable esync */
 	if (!freq)
@@ -253,25 +164,16 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	else
 		sync_mode = ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
 
-	ref_sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
-	ref_sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
-
-	/* Update ref sync control register */
-	rc = zl3073x_write_u8(zldev, ZL_REG_REF_SYNC_CTRL, ref_sync_ctrl);
-	if (rc)
-		return rc;
+	ref.sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
+	ref.sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
 
 	if (freq) {
-		/* 1 Hz is only supported frequnecy currently */
-		rc = zl3073x_write_u32(zldev, ZL_REG_REF_ESYNC_DIV,
-				       ZL_REF_ESYNC_DIV_1HZ);
-		if (rc)
-			return rc;
+		/* 1 Hz is only supported frequency now */
+		ref.esync_n_div = ZL_REF_ESYNC_DIV_1HZ;
 	}
 
-	/* Commit reference configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
-			     ZL_REG_REF_MB_MASK, BIT(ref));
+	/* Update reference configuration */
+	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
 static int
@@ -295,17 +197,12 @@ zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u32 ref_freq;
-	u8 ref;
-	int rc;
+	u8 ref_id;
 
-	/* Read and return ref frequency */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref, &ref_freq);
-	if (!rc)
-		*frequency = ref_freq;
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	*frequency = zl3073x_dev_ref_freq_get(zldpll->dev, ref_id);
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -318,39 +215,18 @@ zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u16 base, mult;
-	u8 ref;
-	int rc;
-
-	/* Get base frequency and multiplier for the requested frequency */
-	rc = zl3073x_ref_freq_factorize(frequency, &base, &mult);
-	if (rc)
-		return rc;
+	struct zl3073x_ref ref;
+	u8 ref_id;
 
-	guard(mutex)(&zldev->multiop_lock);
+	/* Get reference state */
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = *zl3073x_ref_state_get(zldev, ref_id);
 
-	/* Load reference configuration */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref));
+	/* Update frequency */
+	zl3073x_ref_freq_set(&ref, frequency);
 
-	/* Update base frequency, multiplier, numerator & denominator */
-	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_BASE, base);
-	if (rc)
-		return rc;
-	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_MULT, mult);
-	if (rc)
-		return rc;
-	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_M, 1);
-	if (rc)
-		return rc;
-	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_N, 1);
-	if (rc)
-		return rc;
-
-	/* Commit reference configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
-			     ZL_REG_REF_MB_MASK, BIT(ref));
+	/* Commit reference state */
+	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
 /**
@@ -515,21 +391,24 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 conn_ref, ref;
+	const struct zl3073x_ref *ref;
+	u8 conn_id, ref_id;
 	s64 ref_phase;
 	int rc;
 
 	/* Get currently connected reference */
-	rc = zl3073x_dpll_connected_ref_get(zldpll, &conn_ref);
+	rc = zl3073x_dpll_connected_ref_get(zldpll, &conn_id);
 	if (rc)
 		return rc;
 
 	/* Report phase offset only for currently connected pin if the phase
-	 * monitor feature is disabled.
+	 * monitor feature is disabled and only if the input pin signal is
+	 * present.
 	 */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	if ((!zldpll->phase_monitor && ref != conn_ref) ||
-	    !zl3073x_dev_ref_is_status_ok(zldev, ref)) {
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
+	if ((!zldpll->phase_monitor && ref_id != conn_id) ||
+	    !zl3073x_ref_is_status_ok(ref)) {
 		*phase_offset = 0;
 		return 0;
 	}
@@ -540,20 +419,12 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	 * the phase offset is modded to the period of the signal
 	 * the dpll is locked to.
 	 */
-	if (ZL3073X_DPLL_REF_IS_VALID(conn_ref) && conn_ref != ref) {
+	if (ZL3073X_DPLL_REF_IS_VALID(conn_id) && conn_id != ref_id) {
 		u32 conn_freq, ref_freq;
 
-		/* Get frequency of connected ref */
-		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, conn_ref,
-							  &conn_freq);
-		if (rc)
-			return rc;
-
-		/* Get frequency of given ref */
-		rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref,
-							  &ref_freq);
-		if (rc)
-			return rc;
+		/* Get frequency of connected and given ref */
+		conn_freq = zl3073x_dev_ref_freq_get(zldev, conn_id);
+		ref_freq = zl3073x_ref_freq_get(ref);
 
 		if (conn_freq > ref_freq) {
 			s64 conn_period, div_factor;
@@ -580,33 +451,23 @@ zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	const struct zl3073x_ref *ref;
 	s64 phase_comp;
-	u8 ref;
-	int rc;
-
-	guard(mutex)(&zldev->multiop_lock);
+	u8 ref_id;
 
 	/* Read reference configuration */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref));
-	if (rc)
-		return rc;
-
-	/* Read current phase offset compensation */
-	rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP, &phase_comp);
-	if (rc)
-		return rc;
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
 
 	/* Perform sign extension for 48bit signed value */
-	phase_comp = sign_extend64(phase_comp, 47);
+	phase_comp = sign_extend64(ref->phase_comp, 47);
 
 	/* Reverse two's complement negation applied during set and convert
 	 * to 32bit signed int
 	 */
 	*phase_adjust = (s32)-phase_comp;
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -620,32 +481,20 @@ zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	s64 phase_comp;
-	u8 ref;
-	int rc;
+	struct zl3073x_ref ref;
+	u8 ref_id;
+
+	/* Read reference configuration */
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = *zl3073x_ref_state_get(zldev, ref_id);
 
 	/* The value in the register is stored as two's complement negation
 	 * of requested value.
 	 */
-	phase_comp = -phase_adjust;
-
-	guard(mutex)(&zldev->multiop_lock);
+	ref.phase_comp = -phase_adjust;
 
-	/* Read reference configuration */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
-			   ZL_REG_REF_MB_MASK, BIT(ref));
-	if (rc)
-		return rc;
-
-	/* Write the requested value into the compensation register */
-	rc = zl3073x_write_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP, phase_comp);
-	if (rc)
-		return rc;
-
-	/* Commit reference configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
-			     ZL_REG_REF_MB_MASK, BIT(ref));
+	/* Update reference configuration */
+	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
 /**
@@ -1816,16 +1665,17 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 	const char *name;
 
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
-		u8 ref = zl3073x_input_pin_ref_get(index);
-
-		name = "REF";
+		u8 ref_id = zl3073x_input_pin_ref_get(index);
+		const struct zl3073x_ref *ref;
 
 		/* Skip the pin if the DPLL is running in NCO mode */
 		if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_NCO)
 			return false;
 
-		is_diff = zl3073x_dev_ref_is_diff(zldev, ref);
-		is_enabled = zl3073x_dev_ref_is_enabled(zldev, ref);
+		name = "REF";
+		ref = zl3073x_ref_state_get(zldev, ref_id);
+		is_diff = zl3073x_ref_is_diff(ref);
+		is_enabled = zl3073x_ref_is_enabled(ref);
 	} else {
 		/* Output P&N pair shares single HW output */
 		u8 out = zl3073x_output_pin_out_get(index);
@@ -1999,13 +1849,12 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	struct zl3073x_dev *zldev = zldpll->dev;
 	unsigned int reg;
 	s64 phase_offset;
-	u8 ref;
+	u8 ref_id;
 	int rc;
 
-	ref = zl3073x_input_pin_ref_get(pin->id);
-
 	/* No phase offset if the ref monitor reports signal errors */
-	if (!zl3073x_dev_ref_is_status_ok(zldev, ref))
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	if (!zl3073x_dev_ref_is_status_ok(zldev, ref_id))
 		return false;
 
 	/* Select register to read phase offset value depending on pin and
@@ -2017,9 +1866,8 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED)
 		reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
 	else if (zldpll->phase_monitor)
-		reg = ZL_REG_REF_PHASE(ref);
+		reg = ZL_REG_REF_PHASE(ref_id);
 	else
-		/* The pin is not connected or phase monitor disabled */
 		return false;
 
 	/* Read measured phase offset value */
@@ -2059,24 +1907,22 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	s64 ffo;
-	u8 ref;
+	const struct zl3073x_ref *ref;
+	u8 ref_id;
 
 	/* Get reference monitor status */
-	ref = zl3073x_input_pin_ref_get(pin->id);
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
 
 	/* Do not report ffo changes if the reference monitor report errors */
-	if (!zl3073x_dev_ref_is_status_ok(zldev, ref))
+	if (!zl3073x_ref_is_status_ok(ref))
 		return false;
 
-	/* Get the latest measured ref's ffo */
-	ffo = zl3073x_dev_ref_ffo_get(zldev, ref);
-
 	/* Compare with previous value */
-	if (pin->freq_offset != ffo) {
+	if (pin->freq_offset != ref->ffo) {
 		dev_dbg(zldev->dev, "%s freq offset changed: %lld -> %lld\n",
-			pin->label, pin->freq_offset, ffo);
-		pin->freq_offset = ffo;
+			pin->label, pin->freq_offset, ref->ffo);
+		pin->freq_offset = ref->ffo;
 
 		return true;
 	}
diff --git a/drivers/dpll/zl3073x/ref.c b/drivers/dpll/zl3073x/ref.c
index 75652d9892af2..82f5bab01732a 100644
--- a/drivers/dpll/zl3073x/ref.c
+++ b/drivers/dpll/zl3073x/ref.c
@@ -88,6 +88,34 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
+	/* Read frequency related registers */
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &ref->freq_base);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &ref->freq_mult);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &ref->freq_ratio_m);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &ref->freq_ratio_n);
+	if (rc)
+		return rc;
+
+	/* Read eSync and N-div rated registers */
+	rc = zl3073x_read_u32(zldev, ZL_REG_REF_ESYNC_DIV, &ref->esync_n_div);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_SYNC_CTRL, &ref->sync_ctrl);
+	if (rc)
+		return rc;
+
+	/* Read phase compensation register */
+	rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+			      &ref->phase_comp);
+	if (rc)
+		return rc;
+
 	dev_dbg(zldev->dev, "REF%u is %s and configured as %s\n", index,
 		str_enabled_disabled(zl3073x_ref_is_enabled(ref)),
 		zl3073x_ref_is_diff(ref) ? "differential" : "single-ended");
@@ -107,3 +135,60 @@ zl3073x_ref_state_get(struct zl3073x_dev *zldev, u8 index)
 {
 	return &zldev->ref[index];
 }
+
+int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
+			  const struct zl3073x_ref *ref)
+{
+	struct zl3073x_ref *dref = &zldev->ref[index];
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Update mailbox with changed values */
+	if (dref->freq_base != ref->freq_base)
+		rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_BASE,
+				       ref->freq_base);
+	if (!rc && dref->freq_mult != ref->freq_mult)
+		rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_MULT,
+				       ref->freq_mult);
+	if (!rc && dref->freq_ratio_m != ref->freq_ratio_m)
+		rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_M,
+				       ref->freq_ratio_m);
+	if (!rc && dref->freq_ratio_n != ref->freq_ratio_n)
+		rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_N,
+				       ref->freq_ratio_n);
+	if (!rc && dref->esync_n_div != ref->esync_n_div)
+		rc = zl3073x_write_u32(zldev, ZL_REG_REF_ESYNC_DIV,
+				       ref->esync_n_div);
+	if (!rc && dref->sync_ctrl != ref->sync_ctrl)
+		rc = zl3073x_write_u8(zldev, ZL_REG_REF_SYNC_CTRL,
+				      ref->sync_ctrl);
+	if (!rc && dref->phase_comp != ref->phase_comp)
+		rc = zl3073x_write_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+				       ref->phase_comp);
+	if (rc)
+		return rc;
+
+	/* Commit reference configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+			   ZL_REG_REF_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* After successful commit store new state */
+	dref->freq_base = ref->freq_base;
+	dref->freq_mult = ref->freq_mult;
+	dref->freq_ratio_m = ref->freq_ratio_m;
+	dref->freq_ratio_n = ref->freq_ratio_n;
+	dref->esync_n_div = ref->esync_n_div;
+	dref->sync_ctrl = ref->sync_ctrl;
+	dref->phase_comp = ref->phase_comp;
+
+	return 0;
+}
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index c4931e545d24d..efc7f59cd9f9c 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -4,6 +4,7 @@
 #define _ZL3073X_REF_H
 
 #include <linux/bitfield.h>
+#include <linux/math64.h>
 #include <linux/types.h>
 
 #include "regs.h"
@@ -13,12 +14,26 @@ struct zl3073x_dev;
 /**
  * struct zl3073x_ref - input reference state
  * @ffo: current fractional frequency offset
+ * @phase_comp: phase compensation
+ * @esync_n_div: divisor for embedded sync or n-divided signal formats
+ * @freq_base: frequency base
+ * @freq_mult: frequnecy multiplier
+ * @freq_ratio_m: FEC mode multiplier
+ * @freq_ratio_n: FEC mode divisor
  * @config: reference config
+ * @sync_ctrl: reference sync control
  * @mon_status: reference monitor status
  */
 struct zl3073x_ref {
 	s64	ffo;
+	u64	phase_comp;
+	u32	esync_n_div;
+	u16	freq_base;
+	u16	freq_mult;
+	u16	freq_ratio_m;
+	u16	freq_ratio_n;
 	u8	config;
+	u8	sync_ctrl;
 	u8	mon_status;
 };
 
@@ -27,6 +42,9 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index);
 const struct zl3073x_ref *zl3073x_ref_state_get(struct zl3073x_dev *zldev,
 						u8 index);
 
+int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
+			  const struct zl3073x_ref *ref);
+
 int zl3073x_ref_freq_factorize(u32 freq, u16 *base, u16 *mult);
 
 /**
@@ -41,6 +59,42 @@ zl3073x_ref_ffo_get(const struct zl3073x_ref *ref)
 	return ref->ffo;
 }
 
+/**
+ * zl3073x_ref_freq_get - get given input reference frequency
+ * @ref: pointer to ref state
+ *
+ * Return: frequency of the given input reference
+ */
+static inline u32
+zl3073x_ref_freq_get(const struct zl3073x_ref *ref)
+{
+	return mul_u64_u32_div(ref->freq_base * ref->freq_mult,
+			       ref->freq_ratio_m, ref->freq_ratio_n);
+}
+
+/**
+ * zl3073x_ref_freq_set - set given input reference frequency
+ * @ref: pointer to ref state
+ * @freq: frequency to be set
+ *
+ * Return: 0 on success, <0 when frequency cannot be factorized
+ */
+static inline int
+zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq)
+{
+	u16 base, mult;
+	int rc;
+
+	rc = zl3073x_ref_freq_factorize(freq, &base, &mult);
+	if (rc)
+		return rc;
+
+	ref->freq_base = base;
+	ref->freq_mult = mult;
+
+	return 0;
+}
+
 /**
  * zl3073x_ref_is_diff - check if the given input reference is differential
  * @ref: pointer to ref state
-- 
2.51.0


