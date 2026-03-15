Return-Path: <netdev+bounces-267949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEhBI6fvtmnnKgEAu9opvQ
	(envelope-from <netdev+bounces-267949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:43:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2F5291D03
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87FDD301F381
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F868379EF5;
	Sun, 15 Mar 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPPyOlUl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998003793C8
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773596570; cv=none; b=l0psi6EReSlFSm5Iq7siajDvpqxb3CgupK3I528Vuf82FBwiY4gGRMAqAQUvAfXcLchn/MmTEc6//OpGl7KlPwnP/bJLlD1JSUwu6a4XWfji4dEKoZiRcdDqKOxvL0BIV2v9A47CUaj7Qi4miLLCpLAFMyXUu7LqxEEtZfOHjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773596570; c=relaxed/simple;
	bh=oKX+3eriG2SioHUvTBqPQDyaoFl17Cg9VnGmr+nvcq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJa5KaNHFZW3VqJVF4LDIPPSB/BaC+ef3L2thtRhzJhv9Is8ZtHWH2qJH6bijA0n3YSG6DiHtrwZQ6dLIMXU0qDWZYdS06kiohLatdaHHm9kFDI7ZQlqvBHAJvWcxfOkUeGhHR9VB5v/XHwKyCmNxYMrH4uxYxSFsAoMbkB5ssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPPyOlUl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773596567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+yBoH3D6bqIyXFoBiHGN1fywwd96SsUINohBYXJbGo=;
	b=VPPyOlUlI5CDXoLc+kMCffDsnn4q3ENafc4f95v3jSEfaCRBmQuNbGLOkMWYM91zLm4NlL
	TK8T5TZm54sYyRwZ37IJGiDnA7rqmhBjjyVqAZMNo4S27JtVI6v5DAV4kPWG8eXlh4WAu7
	kB8Ap3K1HkkjG4bZw9oQLmkRLafVuE0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-tCHdKIyxPP-MdJevPcmDSg-1; Sun,
 15 Mar 2026 13:42:44 -0400
X-MC-Unique: tCHdKIyxPP-MdJevPcmDSg-1
X-Mimecast-MFC-AGG-ID: tCHdKIyxPP-MdJevPcmDSg_1773596563
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1072A1800344;
	Sun, 15 Mar 2026 17:42:43 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23B6A1955D87;
	Sun, 15 Mar 2026 17:42:38 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/6] dpll: zl3073x: introduce zl3073x_chan for DPLL channel state
Date: Sun, 15 Mar 2026 18:42:21 +0100
Message-ID: <20260315174224.399074-4-ivecera@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-267949-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3D2F5291D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract DPLL channel state management into a dedicated zl3073x_chan
module, following the pattern already established by zl3073x_ref,
zl3073x_out and zl3073x_synth.

The new struct zl3073x_chan caches the raw mode_refsel register value
in a cfg group with inline getters and setters to extract and update
the bitfields. Three standard state management functions are provided:

 - zl3073x_chan_state_fetch: read the mode_refsel register from HW
 - zl3073x_chan_state_get: return cached channel state
 - zl3073x_chan_state_set: write changed state to HW, skip if unchanged

The channel state array chan[ZL3073X_MAX_CHANNELS] is added to struct
zl3073x_dev. Channel state is fetched as part of
zl3073x_dev_state_fetch, using the chip-specific channel count.

The refsel_mode and forced_ref fields are removed from struct
zl3073x_dpll and all direct register accesses in dpll.c are replaced
with the new chan state operations.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Makefile |   4 +-
 drivers/dpll/zl3073x/chan.c   |  79 ++++++++++++++++++++++++++
 drivers/dpll/zl3073x/chan.h   |  74 ++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.c   |  10 ++++
 drivers/dpll/zl3073x/core.h   |   3 +
 drivers/dpll/zl3073x/dpll.c   | 104 ++++++++++++++++------------------
 drivers/dpll/zl3073x/dpll.h   |   4 --
 7 files changed, 217 insertions(+), 61 deletions(-)
 create mode 100644 drivers/dpll/zl3073x/chan.c
 create mode 100644 drivers/dpll/zl3073x/chan.h

diff --git a/drivers/dpll/zl3073x/Makefile b/drivers/dpll/zl3073x/Makefile
index bd324c7fe7101..906ec3fbcc202 100644
--- a/drivers/dpll/zl3073x/Makefile
+++ b/drivers/dpll/zl3073x/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ZL3073X)		+= zl3073x.o
-zl3073x-objs			:= core.o devlink.o dpll.o flash.o fw.o	\
-				   out.o prop.o ref.o synth.o
+zl3073x-objs			:= chan.o core.o devlink.o dpll.o	\
+				   flash.o fw.o out.o prop.o ref.o synth.o
 
 obj-$(CONFIG_ZL3073X_I2C)	+= zl3073x_i2c.o
 zl3073x_i2c-objs		:= i2c.o
diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
new file mode 100644
index 0000000000000..8019b8ce73514
--- /dev/null
+++ b/drivers/dpll/zl3073x/chan.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/dev_printk.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "chan.h"
+#include "core.h"
+
+/**
+ * zl3073x_chan_state_fetch - fetch DPLL channel state from hardware
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: DPLL channel index to fetch state for
+ *
+ * Reads the mode_refsel register for the given DPLL channel and stores
+ * the raw value for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_chan *chan = &zldev->chan[index];
+	int rc;
+
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
+			     &chan->mode_refsel);
+	if (rc)
+		return rc;
+
+	dev_dbg(zldev->dev, "DPLL%u mode: %u, ref: %u\n", index,
+		zl3073x_chan_mode_get(chan), zl3073x_chan_ref_get(chan));
+
+	return 0;
+}
+
+/**
+ * zl3073x_chan_state_get - get current DPLL channel state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: DPLL channel index to get state for
+ *
+ * Return: pointer to given DPLL channel state
+ */
+const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
+						  u8 index)
+{
+	return &zldev->chan[index];
+}
+
+/**
+ * zl3073x_chan_state_set - commit DPLL channel state changes to hardware
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: DPLL channel index to set state for
+ * @chan: desired channel state
+ *
+ * Skips the HW write if the configuration is unchanged, and otherwise
+ * writes the mode_refsel register to hardware.
+ *
+ * Return: 0 on success, <0 on HW error
+ */
+int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
+			   const struct zl3073x_chan *chan)
+{
+	struct zl3073x_chan *dchan = &zldev->chan[index];
+	int rc;
+
+	/* Skip HW write if configuration hasn't changed */
+	if (!memcmp(&dchan->cfg, &chan->cfg, sizeof(chan->cfg)))
+		return 0;
+
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(index),
+			      chan->mode_refsel);
+	if (rc)
+		return rc;
+
+	/* After successful write store new state */
+	dchan->cfg = chan->cfg;
+
+	return 0;
+}
diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
new file mode 100644
index 0000000000000..3e6ffaef0c743
--- /dev/null
+++ b/drivers/dpll/zl3073x/chan.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ZL3073X_CHAN_H
+#define _ZL3073X_CHAN_H
+
+#include <linux/bitfield.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include "regs.h"
+
+struct zl3073x_dev;
+
+/**
+ * struct zl3073x_chan - DPLL channel state
+ * @mode_refsel: mode and reference selection register value
+ */
+struct zl3073x_chan {
+	struct_group(cfg,
+		u8	mode_refsel;
+	);
+};
+
+int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index);
+const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
+						 u8 index);
+int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
+			   const struct zl3073x_chan *chan);
+
+/**
+ * zl3073x_chan_mode_get - get DPLL channel operating mode
+ * @chan: pointer to channel state
+ *
+ * Return: reference selection mode of the given DPLL channel
+ */
+static inline u8 zl3073x_chan_mode_get(const struct zl3073x_chan *chan)
+{
+	return FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE, chan->mode_refsel);
+}
+
+/**
+ * zl3073x_chan_ref_get - get manually selected reference
+ * @chan: pointer to channel state
+ *
+ * Return: reference selected in forced reference lock mode
+ */
+static inline u8 zl3073x_chan_ref_get(const struct zl3073x_chan *chan)
+{
+	return FIELD_GET(ZL_DPLL_MODE_REFSEL_REF, chan->mode_refsel);
+}
+
+/**
+ * zl3073x_chan_mode_set - set DPLL channel operating mode
+ * @chan: pointer to channel state
+ * @mode: mode to set
+ */
+static inline void zl3073x_chan_mode_set(struct zl3073x_chan *chan, u8 mode)
+{
+	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_MODE;
+	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode);
+}
+
+/**
+ * zl3073x_chan_ref_set - set manually selected reference
+ * @chan: pointer to channel state
+ * @ref: reference to set
+ */
+static inline void zl3073x_chan_ref_set(struct zl3073x_chan *chan, u8 ref)
+{
+	chan->mode_refsel &= ~ZL_DPLL_MODE_REFSEL_REF;
+	chan->mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+}
+
+#endif /* _ZL3073X_CHAN_H */
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 07626082aae3b..b03e59fa0834b 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -539,6 +539,16 @@ zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
 		}
 	}
 
+	for (i = 0; i < zldev->info->num_channels; i++) {
+		rc = zl3073x_chan_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch channel state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
 	return rc;
 }
 
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index b6f22ee1c0bd1..2cfb9dd74aa53 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -9,6 +9,7 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#include "chan.h"
 #include "out.h"
 #include "ref.h"
 #include "regs.h"
@@ -61,6 +62,7 @@ struct zl3073x_chip_info {
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
+ * @chan: array of DPLL channels' state
  * @dplls: list of DPLLs
  * @kworker: thread for periodic work
  * @work: periodic work
@@ -77,6 +79,7 @@ struct zl3073x_dev {
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
 	struct zl3073x_out	out[ZL3073X_NUM_OUTS];
 	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
+	struct zl3073x_chan	chan[ZL3073X_MAX_CHANNELS];
 
 	/* DPLL channels */
 	struct list_head	dplls;
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index c201c974a7f9a..f56f073e57df4 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -259,10 +259,13 @@ static int
 zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
 	u8 state, value;
 	int rc;
 
-	switch (zldpll->refsel_mode) {
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
 		/* For automatic mode read refsel_status register */
 		rc = zl3073x_read_u8(zldev,
@@ -282,7 +285,7 @@ zl3073x_dpll_selected_ref_get(struct zl3073x_dpll *zldpll, u8 *ref)
 		break;
 	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
 		/* For manual mode return stored value */
-		*ref = zldpll->forced_ref;
+		*ref = zl3073x_chan_ref_get(chan);
 		break;
 	default:
 		/* For other modes like NCO, freerun... there is no input ref */
@@ -307,10 +310,11 @@ static int
 zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 mode, mode_refsel;
-	int rc;
+	struct zl3073x_chan chan;
+	u8 mode;
 
-	mode = zldpll->refsel_mode;
+	chan = *zl3073x_chan_state_get(zldev, zldpll->id);
+	mode = zl3073x_chan_mode_get(&chan);
 
 	switch (mode) {
 	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
@@ -328,8 +332,8 @@ zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
 				break;
 			}
 			/* Keep selected reference */
-			ref = zldpll->forced_ref;
-		} else if (ref == zldpll->forced_ref) {
+			ref = zl3073x_chan_ref_get(&chan);
+		} else if (ref == zl3073x_chan_ref_get(&chan)) {
 			/* No register update - same mode and same ref */
 			return 0;
 		}
@@ -351,21 +355,10 @@ zl3073x_dpll_selected_ref_set(struct zl3073x_dpll *zldpll, u8 ref)
 		return -EOPNOTSUPP;
 	}
 
-	/* Build mode_refsel value */
-	mode_refsel = FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, mode) |
-		      FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
-
-	/* Update dpll_mode_refsel register */
-	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
-			      mode_refsel);
-	if (rc)
-		return rc;
-
-	/* Store new mode and forced reference */
-	zldpll->refsel_mode = mode;
-	zldpll->forced_ref = ref;
+	zl3073x_chan_mode_set(&chan, mode);
+	zl3073x_chan_ref_set(&chan, ref);
 
-	return rc;
+	return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
 }
 
 /**
@@ -624,9 +617,11 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
 	u8 ref, ref_conn;
 	int rc;
 
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
 	ref = zl3073x_input_pin_ref_get(pin->id);
 
 	/* Get currently connected reference */
@@ -643,7 +638,7 @@ zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
 	 * selectable and its monitor does not report any error then report
 	 * pin as selectable.
 	 */
-	if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
+	if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
 	    zl3073x_dev_ref_is_status_ok(zldev, ref) && pin->selectable) {
 		*state = DPLL_PIN_STATE_SELECTABLE;
 		return 0;
@@ -678,10 +673,13 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
+	const struct zl3073x_chan *chan;
 	u8 new_ref;
 	int rc;
 
-	switch (zldpll->refsel_mode) {
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+
+	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
 	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
@@ -1092,10 +1090,13 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
 	u8 mon_status, state;
 	int rc;
 
-	switch (zldpll->refsel_mode) {
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
 	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
 		/* In FREERUN and NCO modes the DPLL is always unlocked */
@@ -1140,13 +1141,16 @@ zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
 				 struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
+	const struct zl3073x_chan *chan;
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	/* We support switching between automatic and manual mode, except in
 	 * a case where the DPLL channel is configured to run in NCO mode.
 	 * In this case, report only the manual mode to which the NCO is mapped
 	 * as the only supported one.
 	 */
-	if (zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_NCO)
+	if (zl3073x_chan_mode_get(chan) != ZL_DPLL_MODE_REFSEL_MODE_NCO)
 		__set_bit(DPLL_MODE_AUTOMATIC, modes);
 
 	__set_bit(DPLL_MODE_MANUAL, modes);
@@ -1159,8 +1163,11 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 		      enum dpll_mode *mode, struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
+	const struct zl3073x_chan *chan;
 
-	switch (zldpll->refsel_mode) {
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+
+	switch (zl3073x_chan_mode_get(chan)) {
 	case ZL_DPLL_MODE_REFSEL_MODE_FREERUN:
 	case ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER:
 	case ZL_DPLL_MODE_REFSEL_MODE_NCO:
@@ -1239,7 +1246,8 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		      enum dpll_mode mode, struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
-	u8 hw_mode, mode_refsel, ref;
+	struct zl3073x_chan chan;
+	u8 hw_mode, ref;
 	int rc;
 
 	rc = zl3073x_dpll_selected_ref_get(zldpll, &ref);
@@ -1287,26 +1295,18 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 		hw_mode = ZL_DPLL_MODE_REFSEL_MODE_AUTO;
 	}
 
-	/* Build mode_refsel value */
-	mode_refsel = FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, hw_mode);
-
+	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	zl3073x_chan_mode_set(&chan, hw_mode);
 	if (ZL3073X_DPLL_REF_IS_VALID(ref))
-		mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+		zl3073x_chan_ref_set(&chan, ref);
 
-	/* Update dpll_mode_refsel register */
-	rc = zl3073x_write_u8(zldpll->dev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
-			      mode_refsel);
+	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to set reference selection mode");
 		return rc;
 	}
 
-	zldpll->refsel_mode = hw_mode;
-
-	if (ZL3073X_DPLL_REF_IS_VALID(ref))
-		zldpll->forced_ref = ref;
-
 	return 0;
 }
 
@@ -1559,15 +1559,18 @@ zl3073x_dpll_pin_is_registrable(struct zl3073x_dpll *zldpll,
 				enum dpll_pin_direction dir, u8 index)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
 	bool is_diff, is_enabled;
 	const char *name;
 
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
 		u8 ref_id = zl3073x_input_pin_ref_get(index);
 		const struct zl3073x_ref *ref;
 
 		/* Skip the pin if the DPLL is running in NCO mode */
-		if (zldpll->refsel_mode == ZL_DPLL_MODE_REFSEL_MODE_NCO)
+		if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_NCO)
 			return false;
 
 		name = "REF";
@@ -1675,21 +1678,8 @@ static int
 zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 {
 	struct zl3073x_dev *zldev = zldpll->dev;
-	u8 dpll_mode_refsel;
 	int rc;
 
-	/* Read DPLL mode and forcibly selected reference */
-	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
-			     &dpll_mode_refsel);
-	if (rc)
-		return rc;
-
-	/* Extract mode and selected input reference */
-	zldpll->refsel_mode = FIELD_GET(ZL_DPLL_MODE_REFSEL_MODE,
-					dpll_mode_refsel);
-	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
-				       dpll_mode_refsel);
-
 	zldpll->ops = zl3073x_dpll_device_ops;
 	if (zldev->info->flags & ZL3073X_FLAG_DIE_TEMP)
 		zldpll->ops.temp_get = zl3073x_dpll_temp_get;
@@ -1844,8 +1834,10 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	struct zl3073x_dev *zldev = zldpll->dev;
 	enum dpll_lock_status lock_status;
 	struct device *dev = zldev->dev;
+	const struct zl3073x_chan *chan;
 	struct zl3073x_dpll_pin *pin;
 	int rc;
+	u8 mode;
 
 	zldpll->check_count++;
 
@@ -1867,8 +1859,10 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	/* Input pin monitoring does make sense only in automatic
 	 * or forced reference modes.
 	 */
-	if (zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	mode = zl3073x_chan_mode_get(chan);
+	if (mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
+	    mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
 		return;
 
 	/* Update phase offset latch registers for this DPLL if the phase
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 278a24f357c9b..115ee4f67e7ab 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -13,8 +13,6 @@
  * @list: this DPLL list entry
  * @dev: pointer to multi-function parent device
  * @id: DPLL index
- * @refsel_mode: reference selection mode
- * @forced_ref: selected reference in forced reference lock mode
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
  * @ops: DPLL device operations for this instance
@@ -28,8 +26,6 @@ struct zl3073x_dpll {
 	struct list_head		list;
 	struct zl3073x_dev		*dev;
 	u8				id;
-	u8				refsel_mode;
-	u8				forced_ref;
 	u8				check_count;
 	bool				phase_monitor;
 	struct dpll_device_ops		ops;
-- 
2.52.0


