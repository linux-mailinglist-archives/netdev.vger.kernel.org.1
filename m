Return-Path: <netdev+bounces-257235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLC2HdS6hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:44:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F755F4B6C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77582300A326
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3A425CC5;
	Thu,  5 Feb 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzRDwT3Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D9423A9C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306245; cv=none; b=Tnra/tF7pRgDz8R+PiW15OqiAKUA3G3GXbmd/JJq1Z2eUJy64ZQ7x6nkLD92AyL7W0YjP034+mAgzPhOLn+ak4LiopM+gIV91ynYF4kAcCZ4lcUb1+SPdEIjgISWmZOpOFU2nKnZcfalNanO1kdbdIJuARQmyprU3MOv4Y3HJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306245; c=relaxed/simple;
	bh=+fWCDknhNcyAfl0L6h7iW0/iLxaqFgE0u/8YubZwQGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR3Bi8Wal6GsnffQvMy9Cd6XgE8+p4v52MlICwfnj1ihUBKMDx57BQ8aix8Lf6beJplMPzFrbEktAuqpcOWTbZ5XSsFpeCG88Q8IDg5AdXxT67uwbuCD1DanfTx4X0uuPY0mpF5RZz+uD+GrC74sSOnh/TNuOg47Rm+L2jldORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzRDwT3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770306244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx/aDrZcZXnVX7vlg1sIDkqJnzGEYa0QLLZg8IYNH7c=;
	b=hzRDwT3YSctXIYoucChc2PKcc3rIXFKf9wvur3ubjYmZGV2RwxIE2ROr4ECyL8iZnWG8Cg
	rmSv6VOdpyXOO0fvEx1NGyUBnUlurC+Rwk+PuAXUWSsUoL/Z+mjWYXfYY84xqrBjVt874r
	+GcbAeo1vfxbhFOrqZWJ6JK1exCEWyg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-6JNKmIVrPz2_Ll8Qm_NGDQ-1; Thu,
 05 Feb 2026 10:43:59 -0500
X-MC-Unique: 6JNKmIVrPz2_Ll8Qm_NGDQ-1
X-Mimecast-MFC-AGG-ID: 6JNKmIVrPz2_Ll8Qm_NGDQ_1770306238
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF0A61955DC2;
	Thu,  5 Feb 2026 15:43:57 +0000 (UTC)
Received: from cnb-01.lab.eng.brq2.redhat.com (cnb-01.lab.eng.brq2.redhat.com [10.37.129.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E647B18003F6;
	Thu,  5 Feb 2026 15:43:55 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dpll: zl3073x: Add output pin frequency helper
Date: Thu,  5 Feb 2026 16:43:49 +0100
Message-ID: <20260205154350.3180465-2-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257235-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F755F4B6C
X-Rspamd-Action: no action

Introduce zl3073x_dev_output_pin_freq_get() helper function to compute
the output pin frequency based on synthesizer frequency, output divisor,
and signal format. For N-div signal formats, the N-pin frequency is
additionally divided by esync_n_period.

Add zl3073x_out_is_ndiv() helper to check if an output is configured
in N-div mode (2_NDIV or 2_NDIV_INV signal formats).

Refactor zl3073x_dpll_output_pin_frequency_get() callback to use the
new helper, reducing code duplication and enabling reuse of the
frequency calculation logic in other contexts.

This is a preparatory change for adding current frequency to the
supported frequencies list in pin properties.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.h | 30 ++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.c | 39 +------------------------------------
 drivers/dpll/zl3073x/out.h  | 17 ++++++++++++++++
 3 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 09bca2d0926d..dddfcacea5c0 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -301,6 +301,36 @@ u8 zl3073x_dev_out_dpll_get(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_synth_dpll_get(synth);
 }
 
+/**
+ * zl3073x_dev_output_pin_freq_get - get output pin frequency
+ * @zldev: pointer to zl3073x device
+ * @id: output pin id
+ *
+ * Computes the output pin frequency based on the synth frequency, output
+ * divisor, and signal format. For N-div formats, N-pin frequency is
+ * additionally divided by esync_n_period.
+ *
+ * Return: frequency of the given output pin in Hz
+ */
+static inline u32
+zl3073x_dev_output_pin_freq_get(struct zl3073x_dev *zldev, u8 id)
+{
+	const struct zl3073x_synth *synth;
+	const struct zl3073x_out *out;
+	u8 out_id;
+	u32 freq;
+
+	out_id = zl3073x_output_pin_out_get(id);
+	out = zl3073x_out_state_get(zldev, out_id);
+	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
+	freq = zl3073x_synth_freq_get(synth) / out->div;
+
+	if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
+		freq /= out->esync_n_period;
+
+	return freq;
+}
+
 /**
  * zl3073x_dev_out_is_diff - check if the given output is differential
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 7d8ed948b970..7301b4b1edde 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -914,46 +914,9 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				      struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
-	struct zl3073x_dev *zldev = zldpll->dev;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	const struct zl3073x_synth *synth;
-	const struct zl3073x_out *out;
-	u32 synth_freq;
-	u8 out_id;
 
-	out_id = zl3073x_output_pin_out_get(pin->id);
-	out = zl3073x_out_state_get(zldev, out_id);
-
-	/* Get attached synth frequency */
-	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(out));
-	synth_freq = zl3073x_synth_freq_get(synth);
-
-	switch (zl3073x_out_signal_format_get(out)) {
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
-	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
-		/* In case of divided format we have to distiguish between
-		 * given output pin type.
-		 *
-		 * For P-pin the resulting frequency is computed as simple
-		 * division of synth frequency and output divisor.
-		 *
-		 * For N-pin we have to divide additionally by divisor stored
-		 * in esync_n_period output mailbox register that is used as
-		 * N-pin divisor for these modes.
-		 */
-		*frequency = synth_freq / out->div;
-
-		if (!zl3073x_dpll_is_p_pin(pin))
-			*frequency = (u32)*frequency / out->esync_n_period;
-
-		break;
-	default:
-		/* In other modes the resulting frequency is computed as
-		 * division of synth frequency and output divisor.
-		 */
-		*frequency = synth_freq / out->div;
-		break;
-	}
+	*frequency = zl3073x_dev_output_pin_freq_get(zldpll->dev, pin->id);
 
 	return 0;
 }
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index e8ea7a0e0f07..318f9bb8da3a 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -79,6 +79,23 @@ static inline bool zl3073x_out_is_enabled(const struct zl3073x_out *out)
 	return !!FIELD_GET(ZL_OUTPUT_CTRL_EN, out->ctrl);
 }
 
+/**
+ * zl3073x_out_is_ndiv - check if the given output is in N-div mode
+ * @out: pointer to out state
+ *
+ * Return: true if output is in N-div mode, false otherwise
+ */
+static inline bool zl3073x_out_is_ndiv(const struct zl3073x_out *out)
+{
+	switch (zl3073x_out_signal_format_get(out)) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * zl3073x_out_synth_get - get synth connected to given output
  * @out: pointer to out state
-- 
2.52.0


