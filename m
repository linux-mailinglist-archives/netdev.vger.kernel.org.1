Return-Path: <netdev+bounces-266748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFdIEx28sWmxEwAAu9opvQ
	(envelope-from <netdev+bounces-266748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F181268FE1
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264C3307AA33
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27912D1F64;
	Wed, 11 Mar 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JghaTx5H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5622156C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255673; cv=none; b=WXdb8zr9K+mg3MJ5ws6bhClH5a7E8sZ5RoZ9or4GqnWgBWn/FhGrMjqtirBmuFrXRMSNc3yPOTBof4lFCKI6PEmASKAYZosWvvw7hzN7CK6tLIcLaqoe5oDvjHrAIddeQBfakkfbLxIOqxFY+1daSZB75+GIF+HhTZsraKJ4VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255673; c=relaxed/simple;
	bh=MfOJlid+nmwZdH87mYvqURwpvogZtyCih7DRGuqRcAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0F7yplShD+4Vnr1UGOi8+97RJPuVV+eSca+9UTIOgBOy+sYtJMc7hb9cueY/akfs43PZSrIU9J1nbZI9RutMzjMVz8sDcdboqWwga8y3qC9XyPm5e/q/AsD4uDM9jfs41NSaQ5Y4W6ZbcE+Z0CN3Zj/hMHsJZ/ujMl8M883Gyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JghaTx5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773255670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKQXm8kWOE2bAwatcjo/YgiVfdaRMcckipabGM05qTc=;
	b=JghaTx5HB/qHyBMLUC3gE5hNTMq+BWles3uqnisH4UWLCxQQ4GOwqrD0k9z+5JmVVwvx/W
	BgPCAcPgYHMMLxzhSH2k65S+0tfTWsaOv/ncPryeqcD41Y9oDCsj+XI6ioksaE8jisL2St
	ISmvGxOg3HU3xOp8HlMf6s9q+ZEdO9c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-N49hiSOXO06Vor1VvEP5CQ-1; Wed,
 11 Mar 2026 15:01:06 -0400
X-MC-Unique: N49hiSOXO06Vor1VvEP5CQ-1
X-Mimecast-MFC-AGG-ID: N49hiSOXO06Vor1VvEP5CQ_1773255664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43B381956050;
	Wed, 11 Mar 2026 19:01:04 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D00C93002D0F;
	Wed, 11 Mar 2026 19:01:00 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] dpll: zl3073x: use struct_group to partition states
Date: Wed, 11 Mar 2026 20:00:50 +0100
Message-ID: <20260311190055.139006-2-ivecera@redhat.com>
In-Reply-To: <20260311190055.139006-1-ivecera@redhat.com>
References: <20260311190055.139006-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F181268FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Organize the zl3073x_out, zl3073x_ref, and zl3073x_synth structures
using struct_group() to partition fields into semantic groups:

  * cfg:  mutable configuration written to HW via state_set
  * inv:  invariant fields set once during state_fetch
  * stat: read-only status

This enables group-level operations in place of field-by-field copies:

  * state_set validates invariants haven't changed (WARN_ON + -EINVAL)
  * state_set short-circuits when cfg is unchanged
  * state_set copy entire groups in a single assignment instead of
    enumerating each field

Add kernel doc for zl3073x_out_state_set and zl3073x_ref_state_set
documenting the new invariant validation and short-circuit semantics.

Remove forward declaration of zl3073x_synth_state_set().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/out.c   | 27 +++++++++++++++++++------
 drivers/dpll/zl3073x/out.h   | 21 ++++++++++++--------
 drivers/dpll/zl3073x/ref.c   | 38 ++++++++++++++++++++++--------------
 drivers/dpll/zl3073x/ref.h   | 31 +++++++++++++++++------------
 drivers/dpll/zl3073x/synth.h | 16 +++++++--------
 5 files changed, 84 insertions(+), 49 deletions(-)

diff --git a/drivers/dpll/zl3073x/out.c b/drivers/dpll/zl3073x/out.c
index 86829a0c1c022..eb5628aebcee8 100644
--- a/drivers/dpll/zl3073x/out.c
+++ b/drivers/dpll/zl3073x/out.c
@@ -106,12 +106,32 @@ const struct zl3073x_out *zl3073x_out_state_get(struct zl3073x_dev *zldev,
 	return &zldev->out[index];
 }
 
+/**
+ * zl3073x_out_state_set - commit output state changes to hardware
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: output index to set state for
+ * @out: desired output state
+ *
+ * Validates that invariant fields have not been modified, skips the HW
+ * write if the mutable configuration is unchanged, and otherwise writes
+ * only the changed cfg fields to hardware via the mailbox interface.
+ *
+ * Return: 0 on success, -EINVAL if invariants changed, <0 on HW error
+ */
 int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 			  const struct zl3073x_out *out)
 {
 	struct zl3073x_out *dout = &zldev->out[index];
 	int rc;
 
+	/* Reject attempts to change invariant fields (set at fetch only) */
+	if (WARN_ON(memcmp(&dout->inv, &out->inv, sizeof(out->inv))))
+		return -EINVAL;
+
+	/* Skip HW write if configuration hasn't changed */
+	if (!memcmp(&dout->cfg, &out->cfg, sizeof(out->cfg)))
+		return 0;
+
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read output configuration into mailbox */
@@ -146,12 +166,7 @@ int zl3073x_out_state_set(struct zl3073x_dev *zldev, u8 index,
 		return rc;
 
 	/* After successful commit store new state */
-	dout->div = out->div;
-	dout->width = out->width;
-	dout->esync_n_period = out->esync_n_period;
-	dout->esync_n_width = out->esync_n_width;
-	dout->mode = out->mode;
-	dout->phase_comp = out->phase_comp;
+	dout->cfg = out->cfg;
 
 	return 0;
 }
diff --git a/drivers/dpll/zl3073x/out.h b/drivers/dpll/zl3073x/out.h
index 318f9bb8da3a0..edf40432bba5f 100644
--- a/drivers/dpll/zl3073x/out.h
+++ b/drivers/dpll/zl3073x/out.h
@@ -4,6 +4,7 @@
 #define _ZL3073X_OUT_H
 
 #include <linux/bitfield.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include "regs.h"
@@ -17,17 +18,21 @@ struct zl3073x_dev;
  * @esync_n_period: embedded sync or n-pin period (for n-div formats)
  * @esync_n_width: embedded sync or n-pin pulse width
  * @phase_comp: phase compensation
- * @ctrl: output control
  * @mode: output mode
+ * @ctrl: output control
  */
 struct zl3073x_out {
-	u32	div;
-	u32	width;
-	u32	esync_n_period;
-	u32	esync_n_width;
-	s32	phase_comp;
-	u8	ctrl;
-	u8	mode;
+	struct_group(cfg, /* Config */
+		u32	div;
+		u32	width;
+		u32	esync_n_period;
+		u32	esync_n_width;
+		s32	phase_comp;
+		u8	mode;
+	);
+	struct_group(inv, /* Invariants */
+		u8	ctrl;
+	);
 };
 
 int zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index);
diff --git a/drivers/dpll/zl3073x/ref.c b/drivers/dpll/zl3073x/ref.c
index 6b65e61039999..8b4c4807bcc44 100644
--- a/drivers/dpll/zl3073x/ref.c
+++ b/drivers/dpll/zl3073x/ref.c
@@ -73,14 +73,8 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		struct zl3073x_ref *p_ref = ref - 1; /* P-pin counterpart*/
 
 		/* Copy the shared items from the P-pin */
-		ref->config = p_ref->config;
-		ref->esync_n_div = p_ref->esync_n_div;
-		ref->freq_base = p_ref->freq_base;
-		ref->freq_mult = p_ref->freq_mult;
-		ref->freq_ratio_m = p_ref->freq_ratio_m;
-		ref->freq_ratio_n = p_ref->freq_ratio_n;
-		ref->phase_comp = p_ref->phase_comp;
-		ref->sync_ctrl = p_ref->sync_ctrl;
+		ref->cfg = p_ref->cfg;
+		ref->inv = p_ref->inv;
 
 		return 0; /* Finish - no non-shared items for now */
 	}
@@ -154,12 +148,32 @@ zl3073x_ref_state_get(struct zl3073x_dev *zldev, u8 index)
 	return &zldev->ref[index];
 }
 
+/**
+ * zl3073x_ref_state_set - commit input reference state changes to hardware
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: input reference index to set state for
+ * @ref: desired reference state
+ *
+ * Validates that invariant fields have not been modified, skips the HW
+ * write if the mutable configuration is unchanged, and otherwise writes
+ * only the changed cfg fields to hardware via the mailbox interface.
+ *
+ * Return: 0 on success, -EINVAL if invariants changed, <0 on HW error
+ */
 int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
 			  const struct zl3073x_ref *ref)
 {
 	struct zl3073x_ref *dref = &zldev->ref[index];
 	int rc;
 
+	/* Reject attempts to change invariant fields (set at init only) */
+	if (WARN_ON(memcmp(&dref->inv, &ref->inv, sizeof(ref->inv))))
+		return -EINVAL;
+
+	/* Skip HW write if configuration hasn't changed */
+	if (!memcmp(&dref->cfg, &ref->cfg, sizeof(ref->cfg)))
+		return 0;
+
 	guard(mutex)(&zldev->multiop_lock);
 
 	/* Read reference configuration into mailbox */
@@ -207,13 +221,7 @@ int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
 		return rc;
 
 	/* After successful commit store new state */
-	dref->freq_base = ref->freq_base;
-	dref->freq_mult = ref->freq_mult;
-	dref->freq_ratio_m = ref->freq_ratio_m;
-	dref->freq_ratio_n = ref->freq_ratio_n;
-	dref->esync_n_div = ref->esync_n_div;
-	dref->sync_ctrl = ref->sync_ctrl;
-	dref->phase_comp = ref->phase_comp;
+	dref->cfg = ref->cfg;
 
 	return 0;
 }
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index 0d8618f5ce8df..ab3a816c29108 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/math64.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include "regs.h"
@@ -13,28 +14,34 @@ struct zl3073x_dev;
 
 /**
  * struct zl3073x_ref - input reference state
- * @ffo: current fractional frequency offset
  * @phase_comp: phase compensation
  * @esync_n_div: divisor for embedded sync or n-divided signal formats
  * @freq_base: frequency base
  * @freq_mult: frequnecy multiplier
  * @freq_ratio_m: FEC mode multiplier
  * @freq_ratio_n: FEC mode divisor
- * @config: reference config
  * @sync_ctrl: reference sync control
+ * @config: reference config
+ * @ffo: current fractional frequency offset
  * @mon_status: reference monitor status
  */
 struct zl3073x_ref {
-	s64	ffo;
-	u64	phase_comp;
-	u32	esync_n_div;
-	u16	freq_base;
-	u16	freq_mult;
-	u16	freq_ratio_m;
-	u16	freq_ratio_n;
-	u8	config;
-	u8	sync_ctrl;
-	u8	mon_status;
+	struct_group(cfg, /* Configuration */
+		u64	phase_comp;
+		u32	esync_n_div;
+		u16	freq_base;
+		u16	freq_mult;
+		u16	freq_ratio_m;
+		u16	freq_ratio_n;
+		u8	sync_ctrl;
+	);
+	struct_group(inv, /* Invariants */
+		u8	config;
+	);
+	struct_group(stat, /* Status */
+		s64	ffo;
+		u8	mon_status;
+	);
 };
 
 int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index);
diff --git a/drivers/dpll/zl3073x/synth.h b/drivers/dpll/zl3073x/synth.h
index 6c55eb8a888c2..89e13ea2e6d94 100644
--- a/drivers/dpll/zl3073x/synth.h
+++ b/drivers/dpll/zl3073x/synth.h
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/math64.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include "regs.h"
@@ -20,11 +21,13 @@ struct zl3073x_dev;
  * @ctrl: synth control
  */
 struct zl3073x_synth {
-	u32	freq_mult;
-	u16	freq_base;
-	u16	freq_m;
-	u16	freq_n;
-	u8	ctrl;
+	struct_group(inv, /* Invariants */
+		u32	freq_mult;
+		u16	freq_base;
+		u16	freq_m;
+		u16	freq_n;
+		u8	ctrl;
+	);
 };
 
 int zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 synth_id);
@@ -32,9 +35,6 @@ int zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 synth_id);
 const struct zl3073x_synth *zl3073x_synth_state_get(struct zl3073x_dev *zldev,
 						    u8 synth_id);
 
-int zl3073x_synth_state_set(struct zl3073x_dev *zldev, u8 synth_id,
-			    const struct zl3073x_synth *synth);
-
 /**
  * zl3073x_synth_dpll_get - get DPLL ID the synth is driven by
  * @synth: pointer to synth state
-- 
2.52.0


