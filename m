Return-Path: <netdev+bounces-276431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHThOlQu1mkUBggAu9opvQ
	(envelope-from <netdev+bounces-276431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:30:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AB3BA8A6
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC07300F12C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22D3B5304;
	Wed,  8 Apr 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5yuviyy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BA3B52FD
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644065; cv=none; b=OfjsoN/VrDNhFLB9rvhp1kwrNlYeLpupTo5TdRVWyFl5VLRWCBFfhmb6DNtU65BRdPvW3o4Y9soRW4MWsJ9NPhu/6qYw28E+Q1CT6yqemMMHwcGJ1quasLZfDxwzhLR5yA2wmtww6bdHc3hEQh3CbRF6+C67d0e3sG0XsoQ4ISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644065; c=relaxed/simple;
	bh=dJxSnJRH5WTlhbS1qcNR3twfxF1DvgYpesJvkQBb1ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF36wONRMz3mAmuhvLGDBIOsioffidXcyQ80uwhPSw/FEvGmIhmC9mc6Y+nPlGE0C6OGkEN+BdIAOyI+NrdW9lHcUY7kWxyR+IM6P2UxUeBeQ+AmmP0dINzQEnvw7nmgyVf+kU+uGrJqWfvk5yYitfNRkjUq7WZVAhOPpDoB+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5yuviyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775644060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4T+OSw4cC1VWqFnZcfYN55af56xqFffJJ2JU0uA9v0=;
	b=Y5yuviyypJy9/xJDDuIYxL2kxm8nK9sJ/9t1pW2VrMGy0OdUcld17CYcUwU+zB1wWVjrkE
	jsUfUPToGspWxV7zxUoknuinq5YQif2ki7yoogYJ3L6u3ViGCZsu6D2ulrvgHtKNDDcXJ+
	w17Ho9nePbBCTjXdVV/QizWVP5WljLw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-0gkzbUe_M3mIcwP9yabi_g-1; Wed,
 08 Apr 2026 06:27:37 -0400
X-MC-Unique: 0gkzbUe_M3mIcwP9yabi_g-1
X-Mimecast-MFC-AGG-ID: 0gkzbUe_M3mIcwP9yabi_g_1775644056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9D311956059;
	Wed,  8 Apr 2026 10:27:35 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F30B3000203;
	Wed,  8 Apr 2026 10:27:31 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next v3 3/5] dpll: zl3073x: add ref sync and output clock type helpers
Date: Wed,  8 Apr 2026 12:27:14 +0200
Message-ID: <20260408102716.443099-4-ivecera@redhat.com>
In-Reply-To: <20260408102716.443099-1-ivecera@redhat.com>
References: <20260408102716.443099-1-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276431-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 6E0AB3BA8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR and ZL_REF_SYNC_CTRL_PAIR
register definitions.

Add inline helpers to get and set the sync control mode and sync pair
fields of the reference sync control register:

  zl3073x_ref_sync_mode_get/set() - ZL_REF_SYNC_CTRL_MODE field
  zl3073x_ref_sync_pair_get/set() - ZL_REF_SYNC_CTRL_PAIR field

Add inline helpers to get and set the clock type field of the output
mode register:

  zl3073x_out_clock_type_get/set() - ZL_OUTPUT_MODE_CLOCK_TYPE field

Convert existing esync callbacks to use the new helpers.

Reviewed-by: Petr Oros <poros@redhat.com>
Reviewed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 24 ++++++++-----------
 drivers/dpll/zl3073x/out.h  | 22 ++++++++++++++++++
 drivers/dpll/zl3073x/ref.h  | 46 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  2 ++
 4 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 445f4bccb9aab..dc649cf103cb4 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -139,7 +139,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
+	switch (zl3073x_ref_sync_mode_get(ref)) {
 	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
 		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
 		esync->pulse = 25;
@@ -175,8 +175,7 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	else
 		sync_mode = ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
 
-	ref.sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
-	ref.sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
+	zl3073x_ref_sync_mode_set(&ref, sync_mode);
 
 	if (freq) {
 		/* 1 Hz is only supported frequency now */
@@ -595,7 +594,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_synth *synth;
 	const struct zl3073x_out *out;
 	u32 synth_freq, out_freq;
-	u8 clock_type, out_id;
+	u8 out_id;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
@@ -618,8 +617,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
-	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
 		/* No need to read esync data if it is not enabled */
 		esync->freq = 0;
 		esync->pulse = 0;
@@ -652,8 +650,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	struct zl3073x_out out;
-	u8 clock_type, out_id;
 	u32 synth_freq;
+	u8 out_id;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -665,15 +663,13 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	if (zl3073x_out_is_ndiv(&out))
 		return -EOPNOTSUPP;
 
-	/* Select clock type */
+	/* Update clock type in output mode */
 	if (freq)
-		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC;
+		zl3073x_out_clock_type_set(&out,
+					   ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC);
 	else
-		clock_type = ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL;
-
-	/* Update clock type in output mode */
-	out.mode &= ~ZL_OUTPUT_MODE_CLOCK_TYPE;
-	out.mode |= FIELD_PREP(ZL_OUTPUT_MODE_CLOCK_TYPE, clock_type);
+		zl3073x_out_clock_type_set(&out,
+					   ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL);
 
 	/* If esync is being disabled just write mailbox and finish */
 	if (!freq)
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index edf40432bba5f..660889c57bffa 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -42,6 +42,28 @@ const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
 int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 			  const struct zl3073x_out *out);
 
+/**
+ * zl3073x_out_clock_type_get - get output clock type
+ * @out: pointer to out state
+ *
+ * Return: clock type of given output (ZL_OUTPUT_MODE_CLOCK_TYPE_*)
+ */
+static inline u8 zl3073x_out_clock_type_get(const struct zl3073x_out *out)
+{
+	return FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
+}
+
+/**
+ * zl3073x_out_clock_type_set - set output clock type
+ * @out: pointer to out state
+ * @type: clock type (ZL_OUTPUT_MODE_CLOCK_TYPE_*)
+ */
+static inline void
+zl3073x_out_clock_type_set(struct zl3073x_out *out, u8 type)
+{
+	FIELD_MODIFY(ZL_OUTPUT_MODE_CLOCK_TYPE, &out->mode, type);
+}
+
 /**
  * zl3073x_out_signal_format_get - get output signal format
  * @out: pointer to out state
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index be16be20dbc7e..55e80e4f08734 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -120,6 +120,52 @@ zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq)
 	return 0;
 }
 
+/**
+ * zl3073x_ref_sync_mode_get - get sync control mode
+ * @ref: pointer to ref state
+ *
+ * Return: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)
+ */
+static inline u8
+zl3073x_ref_sync_mode_get(const struct zl3073x_ref *ref)
+{
+	return FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl);
+}
+
+/**
+ * zl3073x_ref_sync_mode_set - set sync control mode
+ * @ref: pointer to ref state
+ * @mode: sync control mode (ZL_REF_SYNC_CTRL_MODE_*)
+ */
+static inline void
+zl3073x_ref_sync_mode_set(struct zl3073x_ref *ref, u8 mode)
+{
+	FIELD_MODIFY(ZL_REF_SYNC_CTRL_MODE, &ref->sync_ctrl, mode);
+}
+
+/**
+ * zl3073x_ref_sync_pair_get - get sync pair reference index
+ * @ref: pointer to ref state
+ *
+ * Return: paired reference index
+ */
+static inline u8
+zl3073x_ref_sync_pair_get(const struct zl3073x_ref *ref)
+{
+	return FIELD_GET(ZL_REF_SYNC_CTRL_PAIR, ref->sync_ctrl);
+}
+
+/**
+ * zl3073x_ref_sync_pair_set - set sync pair reference index
+ * @ref: pointer to ref state
+ * @pair: paired reference index
+ */
+static inline void
+zl3073x_ref_sync_pair_set(struct zl3073x_ref *ref, u8 pair)
+{
+	FIELD_MODIFY(ZL_REF_SYNC_CTRL_PAIR, &ref->sync_ctrl, pair);
+}
+
 /**
  * zl3073x_ref_is_diff - check if the given input reference is differential
  * @ref: pointer to ref state
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 5ae50cb761a97..d425dc67250fe 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -213,7 +213,9 @@
 #define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
 #define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
 #define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
+#define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR	1
 #define ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75	2
+#define ZL_REF_SYNC_CTRL_PAIR			GENMASK(7, 4)
 
 #define ZL_REG_REF_ESYNC_DIV			ZL_REG(10, 0x30, 4)
 #define ZL_REF_ESYNC_DIV_1HZ			0
-- 
2.52.0


