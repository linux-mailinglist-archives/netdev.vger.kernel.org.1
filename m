Return-Path: <netdev+bounces-179805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF25A7E889
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE143BC708
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777D25484B;
	Mon,  7 Apr 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHv6iTZT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B23253F38
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047208; cv=none; b=drTHmwPWbz8q3YBsGIf2+FthHqUzcGuZA1Mr6rpqYKRrUlST6PykczLDfMqUPQc/L72p2/iEz0MBow87cyt1MEwDSyqTwAjHUVNlCYsbxvMY9gowcIWfLldqsW4tl04g+Gm92cV38pUyfgCwxgScCkPry4ZJ4du1Eugq9CbJ/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047208; c=relaxed/simple;
	bh=fOinvVF4zjc5mAIV5+YxY0DBJZSXdcUH4zkv4GiwKIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEq0B0j1gGtt/vSVOS5bBP1b4WIul+NpowMCKSp4Ia/BVNwOC/f7qmRcyo26/+YBGQ1+dpvWAlVEqmpovsEqDW2jelHuwk2FanVdlv1h0bd79OqoxOHKpMN/HynR2cOGL8bQGCyK8bfPaeE2JdfgPgKfG0y/nWhbAlwtDAaPkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHv6iTZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv+1ZBatY0TmzFGyhm3TfhAvf1Rfkq6eLjmy+v+sptY=;
	b=DHv6iTZTW7kvEq4QVfOsvMsZqKXBGXf//bOSrRuUkz8yugycjIsdbq33L2Pk2bwl6q7vWq
	ViME+tJfq2SaT0o5txdDHSkYCuMh4qrcA2pgmfpt1Uf3XabWv8UYXQeOrjdkocjQVVCr3T
	s40Qac1QGaX5/mDqmW7ydMAYG4TJSXA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-h0TdVLfoPYyS7zgSHc5bNw-1; Mon,
 07 Apr 2025 13:33:24 -0400
X-MC-Unique: h0TdVLfoPYyS7zgSHc5bNw-1
X-Mimecast-MFC-AGG-ID: h0TdVLfoPYyS7zgSHc5bNw_1744047201
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5170B180AF52;
	Mon,  7 Apr 2025 17:33:21 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDAB7180B488;
	Mon,  7 Apr 2025 17:33:15 +0000 (UTC)
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
Subject: [PATCH 22/28] dpll: zl3073x: Add support to get/set frequency on input pins
Date: Mon,  7 Apr 2025 19:32:55 +0200
Message-ID: <20250407173301.1010462-3-ivecera@redhat.com>
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

Add support to get/set frequency from/to input pins. The frequency
for input pins (references) is computed in the device according this
formula:

 freq = base_freq * multiplier * (nominator / denominator)

where the base_freq comes from the list of supported base frequencies
and other parameters are arbitrary numbers. All these parameters are
16-bit unsigned integers.

Implement necessary callbacks for input pins and helper function
to factorize a frequency into a base frequency and a multiplier
(nominator and denominator are used as 1 for now).

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 179 ++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 192e0e56fcdde..965664da9371d 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -56,6 +56,14 @@ ZL3073X_REG8_DEF(synth_phase_shift_mask,	0x49f);
 ZL3073X_REG8_DEF(synth_phase_shift_intvl,	0x4a0);
 ZL3073X_REG16_DEF(synth_phase_shift_data,	0x4a1);
 
+/*
+ * Register Map Page 10, Ref Mailbox
+ */
+ZL3073X_REG16_DEF(ref_freq_base,		0x505);
+ZL3073X_REG16_DEF(ref_freq_mult,		0x507);
+ZL3073X_REG16_DEF(ref_ratio_m,			0x509);
+ZL3073X_REG16_DEF(ref_ratio_n,			0x50b);
+
 /*
  * Register Map Page 12, DPLL Mailbox
  */
@@ -218,6 +226,175 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_input_ref_frequency_factorize - factorize given frequency
+ * @freq: input frequency
+ * @base_freq: base frequency
+ * @mult: multiplier
+ *
+ * Checks if the given frequency can be factorized using one of the
+ * supported base frequencies. If so the base frequency and multiplier
+ * are stored into appropriate parameters if they are not NULL and
+ * returns 0. If the frequency cannot be factorized then the function
+ * returns -EINVAL.
+ */
+static int
+zl3073x_dpll_input_ref_frequency_factorize(u64 freq, u16 *base, u16 *mult)
+{
+	static const u16 base_freqs[] = {
+		1, 2, 4, 5, 8, 10, 16, 20, 25, 32, 40, 50, 64, 80, 100, 125,
+		128, 160, 200, 250, 256, 320, 400, 500, 625, 640, 800, 1000,
+		1250, 1280, 1600, 2000, 2500, 3125, 3200, 4000, 5000, 6250,
+		6400, 8000, 10000, 12500, 15625, 16000, 20000, 25000, 31250,
+		32000, 40000, 50000, 62500,
+	};
+	u32 div, rem;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(base_freqs); i++) {
+		div = div_u64_rem(freq, base_freqs[i], &rem);
+		if (!rem && div <= U16_MAX) {
+			if (base)
+				*base = base_freqs[i];
+			if (mult)
+				*mult = div;
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
+ * zldev: pointer to device structure
+ * ref_id: reference id
+ * frequency: pointer to variable to store frequency
+ *
+ * Context: zl3073x_dev.lock has to be held
+ *
+ * Reads frequency of given input reference.
+ *
+ * Returns 0 in case of success or negative value if error occurred
+ */
+static int
+zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dev *zldev, u8 ref_id,
+				     u64 *frequency)
+{
+	u16 base_freq, mult, num, denom;
+	int rc;
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_ref_read(zldev, ref_id);
+	if (rc)
+		return rc;
+
+	/* Read base frequency */
+	rc = zl3073x_read_ref_freq_base(zldev, &base_freq);
+	if (rc)
+		return rc;
+
+	/* Read multiplier */
+	rc = zl3073x_read_ref_freq_mult(zldev, &mult);
+	if (rc)
+		return rc;
+
+	/* Write numerator */
+	rc = zl3073x_read_ref_ratio_m(zldev, &num);
+	if (rc)
+		return rc;
+
+	/* Write denominator */
+	rc = zl3073x_read_ref_ratio_n(zldev, &denom);
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
+	*frequency = mul_u64_u32_div(base_freq * mult, num, denom);
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
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 ref_id;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Read and return ref frequency */
+	return zl3073x_dpll_input_ref_frequency_get(zldev, ref_id, frequency);
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
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u16 base_freq, mult;
+	u8 ref_id;
+	int rc;
+
+	/* Get base frequency and multiplier for the requested frequency */
+	rc = zl3073x_dpll_input_ref_frequency_factorize(frequency, &base_freq,
+							&mult);
+	if (rc)
+		return rc;
+
+	/* Take device lock */
+	guard(zl3073x)(zldev);
+
+	/* Write base frequency */
+	rc = zl3073x_write_ref_freq_base(zldev, base_freq);
+	if (rc)
+		return rc;
+
+	/* Write multiplier */
+	rc = zl3073x_write_ref_freq_mult(zldev, mult);
+	if (rc)
+		return rc;
+
+	/* Write numerator */
+	rc = zl3073x_write_ref_ratio_m(zldev, 1);
+	if (rc)
+		return rc;
+
+	/* Write denominator */
+	rc = zl3073x_write_ref_ratio_n(zldev, 1);
+	if (rc)
+		return rc;
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
+
+	/* Update reference configuration from mailbox */
+	return zl3073x_mb_ref_write(zldev, ref_id);
+}
+
 /**
  * zl3073x_dpll_selected_ref_get - get currently selected reference
  * @zldpll: pointer to zl3073x_dpll
@@ -685,6 +862,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
-- 
2.48.1


