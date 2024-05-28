Return-Path: <netdev+bounces-98570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3A8D1CB0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946FFB26274
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA854177992;
	Tue, 28 May 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVoU0qps"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13611175570
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902147; cv=none; b=TQyGNBejUPqIT/VxlFUbvzCFMlB0EcoF5sJdN6jCD2aFQSq4YQd2pOgpqQ17Wn5rbjcJX2RvXIsuGiIu8edpst2v4ltV0ZuGSPH2putH8C/SQtIM7SLYIrPNtXe1IaoUiOmSt7Phdeh5uwt+4E3465McGqti5Z/oMX/WZ8nhaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902147; c=relaxed/simple;
	bh=v0cZw/C8zWmdW/96UfED93gGMqtozyU5z56YS5yvp8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwbKsRcZXWDI6lmVb8os0nF2TlsGnKUusU7scEhAXzkzYxhMXv5CihMb/pFZnRn5Zosj96EuiKHqiC0CiYiBILxJYzfdpMcWT5UyapoKQRVtAjfy3Izq/7eY3w1yTmuitaEP9L8e0OdoKQQ2+m7t+4uhOXvftRVgYU0NLDJTpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVoU0qps; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902147; x=1748438147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0cZw/C8zWmdW/96UfED93gGMqtozyU5z56YS5yvp8E=;
  b=nVoU0qpsxcWKXP8rgaPdVSYf6sZ2T2KWwodLAWWwBRMDnNHiwfPlDig/
   j08dIusz5KgCik2FTixHeOwmtWY3HIRboPAwQexSJNshiDCtQnl9+IVLz
   g6aWrwrYifkao8Ls+bjt2ZSiqmA5JwGLLMZ+QxqM8B9kevdnOouL+Oqhj
   sTK2iZy/caz+/qiH24Z/2KgeGcAXTzUgkXj1VIAQsKQp6hDt56pCvZA6L
   tLFjaLxyMzbqIg2N64EV84OcNtYz38YEOhnRJWugOxw+Cp5EaRFiVxMDf
   40K5Agy2N56FZwP0WUGvT6+IuVuqv8H0BliJpZxXPNkySGuMNxpRBR/HN
   A==;
X-CSE-ConnectionGUID: B8qWiYtiRjyon7VHmwf+zQ==
X-CSE-MsgGUID: /yLO1luiTeK3uUIJlvDICg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193559"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193559"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:46 -0700
X-CSE-ConnectionGUID: wOCgip5WQdO3GzRgR4NGQg==
X-CSE-MsgGUID: ZPK+e8ahQneQurjOC5v3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891167"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:44 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 08/11] ice: xsk: fix txq interrupt mapping
Date: Tue, 28 May 2024 15:14:26 +0200
Message-Id: <20240528131429.3012910-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
References: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_xsk.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index e554cf424fb3..3135fc0aaf73 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -113,23 +113,26 @@ ice_qvec_dis_irq(struct ice_vsi *vsi, struct ice_rx_ring *rx_ring,
  * @q_vector: queue vector
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
@@ -241,7 +244,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		fail = err;
 
 	q_vector = vsi->rx_rings[q_idx]->q_vector;
-	ice_qvec_cfg_msix(vsi, q_vector);
+	ice_qvec_cfg_msix(vsi, q_vector, q_idx);
 
 	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
 	if (!fail)
-- 
2.34.1


