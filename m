Return-Path: <netdev+bounces-237715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDFC4F632
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D373BCF80
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F13A1CFB;
	Tue, 11 Nov 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdsuc9QK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127D393DF0
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884786; cv=none; b=Ra9bD54JLA+cfZhysub6tQFJAK4il+WMr2XlTLohIONo2jV1sXQOh/zjYGyfCvxKydtIGBhv3YG166EfjbQvql0F98F7oEqRZHUANXlEZwJWIpba78USolpLxmeaImbjZaIb2XWSa6NsQBaeWMwIzrTcLSXvFMBw05Fr4+p91Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884786; c=relaxed/simple;
	bh=ygo3KOcGLGy4Qi6oGZSdMlkhlE2c19quvG7dBen/GdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNCLCpu0HtCbujIlIVE3S/z6eal78A2KT+l8X0Lh3I62anveLYHPaJ865ys3mzCS0nI7OxWHY97dnmm3GBhWtPO5Ifo6ect2emmJ7ll069YZ9uV1FYS73ITWeLroEoOip+DHq+qYooAmAoUWt2+Vb57TktBiZzx0KDwNyhdjOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdsuc9QK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sQE/Hn0ijTzMFQhrMRnm6DUeVPlI9hlvlC8QokSb/4=;
	b=Mdsuc9QKZKg/+EzD+QXv7CEPz34g5xN1sA6tjF5atJIsBlwUJyn7b6uJbkRA0seu9GGl7C
	hWGmp0EbH5DEzn2REKhpzkfnKLC9yQ/C+yFvNpHEsjytYypHB/KG/wMRLKmgd5ILLpIn0C
	AC7X9taJF0DOk7pMZVW4s++DTTzs2gQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-R9F_WTtsMIG7h0TrgFMzjg-1; Tue,
 11 Nov 2025 13:12:59 -0500
X-MC-Unique: R9F_WTtsMIG7h0TrgFMzjg-1
X-Mimecast-MFC-AGG-ID: R9F_WTtsMIG7h0TrgFMzjg_1762884777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 409BD18005B9;
	Tue, 11 Nov 2025 18:12:57 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EAD9180094B;
	Tue, 11 Nov 2025 18:12:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/6] dpll: zl3073x: Store raw register values instead of parsed state
Date: Tue, 11 Nov 2025 19:12:38 +0100
Message-ID: <20251111181243.4570-2-ivecera@redhat.com>
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

The zl3073x_ref, zl3073x_out and zl3073x_synth structures
previously stored state that was parsed from register reads. This
included values like boolean 'enabled' flags, synthesizer selections,
and pre-calculated frequencies.

This commit refactors the state management to store the raw register
values directly in these structures. The various inline helper functions
are updated to parse these raw values on-demand using FIELD_GET.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 81 ++++++++++++-------------------------
 drivers/dpll/zl3073x/core.h | 61 ++++++++++++++++------------
 2 files changed, 60 insertions(+), 82 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index e42e527813cf8..50c1fe59bc7f0 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -598,25 +598,22 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
  * @zldev: pointer to zl3073x_dev structure
  * @index: input reference index to fetch state for
  *
- * Function fetches information for the given input reference that are
- * invariant and stores them for later use.
+ * Function fetches state for the given input reference and stores it for
+ * later user.
  *
  * Return: 0 on success, <0 on error
  */
 static int
 zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 {
-	struct zl3073x_ref *input = &zldev->ref[index];
-	u8 ref_config;
+	struct zl3073x_ref *ref = &zldev->ref[index];
 	int rc;
 
 	/* If the input is differential then the configuration for N-pin
 	 * reference is ignored and P-pin config is used for both.
 	 */
-	if (zl3073x_is_n_pin(index) &&
-	    zl3073x_ref_is_diff(zldev, index - 1)) {
-		input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
-		input->diff = true;
+	if (zl3073x_is_n_pin(index) && zl3073x_ref_is_diff(zldev, index - 1)) {
+		memcpy(ref, &zldev->ref[index - 1], sizeof(*ref));
 
 		return 0;
 	}
@@ -630,16 +627,14 @@ zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		return rc;
 
 	/* Read ref_config register */
-	rc = zl3073x_read_u8(zldev, ZL_REG_REF_CONFIG, &ref_config);
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_CONFIG, &ref->config);
 	if (rc)
 		return rc;
 
-	input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref_config);
-	input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref_config);
-
 	dev_dbg(zldev->dev, "REF%u is %s and configured as %s\n", index,
-		str_enabled_disabled(input->enabled),
-		input->diff ? "differential" : "single-ended");
+		str_enabled_disabled(zl3073x_ref_is_enabled(zldev, index)),
+		zl3073x_ref_is_diff(zldev, index)
+			? "differential" : "single-ended");
 
 	return rc;
 }
@@ -649,8 +644,8 @@ zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
  * @zldev: pointer to zl3073x_dev structure
  * @index: output index to fetch state for
  *
- * Function fetches information for the given output (not output pin)
- * that are invariant and stores them for later use.
+ * Function fetches state of the given output (not output pin) and stores it
+ * for later use.
  *
  * Return: 0 on success, <0 on error
  */
@@ -658,22 +653,16 @@ static int
 zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 {
 	struct zl3073x_out *out = &zldev->out[index];
-	u8 output_ctrl, output_mode;
 	int rc;
 
 	/* Read output configuration */
-	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &out->ctrl);
 	if (rc)
 		return rc;
 
-	/* Store info about output enablement and synthesizer the output
-	 * is connected to.
-	 */
-	out->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
-	out->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
-
 	dev_dbg(zldev->dev, "OUT%u is %s and connected to SYNTH%u\n", index,
-		str_enabled_disabled(out->enabled), out->synth);
+		str_enabled_disabled(zl3073x_out_is_enabled(zldev, index)),
+		zl3073x_out_synth_get(zldev, index));
 
 	guard(mutex)(&zldev->multiop_lock);
 
@@ -683,17 +672,13 @@ zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	if (rc)
 		return rc;
 
-	/* Read output_mode */
-	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
+	/* Read output mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &out->mode);
 	if (rc)
 		return rc;
 
-	/* Extract and store output signal format */
-	out->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
-				       output_mode);
-
 	dev_dbg(zldev->dev, "OUT%u has signal format 0x%02x\n", index,
-		out->signal_format);
+		zl3073x_out_signal_format_get(zldev, index));
 
 	return rc;
 }
@@ -703,8 +688,7 @@ zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
  * @zldev: pointer to zl3073x_dev structure
  * @index: synth index to fetch state for
  *
- * Function fetches information for the given synthesizer that are
- * invariant and stores them for later use.
+ * Function fetches state of the given synthesizer and stores it for later use.
  *
  * Return: 0 on success, <0 on error
  */
@@ -712,25 +696,13 @@ static int
 zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
 {
 	struct zl3073x_synth *synth = &zldev->synth[index];
-	u16 base, m, n;
-	u8 synth_ctrl;
-	u32 mult;
 	int rc;
 
 	/* Read synth control register */
-	rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
+	rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth->ctrl);
 	if (rc)
 		return rc;
 
-	/* Store info about synth enablement and DPLL channel the synth is
-	 * driven by.
-	 */
-	synth->enabled = FIELD_GET(ZL_SYNTH_CTRL_EN, synth_ctrl);
-	synth->dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, synth_ctrl);
-
-	dev_dbg(zldev->dev, "SYNTH%u is %s and driven by DPLL%u\n", index,
-		str_enabled_disabled(synth->enabled), synth->dpll);
-
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read synth configuration */
@@ -744,35 +716,32 @@ zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
 	 *
 	 * Read registers with these values
 	 */
-	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &base);
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &synth->freq_base);
 	if (rc)
 		return rc;
 
-	rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &mult);
+	rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &synth->freq_mult);
 	if (rc)
 		return rc;
 
-	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &m);
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &synth->freq_m);
 	if (rc)
 		return rc;
 
-	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &n);
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &synth->freq_n);
 	if (rc)
 		return rc;
 
 	/* Check denominator for zero to avoid div by 0 */
-	if (!n) {
+	if (!synth->freq_n) {
 		dev_err(zldev->dev,
 			"Zero divisor for SYNTH%u retrieved from device\n",
 			index);
 		return -EINVAL;
 	}
 
-	/* Compute and store synth frequency */
-	zldev->synth[index].freq = div_u64(mul_u32_u32(base * m, mult), n);
-
 	dev_dbg(zldev->dev, "SYNTH%u frequency: %u Hz\n", index,
-		zldev->synth[index].freq);
+		zl3073x_synth_freq_get(zldev, index));
 
 	return rc;
 }
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 1dca4ddcf2350..51d0fd6cfabfc 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -29,38 +29,38 @@ struct zl3073x_dpll;
 
 /**
  * struct zl3073x_ref - input reference invariant info
- * @enabled: input reference is enabled or disabled
- * @diff: true if input reference is differential
  * @ffo: current fractional frequency offset
+ * @config: reference config
  */
 struct zl3073x_ref {
-	bool	enabled;
-	bool	diff;
 	s64	ffo;
+	u8	config;
 };
 
 /**
  * struct zl3073x_out - output invariant info
- * @enabled: out is enabled or disabled
- * @synth: synthesizer the out is connected to
- * @signal_format: out signal format
+ * @ctrl: output control
+ * @mode: output mode
  */
 struct zl3073x_out {
-	bool	enabled;
-	u8	synth;
-	u8	signal_format;
+	u8	ctrl;
+	u8	mode;
 };
 
 /**
  * struct zl3073x_synth - synthesizer invariant info
- * @freq: synthesizer frequency
- * @dpll: ID of DPLL the synthesizer is driven by
- * @enabled: synth is enabled or disabled
+ * @freq_mult: frequency multiplier
+ * @freq_base: frequency base
+ * @freq_m: frequency numerator
+ * @freq_n: frequency denominator
+ * @ctrl: synth control
  */
 struct zl3073x_synth {
-	u32	freq;
-	u8	dpll;
-	bool	enabled;
+	u32	freq_mult;
+	u16	freq_base;
+	u16	freq_m;
+	u16	freq_n;
+	u8	ctrl;
 };
 
 /**
@@ -239,7 +239,10 @@ zl3073x_ref_ffo_get(struct zl3073x_dev *zldev, u8 index)
 static inline bool
 zl3073x_ref_is_diff(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->ref[index].diff;
+	if (FIELD_GET(ZL_REF_CONFIG_DIFF_EN, zldev->ref[index].config))
+		return true;
+
+	return false;
 }
 
 /**
@@ -252,7 +255,10 @@ zl3073x_ref_is_diff(struct zl3073x_dev *zldev, u8 index)
 static inline bool
 zl3073x_ref_is_enabled(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->ref[index].enabled;
+	if (FIELD_GET(ZL_REF_CONFIG_ENABLE, zldev->ref[index].config))
+		return true;
+
+	return false;
 }
 
 /**
@@ -265,7 +271,7 @@ zl3073x_ref_is_enabled(struct zl3073x_dev *zldev, u8 index)
 static inline u8
 zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->synth[index].dpll;
+	return FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, zldev->synth[index].ctrl);
 }
 
 /**
@@ -278,7 +284,10 @@ zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
 static inline u32
 zl3073x_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->synth[index].freq;
+	struct zl3073x_synth *synth = &zldev->synth[index];
+
+	return mul_u64_u32_div(synth->freq_base * synth->freq_m,
+			       synth->freq_mult, synth->freq_n);
 }
 
 /**
@@ -291,7 +300,7 @@ zl3073x_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
 static inline bool
 zl3073x_synth_is_enabled(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->synth[index].enabled;
+	return FIELD_GET(ZL_SYNTH_CTRL_EN, zldev->synth[index].ctrl);
 }
 
 /**
@@ -304,7 +313,7 @@ zl3073x_synth_is_enabled(struct zl3073x_dev *zldev, u8 index)
 static inline u8
 zl3073x_out_synth_get(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->out[index].synth;
+	return FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, zldev->out[index].ctrl);
 }
 
 /**
@@ -321,10 +330,10 @@ zl3073x_out_is_enabled(struct zl3073x_dev *zldev, u8 index)
 
 	/* Output is enabled only if associated synth is enabled */
 	synth = zl3073x_out_synth_get(zldev, index);
-	if (zl3073x_synth_is_enabled(zldev, synth))
-		return zldev->out[index].enabled;
+	if (!zl3073x_synth_is_enabled(zldev, synth))
+		return false;
 
-	return false;
+	return FIELD_GET(ZL_OUTPUT_CTRL_EN, zldev->out[index].ctrl);
 }
 
 /**
@@ -337,7 +346,7 @@ zl3073x_out_is_enabled(struct zl3073x_dev *zldev, u8 index)
 static inline u8
 zl3073x_out_signal_format_get(struct zl3073x_dev *zldev, u8 index)
 {
-	return zldev->out[index].signal_format;
+	return FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT, zldev->out[index].mode);
 }
 
 /**
-- 
2.51.0


