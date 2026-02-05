Return-Path: <netdev+bounces-257237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KVzEli7hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:46:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA9F4BB0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6499E3048BF6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D624266BB;
	Thu,  5 Feb 2026 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8kMs3vO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB814266B1
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306253; cv=none; b=ifOY4JhBFhh639l7csIIqp4tvSKbEJPbzHqLJehm5dgOtaM9D8Cj4rSohWUnmUGZKPDRT0cUX71oWMyA3dTtoSgUOnKmqgPALfEqnhB9GJURE3RI75Rv1dwlceu1W4PNZxRpDruDPj+7VIjfw2U0ufBdFqAD+nIY0hWmrWyDiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306253; c=relaxed/simple;
	bh=beJbh9Q51hftX3sFzrLlw65qA1wbptRaJa7R+UbWVuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfYKF7QAWgoJnLUV4Qo6B+tFxcXahNJ74IrjzkGXfwP0BoUUypfnw7+czaR27kxOA3g7XvHr2TymIBsKLh32Rnu5mTI3N1cIfFNNz2xgN3ZR4FEV6dcfylt0KncYo5jsOOGXziedRlKlsu+rbOlDmDVVazZe46D3NDb0ccpGjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8kMs3vO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770306251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUIU87dxavbL2UbuwPOctpcR60YHm3cGpL66RI9YjQs=;
	b=U8kMs3vOjPXHkT2bFIQ7Pvge/olR8t0H6OnQ3OgZcbsNaUdLPRwZBsLAiX6uexLTFMiwqA
	Qdt8F8qFT4+M/eLMWsR2KMmMrLdikSF1ZoC2LykA7abiR79RF/bTHQ16YXsqxbcB3QNbbB
	cyk3SZGAgvFaSaHD0qxN6fmHnzmYLkg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-wS1-gwcLMwaB8eP9VknEig-1; Thu,
 05 Feb 2026 10:44:08 -0500
X-MC-Unique: wS1-gwcLMwaB8eP9VknEig-1
X-Mimecast-MFC-AGG-ID: wS1-gwcLMwaB8eP9VknEig_1770306243
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A46E4195C276;
	Thu,  5 Feb 2026 15:44:00 +0000 (UTC)
Received: from cnb-01.lab.eng.brq2.redhat.com (cnb-01.lab.eng.brq2.redhat.com [10.37.129.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 282F018003F6;
	Thu,  5 Feb 2026 15:43:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] dpll: zl3073x: Include current frequency in supported frequencies list
Date: Thu,  5 Feb 2026 16:43:50 +0100
Message-ID: <20260205154350.3180465-3-ivecera@redhat.com>
In-Reply-To: <20260205154350.3180465-1-ivecera@redhat.com>
References: <20260205154350.3180465-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257237-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFBA9F4BB0
X-Rspamd-Action: no action

Ensure the current pin frequency is always present in the list of
supported frequencies reported to userspace. Previously, if the
firmware node was missing or didn't include the current operating
frequency in the supported-frequencies-hz property, the pin would
report a frequency that wasn't in its supported list.

Get the current frequency early in zl3073x_pin_props_get():
- For input pins: use zl3073x_dev_ref_freq_get()
- For output pins: use zl3073x_dev_output_pin_freq_get()

Place the current frequency at index 0 of the supported frequencies
array, then append frequencies from the firmware node (if present),
skipping any duplicate of the current frequency.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index 4ed153087570..51748b0e523b 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -193,9 +193,10 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 {
 	struct dpll_pin_frequency *ranges;
 	struct zl3073x_pin_props *props;
-	int i, j, num_freqs, rc;
+	int i, j, num_freqs = 0, rc;
+	u64 *freqs = NULL;
 	const char *type;
-	u64 *freqs;
+	u32 curr_freq;
 
 	props = kzalloc(sizeof(*props), GFP_KERNEL);
 	if (!props)
@@ -207,6 +208,7 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 		props->dpll_props.capabilities =
 			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		curr_freq = zl3073x_dev_ref_freq_get(zldev, index);
 	} else {
 		u8 out, synth;
 		u32 f;
@@ -220,6 +222,7 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 		synth = zl3073x_dev_out_synth_get(zldev, out);
 		f = 2 * zl3073x_dev_synth_freq_get(zldev, synth);
 		props->dpll_props.phase_gran = f ? div_u64(PSEC_PER_SEC, f) : 1;
+		curr_freq = zl3073x_dev_output_pin_freq_get(zldev, index);
 	}
 
 	props->dpll_props.phase_range.min = S32_MIN;
@@ -230,7 +233,7 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 	/* Get firmware node for the given pin */
 	rc = zl3073x_prop_pin_fwnode_get(zldev, props, dir, index);
 	if (rc)
-		return props; /* Return if it does not exist */
+		goto skip_fwnode_props;
 
 	/* Look for label property and store the value as board label */
 	fwnode_property_read_string(props->fwnode, "label",
@@ -262,9 +265,10 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 	/* Read supported frequencies property if it is specified */
 	num_freqs = fwnode_property_count_u64(props->fwnode,
 					      "supported-frequencies-hz");
-	if (num_freqs <= 0)
-		/* Return if the property does not exist or number is 0 */
-		return props;
+	if (num_freqs <= 0) {
+		num_freqs = 0;
+		goto skip_fwnode_props;
+	}
 
 	/* The firmware node specifies list of supported frequencies while
 	 * DPLL core pin properties requires list of frequency ranges.
@@ -281,19 +285,25 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 				       "supported-frequencies-hz", freqs,
 				       num_freqs);
 
-	/* Allocate frequency ranges list and fill it */
-	ranges = kcalloc(num_freqs, sizeof(*ranges), GFP_KERNEL);
+skip_fwnode_props:
+	/* Allocate frequency ranges list - extra slot for current frequency */
+	ranges = kcalloc(num_freqs + 1, sizeof(*ranges), GFP_KERNEL);
 	if (!ranges) {
 		rc = -ENOMEM;
 		goto err_alloc_ranges;
 	}
 
-	/* Convert list of frequencies to list of frequency ranges but
-	 * filter-out frequencies that are not representable by device
+	/* Start with current frequency at index 0 */
+	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
+
+	/* Add frequencies from firmware node, skipping current frequency
+	 * and filtering out frequencies not representable by device
 	 */
-	for (i = 0, j = 0; i < num_freqs; i++) {
+	for (i = 0, j = 1; i < num_freqs; i++) {
 		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
 
+		if (freqs[i] == curr_freq)
+			continue;
 		if (zl3073x_pin_check_freq(zldev, dir, index, freqs[i])) {
 			ranges[j] = freq;
 			j++;
-- 
2.52.0


