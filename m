Return-Path: <netdev+bounces-53035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0AA801240
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A4CB20F3A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5C4F212;
	Fri,  1 Dec 2023 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2L0ExV0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA348128
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454138; x=1732990138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFkj0Y5LcVVEWpeFn9a/9EfxjCqiubjt85hFKiNv8/o=;
  b=F2L0ExV0ICEVPyNaS476UG5NLfM4YUnI2hlnKBPrN2eHAY7sen6k3Xz4
   Hc4sa201vepf4Tl8Zvm4/xS9ARAcUFUw7orKxW6ltOCaOkNjorVyBxc2U
   GoeSPWOQoE+g35pFeLs+ZQLB54uiGaKsZfBdGt3NWDRkE/rnkTTn07JS7
   V3f3/oTZDenPfPYVQuXPTedWJlUQH7lKqAVnXUdqeiGxeqFxtgmx0tfg+
   +xKefppCwxUth9arfM/prU98Gzvh+l2+DA7LXDxIld2wM4o539CVbtyzU
   7PXJTAGpTzNjpo9r0YJIzh57bguWCHwQPn89JLqvhPN8ZycunTQfIltdy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244404"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244404"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272447"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272447"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/6] ice: Re-enable timestamping correctly after reset
Date: Fri,  1 Dec 2023 10:08:42 -0800
Message-ID: <20231201180845.219494-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

During reset, TX_TSYN interrupt should be processed as it may process
timestamps in brief moments before and after reset.
Timestamping should be enabled on VSIs at the end of reset procedure.
On ice_get_phy_tx_tstamp_ready error, interrupt should not be rearmed
because error only happens on resets.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b8ad414dac47..84d5dec06252 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3151,7 +3151,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (!hw->reset_ongoing && ice_ptp_pf_handles_tx_interrupt(pf))
+		if (ice_ptp_pf_handles_tx_interrupt(pf))
 			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 71f405f8a6fe..ac3f24693a50 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -705,7 +705,9 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 
 		/* Read the Tx ready status first */
 		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
-		if (err || tstamp_ready)
+		if (err)
+			break;
+		else if (tstamp_ready)
 			return ICE_TX_TSTAMP_WORK_PENDING;
 	}
 
@@ -2468,12 +2470,10 @@ void ice_ptp_reset(struct ice_pf *pf)
 	int err, itr = 1;
 	u64 time_diff;
 
-	if (test_bit(ICE_PFR_REQ, pf->state))
+	if (test_bit(ICE_PFR_REQ, pf->state) ||
+	    !ice_pf_src_tmr_owned(pf))
 		goto pfr;
 
-	if (!ice_pf_src_tmr_owned(pf))
-		goto reset_ts;
-
 	err = ice_ptp_init_phc(hw);
 	if (err)
 		goto err;
@@ -2517,10 +2517,6 @@ void ice_ptp_reset(struct ice_pf *pf)
 			goto err;
 	}
 
-reset_ts:
-	/* Restart the PHY timestamping block */
-	ice_ptp_reset_phy_timestamping(pf);
-
 pfr:
 	/* Init Tx structures */
 	if (ice_is_e810(&pf->hw)) {
@@ -2536,6 +2532,11 @@ void ice_ptp_reset(struct ice_pf *pf)
 
 	set_bit(ICE_FLAG_PTP, pf->flags);
 
+	/* Restart the PHY timestamping block */
+	if (!test_bit(ICE_PFR_REQ, pf->state) &&
+	    ice_pf_src_tmr_owned(pf))
+		ice_ptp_restart_all_phy(pf);
+
 	/* Start periodic work going */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
-- 
2.41.0


