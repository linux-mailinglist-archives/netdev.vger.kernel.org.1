Return-Path: <netdev+bounces-31180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD978C269
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A109280FC6
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61314F9A;
	Tue, 29 Aug 2023 10:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3C14F98
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:40:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648271A2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693305656; x=1724841656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vziGEKQkhvglUca+VEBOArAjk5lf9uAfNsCF1T+Ik5I=;
  b=dcFyshCKm9He6f2f9DRbu6XwatxISRrQkISekXfgQxwoG6GBnfg1Bg+c
   S3W2cw1sMj7N3/0Xwf4Wcj6yearjdFqHgZR8lAM9F4JkwQM9+Esp7ZYeH
   m3qK/IWEy+z88Ag5Fs45MNnI/nmi6CyFXLMBsUrxlqu0C29uMLU75TV/Q
   3DhoJMDFZiAwyWnm2yg6+ZQoPl00qjja9t/8To2z43WsFSbebM+t+ANVL
   TLUp89n825Qky/G8nAgfTPiz4u5LLOjppVVbvd8NdAf1AO/DBKXLD548T
   AX+ar0zEMGSlBH4+WIqOXJLI0QMp2xk3ZP3UygzU3JUAsaVIpwax0JWgk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696872"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461696872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 03:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229755"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853229755"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:40:54 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 01/11] ice: use ice_pf_src_tmr_owned where available
Date: Tue, 29 Aug 2023 12:40:31 +0200
Message-Id: <20230829104041.64131-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829104041.64131-1-karol.kolacinski@intel.com>
References: <20230829104041.64131-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

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
index a5997008bb98..8f327ad5b569 100644
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
index ca40ca220cc9..2e3f0aaacddd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2449,7 +2449,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		goto pfr;
 
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
+	if (!ice_pf_src_tmr_owned(pf))
 		goto reset_ts;
 
 	err = ice_ptp_init_phc(hw);
-- 
2.39.2


