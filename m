Return-Path: <netdev+bounces-179811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFEA7E8A4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F57189CF1D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A1F2561A1;
	Mon,  7 Apr 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+xb/Uaf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C12255229
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047243; cv=none; b=LylRAXHRztdexP5efx+CcNh9FzXGKaa3+WoV7PYfQWLiq2Bukmcs7dJORKQmEvdavE3roRN57hqVy5fvslTDBct4a4buM2BPeMEeQHAaFKDn3C9+q6c4BNl/1pOGNUt8F+mggajdwFbiIfcwUUD5cyuF7SlJ1ct+e00Mb0zKKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047243; c=relaxed/simple;
	bh=0eoyesuUJ7nZXFehU0rjs/Slq1sdsdIs1Ek+4VMektQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceEQcDS/cNLkjfvdqGm5fpnizjPrK9nFFWLR7kP+Phag9h7jyC8MN/Zd76VXKMxmZ9eZJmdBz6/fLtoWWP+cuBUNmgaSCFcVxu6gwXTQrdTIWgG5ZRvPsl5MtSDsZFbegHsT8nU+4urTqX1KURYsY+w4CBonZQd8cZW9aylQXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+xb/Uaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixTjOYCWUZvSMYGAAMcSYpU49kgLEmCLWZmPx1x/04U=;
	b=R+xb/UafLboVljMtP+Wgyiw95R0HnysJ8t4AtoQAOvLOlyBzQspQgKNQBkno7qAlNaHDD3
	60ExSJ++86t3oY/U0a3z2R9qfYafnfHrR3vXeJahokexOYk2Ds2bCEzzOBH2HOSMh5+3do
	K1FP2ETOgdoqL0rEb41PBvSoa5C7IOI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-aWG3WrrmMMebsZvXhkGbgg-1; Mon,
 07 Apr 2025 13:33:59 -0400
X-MC-Unique: aWG3WrrmMMebsZvXhkGbgg-1
X-Mimecast-MFC-AGG-ID: aWG3WrrmMMebsZvXhkGbgg_1744047237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7388018001F8;
	Mon,  7 Apr 2025 17:33:57 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51F9F180B488;
	Mon,  7 Apr 2025 17:33:52 +0000 (UTC)
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
Subject: [PATCH 28/28] dpll: zl3073x: Add support to get fractional frequency offset on input pins
Date: Mon,  7 Apr 2025 19:33:01 +0200
Message-ID: <20250407173301.1010462-9-ivecera@redhat.com>
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

This adds support to get fractional frequency offset for input pins.
Implement the appropriate callback that performs reference frequency
measurement and reports the frequency offset between the DPLL and
the reference.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 110 +++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index e1d7f6d4c3d57..f5a58c3bab382 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -36,12 +36,31 @@ ZL3073X_REG8_IDX_DEF(dpll_refsel_status,	0x130, ZL3073X_NUM_CHANNELS, 1);
 #define DPLL_REFSEL_STATUS_STATE_ACQUIRING	3
 #define DPLL_REFSEL_STATUS_STATE_LOCK		4
 
+ZL3073X_REG32_IDX_DEF(ref_freq,			0x144,
+						ZL3073X_NUM_INPUT_PINS, 4);
+
 /*
  * Register Map Page 4, Ref
  */
 ZL3073X_REG8_DEF(ref_phase_err_read_rqst,	0x20f);
 #define REF_PHASE_ERR_READ_RQST_RD		BIT(0)
 
+ZL3073X_REG8_DEF(ref_freq_meas_ctrl,		0x21c);
+#define REF_FREQ_MEAS_CTRL_LATCH		GENMASK(1, 0)
+#define REF_FREQ_MEAS_CTRL_LATCH_REF_FREQ	1
+#define REF_FREQ_MEAS_CTRL_LATCH_REF_FREQ_OFF	2
+#define REF_FREQ_MEAS_CTRL_LATCH_DPLL_FREQ_OFF	3
+
+ZL3073X_REG8_DEF(ref_freq_meas_mask_3_0,	0x21d);
+#define REF_FREQ_MEAS_MASK_3_0(_ref)		BIT(_ref)
+
+ZL3073X_REG8_DEF(ref_freq_meas_mask_4,		0x21e);
+#define REF_FREQ_MEAS_MASK_4(_ref)		BIT((_ref) - 8)
+
+ZL3073X_REG8_DEF(dpll_meas_ref_freq_ctrl,	0x21f);
+#define DPLL_MEAS_REF_FREQ_CTRL_EN		BIT(0)
+#define DPLL_MEAS_REF_FREQ_CTRL_IDX		GENMASK(6, 4)
+
 ZL3073X_REG48_IDX_DEF(ref_phase,		0x220,
 						ZL3073X_NUM_INPUT_PINS, 6);
 
@@ -140,6 +159,7 @@ struct zl3073x_dpll_pin_info {
  * @esync_control: embedded sync is controllable
  * @pin_state: last saved pin state
  * @phase_offset: last saved pin phase offset
+ * @freq_offset: last saved fractional frequency offset
  */
 struct zl3073x_dpll_pin {
 	struct dpll_pin			*dpll_pin;
@@ -149,6 +169,7 @@ struct zl3073x_dpll_pin {
 	bool				esync_control;
 	enum dpll_pin_state		pin_state;
 	s64				phase_offset;
+	s64				freq_offset;
 };
 
 /**
@@ -498,6 +519,79 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	return rc;
 }
 
+static int
+zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
+			       const struct dpll_device *dpll, void *dpll_priv,
+			       s64 *ffo, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 dpll_meas_ref_freq_ctrl, ref_id;
+	u8 ref_freq_meas_ctrl, ref_mask;
+	s32 freq_offset;
+	int rc;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Wait for being ready */
+	rc = zl3073x_wait_clear_bits(zldev, ref_freq_meas_ctrl,
+				     REF_FREQ_MEAS_CTRL_LATCH);
+	if (rc)
+		return rc;
+
+	/* Select channel index in the mask and enable freq measurement */
+	dpll_meas_ref_freq_ctrl =
+		DPLL_MEAS_REF_FREQ_CTRL_EN |
+		FIELD_PREP(DPLL_MEAS_REF_FREQ_CTRL_IDX, zldpll->id);
+
+	rc = zl3073x_write_dpll_meas_ref_freq_ctrl(zldev,
+						   dpll_meas_ref_freq_ctrl);
+	if (rc)
+		return rc;
+
+	/* Set reference mask
+	 * REF0P,REF0N..REF3P,REF3N are set in ref_freq_meas_mask_3_0 register
+	 * REF4P and REF4N are set in ref_freq_meas_mask_4 register
+	 */
+	if (ref_id < 8) {
+		ref_mask = REF_FREQ_MEAS_MASK_3_0(ref_id);
+		rc = zl3073x_write_ref_freq_meas_mask_3_0(zldev, ref_mask);
+	} else {
+		ref_mask = REF_FREQ_MEAS_MASK_4(ref_id);
+		rc = zl3073x_write_ref_freq_meas_mask_4(zldev, ref_mask);
+	}
+	if (rc)
+		return rc;
+
+	/* Request a reading of the frequency offset between the DPLL and
+	 * the reference
+	 */
+	ref_freq_meas_ctrl = REF_FREQ_MEAS_CTRL_LATCH_DPLL_FREQ_OFF;
+	rc = zl3073x_write_ref_freq_meas_ctrl(zldev, ref_freq_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	rc = zl3073x_wait_clear_bits(zldev, ref_freq_meas_ctrl,
+				     REF_FREQ_MEAS_CTRL_LATCH);
+	if (rc)
+		return rc;
+
+	/* Read the frequency offset between DPLL and reference */
+	rc = zl3073x_read_ref_freq(zldev, ref_id, &freq_offset);
+	if (rc)
+		return rc;
+
+	*ffo = freq_offset;
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				     void *pin_priv,
@@ -1778,6 +1872,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
 	.esync_set = zl3073x_dpll_input_pin_esync_set,
+	.ffo_get = zl3073x_dpll_input_pin_ffo_get,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
@@ -2484,9 +2579,9 @@ zl3073x_dpll_periodic_work(struct kthread_work *work)
 	 * are constant.
 	 */
 	for (i = 0; i < ZL3073X_NUM_INPUT_PINS; i++) {
+		s64 freq_offset, phase_offset;
 		struct zl3073x_dpll_pin *pin;
 		enum dpll_pin_state state;
-		s64 phase_offset;
 		bool pin_changed;
 
 		/* Input pins starts are stored after output pins */
@@ -2513,6 +2608,12 @@ zl3073x_dpll_periodic_work(struct kthread_work *work)
 		if (rc)
 			goto out;
 
+		rc = zl3073x_dpll_input_pin_ffo_get(pin->dpll_pin, pin,
+						    zldpll->dpll_dev, zldpll,
+						    &freq_offset, NULL);
+		if (rc)
+			goto out;
+
 		if (state != pin->pin_state) {
 			dev_dbg(zldev->dev,
 				"INPUT%u state changed to %u\n",
@@ -2527,6 +2628,13 @@ zl3073x_dpll_periodic_work(struct kthread_work *work)
 			pin->phase_offset = phase_offset;
 			pin_changed = true;
 		}
+		if (freq_offset != pin->freq_offset) {
+			dev_dbg(zldev->dev,
+				"INPUT%u frequency offset changed to %llu\n",
+				pin->index, freq_offset);
+			pin->freq_offset = freq_offset;
+			pin_changed = true;
+		}
 
 		if (pin_changed)
 			dpll_pin_change_ntf(pin->dpll_pin);
-- 
2.48.1


