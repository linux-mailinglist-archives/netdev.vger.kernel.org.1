Return-Path: <netdev+bounces-303174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzSPKg3AQ2oXggoAu9opvQ
	(envelope-from <netdev+bounces-303174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B066E4A45
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=I5zvWJN3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303174-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303174-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108A8323ACF3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6FE439009;
	Tue, 30 Jun 2026 12:56:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B477423A80
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824168; cv=none; b=IORXv3u3khBTJBMCodvHTMGNsSt53W6Ynt8Xkk1dJ6Pdn2XzwXNplyqPZqabzI3uGciTu2rIUXl3D/0xNlSz/IkXv2SuoiPSVY+EUZ0Ktuxi0zA41cDskyu4SWnZ2+ZGBkhOvuIqZCjJ/n5Oc5alTNCayvMNH1Ln8X9PP3mY02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824168; c=relaxed/simple;
	bh=twkZWBGKOWAcvZPsxlIhyPX0QGg39affj3timdf3RnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOW7/QulOUl1dmSrzF2CHnlu/DasODWAT+tHnmxjYV2OMc8IL7ld6lYXLT6GZ0hT6PfrUdANpsy15aWLgfPtXMIOprxg/I3D/eac2Ute3I5dt/J4zYLIwPp2CuXTtEHQF3cr+/0ADQycxOhgMj2a2YNIsKwl60bQVZas7yvWPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5zvWJN3; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB963Ztc6awhcAPzFE8DZVvfz9tpFQVDgqGIg0ywWf8=;
	b=I5zvWJN3cd4Bl1WZZZUk0HcuDeLTS/dGbu3kfHualCvDBTG+oZpGDz7sv7QjCZuNVKEppi
	ZAWslYixCsXwsA+s62WYjZKr1C9bJXTz4CvwSI4GlglNR6O9DPtcIwn91M7f+4b9ul3yWF
	w0lmgHMIySVXVJbji6rWo2JdEXCtO/8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-RijZZAqyP8Kt4rjw9UBCew-1; Tue,
 30 Jun 2026 08:55:59 -0400
X-MC-Unique: RijZZAqyP8Kt4rjw9UBCew-1
X-Mimecast-MFC-AGG-ID: RijZZAqyP8Kt4rjw9UBCew_1782824158
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1594180AC6E;
	Tue, 30 Jun 2026 12:55:57 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 729E918005AC;
	Tue, 30 Jun 2026 12:55:54 +0000 (UTC)
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
Subject: [PATCH net-next v6 4/5] dpll: zl3073x: add per-DPLL serialization lock
Date: Tue, 30 Jun 2026 14:55:35 +0200
Message-ID: <20260630125536.720717-5-ivecera@redhat.com>
In-Reply-To: <20260630125536.720717-1-ivecera@redhat.com>
References: <20260630125536.720717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303174-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19B066E4A45

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
 drivers/dpll/zl3073x/core.c |  19 +---
 drivers/dpll/zl3073x/core.h |   2 +-
 drivers/dpll/zl3073x/dpll.c | 189 +++++++++++++++++++++++++++---------
 drivers/dpll/zl3073x/dpll.h |   2 +
 4 files changed, 149 insertions(+), 63 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 0b2050aa2ed92..7f5afaaae6342 100644
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
@@ -732,7 +717,7 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 	/* Update measured input reference frequencies if frequency
 	 * monitoring is enabled.
 	 */
-	if (zldev->freq_monitor) {
+	if (READ_ONCE(zldev->freq_monitor)) {
 		rc = zl3073x_ref_freq_meas_update(zldev);
 		if (rc)
 			dev_warn(zldev->dev,
@@ -768,7 +753,7 @@ int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor)
 		return rc;
 
 	/* Save the new factor */
-	zldev->phase_avg_factor = factor;
+	WRITE_ONCE(zldev->phase_avg_factor, factor);
 
 	return 0;
 }
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 6b55a05a222ed..78dc208f3eea2 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -101,7 +101,7 @@ void zl3073x_dev_stop(struct zl3073x_dev *zldev);
 
 static inline u8 zl3073x_dev_phase_avg_factor_get(struct zl3073x_dev *zldev)
 {
-	return zldev->phase_avg_factor;
+	return READ_ONCE(zldev->phase_avg_factor);
 }
 
 int zl3073x_dev_phase_avg_factor_set(struct zl3073x_dev *zldev, u8 factor);
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 5e58ded5734d7..87e8b7c865485 100644
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
@@ -1138,8 +1206,8 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 		return rc;
 	}
 
-	/* The averaging factor is common for all DPLL channels so after change
-	 * we have to send a notification for other DPLL devices.
+	/* The averaging factor is common for all DPLL channels so after
+	 * change we have to send a notification for other DPLL devices.
 	 */
 	list_for_each_entry(item, &zldpll->dev->dplls, list) {
 		struct dpll_device *dpll_dev = READ_ONCE(item->dpll_dev);
@@ -1160,6 +1228,8 @@ zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
 	u8 hw_mode, ref;
 	int rc;
 
+	guard(mutex)(&zldpll->lock);
+
 	chan = *zl3073x_chan_state_get(zldpll->dev, zldpll->id);
 	ref = zl3073x_chan_refsel_ref_get(&chan);
 
@@ -1221,6 +1291,8 @@ zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	if (zldpll->phase_monitor)
 		*state = DPLL_FEATURE_STATE_ENABLE;
 	else
@@ -1237,6 +1309,8 @@ zl3073x_dpll_phase_offset_monitor_set(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
+	guard(mutex)(&zldpll->lock);
+
 	zldpll->phase_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
 
 	return 0;
@@ -1250,7 +1324,7 @@ zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
-	if (zldpll->dev->freq_monitor)
+	if (READ_ONCE(zldpll->dev->freq_monitor))
 		*state = DPLL_FEATURE_STATE_ENABLE;
 	else
 		*state = DPLL_FEATURE_STATE_DISABLE;
@@ -1265,13 +1339,14 @@ zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
 			      struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll *item, *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
 
-	zldpll->dev->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
+	WRITE_ONCE(zldev->freq_monitor, state == DPLL_FEATURE_STATE_ENABLE);
 
 	/* The frequency monitoring is common for all DPLL channels so after
 	 * change we have to send a notification for other DPLL devices.
 	 */
-	list_for_each_entry(item, &zldpll->dev->dplls, list) {
+	list_for_each_entry(item, &zldev->dplls, list) {
 		struct dpll_device *dpll_dev = READ_ONCE(item->dpll_dev);
 
 		if (item != zldpll && dpll_dev)
@@ -1697,6 +1772,8 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	u8 ref_id;
 	int rc;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	/* No phase offset if the ref monitor reports signal errors */
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	if (!zl3073x_dev_ref_is_status_ok(zldev, ref_id))
@@ -1753,6 +1830,8 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 	const struct zl3073x_chan *chan;
 	s64 ffo;
 
+	lockdep_assert_held(&zldpll->lock);
+
 	if (pin->operstate != DPLL_PIN_OPERSTATE_ACTIVE)
 		return false;
 
@@ -1760,9 +1839,10 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 	ffo = mul_s64_u64_shr(zl3073x_chan_df_offset_get(chan),
 			      244140625, 36);
 
-	if (atomic64_xchg(&pin->freq_offset, ffo) != ffo) {
+	if (pin->freq_offset != ffo) {
 		dev_dbg(zldev->dev, "%s freq offset changed to: %lld\n",
 			pin->label, ffo);
+		pin->freq_offset = ffo;
 		return true;
 	}
 
@@ -1787,7 +1867,9 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
 	u8 ref_id;
 	u32 freq;
 
-	if (!zldpll->dev->freq_monitor)
+	lockdep_assert_held(&zldpll->lock);
+
+	if (!READ_ONCE(zldpll->dev->freq_monitor))
 		return false;
 
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
@@ -1817,27 +1899,37 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
 void
 zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 {
+	DECLARE_BITMAP(changed_pins, ZL3073X_NUM_INPUT_PINS);
 	struct zl3073x_dev *zldev = zldpll->dev;
 	enum dpll_lock_status lock_status;
 	struct device *dev = zldev->dev;
 	struct zl3073x_dpll_pin *pin;
+	bool dev_changed = false;
 	int rc;
 
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
 
 	/* Update phase offset latch registers for this DPLL if the phase
@@ -1849,17 +1941,13 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
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
 
@@ -1868,31 +1956,40 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
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
 
-		if (pin_changed)
+unlock:
+	mutex_unlock(&zldpll->lock);
+
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
@@ -1949,6 +2046,7 @@ zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
 
 	zldpll->dev = zldev;
 	zldpll->id = ch;
+	mutex_init(&zldpll->lock);
 	INIT_LIST_HEAD(&zldpll->pins);
 
 	return zldpll;
@@ -1965,6 +2063,7 @@ zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
 {
 	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
 
+	mutex_destroy(&zldpll->lock);
 	kfree(zldpll);
 }
 
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 21adcc18e45e1..9f57c944a0077 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -18,6 +18,7 @@
  * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
+ * @lock: per-DPLL mutex serializing all operations
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
  */
@@ -30,6 +31,7 @@ struct zl3073x_dpll {
 	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
+	struct mutex			lock;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
 };
-- 
2.53.0


