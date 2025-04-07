Return-Path: <netdev+bounces-179806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FDA7E891
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A957189ABA6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E25254AF2;
	Mon,  7 Apr 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f36/GH3c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3E21B1A3
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047217; cv=none; b=X3gMWT8fpw25zhPeLDzV3+/TOqogS5qQUY7HsA8WaSjjp8xswpzTsKgM5C1FLa451xIKL8LuhIKSrfZdKbFm7nzLSUFbrpv+au1gBAT3IerWwcd4B6v93cFE4uZyRetATsv3TZxoMDUZuBK9Hz2q7G4ya11idoaaoz4IrCFZd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047217; c=relaxed/simple;
	bh=9tEV12iT+lk/TQbKifPeVzB73FC77sRewfBk494d0R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB9KHxSp0e8ZccRZnxmIQGDpE7xzsGqnVOrokWx8MdnUetbIIhvAL+NVCXiCtf7bEwQ9kAgqQg23vGN1aOdqrhNCitOgc/rUhtKydZe52YXjcAPlSON8KWSRHUSVPYfzv+gdN05YWd3g5n+6hVioxgK9piThOiyyXAMX8e6C4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f36/GH3c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyJ7SczzSvPBvcmVSXKy9h7tEHe7K41VOZ4HgFb0Xyk=;
	b=f36/GH3cXHYKxu1F7S9tsXcExdRgEu111HEVGwzHQg40qKGrI2/OeScsE417m1FAwFuOLF
	izX2bQ+dwIm0FuLc2EPDW45biTq470kDLiLgqvhx7MdEg1bIXoQ+N6Qz7nbIgGMyBnJkjL
	jfAC2mhtgpLAyoth9AGph2eL+sYKb4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-r7q0JEySM8i0VCg5F-ehuA-1; Mon,
 07 Apr 2025 13:33:29 -0400
X-MC-Unique: r7q0JEySM8i0VCg5F-ehuA-1
X-Mimecast-MFC-AGG-ID: r7q0JEySM8i0VCg5F-ehuA_1744047207
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61CB31801A1A;
	Mon,  7 Apr 2025 17:33:27 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E126C180B488;
	Mon,  7 Apr 2025 17:33:21 +0000 (UTC)
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
Subject: [PATCH 23/28] dpll: zl3073x: Add support to get/set frequency on output pins
Date: Mon,  7 Apr 2025 19:32:56 +0200
Message-ID: <20250407173301.1010462-4-ivecera@redhat.com>
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

This adds support to get/set frequencies for output pins. The frequency
for output pin is determined by the frequency of synthesizer the output
pin is connected to and divisor of the output to which is the given pin
belongs. The resulting frequency of the P-pin and the N-pin from this
output pair depends on the signal format of this output pair.

The device supports so-called N-divided signal formats where for the
N-pin there is an additional divisor. The frequencies for both pins from
such output pair are computed:

 P-pin-freq = synth_freq / output_div
 N-pin-freq = synth_freq / output_div / n_div

For other signal-format types both P and N pin have the same frequency
based only synth frequency and output divisor.

Implement output pin callbacks to get and set frequency. The frequency
setting for the output non-N-divided signal format is simple as we have
to compute just new output divisor. For N-divided formats it is more
complex because by changing of output divisor we change frequency for
both P and N pins. In this case if we are changing frequency for P-pin
we have to compute also new N-divisor for N-pin to keep its current
frequency. From this and the above it follows that the frequency of
the N-pin cannot be higher than the frequency of the P-pin and the
callback must take this limitation into account.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 248 ++++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 965664da9371d..07a547aaee0f1 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -74,6 +74,14 @@ ZL3073X_REG8_IDX_DEF(dpll_ref_prio,		0x652,
 #define DPLL_REF_PRIO_MAX			14
 #define DPLL_REF_PRIO_NONE			15 /* non-selectable */
 
+/*
+ * Register Map Page 14, Output Mailbox
+ */
+ZL3073X_REG32_DEF(output_div,			0x70c);
+ZL3073X_REG32_DEF(output_width,			0x710);
+ZL3073X_REG32_DEF(output_ndiv_period,		0x714);
+ZL3073X_REG32_DEF(output_ndiv_width,		0x718);
+
 #define ZL3073X_REF_NONE			ZL3073X_NUM_INPUT_PINS
 #define ZL3073X_REF_IS_VALID(_ref)		((_ref) != ZL3073X_REF_NONE)
 
@@ -787,6 +795,244 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+static u8
+zl3073x_dpll_pin_synth_get(struct zl3073x_dpll_pin *pin)
+{
+	u8 output = zl3073x_dpll_output_pin_output_get(pin);
+
+	return zl3073x_output_synth_get(pin_to_dev(pin), output);
+}
+
+static int
+zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 *frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 output, signal_format, synth;
+	u64 synth_freq;
+	u32 output_div;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	output = zl3073x_dpll_output_pin_output_get(pin);
+	synth = zl3073x_dpll_pin_synth_get(pin);
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_output_read(zldev, output);
+	if (rc)
+		return rc;
+
+	/* Get divisor */
+	rc = zl3073x_read_output_div(zldev, &output_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!output_div) {
+		dev_err(zldev->dev,
+			"Zero divisor for output %u got from device\n",
+			output);
+		return -EINVAL;
+	}
+
+	/* Read used signal format for the given output */
+	signal_format = zl3073x_output_signal_format_get(zldev, output);
+
+	switch (signal_format) {
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV:
+	case OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV:
+		/* In case of divided format we have to distiguish between
+		 * given output pin type.
+		 */
+		if (zl3073x_dpll_is_p_pin(pin)) {
+			/* For P-pin the resulting frequency is computed as
+			 * simple division of synth frequency and output
+			 * divisor.
+			 */
+			*frequency = div_u64(synth_freq, output_div);
+		} else {
+			/* For N-pin we have to divide additionally by
+			 * divisor stored in output_ndiv_period register
+			 * that is used as N-pin divisor for these modes.
+			 */
+			u64 divisor;
+			u32 ndiv;
+
+			rc = zl3073x_read_output_ndiv_period(zldev, &ndiv);
+			if (rc)
+				return rc;
+
+			/* Check N-pin divisor for zero */
+			if (!ndiv) {
+				dev_err(zldev->dev,
+					"Zero N-pin divisor for output %u got from device\n",
+					output);
+				return -EINVAL;
+			}
+
+			/* Compute final divisor for N-pin */
+			divisor = mul_u32_u32(output_div, ndiv);
+			*frequency = div64_u64(synth_freq, divisor);
+		}
+		break;
+	default:
+		/* In other modes the resulting frequency is computed as
+		 * division of synth frequency and output divisor.
+		 */
+		*frequency = div_u64(synth_freq, output_div);
+		break;
+	}
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 output_n_freq, output_p_freq;
+	u8 output, signal_format, synth;
+	u32 cur_div, new_div, n_div;
+	u64 rem, synth_freq;
+	int rc;
+
+	output = zl3073x_dpll_output_pin_output_get(pin);
+	synth = zl3073x_dpll_pin_synth_get(pin);
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Compute new divisor and check the remainder to be zero as
+	 * the requested frequency has to divide synthesizer frequency
+	 */
+	new_div = (u32)div64_u64_rem(synth_freq, frequency, &rem);
+	if (rem) {
+		dev_err(zldev->dev,
+			"The requested frequency must divide %llu Hz\n",
+			synth_freq);
+		return -EINVAL;
+	}
+
+	guard(zl3073x)(zldev);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_output_read(zldev, output);
+	if (rc)
+		return rc;
+
+	/* Get used signal format for the given output */
+	signal_format = zl3073x_output_signal_format_get(zldev, output);
+
+	/* Check signal format */
+	if (signal_format != OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV &&
+	    signal_format != OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV) {
+		/* For non N-divided signal formats the frequency is computed
+		 * as division of synth frequency and output divisor.
+		 */
+		rc = zl3073x_write_output_div(zldev, new_div);
+		if (rc)
+			return rc;
+
+		/* For 50/50 duty cycle the divisor is equal to width */
+		rc = zl3073x_write_output_width(zldev, new_div);
+		if (rc)
+			return rc;
+
+		/* Update output configuration from mailbox */
+		return zl3073x_mb_output_write(zldev, output);
+	}
+
+	/* For N-divided signal format get current divisor */
+	rc = zl3073x_read_output_div(zldev, &cur_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!cur_div) {
+		dev_err(zldev->dev,
+			"Zero divisor for output %u got from device\n",
+			output);
+		return -EINVAL;
+	}
+
+	/* Compute current output frequency for P-pin */
+	output_p_freq = (u32)div_u64(synth_freq, cur_div);
+
+	/* Get N-pin divisor */
+	rc = zl3073x_read_output_ndiv_period(zldev, &n_div);
+	if (rc)
+		return rc;
+
+	/* Check N-pin divisor for zero */
+	if (!n_div) {
+		dev_err(zldev->dev,
+			"Zero N-pin divisor for output %u got from device\n",
+			output);
+		return -EINVAL;
+	}
+
+	/* Compute current N-pin frequency */
+	output_n_freq = output_p_freq / n_div;
+
+	if (zl3073x_dpll_is_p_pin(pin)) {
+		/* We are going to change output frequency for P-pin but
+		 * if the requested frequency is less than current N-pin
+		 * frequency then indicate a failure as we are not able
+		 * to compute N-pin divisor to keep its frequency unchanged.
+		 */
+		if (frequency <= output_n_freq)
+			return -EINVAL;
+
+		/* Update the register with new divisor */
+		rc = zl3073x_write_output_div(zldev, new_div);
+		if (rc)
+			return rc;
+
+		/* For 50/50 duty cycle the divisor is equal to width */
+		rc = zl3073x_write_output_width(zldev, new_div);
+		if (rc)
+			return rc;
+
+		/* Compute new divisor for N-pin */
+		n_div = (u32)div_u64(frequency, output_n_freq);
+	} else {
+		/* We are going to change frequency of N-pin but if
+		 * the requested freq is greater or equal than freq of P-pin
+		 * in the output pair we cannot compute divisor for the N-pin.
+		 * In this case indicate a failure.
+		 */
+		if (output_p_freq <= frequency)
+			return -EINVAL;
+
+		/* Compute new divisor for N-pin */
+		n_div = output_p_freq / (u32)frequency;
+	}
+
+	/* Update divisor for the N-pin */
+	rc = zl3073x_write_output_ndiv_period(zldev, n_div);
+	if (rc)
+		return rc;
+
+	/* For 50/50 duty cycle the divisor is equal to width */
+	rc = zl3073x_write_output_ndiv_width(zldev, n_div);
+	if (rc)
+		return rc;
+
+	/* Update output configuration from mailbox */
+	return zl3073x_mb_output_write(zldev, output);
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -872,6 +1118,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
-- 
2.48.1


