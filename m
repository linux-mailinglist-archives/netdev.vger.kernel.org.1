Return-Path: <netdev+bounces-107294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EC91A7B7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AE3B26D33
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28A192B9C;
	Thu, 27 Jun 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpRSb6ed"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EB194083
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494334; cv=none; b=L2quTlKr4z7+LKULlp49r1i3hFIOBwbU53eNbxV+zCrchzcdlrmda2WT88RQx8HItJDYVN+8Zc47Dqi+MODyV1RjP2EKE6xEI51fqkC4sknflve8++MLqkat1BvOOBYqwveT00wOcpubkfl6tO4p8b8q7ho+q2uQnJHf6HqxUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494334; c=relaxed/simple;
	bh=rmQwXCFZo7BvRkVcopxBFnH88drjhJzKTgexVz+oJzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIJ4klINrb1sVb92Btv0eEcqkW3n1pO/+dxrkmf5y4I1tTdwM7yMDzYKnF403yg7E7WO2WQ87PJT5wy1n9i/fRxVnpeSXN5O091nA02cRlFzMtXF5rYo2H1B5tBo/ctr45QWB0Se5kJ6/dQt7devKqSje2AROCAT1Tu3WHu1TiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpRSb6ed; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494334; x=1751030334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmQwXCFZo7BvRkVcopxBFnH88drjhJzKTgexVz+oJzo=;
  b=TpRSb6edozVt8rTyLlVDWGFEvgCovyD6pIHY4NzIbY2o2DtupdNxSikY
   EbSCjN1ps7q53mWAc16cKPSSgGp61LhKEFfTSwYh0tW2M2Lm/FpTh4QXn
   qV6M5p2Ob04Xyq2KL7eid3tJfnzOAVy3ktNJh8v8gdh7JIWqbOmAG1lRm
   mi30FPBg0NWwQO4V6JGMpcWgEXm8bcp4fXo7rpRywYGe2FZ7vQMbvFbmu
   F7J6j8lVDoCV3A0FLue0j5BY4toxkkj+FhPoxJzAI0/Z02OrVzNKp8f1v
   kMpZtFHztH86/p+v9qlOHIzXfAG3XeV19g15v0XDNO7tkEPEkrUK+TqP5
   w==;
X-CSE-ConnectionGUID: kDWr8Mp2TlqVyAwmV3yT/Q==
X-CSE-MsgGUID: 0kQJwL0NQwq1FARAujyILQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452354"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452354"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:18:54 -0700
X-CSE-ConnectionGUID: TH+8p3+kTe26tRuGFaVbwg==
X-CSE-MsgGUID: YPu3QyILTXSuqBlxJoFKPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315392"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:51 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v4 iwl-net 4/8] ice: modify error handling when setting XSK pool in ndo_bpf
Date: Thu, 27 Jun 2024 15:17:53 +0200
Message-Id: <20240627131757.144991-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
References: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't bail out right when spotting an error within ice_qp_{dis,ena}()
but rather track error and go through whole flow of disabling and
enabling queue pair.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ba50af9a5929..902096b000f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -162,6 +162,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
 	int timeout = 50;
+	int fail = 0;
 	int err;
 
 	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
@@ -186,8 +187,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
-	if (err)
-		return err;
+	if (!fail)
+		fail = err;
 	if (ice_is_xdp_ena_vsi(vsi)) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
@@ -195,15 +196,15 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		ice_fill_txq_meta(vsi, xdp_ring, &txq_meta);
 		err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, xdp_ring,
 					   &txq_meta);
-		if (err)
-			return err;
+		if (!fail)
+			fail = err;
 	}
 
 	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-	return 0;
+	return fail;
 }
 
 /**
@@ -216,32 +217,33 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
 	struct ice_q_vector *q_vector;
+	int fail = 0;
 	int err;
 
 	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
-	if (err)
-		return err;
+	if (!fail)
+		fail = err;
 
 	if (ice_is_xdp_ena_vsi(vsi)) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
 		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
-		if (err)
-			return err;
+		if (!fail)
+			fail = err;
 		ice_set_ring_xdp(xdp_ring);
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
 	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
-	if (err)
-		return err;
+	if (!fail)
+		fail = err;
 
 	q_vector = vsi->rx_rings[q_idx]->q_vector;
 	ice_qvec_cfg_msix(vsi, q_vector);
 
 	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
-	if (err)
-		return err;
+	if (!fail)
+		fail = err;
 
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
@@ -249,7 +251,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
-	return 0;
+	return fail;
 }
 
 /**
-- 
2.34.1


