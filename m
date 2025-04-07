Return-Path: <netdev+bounces-179810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D432A7E8A1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D68A3BD989
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33225525B;
	Mon,  7 Apr 2025 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb18KF1I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5125523E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047240; cv=none; b=Kp9nOufEGXoO4P44+yJ3Wl5J7iQ6l734wwdeie8y90J5NKuO9weHCsb05zgdhZUgEx/wtQiKAyu6wAmCD6FuDOTlJHOQQKs95UoPTl+st43tJxVJyS/0q8JWBsD6HSqjQfuYbaQHGJalcvQhGZCERiHN6x1O+ECCKrwUGj91e3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047240; c=relaxed/simple;
	bh=yLTHJ05ygRIZZ5iwUiKUKh0Cm43hl1zFVEBf723h+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRTg02/wk9ZagMi08ezvZyyUdbHxKMrqOL+JCP0wnEplda5fGEhUW/LE5zQw3bAF7vu9MCgK/gpYYk4cueAkxEopBkVB7taJZW+/PBCZR5am0blmyzFQvKsAQCII5ajfP5s5ahlb+D0AXjw/YQTQJvZ6HK/NvpNLPnS3C5gDUIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cb18KF1I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=palQv57hQTCne25I0QNHI4EgnBuV8W5p0oe7j/ULdJ4=;
	b=Cb18KF1IWM1vHllTXwXZWUNpbsphgtZxiZVrvpCAcmNzuy5S7NUOeqDmQS49dH71DD+dcT
	HVykslFKK0pG42yR5Ab9aHnjOgVvzD/VqVWEVQGEGowR/7wQSPPc1kqf0yjZy+IDa2/45J
	r74KaI5Y2uUkE7urRgC6DxHa0QdaKQQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-9rKRSkUjP-C4FuEln5yjVQ-1; Mon,
 07 Apr 2025 13:33:54 -0400
X-MC-Unique: 9rKRSkUjP-C4FuEln5yjVQ-1
X-Mimecast-MFC-AGG-ID: 9rKRSkUjP-C4FuEln5yjVQ_1744047231
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B642B1800267;
	Mon,  7 Apr 2025 17:33:51 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4743F180B488;
	Mon,  7 Apr 2025 17:33:45 +0000 (UTC)
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
Subject: [PATCH 27/28] dpll: zl3073x: Add support to get/set esync on pins
Date: Mon,  7 Apr 2025 19:33:00 +0200
Message-ID: <20250407173301.1010462-8-ivecera@redhat.com>
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

This adds support to get/set embedded sync for both input and output
pins. The DPLL is able to lock on input reference when the embedded sync
frequency is 1 PPS and pulse width 25%. The esync on outputs are more
versatille and theoretically supports any esync frequency that divides
current output frequency but for now support the same that supported on
input pins (1 PPS & 25% pulse).

Note that for the output pins the esync divisor shares the same register
used for N-divided signal formats. Due to this the esync cannot be
enabled on outputs configured with one of the N-divided signal formats.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 370 +++++++++++++++++++++++++++++++++++-
 1 file changed, 368 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index b1f38f000899b..e1d7f6d4c3d57 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -81,6 +81,14 @@ ZL3073X_REG16_DEF(ref_ratio_m,			0x509);
 ZL3073X_REG16_DEF(ref_ratio_n,			0x50b);
 ZL3073X_REG48_DEF(ref_phase_compensation,	0x528);
 
+ZL3073X_REG8_DEF(ref_sync_ctrl,			0x52e);
+#define REF_SYNC_CTRL_MODE			GENMASK(2, 0)
+#define REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
+#define REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75	2
+
+ZL3073X_REG32_DEF(ref_esync_div,		0x530);
+#define REF_ESYNC_DIV_1HZ			0
+
 /*
  * Register Map Page 12, DPLL Mailbox
  */
@@ -94,10 +102,17 @@ ZL3073X_REG8_IDX_DEF(dpll_ref_prio,		0x652,
 /*
  * Register Map Page 14, Output Mailbox
  */
+ZL3073X_REG8_DEF(output_mode,			0x705);
+#define OUTPUT_MODE_CLOCK_TYPE			GENMASK(2, 0)
+#define OUTPUT_MODE_CLOCK_TYPE_NORMAL		0
+#define OUTPUT_MODE_CLOCK_TYPE_ESYNC		1
+
 ZL3073X_REG32_DEF(output_div,			0x70c);
 ZL3073X_REG32_DEF(output_width,			0x710);
-ZL3073X_REG32_DEF(output_ndiv_period,		0x714);
-ZL3073X_REG32_DEF(output_ndiv_width,		0x718);
+ZL3073X_REG32_DEF(output_esync_period,		0x714);
+ZL3073X_REG32_DEF(output_ndiv_period,		0x714); /* alias for previous */
+ZL3073X_REG32_DEF(output_esync_width,		0x718);
+ZL3073X_REG32_DEF(output_ndiv_width,		0x718); /* alias for previous */
 
 ZL3073X_REG32_DEF(output_phase_compensation,	0x720);
 
@@ -122,6 +137,7 @@ struct zl3073x_dpll_pin_info {
  * @index: index in zl3073x_dpll.pins array
  * @prio: pin priority <0, 14>
  * @selectable: pin is selectable in automatic mode
+ * @esync_control: embedded sync is controllable
  * @pin_state: last saved pin state
  * @phase_offset: last saved pin phase offset
  */
@@ -130,6 +146,7 @@ struct zl3073x_dpll_pin {
 	u8				index;
 	u8				prio;
 	bool				selectable;
+	bool				esync_control;
 	enum dpll_pin_state		pin_state;
 	s64				phase_offset;
 };
@@ -213,6 +230,13 @@ zl3073x_dpll_is_n_pin(struct zl3073x_dpll_pin *pin)
 	return zl3073x_is_n_pin(zl3073x_dpll_pin_index_get(pin));
 }
 
+/*
+ * Supported esync ranges for input and for output per output pair type
+ */
+static const struct dpll_pin_frequency esync_freq_ranges[] = {
+	DPLL_PIN_FREQUENCY_RANGE(0, 1),
+};
+
 /**
  * zl3073x_dpll_is_p_pin - check if the pin is P-pin
  * @pin: pin to check
@@ -352,6 +376,128 @@ zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dev *zldev, u8 ref_id,
 	return rc;
 }
 
+static int
+zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
+				 void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv,
+				 struct dpll_pin_esync *esync,
+				 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 sync_mode, ref_id, ref_sync_ctrl;
+	u32 esync_div;
+	u64 ref_freq;
+	int rc;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Get reference frequency */
+	rc = zl3073x_dpll_input_ref_frequency_get(zldev, ref_id, &ref_freq);
+	if (rc)
+		return rc;
+
+	/* Get ref sync mode */
+	rc = zl3073x_read_ref_sync_ctrl(zldev, &ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	sync_mode = FIELD_GET(REF_SYNC_CTRL_MODE, ref_sync_ctrl);
+
+	/* Get esync divisor */
+	rc = zl3073x_read_ref_esync_div(zldev, &esync_div);
+	if (rc)
+		return rc;
+
+	switch (sync_mode) {
+	case REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
+		esync->freq = (esync_div == REF_ESYNC_DIV_1HZ) ? 1 : 0;
+		esync->pulse = 25;
+		break;
+	default:
+		esync->freq = 0;
+		esync->pulse = 50;
+		break;
+	}
+
+	/* If the pin supports esync control expose its range but only
+	 * if the current reference frequency is > 1 Hz.
+	 */
+	if (pin->esync_control && ref_freq > 1) {
+		esync->range = esync_freq_ranges;
+		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
+	} else {
+		esync->range = NULL;
+		esync->range_num = 0;
+	}
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
+				 void *pin_priv,
+				 const struct dpll_device *dpll,
+				 void *dpll_priv, u64 freq,
+				 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 ref_id, ref_sync_ctrl, sync_mode;
+	int rc;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_ref_read(zldev, ref_id);
+	if (rc)
+		return rc;
+
+	/* Read ref sync control */
+	rc = zl3073x_read_ref_sync_ctrl(zldev, &ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	/* Use freq == 0 to disable esync */
+	if (!freq)
+		sync_mode = REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF;
+	else
+		sync_mode = REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
+
+	ref_sync_ctrl &= REF_SYNC_CTRL_MODE;
+	ref_sync_ctrl |= FIELD_PREP(REF_SYNC_CTRL_MODE, sync_mode);
+
+	/* Update ref sync control register */
+	rc = zl3073x_write_ref_sync_ctrl(zldev, ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	if (freq) {
+		/* 1 Hz is only supported frequnecy currently */
+		rc = zl3073x_write_ref_esync_div(zldev, REF_ESYNC_DIV_1HZ);
+		if (rc)
+			return rc;
+	}
+
+	/* Update reference configuration from mailbox */
+	rc = zl3073x_mb_ref_write(zldev, ref_id);
+	if (rc)
+		return rc;
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				     void *pin_priv,
@@ -1017,6 +1163,218 @@ zl3073x_dpll_pin_synth_get(struct zl3073x_dpll_pin *pin)
 	return zl3073x_output_synth_get(pin_to_dev(pin), output);
 }
 
+static int
+zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
+				  void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv,
+				  struct dpll_pin_esync *esync,
+				  struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 esync_period, esync_width, output_div;
+	u8 clock_type, output, output_mode, synth;
+	u64 synth_freq;
+	int rc;
+
+	output = zl3073x_dpll_output_pin_output_get(pin);
+
+	/* If N-division is enabled, esync is not supported. The register used
+	 * for N-division is also used for the esync divider so both cannot
+	 * be used.
+	 */
+	switch (zl3073x_output_signal_format_get(zldev, output)) {
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_output_read(zldev, output);
+	if (rc)
+		return rc;
+
+	/* Read output mode */
+	rc = zl3073x_read_output_mode(zldev, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Read output divisor */
+	rc = zl3073x_read_output_div(zldev, &output_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!output_div) {
+		dev_err(zldev->dev,
+			"Zero divisor for OUTPUT%u got from device\n",
+			output);
+		return -EINVAL;
+	}
+
+	/* Get synth attached to output pin */
+	synth = zl3073x_dpll_pin_synth_get(pin);
+
+	/* Get synth frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	clock_type = FIELD_GET(OUTPUT_MODE_CLOCK_TYPE, output_mode);
+	if (clock_type != OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+		/* No need to read esync data if it is not enabled */
+		esync->freq = 0;
+		esync->pulse = 50;
+
+		goto finish;
+	}
+
+	/* Read esync period */
+	rc = zl3073x_read_output_esync_period(zldev, &esync_period);
+	if (rc)
+		return rc;
+
+	/* Check esync divisor for zero */
+	if (!esync_period) {
+		dev_err(zldev->dev,
+			"Zero esync divisor for OUTPUT%u got from device\n",
+			output);
+		return -EINVAL;
+	}
+
+	/* Get esync pulse width in units of half synth cycles */
+	rc = zl3073x_read_output_esync_width(zldev, &esync_width);
+	if (rc)
+		return rc;
+
+	/* Compute esync frequency:
+	 * esync_freq = synth_freq / output_div / esync_period;
+	 *     ...    = synth_freq / (output_div * esync_period);
+	 */
+	esync->freq = div64_u64(synth_freq,
+				mul_u32_u32(output_div, esync_period));
+
+	/* By comparing the esync_pulse_width to the half of the pulse width
+	 * the esync pulse percentage can be determined.
+	 * Note that half pulse width is in units of half synth cycles, which
+	 * is why it reduces down to be output_div.
+	 */
+	esync->pulse = (50 * esync_width) / output_div;
+
+finish:
+	/* Set supported esync ranges if the pin supports esync control and
+	 * if the output frequency is > 1 Hz.
+	 */
+	if (pin->esync_control && div_u64(synth_freq, output_div) > 1) {
+		esync->range = esync_freq_ranges;
+		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
+	} else {
+		esync->range = NULL;
+		esync->range_num = 0;
+	}
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
+				  void *pin_priv,
+				  const struct dpll_device *dpll,
+				  void *dpll_priv, u64 freq,
+				  struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 esync_period, esync_width, output_div;
+	u8 clock_type, output, output_mode, synth;
+	u64 synth_freq;
+	int rc;
+
+	output = zl3073x_dpll_output_pin_output_get(pin);
+
+	/* If N-division is enabled, esync is not supported. The register used
+	 * for N-division is also used for the esync divider so both cannot
+	 * be used.
+	 */
+	switch (zl3073x_output_signal_format_get(zldev, output)) {
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_output_read(zldev, output);
+	if (rc)
+		return rc;
+
+	/* Read output mode */
+	rc = zl3073x_read_output_mode(zldev, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Select clock type */
+	if (freq)
+		clock_type = OUTPUT_MODE_CLOCK_TYPE_ESYNC;
+	else
+		clock_type = OUTPUT_MODE_CLOCK_TYPE_NORMAL;
+
+	/* Update clock type in ref sync control */
+	output_mode &= ~OUTPUT_MODE_CLOCK_TYPE;
+	output_mode |= FIELD_PREP(OUTPUT_MODE_CLOCK_TYPE, clock_type);
+	rc = zl3073x_write_output_mode(zldev, output_mode);
+	if (rc)
+		return rc;
+
+	/* If esync is being disabled just write mailbox and finish */
+	if (!freq)
+		goto write_mailbox;
+
+	/* Read output divisor */
+	rc = zl3073x_read_output_div(zldev, &output_div);
+	if (rc)
+		return rc;
+
+	/* Get synth attached to output pin */
+	synth = zl3073x_dpll_pin_synth_get(pin);
+
+	/* Get synth frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Compute and update esync period */
+	esync_period = (u32)div64_u64(synth_freq, freq * output_div);
+	rc = zl3073x_write_output_esync_period(zldev, esync_period);
+	if (rc)
+		return rc;
+
+	/* Half of the period in units of 1/2 synth cycle can be represented by
+	 * the output_div. To get the supported esync pulse width of 25% of the
+	 * period the output_div can just be divided by 2. Note that this
+	 * assumes that output_div is even, otherwise some resolution will be
+	 * lost.
+	 */
+	esync_width = output_div / 2;
+	rc = zl3073x_write_output_esync_width(zldev, esync_width);
+	if (rc)
+		return rc;
+
+write_mailbox:
+	/* Update output configuration from mailbox */
+	rc = zl3073x_mb_output_write(zldev, output);
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				      void *pin_priv,
@@ -1418,6 +1776,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.esync_get = zl3073x_dpll_input_pin_esync_get,
+	.esync_set = zl3073x_dpll_input_pin_esync_set,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
@@ -1431,6 +1791,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.esync_get = zl3073x_dpll_output_pin_esync_get,
+	.esync_set = zl3073x_dpll_output_pin_esync_set,
 	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
 	.phase_adjust_get = zl3073x_dpll_output_pin_phase_adjust_get,
@@ -1678,6 +2040,10 @@ zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
 				 pin_type);
 	}
 
+	/* Check if the pin supports embedded sync control */
+	pin->esync_control = fwnode_property_read_bool(pin_info->fwnode,
+						       "esync-control");
+
 	/* Read supported frequencies property if it is specified */
 	num_freqs = fwnode_property_count_u64(pin_info->fwnode,
 					      "supported-frequencies");
-- 
2.48.1


