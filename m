Return-Path: <netdev+bounces-34821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B67A5512
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6691281F1C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5330FA3;
	Mon, 18 Sep 2023 21:28:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335B28E3C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8208E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072528; x=1726608528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDT2d0XTt/djZM4qF1alnrxtlI1+4H294yBp8Pqe410=;
  b=Pcsm0zGX4z/fQ9B2g+h3rUv4Ru+erK5sEIF/r0tEge4nqLN3OdIT+B2W
   xXkwEWOA1KLLTvmuSyO3feoW9YHEPHwkMzjQxsO8YMakOGUpyK7Rh2GZC
   8PunrB1pRs0hPhgZylvTuRnSpwH+4bE00Dw5dUw9hSh2i8uzTxiGC7sdM
   /CmovTLIv2TDvF/lsZgHsnsM9FurRrBV+7sYXWrJ7nBKuUfsRHdyjIy72
   n20MDtHat3tGVW52bK7Oqj0H2Yq8dT9pVZ3gd3EWFaj4THOQqalN64QN2
   oY07Rcl6bqbDKV9oCy/EgnUMx6VWEltKIkQgdTCr4LjggAbarUq6ALHty
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187286"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187286"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186238"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186238"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next v2 10/11] ice: introduce ice_pf_src_tmr_owned
Date: Mon, 18 Sep 2023 14:28:13 -0700
Message-Id: <20230918212814.435688-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

Add ice_pf_src_tmr_owned() macro to check the function capability bit
indicating if the current function owns the PTP hardware clock. This is
slightly shorter than the more verbose access via
hw.func_caps.ts_func_info.src_tmr_owned. Use this where possible rather
than open coding its equivalent.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 6 +++---
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 04665aff2234..d30ae39c19f0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -196,6 +196,8 @@
 
 #define ice_pf_to_dev(pf) (&((pf)->pdev->dev))
 
+#define ice_pf_src_tmr_owned(pf) ((pf)->hw.func_caps.ts_func_info.src_tmr_owned)
+
 enum ice_feature {
 	ICE_F_DSCP,
 	ICE_F_PHY_RCLK,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 382196486054..1549890a3cbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3992,7 +3992,7 @@ void ice_init_feature_support(struct ice_pf *pf)
 		if (ice_is_phy_rclk_present(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_PHY_RCLK);
 		/* If we don't own the timer - don't enable other caps */
-		if (!pf->hw.func_caps.ts_func_info.src_tmr_owned)
+		if (!ice_pf_src_tmr_owned(pf))
 			break;
 		if (ice_is_cgu_present(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_CGU);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b73d3b1e48d1..e22f41fea8db 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3159,7 +3159,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 		ena_mask &= ~PFINT_OICR_TSYN_EVNT_M;
 
-		if (hw->func_caps.ts_func_info.src_tmr_owned) {
+		if (ice_pf_src_tmr_owned(pf)) {
 			/* Save EVENTs from GLTSYN register */
 			pf->ptp.ext_ts_irq |= gltsyn_stat &
 					      (GLTSYN_STAT_EVENT0_M |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7ae1f1abe965..05f922d3b316 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -436,7 +436,7 @@ static void ice_clear_ptp_clock_index(struct ice_pf *pf)
 	int err;
 
 	/* Do not clear the index if we don't own the timer */
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+	if (!ice_pf_src_tmr_owned(pf))
 		return;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
@@ -2499,7 +2499,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		goto pfr;
 
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+	if (!ice_pf_src_tmr_owned(pf))
 		goto reset_ts;
 
 	err = ice_ptp_init_phc(hw);
@@ -2751,7 +2751,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
-	if (hw->func_caps.ts_func_info.src_tmr_owned) {
+	if (ice_pf_src_tmr_owned(pf)) {
 		err = ice_ptp_init_owner(pf);
 		if (err)
 			goto err;
-- 
2.38.1


