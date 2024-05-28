Return-Path: <netdev+bounces-98571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9D8D1CB5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747A21F236F8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407116F834;
	Tue, 28 May 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAYh3522"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF888178372
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902164; cv=none; b=dt6EXLAm/gq2Nn45SfHUB9dWPkiSN+j6D3SS/seczWSrsnQnLZjc5kqHx5t4X1zDMMk/i/yeKDDC1x7JIRgwjU8VYgQUD3m1k2B7/K+QIWe/XQ7WlaXPzabBUnkrJFnKr82EvKd8AQ18Ux4tsJ8etDNWUX7TG90FL1v2eIIUeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902164; c=relaxed/simple;
	bh=9ibL8cpkE1BEVaC2RFbojcJo454wmbd9a09sM9ZH/l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ok/SFx3lWAsq+3wVP8cFZuUDn0XRlst19DnSOmMrv6pGWdMUfo3YWtgPI5vQQJm1M2iekxlUrqaI7Oknd3QLVU7Z6k/QWqyohedVhBU7aUp/mFgGyu0QKBR1Wh1VuX7XAFhrP1sWdwKh90JXzxv7D3hP7lPptBrqcn9ZxRUkMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAYh3522; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902163; x=1748438163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ibL8cpkE1BEVaC2RFbojcJo454wmbd9a09sM9ZH/l0=;
  b=bAYh3522X/RNigmOU1tI0b4QPas8qChgQLicS+5SLigy2MV7yt4PCKzW
   QWRSxZ2d0IUqqGH9lc0gdyAjWpjOh+VB+YmJ23Pfz6tFUh6bbfh6OL6Ro
   qr4FP9AQWPvNEFkdSKSkCyA0lCRN8iayWpbNhXp6H2DEj9xEdDPZFbhMb
   cUjo0UcP5q3Ag6z4kxYNBB0b4wKXrnPukO3rrHc1Qv/v9YX9yuJ0TOKjI
   LZDth5zb0RJLzJ0Lpgis7uCi4eDAVBBXWa4uw9mtsS/Md7SCC8CzF1vj/
   omJb+wjgeSem9/BbhFdgkG6pG+mAGQs2Fq9y+qpu5WFPxGdbJz6EAN45r
   Q==;
X-CSE-ConnectionGUID: DVhwOpvQSqiAYaSRPaDPlQ==
X-CSE-MsgGUID: tD0jleptT3aXVQbUiUMuLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193569"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:48 -0700
X-CSE-ConnectionGUID: 9YdYx1YpRYOPzJySl5u6Uw==
X-CSE-MsgGUID: eUBxHCQ4SluH2zrAs3gsfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891171"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:46 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com
Subject: [PATCH iwl-net 09/11] ice: move locking outside of ice_qp_ena and ice_qp_dis
Date: Tue, 28 May 2024 15:14:27 +0200
Message-Id: <20240528131429.3012910-10-maciej.fijalkowski@intel.com>
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

From: Larysa Zaremba <larysa.zaremba@intel.com>

Currently, ice_qp_ena() is called, even if ICE_CFG_BUSY could not be
acquired by ice_qp_dis(), in such case there is nothing to undo.
Move locking logic out of these functions, so:
* we immediately return, if the lock could not be acquired
* ice_qp_ena() does not operate in an unsafe context
* ice_qp_ena() does not clear ICE_CFG_BUSY, when it is not held

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 3135fc0aaf73..fe4aa4b537dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -165,7 +165,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_q_vector *q_vector;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	int timeout = 50;
 	int fail = 0;
 	int err;
 
@@ -176,13 +175,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	rx_ring = vsi->rx_rings[q_idx];
 	q_vector = rx_ring->q_vector;
 
-	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-		usleep_range(1000, 2000);
-	}
-
 	synchronize_net();
 	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
@@ -257,7 +249,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	synchronize_net();
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 	netif_carrier_on(vsi->netdev);
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
 }
@@ -390,6 +381,14 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 
 	if (if_running) {
 		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
+		int timeout = 50;
+
+		while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
+			timeout--;
+			if (!timeout)
+				return -EBUSY;
+			usleep_range(1000, 2000);
+		}
 
 		ret = ice_qp_dis(vsi, qid);
 		if (ret) {
@@ -412,6 +411,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 			napi_schedule(&vsi->rx_rings[qid]->xdp_ring->q_vector->napi);
 		else if (ret)
 			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
+		clear_bit(ICE_CFG_BUSY, vsi->state);
 	}
 
 failure:
-- 
2.34.1


