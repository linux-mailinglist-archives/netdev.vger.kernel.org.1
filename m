Return-Path: <netdev+bounces-269586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBq2H503vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:51:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A3A2D04F5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CC0630055C8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE93EFD1C;
	Thu, 19 Mar 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ercbtg/V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C83F0750
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942527; cv=none; b=M4kWZwWXTmucoUAlIEvAAWvAxg61t1dkPBGbiLalKEKo+cd3rtt/P0n9KT8/QXPd8SrouCvUZ6Qkz0VihyD6XMECUG65s6w6DSe0M3S4XTTP2ha0m5PiY5dfVu4/v3A1xF/8uqwmx8tNuK+3vEUlJXEpSuTmuqK+i1oyi1/4UEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942527; c=relaxed/simple;
	bh=kjNH7FWLNS9x9giTCrdcAsFzjmSPBqdWUcvW0CQKihI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9+d1qjk8gsjsdY4BIifF7w+32p4wfrXk3eHf47pbJtee0xIUhyEGyl9a3pwGIJ07mRrKNY7fDJ3WfDeefHiZ+df1Y15r7iVCPcBHbXiVEpXzjlJ3vWv9djAHhLDLmtX9Hqti4qggQkbKfyra5um7iQ4RFdPDfKTH1qOLHKBr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ercbtg/V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyQG9yevk1xligmB7MjycSxF0+q8dc7XOQQEnMXUrT0=;
	b=ercbtg/VN+SzQIRUq83Pby6sExaIHGtO/gdwn9F1GCDKPz4iKbrbRONI8v1obah739Fp5a
	TLK/y8YZrtO1dWHs8yVbFkyMvtWgdHM+yAv4Pi0v9feh/Tt8VnM06Xo7I0Jpz5xVmxtvBg
	j/1th/R+t684wALTRE7bKG9i+ZHZyy0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-sITm5hv2PXOE-U2U81Vy7w-1; Thu,
 19 Mar 2026 13:48:38 -0400
X-MC-Unique: sITm5hv2PXOE-U2U81Vy7w-1
X-Mimecast-MFC-AGG-ID: sITm5hv2PXOE-U2U81Vy7w_1773942516
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88CFB195609F;
	Thu, 19 Mar 2026 17:48:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73ABF30002DF;
	Thu, 19 Mar 2026 17:48:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 1/5] dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
Date: Thu, 19 Mar 2026 18:48:22 +0100
Message-ID: <20260319174826.7623-2-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-1-ivecera@redhat.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269586-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.908];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A3A2D04F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Return -EOPNOTSUPP early in esync_get callbacks when esync is not
supported instead of conditionally populating the range at the end.
This simplifies the control flow by removing the finish label/goto
in the output variant and the conditional range assignment in both
input and output variants.

Replace open-coded N-div signal format switch statements with
zl3073x_out_is_ndiv() helper in esync_get, esync_set and
frequency_set callbacks.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 64 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index a29f606318f6d..79ef62d69a32d 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -131,6 +131,12 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 
+	if (!pin->esync_control || zl3073x_ref_freq_get(ref) == 1)
+		return -EOPNOTSUPP;
+
+	esync->range = esync_freq_ranges;
+	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
+
 	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
 	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
 		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
@@ -142,17 +148,6 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 		break;
 	}
 
-	/* If the pin supports esync control expose its range but only
-	 * if the current reference frequency is > 1 Hz.
-	 */
-	if (pin->esync_control && zl3073x_ref_freq_get(ref) > 1) {
-		esync->range = esync_freq_ranges;
-		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
-	} else {
-		esync->range = NULL;
-		esync->range_num = 0;
-	}
-
 	return 0;
 }
 
@@ -582,8 +577,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	const struct zl3073x_out *out;
+	u32 synth_freq, out_freq;
 	u8 clock_type, out_id;
-	u32 synth_freq;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
@@ -592,17 +587,19 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	switch (zl3073x_out_signal_format_get(out)) {
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+	if (zl3073x_out_is_ndiv(out))
 		return -EOPNOTSUPP;
-	default:
-		break;
-	}
 
 	/* Get attached synth frequency */
 	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
 	synth_freq = zl3073x_synth_freq_get(synth);
+	out_freq = synth_freq / out->div;
+
+	if (!pin->esync_control || out_freq == 1)
+		return -EOPNOTSUPP;
+
+	esync->range = esync_freq_ranges;
+	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
 	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
 	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
@@ -610,11 +607,11 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 		esync->freq = 0;
 		esync->pulse = 0;
 
-		goto finish;
+		return 0;
 	}
 
 	/* Compute esync frequency */
-	esync->freq = synth_freq / out->div / out->esync_n_period;
+	esync->freq = out_freq / out->esync_n_period;
 
 	/* By comparing the esync_pulse_width to the half of the pulse width
 	 * the esync pulse percentage can be determined.
@@ -623,18 +620,6 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	 */
 	esync->pulse = (50 * out->esync_n_width) / out->div;
 
-finish:
-	/* Set supported esync ranges if the pin supports esync control and
-	 * if the output frequency is > 1 Hz.
-	 */
-	if (pin->esync_control && (synth_freq / out->div) > 1) {
-		esync->range = esync_freq_ranges;
-		esync->range_num = ARRAY_SIZE(esync_freq_ranges);
-	} else {
-		esync->range = NULL;
-		esync->range_num = 0;
-	}
-
 	return 0;
 }
 
@@ -660,13 +645,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	 * for N-division is also used for the esync divider so both cannot
 	 * be used.
 	 */
-	switch (zl3073x_out_signal_format_get(&out)) {
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+	if (zl3073x_out_is_ndiv(&out))
 		return -EOPNOTSUPP;
-	default:
-		break;
-	}
 
 	/* Select clock type */
 	if (freq)
@@ -728,9 +708,9 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
-	u8 out_id, signal_format;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
+	u8 out_id;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -740,12 +720,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	synth_freq = zl3073x_synth_freq_get(synth);
 	new_div = synth_freq / (u32)frequency;
 
-	/* Get used signal format for the given output */
-	signal_format = zl3073x_out_signal_format_get(&out);
-
 	/* Check signal format */
-	if (signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV &&
-	    signal_format != ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV) {
+	if (!zl3073x_out_is_ndiv(&out)) {
 		/* For non N-divided signal formats the frequency is computed
 		 * as division of synth frequency and output divisor.
 		 */
-- 
2.52.0


