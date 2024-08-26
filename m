Return-Path: <netdev+bounces-122079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0695FD6A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6A7280E89
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546D1A01B8;
	Mon, 26 Aug 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvWqN8NS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D61A00E2
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712427; cv=none; b=T4iJ5hqwgsplF4Sqi6aQfboJjFFghlAZxsC0792KgRwv4NMoaOw1pmQU1wBSFw6gt7b+FHVyKXn8mAWZ9N7xwD7CUSk3TzV7QqUzXrxut2mFvXP8W+qQaGi4jMf2G/ttDCnsezhVcf7gXxgAjKWqsJicPGyfbsnbCT3PxIUq1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712427; c=relaxed/simple;
	bh=wgj0TxEvUwKdRCg9wxm6P8JYEwRetHDvckzpK8H5IQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLFMXf7o3ps/I3shPSh3ilEyVIMJwsoZ+GwsVK6Fzy2OctzyxBSFyXvJYewY2JE/gYlNzFpb0A/iLJaD9Scc5wjVyi4cbFKPRAKPLkY+hAnw/dRWzzzcblHMnQFlcDKA28nRomTEt6l8ia+fqaClyeGFiVrCcq2kYAiIwc9BmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvWqN8NS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712426; x=1756248426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wgj0TxEvUwKdRCg9wxm6P8JYEwRetHDvckzpK8H5IQE=;
  b=cvWqN8NS1h4zjWJi/riMlnHeu6tzvjw8kXWKtwtSY21sE2ai1xshp2tW
   ooVMPtKIwfNWlMhYSvAWoTKTPvV9J+RvoqCi86pxOTHHVV+T/kN1BAX5j
   WnTFaIylecBN+QxMl+wVhCxBzK6rB4TAMesnqPqY3MMDohMErU9VZB4hT
   XjjnrSCBkALEhfmJmfGEtzQENw1TV405YctstzaqVNmXSOKM2i4//Moha
   PVcYZVEF5rLET1nDR8B7r7OvdbtuMtvm3dioiXu1GQzqSt3Ys5CgQnnTe
   yNdSMgMdiVUvgsDcUh2Ygh7WH0R91oRjsWM2CQARYGDEwa0hfnuP+ndca
   A==;
X-CSE-ConnectionGUID: hIg5T0KeQSGTZsW9k0hO5g==
X-CSE-MsgGUID: tY7XWBqiQ0amE8J4YB14VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030981"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030981"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:02 -0700
X-CSE-ConnectionGUID: s4MG6gxzSsqkjAj20YRTKQ==
X-CSE-MsgGUID: ixqGYoCbTQSqQwW0Cy8HMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822481"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:47:01 -0700
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
Subject: [PATCH net-next 6/8] ice: remove unnecessary control queue cmd_buf arrays
Date: Mon, 26 Aug 2024 15:46:46 -0700
Message-ID: <20240826224655.133847-7-anthony.l.nguyen@intel.com>
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

The driver allocates a cmd_buf array in addition to the desc_buf array.
This array stores an ice_sq_cd command details structure for each entry in
the control queue ring.

The contents of the structure are copied from the value passed in via
ice_sq_send_cmd, and include only a pointer to storage for the write back
descriptor contents.

Originally this array was intended to support asynchronous completion
including features such as a callback function. This support was never
implemented. All that exists today is needless copying and resetting of a
cmd_buf array that is otherwise functionally unused.

Since we do not plan to implement asynchronous completions, drop this
unnecessary memory and logic. This saves memory for each control queue, and
avoids the pointless copying and memset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 29 ++-----------------
 drivers/net/ethernet/intel/ice/ice_controlq.h |  3 --
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index f38fd25a914a..b5774035e6f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -99,17 +99,6 @@ ice_alloc_ctrlq_sq_ring(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 		return -ENOMEM;
 	cq->sq.desc_buf.size = size;
 
-	cq->sq.cmd_buf = devm_kcalloc(ice_hw_to_dev(hw), cq->num_sq_entries,
-				      sizeof(struct ice_sq_cd), GFP_KERNEL);
-	if (!cq->sq.cmd_buf) {
-		dmam_free_coherent(ice_hw_to_dev(hw), cq->sq.desc_buf.size,
-				   cq->sq.desc_buf.va, cq->sq.desc_buf.pa);
-		cq->sq.desc_buf.va = NULL;
-		cq->sq.desc_buf.pa = 0;
-		cq->sq.desc_buf.size = 0;
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -338,8 +327,6 @@ do {									\
 					(qi)->ring.r.ring##_bi[i].size = 0;\
 		}							\
 	}								\
-	/* free the buffer info list */					\
-	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
 	/* free DMA head */						\
 	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
 } while (0)
@@ -865,21 +852,17 @@ static u16 ice_clean_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
 {
 	struct ice_ctl_q_ring *sq = &cq->sq;
 	u16 ntc = sq->next_to_clean;
-	struct ice_sq_cd *details;
 	struct ice_aq_desc *desc;
 
 	desc = ICE_CTL_Q_DESC(*sq, ntc);
-	details = ICE_CTL_Q_DETAILS(*sq, ntc);
 
 	while (rd32(hw, cq->sq.head) != ntc) {
 		ice_debug(hw, ICE_DBG_AQ_MSG, "ntc %d head %d.\n", ntc, rd32(hw, cq->sq.head));
 		memset(desc, 0, sizeof(*desc));
-		memset(details, 0, sizeof(*details));
 		ntc++;
 		if (ntc == sq->count)
 			ntc = 0;
 		desc = ICE_CTL_Q_DESC(*sq, ntc);
-		details = ICE_CTL_Q_DETAILS(*sq, ntc);
 	}
 
 	sq->next_to_clean = ntc;
@@ -1009,7 +992,6 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	struct ice_dma_mem *dma_buf = NULL;
 	struct ice_aq_desc *desc_on_ring;
 	bool cmd_completed = false;
-	struct ice_sq_cd *details;
 	int status = 0;
 	u16 retval = 0;
 	u32 val = 0;
@@ -1053,12 +1035,6 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		goto sq_send_command_error;
 	}
 
-	details = ICE_CTL_Q_DETAILS(cq->sq, cq->sq.next_to_use);
-	if (cd)
-		*details = *cd;
-	else
-		memset(details, 0, sizeof(*details));
-
 	/* Call clean and check queue available function to reclaim the
 	 * descriptors that were processed by FW/MBX; the function returns the
 	 * number of desc available. The clean function called here could be
@@ -1140,9 +1116,8 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	ice_debug_cq(hw, cq, (void *)desc, buf, buf_size, true);
 
 	/* save writeback AQ if requested */
-	if (details->wb_desc)
-		memcpy(details->wb_desc, desc_on_ring,
-		       sizeof(*details->wb_desc));
+	if (cd && cd->wb_desc)
+		memcpy(cd->wb_desc, desc_on_ring, sizeof(*cd->wb_desc));
 
 	/* update the error if time out occurred */
 	if (!cmd_completed) {
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index e5b6691436f5..ca97b7365a1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -50,7 +50,6 @@ enum ice_ctl_q {
 struct ice_ctl_q_ring {
 	void *dma_head;			/* Virtual address to DMA head */
 	struct ice_dma_mem desc_buf;	/* descriptor ring memory */
-	void *cmd_buf;			/* command buffer memory */
 
 	union {
 		struct ice_dma_mem *sq_bi;
@@ -80,8 +79,6 @@ struct ice_sq_cd {
 	struct ice_aq_desc *wb_desc;
 };
 
-#define ICE_CTL_Q_DETAILS(R, i) (&(((struct ice_sq_cd *)((R).cmd_buf))[i]))
-
 /* rq event information */
 struct ice_rq_event_info {
 	struct ice_aq_desc desc;
-- 
2.42.0


