Return-Path: <netdev+bounces-179808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31845A7E89A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A920E189BB76
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF72550BA;
	Mon,  7 Apr 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNPe+AFf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D921C194
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047231; cv=none; b=AAnIknS/Lo1F2sxPaxJBJ9UWhZ98j5jdk8Dev24wZkA+t5wiMrUeA4/3LhIrlLmW68ZfTcYrDWyRhxUZrlbSVzZ0x9pLljycelL3x83ydw6PsWG3PNyqCLoRn1F9zH/ObTDkSrHRXK1NAD4fCMMU1Zn+4RPyG64NX4VpmcP7Fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047231; c=relaxed/simple;
	bh=OVj9Ib21dXimZLr1073/sKR4D7bcHA8iGi2AcUi8iiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t56F4obRhwi24IP2JxWdrPsnZR9AHzvvJRDAJmyLTQ4wqDqLR9t4c9Nzu3eF5eDhGwmnb1zCU7sOtF+ka5x4NDy/MBM1DameJibPisFE6e2g1fnbPzD0oYtyHKCqTAW6lOUq0HKqQMSbxE4159RLdD4paHhyrF7j6Z5eHOZpYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNPe+AFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPKTO/lkAm23+jGXrw/+m68oGTpukXV85p9697O5xzI=;
	b=NNPe+AFfLwz+9OpN/9t3iNsc72qWPzohQROAmMMCbtKasfSYArfBsrRFNDv8u/mpLGnQfu
	Kt8jqiX61xne3ltV5kiGdwVu7joZjmV3nS9MaEsKfpTAeSK+5y5VUrjditAnzwA6xfOyYK
	mEOEksXtewEGYCSusCxDDibFKN9jBn8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-J8Mg4pjHMaWQLk82l9cgyw-1; Mon,
 07 Apr 2025 13:33:44 -0400
X-MC-Unique: J8Mg4pjHMaWQLk82l9cgyw-1
X-Mimecast-MFC-AGG-ID: J8Mg4pjHMaWQLk82l9cgyw_1744047219
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0F851801A07;
	Mon,  7 Apr 2025 17:33:39 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C524180B488;
	Mon,  7 Apr 2025 17:33:33 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 25/28] dpll: zl3073x: Add support to get phase offset on input pins
Date: Mon,  7 Apr 2025 19:32:58 +0200
Message-ID: <20250407173301.1010462-6-ivecera@redhat.com>
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

This adds support to get phase offset for the input pins. Implement
the appropriate callback that performs DPLL to reference phase
error measurement and reports the measured value. If the DPLL is
currently locked to different reference with higher frequency
then the phase offset is modded to the period of the signal
the DPLL is locked to.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 156 +++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index c920904008e22..3b28d229dd4be 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -36,6 +36,15 @@ ZL3073X_REG8_IDX_DEF(dpll_refsel_status,	0x130, ZL3073X_NUM_CHANNELS, 1);
 #define DPLL_REFSEL_STATUS_STATE_ACQUIRING	3
 #define DPLL_REFSEL_STATUS_STATE_LOCK		4
 
+/*
+ * Register Map Page 4, Ref
+ */
+ZL3073X_REG8_DEF(ref_phase_err_read_rqst,	0x20f);
+#define REF_PHASE_ERR_READ_RQST_RD		BIT(0)
+
+ZL3073X_REG48_IDX_DEF(ref_phase,		0x220,
+						ZL3073X_NUM_INPUT_PINS, 6);
+
 /*
  * Register Map Page 5, DPLL
  */
@@ -48,6 +57,13 @@ ZL3073X_REG8_IDX_DEF(dpll_mode_refsel,		0x284, ZL3073X_NUM_CHANNELS, 4);
 #define DPLL_MODE_REFSEL_MODE_NCO		4
 #define DPLL_MODE_REFSEL_REF			GENMASK(7, 4)
 
+ZL3073X_REG8_DEF(dpll_meas_ctrl,		0x2d0);
+#define DPLL_MEAS_CTRL_EN			BIT(0)
+#define DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
+
+ZL3073X_REG8_DEF(dpll_meas_idx,			0x2d1);
+#define DPLL_MEAS_IDX_IDX			GENMASK(2, 0)
+
 /*
  * Register Map Page 9, Synth and Output
  */
@@ -104,6 +120,7 @@ struct zl3073x_dpll_pin_info {
  * @prio: pin priority <0, 14>
  * @selectable: pin is selectable in automatic mode
  * @pin_state: last saved pin state
+ * @phase_offset: last saved pin phase offset
  */
 struct zl3073x_dpll_pin {
 	struct dpll_pin			*dpll_pin;
@@ -111,6 +128,7 @@ struct zl3073x_dpll_pin {
 	u8				prio;
 	bool				selectable;
 	enum dpll_pin_state		pin_state;
+	s64				phase_offset;
 };
 
 /**
@@ -558,6 +576,120 @@ zl3073x_dpll_connected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
  *
  * Returns 0 in case of success or negative value otherwise.
  */
+static int
+zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv, s64 *phase_offset,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 dpll_meas_ctrl, dpll_meas_idx;
+	u8 conn_ref, ref_id, ref_status;
+	s64 ref_phase;
+	int rc;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Wait for reading to be ready */
+	rc = zl3073x_wait_clear_bits(zldev, ref_phase_err_read_rqst,
+				     REF_PHASE_ERR_READ_RQST_RD);
+	if (rc)
+		return rc;
+
+	/* Read measurement control register */
+	rc = zl3073x_read_dpll_meas_ctrl(zldev, &dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Enable measurement */
+	dpll_meas_ctrl |= DPLL_MEAS_CTRL_EN;
+
+	/* Update measurement control register with new values */
+	rc = zl3073x_write_dpll_meas_ctrl(zldev, dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Set measurement index to channel index */
+	dpll_meas_idx = FIELD_PREP(DPLL_MEAS_IDX_IDX, zldpll->id);
+	rc = zl3073x_write_dpll_meas_idx(zldev, dpll_meas_idx);
+	if (rc)
+		return rc;
+
+	/* Request read of the current phase error measurements */
+	rc = zl3073x_write_ref_phase_err_read_rqst(zldev,
+						   REF_PHASE_ERR_READ_RQST_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for confirmation from the device */
+	rc = zl3073x_wait_clear_bits(zldev, ref_phase_err_read_rqst,
+				     REF_PHASE_ERR_READ_RQST_RD);
+	if (rc)
+		return rc;
+
+	/* Read DPLL-to-REF phase measurement */
+	rc = zl3073x_read_ref_phase(zldev, ref_id, &ref_phase);
+	if (rc)
+		return rc;
+
+	/* Perform sign extension for 48bit signed value */
+	ref_phase = sign_extend64(ref_phase, 47);
+
+	/* Register units are 0.01 ps -> convert it to ps */
+	ref_phase = div_s64(ref_phase, 100);
+
+	/* Get currently connected reference */
+	rc = zl3073x_dpll_connected_ref_get(zldpll, &conn_ref);
+	if (rc)
+		return rc;
+
+	/* Get this pin monitor status */
+	rc = zl3073x_read_ref_mon_status(zldev, ref_id, &ref_status);
+	if (rc)
+		return rc;
+
+	/* The DPLL being locked to a higher freq than the current ref
+	 * the phase offset is modded to the period of the signal
+	 * the dpll is locked to.
+	 */
+	if (ZL3073X_REF_IS_VALID(conn_ref) && conn_ref != ref_id &&
+	    ref_status == REF_MON_STATUS_OK) {
+		u64 conn_freq, ref_freq;
+
+		/* Get frequency of connected ref */
+		rc = zl3073x_dpll_input_ref_frequency_get(zldev, conn_ref,
+							  &conn_freq);
+		if (rc)
+			return rc;
+
+		/* Get frequency of given ref */
+		rc = zl3073x_dpll_input_ref_frequency_get(zldev, ref_id,
+							  &ref_freq);
+		if (rc)
+			return rc;
+
+		if (conn_freq > ref_freq) {
+			s64 conn_period;
+			int div_factor;
+
+			conn_period = (s64)div_u64(PSEC_PER_SEC, conn_freq);
+			div_factor = div64_s64(ref_phase, conn_period);
+			ref_phase -= conn_period * div_factor;
+		}
+	}
+
+	*phase_offset = ref_phase;
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
 {
@@ -1110,6 +1242,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
+	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
@@ -1805,6 +1938,8 @@ zl3073x_dpll_periodic_work(struct kthread_work *work)
 	for (i = 0; i < ZL3073X_NUM_INPUT_PINS; i++) {
 		struct zl3073x_dpll_pin *pin;
 		enum dpll_pin_state state;
+		s64 phase_offset;
+		bool pin_changed;
 
 		/* Input pins starts are stored after output pins */
 		pin = &zldpll->pins[ZL3073X_NUM_OUTPUT_PINS + i];
@@ -1821,13 +1956,32 @@ zl3073x_dpll_periodic_work(struct kthread_work *work)
 		if (rc)
 			goto out;
 
+		rc = zl3073x_dpll_input_pin_phase_offset_get(pin->dpll_pin,
+							     pin,
+							     zldpll->dpll_dev,
+							     zldpll,
+							     &phase_offset,
+							     NULL);
+		if (rc)
+			goto out;
+
 		if (state != pin->pin_state) {
 			dev_dbg(zldev->dev,
 				"INPUT%u state changed to %u\n",
 				zl3073x_dpll_pin_index_get(pin), state);
 			pin->pin_state = state;
-			dpll_pin_change_ntf(pin->dpll_pin);
+			pin_changed = true;
 		}
+		if (phase_offset != pin->phase_offset) {
+			dev_dbg(zldev->dev,
+				"INPUT%u phase offset changed to %llu\n",
+				pin->index, phase_offset);
+			pin->phase_offset = phase_offset;
+			pin_changed = true;
+		}
+
+		if (pin_changed)
+			dpll_pin_change_ntf(pin->dpll_pin);
 	}
 
 out:
-- 
2.48.1


