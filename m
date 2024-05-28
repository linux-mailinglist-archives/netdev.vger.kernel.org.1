Return-Path: <netdev+bounces-98566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070088D1C8F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B6728726D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF62171E59;
	Tue, 28 May 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blF7HS8r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425D171671
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902138; cv=none; b=NkmqMwk/Qw24eAgJWUuHISWuh3uZQOI6ByyodywJlCUJlxAI1VSxfBYiWPckMxByyw+chnZpIpesqB/ZWa+RJs72OEQUADrQOJRiZAueciqlSpVYzsnRUGeCk0v2YJQZgAae3rOOo4PRl6IiZW+lvG8r9cZRaUF8nhN3jKdz7EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902138; c=relaxed/simple;
	bh=YVeYKEPpaAffYIVARbSPYcT3/ud4/QQnvxjXpeJuUIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGWTEVe6UD0IeOBrryKzg2QpI2S/afkv2mTsTCrjGUS2WXohf9A0bSeQf8vVosXmYFvPhNhR5wPr6Pu27ZljVfSP1UEI5xYYI9BzGpAASqi2daMd0YgalFAD0eSc5PgPDvILWkwTfP2vRXPwhi4YLMqGWRbZ868NqBOQg8gYSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blF7HS8r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902138; x=1748438138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YVeYKEPpaAffYIVARbSPYcT3/ud4/QQnvxjXpeJuUIY=;
  b=blF7HS8rxJ4G7+9oIyFUUUKYwlV2b4gKP7ofqXPLtNJyWxPWy5XobR/v
   /a9+k98UTyh1z7NVWYTxR344uwAqA5p7/4MzLYohDAaAdQrYY9xEaxhDc
   CgNn0oVz8YmbSWZ+q2bhjr7+vGz3PgjeNked1akyQHddnSA2+6EVJ2wsa
   aSGf5MeswI3i/XATio+rFN0RUKzxgD+PmELSmVnC2Tt/c9ftOedG5tkJ/
   wC4+eXPgN+Y1uZrZpHlxHKW6QgRB9HtjcfSjj67Ft16ruMmwgoyEpMOXA
   JPU6moNzCZIsxVo6uAtQGRtHwfxTU/+oaclzOfOAg3FqHwBkDSv6AJhWU
   w==;
X-CSE-ConnectionGUID: B2PM9EpKR7Cb6x9DsHi7eA==
X-CSE-MsgGUID: IkXd6XpLQWOnVaWLIL4MVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193535"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193535"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:38 -0700
X-CSE-ConnectionGUID: Gm3g5tZkT8WQ+I0uR5nKTg==
X-CSE-MsgGUID: QkrJuViXRKKVEnf6TapHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891126"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:35 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 04/11] ice: modify error handling when setting XSK pool in ndo_bpf
Date: Tue, 28 May 2024 15:14:22 +0200
Message-Id: <20240528131429.3012910-5-maciej.fijalkowski@intel.com>
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

Don't bail out right when spotting an error within ice_qp_{dis,ena}()
but rather track error and go through whole flow of disabling and
enabling queue pair.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index e93cb0ca4106..3dcab89be256 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -163,6 +163,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
 	int timeout = 50;
+	int fail = 0;
 	int err;
 
 	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
@@ -187,8 +188,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
-	if (err)
-		return err;
+	if (!fail)
+		fail = err;
 	if (ice_is_xdp_ena_vsi(vsi)) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
@@ -196,15 +197,15 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
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
@@ -217,32 +218,33 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
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
@@ -250,7 +252,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
-	return 0;
+	return fail;
 }
 
 /**
-- 
2.34.1


