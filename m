Return-Path: <netdev+bounces-267952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAADMBnwtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:44:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C785291D3F
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95A0B303B4C1
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D7637A4B5;
	Sun, 15 Mar 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvEB3ea1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674837B3F7
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596579; cv=none; b=GuU/lgFfuaZo8Lff8oNeVLBOBYKy6tclHIZXV66/wiUWBEksxPf1hI/mMjQIp+UKwP6HK08Eo2GzHp/OiwB+JYevUfArflvaNDJ8C2Tw2L3QygXEwUwWSVJpDQfgn2qfyhjsJqTPPKVi9sI81Tml85T70PTH+A6/wRnWWh97lYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596579; c=relaxed/simple;
	bh=rsTHFzHbK4JYsC87EPtlHt+41j1PY+iThGETFUiX/w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPZfxxm1FzrxXcFkpbEWd+oXMJJoZwVKRASYLq1Ik1q36z646XX4pLCOWGCoFYYJ1aAOa8xg0XUnaJZMTtZU8v4/wyLpKkH3hTXQdACZCoWzppI9SM1NaNDnNbb2NSxcZR9JVNaubARI3G7zYnHq0x8XlJuFjWdJshuEMaqexp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvEB3ea1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8WYTuoNIuqMPo+cmbjOayFAba9DhLh5Ks6v5Vsi6eM=;
	b=dvEB3ea1KcKRcPJTKVgbXN0sBurkaMnTnVMMgvfW+VdQPtbxpmlGrVsS7dD4ZZH+rlfo3x
	xmolB7c4EDyJPRWn2At7faNycsIugOTY29hdYSgB+G0dwdxeCz+bFKcQaTNXZa26EJE26V
	3gTv8zDdWUm05rMsZWh1nfFH9ssGQ8k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-2znejUk_O9-YruBTMr11WA-1; Sun,
 15 Mar 2026 13:42:52 -0400
X-MC-Unique: 2znejUk_O9-YruBTMr11WA-1
X-Mimecast-MFC-AGG-ID: 2znejUk_O9-YruBTMr11WA_1773596571
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A389F19560B5;
	Sun, 15 Mar 2026 17:42:51 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2C371955D87;
	Sun, 15 Mar 2026 17:42:47 +0000 (UTC)
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
Subject: [PATCH net-next v2 5/6] dpll: zl3073x: add reference priority to zl3073x_chan
Date: Sun, 15 Mar 2026 18:42:23 +0100
Message-ID: <20260315174224.399074-6-ivecera@redhat.com>
In-Reply-To: <20260315174224.399074-1-ivecera@redhat.com>
References: <20260315174224.399074-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267952-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3C785291D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Cache the ZL_REG_DPLL_REF_PRIO registers in the zl3073x_chan cfg group.
These mailbox-based registers store per-reference priority values
(4 bits each, P/N packed) used for automatic reference selection.

Add ref_prio[] array to struct zl3073x_chan and provide inline helpers
zl3073x_chan_ref_prio_get(), zl3073x_chan_ref_prio_set(), and
zl3073x_chan_ref_is_selectable() for nibble-level access and priority
queries. Extend state_fetch and state_set with DPLL mailbox operations
to read and write the priority registers.

Replace the ad-hoc zl3073x_dpll_ref_prio_get/set functions in dpll.c
with the cached state pattern, removing direct mailbox access from
the DPLL layer. This also simplifies pin registration since reading
priority from cached state cannot fail.

Remove the pin->selectable flag from struct zl3073x_dpll_pin and
derive the selectable state from the cached ref priority via
zl3073x_chan_ref_is_selectable(), eliminating a redundant cache.

Inline zl3073x_dpll_selected_ref_set() into
zl3073x_dpll_input_pin_state_on_dpll_set(), unifying all manual and
automatic mode paths to commit changes through a single
zl3073x_chan_state_set() call at the end of the function.

Move hardware limit constants from core.h to regs.h so that chan.h
can reference ZL3073X_NUM_REFS for the ref_prio array size.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed issue reported by AI
---
 drivers/dpll/zl3073x/chan.c |  68 +++++++-
 drivers/dpll/zl3073x/chan.h |  53 +++++++
 drivers/dpll/zl3073x/core.h |  11 --
 drivers/dpll/zl3073x/dpll.c | 299 +++++++++---------------------------
 drivers/dpll/zl3073x/regs.h |  12 ++
 5 files changed, 202 insertions(+), 241 deletions(-)

diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
index 71fb60a9859bf..2f48ca2391494 100644
--- a/drivers/dpll/zl3073x/chan.c
+++ b/drivers/dpll/zl3073x/chan.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/cleanup.h>
 #include <linux/dev_printk.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -33,15 +34,15 @@ int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index)
  * @zldev: pointer to zl3073x_dev structure
  * @index: DPLL channel index to fetch state for
  *
- * Reads the mode_refsel register for the given DPLL channel and stores
- * the raw value for later use.
+ * Reads the mode_refsel register and reference priority registers for
+ * the given DPLL channel and stores the raw values for later use.
  *
  * Return: 0 on success, <0 on error
  */
 int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 {
 	struct zl3073x_chan *chan = &zldev->chan[index];
-	int rc;
+	int rc, i;
 
 	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
 			     &chan->mode_refsel);
@@ -62,6 +63,22 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		zl3073x_chan_refsel_state_get(chan),
 		zl3073x_chan_refsel_ref_get(chan));
 
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read DPLL configuration from mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
+			   ZL_REG_DPLL_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Read reference priority registers */
+	for (i = 0; i < ARRAY_SIZE(chan->ref_prio); i++) {
+		rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REF_PRIO(i),
+				     &chan->ref_prio[i]);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
@@ -85,7 +102,9 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
  * @chan: desired channel state
  *
  * Skips the HW write if the configuration is unchanged, and otherwise
- * writes the mode_refsel register to hardware.
+ * writes only the changed registers to hardware. The mode_refsel register
+ * is written directly, while the reference priority registers are written
+ * via the DPLL mailbox interface.
  *
  * Return: 0 on success, <0 on HW error
  */
@@ -93,14 +112,49 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
 			   const struct zl3073x_chan *chan)
 {
 	struct zl3073x_chan *dchan = &zldev->chan[index];
-	int rc;
+	int rc, i;
 
 	/* Skip HW write if configuration hasn't changed */
 	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
 		return 0;
 
-	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
-			      chan->mode_refsel);
+	/* Direct register write for mode_refsel */
+	if (dchan->mode_refsel != chan->mode_refsel) {
+		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
+				      chan->mode_refsel);
+		if (rc)
+			return rc;
+		dchan->mode_refsel = chan->mode_refsel;
+	}
+
+	/* Mailbox write for ref_prio if changed */
+	if (!memcmp(dchan->ref_prio, chan->ref_prio, sizeof(chan->ref_prio))) {
+		dchan->cfg = chan->cfg;
+		return 0;
+	}
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read DPLL configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
+			   ZL_REG_DPLL_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Update changed ref_prio registers */
+	for (i = 0; i < ARRAY_SIZE(chan->ref_prio); i++) {
+		if (dchan->ref_prio[i] != chan->ref_prio[i]) {
+			rc = zl3073x_write_u8(zldev,
+					      ZL_REG_DPLL_REF_PRIO(i),
+					      chan->ref_prio[i]);
+			if (rc)
+				return rc;
+		}
+	}
+
+	/* Commit DPLL configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
+			   ZL_REG_DPLL_MB_MASK, BIT(index));
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
index f73a076108551..e0f02d3432086 100644
--- a/drivers/dpll/zl3073x/chan.h
+++ b/drivers/dpll/zl3073x/chan.h
@@ -14,12 +14,14 @@ struct zl3073x_dev;
 /**
  * struct zl3073x_chan - DPLL channel state
  * @mode_refsel: mode and reference selection register value
+ * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
  * @mon_status: monitor status register value
  * @refsel_status: reference selection status register value
  */
 struct zl3073x_chan {
 	struct_group(cfg,
 		u8	mode_refsel;
+		u8	ref_prio[ZL3073X_NUM_REFS / 2];
 	);
 	struct_group(stat,
 		u8	mon_status;
@@ -79,6 +81,57 @@ static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)
 	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
 }
 
+/**
+ * zl3073x_chan_ref_prio_get - get reference priority
+ * @chan: pointer to channel state
+ * @ref: input reference index
+ *
+ * Return: priority of the given reference <0, 15>
+ */
+static inline u8
+zl3073x_chan_ref_prio_get(const struct zl3073x_chan *chan, u8 ref)
+{
+	u8 val = chan->ref_prio[ref / 2];
+
+	if (!(ref & 1))
+		return FIELD_GET(ZL_DPLL_REF_PRIO_REF_P, val);
+	else
+		return FIELD_GET(ZL_DPLL_REF_PRIO_REF_N, val);
+}
+
+/**
+ * zl3073x_chan_ref_prio_set - set reference priority
+ * @chan: pointer to channel state
+ * @ref: input reference index
+ * @prio: priority to set
+ */
+static inline void
+zl3073x_chan_ref_prio_set(struct zl3073x_chan *chan, u8 ref, u8 prio)
+{
+	u8 *val = &chan->ref_prio[ref / 2];
+
+	if (!(ref & 1)) {
+		*val &= ~ZL_DPLL_REF_PRIO_REF_P;
+		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
+	} else {
+		*val &= ~ZL_DPLL_REF_PRIO_REF_N;
+		*val |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
+	}
+}
+
+/**
+ * zl3073x_chan_ref_is_selectable - check if reference is selectable
+ * @chan: pointer to channel state
+ * @ref: input reference index
+ *
+ * Return: true if the reference priority is not NONE, false otherwise
+ */
+static inline bool
+zl3073x_chan_ref_is_selectable(const struct zl3073x_chan *chan, u8 ref)
+{
+	return zl3073x_chan_ref_prio_get(chan, ref) != ZL_DPLL_REF_PRIO_NONE;
+}
+
 /**
  * zl3073x_chan_lock_state_get - get DPLL channel lock state
  * @chan: pointer to channel state
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 2cfb9dd74aa53..99440620407da 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -19,17 +19,6 @@ struct device;
 struct regmap;
 struct zl3073x_dpll;
 
-/*
- * Hardware limits for ZL3073x chip family
- */
-#define ZL3073X_MAX_CHANNELS	5
-#define ZL3073X_NUM_REFS	10
-#define ZL3073X_NUM_OUTS	10
-#define ZL3073X_NUM_SYNTHS	5
-#define ZL3073X_NUM_INPUT_PINS	ZL3073X_NUM_REFS
-#define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
-#define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
-				 ZL3073X_NUM_OUTPUT_PINS)
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 49e3f9f130848..7fb851976402b 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -34,7 +34,6 @@
  * @dir: pin direction
  * @id: pin id
  * @prio: pin priority <0, 14>
- * @selectable: pin is selectable in automatic mode
  * @esync_control: embedded sync is controllable
  * @phase_gran: phase adjustment granularity
  * @pin_state: last saved pin state
@@ -50,7 +49,6 @@ struct zl3073x_dpll_pin {
 	enum dpll_pin_direction	dir;
 	u8			id;
 	u8			prio;
-	bool			selectable;
 	bool			esync_control;
 	s32			phase_gran;
 	enum dpll_pin_state	pin_state;
@@ -284,71 +282,6 @@ zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 	return 0;
 }
 
-/**
- * zl3073x_dpll_selected_ref_set - select reference in manual mode
- * @zldpll: pointer to zl3073x_dpll
- * @ref: input reference to be selected
- *
- * Selects the given reference for the DPLL channel it should be
- * locked to.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
-{
-	struct zl3073x_dev *zldev = zldpll->dev;
-	struct zl3073x_chan chan;
-	u8 mode;
-
-	chan = *zl3073x_chan_state_get(zldev, zldpll->id);
-	mode = zl3073x_chan_mode_get(&chan);
-
-	switch (mode) {
-	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
-		/* Manual mode with ref selected */
-		if (ref == ZL3073X_DPLL_REF_NONE) {
-			switch (zldpll->lock_status) {
-			case DPLL_LOCK_STATUS_LOCKED_HO_ACQ:
-			case DPLL_LOCK_STATUS_HOLDOVER:
-				/* Switch to forced holdover */
-				mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
-				break;
-			default:
-				/* Switch to freerun */
-				mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
-				break;
-			}
-			/* Keep selected reference */
-			ref = zl3073x_chan_ref_get(&chan);
-		} else if (ref == zl3073x_chan_ref_get(&chan)) {
-			/* No register update - same mode and same ref */
-			return 0;
-		}
-		break;
-	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
-	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
-		/* Manual mode without no ref */
-		if (ref == ZL3073X_DPLL_REF_NONE)
-			/* No register update - keep current mode */
-			return 0;
-
-		/* Switch to reflock mode and update ref selection */
-		mode = ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
-		break;
-	default:
-		/* For other modes like automatic or NCO ref cannot be selected
-		 * manually
-		 */
-		return -EOPNOTSUPP;
-	}
-
-	zl3073x_chan_mode_set(&chan, mode);
-	zl3073x_chan_ref_set(&chan, ref);
-
-	return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
-}
-
 /**
  * zl3073x_dpll_connected_ref_get - get currently connected reference
  * @zldpll: pointer to zl3073x_dpll
@@ -497,98 +430,6 @@ zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_ref_state_set(zldev, ref_id, &ref);
 }
 
-/**
- * zl3073x_dpll_ref_prio_get - get priority for given input pin
- * @pin: pointer to pin
- * @prio: place to store priority
- *
- * Reads current priority for the given input pin and stores the value
- * to @prio.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
-{
-	struct zl3073x_dpll *zldpll = pin->dpll;
-	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 ref, ref_prio;
-	int rc;
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read DPLL configuration */
-	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
-			   ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
-	if (rc)
-		return rc;
-
-	/* Read reference priority - one value for P&N pins (4 bits/pin) */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2),
-			     &ref_prio);
-	if (rc)
-		return rc;
-
-	/* Select nibble according pin type */
-	if (zl3073x_dpll_is_p_pin(pin))
-		*prio = FIELD_GET(ZL_DPLL_REF_PRIO_REF_P, ref_prio);
-	else
-		*prio = FIELD_GET(ZL_DPLL_REF_PRIO_REF_N, ref_prio);
-
-	return rc;
-}
-
-/**
- * zl3073x_dpll_ref_prio_set - set priority for given input pin
- * @pin: pointer to pin
- * @prio: place to store priority
- *
- * Sets priority for the given input pin.
- *
- * Return: 0 on success, <0 on error
- */
-static int
-zl3073x_dpll_ref_prio_set(struct zl3073x_dpll_pin *pin, u8 prio)
-{
-	struct zl3073x_dpll *zldpll = pin->dpll;
-	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 ref, ref_prio;
-	int rc;
-
-	guard(mutex)(&zldev->multiop_lock);
-
-	/* Read DPLL configuration into mailbox */
-	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
-			   ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
-	if (rc)
-		return rc;
-
-	/* Read reference priority - one value shared between P&N pins */
-	ref = zl3073x_input_pin_ref_get(pin->id);
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2), &ref_prio);
-	if (rc)
-		return rc;
-
-	/* Update nibble according pin type */
-	if (zl3073x_dpll_is_p_pin(pin)) {
-		ref_prio &= ~ZL_DPLL_REF_PRIO_REF_P;
-		ref_prio |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
-	} else {
-		ref_prio &= ~ZL_DPLL_REF_PRIO_REF_N;
-		ref_prio |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
-	}
-
-	/* Update reference priority */
-	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2), ref_prio);
-	if (rc)
-		return rc;
-
-	/* Commit configuration */
-	return zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
-			     ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
-}
-
 /**
  * zl3073x_dpll_ref_state_get - get status for given input pin
  * @pin: pointer to pin
@@ -627,7 +468,8 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 	 * pin as selectable.
 	 */
 	if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    zl3073x_dev_ref_is_status_ok(zldev, ref) && pin->selectable) {
+	    zl3073x_dev_ref_is_status_ok(zldev, ref) &&
+	    zl3073x_chan_ref_is_selectable(chan, ref)) {
 		*state = DPLL_PIN_STATE_SELECTABLE;
 		return 0;
 	}
@@ -661,71 +503,81 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
-	const struct zl3073x_chan *chan;
-	u8 new_ref;
+	struct zl3073x_chan chan;
+	u8 mode, ref;
 	int rc;
 
-	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	mode = zl3073x_chan_mode_get(&chan);
 
-	switch (zl3073x_chan_mode_get(chan)) {
+	switch (mode) {
 	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
-	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
-	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
 		if (state == DPLL_PIN_STATE_CONNECTED) {
 			/* Choose the pin as new selected reference */
-			new_ref = zl3073x_input_pin_ref_get(pin->id);
+			zl3073x_chan_ref_set(&chan, ref);
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
-			/* No reference */
-			new_ref = ZL3073X_DPLL_REF_NONE;
+			/* Choose new mode based on lock status */
+			switch (zldpll->lock_status) {
+			case DPLL_LOCK_STATUS_LOCKED_HO_ACQ:
+			case DPLL_LOCK_STATUS_HOLDOVER:
+				mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
+				break;
+			default:
+				mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
+				break;
+			}
+			zl3073x_chan_mode_set(&chan, mode);
 		} else {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Invalid pin state for manual mode");
-			return -EINVAL;
+			goto invalid_state;
+		}
+		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
+	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
+		if (state == DPLL_PIN_STATE_CONNECTED) {
+			/* Choose the pin as new selected reference */
+			zl3073x_chan_ref_set(&chan, ref);
+			/* Switch to reflock mode */
+			zl3073x_chan_mode_set(&chan,
+					      ZL_DPLL_MODE_REFSEL_MODE_REFLOCK);
+		} else if (state != DPLL_PIN_STATE_DISCONNECTED) {
+			goto invalid_state;
 		}
-
-		rc = zl3073x_dpll_selected_ref_set(zldpll, new_ref);
 		break;
-
 	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
 		if (state == DPLL_PIN_STATE_SELECTABLE) {
-			if (pin->selectable)
+			if (zl3073x_chan_ref_is_selectable(&chan, ref))
 				return 0; /* Pin is already selectable */
 
 			/* Restore pin priority in HW */
-			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
-			if (rc)
-				return rc;
-
-			/* Mark pin as selectable */
-			pin->selectable = true;
+			zl3073x_chan_ref_prio_set(&chan, ref, pin->prio);
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
-			if (!pin->selectable)
+			if (!zl3073x_chan_ref_is_selectable(&chan, ref))
 				return 0; /* Pin is already disconnected */
 
 			/* Set pin priority to none in HW */
-			rc = zl3073x_dpll_ref_prio_set(pin,
-						       ZL_DPLL_REF_PRIO_NONE);
-			if (rc)
-				return rc;
-
-			/* Mark pin as non-selectable */
-			pin->selectable = false;
+			zl3073x_chan_ref_prio_set(&chan, ref,
+						  ZL_DPLL_REF_PRIO_NONE);
 		} else {
-			NL_SET_ERR_MSG(extack,
-				       "Invalid pin state for automatic mode");
-			return -EINVAL;
+			goto invalid_state;
 		}
 		break;
-
 	default:
 		/* In other modes we cannot change input reference */
 		NL_SET_ERR_MSG(extack,
 			       "Pin state cannot be changed in current mode");
-		rc = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
 
-	return rc;
+	/* Commit DPLL channel changes */
+	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
+	if (rc)
+		return rc;
+
+	return 0;
+invalid_state:
+	NL_SET_ERR_MSG_MOD(extack, "Invalid pin state for this device mode");
+	return -EINVAL;
 }
 
 static int
@@ -745,15 +597,21 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
 				const struct dpll_device *dpll, void *dpll_priv,
 				u32 prio, struct netlink_ext_ack *extack)
 {
+	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	struct zl3073x_chan chan;
+	u8 ref;
 	int rc;
 
 	if (prio > ZL_DPLL_REF_PRIO_MAX)
 		return -EINVAL;
 
 	/* If the pin is selectable then update HW registers */
-	if (pin->selectable) {
-		rc = zl3073x_dpll_ref_prio_set(pin, prio);
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	if (zl3073x_chan_ref_is_selectable(&chan, ref)) {
+		zl3073x_chan_ref_prio_set(&chan, ref, prio);
+		rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
 		if (rc)
 			return rc;
 	}
@@ -1235,6 +1093,8 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		return rc;
 	}
 
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+
 	if (mode == DPLL_MODE_MANUAL) {
 		/* We are switching from automatic to manual mode:
 		 * - if we have a valid reference selected during auto mode then
@@ -1256,25 +1116,21 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		 *   it is selectable after switch to automatic mode
 		 * - switch to automatic mode
 		 */
-		struct zl3073x_dpll_pin *pin;
-
-		pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
-		if (pin && !pin->selectable) {
-			/* Restore pin priority in HW */
-			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
-			if (rc) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "failed to restore pin priority");
-				return rc;
+		if (ZL3073X_DPLL_REF_IS_VALID(ref) &&
+		    !zl3073x_chan_ref_is_selectable(&chan, ref)) {
+			struct zl3073x_dpll_pin *pin;
+
+			pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
+			if (pin) {
+				/* Restore pin priority in HW */
+				zl3073x_chan_ref_prio_set(&chan, ref,
+							  pin->prio);
 			}
-
-			pin->selectable = true;
 		}
 
 		hw_mode = ZL_DPLL_MODE_REFSEL_MODE_AUTO;
 	}
 
-	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	zl3073x_chan_mode_set(&chan, hw_mode);
 	if (ZL3073X_DPLL_REF_IS_VALID(ref))
 		zl3073x_chan_ref_set(&chan, ref);
@@ -1426,18 +1282,16 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	pin->phase_gran = props->dpll_props.phase_gran;
 
 	if (zl3073x_dpll_is_input_pin(pin)) {
-		rc = zl3073x_dpll_ref_prio_get(pin, &pin->prio);
-		if (rc)
-			goto err_prio_get;
+		const struct zl3073x_chan *chan;
+		u8 ref;
+
+		chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+		ref = zl3073x_input_pin_ref_get(pin->id);
+		pin->prio = zl3073x_chan_ref_prio_get(chan, ref);
 
-		if (pin->prio == ZL_DPLL_REF_PRIO_NONE) {
-			/* Clamp prio to max value & mark pin non-selectable */
+		if (pin->prio == ZL_DPLL_REF_PRIO_NONE)
+			/* Clamp prio to max value */
 			pin->prio = ZL_DPLL_REF_PRIO_MAX;
-			pin->selectable = false;
-		} else {
-			/* Mark pin as selectable */
-			pin->selectable = true;
-		}
 	}
 
 	/* Create or get existing DPLL pin */
@@ -1466,7 +1320,6 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 err_register:
 	dpll_pin_put(pin->dpll_pin, &pin->tracker);
-err_prio_get:
 	pin->dpll_pin = NULL;
 err_pin_get:
 	zl3073x_pin_props_put(props);
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 19c598daa784c..5ae50cb761a97 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -6,6 +6,18 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 
+/*
+ * Hardware limits for ZL3073x chip family
+ */
+#define ZL3073X_MAX_CHANNELS	5
+#define ZL3073X_NUM_REFS	10
+#define ZL3073X_NUM_OUTS	10
+#define ZL3073X_NUM_SYNTHS	5
+#define ZL3073X_NUM_INPUT_PINS	ZL3073X_NUM_REFS
+#define ZL3073X_NUM_OUTPUT_PINS	(ZL3073X_NUM_OUTS * 2)
+#define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
+				 ZL3073X_NUM_OUTPUT_PINS)
+
 /*
  * Register address structure:
  * ===========================
-- 
2.52.0


