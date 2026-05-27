Return-Path: <netdev+bounces-292369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGbNIKEZF2ov4gcAu9opvQ
	(envelope-from <netdev+bounces-292369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026EF5E7A38
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A87830945FE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8FA436356;
	Wed, 27 May 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W82Fsmv3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE284380FE4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898401; cv=none; b=IMxov3+MbrwTJ3P9cC6W8ohOrzFsgukYgeSPgUrSOLjP7NGar9pZgIxFxtW8OZvD0pEdJbzTbV/n2RC79QovRJGMy0lImsTlo/u7EweDPost5JtkVbos+NI9ScPh5IV6e2Zgj7WSSmmXSfv09tQB6H1PXi7g4fwYx5tbbfRXATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898401; c=relaxed/simple;
	bh=KT7bS8WUcwap+mfOESA9xsUOI5o3clRRUMGFjAtD1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPiwxU3cmGb66w0msdt7sP5nRk1U2j0juVmQ3f4FpGoLyyS/oDpoS3RFkMHBf+vvTW5xCylZClpSjmfkbiFv8log/B6LndGnP4A3dwceC6RQgHcja+BPxltzGmAROYM5BeuVbMk68KzuDqiFYg7wzw1UPq2348fmgmOBzaTqGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W82Fsmv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779898393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pgFWRnUlM7poxsvly5nrMvDuqZ/7FEV7PBVD9Kne26A=;
	b=W82Fsmv3m3B3x6zFTSeZtr3EhvoFH+wiweY7B/gOX6E/hdjCNOPrgdATsd8Aj5d79ejVlK
	NoJgbkoOHya+buj8qIDBAI76ZbKC8sTHHmVo0S3sxvVpBEh5vbKEcKIeuA5GuTxLt+HtEe
	tghboFtnP50h9dRfSEXknZtuqutyXek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-1oCxecSCOOemVrE1Yg25oQ-1; Wed,
 27 May 2026 12:13:07 -0400
X-MC-Unique: 1oCxecSCOOemVrE1Yg25oQ-1
X-Mimecast-MFC-AGG-ID: 1oCxecSCOOemVrE1Yg25oQ_1779898382
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B812319560B8;
	Wed, 27 May 2026 16:13:01 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 722C71684;
	Wed, 27 May 2026 16:12:57 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/4] dpll: zl3073x: add per-DPLL serialization lock
Date: Wed, 27 May 2026 18:12:40 +0200
Message-ID: <20260527161241.86655-4-ivecera@redhat.com>
In-Reply-To: <20260527161241.86655-1-ivecera@redhat.com>
References: <20260527161241.86655-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292369-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 026EF5E7A38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a per-DPLL mutex that serializes all operations on a given DPLL
channel across DPLL netlink callbacks, the periodic kthread worker,
and (in subsequent patches) PTP clock callbacks.

All DPLL pin and device callbacks that access mutable state take the
lock as the first operation. The periodic worker holds it for the
entire check cycle of each channel, deferring change notifications
until after the lock is released to avoid ABBA deadlock with
dpll_lock. This establishes the lock ordering:
dpll_lock (subsystem, outer) -> zldpll->lock (driver, inner).

Move zl3073x_chan_state_update() from the per-device
zl3073x_dev_chan_states_update() loop into the per-DPLL
zl3073x_dpll_changes_check() so it runs under zldpll->lock.
This serializes df_offset writes with all readers and
eliminates the need for separate df_offset synchronization.

Change pin->freq_offset from atomic64_t to plain s64 since all
readers and writers are now serialized by zldpll->lock, making
atomic access unnecessary.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c |  18 +---
 drivers/dpll/zl3073x/dpll.c | 186 ++++++++++++++++++++++++++++--------
 drivers/dpll/zl3073x/dpll.h |   2 +
 3 files changed, 151 insertions(+), 55 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 02f42fd72aa57..e3631d800cbf1 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -567,19 +567,7 @@ zl3073x_dev_ref_states_update(struct zl3073x_dev *zldev)
 	}
 }
 
-static void
-zl3073x_dev_chan_states_update(struct zl3073x_dev *zldev)
-{
-	int i, rc;
 
-	for (i = 0; i < zldev->info->num_channels; i++) {
-		rc = zl3073x_chan_state_update(zldev, i);
-		if (rc)
-			dev_warn(zldev->dev,
-				 "Failed to get DPLL%u state: %pe\n", i,
-				 ERR_PTR(rc));
-	}
-}
 
 /**
  * zl3073x_ref_phase_offsets_update - update reference phase offsets
@@ -720,9 +708,6 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	/* Update input references' states */
 	zl3073x_dev_ref_states_update(zldev);
 
-	/* Update DPLL channels' states */
-	zl3073x_dev_chan_states_update(zldev);
-
 	/* Update DPLL-to-connected-ref phase offsets registers */
 	rc = zl3073x_ref_phase_offsets_update(zldev, -1);
 	if (rc)
@@ -733,14 +718,17 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	 * frequency monitoring enabled.
 	 */
 	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		mutex_lock(&zldpll->lock);
 		if (zldpll->freq_monitor) {
 			rc = zl3073x_ref_freq_meas_update(zldev);
 			if (rc)
 				dev_warn(zldev->dev,
 					 "Failed to update measured frequencies: %pe\n",
 					 ERR_PTR(rc));
+			mutex_unlock(&zldpll->lock);
 			break;
 		}
+		mutex_unlock(&zldpll->lock);
 	}
 
 	list_for_each_entry(zldpll, &zldev->dplls, list)
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 605801964c3cd..d14b8992105af 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
@@ -58,7 +57,7 @@ struct zl3073x_dpll_pin {
 	s32			phase_gran;
 	enum dpll_pin_operstate	operstate;
 	s64			phase_offset;
-	atomic64_t		freq_offset;
+	s64			freq_offset;
 	u32			measured_freq;
 };
 
@@ -134,6 +133,8 @@ zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_ref *ref;
 	u8 ref_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 
@@ -170,6 +171,8 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_ref ref;
 	u8 ref_id, sync_mode;
 
+	guard(mutex)(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = *zl3073x_ref_state_get(zldev, ref_id);
 
@@ -205,6 +208,8 @@ zl3073x_dpll_input_pin_ref_sync_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_ref *ref;
 	u8 ref_id, mode, pair;
 
+	guard(mutex)(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 	mode = zl3073x_ref_sync_mode_get(ref);
@@ -236,6 +241,8 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_ref ref;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
 	ref = *zl3073x_ref_state_get(zldev, ref_id);
@@ -299,12 +306,15 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 			       struct dpll_ffo_param *ffo,
 			       struct netlink_ext_ack *extack)
 {
+	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
 		return -ENODATA;
 
-	ffo->ffo = atomic64_read(&pin->freq_offset);
+	ffo->ffo = pin->freq_offset;
 
 	return 0;
 }
@@ -316,8 +326,11 @@ zl3073x_dpll_input_pin_measured_freq_get(const struct dpll_pin *dpll_pin,
 					 void *dpll_priv, u64 *measured_freq,
 					 struct netlink_ext_ack *extack)
 {
+	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	*measured_freq = pin->measured_freq;
 	*measured_freq *= DPLL_PIN_MEASURED_FREQUENCY_DIVIDER;
 
@@ -335,6 +348,8 @@ zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	u8 ref_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	*frequency = zl3073x_dev_ref_freq_get(zldpll->dev, ref_id);
 
@@ -354,6 +369,8 @@ zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_ref ref;
 	u8 ref_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	/* Get reference state */
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = *zl3073x_ref_state_get(zldev, ref_id);
@@ -402,6 +419,8 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	u8 conn_id, ref_id;
 	s64 ref_phase;
 
+	guard(mutex)(&zldpll->lock);
+
 	/* Get currently connected reference */
 	conn_id = zl3073x_dpll_connected_ref_get(zldpll);
 
@@ -459,6 +478,8 @@ zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	s64 phase_comp;
 	u8 ref_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	/* Read reference configuration */
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
@@ -491,6 +512,8 @@ zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_ref ref;
 	u8 ref_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	/* Read reference configuration */
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = *zl3073x_ref_state_get(zldev, ref_id);
@@ -524,6 +547,8 @@ zl3073x_dpll_ref_operstate_get(struct zl3073x_dpll_pin *pin,
 	const struct zl3073x_ref *ref;
 	u8 ref_id;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 
 	/* Check if this pin is the currently locked reference */
@@ -557,6 +582,8 @@ zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_chan *chan;
 	u8 mode, ref;
 
+	guard(mutex)(&zldpll->lock);
+
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	ref = zl3073x_input_pin_ref_get(pin->id);
 	mode = zl3073x_chan_mode_get(chan);
@@ -590,8 +617,11 @@ zl3073x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
 					     enum dpll_pin_operstate *operstate,
 					     struct netlink_ext_ack *extack)
 {
+	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	return zl3073x_dpll_ref_operstate_get(pin, operstate);
 }
 
@@ -607,7 +637,9 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll_pin *pin = pin_priv;
 	struct zl3073x_chan chan;
 	u8 mode, ref;
-	int rc;
+	int rc = 0;
+
+	mutex_lock(&zldpll->lock);
 
 	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	ref = zl3073x_input_pin_ref_get(pin->id);
@@ -649,13 +681,13 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
 		if (state == DPLL_PIN_STATE_SELECTABLE) {
 			if (zl3073x_chan_ref_is_selectable(&chan, ref))
-				return 0; /* Pin is already selectable */
+				goto unlock; /* Pin is already selectable */
 
 			/* Restore pin priority in HW */
 			zl3073x_chan_ref_prio_set(&chan, ref, pin->prio);
 		} else if (state == DPLL_PIN_STATE_DISCONNECTED) {
 			if (!zl3073x_chan_ref_is_selectable(&chan, ref))
-				return 0; /* Pin is already disconnected */
+				goto unlock; /* Pin is already disconnected */
 
 			/* Set pin priority to none in HW */
 			zl3073x_chan_ref_prio_set(&chan, ref,
@@ -668,18 +700,20 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 		/* In other modes we cannot change input reference */
 		NL_SET_ERR_MSG(extack,
 			       "Pin state cannot be changed in current mode");
-		return -EOPNOTSUPP;
+		rc = -EOPNOTSUPP;
+		goto unlock;
 	}
 
 	/* Commit DPLL channel changes */
 	rc = zl3073x_chan_state_set(zldpll->dev, zldpll->id, &chan);
-	if (rc)
-		return rc;
+	goto unlock;
 
-	return 0;
 invalid_state:
 	NL_SET_ERR_MSG_MOD(extack, "Invalid pin state for this device mode");
-	return -EINVAL;
+	rc = -EINVAL;
+unlock:
+	mutex_unlock(&zldpll->lock);
+	return rc;
 }
 
 static int
@@ -687,8 +721,11 @@ zl3073x_dpll_input_pin_prio_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 				const struct dpll_device *dpll, void *dpll_priv,
 				u32 *prio, struct netlink_ext_ack *extack)
 {
+	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	*prio = pin->prio;
 
 	return 0;
@@ -705,6 +742,8 @@ zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
 	u8 ref;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (prio > ZL_DPLL_REF_PRIO_MAX)
 		return -EINVAL;
 
@@ -740,6 +779,8 @@ zl3073x_dpll_output_pin_esync_get(const struct dpll_pin *dpll_pin,
 	u32 synth_freq, out_freq;
 	u8 out_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
 
@@ -797,6 +838,8 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	u32 synth_freq;
 	u8 out_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
 
@@ -817,7 +860,7 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 
 	/* If esync is being disabled just write mailbox and finish */
 	if (!freq)
-		goto write_mailbox;
+		return zl3073x_out_state_set(zldev, out_id, &out);
 
 	/* Get attached synth frequency */
 	synth = zl3073x_synth_state_get(zldev, zl3073x_out_synth_get(&out));
@@ -834,7 +877,6 @@ zl3073x_dpll_output_pin_esync_set(const struct dpll_pin *dpll_pin,
 	 */
 	out.esync_n_width = out.div / 2;
 
-write_mailbox:
 	/* Commit output configuration */
 	return zl3073x_out_state_set(zldev, out_id, &out);
 }
@@ -849,6 +891,8 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	*frequency = zl3073x_dev_output_pin_freq_get(zldpll->dev, pin->id);
 
 	return 0;
@@ -869,6 +913,8 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_out out;
 	u8 out_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
 
@@ -942,6 +988,8 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	const struct zl3073x_out *out;
 	u8 out_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
 
@@ -965,6 +1013,8 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_out out;
 	u8 out_id;
 
+	guard(mutex)(&zldpll->lock);
+
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
 
@@ -998,6 +1048,8 @@ zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
 	u16 val;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	rc = zl3073x_read_u16(zldev, ZL_REG_DIE_TEMP_STATUS, &val);
 	if (rc)
 		return rc;
@@ -1009,14 +1061,13 @@ zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
 }
 
 static int
-zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
-			     enum dpll_lock_status *status,
-			     enum dpll_lock_status_error *status_error,
-			     struct netlink_ext_ack *extack)
+__zl3073x_dpll_lock_status_get(struct zl3073x_dpll *zldpll,
+			       enum dpll_lock_status *status)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
 	const struct zl3073x_chan *chan;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	switch (zl3073x_chan_mode_get(chan)) {
@@ -1052,6 +1103,19 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
+			     enum dpll_lock_status *status,
+			     enum dpll_lock_status_error *status_error,
+			     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	guard(mutex)(&zldpll->lock);
+
+	return __zl3073x_dpll_lock_status_get(zldpll, status);
+}
+
 static int
 zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
 				 void *dpll_priv, unsigned long *modes,
@@ -1060,6 +1124,8 @@ zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	const struct zl3073x_chan *chan;
 
+	guard(mutex)(&zldpll->lock);
+
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	/* We support switching between automatic and manual mode, except in
@@ -1082,6 +1148,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 	struct zl3073x_dpll *zldpll = dpll_priv;
 	const struct zl3073x_chan *chan;
 
+	guard(mutex)(&zldpll->lock);
+
 	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 
 	switch (zl3073x_chan_mode_get(chan)) {
@@ -1112,6 +1180,8 @@ zl3073x_dpll_phase_offset_avg_factor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	*factor = zl3073x_dev_phase_avg_factor_get(zldpll->dev);
 
 	return 0;
@@ -1134,6 +1204,8 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 	struct zl3073x_dpll *item, *zldpll = dpll_priv;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (factor > 15) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "Phase offset average factor has to be from range <0,15>");
@@ -1167,6 +1239,8 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 	u8 hw_mode, ref;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	ref = zl3073x_chan_refsel_ref_get(&chan);
 
@@ -1228,6 +1302,8 @@ zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (zldpll->phase_monitor)
 		*state = DPLL_FEATURE_STATE_ENABLE;
 	else
@@ -1244,6 +1320,8 @@ zl3073x_dpll_phase_offset_monitor_set(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	zldpll->phase_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
 
 	return 0;
@@ -1257,6 +1335,8 @@ zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (zldpll->freq_monitor)
 		*state = DPLL_FEATURE_STATE_ENABLE;
 	else
@@ -1273,6 +1353,8 @@ zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	zldpll->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
 
 	return 0;
@@ -1694,6 +1776,8 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	u8 ref_id;
 	int rc;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	/* No phase offset if the ref monitor reports signal errors */
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	if (!zl3073x_dev_ref_is_status_ok(zldev, ref_id))
@@ -1750,6 +1834,8 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 	const struct zl3073x_chan *chan;
 	s64 ffo;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
 		return false;
 
@@ -1757,9 +1843,10 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
 			      244140625, 36);
 
-	if (atomic64_xchg(&pin->freq_offset, ffo) != ffo) {
+	if (pin->freq_offset != ffo) {
 		dev_dbg(zldev->dev, "%s freq offset changed to: %lld\n",
 			pin->label, ffo);
+		pin->freq_offset = ffo;
 		return true;
 	}
 
@@ -1784,6 +1871,8 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
 	u8 ref_id;
 	u32 freq;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	if (!zldpll->freq_monitor)
 		return false;
 
@@ -1814,29 +1903,39 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
 void
 zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 {
+	DECLARE_BITMAP(changed_pins, ZL3073X_NUM_INPUT_PINS);
 	struct zl3073x_dev *zldev = zldpll->dev;
 	enum dpll_lock_status lock_status;
 	struct device *dev = zldev->dev;
 	const struct zl3073x_chan *chan;
 	struct zl3073x_dpll_pin *pin;
+	bool dev_changed = false;
 	int rc;
 	u8 mode;
 
+	bitmap_zero(changed_pins, ZL3073X_NUM_INPUT_PINS);
+
+	mutex_lock(&zldpll->lock);
+
 	zldpll->check_count++;
 
-	/* Get current lock status for the DPLL */
-	rc = zl3073x_dpll_lock_status_get(zldpll->dpll_dev, zldpll,
-					  &lock_status, NULL, NULL);
+	rc = zl3073x_chan_state_update(zldev, zldpll->id);
+	if (rc) {
+		dev_err(dev, "Failed to get DPLL%u state: %pe\n",
+			zldpll->id, ERR_PTR(rc));
+		goto unlock;
+	}
+
+	rc = __zl3073x_dpll_lock_status_get(zldpll, &lock_status);
 	if (rc) {
 		dev_err(dev, "Failed to get DPLL%u lock status: %pe\n",
 			zldpll->id, ERR_PTR(rc));
-		return;
+		goto unlock;
 	}
 
-	/* If lock status was changed then notify DPLL core */
 	if (zldpll->lock_status != lock_status) {
 		zldpll->lock_status = lock_status;
-		dpll_device_change_ntf(zldpll->dpll_dev);
+		dev_changed = true;
 	}
 
 	/* Input pin monitoring does make sense only in automatic
@@ -1846,7 +1945,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	mode = zl3073x_chan_mode_get(chan);
 	if (mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
 	    mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
-		return;
+		goto unlock;
 
 	/* Update phase offset latch registers for this DPLL if the phase
 	 * offset monitor feature is enabled.
@@ -1857,17 +1956,13 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 			dev_err(zldev->dev,
 				"Failed to update phase offsets: %pe\n",
 				ERR_PTR(rc));
-			return;
+			goto unlock;
 		}
 	}
 
 	list_for_each_entry(pin, &zldpll->pins, list) {
 		enum dpll_pin_operstate operstate;
-		bool pin_changed = false;
 
-		/* Output pins change checks are not necessary because output
-		 * states are constant.
-		 */
 		if (!zl3073x_dpll_is_input_pin(pin))
 			continue;
 
@@ -1876,31 +1971,40 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 			dev_err(dev,
 				"Failed to get %s on DPLL%u oper state: %pe\n",
 				pin->label, zldpll->id, ERR_PTR(rc));
-			return;
+			goto unlock;
 		}
 
 		if (operstate != pin->operstate) {
 			dev_dbg(dev, "%s oper state changed: %u->%u\n",
 				pin->label, pin->operstate, operstate);
 			pin->operstate = operstate;
-			pin_changed = true;
+			set_bit(pin->id, changed_pins);
 		}
 
-		/* Check for phase offset, ffo, and measured freq change
-		 * once per second.
-		 */
 		if (zldpll->check_count % 2 == 0) {
 			if (zl3073x_dpll_pin_phase_offset_check(pin))
-				pin_changed = true;
+				set_bit(pin->id, changed_pins);
 
 			if (zl3073x_dpll_pin_ffo_check(pin))
-				pin_changed = true;
+				set_bit(pin->id, changed_pins);
 
 			if (zl3073x_dpll_pin_measured_freq_check(pin))
-				pin_changed = true;
+				set_bit(pin->id, changed_pins);
 		}
+	}
+
+unlock:
+	mutex_unlock(&zldpll->lock);
 
-		if (pin_changed)
+	/* Send notifications outside the lock to avoid ABBA deadlock
+	 * with dpll_lock taken by notification functions.
+	 */
+	if (dev_changed)
+		dpll_device_change_ntf(zldpll->dpll_dev);
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (zl3073x_dpll_is_input_pin(pin) &&
+		    test_bit(pin->id, changed_pins))
 			dpll_pin_change_ntf(pin->dpll_pin);
 	}
 }
@@ -1957,6 +2061,7 @@ zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
 
 	zldpll->dev = zldev;
 	zldpll->id = ch;
+	mutex_init(&zldpll->lock);
 	INIT_LIST_HEAD(&zldpll->pins);
 	INIT_WORK(&zldpll->change_work, zl3073x_dpll_change_work);
 
@@ -1974,6 +2079,7 @@ zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
 {
 	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
 
+	mutex_destroy(&zldpll->lock);
 	kfree(zldpll);
 }
 
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 434c32a7db123..0c9924a995087 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -19,6 +19,7 @@
  * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
+ * @lock: per-DPLL mutex serializing all operations
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
  * @change_work: device change notification work
@@ -33,6 +34,7 @@ struct zl3073x_dpll {
 	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
+	struct mutex			lock;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 	struct work_struct		change_work;
-- 
2.53.0


