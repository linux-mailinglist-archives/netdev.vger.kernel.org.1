Return-Path: <netdev+bounces-107298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BA91A7BC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D41F2193D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD28192B8B;
	Thu, 27 Jun 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lddokbdW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D7194135
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494346; cv=none; b=Yo/BbAOa66HCYRszRbxRsLIBxy3gqSe79AcclvnAcgB8Qmn96wl+bJYA4aRLBKp9tLOZ1qXaIccctOD6unNHPCpjU6s8MIlkiNbCOYsVG2olj2AACguLwygW2qWkFwYmJI714yCmJjU6TN4yMbvE2hW3mhBH6HKHnAoSWeljpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494346; c=relaxed/simple;
	bh=bjK+k9PzA3o34izY3/oAvS7AIrYRNsdwJRRqlVdKdh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8MQDrPRwBgk4tW4rhWNinpT7m53/Frimu0C/2zVMS+YEvK87S/tB6Pcw2qHvo4AlXNeizKdAvpLiRy8kohbuVIfAX5glB4/HMylGeOMpiAHkVf1KrikPOQld4xX4f0BNTZPj1y9ZSfs2AzVECiB4xdBsab0pLMpU1hcd7O3P60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lddokbdW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494345; x=1751030345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjK+k9PzA3o34izY3/oAvS7AIrYRNsdwJRRqlVdKdh8=;
  b=lddokbdWohdGIYDEWAsd3cB8SyLGhGAwEVu6PVES/eT+QrHYuGyRQCwj
   5v9kaIPhLIqUvYM1A5knR00EFqxXKQjj1iTlwmcvaBU/qrtqCT5BChEt7
   WJ3Xq65OOo3jgLc+/KLXu/7rwP6dnOQD89zpt1nKIMQIPy2/PukmMbmS6
   SGdY/+gJCBrEk1x7ldz9tsKG/Uyot+l0oLBop1RFOaEtw9HGhRVE4a8os
   8mQowkk12xO8clQANk82RvDTXAfOvvxRK8bb2e1vzh+qAhrmM6GsraZMO
   tZ3QLOkR+u2MVuzNIJoBAfIKogVild9SOCZsOIZaJfd0mVHQaG+eMjZMi
   Q==;
X-CSE-ConnectionGUID: oJuHuTYxTzis9qpb+E/OgQ==
X-CSE-MsgGUID: A+MNac84SLaIfg72VNh95A==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452381"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452381"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:19:05 -0700
X-CSE-ConnectionGUID: dcU4IxOISkuxxKUZlpWDsQ==
X-CSE-MsgGUID: Rk79D5OuRyG2ki3r2rMJ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315436"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:19:02 -0700
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
Subject: [PATCH v4 iwl-net 8/8] ice: xsk: fix txq interrupt mapping
Date: Thu, 27 Jun 2024 15:17:57 +0200
Message-Id: <20240627131757.144991-9-maciej.fijalkowski@intel.com>
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

ice_cfg_txq_interrupt() internally handles XDP Tx ring. Do not use
ice_for_each_tx_ring() in ice_qvec_cfg_msix() as this causing us to
treat XDP ring that belongs to queue vector as Tx ring and therefore
misconfiguring the interrupts.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index b4058c4937bc..492a9e54d58b 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -110,25 +110,29 @@ ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
  * ice_qvec_cfg_msix - Enable IRQ for given queue vector
  * @vsi: the VSI that contains queue vector
  * @q_vector: queue vector
+ * @qid: queue index
  */
 static void
-ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector, u16 qid)
 {
 	u16 reg_idx = q_vector->reg_idx;
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
-	struct ice_tx_ring *tx_ring;
-	struct ice_rx_ring *rx_ring;
+	int q, _qid = qid;
 
 	ice_cfg_itr(hw, q_vector);
 
-	ice_for_each_tx_ring(tx_ring, q_vector->tx)
-		ice_cfg_txq_interrupt(vsi, tx_ring->reg_idx, reg_idx,
-				      q_vector->tx.itr_idx);
+	for (q = 0; q < q_vector->num_ring_tx; q++) {
+		ice_cfg_txq_interrupt(vsi, _qid, reg_idx, q_vector->tx.itr_idx);
+		_qid++;
+	}
 
-	ice_for_each_rx_ring(rx_ring, q_vector->rx)
-		ice_cfg_rxq_interrupt(vsi, rx_ring->reg_idx, reg_idx,
-				      q_vector->rx.itr_idx);
+	_qid = qid;
+
+	for (q = 0; q < q_vector->num_ring_rx; q++) {
+		ice_cfg_rxq_interrupt(vsi, _qid, reg_idx, q_vector->rx.itr_idx);
+		_qid++;
+	}
 
 	ice_flush(hw);
 }
@@ -241,7 +245,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		fail = err;
 
 	q_vector = vsi->rx_rings[q_idx]->q_vector;
-	ice_qvec_cfg_msix(vsi, q_vector);
+	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
 
 	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
 	if (!fail)
-- 
2.34.1


