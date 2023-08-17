Return-Path: <netdev+bounces-28473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16F77F890
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC7D1C21033
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162A14F6C;
	Thu, 17 Aug 2023 14:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652514F6B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:18:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13B2D79
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692281896; x=1723817896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tigtovoxJ2ym3wDfkrnlqPh0llOAfxHW66RA5eLSXgw=;
  b=bwXRDkHnmsopiVDioka2r0QvwkUwpJUf6C8Jx+s5K1q7pMW8u7dNerMl
   vv6MywNA1RmZMzWjviRXxSlraesrkfdLTOlS+NDVtEDIBuytpo7zrCiqa
   c8bN2xQuXkB4W1rwlQ5svk+dtHdKcbv6bdMPMp+A73vPSRilicD6aOu0p
   LzaSrolPR33XcEaHfCCh49owBQfVzsy4CcotBLU5btvgzLzuQqX/3bopC
   2oh/j7xtZPSTUXif3Umvkf1ujmMdr6ij8+DDaXcBQHz/a+ePeD00Pq7oJ
   NXWDR6SlDsjJ/J2oIn/C/J5ozR12O70Ggpk1hXwjlXpcLkeoQRUw+hVGJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403804192"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403804192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981189668"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981189668"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 07:18:13 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 iwl-next 1/9] ice: use ice_pf_src_tmr_owned where available
Date: Thu, 17 Aug 2023 16:17:38 +0200
Message-Id: <20230817141746.18726-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817141746.18726-1-karol.kolacinski@intel.com>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ice_pf_src_tmr_owned() macro exists to check the function capability
bit indicating if the current function owns the PTP hardware clock.

This is slightly shorter than the more verbose access via
hw.func_caps.ts_func_info.src_tmr_owned. Be consistent and use this
where possible rather than open coding its equivalent.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a6dd336d2500..b6858f04152c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3185,7 +3185,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 		ena_mask &= ~PFINT_OICR_TSYN_EVNT_M;
 
-		if (hw->func_caps.ts_func_info.src_tmr_owned) {
+		if (ice_pf_src_tmr_owned(pf)) {
 			/* Save EVENTs from GLTSYN register */
 			pf->ptp.ext_ts_irq |= gltsyn_stat &
 					      (GLTSYN_STAT_EVENT0_M |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 97b8581ae931..0669ca905c46 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2447,7 +2447,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		goto pfr;
 
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+	if (!ice_pf_src_tmr_owned(pf))
 		goto reset_ts;
 
 	err = ice_ptp_init_phc(hw);
-- 
2.39.2


