Return-Path: <netdev+bounces-169358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C2A43929
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8398E19E10CA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9F72638B2;
	Tue, 25 Feb 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz+80rHl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB25262D3B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474571; cv=none; b=JknFJBH8UXn3l3G68LGmAPoGsMp1Jleq6nO46rSlvXWbr0mefj6H+PKwg29vgpCsJUFfPXYMbYmB3O/MEVpXwK0ICRSBYEDUl9/GA1Z9mpRCyT0XQmFeHXVOCjbwaF+JMNfIUtZTMafPza2bKbJmf3rnP0YDy+x6qhvUdUMSKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474571; c=relaxed/simple;
	bh=qvH744x9n/EIaRK81PRkt4ItVtZ4IA+MhzAIe0c3AxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYBoE+p+ZJQJm1KoZniQeuKPP0VVEpP8xcj6CjleeQOY0ALvEVHuFUkerZPwO15cFrzQdWBlcP/R+tRV7HnSkDmnTRJ4xmmGVMzSJDKInB0U0lRUNF6YqI4iIwWtLaXlsr+MsWDMNcX/++Cx0Y7K0n66NEELeDcyDn1+3IrGEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cz+80rHl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474569; x=1772010569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvH744x9n/EIaRK81PRkt4ItVtZ4IA+MhzAIe0c3AxQ=;
  b=Cz+80rHlJBZB47NT+xlm6zXG5k7ZFeWNqFgGIQLyHY+tHEJXN5bE8Yd6
   KMFkPYvCbvrw1MWSHMCFudRE++rQtcNbu9docf0gPtSiRK5H7hPu2t+tR
   kRugsdG6h7AqkkoDVymoMFYPDL+A+W3L6GDWxUNX5dNVFf3ziEB29TwDO
   ZMhRLaa+9KSB2PXNEf/lrpHMm2+VNDVkpWJIghiGuiZXC0BYkZ8JqgPVB
   mExZXfY4jT0BXsYJ6TAm/dkgdGTwYwPt11xRDW1iYQb7v4+1tOGMtNFGB
   h4X6TcwuCwcjp2QAFWM06C5S9zBBtBr4uMUrVPfMDtalgTYRF1sA/2uo4
   w==;
X-CSE-ConnectionGUID: R3QMEkEYRGemOM7TzNtd4Q==
X-CSE-MsgGUID: wXi05FxOQvaaeMac2o5XHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810340"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810340"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:29 -0800
X-CSE-ConnectionGUID: HxS2/pS1Tqm2YBs5XkgZLA==
X-CSE-MsgGUID: Gs5F6aekTIGmUa9YBhzKxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275661"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:28 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 3/5] ice: validate queue quanta parameters to prevent OOB access
Date: Tue, 25 Feb 2025 10:08:47 +0100
Message-ID: <20250225090847.513849-6-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Add queue wraparound prevention in quanta configuration.
Ensure end_qid does not overflow by validating start_qid and num_queues.

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 343f2b4b0dc5..adb1bf12542f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1903,13 +1903,21 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
  */
 static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 {
+	u16 quanta_prof_id, quanta_size, start_qid, num_queues, end_qid, i;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	u16 quanta_prof_id, quanta_size, start_qid, end_qid, i;
 	struct virtchnl_quanta_cfg *qquanta =
 		(struct virtchnl_quanta_cfg *)msg;
 	struct ice_vsi *vsi;
 	int ret;
 
+	start_qid = qquanta->queue_select.start_queue_id;
+	num_queues = qquanta->queue_select.num_queues;
+
+	if (check_add_overflow(start_qid, num_queues, &end_qid)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto err;
@@ -1921,8 +1929,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	end_qid = qquanta->queue_select.start_queue_id +
-		  qquanta->queue_select.num_queues;
 	if (end_qid > ICE_MAX_RSS_QS_PER_VF ||
 	    end_qid > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
 		dev_err(ice_pf_to_dev(vf->pf), "VF-%d trying to configure more than allocated number of queues: %d\n",
@@ -1951,7 +1957,6 @@ static int ice_vc_cfg_q_quanta(struct ice_vf *vf, u8 *msg)
 		goto err;
 	}
 
-	start_qid = qquanta->queue_select.start_queue_id;
 	for (i = start_qid; i < end_qid; i++)
 		vsi->tx_rings[i]->quanta_prof_id = quanta_prof_id;
 
-- 
2.47.0


