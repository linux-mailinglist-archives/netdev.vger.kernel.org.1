Return-Path: <netdev+bounces-61029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8F1822480
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E141C22D3E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C0817727;
	Tue,  2 Jan 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJPB7JqD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70811171A3
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233078; x=1735769078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQX0CgIqqPppQGffRuKL83XbfTG+i1fBNeWY4ziW5xs=;
  b=kJPB7JqDiCbokrGebANC01jgVTqhzOi5BaX4Q0/mQk7TJfFw3ywDQdov
   tz6uPUmUPooTD+l5HZv+XvvMQUtMaoarRM/Cwci2sw+9M7Ju/ZTlan9Ds
   k8kYN+9BPldJGnHNMrKUjHuiS/Yz7JECfLsrL+dGD7ZyA6K1eJP/5qTpn
   4zEFYcPp4+Qewk9qaaKHqcX1WTF87pr+j/iiE99fR65uueQdTmmLGl0qN
   lp5tikEvOjpWcqTXg04DP9F4b3sqs/1ZrbqDiAbPyj9YhionbOdJP04p+
   om70vet9BBhZ9IRSuqgw4dZGiP1xGgynjE47/4r2DkMQ1PYuN2vmebaKn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567872"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621400"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621400"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:35 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Michal Michalik <michal.michalik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/7] ice: Schedule service task in IRQ top half
Date: Tue,  2 Jan 2024 14:04:17 -0800
Message-ID: <20240102220428.698969-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Schedule service task and EXTTS in the top half to avoid bottom half
scheduling if possible, which significantly reduces timestamping delay.

Co-developed-by: Michal Michalik <michal.michalik@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c | 20 +++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2defac6d9168..30816dce76cf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -518,7 +518,6 @@ enum ice_pf_flags {
 };
 
 enum ice_misc_thread_tasks {
-	ICE_MISC_THREAD_EXTTS_EVENT,
 	ICE_MISC_THREAD_TX_TSTAMP,
 	ICE_MISC_THREAD_NBITS		/* must be last */
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d460d4231b1d..85004bb2dfe3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3084,6 +3084,7 @@ static void ice_ena_misc_vector(struct ice_pf *pf)
 static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 {
 	struct ice_pf *pf = (struct ice_pf *)data;
+	irqreturn_t ret = IRQ_HANDLED;
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	u32 oicr, ena_mask;
@@ -3165,8 +3166,10 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (ice_ptp_pf_handles_tx_interrupt(pf))
+		if (ice_ptp_pf_handles_tx_interrupt(pf)) {
 			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
+			ret = IRQ_WAKE_THREAD;
+		}
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
@@ -3182,7 +3185,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 					       GLTSYN_STAT_EVENT1_M |
 					       GLTSYN_STAT_EVENT2_M);
 
-			set_bit(ICE_MISC_THREAD_EXTTS_EVENT, pf->misc_thread);
+			ice_ptp_extts_event(pf);
 		}
 	}
 
@@ -3205,8 +3208,11 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
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
@@ -3222,12 +3228,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
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
@@ -3239,6 +3240,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 		}
 	}
 
+skip_irq:
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 
 	return IRQ_HANDLED;
-- 
2.41.0


