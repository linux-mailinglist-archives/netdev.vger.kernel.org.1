Return-Path: <netdev+bounces-293634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D3HHoxQHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:27:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34DD61C68A
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97FE130A6A15
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC54390609;
	Mon,  1 Jun 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqEZ1Skj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACA38F65C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305596; cv=none; b=bGpTlLVMapyP4Zh07vwyYLqnztdOw+ekmS4jxv3ZMCyVa/wlNTc5v4w0soIBlzIpaPHh0qgcfyfwAQT6jNazDRHutYtfmzOcBKZInXAD/+qs/dVToSeWjc0BktgBaZIs1aBPhx2KSgxxAYdSSiUCZARK6b9ek8dqYYT6ZA8F8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305596; c=relaxed/simple;
	bh=TUxNBLwkxSJH2CWH5dBiAkp2SEN2WXnHaTocnBh2WtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA6SD6O9a29SLwvpsksC17Q+MZVO4hRix+1GZ7F1+Ax+W07SoK1Cw0xZh5y6hku2OJ69DT96ThH4rh0WiUAYsEsLiJxzs10dsfQRQ+e2fxSOaFWp7HhCDJc1hEGguc0e2bKj3XaLGbCVKV7bLpG7IeFL8q08wm3ICoPu4B8saK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqEZ1Skj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305595; x=1811841595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUxNBLwkxSJH2CWH5dBiAkp2SEN2WXnHaTocnBh2WtE=;
  b=BqEZ1Skjwxlkl9fpvkWHkzyyPrmKrPMMF9eFQEgbMb2P7VDzRW5Jrp8G
   iHqq9Tjfs7lRb1psKW95zCVbTOe1NQLHGZi1AQgk7o7U0gKpVAjxQCVXF
   SuseLar3xZcPMlqiPCEVuAHM7snAcz+b0SFXmEAvuY84Ktn2X7bTyPX/j
   ZrJ578nw4nl6LpxFcdBBttFjZAS2kywwwMFdCRrzf3+Rd1lUedumrbcIT
   x5pEfOP1FoaOk/ui+u8P+Lw2AlBxNEaFcRVx2CgsL9kqKBDK/bLcsqQkS
   LgB4LLp7f/1n0aV1xwvQhfDN90nold49h6EHtGvcSWpD/nnBm93OSVluT
   Q==;
X-CSE-ConnectionGUID: KXsLSuJXQeuBT7+tLAL1Aw==
X-CSE-MsgGUID: 0VsE2gEuS46HSFxjEcuypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80791623"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80791623"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:54 -0700
X-CSE-ConnectionGUID: UKyyR9z4QAS1LxJpt1evMw==
X-CSE-MsgGUID: nlzAprn2ShCWRDiP07JD/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247802570"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa004.jf.intel.com with ESMTP; 01 Jun 2026 02:19:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 1/3] ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
Date: Mon,  1 Jun 2026 09:19:49 +0000
Message-ID: <20260601091951.3017848-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
References: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Queue-Id: D34DD61C68A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use RCU to ensure the consistent state of the control PF global
pointer contained in struct ice_adapter. Enforce RCU usage on
the callers.

Fix a potential invalid pointer return due a TOCTOU issue

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 10 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 99 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  9 ++
 4 files changed, 84 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f9a43daf04fe..c4ae5f9e095c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -40,6 +40,7 @@
 #include <linux/cpu_rmap.h>
 #include <linux/dim.h>
 #include <linux/gnss.h>
+#include <linux/rcupdate.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tc_act/tc_mirred.h>
@@ -1160,14 +1161,19 @@ static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
  * ice_get_primary_hw - Get pointer to primary ice_hw structure
  * @pf: pointer to PF structure
  *
+ * The function must be called from an RCU read-side critical section.
+ * hw is embedded in struct ice_pf, so it is protected by the RCU.
+ *
  * Return: A pointer to ice_hw structure with access to timesync
  * register space.
  */
 static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
 {
-	if (!pf->adapter->ctrl_pf)
+	struct ice_pf *ctrl_pf = rcu_dereference(pf->adapter->ctrl_pf);
+
+	if (!ctrl_pf)
 		return &pf->hw;
 	else
-		return &pf->adapter->ctrl_pf->hw;
+		return &ctrl_pf->hw;
 }
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e95266c7f20b..349d49d57f11 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -42,7 +42,7 @@ struct ice_adapter {
 	/* For access to GLCOMM_QTX_CNTX_CTL register */
 	spinlock_t txq_ctx_lock;
 
-	struct ice_pf *ctrl_pf;
+	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
 	u64 index;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 07e621813ff5..348fc73607b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/rcupdate.h>
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
@@ -54,11 +55,35 @@ static const struct ice_ptp_pin_desc ice_pin_desc_dpll[] = {
 	{  SDP3, {  3, -1 }, { 0, 0 }},
 };
 
+/**
+ * ice_get_ctrl_pf - Get the control PF for a given PF
+ * @pf: The PF pointer to look up at
+ *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section.
+ *
+ * Return: Pointer to the control PF, or NULL if not found
+ */
 static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 {
-	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
+	return !pf->adapter ? NULL : rcu_dereference(pf->adapter->ctrl_pf);
 }
 
+/**
+ * ice_get_ctrl_ptp - Get the PTP structure for the control PF
+ * @pf: The PF pointer to look up at
+ *
+ * The control PF is the PF which owns the PTP clock for the adapter.
+ * Only the control PF is allowed to perform certain operations on the
+ * PTP clock such as adjusting the time or configuring the pins.
+ *
+ * This function must be called from an RCU read-side critical section.
+ *
+ * Return: Pointer to the PTP structure of the control PF, or NULL if not found
+ */
 static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
@@ -207,39 +232,42 @@ u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	u32 hi, lo, lo2;
 	u8 tmr_idx;
 
-	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
-
-	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
-	/* Read the system timestamp pre PHC read */
-	ptp_read_system_prets(sts);
-
-	if (hw->mac_type == ICE_MAC_E830) {
-		u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
+	scoped_guard(rcu) {
+		if (!ice_is_primary(hw))
+			hw = ice_get_primary_hw(pf);
 
-		/* Read the system timestamp post PHC read */
-		ptp_read_system_postts(sts);
-
-		return clk_time;
-	}
+		tmr_idx = ice_get_ptp_src_clock_index(hw);
+		guard(spinlock)(&pf->adapter->ptp_gltsyn_time_lock);
+		/* Read the system timestamp pre PHC read */
+		ptp_read_system_prets(sts);
 
-	lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+		if (hw->mac_type == ICE_MAC_E830) {
+			u64 clk_time = rd64(hw, E830_GLTSYN_TIME_L(tmr_idx));
 
-	/* Read the system timestamp post PHC read */
-	ptp_read_system_postts(sts);
+			/* Read the system timestamp post PHC read */
+			ptp_read_system_postts(sts);
 
-	hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
-	lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			return clk_time;
+		}
 
-	if (lo2 < lo) {
-		/* if TIME_L rolled over read TIME_L again and update
-		 * system timestamps
-		 */
-		ptp_read_system_prets(sts);
 		lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		/* Read the system timestamp post PHC read */
 		ptp_read_system_postts(sts);
+
 		hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		lo2 = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+
+		if (lo2 < lo) {
+			/* if TIME_L rolled over read TIME_L again and update
+			 * system timestamps
+			 */
+			ptp_read_system_prets(sts);
+			lo = rd32(hw, GLTSYN_TIME_L(tmr_idx));
+			ptp_read_system_postts(sts);
+			hi = rd32(hw, GLTSYN_TIME_H(tmr_idx));
+		}
+
 	}
 
 	return ((u64)hi << 32) | lo;
@@ -3076,18 +3104,19 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static void ice_ptp_setup_adapter(struct ice_pf *pf)
 {
-	pf->adapter->ctrl_pf = pf;
+	rcu_assign_pointer(pf->adapter->ctrl_pf, pf);
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (!ctrl_ptp) {
-		dev_info(ice_pf_to_dev(pf),
-			 "PTP unavailable: no controlling PF\n");
-		return -EOPNOTSUPP;
+	scoped_guard(rcu) {
+		if (!ice_get_ctrl_ptp(pf)) {
+			dev_info(ice_pf_to_dev(pf),
+				 "PTP unavailable: no controlling PF\n");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	if (pf->hw.mac_type == ICE_MAC_UNKNOWN)
@@ -3123,11 +3152,15 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ctrl_ptp;
 	struct ptp_clock *clock;
 
+	guard(rcu)();
+
+	ctrl_ptp = ice_get_ctrl_ptp(pf);
 	if (!ctrl_ptp)
 		return -1;
+
 	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 40181431f4ca..9ea72d5f59cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include "ice_common.h"
@@ -351,6 +352,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
 	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -383,6 +386,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 			dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
 	}
 
+	guard(rcu)();
+
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
 
@@ -1952,6 +1957,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
 	}
@@ -2121,6 +2128,8 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		guard(rcu)();
+
 		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
 	}
-- 
2.53.0


