Return-Path: <netdev+bounces-98572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B048D1CB6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2649286679
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45762178377;
	Tue, 28 May 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haYBOoFz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825316F262
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902165; cv=none; b=WIpjRhQeXV0Bj2fU+x7oAeWpBhCyRt8qaVAm5+rLfU805QyuK/VHKDNBIS6+wNn5P8gJmCU6Y6eyTqIlsP8oyOH8R1wNumx22e2VepnCH759mFLHJy+XGjV1GiAstWnJ5Xl1A+9WQ+djjuPBMlPPSA6N+Ga9ZJ+Bv7jsYwkhzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902165; c=relaxed/simple;
	bh=ETPGhiS7aB5sus5c74yVshGkoE8DOPIbYrYn+PvjTzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s1mhAZnqKGGYgpSs7eJV42eA6Ai/OqA48nJxCYAhxcI8YsrBsH//rdfrIlkNjhvtL/RI/poWDbRz9NjNqdEINRLs6bUJaq/Ct1nLOs5gMb8jtzk/hdX2HJo5LKqC8c/A1XJJzClMZgzL9rcmcnTNIozynQpzaKAlZwNxVioL/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haYBOoFz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902164; x=1748438164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETPGhiS7aB5sus5c74yVshGkoE8DOPIbYrYn+PvjTzk=;
  b=haYBOoFzEVPkFTBhsGDgcQ21UXADfxzBNFoX5STglKgYj2makDjgYNVC
   GCW6pgGQ2/cshyvR0Pg2wVbCxf0ftV4/lMepA8oSLgi04S1pEm+0iI25D
   X19fNwnH6Jv1rZnBxFSpaM0OOvPKT9rAHMX55LKqd2rIFH8yn9w64OK6W
   j80uZDSF6XM6BNf+MUmksxUQvlBFcPwGUcMV7YFsvEnPeK3yS/7HmAU7n
   h7oOhZrXMuQjQ7RftJkuVXFxO04DBjtXl9QeXjNDuGzg7VYIwnB3H1wXk
   RVX4P3GCwl2T6PuxtLHV6HH5x1iH5jwtyEHNcCoWbvIRMzWj3r8QwpXXy
   w==;
X-CSE-ConnectionGUID: X0JhsjodSkuPRkE2odL8TA==
X-CSE-MsgGUID: US8vnicVR+e9qbs02M7A8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193578"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:50 -0700
X-CSE-ConnectionGUID: Tk+RovD3Rg21ao04H38rUg==
X-CSE-MsgGUID: +kyv3pA3QH+wXIBzfQW+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891177"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com
Subject: [PATCH iwl-net 10/11] ice: lock with PF state instead of VSI state in ice_xsk_pool_setup()
Date: Tue, 28 May 2024 15:14:28 +0200
Message-Id: <20240528131429.3012910-11-maciej.fijalkowski@intel.com>
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

The main intent of using ICE_CFG_BUSY is to prevent the reset from
starting, when other configuration is being processed. pf->state is checked
before starting reset, but ice_xsk_pool_setup sets the flag in vsi->state,
which is almost useless. Also, ICE_CFG_BUSY belongs to enum ice_pf_state,
not ice_vsi_state.

Change vsi->state to pf->state in ice_xsk_pool_setup() locking code, so
reset would not interfere with AF_XDP configuration.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index fe4aa4b537dd..225d027d3d7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -370,6 +370,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
 	bool if_running, pool_present = !!pool;
 	int ret = 0, pool_failure = 0;
+	struct ice_pf *pf = vsi->back;
 
 	if (qid >= vsi->num_rxq || qid >= vsi->num_txq) {
 		netdev_err(vsi->netdev, "Please use queue id in scope of combined queues count\n");
@@ -383,7 +384,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
 		int timeout = 50;
 
-		while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
+		while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
 			timeout--;
 			if (!timeout)
 				return -EBUSY;
@@ -411,7 +412,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 			napi_schedule(&vsi->rx_rings[qid]->xdp_ring->q_vector->napi);
 		else if (ret)
 			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
-		clear_bit(ICE_CFG_BUSY, vsi->state);
+		clear_bit(ICE_CFG_BUSY, pf->state);
 	}
 
 failure:
-- 
2.34.1


