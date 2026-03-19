Return-Path: <netdev+bounces-269588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPE7MUI6vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492D2D078E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0243041BC3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1F3F20FF;
	Thu, 19 Mar 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQsmF872"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EC3F2108
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942536; cv=none; b=Fcif4itjtb3aJtzExKgTYufBrpBN/FD2Sk13hqe/nrFYB4efVYZ0aXHiEjaynx4QDR+FiwJgy3PTMPY+LAnXonPo9wjYlNxWz8/XvVr4jMYmJHuzmSpUFXUeZqUW+AivxFWkk5fuLHINug5kGwU5FEfpoLF/36kDIYmG5lQPDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942536; c=relaxed/simple;
	bh=8UwCfsFW6W5qZaITliwOOZSS/sb/aqUjjutyqHx9lXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlNNEeRpiK98k9CxRxVLhylB/g2be9LPgCkHTqEhbcalEPVoneQf5wupnHQP4SyGloM8qfbEpPXDQ+DQ1cc6C+a/iP2eUaKL8uHnFeHUP3RZk1lp/y5IHofXFvmERoV6u/a9Eys+YW9bf+uiENF6hrgQq5l0ukALK74tzDKgaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQsmF872; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773942530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRgfhcPZaouIM+HcER/z7TWvKLpRBcsHTt9Q5NsvwFs=;
	b=HQsmF872D5XgiVXO62fm5U6fReDvm0QZ6jRrk1D2DIBYioZQ+tCJzC/lUyIrnkGCZOh/uX
	mQx34XOINTYIKaFduK+sEUPHR75LttGIeb58HhXwYBxwHmqNg/sZ+SZl8nqC2xulr1wRXT
	f+VRq1T16nKHIlHfOBEmnTx3w56xCTo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-6gHPlkLePICuRXCXkH9NaA-1; Thu,
 19 Mar 2026 13:48:46 -0400
X-MC-Unique: 6gHPlkLePICuRXCXkH9NaA-1
X-Mimecast-MFC-AGG-ID: 6gHPlkLePICuRXCXkH9NaA_1773942525
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34EB31956094;
	Thu, 19 Mar 2026 17:48:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7662630001A1;
	Thu, 19 Mar 2026 17:48:41 +0000 (UTC)
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
Subject: [PATCH net-next 3/5] dpll: zl3073x: add ref sync and output clock type helpers
Date: Thu, 19 Mar 2026 18:48:24 +0100
Message-ID: <20260319174826.7623-4-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269588-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.904];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6492D2D078E
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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 24 ++++++++-----------
 drivers/dpll/zl3073x/out.h  | 22 ++++++++++++++++++
 drivers/dpll/zl3073x/ref.h  | 46 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  2 ++
 4 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 79ef62d69a32d..276f0a92db0b1 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -137,7 +137,7 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	switch (FIELD_GET(ZL_REF_SYNC_CTRL_MODE, ref->sync_ctrl)) {
+	switch (zl3073x_ref_sync_mode_get(ref)) {
 	case ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75:
 		esync->freq = ref->esync_n_div == ZL_REF_ESYNC_DIV_1HZ ? 1 : 0;
 		esync->pulse = 25;
@@ -173,8 +173,7 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	else
 		sync_mode = ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75;
 
-	ref.sync_ctrl &= ~ZL_REF_SYNC_CTRL_MODE;
-	ref.sync_ctrl |= FIELD_PREP(ZL_REF_SYNC_CTRL_MODE, sync_mode);
+	zl3073x_ref_sync_mode_set(&ref, sync_mode);
 
 	if (freq) {
 		/* 1 Hz is only supported frequency now */
@@ -578,7 +577,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_synth *synth;
 	const struct zl3073x_out *out;
 	u32 synth_freq, out_freq;
-	u8 clock_type, out_id;
+	u8 out_id;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
@@ -601,8 +600,7 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	esync->range = esync_freq_ranges;
 	esync->range_num = ARRAY_SIZE(esync_freq_ranges);
 
-	clock_type = FIELD_GET(ZL_OUTPUT_MODE_CLOCK_TYPE, out->mode);
-	if (clock_type != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
+	if (zl3073x_out_clock_type_get(out) != ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC) {
 		/* No need to read esync data if it is not enabled */
 		esync->freq = 0;
 		esync->pulse = 0;
@@ -635,8 +633,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	struct zl3073x_out out;
-	u8 clock_type, out_id;
 	u32 synth_freq;
+	u8 out_id;
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -648,15 +646,13 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
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
index 06d8d4d97ea26..09fab97a71d7e 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -106,6 +106,52 @@ zl3073x_ref_freq_set(struct zl3073x_ref *ref, u32 freq)
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


