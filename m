Return-Path: <netdev+bounces-281641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIH4DiBF8Gn2QwEAu9opvQ
	(envelope-from <netdev+bounces-281641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:26:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4F47D8D6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA52305DBBC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E632E126;
	Tue, 28 Apr 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2L8rbfz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8D33F8C3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353812; cv=none; b=KvKWnVVLB1/QW5vrstlg68jL8b9hSq8qEJDN81wWXgTCji6mq3VfjEwNTWiP7Gn+evXMIeNyh2mHMPq+gA9HnxvfPzXSXS0tNbntOLQCAYKTW5WDTozpXP+rVbKTs2Xok71g5wsLK/XnuB8kPtI2MRFvZ6tvlG9/qIe/q9dbKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353812; c=relaxed/simple;
	bh=OKm3xwswnlNVnZLDavoSl/QXcXWznGFcDzlHWZpTjmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BABzoQmjuKt5o2cnY9Aa7JH1gnKc9ZJPDa6uKHkMpy4+33T8flC2w1ijL02H1sLd01ZI0XF+AvHk+K6LvBRMQRotoADm/5XBfWHU9+NLA7WajC/u1Kv7A5o0z+O56bQ9bqo2iE2w1JNETUhcrZX8Isxd6bheW3OAqEsJ6b/jDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2L8rbfz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353805; x=1808889805;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OKm3xwswnlNVnZLDavoSl/QXcXWznGFcDzlHWZpTjmE=;
  b=G2L8rbfzeQI40tb+NUxQMn3PjF6CGjTS+k08hnAENmRUpC/CJ4AM8wcb
   Xe53LxrXj9pIHAFmeSL+1iEfpfdP/2ztp9R6jRpy7IKQ0nz7vkOjw/jh2
   RiWbt2gBjO7FPEU/hh2ChCcwWRG/Ve9K1CcrEsco/0EfhsCoCY89pQNgb
   3W4kPoS+hBEX47JREPZ6I+WAFHQM9Tb2g5NnKAB7B1EGUi8tnjw71hENa
   kJpru3yx/SdJqgZZlpeUUNxUKUwGH1TPhkHkN926qUmKTZNl7OdTJhxqP
   zjd/GzknYBSn+GVIShNn8WNWxvUvvt2kp1Y3Lwhlswma9fgdMWiC0UzjL
   g==;
X-CSE-ConnectionGUID: PNZnncdsT/yPZbq5RoFXyQ==
X-CSE-MsgGUID: ge0q/m/STkC0vKztn8LJ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="100910577"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="100910577"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
X-CSE-ConnectionGUID: QqLGyYdfT6at21F5S5nyoA==
X-CSE-MsgGUID: XiOYhEjAR4q3yX7bQvyyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237800222"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:23:16 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 27 Apr 2026 22:22:22 -0700
Subject: [PATCH net 10/11] ice: fix missing dpll notifications for SW pins
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-jk-iwl-net-petr-oros-fixes-v1-10-cdcb48303fd8@intel.com>
References: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
In-Reply-To: <20260427-jk-iwl-net-petr-oros-fixes-v1-0-cdcb48303fd8@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Petr Oros <poros@redhat.com>, Alexander Nowlin <alexander.nowlin@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Ivan Vecera <ivecera@redhat.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5757;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ir4agml4Vm+vrLQRAyaNu08/pZsMVRkXSrdEhTxoCNc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswPLk4uyzskux1XMv46MXGy2aPN9/+LVbxoWuuzleWOU
 MrGeys2dpSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRC5wM/6ycGVYZCT//cvri
 poR6nqAdImYsFTIPFNTPNqxeNW+P1QmGf2bqTRIP9n6Wrbrwcp6nmYrQjlf53Q8EX85KSegvX2L
 AxAcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: A8D4F47D8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281641-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Petr Oros <poros@redhat.com>

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

Fix by introducing ice_dpll_pin_ntf(), a wrapper around
dpll_pin_change_ntf() that also notifies any registered SMA/U.FL pin
whose backing CGU input matches.  Replace all direct
dpll_pin_change_ntf() calls in the periodic notification paths with
this wrapper.  Fix ice_dpll_phase_offset_get() to return the backing
CGU input's phase_offset for input-direction SW pins.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 47 +++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 3f8cd5b8298b..721a3f4d6a28 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1963,7 +1963,10 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
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
@@ -2657,6 +2660,27 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
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
@@ -2665,6 +2689,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
  */
 static void ice_dpll_notify_changes(struct ice_dpll *d)
 {
+	struct ice_dplls *dplls = &d->pf->dplls;
 	bool pin_notified = false;
 
 	if (d->prev_dpll_state != d->dpll_state) {
@@ -2673,17 +2698,17 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
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
 
@@ -2712,6 +2737,7 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
 
 /**
  * ice_dpll_pins_notify_mask - notify dpll subsystem about bulk pin changes
+ * @dplls: pointer to dplls struct
  * @pins: array of ice_dpll_pin pointers registered within dpll subsystem
  * @pin_num: number of pins
  * @phase_offset_ntf_mask: bitmask of pin indexes to notify
@@ -2721,15 +2747,14 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
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
@@ -2905,7 +2930,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
 	ice_dpll_notify_changes(de);
 	ice_dpll_notify_changes(dp);
 	if (phase_offset_ntf)
-		ice_dpll_pins_notify_mask(d->inputs, d->num_inputs,
+		ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
 					  phase_offset_ntf);
 
 resched:

-- 
2.54.0.rc2.531.gaf818d63126a


