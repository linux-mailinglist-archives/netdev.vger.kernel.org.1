Return-Path: <netdev+bounces-207176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15BB061D9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDF3189ED86
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF220299B;
	Tue, 15 Jul 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9sYikFY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF21F7580
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590817; cv=none; b=Q2cEJpB0/myIID4K2IHv127TJkNe5pu9Bc1FqtUnr4W2PR5xraSaP7GWHNgvR/3Wmx/CRkd/AZWWhOqsySCEi6KEUmZAt8oDYpSrATEovXApvL4U3TMNMAmRUbWb5aM/S7VZABTPBZ24wB6tAoKmt3079fbSp+6/hTdP9pex1/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590817; c=relaxed/simple;
	bh=g17Y14naWUx3Ubb2LKidt55fuCGvO4EKqT9wjw9rc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcrMJB4jfcvpKKZv7YXPgJiJBwbSRpIALamf/lYEMxo5EFv1RvXtUK5ywMPKMVsm+m9c7b2ZmyvtJhDhWE71C/00Z+To0CThSsaqzeYXVe45yoma+fBLshce2eV/axpiXSDNh5IyQF1EDjUwjRvgJnmnAiiv0KpkDp4gUb/8G8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9sYikFY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfJMFsdfwPBZmxzUUkiiSTjSBsZA03uY0bmnMvqUvp0=;
	b=h9sYikFYQHgohSh4QDiV5RcxtNIEvxfogqH8zgnXKKxAAhb5njsvkkXVFnuKPosuSavNoQ
	boi3hiJW9rrzxmxEtHcHGsOlPylHoZNTFNgRwuoflIInJb/ACoKBwZ3xImZX7r6xhODqrZ
	3uD2xDnFYO7TYuNtKYXZ+c4Q2a0Xrf8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-JdDK4CZiMnemEaMOKjJs4w-1; Tue,
 15 Jul 2025 10:46:48 -0400
X-MC-Unique: JdDK4CZiMnemEaMOKjJs4w-1
X-Mimecast-MFC-AGG-ID: JdDK4CZiMnemEaMOKjJs4w_1752590807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C764B1955F45;
	Tue, 15 Jul 2025 14:46:46 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E84219560AF;
	Tue, 15 Jul 2025 14:46:42 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>,
	Prathosh Satish <prathosh.satish@microchip.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 1/5] dpll: zl3073x: Add support to get/set esync on pins
Date: Tue, 15 Jul 2025 16:46:29 +0200
Message-ID: <20250715144633.149156-2-ivecera@redhat.com>
In-Reply-To: <20250715144633.149156-1-ivecera@redhat.com>
References: <20250715144633.149156-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support to get/set embedded sync for both input and output pins.
The DPLL is able to lock on input reference when the embedded sync
frequency is 1 PPS and pulse width 25%. The esync on outputs are more
versatille and theoretically supports any esync frequency that divides
current output frequency but for now support the same that supported on
input pins (1 PPS & 25% pulse).

Note that for the output pins the esync divisor shares the same register
used for N-divided signal formats. Due to this the esync cannot be
enabled on outputs configured with one of the N-divided signal formats.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Prathosh Satish <prathosh.satish@microchip.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed reverse christmas tree declaration
* added check for zero output divisor in zl3073x_dpll_output_pin_esync_set
---
 drivers/dpll/zl3073x/dpll.c | 350 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/regs.h |  11 ++
 2 files changed, 360 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index cb0f1a43c5fbd..9eea34b4496d1 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -34,6 +34,7 @@
  * @id: pin id
  * @prio: pin priority <0, 14>
  * @selectable: pin is selectable in automatic mode
+ * @esync_control: embedded sync is controllable
  * @pin_state: last saved pin state
  */
 struct zl3073x_dpll_pin {
@@ -45,9 +46,17 @@ struct zl3073x_dpll_pin {
 	u8			id;
 	u8			prio;
 	bool			selectable;
+	bool			esync_control;
 	enum dpll_pin_state	pin_state;
 };
 
+/*
+ * Supported esync ranges for input and for output per output pair type
+ */
+static const struct dpll_pin_frequency esync_freq_ranges[] = {
+	DPLL_PIN_FREQUENCY_RANGE(0, 1),
+};
+
 /**
  * zl3073x_dpll_is_input_pin - check if the pin is input one
  * @pin: pin to check
@@ -139,6 +148,126 @@ zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
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
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 ref, ref_sync_ctrl, sync_mode;
+	u32 esync_div, ref_freq;
+	int rc;
+
+	/* Get reference frequency */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_dpll_input_ref_frequency_get(zldpll, pin->id, &ref_freq);
+	if (rc)
+		return rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+	if (rc)
+		return rc;
+
+	/* Get ref sync mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_SYNC_CTRL, &ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	/* Get esync divisor */
+	rc = zl3073x_read_u32(zldev, ZL_REG_REF_ESYNC_DIV, &esync_div);
+	if (rc)
+		return rc;
+
+	sync_mode = FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref_sync_ctrl);
+
+	switch (sync_mode) {
+	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
+		esync->freq = (esync_div == ZL_REF_ESYNC_DIV_1HZ) ? 1 : 0;
+		esync->pulse = 25;
+		break;
+	default:
+		esync->freq = 0;
+		esync->pulse = 0;
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
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 ref, ref_sync_ctrl, sync_mode;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration into mailbox */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+	if (rc)
+		return rc;
+
+	/* Get ref sync mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_SYNC_CTRL, &ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	/* Use freq == 0 to disable esync */
+	if (!freq)
+		sync_mode = ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF;
+	else
+		sync_mode = ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
+
+	ref_sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
+	ref_sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
+
+	/* Update ref sync control register */
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_SYNC_CTRL, ref_sync_ctrl);
+	if (rc)
+		return rc;
+
+	if (freq) {
+		/* 1 Hz is only supported frequnecy currently */
+		rc = zl3073x_write_u32(zldev, ZL_REG_REF_ESYNC_DIV,
+				       ZL_REF_ESYNC_DIV_1HZ);
+		if (rc)
+			return rc;
+	}
+
+	/* Commit reference configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+			     ZL_REG_REF_MB_MASK, BIT(ref));
+}
+
 static int
 zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				     void *pin_priv,
@@ -640,6 +769,220 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
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
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct device *dev = zldev->dev;
+	u32 esync_period, esync_width;
+	u8 clock_type, synth;
+	u8 out, output_mode;
+	u32 output_div;
+	u32 synth_freq;
+	int rc;
+
+	out = zl3073x_output_pin_out_get(pin->id);
+
+	/* If N-division is enabled, esync is not supported. The register used
+	 * for N-division is also used for the esync divider so both cannot
+	 * be used.
+	 */
+	switch (zl3073x_out_signal_format_get(zldev, out)) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	/* Read output mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Read output divisor */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!output_div) {
+		dev_err(dev, "Zero divisor for OUTPUT%u got from device\n",
+			out);
+		return -EINVAL;
+	}
+
+	/* Get synth attached to output pin */
+	synth = zl3073x_out_synth_get(zldev, out);
+
+	/* Get synth frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, output_mode);
+	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+		/* No need to read esync data if it is not enabled */
+		esync->freq = 0;
+		esync->pulse = 0;
+
+		goto finish;
+	}
+
+	/* Read esync period */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, &esync_period);
+	if (rc)
+		return rc;
+
+	/* Check esync divisor for zero */
+	if (!esync_period) {
+		dev_err(dev, "Zero esync divisor for OUTPUT%u got from device\n",
+			out);
+		return -EINVAL;
+	}
+
+	/* Get esync pulse width in units of half synth cycles */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, &esync_width);
+	if (rc)
+		return rc;
+
+	/* Compute esync frequency */
+	esync->freq = synth_freq / output_div / esync_period;
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
+	if (pin->esync_control && (synth_freq / output_div) > 1) {
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
+	u32 esync_period, esync_width, output_div;
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 clock_type, out, output_mode, synth;
+	u32 synth_freq;
+	int rc;
+
+	out = zl3073x_output_pin_out_get(pin->id);
+
+	/* If N-division is enabled, esync is not supported. The register used
+	 * for N-division is also used for the esync divider so both cannot
+	 * be used.
+	 */
+	switch (zl3073x_out_signal_format_get(zldev, out)) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	/* Read output mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Select clock type */
+	if (freq)
+		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
+	else
+		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
+
+	/* Update clock type in output mode */
+	output_mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
+	output_mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
+	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_MODE, output_mode);
+	if (rc)
+		return rc;
+
+	/* If esync is being disabled just write mailbox and finish */
+	if (!freq)
+		goto write_mailbox;
+
+	/* Get synth attached to output pin */
+	synth = zl3073x_out_synth_get(zldev, out);
+
+	/* Get synth frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!output_div) {
+		dev_err(zldev->dev,
+			"Zero divisor for OUTPUT%u got from device\n", out);
+		return -EINVAL;
+	}
+
+	/* Compute and update esync period */
+	esync_period = synth_freq / (u32)freq / output_div;
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, esync_period);
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
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, esync_width);
+	if (rc)
+		return rc;
+
+write_mailbox:
+	/* Commit output configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+}
+
 static int
 zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				      void *pin_priv,
@@ -956,6 +1299,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.esync_get = zl3073x_dpll_input_pin_esync_get,
+	.esync_set = zl3073x_dpll_input_pin_esync_set,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
@@ -966,6 +1311,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.esync_get = zl3073x_dpll_output_pin_esync_get,
+	.esync_set = zl3073x_dpll_output_pin_esync_set,
 	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
@@ -1040,8 +1387,9 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	if (IS_ERR(props))
 		return PTR_ERR(props);
 
-	/* Save package label */
+	/* Save package label & esync capability */
 	strscpy(pin->label, props->package_label);
+	pin->esync_control = props->esync_control;
 
 	if (zl3073x_dpll_is_input_pin(pin)) {
 		rc = zl3073x_dpll_ref_prio_get(pin, &pin->prio);
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 493c63e729208..64bb43bbc3168 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -146,6 +146,14 @@
 #define ZL_REF_CONFIG_ENABLE			BIT(0)
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
 
+#define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
+#define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
+#define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
+#define ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75	2
+
+#define ZL_REG_REF_ESYNC_DIV			ZL_REG(10, 0x30, 4)
+#define ZL_REF_ESYNC_DIV_1HZ			0
+
 /********************************
  * Register Page 12, DPLL Mailbox
  ********************************/
@@ -188,6 +196,9 @@
 #define ZL_OUTPUT_MB_SEM_RD			BIT(1)
 
 #define ZL_REG_OUTPUT_MODE			ZL_REG(14, 0x05, 1)
+#define ZL_OUTPUT_MODE_CLOCK_TYPE		GENMASK(2, 0)
+#define ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL	0
+#define ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC		1
 #define ZL_OUTPUT_MODE_SIGNAL_FORMAT		GENMASK(7, 4)
 #define ZL_OUTPUT_MODE_SIGNAL_FORMAT_DISABLED	0
 #define ZL_OUTPUT_MODE_SIGNAL_FORMAT_LVDS	1
-- 
2.49.1


