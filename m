Return-Path: <netdev+bounces-50801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103087F72F5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073E11C20988
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DB1DDD7;
	Fri, 24 Nov 2023 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTZdSBbH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183141A5
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700826170; x=1732362170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+muN5zrCCVIk49U1qjvrc+4QLuRjzbV2Q0im5dypsMQ=;
  b=WTZdSBbH9SatHPo/pdL4Mbp2nXgr2PL7/U79fTjznngium2R6nmPwZ+t
   EcHeDzztLaZ321YKb7F6AVmUOkt149yCUG1OTZYJPUIP3UaIQSkv7J7Jf
   r5Rgfyl56Ast2EPUv4kOdOFZZYUP6S7+by7pIVVZzeOR0n5CrKJ8kwd1i
   1fsCCIKlCIEkf3HgXv4htqsIdadWgaF4fGlfx1x34ymU4SavFBgBGy1P4
   bPYs2wxofEcHsDWlBqv2spbXJA3iXuj8/LEY29dVx17oQss5iCXkQcurp
   EraYvBIVqmYaVdVOKBmte9WXHx2nG4t1jd7cpoPtn3WWiKWclbxUolIZ7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458898753"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="458898753"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="891047097"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="891047097"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2023 03:42:47 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH iwl-next 1/2] ice: Schedule service task in IRQ top half
Date: Fri, 24 Nov 2023 12:41:54 +0100
Message-Id: <20231124114155.251360-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Schedule service task and EXTTS in the top half to avoid bottom half
scheduling if possible, which significantly reduces timestamping delay.

Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3ea33947b878..d5a8da0c02c3 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -517,7 +517,6 @@ enum ice_pf_flags {
 };
 
 enum ice_misc_thread_tasks {
-	ICE_MISC_THREAD_EXTTS_EVENT,
 	ICE_MISC_THREAD_TX_TSTAMP,
 	ICE_MISC_THREAD_NBITS		/* must be last */
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1f159b4362ec..6b91ec6f420d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3078,6 +3078,7 @@ static void ice_ena_misc_vector(struct ice_pf *pf)
 static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 {
 	struct ice_pf *pf = (struct ice_pf *)data;
+	irqreturn_t ret = IRQ_HANDLED;
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	u32 oicr, ena_mask;
@@ -3161,6 +3162,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
 		if (ice_ptp_pf_handles_tx_interrupt(pf))
 			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
+			ret = IRQ_WAKE_THREAD;
+		}
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
@@ -3176,7 +3179,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 					       GLTSYN_STAT_EVENT1_M |
 					       GLTSYN_STAT_EVENT2_M);
 
-			set_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread);
+			ice_ptp_extts_event(pf);
 		}
 	}
 
@@ -3199,8 +3202,11 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 			set_bit(ICE_PFR_REQ, pf->state);
 		}
 	}
+	ice_service_task_schedule(pf);
+	if (ret == IRQ_HANDLED)
+		ice_irq_dynamic_ena(hw, NULL, NULL);
 
-	return IRQ_WAKE_THREAD;
+	return ret;
 }
 
 /**
@@ -3216,12 +3222,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	hw = &pf->hw;
 
 	if (ice_is_reset_in_progress(pf->state))
-		return IRQ_HANDLED;
-
-	ice_service_task_schedule(pf);
-
-	if (test_and_clear_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread))
-		ice_ptp_extts_event(pf);
+		goto skip_irq;
 
 	if (test_and_clear_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread)) {
 		/* Process outstanding Tx timestamps. If there is more work,
@@ -3233,6 +3234,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 		}
 	}
 
+skip_irq:
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 
 	return IRQ_HANDLED;

base-commit: 2f5380161e527b085e3a0b1c4898810ef35d4240
-- 
2.40.1


