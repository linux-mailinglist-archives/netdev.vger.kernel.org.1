Return-Path: <netdev+bounces-288103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL0qF+FVBmqnigIAu9opvQ
	(envelope-from <netdev+bounces-288103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:08:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BD3547B0F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8BBD3092DAF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833563921C7;
	Thu, 14 May 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEm2IWm9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8638F929;
	Thu, 14 May 2026 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799901; cv=none; b=O02LrR06d7KsoMghb2nShyRneRmxI6LgmeGiz8hLeGmZMNv/kWae+zVeCAG7NIvm/uKK1jk/GzXraszxF2AEHKa1WFH0Qc7UmaKaqEgHCO9veCyv7NFwc66Mlah1U9hvpVgnm4Z19hpnlOjVyk/B3/mTUSwiDAh+6owZsX71v1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799901; c=relaxed/simple;
	bh=uGgSnY7fKgSgIWpGn+DI3Rpeyksyw4XnVW3Pf/FTpsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQA8U7FbxJmzhCDh4MZv+mCNnOTH+OORm9ysyxi4ecU6t8o1rg88w+avLy3aPJ20Fym13AkFKtS06Fggs/xQR32KwQHvr83j2h8RvI5eEV1gUB1xOpFkjbTUUG4jWXtKnhVZba1S6lobzIhoIh4vd4EENXbUz6c2wH66E2sTKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEm2IWm9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778799900; x=1810335900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGgSnY7fKgSgIWpGn+DI3Rpeyksyw4XnVW3Pf/FTpsE=;
  b=OEm2IWm9fL7eWLuMyZnkBUSq3i9PtvtA5qpVWye2kyQgbRD66APz2vYv
   XqGT2K/gUfz6YaP84imSJTPYXYYUik/ZSnEq/SVfmHmP+12VcI7WLjsNQ
   64cRjsYIqJlemCc76iBmcKNcl8U7BFkxyrZl96d7MMxua1DLNPEvL9i8x
   Rs8wwwLUP0edIxC74JtxITTGelu4X6skowbnhwneC3Y4kolrWryiDrsky
   v7YWFcoY6RAHiYGTHdae/LOvX8LklR4NxIdnn36McsPLI4wkp7Bns6n/i
   1FFbqfJFBT7/iaIebQhKohkxJ7XnRsdJ2sLcWPshNkAfRUT/e+XHAHZxn
   g==;
X-CSE-ConnectionGUID: 865BNf9ISa+uST+1uPhNrw==
X-CSE-MsgGUID: ApwE7Ja6QmeF8zNUYWfywQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79924658"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79924658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:04:58 -0700
X-CSE-ConnectionGUID: t+ePfV0AQ/uTHmTIt/ldmw==
X-CSE-MsgGUID: urLzTFzsT1etDHRBcHFKfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262275950"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2026 16:04:53 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v9 net-next 8/8] ice: implement E825 TX ref clock control and TXC hardware sync status
Date: Fri, 15 May 2026 00:59:46 +0200
Message-Id: <20260514225946.2885623-9-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C6BD3547B0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-288103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Build on the previously introduced TXC DPLL framework and implement
full TX reference clock control and hardware-backed synchronization
status reporting for E825 devices.

E825 firmware may accept or override TX reference clock requests based
on device-wide routing constraints and link conditions. For this
reason, TX reference selection and synchronization status must be
observed from hardware rather than inferred from user intent.

This change implements TX reference switching using a deferred worker,
triggered by DPLL TXCLK pin operations. Pin set callbacks express
selection intent and schedule the operation asynchronously; firmware
commands and autonegotiation restarts are executed outside of DPLL
context.

After link-up, the effective TX reference clock is read back from
hardware and software state is reconciled accordingly. TXCLK pin state
reflects only the selected reference clock topology:
- External references (SYNCE, EREF0) are represented as TXCLK pins
- The internal ENET/TXCO clock has no pin representation; when selected,
  all TXCLK pins are reported DISCONNECTED

Actual hardware synchronization result is reported exclusively via the
TXC DPLL lock status:
- LOCKED when an external TX reference is in use
- UNLOCKED when falling back to ENET/TXCO

This separation allows userspace to distinguish between TX reference
selection and successful synchronization, matching the DPLL subsystem
model where pin state describes topology and device lock status
describes signal quality.

With this change, TX reference clocks on E825 devices can be reliably
selected, verified against hardware state, and monitored for effective
synchronization via standard DPLL interfaces.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile     |   2 +-
 drivers/net/ethernet/intel/ice/ice.h        |  12 +
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 131 ++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  26 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h    |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  37 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  27 ++
 drivers/net/ethernet/intel/ice/ice_txclk.c  | 289 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h  |  38 +++
 10 files changed, 554 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 38db476ab2ec..95fd0c49800f 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
-ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o ice_dpll.o ice_tspll.o ice_cpi.o
+ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o ice_dpll.o ice_tspll.o ice_cpi.o ice_txclk.o
 ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
 ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 725b130dd3a2..f72bb1aa4067 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1155,4 +1155,16 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 	else
 		return &pf->adapter->ctrl_pf->hw;
 }
+
+/**
+ * ice_get_ctrl_pf - Get pointer to Control PF of the adapter
+ * @pf: pointer to the current PF structure
+ *
+ * Return: A pointer to ice_pf structure which is Control PF,
+ * NULL if it's not initialized yet.
+ */
+static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
+{
+	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+}
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 1b193e0c35ab..c9b101613fbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_txclk.h"
 #include <linux/dpll.h>
 #include <linux/property.h>
 
@@ -19,8 +20,6 @@
 #define ICE_DPLL_SW_PIN_INPUT_BASE_QSFP		6
 #define ICE_DPLL_SW_PIN_OUTPUT_BASE		0
 
-#define E825_EXT_EREF_PIN_IDX			0
-#define E825_EXT_SYNCE_PIN_IDX			1
 #define E825_RCLK_PARENT_0_PIN_IDX		0
 #define E825_RCLK_PARENT_1_PIN_IDX		1
 
@@ -2615,6 +2614,60 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	return ret;
 }
 
+/**
+ * ice_dpll_txclk_work - apply a pending TX reference clock change
+ * @work: work_struct embedded in struct ice_dplls
+ *
+ * This worker executes an outstanding TX reference clock switch request
+ * that was previously queued via the DPLL TXCLK pin set callback.
+ *
+ * The worker performs only the operational part of the switch, issuing
+ * the necessary firmware commands to request a new TX reference clock
+ * selection (e.g. triggering an AN restart). It does not verify whether
+ * the requested clock was ultimately accepted by the hardware.
+ *
+ * Hardware verification, software state reconciliation, pin state
+ * notification, and TXC DPLL lock-status updates are performed later,
+ * after link-up, by ice_txclk_update_and_notify().
+ *
+ * Context:
+ *   - Runs in process context on pf->dplls.wq and may sleep.
+ *   - Serializes access to shared TXCLK state using pf->dplls.lock.
+ */
+static void ice_dpll_txclk_work(struct work_struct *work)
+{
+	struct ice_dplls *dplls =
+		container_of(work, struct ice_dplls, txclk_work);
+	struct ice_pf *pf = container_of(dplls, struct ice_pf, dplls);
+	enum ice_e825c_ref_clk clk;
+	bool do_switch;
+	int err;
+
+	mutex_lock(&pf->dplls.lock);
+	do_switch = pf->dplls.txclk_switch_requested;
+	clk = pf->ptp.port.tx_clk_req;
+	mutex_unlock(&pf->dplls.lock);
+
+	if (!do_switch)
+		return;
+
+	err = ice_txclk_set_clk(pf, clk);
+
+	mutex_lock(&pf->dplls.lock);
+	pf->dplls.txclk_switch_requested = false;
+	if (err) {
+		/* Roll back the requested clock to match the current hardware
+		 * state so that ice_txclk_update_and_notify() does not
+		 * misinterpret a future link-up as a failed switch.
+		 */
+		dev_err(ice_pf_to_dev(pf),
+			"TX clock switch to %u failed, err=%d; reverting\n",
+			clk, err);
+		pf->ptp.port.tx_clk_req = pf->ptp.port.tx_clk;
+	}
+	mutex_unlock(&pf->dplls.lock);
+}
+
 /**
  * ice_dpll_txclk_state_on_dpll_set - set a state on TX clk pin
  * @pin: pointer to a pin
@@ -2626,7 +2679,9 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
  *
  * Dpll subsystem callback, set a state of a Tx reference clock pin
  *
+ * Context: Acquires and releases pf->dplls.lock
  * Return:
+ * * 0 - success
  * * negative - failure
  */
 static int
@@ -2635,11 +2690,29 @@ ice_dpll_txclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 				 void *dpll_priv, enum dpll_pin_state state,
 				 struct netlink_ext_ack *extack)
 {
-	/*
-	 * TODO: set HW accordingly to selected TX reference clock.
-	 * To be added in the follow up patches.
-	 */
-	return -EOPNOTSUPP;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+	enum ice_e825c_ref_clk new_clk;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
+	mutex_lock(&pf->dplls.lock);
+	if (state == DPLL_PIN_STATE_DISCONNECTED &&
+	    p->tx_ref_src != pf->ptp.port.tx_clk_req)
+		goto unlock;
+
+	new_clk = (state == DPLL_PIN_STATE_DISCONNECTED) ? ICE_REF_CLK_ENET :
+			p->tx_ref_src;
+	if (new_clk == pf->ptp.port.tx_clk_req)
+		goto unlock;
+
+	pf->ptp.port.tx_clk_req = new_clk;
+	pf->dplls.txclk_switch_requested = true;
+	queue_work(pf->dplls.wq, &pf->dplls.txclk_work);
+unlock:
+	mutex_unlock(&pf->dplls.lock);
+	return 0;
 }
 
 /**
@@ -2651,10 +2724,21 @@ ice_dpll_txclk_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
  * @state: on success holds pin state on parent pin
  * @extack: error reporting
  *
- * dpll subsystem callback, get a state of a TX clock reference pin.
+ * TXCLK DPLL pin state is derived and not stored explicitly.
  *
+ * Only external TX reference clocks (SYNCE, EREF0) are modeled
+ * as DPLL pins. The internal ENET (TXCO) clock has no pin and,
+ * when selected, all TXCLK pins are reported DISCONNECTED.
+ *
+ * During a pending TXCLK switch, the requested pin may be
+ * reported as CONNECTED before hardware verification.
+ * Hardware acceptance and synchronization are reported
+ * exclusively via TXC DPLL lock-status.
+ *
+ * Context: Acquires and releases pf->dplls.lock
  * Return:
  * * 0 - success
+ * * negative - failure
  */
 static int
 ice_dpll_txclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
@@ -2663,11 +2747,18 @@ ice_dpll_txclk_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
 				 enum dpll_pin_state *state,
 				 struct netlink_ext_ack *extack)
 {
-	/*
-	 * TODO: query HW status to determine if the TX reference is selected.
-	 * To be added in the follow up patches.
-	 */
-	*state = DPLL_PIN_STATE_DISCONNECTED;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_pf *pf = p->pf;
+
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
+	mutex_lock(&pf->dplls.lock);
+	if (pf->ptp.port.tx_clk_req == p->tx_ref_src)
+		*state = DPLL_PIN_STATE_CONNECTED;
+	else
+		*state = DPLL_PIN_STATE_DISCONNECTED;
+	mutex_unlock(&pf->dplls.lock);
 
 	return 0;
 }
@@ -4531,6 +4622,8 @@ static int ice_dpll_init_info_e825c(struct ice_pf *pf)
 	dt->mode = DPLL_MODE_MANUAL;
 	dt->dpll_idx = pf->ptp.port.port_num;
 
+	INIT_WORK(&pf->dplls.txclk_work, ice_dpll_txclk_work);
+
 	d->inputs = kzalloc_objs(*d->inputs, d->num_inputs);
 	if (!d->inputs)
 		return -ENOMEM;
@@ -4674,10 +4767,21 @@ void ice_dpll_deinit(struct ice_pf *pf)
 {
 	bool cgu = ice_is_feature_supported(pf, ICE_F_CGU);
 
+	/* Clear the flag under the lock so that concurrent callers of
+	 * ice_txclk_update_and_notify() either see the cleared flag and
+	 * return early, or are already past the check and will finish
+	 * before we proceed to free pins and DPLL devices below.
+	 */
+	mutex_lock(&pf->dplls.lock);
 	clear_bit(ICE_FLAG_DPLL, pf->flags);
+	mutex_unlock(&pf->dplls.lock);
+
 	if (cgu)
 		ice_dpll_deinit_worker(pf);
 
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825)
+		cancel_work_sync(&pf->dplls.txclk_work);
+
 	ice_dpll_deinit_pins(pf, cgu);
 	if (!IS_ERR_OR_NULL(pf->dplls.pps.dpll))
 		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
@@ -4687,6 +4791,7 @@ void ice_dpll_deinit(struct ice_pf *pf)
 		ice_dpll_deinit_dpll(pf, &pf->dplls.txc, false);
 
 	ice_dpll_deinit_info(pf);
+
 	mutex_destroy(&pf->dplls.lock);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index 85e38752056d..81553f84799c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -8,6 +8,8 @@
 
 #define ICE_DPLL_RCLK_NUM_MAX	4
 #define ICE_DPLL_TXCLK_NUM_MAX	2
+#define E825_EXT_EREF_PIN_IDX	0
+#define E825_EXT_SYNCE_PIN_IDX	1
 
 #define ICE_CGU_R10			0x28
 #define ICE_CGU_R10_SYNCE_CLKO_SEL	GENMASK(8, 5)
@@ -168,6 +170,8 @@ struct ice_dplls {
 	s32 output_phase_adj_max;
 	u32 periodic_counter;
 	bool generic;
+	struct work_struct txclk_work;
+	bool txclk_switch_requested;
 };
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 36df742c326c..c1332b51559e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_txclk.h"
 
 static const char ice_pin_names[][64] = {
 	"SDP0",
@@ -54,11 +55,6 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
-static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
-{
-	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
-}
-
 static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
@@ -1328,6 +1324,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 			}
 		}
 		mutex_unlock(&pf->dplls.lock);
+
+		if (linkup)
+			ice_txclk_update_and_notify(pf);
 	}
 
 	switch (hw->mac_type) {
@@ -3073,6 +3072,7 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
+	u8 port_num, phy;
 
 	if (!ctrl_ptp) {
 		dev_info(ice_pf_to_dev(pf),
@@ -3090,6 +3090,10 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 		 &pf->adapter->ports.ports);
 	mutex_unlock(&pf->adapter->ports.lock);
 
+	port_num = ptp->port.port_num;
+	phy = port_num / pf->hw.ptp.ports_per_phy;
+	set_bit(port_num, &ctrl_ptp->tx_refclks[phy][pf->ptp.port.tx_clk]);
+
 	return 0;
 }
 
@@ -3290,6 +3294,7 @@ static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
  */
 void ice_ptp_init(struct ice_pf *pf)
 {
+	enum ice_e825c_ref_clk tx_ref_clk;
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
 	int err;
@@ -3318,6 +3323,17 @@ void ice_ptp_init(struct ice_pf *pf)
 			goto err_exit;
 	}
 
+	ptp->port.tx_clk = ICE_REF_CLK_ENET;
+	ptp->port.tx_clk_req = ICE_REF_CLK_ENET;
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+		err = ice_get_serdes_ref_sel_e825c(hw, ptp->port.port_num,
+						   &tx_ref_clk);
+		if (!err) {
+			ptp->port.tx_clk = tx_ref_clk;
+			ptp->port.tx_clk_req = tx_ref_clk;
+		}
+	}
+
 	err = ice_ptp_setup_pf(pf);
 	if (err)
 		goto err_exit;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8c44bd758a4f..8b385271ab36 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -144,6 +144,8 @@ struct ice_ptp_tx {
  * @link_up: indicates whether the link is up
  * @tx_fifo_busy_cnt: number of times the Tx FIFO was busy
  * @port_num: the port number this structure represents
+ * @tx_clk: currently active Tx reference clock source
+ * @tx_clk_req: requested Tx reference clock source (new target)
  */
 struct ice_ptp_port {
 	struct list_head list_node;
@@ -153,6 +155,8 @@ struct ice_ptp_port {
 	bool link_up;
 	u8 tx_fifo_busy_cnt;
 	u8 port_num;
+	enum ice_e825c_ref_clk tx_clk;
+	enum ice_e825c_ref_clk tx_clk_req;
 };
 
 enum ice_ptp_tx_interrupt {
@@ -236,6 +240,7 @@ struct ice_ptp_pin_desc {
  * @info: structure defining PTP hardware capabilities
  * @clock: pointer to registered PTP clock device
  * @tstamp_config: hardware timestamping configuration
+ * @tx_refclks: bitmaps table to store the information about TX reference clocks
  * @reset_time: kernel time after clock stop on reset
  * @tx_hwtstamp_good: number of completed Tx timestamp requests
  * @tx_hwtstamp_skipped: number of Tx time stamp requests skipped
@@ -261,6 +266,8 @@ struct ice_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct kernel_hwtstamp_config tstamp_config;
+#define ICE_E825_MAX_PHYS 2
+	unsigned long tx_refclks[ICE_E825_MAX_PHYS][ICE_REF_CLK_MAX];
 	u64 reset_time;
 	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 24fb7a3e14d6..f7f82aef9f40 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -486,6 +486,43 @@ static int ice_read_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 *val)
 	return err;
 }
 
+/**
+ * ice_get_serdes_ref_sel_e825c - Read current Tx ref clock source
+ * @hw: pointer to the HW struct
+ * @port: port number for which Tx reference clock is read
+ * @clk: Tx reference clock value (output)
+ *
+ * Return: 0 on success, other error codes when failed to read from PHY
+ */
+int ice_get_serdes_ref_sel_e825c(struct ice_hw *hw, u8 port,
+				 enum ice_e825c_ref_clk *clk)
+{
+	u8 lane = port % hw->ptp.ports_per_phy;
+	u32 serdes_rx_nt, serdes_tx_nt;
+	u32 val;
+	int ret;
+
+	ret = ice_read_phy_eth56g(hw, port,
+				  SERDES_IP_IF_LN_FLXM_GENERAL(lane, 0),
+				  &val);
+	if (ret)
+		return ret;
+
+	serdes_rx_nt = FIELD_GET(CFG_ICTL_PCS_REF_SEL_RX_NT, val);
+	serdes_tx_nt = FIELD_GET(CFG_ICTL_PCS_REF_SEL_TX_NT, val);
+
+	if (serdes_tx_nt == REF_SEL_NT_SYNCE &&
+	    serdes_rx_nt == REF_SEL_NT_SYNCE)
+		*clk = ICE_REF_CLK_SYNCE;
+	else if (serdes_tx_nt == REF_SEL_NT_EREF0 &&
+		 serdes_rx_nt == REF_SEL_NT_EREF0)
+		*clk = ICE_REF_CLK_EREF0;
+	else
+		*clk = ICE_REF_CLK_ENET;
+
+	return 0;
+}
+
 /**
  * ice_phy_res_address_eth56g - Calculate a PHY port register address
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 10795d023f44..31c44bc16b1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -383,6 +383,8 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
 int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port);
+int ice_get_serdes_ref_sel_e825c(struct ice_hw *hw, u8 port,
+				 enum ice_e825c_ref_clk *clk);
 
 #define ICE_ETH56G_NOMINAL_INCVAL	0x140000000ULL
 #define ICE_ETH56G_NOMINAL_PCS_REF_TUS	0x100000000ULL
@@ -795,4 +797,29 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define PHY_PTP_1STEP_PD_DELAY_M	GENMASK(30, 1)
 #define PHY_PTP_1STEP_PD_DLY_V_M	BIT(31)
 
+#define SERDES_IP_IF_LN_FLXM_GENERAL(n, m) \
+	(0x32B800 + (m) * 0x100000 + (n) * 0x8000)
+#define CFG_RESERVED0_1                         GENMASK(1, 0)
+#define CFG_ICTL_PCS_MODE_NT                    BIT(2)
+#define CFG_ICTL_PCS_RCOMP_SLAVE_EN_NT          BIT(3)
+#define CFG_ICTL_PCS_CMN_FORCE_PUP_A            BIT(4)
+#define CFG_ICTL_PCS_RCOMP_SLAVE_VALID_A        BIT(5)
+#define CFG_ICTL_PCS_REF_SEL_RX_NT              GENMASK(9, 6)
+#define REF_SEL_NT_ENET                         0
+#define REF_SEL_NT_EREF0                        1
+#define REF_SEL_NT_SYNCE                        2
+#define CFG_IDAT_DFX_OBS_DIG_                   GENMASK(11, 10)
+#define CFG_IRST_APB_MEM_B                      BIT(12)
+#define CFG_ICTL_PCS_DISCONNECT_NT              BIT(13)
+#define CFG_ICTL_PCS_ISOLATE_NT                 BIT(14)
+#define CFG_RESERVED15_15                       BIT(15)
+#define CFG_IRST_PCS_TSTBUS_B_A                 BIT(16)
+#define CFG_ICTL_PCS_REF_TERM_HIZ_EN_NT         BIT(17)
+#define CFG_RESERVED18_19                       GENMASK(19, 18)
+#define CFG_ICTL_PCS_SYNTHLCSLOW_FORCE_PUP_A    BIT(20)
+#define CFG_ICTL_PCS_SYNTHLCFAST_FORCE_PUP_A    BIT(21)
+#define CFG_RESERVED22_24                       GENMASK(24, 22)
+#define CFG_ICTL_PCS_REF_SEL_TX_NT              GENMASK(28, 25)
+#define CFG_RESERVED29_31                       GENMASK(31, 29)
+
 #endif /* _ICE_PTP_HW_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.c b/drivers/net/ethernet/intel/ice/ice_txclk.c
new file mode 100644
index 000000000000..7b3cf8fc399e
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_txclk.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026 Intel Corporation */
+
+#include "ice.h"
+#include "ice_cpi.h"
+#include "ice_txclk.h"
+
+#define ICE_PHY0	0
+#define ICE_PHY1	1
+
+/**
+ * ice_txclk_get_pin - map TX reference clock to its DPLL pin
+ * @pf: pointer to the PF structure
+ * @ref_clk: TX reference clock selection
+ *
+ * Return the DPLL pin corresponding to a given external TX reference
+ * clock. Only external TX reference clocks (SYNCE and EREF0) are
+ * represented as DPLL pins. The internal ENET (TXCO) clock has no
+ * associated DPLL pin and therefore yields %NULL.
+ *
+ * This helper is used when emitting DPLL pin change notifications
+ * after TX reference clock transitions have been verified.
+ *
+ * Return: Pointer to the corresponding struct dpll_pin, or %NULL if
+ *         the TX reference clock has no DPLL pin representation.
+ */
+static struct dpll_pin *
+ice_txclk_get_pin(struct ice_pf *pf, enum ice_e825c_ref_clk ref_clk)
+{
+	switch (ref_clk) {
+	case ICE_REF_CLK_SYNCE:
+		return pf->dplls.txclks[E825_EXT_SYNCE_PIN_IDX].pin;
+	case ICE_REF_CLK_EREF0:
+		return pf->dplls.txclks[E825_EXT_EREF_PIN_IDX].pin;
+	case ICE_REF_CLK_ENET:
+	default:
+		return NULL;
+	}
+}
+
+/**
+ * ice_txclk_enable_peer - Enable required TX reference clock on peer PHY
+ * @pf: pointer to the PF structure
+ * @clk: TX reference clock that must be enabled
+ *
+ * Some TX reference clocks on E825-class devices (SyncE and EREF0) must
+ * be enabled on both PHY complexes to allow proper routing:
+ *
+ *   - SyncE must be enabled on both PHYs when used by PHY0
+ *   - EREF0 must be enabled on both PHYs when used by PHY1
+ *
+ * If the requested clock is not yet enabled on the peer PHY, enable it.
+ * ENET does not require duplication and is ignored.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+static int ice_txclk_enable_peer(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+	bool peer_clk_in_use;
+	u8 port_num, phy;
+	int err;
+
+	if (clk == ICE_REF_CLK_ENET)
+		return 0;
+
+	if (IS_ERR_OR_NULL(ctrl_pf)) {
+		dev_err(ice_pf_to_dev(pf),
+			"Can't enable tx-clk on peer: no controlling PF\n");
+		return -EINVAL;
+	}
+
+	port_num = pf->ptp.port.port_num;
+	phy = port_num / pf->hw.ptp.ports_per_phy;
+	peer_clk_in_use = true;
+	mutex_lock(&ctrl_pf->dplls.lock);
+	if (clk == ICE_REF_CLK_SYNCE && phy == ICE_PHY0)
+		peer_clk_in_use = ice_txclk_any_port_uses(ctrl_pf,
+							  ICE_PHY1,
+							  clk);
+	else if (clk == ICE_REF_CLK_EREF0 && phy == ICE_PHY1)
+		peer_clk_in_use = ice_txclk_any_port_uses(ctrl_pf,
+							  ICE_PHY0,
+							  clk);
+	mutex_unlock(&ctrl_pf->dplls.lock);
+
+	if ((clk == ICE_REF_CLK_SYNCE && phy == ICE_PHY0 && !peer_clk_in_use) ||
+	    (clk == ICE_REF_CLK_EREF0 && phy == ICE_PHY1 && !peer_clk_in_use)) {
+		u8 peer_phy = phy ? ICE_PHY0 : ICE_PHY1;
+
+		err = ice_cpi_ena_dis_clk_ref(&pf->hw, peer_phy, clk, true);
+		if (err) {
+			dev_err(ice_hw_to_dev(&pf->hw),
+				"Failed to enable the %u TX clock for the %u PHY\n",
+				clk, peer_phy);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+#define ICE_REFCLK_USER_TO_AQ_IDX(x) ((x) + 1)
+
+/**
+ * ice_txclk_set_clk - Set Tx reference clock
+ * @pf: pointer to pf structure
+ * @clk: new Tx clock
+ *
+ * Return: 0 on success, negative value otherwise.
+ */
+int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
+{
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+	struct ice_port_info *port_info;
+	bool clk_in_use;
+	u8 port_num, phy;
+	int err;
+
+	if (pf->ptp.port.tx_clk == clk)
+		return 0;
+
+	if (IS_ERR_OR_NULL(ctrl_pf)) {
+		dev_err(ice_pf_to_dev(pf),
+			"Can't set tx-clk: no controlling PF\n");
+		return -EINVAL;
+	}
+
+	port_num = pf->ptp.port.port_num;
+	phy = port_num / pf->hw.ptp.ports_per_phy;
+	port_info = pf->hw.port_info;
+	mutex_lock(&ctrl_pf->dplls.lock);
+	clk_in_use = ice_txclk_any_port_uses(ctrl_pf, phy, clk);
+	mutex_unlock(&ctrl_pf->dplls.lock);
+
+	/* Check if the TX clk is enabled for this PHY, if not - enable it */
+	if (!clk_in_use) {
+		err = ice_cpi_ena_dis_clk_ref(&pf->hw, phy, clk, true);
+		if (err) {
+			dev_err(ice_pf_to_dev(pf), "Failed to enable the %u TX clock for the %u PHY\n",
+				clk, phy);
+			return err;
+		}
+		err = ice_txclk_enable_peer(pf, clk);
+		if (err)
+			return err;
+	}
+
+	/* We are ready to switch to the new TX clk. */
+	err = ice_aq_set_link_restart_an(port_info, true, NULL,
+					 ICE_REFCLK_USER_TO_AQ_IDX(clk));
+	if (err)
+		dev_err(ice_pf_to_dev(pf),
+			"AN restart AQ command failed with err %d\n",
+			err);
+
+	return err;
+}
+
+/**
+ * ice_txclk_update_and_notify - Validate TX reference clock switching
+ * @pf: pointer to PF structure
+ *
+ * After a link-up event, verify whether the previously requested TX reference
+ * clock transition actually succeeded. The SERDES reference selector reflects
+ * the effective hardware choice, which may differ from the requested clock
+ * when Auto-Negotiation or firmware applies additional policy.
+ *
+ * If the hardware-selected clock differs from the requested one, update the
+ * software state accordingly and stop further processing.
+ *
+ * When the switch is successful, update the per‑PHY usage bitmaps so that the
+ * driver knows which reference clock is currently in use by this port.
+ *
+ * This function does not initiate a clock switch; it only validates the result
+ * of a previously triggered transition and performs cleanup of unused clocks.
+ */
+void ice_txclk_update_and_notify(struct ice_pf *pf)
+{
+	struct ice_ptp_port *ptp_port = &pf->ptp.port;
+	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
+	struct dpll_pin *old_pin = NULL;
+	struct dpll_pin *new_pin = NULL;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_e825c_ref_clk clk;
+	int err;
+	u8 phy;
+
+	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
+
+	mutex_lock(&pf->dplls.lock);
+	/* Bail out if DPLL subsystem is being torn down. ice_dpll_deinit()
+	 * clears ICE_FLAG_DPLL before freeing pins and the dpll device, so a
+	 * cleared flag under the lock means those objects can no longer be
+	 * safely dereferenced.
+	 */
+	if (!test_bit(ICE_FLAG_DPLL, pf->flags)) {
+		mutex_unlock(&pf->dplls.lock);
+		return;
+	}
+	/* If a switch is still pending, the link-up event preceded the
+	 * worker's AN restart. Hardware hasn't applied the new clock yet,
+	 * so reading the SERDES selector now would produce a false failure.
+	 * Let the worker run first; the link-up that follows the AN restart
+	 * will trigger the verification.
+	 */
+	if (pf->dplls.txclk_switch_requested) {
+		mutex_unlock(&pf->dplls.lock);
+		return;
+	}
+	/* no TX clock change requested */
+	if (pf->ptp.port.tx_clk == pf->ptp.port.tx_clk_req) {
+		mutex_unlock(&pf->dplls.lock);
+		return;
+	}
+	/* verify current Tx reference settings */
+	err = ice_get_serdes_ref_sel_e825c(hw,
+					   ptp_port->port_num,
+					   &clk);
+	if (err) {
+		mutex_unlock(&pf->dplls.lock);
+		return;
+	}
+
+	if (clk != pf->ptp.port.tx_clk_req) {
+		dev_warn(ice_pf_to_dev(pf),
+			 "Failed to switch tx-clk for phy %d and clk %u (current: %u)\n",
+			 phy, pf->ptp.port.tx_clk_req, clk);
+		old_pin = ice_txclk_get_pin(pf, pf->ptp.port.tx_clk_req);
+		new_pin = ice_txclk_get_pin(pf, clk);
+		pf->ptp.port.tx_clk = clk;
+		pf->ptp.port.tx_clk_req = clk;
+		/* Update the reference clock bitmap to match the hardware
+		 * clock that was actually accepted, so that
+		 * ice_txclk_any_port_uses() reflects reality even on failure.
+		 */
+		if (!IS_ERR_OR_NULL(ctrl_pf))
+			for (int i = 0; i < ICE_REF_CLK_MAX; i++)
+				(clk == i) ?
+				 set_bit(ptp_port->port_num,
+					 &ctrl_pf->ptp.tx_refclks[phy][i]) :
+				 clear_bit(ptp_port->port_num,
+					   &ctrl_pf->ptp.tx_refclks[phy][i]);
+		goto err_notify;
+	}
+
+	old_pin = ice_txclk_get_pin(pf, pf->ptp.port.tx_clk);
+	pf->ptp.port.tx_clk = clk;
+	pf->ptp.port.tx_clk_req = clk;
+
+	if (IS_ERR_OR_NULL(ctrl_pf)) {
+		dev_err(ice_pf_to_dev(pf),
+			"Can't set tx-clk: no controlling PF\n");
+		goto err_notify;
+	}
+
+	/* update Tx reference clock usage map */
+	for (int i = 0; i < ICE_REF_CLK_MAX; i++)
+		(clk == i) ?
+		 set_bit(ptp_port->port_num,
+			 &ctrl_pf->ptp.tx_refclks[phy][i]) :
+		 clear_bit(ptp_port->port_num,
+			   &ctrl_pf->ptp.tx_refclks[phy][i]);
+
+err_notify:
+	/* Update TXC DPLL lock status based on effective TX clk, while still
+	 * holding the lock to prevent concurrent link-up events from racing
+	 * on dpll_state.
+	 */
+	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll)) {
+		enum dpll_lock_status new_lock = ice_txclk_lock_status(clk);
+
+		if (pf->dplls.txc.dpll_state != new_lock)
+			pf->dplls.txc.dpll_state = new_lock;
+		else
+			/* No change; suppress the notification below */
+			pf->dplls.txc.dpll = ERR_PTR(-ENODEV);
+	}
+	mutex_unlock(&pf->dplls.lock);
+
+	/* Notify TX clk pins state transition */
+	if (old_pin)
+		dpll_pin_change_ntf(old_pin);
+	if (new_pin)
+		dpll_pin_change_ntf(new_pin);
+
+	if (!IS_ERR_OR_NULL(pf->dplls.txc.dpll))
+		dpll_device_change_ntf(pf->dplls.txc.dpll);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_txclk.h b/drivers/net/ethernet/intel/ice/ice_txclk.h
new file mode 100644
index 000000000000..bdf591ea8f14
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_txclk.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2026 Intel Corporation */
+
+#ifndef _ICE_TXCLK_H_
+#define _ICE_TXCLK_H_
+
+/**
+ * ice_txclk_any_port_uses - check if any port on a PHY uses this TX refclk
+ * @ctrl_pf: control PF (owner of the shared tx_refclks map)
+ * @phy: PHY index
+ * @clk: TX reference clock
+ *
+ * Return: true if any bit (port) is set for this clock on this PHY
+ */
+static inline bool
+ice_txclk_any_port_uses(const struct ice_pf *ctrl_pf, u8 phy,
+			enum ice_e825c_ref_clk clk)
+{
+	return find_first_bit(&ctrl_pf->ptp.tx_refclks[phy][clk],
+			BITS_PER_LONG) < BITS_PER_LONG;
+}
+
+static inline enum dpll_lock_status
+ice_txclk_lock_status(enum ice_e825c_ref_clk clk)
+{
+	switch (clk) {
+	case ICE_REF_CLK_SYNCE:
+	case ICE_REF_CLK_EREF0:
+		return DPLL_LOCK_STATUS_LOCKED;
+	case ICE_REF_CLK_ENET:
+	default:
+		return DPLL_LOCK_STATUS_UNLOCKED;
+	}
+}
+
+int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk);
+void ice_txclk_update_and_notify(struct ice_pf *pf);
+#endif /* _ICE_TXCLK_H_ */
-- 
2.39.3


