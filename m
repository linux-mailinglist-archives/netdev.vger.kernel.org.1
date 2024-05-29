Return-Path: <netdev+bounces-99008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04508D3582
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3DC1C22EDD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31402180A67;
	Wed, 29 May 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC8+m8CJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC618131B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981840; cv=none; b=k+vkTSOsjph5d2Pqh2Oc4Ecas4YwWgYUzHS8hyIEHbbSKZ7frLB01N2Mzq2gft6kV8pzNAcjGt5dUjo13pVspDyafd4Zajl5qgEgnGObYRZvlJNHtlz+X/VJtESAsipxg/m7yJ473ctVYefDW2CLkvqof7LeiT4VhsNZL+yaPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981840; c=relaxed/simple;
	bh=JxgorqeOgR50t13m+RvvtSW764Pt/UK0PXKKYocvqN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+aGpwVXxAroA6iVO4IrjsddtepSgjrC43jVksfoiI5015NUTIG6IV+ZXJ5dRSbK0O3ylYs/DkQL+uOthxCmc4hh/BOSsVx/NRkLKAuuKKSDTo97gNtn7kCd7W5bWsDzQuxlw8xRttKjy/Y7Bqich8qTDmEv7d+C4N9tcln1q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC8+m8CJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981838; x=1748517838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxgorqeOgR50t13m+RvvtSW764Pt/UK0PXKKYocvqN8=;
  b=DC8+m8CJs+IUgnDpXrFPhcSrqI0G7DCRHzpHEMRTWJ73EBgqojAHtWGc
   x+gXIJKXnh7D7MYNfuhQOjUtLrGn3d2AJBiClFT1Qhnx+mPyqBolPyTsV
   g+a0wjGEs7bNnhAYJHfNrCCs7btzfNvaX1IIBSUZThD3J/4Ksa+BZGxEY
   pOdht/C0AnEjkfJfrLY3JP5AshfsLF69qVwyRNDj15fa9NhBpZTXAXVqT
   Ui8TZjvUjp6VWFABeQVwdn9MC1cO7sdll2qPWGqr8WmCXXJarDbC2o0hi
   suYliDEYxFV1v1K04kzr2ddOb08IaGaHDpd1yr374sJOiRPyR2ZHCZAc2
   A==;
X-CSE-ConnectionGUID: S4jg2Q0NS7KbZnp0Uq+obA==
X-CSE-MsgGUID: rtLOHSwUSlOGT0eScALR/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169278"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:58 -0700
X-CSE-ConnectionGUID: AMy57ZThSt61j1VcW+Xi3w==
X-CSE-MsgGUID: qKJnVYjeQ62irQKp9uqrFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277195"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:56 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 8/8] ice: xsk: fix txq interrupt mapping
Date: Wed, 29 May 2024 13:23:37 +0200
Message-Id: <20240529112337.3639084-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
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
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 693f0e3a37ce..85aa841a16bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -111,25 +111,29 @@ ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
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


