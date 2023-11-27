Return-Path: <netdev+bounces-51472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690B7FAC54
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3161281D47
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C446451;
	Mon, 27 Nov 2023 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TS5iALSD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E12D5A
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701119446; x=1732655446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HR4JDKlfx6/eYpK3fQE6/MsuNMbK3KPtCR3rE7d9NhU=;
  b=TS5iALSDyQ5Unh6GrObvaKdSZcYF7PwG1AYaTlEVMpfJjnjbypQiOxCf
   /U/ItOCvIVtRzxrv+8WLc+mEhSWYcPzoti1EUcRlV3PKWt/rj8vI0hnEJ
   hug2EqS/KU+2Ag3+UNrjpelNdsvUGndFgQApblM5hcvcicfo762Jy3sZn
   HUq3qWzFitHGRdLCKoc2pi3wyiMUE0rDIcLNnc9OiWYmllmiyO4x5//GL
   8gWx2KFEBkhzpP20cnCJSWo2omaI741nVLvNXqCBUgy+UHzvDCWsFoiJB
   oa6xe/gsmII6/XoQFQgVzbGucKXXnkPHMSfyF4MRSEPWE0a/ytxhh7wkw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="5982921"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="5982921"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 13:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9724679"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 13:10:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/5] i40e: Remove queue tracking fields from i40e_adminq_ring
Date: Mon, 27 Nov 2023 13:10:33 -0800
Message-ID: <20231127211037.1135403-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Fields 'head', 'tail', 'len', 'bah' and 'bal' in i40e_adminq_ring
are used to store register offsets. These offsets are initialized
and remains constant so there is no need to store them in the
i40e_adminq_ring structure.

Remove these fields from i40e_adminq_ring and use register offset
constants instead. Remove i40e_adminq_init_regs() that originally
stores these constants into these fields.

Finally improve i40e_check_asq_alive() that assumes that
non-zero value of hw->aq.asq.len indicates fully initialized
AdminQ send queue. Replace it by check for non-zero value
of field hw->aq.asq.count that is non-zero when the sending
queue is initialized and is zeroed during shutdown of
the queue.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 86 +++++++------------
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  7 --
 drivers/net/ethernet/intel/i40e/i40e_common.c |  8 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +-
 4 files changed, 39 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 896c43905309..f73f5930fc58 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -8,27 +8,6 @@
 
 static void i40e_resume_aq(struct i40e_hw *hw);
 
-/**
- *  i40e_adminq_init_regs - Initialize AdminQ registers
- *  @hw: pointer to the hardware structure
- *
- *  This assumes the alloc_asq and alloc_arq functions have already been called
- **/
-static void i40e_adminq_init_regs(struct i40e_hw *hw)
-{
-	/* set head and tail registers in our local struct */
-	hw->aq.asq.tail = I40E_PF_ATQT;
-	hw->aq.asq.head = I40E_PF_ATQH;
-	hw->aq.asq.len  = I40E_PF_ATQLEN;
-	hw->aq.asq.bal  = I40E_PF_ATQBAL;
-	hw->aq.asq.bah  = I40E_PF_ATQBAH;
-	hw->aq.arq.tail = I40E_PF_ARQT;
-	hw->aq.arq.head = I40E_PF_ARQH;
-	hw->aq.arq.len  = I40E_PF_ARQLEN;
-	hw->aq.arq.bal  = I40E_PF_ARQBAL;
-	hw->aq.arq.bah  = I40E_PF_ARQBAH;
-}
-
 /**
  *  i40e_alloc_adminq_asq_ring - Allocate Admin Queue send rings
  *  @hw: pointer to the hardware structure
@@ -254,17 +233,17 @@ static int i40e_config_asq_regs(struct i40e_hw *hw)
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
-	wr32(hw, hw->aq.asq.head, 0);
-	wr32(hw, hw->aq.asq.tail, 0);
+	wr32(hw, I40E_PF_ATQH, 0);
+	wr32(hw, I40E_PF_ATQT, 0);
 
 	/* set starting point */
-	wr32(hw, hw->aq.asq.len, (hw->aq.num_asq_entries |
+	wr32(hw, I40E_PF_ATQLEN, (hw->aq.num_asq_entries |
 				  I40E_PF_ATQLEN_ATQENABLE_MASK));
-	wr32(hw, hw->aq.asq.bal, lower_32_bits(hw->aq.asq.desc_buf.pa));
-	wr32(hw, hw->aq.asq.bah, upper_32_bits(hw->aq.asq.desc_buf.pa));
+	wr32(hw, I40E_PF_ATQBAL, lower_32_bits(hw->aq.asq.desc_buf.pa));
+	wr32(hw, I40E_PF_ATQBAH, upper_32_bits(hw->aq.asq.desc_buf.pa));
 
 	/* Check one register to verify that config was applied */
-	reg = rd32(hw, hw->aq.asq.bal);
+	reg = rd32(hw, I40E_PF_ATQBAL);
 	if (reg != lower_32_bits(hw->aq.asq.desc_buf.pa))
 		ret_code = -EIO;
 
@@ -283,20 +262,20 @@ static int i40e_config_arq_regs(struct i40e_hw *hw)
 	u32 reg = 0;
 
 	/* Clear Head and Tail */
-	wr32(hw, hw->aq.arq.head, 0);
-	wr32(hw, hw->aq.arq.tail, 0);
+	wr32(hw, I40E_PF_ARQH, 0);
+	wr32(hw, I40E_PF_ARQT, 0);
 
 	/* set starting point */
-	wr32(hw, hw->aq.arq.len, (hw->aq.num_arq_entries |
+	wr32(hw, I40E_PF_ARQLEN, (hw->aq.num_arq_entries |
 				  I40E_PF_ARQLEN_ARQENABLE_MASK));
-	wr32(hw, hw->aq.arq.bal, lower_32_bits(hw->aq.arq.desc_buf.pa));
-	wr32(hw, hw->aq.arq.bah, upper_32_bits(hw->aq.arq.desc_buf.pa));
+	wr32(hw, I40E_PF_ARQBAL, lower_32_bits(hw->aq.arq.desc_buf.pa));
+	wr32(hw, I40E_PF_ARQBAH, upper_32_bits(hw->aq.arq.desc_buf.pa));
 
 	/* Update tail in the HW to post pre-allocated buffers */
-	wr32(hw, hw->aq.arq.tail, hw->aq.num_arq_entries - 1);
+	wr32(hw, I40E_PF_ARQT, hw->aq.num_arq_entries - 1);
 
 	/* Check one register to verify that config was applied */
-	reg = rd32(hw, hw->aq.arq.bal);
+	reg = rd32(hw, I40E_PF_ARQBAL);
 	if (reg != lower_32_bits(hw->aq.arq.desc_buf.pa))
 		ret_code = -EIO;
 
@@ -439,11 +418,11 @@ static int i40e_shutdown_asq(struct i40e_hw *hw)
 	}
 
 	/* Stop firmware AdminQ processing */
-	wr32(hw, hw->aq.asq.head, 0);
-	wr32(hw, hw->aq.asq.tail, 0);
-	wr32(hw, hw->aq.asq.len, 0);
-	wr32(hw, hw->aq.asq.bal, 0);
-	wr32(hw, hw->aq.asq.bah, 0);
+	wr32(hw, I40E_PF_ATQH, 0);
+	wr32(hw, I40E_PF_ATQT, 0);
+	wr32(hw, I40E_PF_ATQLEN, 0);
+	wr32(hw, I40E_PF_ATQBAL, 0);
+	wr32(hw, I40E_PF_ATQBAH, 0);
 
 	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
 
@@ -473,11 +452,11 @@ static int i40e_shutdown_arq(struct i40e_hw *hw)
 	}
 
 	/* Stop firmware AdminQ processing */
-	wr32(hw, hw->aq.arq.head, 0);
-	wr32(hw, hw->aq.arq.tail, 0);
-	wr32(hw, hw->aq.arq.len, 0);
-	wr32(hw, hw->aq.arq.bal, 0);
-	wr32(hw, hw->aq.arq.bah, 0);
+	wr32(hw, I40E_PF_ARQH, 0);
+	wr32(hw, I40E_PF_ARQT, 0);
+	wr32(hw, I40E_PF_ARQLEN, 0);
+	wr32(hw, I40E_PF_ARQBAL, 0);
+	wr32(hw, I40E_PF_ARQBAH, 0);
 
 	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
 
@@ -608,9 +587,6 @@ int i40e_init_adminq(struct i40e_hw *hw)
 		goto init_adminq_exit;
 	}
 
-	/* Set up register offsets */
-	i40e_adminq_init_regs(hw);
-
 	/* setup ASQ command write back timeout */
 	hw->aq.asq_cmd_timeout = I40E_ASQ_CMD_TIMEOUT;
 
@@ -720,9 +696,9 @@ static u16 i40e_clean_asq(struct i40e_hw *hw)
 
 	desc = I40E_ADMINQ_DESC(*asq, ntc);
 	details = I40E_ADMINQ_DETAILS(*asq, ntc);
-	while (rd32(hw, hw->aq.asq.head) != ntc) {
+	while (rd32(hw, I40E_PF_ATQH) != ntc) {
 		i40e_debug(hw, I40E_DEBUG_AQ_COMMAND,
-			   "ntc %d head %d.\n", ntc, rd32(hw, hw->aq.asq.head));
+			   "ntc %d head %d.\n", ntc, rd32(hw, I40E_PF_ATQH));
 
 		if (details->callback) {
 			I40E_ADMINQ_CALLBACK cb_func =
@@ -756,7 +732,7 @@ static bool i40e_asq_done(struct i40e_hw *hw)
 	/* AQ designers suggest use of head for better
 	 * timing reliability than DD bit
 	 */
-	return rd32(hw, hw->aq.asq.head) == hw->aq.asq.next_to_use;
+	return rd32(hw, I40E_PF_ATQH) == hw->aq.asq.next_to_use;
 
 }
 
@@ -797,7 +773,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
 
 	hw->aq.asq_last_status = I40E_AQ_RC_OK;
 
-	val = rd32(hw, hw->aq.asq.head);
+	val = rd32(hw, I40E_PF_ATQH);
 	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: head overrun at %d\n", val);
@@ -889,7 +865,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
 	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
 		hw->aq.asq.next_to_use = 0;
 	if (!details->postpone)
-		wr32(hw, hw->aq.asq.tail, hw->aq.asq.next_to_use);
+		wr32(hw, I40E_PF_ATQT, hw->aq.asq.next_to_use);
 
 	/* if cmd_details are not defined or async flag is not set,
 	 * we need to wait for desc write back
@@ -949,7 +925,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
 	/* update the error if time out occurred */
 	if ((!cmd_completed) &&
 	    (!details->async && !details->postpone)) {
-		if (rd32(hw, hw->aq.asq.len) & I40E_GL_ATQLEN_ATQCRIT_MASK) {
+		if (rd32(hw, I40E_PF_ATQLEN) & I40E_GL_ATQLEN_ATQCRIT_MASK) {
 			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 				   "AQTX: AQ Critical error.\n");
 			status = -EIO;
@@ -1103,7 +1079,7 @@ int i40e_clean_arq_element(struct i40e_hw *hw,
 	}
 
 	/* set next_to_use to head */
-	ntu = rd32(hw, hw->aq.arq.head) & I40E_PF_ARQH_ARQH_MASK;
+	ntu = rd32(hw, I40E_PF_ARQH) & I40E_PF_ARQH_ARQH_MASK;
 	if (ntu == ntc) {
 		/* nothing to do - shouldn't need to update ring's values */
 		ret_code = -EALREADY;
@@ -1151,7 +1127,7 @@ int i40e_clean_arq_element(struct i40e_hw *hw,
 	desc->params.external.addr_low = cpu_to_le32(lower_32_bits(bi->pa));
 
 	/* set tail = the last cleaned desc index. */
-	wr32(hw, hw->aq.arq.tail, ntc);
+	wr32(hw, I40E_PF_ARQT, ntc);
 	/* ntc is updated to tail + 1 */
 	ntc++;
 	if (ntc == hw->aq.num_arq_entries)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 80125bea80a2..ee86d2c53079 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -29,13 +29,6 @@ struct i40e_adminq_ring {
 	/* used for interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
-
-	/* used for queue tracking */
-	u32 head;
-	u32 tail;
-	u32 len;
-	u32 bah;
-	u32 bal;
 };
 
 /* ASQ transaction details */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e171f4814e21..bd52b73cf61f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -195,11 +195,11 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
  **/
 bool i40e_check_asq_alive(struct i40e_hw *hw)
 {
-	if (hw->aq.asq.len)
-		return !!(rd32(hw, hw->aq.asq.len) &
-			  I40E_PF_ATQLEN_ATQENABLE_MASK);
-	else
+	/* Check if the queue is initialized */
+	if (!hw->aq.asq.count)
 		return false;
+
+	return !!(rd32(hw, I40E_PF_ATQLEN) & I40E_PF_ATQLEN_ATQENABLE_MASK);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d71331a8a972..9eeea8d9ab67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10127,7 +10127,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 		return;
 
 	/* check for error indications */
-	val = rd32(&pf->hw, pf->hw.aq.arq.len);
+	val = rd32(&pf->hw, I40E_PF_ARQLEN);
 	oldval = val;
 	if (val & I40E_PF_ARQLEN_ARQVFE_MASK) {
 		if (hw->debug_mask & I40E_DEBUG_AQ)
@@ -10146,9 +10146,9 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 		val &= ~I40E_PF_ARQLEN_ARQCRIT_MASK;
 	}
 	if (oldval != val)
-		wr32(&pf->hw, pf->hw.aq.arq.len, val);
+		wr32(&pf->hw, I40E_PF_ARQLEN, val);
 
-	val = rd32(&pf->hw, pf->hw.aq.asq.len);
+	val = rd32(&pf->hw, I40E_PF_ATQLEN);
 	oldval = val;
 	if (val & I40E_PF_ATQLEN_ATQVFE_MASK) {
 		if (pf->hw.debug_mask & I40E_DEBUG_AQ)
@@ -10166,7 +10166,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 		val &= ~I40E_PF_ATQLEN_ATQCRIT_MASK;
 	}
 	if (oldval != val)
-		wr32(&pf->hw, pf->hw.aq.asq.len, val);
+		wr32(&pf->hw, I40E_PF_ATQLEN, val);
 
 	event.buf_len = I40E_MAX_AQ_BUF_SIZE;
 	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
-- 
2.41.0


