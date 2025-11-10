Return-Path: <netdev+bounces-237288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02268C48744
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2570F4EDCA1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712F308F36;
	Mon, 10 Nov 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyPp5XT3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD02E5407
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797540; cv=none; b=NtfDf/B8y7WePLlCClbSmabPLmkF/hqJ0s2ocld2Mqh79+959DuCYLOAEFXueXrW76jBpjnWYlNRTGREhnd0KXf/Jx7NcGt8L2BJ6DCFR8GmauLFZKeXEgajyrBYbZ6zeny+tejuPppV29J0w/MBtYajqGgjuHNR9qlcwLb6gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797540; c=relaxed/simple;
	bh=2B6d07nY3yDS5tbSlTw85lvmtPuIE5eXq69GgWdPmTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSvWC2iLkFE7I9wNfL2atFfFzr2I8eRZ984zHcj99GGSWZleyIS5vWcNzEWPUYtt7Pmk4ZFvZQvflO6q2ACQ2rP0v97SfDWhIaDlQFax0SyhxXUsQmrcpvCSbc5z8WRvvVW6SCCrpaFH28Oi6TJKdImbbdYMGtYnyJXCNCMFg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyPp5XT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762797536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oS3JnrfnWIxiCz1g0Q3P18pey/R+DicELvnHmiAVwP0=;
	b=RyPp5XT356CVhUxRvymmylVpvoGg7KCDipFpBNeSkaCS5+8ZUsCDG9Sm/+8xL7fw2muKLH
	pZRCMGHzQ8muIjFNI1seI847KVo26jQMRidjEv9EiclTwrVkqoaaHhpRiT6m/+i34X0ybX
	+ldlxDABT9iPAIpgC1RSjZVJU7ffI3E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-KbxJjjeQPimtmMC_LT1rYA-1; Mon,
 10 Nov 2025 12:58:41 -0500
X-MC-Unique: KbxJjjeQPimtmMC_LT1rYA-1
X-Mimecast-MFC-AGG-ID: KbxJjjeQPimtmMC_LT1rYA_1762797520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458D41956088;
	Mon, 10 Nov 2025 17:58:40 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.193])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A09F1800367;
	Mon, 10 Nov 2025 17:58:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] dpll: zl3073x: Cache all output properties in zl3073x_out
Date: Mon, 10 Nov 2025 18:58:17 +0100
Message-ID: <20251110175818.1571610-6-ivecera@redhat.com>
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

Expand the zl3073x_out structure to cache all output-related
hardware registers, including divisors, widths, embedded-sync
parameters and phase compensation.

Modify zl3073x_out_state_fetch() to read and populate all these
new fields at once, including zero-divisor checks. Refactor all
dpll "getter" functions in dpll.c to read from this new
cached state instead of performing direct register access.

Introduce a new function, zl3073x_out_state_set(), to handle
writing changes back to the hardware. This function compares the
provided state with the current cached state and writes *only* the
modified register values via a single mailbox sequence before
updating the local cache.

Refactor all dpll "setter" functions to modify a local copy of
the output state and then call zl3073x_out_state_set() to
commit the changes.

This change centralizes all output-related register I/O into
out.c, significantly reduces bus traffic, and simplifies the logic
in dpll.c.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 377 +++++++++---------------------------
 drivers/dpll/zl3073x/out.c  |  96 +++++++++
 drivers/dpll/zl3073x/out.h  |   8 +
 3 files changed, 193 insertions(+), 288 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 516092997aba0..6e673ea4e789c 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -770,21 +770,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	struct device *dev = zldev->dev;
-	u32 esync_period, esync_width;
-	u8 clock_type, synth;
-	u8 out, output_mode;
-	u32 output_div;
+	const struct zl3073x_synth *synth;
+	const struct zl3073x_out *out;
+	u8 clock_type, out_id;
 	u32 synth_freq;
-	int rc;
 
-	out = zl3073x_output_pin_out_get(pin->id);
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = zl3073x_out_state_get(zldev, out_id);
 
 	/* If N-division is enabled, esync is not supported. The register used
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	switch (zl3073x_dev_out_signal_format_get(zldev, out)) {
+	switch (zl3073x_out_signal_format_get(out)) {
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
 		return -EOPNOTSUPP;
@@ -792,38 +790,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 		break;
 	}
 
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read output configuration into mailbox */
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
-
-	/* Read output mode */
-	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
-	if (rc)
-		return rc;
-
-	/* Read output divisor */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
-	if (rc)
-		return rc;
-
-	/* Check output divisor for zero */
-	if (!output_div) {
-		dev_err(dev, "Zero divisor for OUTPUT%u got from device\n",
-			out);
-		return -EINVAL;
-	}
-
-	/* Get synth attached to output pin */
-	synth = zl3073x_dev_out_synth_get(zldev, out);
-
-	/* Get synth frequency */
-	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
+	/* Get attached synth frequency */
+	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
+	synth_freq = zl3073x_synth_freq_get(synth);
 
-	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, output_mode);
+	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
 	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
 		/* No need to read esync data if it is not enabled */
 		esync->freq = 0;
@@ -832,38 +803,21 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 		goto finish;
 	}
 
-	/* Read esync period */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, &esync_period);
-	if (rc)
-		return rc;
-
-	/* Check esync divisor for zero */
-	if (!esync_period) {
-		dev_err(dev, "Zero esync divisor for OUTPUT%u got from device\n",
-			out);
-		return -EINVAL;
-	}
-
-	/* Get esync pulse width in units of half synth cycles */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, &esync_width);
-	if (rc)
-		return rc;
-
 	/* Compute esync frequency */
-	esync->freq = synth_freq / output_div / esync_period;
+	esync->freq = synth_freq / out->div / out->esync_n_period;
 
 	/* By comparing the esync_pulse_width to the half of the pulse width
 	 * the esync pulse percentage can be determined.
 	 * Note that half pulse width is in units of half synth cycles, which
 	 * is why it reduces down to be output_div.
 	 */
-	esync->pulse = (50 * esync_width) / output_div;
+	esync->pulse = (50 * out->esync_n_width) / out->div;
 
 finish:
 	/* Set supported esync ranges if the pin supports esync control and
 	 * if the output frequency is > 1 Hz.
 	 */
-	if (pin->esync_control && (synth_freq / output_div) > 1) {
+	if (pin->esync_control && (synth_freq / out->div) > 1) {
 		esync->range = esync_freq_ranges;
 		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 	} else {
@@ -881,21 +835,22 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 				  void *dpll_priv, u64 freq,
 				  struct netlink_ext_ack *extack)
 {
-	u32 esync_period, esync_width, output_div;
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 clock_type, out, output_mode, synth;
+	const struct zl3073x_synth *synth;
+	struct zl3073x_out out;
+	u8 clock_type, out_id;
 	u32 synth_freq;
-	int rc;
 
-	out = zl3073x_output_pin_out_get(pin->id);
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = *zl3073x_out_state_get(zldev, out_id);
 
 	/* If N-division is enabled, esync is not supported. The register used
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	switch (zl3073x_dev_out_signal_format_get(zldev, out)) {
+	switch (zl3073x_out_signal_format_get(&out)) {
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
 		return -EOPNOTSUPP;
@@ -903,19 +858,6 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 		break;
 	}
 
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read output configuration into mailbox */
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
-
-	/* Read output mode */
-	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
-	if (rc)
-		return rc;
-
 	/* Select clock type */
 	if (freq)
 		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
@@ -923,38 +865,19 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
 
 	/* Update clock type in output mode */
-	output_mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
-	output_mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
-	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_MODE, output_mode);
-	if (rc)
-		return rc;
+	out.mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
+	out.mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
 
 	/* If esync is being disabled just write mailbox and finish */
 	if (!freq)
 		goto write_mailbox;
 
-	/* Get synth attached to output pin */
-	synth = zl3073x_dev_out_synth_get(zldev, out);
-
-	/* Get synth frequency */
-	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
-
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
-	if (rc)
-		return rc;
-
-	/* Check output divisor for zero */
-	if (!output_div) {
-		dev_err(zldev->dev,
-			"Zero divisor for OUTPUT%u got from device\n", out);
-		return -EINVAL;
-	}
+	/* Get attached synth frequency */
+	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
+	synth_freq = zl3073x_synth_freq_get(synth);
 
 	/* Compute and update esync period */
-	esync_period = synth_freq / (u32)freq / output_div;
-	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, esync_period);
-	if (rc)
-		return rc;
+	out.esync_n_period = synth_freq / (u32)freq / out.div;
 
 	/* Half of the period in units of 1/2 synth cycle can be represented by
 	 * the output_div. To get the supported esync pulse width of 25% of the
@@ -962,15 +885,11 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	 * assumes that output_div is even, otherwise some resolution will be
 	 * lost.
 	 */
-	esync_width = output_div / 2;
-	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, esync_width);
-	if (rc)
-		return rc;
+	out.esync_n_width = out.div / 2;
 
 write_mailbox:
 	/* Commit output configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
-			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	return zl3073x_out_state_set(zldev, out_id, &out);
 }
 
 static int
@@ -983,83 +902,46 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	struct device *dev = zldev->dev;
-	u8 out, signal_format, synth;
-	u32 output_div, synth_freq;
-	int rc;
-
-	out = zl3073x_output_pin_out_get(pin->id);
-	synth = zl3073x_dev_out_synth_get(zldev, out);
-	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read output configuration into mailbox */
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
-
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
-	if (rc)
-		return rc;
+	const struct zl3073x_synth *synth;
+	const struct zl3073x_out *out;
+	u32 synth_freq;
+	u8 out_id;
 
-	/* Check output divisor for zero */
-	if (!output_div) {
-		dev_err(dev, "Zero divisor for output %u got from device\n",
-			out);
-		return -EINVAL;
-	}
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = zl3073x_out_state_get(zldev, out_id);
 
-	/* Read used signal format for the given output */
-	signal_format = zl3073x_dev_out_signal_format_get(zldev, out);
+	/* Get attached synth frequency */
+	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
+	synth_freq = zl3073x_synth_freq_get(synth);
 
-	switch (signal_format) {
+	switch (zl3073x_out_signal_format_get(out)) {
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
 	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
 		/* In case of divided format we have to distiguish between
 		 * given output pin type.
+		 *
+		 * For P-pin the resulting frequency is computed as simple
+		 * division of synth frequency and output divisor.
+		 *
+		 * For N-pin we have to divide additionally by divisor stored
+		 * in esync_n_period output mailbox register that is used as
+		 * N-pin divisor for these modes.
 		 */
-		if (zl3073x_dpll_is_p_pin(pin)) {
-			/* For P-pin the resulting frequency is computed as
-			 * simple division of synth frequency and output
-			 * divisor.
-			 */
-			*frequency = synth_freq / output_div;
-		} else {
-			/* For N-pin we have to divide additionally by
-			 * divisor stored in esync_period output mailbox
-			 * register that is used as N-pin divisor for these
-			 * modes.
-			 */
-			u32 ndiv;
-
-			rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
-					      &ndiv);
-			if (rc)
-				return rc;
+		*frequency = synth_freq / out->div;
 
-			/* Check N-pin divisor for zero */
-			if (!ndiv) {
-				dev_err(dev,
-					"Zero N-pin divisor for output %u got from device\n",
-					out);
-				return -EINVAL;
-			}
+		if (!zl3073x_dpll_is_p_pin(pin))
+			*frequency = (u32)*frequency / out->esync_n_period;
 
-			/* Compute final divisor for N-pin */
-			*frequency = synth_freq / output_div / ndiv;
-		}
 		break;
 	default:
 		/* In other modes the resulting frequency is computed as
 		 * division of synth frequency and output divisor.
 		 */
-		*frequency = synth_freq / output_div;
+		*frequency = synth_freq / out->div;
 		break;
 	}
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -1072,28 +954,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	struct device *dev = zldev->dev;
-	u32 output_n_freq, output_p_freq;
-	u8 out, signal_format, synth;
-	u32 cur_div, new_div, ndiv;
-	u32 synth_freq;
-	int rc;
+	const struct zl3073x_synth *synth;
+	u8 out_id, signal_format;
+	u32 new_div, synth_freq;
+	struct zl3073x_out out;
 
-	out = zl3073x_output_pin_out_get(pin->id);
-	synth = zl3073x_dev_out_synth_get(zldev, out);
-	synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = *zl3073x_out_state_get(zldev, out_id);
+
+	/* Get attached synth frequency and compute new divisor */
+	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
+	synth_freq = zl3073x_synth_freq_get(synth);
 	new_div = synth_freq / (u32)frequency;
 
 	/* Get used signal format for the given output */
-	signal_format = zl3073x_dev_out_signal_format_get(zldev, out);
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Load output configuration */
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
+	signal_format = zl3073x_out_signal_format_get(&out);
 
 	/* Check signal format */
 	if (signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV &&
@@ -1101,99 +976,50 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 		/* For non N-divided signal formats the frequency is computed
 		 * as division of synth frequency and output divisor.
 		 */
-		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_DIV, new_div);
-		if (rc)
-			return rc;
+		out.div = new_div;
 
 		/* For 50/50 duty cycle the divisor is equal to width */
-		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_WIDTH, new_div);
-		if (rc)
-			return rc;
+		out.width = new_div;
 
 		/* Commit output configuration */
-		return zl3073x_mb_op(zldev,
-				     ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
-				     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+		return zl3073x_out_state_set(zldev, out_id, &out);
 	}
 
-	/* For N-divided signal format get current divisor */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &cur_div);
-	if (rc)
-		return rc;
-
-	/* Check output divisor for zero */
-	if (!cur_div) {
-		dev_err(dev, "Zero divisor for output %u got from device\n",
-			out);
-		return -EINVAL;
-	}
-
-	/* Get N-pin divisor (shares the same register with esync */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, &ndiv);
-	if (rc)
-		return rc;
-
-	/* Check N-pin divisor for zero */
-	if (!ndiv) {
-		dev_err(dev,
-			"Zero N-pin divisor for output %u got from device\n",
-			out);
-		return -EINVAL;
-	}
-
-	/* Compute current output frequency for P-pin */
-	output_p_freq = synth_freq / cur_div;
-
-	/* Compute current N-pin frequency */
-	output_n_freq = output_p_freq / ndiv;
-
 	if (zl3073x_dpll_is_p_pin(pin)) {
 		/* We are going to change output frequency for P-pin but
 		 * if the requested frequency is less than current N-pin
 		 * frequency then indicate a failure as we are not able
 		 * to compute N-pin divisor to keep its frequency unchanged.
+		 *
+		 * Update divisor for N-pin to keep N-pin frequency.
 		 */
-		if (frequency <= output_n_freq)
+		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
+		if (!out.esync_n_period)
 			return -EINVAL;
 
 		/* Update the output divisor */
-		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_DIV, new_div);
-		if (rc)
-			return rc;
+		out.div = new_div;
 
 		/* For 50/50 duty cycle the divisor is equal to width */
-		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_WIDTH, new_div);
-		if (rc)
-			return rc;
-
-		/* Compute new divisor for N-pin */
-		ndiv = (u32)frequency / output_n_freq;
+		out.width = out.div;
 	} else {
 		/* We are going to change frequency of N-pin but if
 		 * the requested freq is greater or equal than freq of P-pin
 		 * in the output pair we cannot compute divisor for the N-pin.
 		 * In this case indicate a failure.
+		 *
+		 * Update divisor for N-pin
 		 */
-		if (output_p_freq <= frequency)
+		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
+		if (!out.esync_n_period)
 			return -EINVAL;
-
-		/* Compute new divisor for N-pin */
-		ndiv = output_p_freq / (u32)frequency;
 	}
 
-	/* Update divisor for the N-pin */
-	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, ndiv);
-	if (rc)
-		return rc;
-
 	/* For 50/50 duty cycle the divisor is equal to width */
-	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, ndiv);
-	if (rc)
-		return rc;
+	out.esync_n_width = out.esync_n_period;
 
 	/* Commit output configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
-			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	return zl3073x_out_state_set(zldev, out_id, &out);
 }
 
 static int
@@ -1207,30 +1033,18 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	s32 phase_comp;
-	u8 out;
-	int rc;
-
-	guard(mutex)(&zldev->multiop_lock);
+	const struct zl3073x_out *out;
+	u8 out_id;
 
-	/* Read output configuration */
-	out = zl3073x_output_pin_out_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
-
-	/* Read current output phase compensation */
-	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, &phase_comp);
-	if (rc)
-		return rc;
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = zl3073x_out_state_get(zldev, out_id);
 
 	/* Convert value to ps and reverse two's complement negation applied
 	 * during 'set'
 	 */
-	*phase_adjust = -phase_comp * pin->phase_gran;
+	*phase_adjust = -out->phase_comp * pin->phase_gran;
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -1244,31 +1058,19 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u8 out;
-	int rc;
+	struct zl3073x_out out;
+	u8 out_id;
+
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	out = *zl3073x_out_state_get(zldev, out_id);
 
 	/* The value in the register is stored as two's complement negation
 	 * of requested value and expressed in half synth clock cycles.
 	 */
-	phase_adjust = -phase_adjust / pin->phase_gran;
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read output configuration */
-	out = zl3073x_output_pin_out_get(pin->id);
-	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
-			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
-	if (rc)
-		return rc;
-
-	/* Write the requested value into the compensation register */
-	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, phase_adjust);
-	if (rc)
-		return rc;
+	out.phase_comp = -phase_adjust / pin->phase_gran;
 
 	/* Update output configuration from mailbox */
-	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
-			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	return zl3073x_out_state_set(zldev, out_id, &out);
 }
 
 static int
@@ -1680,8 +1482,6 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 		/* Output P&N pair shares single HW output */
 		u8 out = zl3073x_output_pin_out_get(index);
 
-		name = "OUT";
-
 		/* Skip the pin if it is connected to different DPLL channel */
 		if (zl3073x_dev_out_dpll_get(zldev, out) != zldpll->id) {
 			dev_dbg(zldev->dev,
@@ -1691,6 +1491,7 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 			return false;
 		}
 
+		name = "OUT";
 		is_diff = zl3073x_dev_out_is_diff(zldev, out);
 		is_enabled = zl3073x_dev_output_pin_is_enabled(zldev, index);
 	}
diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
index a48f6917b39fb..3bbe97fad3b34 100644
--- a/drivers/dpll/zl3073x/out.c
+++ b/drivers/dpll/zl3073x/out.c
@@ -50,6 +50,46 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	dev_dbg(zldev->dev, "OUT%u has signal format 0x%02x\n", index,
 		zl3073x_out_signal_format_get(out));
 
+	/* Read output divisor */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &out->div);
+	if (rc)
+		return rc;
+
+	if (!out->div) {
+		dev_err(zldev->dev, "Zero divisor for OUT%u got from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	dev_dbg(zldev->dev, "OUT%u divisor: %u\n", index, out->div);
+
+	/* Read output width */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_WIDTH, &out->width);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
+			      &out->esync_n_period);
+	if (rc)
+		return rc;
+
+	if (!out->esync_n_period) {
+		dev_err(zldev->dev,
+			"Zero esync divisor for OUT%u got from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH,
+			      &out->esync_n_width);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+			      &out->phase_comp);
+	if (rc)
+		return rc;
+
 	return rc;
 }
 
@@ -65,3 +105,59 @@ const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
 {
 	return &zldev->out[index];
 }
+
+#define ZL3073X_OUT_SYNC_ONE(_dev, _dst, _src, _type, _field, _reg)	\
+	((_dst)->_field != (_src)->_field ?				\
+	 zl3073x_write_##_type(_dev, _reg, (_src)->_field) : 0)
+
+int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
+			  const struct zl3073x_out *out)
+{
+	struct zl3073x_out *dout = &zldev->out[index];
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Update mailbox with changed values */
+	rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u32, div,
+				  ZL_REG_OUTPUT_DIV);
+	if (!rc)
+		rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u32, width,
+					  ZL_REG_OUTPUT_WIDTH);
+	if (!rc)
+		rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u32, esync_n_period,
+					  ZL_REG_OUTPUT_ESYNC_PERIOD);
+	if (!rc)
+		rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u32, esync_n_width,
+					  ZL_REG_OUTPUT_ESYNC_WIDTH);
+	if (!rc)
+		rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u8, mode,
+					  ZL_REG_OUTPUT_MODE);
+	if (!rc)
+		rc = ZL3073X_OUT_SYNC_ONE(zldev, dout, out, u32, phase_comp,
+					  ZL_REG_OUTPUT_PHASE_COMP);
+	if (rc)
+		return rc;
+
+	/* Commit output configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* After successful commit store new state */
+	dout->div = out->div;
+	dout->width = out->width;
+	dout->esync_n_period = out->esync_n_period;
+	dout->esync_n_width = out->esync_n_width;
+	dout->mode = out->mode;
+	dout->phase_comp = out->phase_comp;
+
+	return 0;
+}
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index 986aa046221da..ff1fb7985d4de 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -16,6 +16,11 @@ struct zl3073x_dev;
  * @mode: output mode
  */
 struct zl3073x_out {
+	u32	div;
+	u32	width;
+	u32	esync_n_period;
+	u32	esync_n_width;
+	s32	phase_comp;
 	u8	ctrl;
 	u8	mode;
 };
@@ -24,6 +29,9 @@ int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index);
 const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
 						u8 index);
 
+int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
+			  const struct zl3073x_out *out);
+
 /**
  * zl3073x_out_signal_format_get - get output signal format
  * @out: pointer to out state
-- 
2.51.0


