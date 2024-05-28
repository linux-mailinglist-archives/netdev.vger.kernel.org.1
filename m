Return-Path: <netdev+bounces-98565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D18D1C89
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A14B2422B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE7171668;
	Tue, 28 May 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljdslKUq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895117108B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902136; cv=none; b=P47O4Ic8Yp2qQyI9pIIb3+gLvppeKZDbfTJkBdNGnOZbj7oWjH4FuqfnWnIiukap58Bgi0nz3xEbnko143N07Zg6s6DOxBe6Z2fR8RODm9pTyo7X+pjGwnDxBugFzoHO91K6JOLHEfv2LmXdPIR2VuAb3uYJ4G5trVK99xw0rRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902136; c=relaxed/simple;
	bh=k+t6/dW0a7XTqHTJyIkOeGq6uYftDeoAQY5f4RgHSbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNb5A6pzDgEiLKsDevZMbGf8mm4+Mzx76KUi7zm+aHDi1Gtj0fz+vuHzxNAaS+ZOOBPGBHJygahER72u547PMQLYYmIt30bMxmB51ueXk6P9kljG7GnM/lxeOTf/rsD2KV+kKaxBnRy3zrtUWM0jYFouWaNL69/9stea7FIbhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljdslKUq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902135; x=1748438135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+t6/dW0a7XTqHTJyIkOeGq6uYftDeoAQY5f4RgHSbU=;
  b=ljdslKUqp6eK1I3oYWPok+Xwk9PwEjujkFOSHjC1RHQIFsLmburCW5Rq
   n+IOhvORetp9OyOJSTo7UCp3FVxKSjHV/Bpxo+aQUu+xL6kjQ1Ju/QbP+
   +lEF0qfAzwnDc2vaNHi8StNnyOVYXNNf91u/eoEbcnbhnbXSNAQUMtGd6
   b0txhPCtdX0b4FldrUyb1yziKGGywLPJTXNX3oXtCZoU8cTiK17Rixf0X
   J0UlCiXvr9ZDT8iywJtlqtmH+nkjfeJES6021NEdl127qjJsqs7F8dCWf
   uFM68/osRCpvm2BqvUl3d9huL8aHtxjteaB6XwWk7FyXtL9t+oNbado2q
   A==;
X-CSE-ConnectionGUID: hzlzGmfoTruVSXm9lxQI7g==
X-CSE-MsgGUID: wFlF9J/1Tz27AacgTb89lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193531"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193531"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:35 -0700
X-CSE-ConnectionGUID: w43hokqDTl68StL9KdAGiA==
X-CSE-MsgGUID: iIOK/ey0Sx+/bDS+xpjKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891117"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:33 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 03/11] ice: replace synchronize_rcu with synchronize_net
Date: Tue, 28 May 2024 15:14:21 +0200
Message-Id: <20240528131429.3012910-4-maciej.fijalkowski@intel.com>
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

Given that ice_qp_dis() is called under rtnl_lock, synchronize_net() can
be called instead of synchronize_rcu() so that XDP rings can finish its
job in a faster way. Also let us do this as earlier in XSK queue disable
flow.

Additionally, turn off regular Tx queue before disabling irqs and NAPI.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 4f606a1055b0..e93cb0ca4106 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -53,7 +53,6 @@ static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
 	if (ice_is_xdp_ena_vsi(vsi)) {
-		synchronize_rcu();
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
 	}
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
@@ -180,11 +179,12 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		usleep_range(1000, 2000);
 	}
 
+	synchronize_net();
+	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
 	ice_qvec_toggle_napi(vsi, q_vector, false);
 
-	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
-
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (err)
-- 
2.34.1


