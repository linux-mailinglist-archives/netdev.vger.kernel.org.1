Return-Path: <netdev+bounces-52131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF67FD6F7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473A61C2085A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7178D1B287;
	Wed, 29 Nov 2023 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsN2l+Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7A170B
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701261634; x=1732797634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hzlS8rjjfsl0XfkEJaCGalHUNG7PIYHXNph5mBbsEaw=;
  b=GsN2l+PsH06/auo7GpNa6v8jkF6puyrSMfessj5DqEwuZfKdL9PMgs3k
   6Pk4FYBL7+zQB3DUqS1tzUUg0iRElmArZU0gdrNwOUluLVRzTWN0sTiC8
   toWX0JftUmOiA/kAAFmnZk6v57ObJzuinsxqEw9C95g/Cnha6HG//gCGR
   M/QxkFYcuXBFB8Q02PpjKNtkBgQ+A7mXG2qpOyrTX2K3ldOoFBa6fI2Xx
   5fnFCdwFk08UcEYJ/U1zvtEYU+ZJpEl4LhbCjAgz0SroGPEpqm8PAFSAT
   MnLG93GcwWMn1ZWLftnMMo8y918T3XJhOURy3f668VQKdYNBG4G/uqME/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479355438"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479355438"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 04:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="772669824"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="772669824"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2023 04:40:32 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH v2 iwl-next 1/2] ice: Schedule service task in IRQ top half
Date: Wed, 29 Nov 2023 13:40:22 +0100
Message-Id: <20231129124023.741299-1-karol.kolacinski@intel.com>
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Added missing opening curly brace

 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

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
index c7c6ec3e131b..d209826be2c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3066,6 +3066,7 @@ static void ice_ena_misc_vector(struct ice_pf *pf)
 static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 {
 	struct ice_pf *pf = (struct ice_pf *)data;
+	irqreturn_t ret = IRQ_HANDLED;
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	u32 oicr, ena_mask;
@@ -3147,8 +3148,10 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (ice_ptp_pf_handles_tx_interrupt(pf))
+		if (ice_ptp_pf_handles_tx_interrupt(pf)) {
 			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
+			ret = IRQ_WAKE_THREAD;
+		}
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
@@ -3164,7 +3167,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 					       GLTSYN_STAT_EVENT1_M |
 					       GLTSYN_STAT_EVENT2_M);
 
-			set_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread);
+			ice_ptp_extts_event(pf);
 		}
 	}
 
@@ -3187,8 +3190,11 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
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
@@ -3204,12 +3210,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
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
@@ -3221,6 +3222,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 		}
 	}
 
+skip_irq:
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 
 	return IRQ_HANDLED;

base-commit: a1c79fa9e5cd3288ecb4019692a4d3ccbf7d2370
-- 
2.40.1


