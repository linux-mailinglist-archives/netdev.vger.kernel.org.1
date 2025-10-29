Return-Path: <netdev+bounces-234045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC26C1BB04
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49651899E5E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DE33F36A;
	Wed, 29 Oct 2025 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhsG6ugp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B72E8E00
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751959; cv=none; b=dwOKKo+a+3y0B50tO17IsCpMitUy3G7JUo/mRykRWI9ZEUw5VnL9JsyyWxX5cIm30ZOjUV7Le6MztCX0JnoEzqDH3tHq7wtbfbC7Qqqka3tKSA+Zhab5Gau5o6lo+igYKe20Q1IeM7Ul6CnMtbkG42SWaQnUBqgF2NMPcwfX+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751959; c=relaxed/simple;
	bh=xauAvnk6/GxzHF/WP1wspDkYNiWic6rRsCYaAJRZOBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxCu8ySEelbXD42cKQuPU2z3F8ofNe8sVfjDuMJqqI73k3n0gVGw69xDOzup0SZqDfJKiW3XrBCtNonPu2JrxwOrqJghawGqncbHFI5a+e24Fp2gkZ/4JR23flti+/3mfRWhq1a3vmnzg1JMCRlyMHNiEIBWOidDivkAkUhBh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhsG6ugp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761751957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkdwrWzGIup7HfmUmpOde8bI+XzMz3fzDOaWpwVeTro=;
	b=fhsG6ugpr/0M/rrCbR2TGYxAS6D6Uu5ZM3SZyXA3oUZ6xB4qx5oKbGmzwRvr+pAOgRT6ie
	vYmY6YzyQM91cqGrGzKLhXfRbEnhgbgz0Ma/gHjySm7ABGOL2vEWsKvb5fjRu7MZROg5lX
	xjjJ59Ns4+Lt8w7TOLcQnKld/C2A8nk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-CbrkPr5RPu2ScHyfXUw2Rw-1; Wed,
 29 Oct 2025 11:32:29 -0400
X-MC-Unique: CbrkPr5RPu2ScHyfXUw2Rw-1
X-Mimecast-MFC-AGG-ID: CbrkPr5RPu2ScHyfXUw2Rw_1761751946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77E741808985;
	Wed, 29 Oct 2025 15:32:25 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.34.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 717F11800353;
	Wed, 29 Oct 2025 15:32:20 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] dpll: zl3073x: Specify phase adjustment granularity for pins
Date: Wed, 29 Oct 2025 16:32:07 +0100
Message-ID: <20251029153207.178448-3-ivecera@redhat.com>
In-Reply-To: <20251029153207.178448-1-ivecera@redhat.com>
References: <20251029153207.178448-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Output pins phase adjustment values in the device are expressed
in half synth clock cycles. Use this number of cycles as output
pins' phase adjust granularity and simplify both get/set callbacks.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 58 +++++++++----------------------------
 drivers/dpll/zl3073x/prop.c | 11 +++++++
 2 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 93dc93eec79ed..b13eb4e342d58 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -35,6 +35,7 @@
  * @prio: pin priority <0, 14>
  * @selectable: pin is selectable in automatic mode
  * @esync_control: embedded sync is controllable
+ * @phase_gran: phase adjustment granularity
  * @pin_state: last saved pin state
  * @phase_offset: last saved pin phase offset
  * @freq_offset: last saved fractional frequency offset
@@ -49,6 +50,7 @@ struct zl3073x_dpll_pin {
 	u8			prio;
 	bool			selectable;
 	bool			esync_control;
+	s32			phase_gran;
 	enum dpll_pin_state	pin_state;
 	s64			phase_offset;
 	s64			freq_offset;
@@ -1388,25 +1390,14 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	u32 synth_freq;
 	s32 phase_comp;
-	u8 out, synth;
+	u8 out;
 	int rc;
 
-	out = zl3073x_output_pin_out_get(pin->id);
-	synth = zl3073x_out_synth_get(zldev, out);
-	synth_freq = zl3073x_synth_freq_get(zldev, synth);
-
-	/* Check synth freq for zero */
-	if (!synth_freq) {
-		dev_err(zldev->dev, "Got zero synth frequency for output %u\n",
-			out);
-		return -EINVAL;
-	}
-
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read output configuration */
+	out = zl3073x_output_pin_out_get(pin->id);
 	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
 			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
 	if (rc)
@@ -1417,11 +1408,10 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	if (rc)
 		return rc;
 
-	/* Value in register is expressed in half synth clock cycles */
-	phase_comp *= (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
-
-	/* Reverse two's complement negation applied during 'set' */
-	*phase_adjust = -phase_comp;
+	/* Convert value to ps and reverse two's complement negation applied
+	 * during 'set'
+	 */
+	*phase_adjust = -phase_comp * pin->phase_gran;
 
 	return rc;
 }
@@ -1437,39 +1427,18 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	int half_synth_cycle;
-	u32 synth_freq;
-	u8 out, synth;
+	u8 out;
 	int rc;
 
-	/* Get attached synth */
-	out = zl3073x_output_pin_out_get(pin->id);
-	synth = zl3073x_out_synth_get(zldev, out);
-
-	/* Get synth's frequency */
-	synth_freq = zl3073x_synth_freq_get(zldev, synth);
-
-	/* Value in register is expressed in half synth clock cycles so
-	 * the given phase adjustment a multiple of half synth clock.
-	 */
-	half_synth_cycle = (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
-
-	if ((phase_adjust % half_synth_cycle) != 0) {
-		NL_SET_ERR_MSG_FMT(extack,
-				   "Phase adjustment value has to be multiple of %d",
-				   half_synth_cycle);
-		return -EINVAL;
-	}
-	phase_adjust /= half_synth_cycle;
-
 	/* The value in the register is stored as two's complement negation
-	 * of requested value.
+	 * of requested value and expressed in half synth clock cycles.
 	 */
-	phase_adjust = -phase_adjust;
+	phase_adjust = -phase_adjust / pin->phase_gran;
 
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read output configuration */
+	out = zl3073x_output_pin_out_get(pin->id);
 	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
 			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
 	if (rc)
@@ -1758,9 +1727,10 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	if (IS_ERR(props))
 		return PTR_ERR(props);
 
-	/* Save package label & esync capability */
+	/* Save package label, esync capability and phase adjust granularity */
 	strscpy(pin->label, props->package_label);
 	pin->esync_control = props->esync_control;
+	pin->phase_gran = props->dpll_props.phase_gran;
 
 	if (zl3073x_dpll_is_input_pin(pin)) {
 		rc = zl3073x_dpll_ref_prio_get(pin, &pin->prio);
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index 4cf7e8aefcb37..9e1fca5cdaf1e 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -208,7 +208,18 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 	} else {
+		u8 out, synth;
+		u32 f;
+
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+
+		/* The output pin phase adjustment granularity equals half of
+		 * the synth frequency count.
+		 */
+		out = zl3073x_output_pin_out_get(index);
+		synth = zl3073x_out_synth_get(zldev, out);
+		f = 2 * zl3073x_synth_freq_get(zldev, synth);
+		props->dpll_props.phase_gran = f ? div_u64(PSEC_PER_SEC, f) : 1;
 	}
 
 	props->dpll_props.phase_range.min = S32_MIN;
-- 
2.51.0


