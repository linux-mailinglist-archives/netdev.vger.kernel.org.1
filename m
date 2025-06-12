Return-Path: <netdev+bounces-197183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B153FAD7BD7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5425E1643AE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE922D8DCF;
	Thu, 12 Jun 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnQi9+SQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C12D6634
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758623; cv=none; b=mEl0MCbrqIgeP4UUGuTjn43uySrl0ErJNQwKm8zrjaCelbT+MftxymaM7osGrlj8WioiCKQcfTK9qsR9MGcHXhXD9et0BWhRRFZPk6pIhjxZwMpexQbRqqIU0o/oOYqn/HBDZjjmxTAoWWCtBJ7CH6BRw1qbLl7dOoZ9AJGe4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758623; c=relaxed/simple;
	bh=b34/psQYD7vvwsN5cOgIoUDtvdI8onTh0cGhnaw+Nms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Weq644ZweNkJEjQwgqIb2YoT3KmZe7M/VwZTmiHo/BfxSyHvWHMlMn+yIvsnOQHzDZy91gkMnxxFe5hNWAm70N/9b2MWEKC6O0UU7WREsmzbdSZGHHKYSZ9fSMuX7DOVUUaiBoKO9zOT5GoNlCqEwxkpAOWOSL9aJCjcvAOCjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnQi9+SQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749758620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T+GUS74e0ZRDRE8sW06RSoY7dXJucx8m24d6Lv2LCM=;
	b=bnQi9+SQrlGtu6i1CCPGgpPSTvhX9Om9fhnh09DeRNsAVYeA8+jRbP+aH/q8+NnT6yEx9P
	0i9v3LaOKFLlQLYLbUve9LtL1aHIViebCqgKdqjWsXgY0AayzQWrwwMAN5qEkFZ+BH6Cfj
	AJwZM7rQ2Ii0vGAZzYqTghblnR4PEK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-zMdz-4msMLCHMzzMgS2hEQ-1; Thu,
 12 Jun 2025 16:03:39 -0400
X-MC-Unique: zMdz-4msMLCHMzzMgS2hEQ-1
X-Mimecast-MFC-AGG-ID: zMdz-4msMLCHMzzMgS2hEQ_1749758615
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E84D1808985;
	Thu, 12 Jun 2025 20:03:35 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E321B18003FC;
	Thu, 12 Jun 2025 20:03:28 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v9 14/14] dpll: zl3073x: Add support to get/set frequency on output pins
Date: Thu, 12 Jun 2025 22:01:45 +0200
Message-ID: <20250612200145.774195-15-ivecera@redhat.com>
In-Reply-To: <20250612200145.774195-1-ivecera@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add support to get/set frequencies on output pins. The frequency for
output pin is determined by the frequency of synthesizer the output
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

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 235 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |   5 +
 2 files changed, 240 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 8bd0e3e66e7f1..65d568cd1084e 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -640,6 +640,239 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 *frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct device *dev = zldev->dev;
+	u8 out, signal_format, synth;
+	u32 output_div, synth_freq;
+	int rc;
+
+	out = zl3073x_output_pin_out_get(pin->id);
+	synth = zl3073x_out_synth_get(zldev, out);
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &output_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!output_div) {
+		dev_err(dev, "Zero divisor for output %u got from device\n",
+			out);
+		return -EINVAL;
+	}
+
+	/* Read used signal format for the given output */
+	signal_format = zl3073x_out_signal_format_get(zldev, out);
+
+	switch (signal_format) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+		/* In case of divided format we have to distiguish between
+		 * given output pin type.
+		 */
+		if (zl3073x_dpll_is_p_pin(pin)) {
+			/* For P-pin the resulting frequency is computed as
+			 * simple division of synth frequency and output
+			 * divisor.
+			 */
+			*frequency = synth_freq / output_div;
+		} else {
+			/* For N-pin we have to divide additionally by
+			 * divisor stored in esync_period output mailbox
+			 * register that is used as N-pin divisor for these
+			 * modes.
+			 */
+			u32 ndiv;
+
+			rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
+					      &ndiv);
+			if (rc)
+				return rc;
+
+			/* Check N-pin divisor for zero */
+			if (!ndiv) {
+				dev_err(dev,
+					"Zero N-pin divisor for output %u got from device\n",
+					out);
+				return -EINVAL;
+			}
+
+			/* Compute final divisor for N-pin */
+			*frequency = synth_freq / output_div / ndiv;
+		}
+		break;
+	default:
+		/* In other modes the resulting frequency is computed as
+		 * division of synth frequency and output divisor.
+		 */
+		*frequency = synth_freq / output_div;
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
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct device *dev = zldev->dev;
+	u32 output_n_freq, output_p_freq;
+	u8 out, signal_format, synth;
+	u32 cur_div, new_div, ndiv;
+	u32 synth_freq;
+	int rc;
+
+	out = zl3073x_output_pin_out_get(pin->id);
+	synth = zl3073x_out_synth_get(zldev, out);
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Check the requested frequency divides synth frequency without
+	 * remainder.
+	 */
+	if (synth_freq % (u32)frequency) {
+		dev_err(dev, "The requested frequency must divide %u Hz\n",
+			synth_freq);
+		return -EINVAL;
+	}
+	new_div = synth_freq / (u32)frequency;
+
+	/* Get used signal format for the given output */
+	signal_format = zl3073x_out_signal_format_get(zldev, out);
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Load output configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	/* Check signal format */
+	if (signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV &&
+	    signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV) {
+		/* For non N-divided signal formats the frequency is computed
+		 * as division of synth frequency and output divisor.
+		 */
+		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_DIV, new_div);
+		if (rc)
+			return rc;
+
+		/* For 50/50 duty cycle the divisor is equal to width */
+		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_WIDTH, new_div);
+		if (rc)
+			return rc;
+
+		/* Commit output configuration */
+		return zl3073x_mb_op(zldev,
+				     ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+				     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	}
+
+	/* For N-divided signal format get current divisor */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_DIV, &cur_div);
+	if (rc)
+		return rc;
+
+	/* Check output divisor for zero */
+	if (!cur_div) {
+		dev_err(dev, "Zero divisor for output %u got from device\n",
+			out);
+		return -EINVAL;
+	}
+
+	/* Get N-pin divisor (shares the same register with esync */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, &ndiv);
+	if (rc)
+		return rc;
+
+	/* Check N-pin divisor for zero */
+	if (!ndiv) {
+		dev_err(dev,
+			"Zero N-pin divisor for output %u got from device\n",
+			out);
+		return -EINVAL;
+	}
+
+	/* Compute current output frequency for P-pin */
+	output_p_freq = synth_freq / cur_div;
+
+	/* Compute current N-pin frequency */
+	output_n_freq = output_p_freq / ndiv;
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
+		/* Update the output divisor */
+		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_DIV, new_div);
+		if (rc)
+			return rc;
+
+		/* For 50/50 duty cycle the divisor is equal to width */
+		rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_WIDTH, new_div);
+		if (rc)
+			return rc;
+
+		/* Compute new divisor for N-pin */
+		ndiv = (u32)frequency / output_n_freq;
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
+		ndiv = output_p_freq / (u32)frequency;
+	}
+
+	/* Update divisor for the N-pin */
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD, ndiv);
+	if (rc)
+		return rc;
+
+	/* For 50/50 duty cycle the divisor is equal to width */
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH, ndiv);
+	if (rc)
+		return rc;
+
+	/* Commit output configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -724,6 +957,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 09dd314663dff..9c62906de095d 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -198,4 +198,9 @@
 #define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV	12
 #define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV	15
 
+#define ZL_REG_OUTPUT_DIV			ZL_REG(14, 0x0c, 4)
+#define ZL_REG_OUTPUT_WIDTH			ZL_REG(14, 0x10, 4)
+#define ZL_REG_OUTPUT_ESYNC_PERIOD		ZL_REG(14, 0x14, 4)
+#define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
+
 #endif /* _ZL3073X_REGS_H */
-- 
2.49.0


