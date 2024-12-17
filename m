Return-Path: <netdev+bounces-152739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534D9F59E6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DF161B28
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9E1F9F64;
	Tue, 17 Dec 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGhFTluS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823F1F76DA
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476246; cv=none; b=odN2cDli4T5hLBeVgsiO0ryvpryzzXTUbVjHPQKtptz75VLGRYk0TAILnSKMfylkAjNk7Dj0spN2cOrfzBBQjV0COdkMBP1x+CFECWB8rmr6BKhhLM9FincTQzBub1vVwK1iX3uJV3dtfFx9gr2pbdtu77I1v81V8d7DCb3RxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476246; c=relaxed/simple;
	bh=luBJ7CB2f5UlPP2UXjRf0U8QqG4pluM+cogaS1TvHzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyv5+E/GaEwHi8uz1Ck61qUWGaPweyAWR6kn8uV7YGUwecFyXifnmOFdJ/WKTLlV6ogzDtcDuzTALfy6WJx6202bjFiLvS1z+XQgVfrnb8g0THFb1Xa6XuapwPhFeJrntFM6Fp8HVydbIrsfnhvWU068jUlIfIS/uinjecLVjVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGhFTluS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734476245; x=1766012245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luBJ7CB2f5UlPP2UXjRf0U8QqG4pluM+cogaS1TvHzk=;
  b=GGhFTluSlm7eMs07CE243YFpWZVqS1zPaVirCReBqqkDJE0OL5Tpm2SS
   Sx25fPq9Wz4N38Y9ugV5Kk0mySse+FeQ8lI13Kn5mKcTS8UscYX7b6QqW
   JdoErI1sVEgY7441O+oiWumXowJkO05C6xyecxyS4G4KYnPoFNE0VyV37
   decnXy1uBnOca73uiO7awz/edr+sdwrZT+gUkrgcCmljmCNk4W7TdOXbx
   s1IQIzGWqxt1H2nuWetk1q7R6GjUJTn+nPn2CumPfoda31D1m+ymZmTEq
   w7d+NmRCyLJIH8qo1VHAnQd8bn/4i9BXpt4u0496KKx27WT2J018IMT8c
   Q==;
X-CSE-ConnectionGUID: TU+VWmKBT0itqb0pZS05NA==
X-CSE-MsgGUID: sD00kDT5Q2CLck/YGine6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35072004"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35072004"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 14:57:24 -0800
X-CSE-ConnectionGUID: aTd0Z017QcukNWGSNQ9k4w==
X-CSE-MsgGUID: NVKr/aHHStK8z9Tf7rqkMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120916651"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Dec 2024 14:57:23 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	michal.kubiak@intel.com,
	madhu.chittim@intel.com,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 2/2] idpf: trigger SW interrupt when exiting wb_on_itr mode
Date: Tue, 17 Dec 2024 14:57:13 -0800
Message-ID: <20241217225715.4005644-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
References: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

There is a race condition between exiting wb_on_itr and completion write
backs. For example, we are in wb_on_itr mode and a Tx completion is
generated by HW, ready to be written back, as we are re-enabling
interrupts:

	HW                      SW
	|                       |
	|			| idpf_tx_splitq_clean_all
	|                       | napi_complete_done
	|			|
	| tx_completion_wb 	| idpf_vport_intr_update_itr_ena_irq

That tx_completion_wb happens before the vector is fully re-enabled.
Continuing with this example, it is a UDP stream and the
tx_completion_wb is the last one in the flow (there are no rx packets).
Because the HW generated the completion before the interrupt is fully
enabled, the HW will not fire the interrupt once the timer expires and
the write back will not happen. NAPI poll won't be called.  We have
indicated we're back in interrupt mode but nothing else will trigger the
interrupt. Therefore, the completion goes unprocessed, triggering a Tx
timeout.

To mitigate this, fire a SW triggered interrupt upon exiting wb_on_itr.
This interrupt will catch the rogue completion and avoid the timeout.
Add logic to set the appropriate bits in the vector's dyn_ctl register.

Fixes: 9c4a27da0ecc ("idpf: enable WB_ON_ITR")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 29 ++++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 34f4118c7bc0..2fa9c36e33c9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3604,21 +3604,31 @@ static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 /**
  * idpf_vport_intr_buildreg_itr - Enable default interrupt generation settings
  * @q_vector: pointer to q_vector
- * @type: itr index
- * @itr: itr value
  */
-static u32 idpf_vport_intr_buildreg_itr(struct idpf_q_vector *q_vector,
-					const int type, u16 itr)
+static u32 idpf_vport_intr_buildreg_itr(struct idpf_q_vector *q_vector)
 {
-	u32 itr_val;
+	u32 itr_val = q_vector->intr_reg.dyn_ctl_intena_m;
+	int type = IDPF_NO_ITR_UPDATE_IDX;
+	u16 itr = 0;
+
+	if (q_vector->wb_on_itr) {
+		/*
+		 * Trigger a software interrupt when exiting wb_on_itr, to make
+		 * sure we catch any pending write backs that might have been
+		 * missed due to interrupt state transition.
+		 */
+		itr_val |= q_vector->intr_reg.dyn_ctl_swint_trig_m |
+			   q_vector->intr_reg.dyn_ctl_sw_itridx_ena_m;
+		type = IDPF_SW_ITR_UPDATE_IDX;
+		itr = IDPF_ITR_20K;
+	}
 
 	itr &= IDPF_ITR_MASK;
 	/* Don't clear PBA because that can cause lost interrupts that
 	 * came in while we were cleaning/polling
 	 */
-	itr_val = q_vector->intr_reg.dyn_ctl_intena_m |
-		  (type << q_vector->intr_reg.dyn_ctl_itridx_s) |
-		  (itr << (q_vector->intr_reg.dyn_ctl_intrvl_s - 1));
+	itr_val |= (type << q_vector->intr_reg.dyn_ctl_itridx_s) |
+		   (itr << (q_vector->intr_reg.dyn_ctl_intrvl_s - 1));
 
 	return itr_val;
 }
@@ -3716,9 +3726,8 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 	/* net_dim() updates ITR out-of-band using a work item */
 	idpf_net_dim(q_vector);
 
+	intval = idpf_vport_intr_buildreg_itr(q_vector);
 	q_vector->wb_on_itr = false;
-	intval = idpf_vport_intr_buildreg_itr(q_vector,
-					      IDPF_NO_ITR_UPDATE_IDX, 0);
 
 	writel(intval, q_vector->intr_reg.dyn_ctl);
 }
-- 
2.47.1


