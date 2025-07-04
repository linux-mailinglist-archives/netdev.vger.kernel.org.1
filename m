Return-Path: <netdev+bounces-204243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C8AF9AB1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47B81887C98
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF52EE981;
	Fri,  4 Jul 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2yHKFyz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A99326A67
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653434; cv=none; b=Y353Soc1SH1B1STh820EnpbPZxD+WfwB7EZLUGqlqe4ckAbH34OFWzYKyj7PKp8gHq1taAhJNDcrjcDms0ZfrOYIw6GOB5ghriqU01aA8cULtfRPDP9ube13k39oBfdcWnm2KX3rC7oHtIxmQkhmgqlX/gX3gIbensePwE6beVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653434; c=relaxed/simple;
	bh=XRgVpgnM7pxZFXiTe5lCUdorkhdYB+MJ6POhXCwyO08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M02jrBwhqRlkduRh+Jx5CXN/umhHRuc670ujtjJGnqpWjGLX3GanPzEBkskjqNlIcIf0O7mrB4n5k5A7IanYz35H3aHHDYAUOk+/kxvTcy9pvkkMULErl3vkpI94OHsNTorNapnIorBBm7Shkdjg0ZBllZmvoBZDRLERp+RxEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2yHKFyz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9jckliHnHTfALUaXs+FmqJIvCwgAR0BWWD929o+6eM=;
	b=B2yHKFyzyI0gZn60yy693pgsXg4kDMZYy06QdW/Y38JAH7bGLkJLwlT/8nPmNFnnG5/41d
	/Qz6yjd/iM/k43Vj8guQJoWgwc4NTh91lx0BTR1mvptvrI/xARV/Mbu+De2QPCEWXmYCIl
	5sZXOnunyEntCR0jq9JjlsGAw8n0g8o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-2sJmhORPMfaBJFhIqlECRg-1; Fri,
 04 Jul 2025 14:23:47 -0400
X-MC-Unique: 2sJmhORPMfaBJFhIqlECRg-1
X-Mimecast-MFC-AGG-ID: 2sJmhORPMfaBJFhIqlECRg_1751653424
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C46F91955EC6;
	Fri,  4 Jul 2025 18:23:44 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5356619560A7;
	Fri,  4 Jul 2025 18:23:38 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
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
Subject: [PATCH net-next v13 12/12] dpll: zl3073x: Add support to get/set frequency on pins
Date: Fri,  4 Jul 2025 20:22:02 +0200
Message-ID: <20250704182202.1641943-13-ivecera@redhat.com>
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support to get/set frequency on pins. The frequency for input
pins (references) is computed in the device according this formula:

 freq = base_freq * multiplier * (nominator / denominator)

where the base_freq comes from the list of supported base frequencies
and other parameters are arbitrary numbers. All these parameters are
16-bit unsigned integers.

The frequency for output pin is determined by the frequency of
synthesizer the output pin is connected to and divisor of the output
to which is the given pin belongs. The resulting frequency of the
P-pin and the N-pin from this output pair depends on the signal
format of this output pair.

The device supports so-called N-divided signal formats where for the
N-pin there is an additional divisor. The frequencies for both pins
from such output pair are computed:

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
v13:
* squashed patch 14
---
 drivers/dpll/zl3073x/dpll.c | 349 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  10 ++
 2 files changed, 359 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index d39094b7cbc88..cb0f1a43c5fbd 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -8,6 +8,7 @@
 #include <linux/dpll.h>
 #include <linux/err.h>
 #include <linux/kthread.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -84,6 +85,127 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
+ * @zldpll: pointer to zl3073x_dpll
+ * @ref_id: reference id
+ * @frequency: pointer to variable to store frequency
+ *
+ * Reads frequency of given input reference.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
+				     u32 *frequency)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u16 base, mult, num, denom;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref_id));
+	if (rc)
+		return rc;
+
+	/* Read registers to compute resulting frequency */
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
+	if (rc)
+		return rc;
+
+	/* Sanity check that HW has not returned zero denominator */
+	if (!denom) {
+		dev_err(zldev->dev,
+			"Zero divisor for ref %u frequency got from device\n",
+			ref_id);
+		return -EINVAL;
+	}
+
+	/* Compute the frequency */
+	*frequency = mul_u64_u32_div(base * mult, num, denom);
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
+				     void *pin_priv,
+				     const struct dpll_device *dpll,
+				     void *dpll_priv, u64 *frequency,
+				     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 ref_freq;
+	u8 ref;
+	int rc;
+
+	/* Read and return ref frequency */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref, &ref_freq);
+	if (!rc)
+		*frequency = ref_freq;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				     void *pin_priv,
+				     const struct dpll_device *dpll,
+				     void *dpll_priv, u64 frequency,
+				     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u16 base, mult;
+	u8 ref;
+	int rc;
+
+	/* Get base frequency and multiplier for the requested frequency */
+	rc = zl3073x_ref_freq_factorize(frequency, &base, &mult);
+	if (rc)
+		return rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Load reference configuration */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+
+	/* Update base frequency, multiplier, numerator & denominator */
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_BASE, base);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_MULT, mult);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_M, 1);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_N, 1);
+	if (rc)
+		return rc;
+
+	/* Commit reference configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+			     ZL_REG_REF_MB_MASK, BIT(ref));
+}
+
 /**
  * zl3073x_dpll_selected_ref_get - get currently selected reference
  * @zldpll: pointer to zl3073x_dpll
@@ -518,6 +640,229 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
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
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -611,6 +956,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
@@ -619,6 +966,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 
 static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index dafe62da81d06..493c63e729208 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -137,6 +137,11 @@
 #define ZL_REF_MB_SEM_WR			BIT(0)
 #define ZL_REF_MB_SEM_RD			BIT(1)
 
+#define ZL_REG_REF_FREQ_BASE			ZL_REG(10, 0x05, 2)
+#define ZL_REG_REF_FREQ_MULT			ZL_REG(10, 0x07, 2)
+#define ZL_REG_REF_RATIO_M			ZL_REG(10, 0x09, 2)
+#define ZL_REG_REF_RATIO_N			ZL_REG(10, 0x0b, 2)
+
 #define ZL_REG_REF_CONFIG			ZL_REG(10, 0x0d, 1)
 #define ZL_REF_CONFIG_ENABLE			BIT(0)
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
@@ -195,4 +200,9 @@
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


