Return-Path: <netdev+bounces-279019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LP0L7fL4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9440D9B5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB06F3058553
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944813AE71B;
	Thu, 16 Apr 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqnMIcG5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592653AE196
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339624; cv=none; b=PASK19jFgevGwiAEbfw38NDeCbQh75yFTq7B5tztsRETL71IZckSU1Axre6kdcqa3xHcQza02lPjUT0TUkiqsOlc+PPvLvaQ4hybpY/WNGPs3KsrAk2hp2c+urHQjt8Pps4chMvFHWRQLd1VRgq56Ei7d1w/XNWY3XYsawUT518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339624; c=relaxed/simple;
	bh=7LFO7y/+yJDUBU+zvWHVSirIhyLKOOq461KhyLPB2LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj4g0xkaO81ImGI4xQTo19+eQ76CU8NNEgbtbAOowYw7OBaAJn+l/KRBr9asE8oC2188jJCc42NAhK1RKQvpZQCRwhDx6hOoS4Ax3lVrR7vmUXYuUWrzBpyT1dhYGRIBWy0AhA3iTXbcuxsTnVasFZdDeRjrxxNo43Jej/OBzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqnMIcG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776339619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLotX7IEgbAkY26WaqkBVeVZ17szpdiJ55gFPzooK4k=;
	b=HqnMIcG5Fw5GaGMNoLn44dGTpsOEa/EObUDHFMU3dJ45ofzsph6UCOuviqZ6SQ6cI1HwJr
	JtaWQT/sHHI/o8RChnKDtJjxCAtjmDvqg2O37XKNg4nV2lC+QZDdfOKPY8YFMCUmhmQB5x
	tXNv+3Q8HTWGl2JCe/WC4VeIcrMcd7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-UrU_Zsa7P1WKXSUPytv0Mg-1; Thu,
 16 Apr 2026 07:40:15 -0400
X-MC-Unique: UrU_Zsa7P1WKXSUPytv0Mg-1
X-Mimecast-MFC-AGG-ID: UrU_Zsa7P1WKXSUPytv0Mg_1776339613
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9B181800473;
	Thu, 16 Apr 2026 11:40:12 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6B4E18004AD;
	Thu, 16 Apr 2026 11:40:07 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v6 2/2] ice: fix missing dpll notifications for SW pins
Date: Thu, 16 Apr 2026 13:39:52 +0200
Message-ID: <20260416113952.389405-3-poros@redhat.com>
In-Reply-To: <20260416113952.389405-1-poros@redhat.com>
References: <20260416113952.389405-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279019-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37F9440D9B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SMA/U.FL pin redesign (commit 2dd5d03c77e2 ("ice: redesign dpll
sma/u.fl pins control")) introduced software-controlled pins that wrap
backing CGU input/output pins, but never updated the notification and
data paths to propagate pin events to these SW wrappers.

The periodic work sends dpll_pin_change_ntf() only for direct CGU input
pins.  SW pins that wrap these inputs never receive change or phase
offset notifications, so userspace consumers such as synce4l monitoring
SMA pins via dpll netlink never learn about state transitions or phase
offset updates.  Similarly, ice_dpll_phase_offset_get() reads the SW
pin's own phase_offset field which is never updated; the PPS monitor
writes to the backing CGU input's field instead.

On top of that, when SMA or U.FL pin state changes via PCA9575 GPIO
write, the paired pin's state also changes because they share physical
signal paths, but no notification is sent for the peer pin.

Fix by introducing ice_dpll_pin_ntf(), a wrapper around
dpll_pin_change_ntf() that also notifies any registered SMA/U.FL pin
whose backing CGU input matches.  Replace all direct
dpll_pin_change_ntf() calls in the periodic notification paths with
this wrapper.  Fix ice_dpll_phase_offset_get() to return the backing
CGU input's phase_offset for input-direction SW pins.  Add
ice_dpll_sw_pin_notify_peer() to send a notification for the paired
SW pin after PCA9575 writes.  The peer notification is called from
the dpll_pin_ops callback wrappers after pf->dplls.lock is released,
because dpll_pin_change_ntf() sends a netlink message that invokes
driver callbacks which acquire the same lock.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v6:
 - fix deadlock reported by Michal Schmidt: dpll_pin_change_ntf() in
   peer notification was called with dpll_lock held, causing deadlock.
   Move the peer notification calls out of ice_dpll_sma_direction_set()
   and ice_dpll_ufl_pin_state_set() into their dpll_pin_ops callback
   wrappers, after pf->dplls.lock is released, and use
   __dpll_pin_change_ntf() because dpll_lock is still held by the dpll
   netlink layer (dpll_pin_pre_doit).
v5: https://lore.kernel.org/all/20260409102501.1447628-1-poros@redhat.com/
 - add ice_dpll_sw_pin_notify_peer() for SMA/U.FL peer notification
   when PCA9575 routing changes affect the paired pin (reported by
   Intel test: SMA state change did not log U.FL status change in
   subscribe monitor)
v4: https://lore.kernel.org/all/20260319205256.998876-1-poros@redhat.com/
v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 80 +++++++++++++++++++----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 3a90a2940fdc6e..117c6a8590a279 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1154,6 +1154,32 @@ ice_dpll_input_state_get(const struct dpll_pin *pin, void *pin_priv,
 				      extack, ICE_DPLL_PIN_TYPE_INPUT);
 }
 
+/**
+ * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a state change
+ * @d: pointer to dplls struct
+ * @changed: the SW pin that was explicitly changed (already notified by dpll core)
+ *
+ * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1 and
+ * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
+ * expander, the paired pin's state may also change.  Send a change
+ * notification for the peer pin so userspace consumers monitoring the
+ * peer via dpll netlink learn about the update.
+ *
+ * Context: Called from dpll_pin_ops callbacks after pf->dplls.lock is
+ *          released.  Uses __dpll_pin_change_ntf() because dpll_lock is
+ *          still held by the dpll netlink layer.
+ */
+static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
+					struct ice_dpll_pin *changed)
+{
+	struct ice_dpll_pin *peer;
+
+	peer = (changed >= d->sma && changed < d->sma + ICE_DPLL_PIN_SW_NUM) ?
+		&d->ufl[changed->idx] : &d->sma[changed->idx];
+	if (peer->pin)
+		__dpll_pin_change_ntf(peer->pin);
+}
+
 /**
  * ice_dpll_sma_direction_set - set direction of SMA pin
  * @p: pointer to a pin
@@ -1233,7 +1259,6 @@ static int ice_dpll_sma_direction_set(struct ice_dpll_pin *p,
 			ret = ice_dpll_pin_state_update(p->pf, target,
 							type, extack);
 	}
-
 	return ret;
 }
 
@@ -1344,6 +1369,8 @@ ice_dpll_ufl_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
 
 	return ret;
 }
@@ -1462,6 +1489,8 @@ ice_dpll_sma_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 unlock:
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, sma);
 
 	return ret;
 }
@@ -1657,6 +1686,8 @@ ice_dpll_pin_sma_direction_set(const struct dpll_pin *pin, void *pin_priv,
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_sma_direction_set(p, direction, extack);
 	mutex_unlock(&pf->dplls.lock);
+	if (!ret)
+		ice_dpll_sw_pin_notify_peer(&pf->dplls, p);
 
 	return ret;
 }
@@ -1963,7 +1994,10 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
 				       d->active_input == p->input->pin))
 		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
 	else if (d->phase_offset_monitor_period)
-		*phase_offset = p->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
+		*phase_offset = (p->input &&
+				 p->direction == DPLL_PIN_DIRECTION_INPUT ?
+				 p->input->phase_offset :
+				 p->phase_offset) * ICE_DPLL_PHASE_OFFSET_FACTOR;
 	else
 		*phase_offset = 0;
 	mutex_unlock(&pf->dplls.lock);
@@ -2659,6 +2693,27 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
 	return pci_get_dsn(pf->pdev);
 }
 
+/**
+ * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
+ * @dplls: pointer to dplls struct
+ * @pin: the dpll_pin that changed
+ *
+ * Send a change notification for @pin and for any registered SMA/U.FL pin
+ * whose backing CGU input matches @pin.
+ */
+static void ice_dpll_pin_ntf(struct ice_dplls *dplls, struct dpll_pin *pin)
+{
+	dpll_pin_change_ntf(pin);
+	for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
+		if (dplls->sma[i].pin && dplls->sma[i].input &&
+		    dplls->sma[i].input->pin == pin)
+			dpll_pin_change_ntf(dplls->sma[i].pin);
+		if (dplls->ufl[i].pin && dplls->ufl[i].input &&
+		    dplls->ufl[i].input->pin == pin)
+			dpll_pin_change_ntf(dplls->ufl[i].pin);
+	}
+}
+
 /**
  * ice_dpll_notify_changes - notify dpll subsystem about changes
  * @d: pointer do dpll
@@ -2667,6 +2722,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2675,17 +2731,17 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
 	}
 	if (d->prev_input != d->active_input) {
 		if (d->prev_input)
-			dpll_pin_change_ntf(d->prev_input);
+			ice_dpll_pin_ntf(dplls, d->prev_input);
 		d->prev_input = d->active_input;
 		if (d->active_input) {
-			dpll_pin_change_ntf(d->active_input);
+			ice_dpll_pin_ntf(dplls, d->active_input);
 			pin_notified = true;
 		}
 	}
 	if (d->prev_phase_offset != d->phase_offset) {
 		d->prev_phase_offset = d->phase_offset;
 		if (!pin_notified && d->active_input)
-			dpll_pin_change_ntf(d->active_input);
+			ice_dpll_pin_ntf(dplls, d->active_input);
 	}
 }
 
@@ -2714,6 +2770,7 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
 
 /**
  * ice_dpll_pins_notify_mask - notify dpll subsystem about bulk pin changes
+ * @dplls: pointer to dplls struct
  * @pins: array of ice_dpll_pin pointers registered within dpll subsystem
  * @pin_num: number of pins
  * @phase_offset_ntf_mask: bitmask of pin indexes to notify
@@ -2723,15 +2780,14 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
  *
  * Context: Must be called while pf->dplls.lock is released.
  */
-static void ice_dpll_pins_notify_mask(struct ice_dpll_pin *pins,
+static void ice_dpll_pins_notify_mask(struct ice_dplls *dplls,
+				      struct ice_dpll_pin *pins,
 				      u8 pin_num,
 				      u32 phase_offset_ntf_mask)
 {
-	int i = 0;
-
-	for (i = 0; i < pin_num; i++)
-		if (phase_offset_ntf_mask & (1 << i))
-			dpll_pin_change_ntf(pins[i].pin);
+	for (int i = 0; i < pin_num; i++)
+		if (phase_offset_ntf_mask & BIT(i))
+			ice_dpll_pin_ntf(dplls, pins[i].pin);
 }
 
 /**
@@ -2907,7 +2963,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 	if (phase_offset_ntf)
-		ice_dpll_pins_notify_mask(d->inputs, d->num_inputs,
+		ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
 					  phase_offset_ntf);
 
 resched:
-- 
2.52.0


