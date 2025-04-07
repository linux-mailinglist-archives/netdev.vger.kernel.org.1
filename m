Return-Path: <netdev+bounces-179809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F730A7E89D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75221189C293
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7C25522E;
	Mon,  7 Apr 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aotd0HP8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBC255229
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047237; cv=none; b=cxbJZ9mC8AgXhbkUOe4dT2gmAYqOEF3FSI8Wqw0g44MlA25wXcL5RN97POf/5HPuoT/AFW+e0nJ2css2iYK3ZYJi/kViZTj9kR0FiAh0iAcA9rzHIoggW7e2AI8sikvzZMUOAdpd9C/5hlv8hE/IdWhbbbXklx/Q7ZLmY4O/YGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047237; c=relaxed/simple;
	bh=5U093kAY3hoxDsZMSwlw+0r/goDrQdnI3Vv4TryWwjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0zLEwpB8oTkhvTM4bi8XalY4MOKXbos/gvnoXyYRuKqISA8hPGaFXlPpZ4SabKPDWpm1EbxMk/jQqvMVqtPBW/rmuyLc0aZ3nUXH+oVMBg/88u7FWlPH84xjhZ3mhEdElo4SwsTfJ/deMjMtCWxiM0/+wTtX7dO9f7t7o/WTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aotd0HP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwU+hrjd2qkJ6gHJBxOGGNS7xPX2aUI8bJ62fHCyzOw=;
	b=Aotd0HP8XhuX8kCY3vSKZNCmuuB4rtShSVvTJbpr7MS6vNKojE2sz6tt71pLbpXNNuC5GN
	goGu5plqEYw7928LS8i7Akv9MxftTr/k3wzPqSDJZoELSwmWe2af47p4fGP9GQU8RTWrYo
	qGjC7bOYw/PplC2uElXiFBU1BDKYBcY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-c_A4qxucOme73u5Ag1nZcg-1; Mon,
 07 Apr 2025 13:33:48 -0400
X-MC-Unique: c_A4qxucOme73u5Ag1nZcg-1
X-Mimecast-MFC-AGG-ID: c_A4qxucOme73u5Ag1nZcg_1744047225
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3279180025B;
	Mon,  7 Apr 2025 17:33:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DA0D1828A80;
	Mon,  7 Apr 2025 17:33:39 +0000 (UTC)
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
Subject: [PATCH 26/28] dpll: zl3073x: Add support to get/set phase adjust on pins
Date: Mon,  7 Apr 2025 19:32:59 +0200
Message-ID: <20250407173301.1010462-7-ivecera@redhat.com>
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

This adds support to get/set phase adjustment for both input and output
pins. The phase adjustment is implemented using reference and output
phase offset compensation registers. For input pins the adjustment value
can be arbitrary number but for outputs the value has to be a multiple
of half synthesizer clock cycles.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 182 ++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index 3b28d229dd4be..b1f38f000899b 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -79,6 +79,7 @@ ZL3073X_REG16_DEF(ref_freq_base,		0x505);
 ZL3073X_REG16_DEF(ref_freq_mult,		0x507);
 ZL3073X_REG16_DEF(ref_ratio_m,			0x509);
 ZL3073X_REG16_DEF(ref_ratio_n,			0x50b);
+ZL3073X_REG48_DEF(ref_phase_compensation,	0x528);
 
 /*
  * Register Map Page 12, DPLL Mailbox
@@ -98,6 +99,8 @@ ZL3073X_REG32_DEF(output_width,			0x710);
 ZL3073X_REG32_DEF(output_ndiv_period,		0x714);
 ZL3073X_REG32_DEF(output_ndiv_width,		0x718);
 
+ZL3073X_REG32_DEF(output_phase_compensation,	0x720);
+
 #define ZL3073X_REF_NONE			ZL3073X_NUM_INPUT_PINS
 #define ZL3073X_REF_IS_VALID(_ref)		((_ref) != ZL3073X_REF_NONE)
 
@@ -690,6 +693,85 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	return rc;
 }
 
+static int
+zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv,
+					s32 *phase_adjust,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	s64 phase_comp;
+	u8 ref_id;
+	int rc;
+
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
+	/* Read current phase offset compensation */
+	rc = zl3073x_read_ref_phase_compensation(zldev, &phase_comp);
+	if (rc)
+		return rc;
+
+	/* Perform sign extension for 48bit signed value */
+	phase_comp = sign_extend64(phase_comp, 47);
+
+	/* Reverse two's complement negation applied during set and convert
+	 * to 32bit signed int
+	 */
+	*phase_adjust = (s32) -phase_comp;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv,
+					s32 phase_adjust,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	s64 phase_comp;
+	u8 ref_id;
+	int rc;
+
+	guard(zl3073x)(zldev);
+
+	/* The value in the register is stored as two's complement negation
+	 * of requested value.
+	 */
+	phase_comp = (s64) -phase_adjust;
+
+	/* Write the requested value into the compensation register */
+	rc = zl3073x_write_ref_phase_compensation(zldev, phase_comp);
+	if (rc)
+		return rc;
+
+	/* Get index of the pin */
+	ref_id = zl3073x_dpll_pin_index_get(pin);
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
 zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
 {
@@ -1165,6 +1247,102 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_mb_output_write(zldev, output);
 }
 
+static int
+zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 s32 *phase_adjust,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u8 output, synth;
+	u64 synth_freq;
+	s32 phase_comp;
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
+	/* Read current output phase compensation */
+	rc = zl3073x_read_output_phase_compensation(zldev, &phase_comp);
+	if (rc)
+		return rc;
+
+	/* Value in register is expressed in half synth clock cycles */
+	phase_comp *= (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
+
+	/* Reverse two's complement negation applied during 'set' */
+	*phase_adjust = -phase_comp;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 s32 phase_adjust,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	int half_synth_cycle;
+	u8 output, synth;
+	u64 synth_freq;
+	int phase_comp;
+	int rc;
+
+	/* Get attached synth */
+	synth = zl3073x_dpll_pin_synth_get(pin);
+
+	/* Get synth's frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Value in register is expressed in half synth clock cycles so
+	 * the given phase adjustment a multiple of half synth clock.
+	 */
+	half_synth_cycle = (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
+
+	if ((phase_adjust % half_synth_cycle) != 0) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Phase adjustment value has to be multiple of %d",
+				   half_synth_cycle);
+		return -EINVAL;
+	}
+	phase_adjust /= half_synth_cycle;
+
+	guard(zl3073x)(zldev);
+
+	/* The value in the register is stored as two's complement negation
+	 * of requested value.
+	 */
+	phase_comp = -phase_adjust;
+
+	/* Write the requested value into the compensation register */
+	rc = zl3073x_write_output_phase_compensation(zldev, phase_comp);
+	if (rc)
+		return rc;
+
+	/* Update output configuration from mailbox */
+	output = zl3073x_dpll_output_pin_output_get(pin);
+	rc = zl3073x_mb_output_write(zldev, output);
+
+	return rc;
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -1243,6 +1421,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
+	.phase_adjust_get = zl3073x_dpll_input_pin_phase_adjust_get,
+	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
@@ -1253,6 +1433,8 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
+	.phase_adjust_get = zl3073x_dpll_output_pin_phase_adjust_get,
+	.phase_adjust_set = zl3073x_dpll_output_pin_phase_adjust_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
-- 
2.48.1


