Return-Path: <netdev+bounces-122078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC195FD69
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483B4B222F8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE01A01B3;
	Mon, 26 Aug 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4LJsmAx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FC1A00DF
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712426; cv=none; b=Ri4AsxeDjtjof2lPMZ+XHNC8jIoQTin+BYH8iuFx9MDybWsHVHcdiUkWNb4uKuuyikls9brAJKh4JPzBie4cTUt3Ed7qJp/+pBu0CTVP9uWubVRvS9+Nnn8UbOZcq7xrUSsZfCR645a4OzW/4PZn8wRuW7f+DkywZJq4hULHUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712426; c=relaxed/simple;
	bh=V2ihdL3KXAvPsEsIrimDq8k/GmGt+KAhoKAv5VaruDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbunyBOm4x10E8ATbt9caDMb5R8ajrn1sJx7fE0eyhFLGssAMQsvNbe70+E3zYdvtpV+LH49OhvmXEF7rHQoGLQK5CK84WHKKNUtF5Cp6BZtUIqcruw+BlJMjjjqxm2X6Mbmdkh8JyMQZIjJctYjUlXxEOVA33GRwCFWMxKxNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4LJsmAx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712425; x=1756248425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V2ihdL3KXAvPsEsIrimDq8k/GmGt+KAhoKAv5VaruDs=;
  b=R4LJsmAxVDk/kP6OtAmEfTh+M0jISZhNMOq0gZOpOI2DhxA1SXrl6U2k
   TqkK53UYj9BViwQr2oY8LZ3oNkK6tMFDvyo0AJe7sdQJal57Qzx8ccgca
   7v9fktcIsrsW4pSAOTAHa02BwVmH7vkmfNCp/xECHWWPGDQkmNxkC3QAA
   l2JgQMeFa2ACu2DIewlVq7xmtjrbEKNivW9Otv5hVGRYFKPiPi6AEE4Ut
   iVGpt7KZZxAAmlYOX/S7OUNH725wjfuuNUz5SYFxPYvyaZNEp/F7LnLvm
   gbnsp+vfWO4+CQF/RG6Zy28KGa6r8xJlrKTYHoOVMo7T0pbIpIv63rlxR
   g==;
X-CSE-ConnectionGUID: ZxiZAbUiSvKfbFC9aLYdUQ==
X-CSE-MsgGUID: A/meJBdFQkeuQNHPtpRbxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030975"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030975"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:01 -0700
X-CSE-ConnectionGUID: Jl/Tl4Y7RiWgWVITtQkZng==
X-CSE-MsgGUID: WJglsqKaQQyoqfYdV422ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822478"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/8] ice: reword comments referring to control queues
Date: Mon, 26 Aug 2024 15:46:45 -0700
Message-ID: <20240826224655.133847-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
References: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Many comments in ice_controlq.c use the term "Admin queue" despite the code
being intended for arbitrary control queues, not just the Admin queue.
Reword the comments to make it clear that this code is the generic control
queue logic that is shared by all of the control queues, and is not
specific to the Admin queue.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 020600de9533..f38fd25a914a 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -188,7 +188,7 @@ ice_alloc_rq_bufs(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 		if (cq->rq_buf_size > ICE_AQ_LG_BUF)
 			desc->flags |= cpu_to_le16(ICE_AQ_FLAG_LB);
 		desc->opcode = 0;
-		/* This is in accordance with Admin queue design, there is no
+		/* This is in accordance with control queue design, there is no
 		 * register for buffer size configuration
 		 */
 		desc->datalen = cpu_to_le16(bi->size);
@@ -405,11 +405,11 @@ static int ice_init_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 }
 
 /**
- * ice_init_rq - initialize ARQ
+ * ice_init_rq - initialize receive side of a control queue
  * @hw: pointer to the hardware structure
  * @cq: pointer to the specific Control queue
  *
- * The main initialization routine for the Admin Receive (Event) Queue.
+ * The main initialization routine for Receive side of a control queue.
  * Prior to calling this function, the driver *MUST* set the following fields
  * in the cq->structure:
  *     - cq->num_rq_entries
@@ -465,7 +465,7 @@ static int ice_init_rq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 }
 
 /**
- * ice_shutdown_sq - shutdown the Control ATQ
+ * ice_shutdown_sq - shutdown the transmit side of a control queue
  * @hw: pointer to the hardware structure
  * @cq: pointer to the specific Control queue
  *
@@ -482,7 +482,7 @@ static int ice_shutdown_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 		goto shutdown_sq_out;
 	}
 
-	/* Stop firmware AdminQ processing */
+	/* Stop processing of the control queue */
 	wr32(hw, cq->sq.head, 0);
 	wr32(hw, cq->sq.tail, 0);
 	wr32(hw, cq->sq.len, 0);
@@ -855,7 +855,7 @@ void ice_destroy_all_ctrlq(struct ice_hw *hw)
 }
 
 /**
- * ice_clean_sq - cleans Admin send queue (ATQ)
+ * ice_clean_sq - cleans send side of a control queue
  * @hw: pointer to the hardware structure
  * @cq: pointer to the specific Control queue
  *
@@ -989,7 +989,7 @@ static bool ice_sq_done(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 }
 
 /**
- * ice_sq_send_cmd - send command to Control Queue (ATQ)
+ * ice_sq_send_cmd - send command to a control queue
  * @hw: pointer to the HW struct
  * @cq: pointer to the specific Control queue
  * @desc: prefilled descriptor describing the command
@@ -997,8 +997,9 @@ static bool ice_sq_done(struct ice_hw *hw, struct ice_ctl_q_info *cq)
  * @buf_size: size of buffer for indirect commands (or 0 for direct commands)
  * @cd: pointer to command details structure
  *
- * This is the main send command routine for the ATQ. It runs the queue,
- * cleans the queue, etc.
+ * Main command for the transmit side of a control queue. It puts the command
+ * on the queue, bumps the tail, waits for processing of the command, captures
+ * command status and results, etc.
  */
 int
 ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
@@ -1182,9 +1183,9 @@ void ice_fill_dflt_direct_cmd_desc(struct ice_aq_desc *desc, u16 opcode)
  * @e: event info from the receive descriptor, includes any buffers
  * @pending: number of events that could be left to process
  *
- * This function cleans one Admin Receive Queue element and returns
- * the contents through e. It can also return how many events are
- * left to process through 'pending'.
+ * Clean one element from the receive side of a control queue. On return 'e'
+ * contains contents of the message, and 'pending' contains the number of
+ * events left to process.
  */
 int
 ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
-- 
2.42.0


