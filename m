Return-Path: <netdev+bounces-98573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFD8D1CB7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6E4B238CF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565E178381;
	Tue, 28 May 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzDm7NVX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D616F836
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902166; cv=none; b=rJ+paFl/v+9P96i44dR64SoFFI3AyQGDW5+TbxuSxrEsFfOXN30emmIoGY4c5wo1dcfT/Zril24PDj/dPmJK/bREh7yIaCRUHz20bKJdkelcmoi2jxhrVhQ6UEY5mEUlPOFADZOVnTYR80mv5tTcp6qRPtE3OV/daFi+V5zkd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902166; c=relaxed/simple;
	bh=PiHcrt4MpBpN05Srlg+JhvwjicgYE6GmVyjVgxZdXqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H84pDbMk3Nr5/IbXWuwepZp4I30QUW4AuPnNiiSrDDrl+EIL0K+c3EMVSkTj9DnFRCeLbqNFOZariViSORs+bdSOZnb/a5cC9AgLmr3RTl8Ttgw19itCyynY6sv5RqDzfT+A+n/jVRiIZ/pp02sBP5e/oA04NKuqs5vbk+FZB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzDm7NVX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902165; x=1748438165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PiHcrt4MpBpN05Srlg+JhvwjicgYE6GmVyjVgxZdXqU=;
  b=lzDm7NVXC3o76ROiwXylScNhQqLerVRtXK8Uj2gFPOLkj83ltf+bs9+j
   pOmyeAPpsK3/3/mVdjSTRqAMvKDUQId8iIJfKD+ifMgjoY2hA0CJfvSW3
   w522dZXb0OyIRUUgrmjlCBuR6kXXKzNu15jKXP4T4n57cia6ZCJhRu6eU
   /TXGwfW9cqxUE9r2g3BYHDehivg3vux/F641/N+8rba1ni6cU1VB9RPpT
   y4HrFlU6zVf5axuHdPy3gZBQhVzNynpnDwGJw8KlTlkAlC00SnmsEbnPt
   DQYzcJ1eXGep8Y0cIUYVVAxA0GouM97k9DiaCm/Di0GIEMV9lKzhhW1rX
   g==;
X-CSE-ConnectionGUID: reTfTlbMQXeWYNQuir+KbA==
X-CSE-MsgGUID: lGfCzs+eQUWFnwfWt+KMhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193589"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:52 -0700
X-CSE-ConnectionGUID: UHB0bFdaQ6mUWy/OIdKRJA==
X-CSE-MsgGUID: eaDjYtd+SpWsHAwPorLzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891182"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:50 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com
Subject: [PATCH iwl-net 11/11] ice: protect ring configuration with a mutex
Date: Tue, 28 May 2024 15:14:29 +0200
Message-Id: <20240528131429.3012910-12-maciej.fijalkowski@intel.com>
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

Add a ring_lock mutex to protect sections, where software rings are
affected. Particularly, to prevent system crash, when tx_timeout
and .ndo_bpf() happen at the same time.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 23 ++++++++++---
 drivers/net/ethernet/intel/ice/ice_main.c | 39 ++++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 13 ++------
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 701a61d791dd..7c1e24afa34b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -307,6 +307,7 @@ enum ice_pf_state {
 	ICE_PHY_INIT_COMPLETE,
 	ICE_FD_VF_FLUSH_CTX,		/* set at FD Rx IRQ or timeout */
 	ICE_AUX_ERR_PENDING,
+	ICE_RTNL_WAITS_FOR_RESET,
 	ICE_STATE_NBITS		/* must be last */
 };
 
@@ -941,6 +942,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 			  enum ice_xdp_cfg cfg_type);
 int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
 void ice_map_xdp_rings(struct ice_vsi *vsi);
+bool ice_rebuild_pending(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7629b0190578..a5dc6fc6e63d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2426,7 +2426,10 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		dev_err(ice_pf_to_dev(pf), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
 			vsi->vsi_num, err);
 
-	if (ice_is_xdp_ena_vsi(vsi))
+	/* xdp_rings can be absent, if program was attached amid reset,
+	 * VSI rebuild is supposed to create them later
+	 */
+	if (ice_is_xdp_ena_vsi(vsi) && vsi->xdp_rings)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
@@ -2737,12 +2740,24 @@ ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
 	if (current_work() == &pf->serv_task ||
 	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
 	    test_bit(ICE_DOWN, pf->state) ||
-	    test_bit(ICE_SUSPENDED, pf->state))
+	    test_bit(ICE_SUSPENDED, pf->state)) {
+		bool rtnl_held_here = true;
+
+		while (!rtnl_trylock()) {
+			if (test_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state)) {
+				rtnl_held_here = false;
+				break;
+			}
+			usleep_range(1000, 2000);
+		}
 		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
-				     false);
-	else
+				     true);
+		if (rtnl_held_here)
+			rtnl_unlock();
+	} else {
 		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
 				     true);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 15a6805ac2a1..7724ed8fc1b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2986,6 +2986,20 @@ static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
 		return ICE_RXBUF_3072;
 }
 
+/**
+ * ice_rebuild_pending - ice_vsi_rebuild will be performed, when locks are released
+ * @vsi: VSI to setup XDP for
+ *
+ * ice_vsi_close() in the reset path is called under rtnl_lock(),
+ * so it happened strictly before or after .ndo_bpf().
+ * In case it has happened before, we do not have anything attached to rings
+ */
+bool ice_rebuild_pending(struct ice_vsi *vsi)
+{
+	return ice_is_reset_in_progress(vsi->back->state) &&
+	       !vsi->rx_rings[0]->desc;
+}
+
 /**
  * ice_xdp_setup_prog - Add or remove XDP eBPF program
  * @vsi: VSI to setup XDP for
@@ -3009,7 +3023,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	}
 
 	/* hot swap progs and avoid toggling link */
-	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog || ice_rebuild_pending(vsi)) {
 		ice_vsi_assign_bpf_prog(vsi, prog);
 		return 0;
 	}
@@ -3081,21 +3095,33 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	int ret;
 
 	if (vsi->type != ICE_VSI_PF) {
 		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
 		return -EINVAL;
 	}
 
+	while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
+		set_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
+		usleep_range(1000, 2000);
+	}
+	clear_bit(ICE_RTNL_WAITS_FOR_RESET, pf->state);
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
+		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
+		break;
 	case XDP_SETUP_XSK_POOL:
-		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
-					  xdp->xsk.queue_id);
+		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	clear_bit(ICE_CFG_BUSY, pf->state);
+	return ret;
 }
 
 /**
@@ -7672,7 +7698,10 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_gnss_init(pf);
 
 	/* rebuild PF VSI */
+	while (test_and_set_bit(ICE_CFG_BUSY, pf->state))
+		usleep_range(1000, 2000);
 	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_PF);
+	clear_bit(ICE_CFG_BUSY, pf->state);
 	if (err) {
 		dev_err(dev, "PF VSI rebuild failed: %d\n", err);
 		goto err_vsi_rebuild;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 225d027d3d7a..962af14f9fd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -370,7 +370,6 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
 	bool if_running, pool_present = !!pool;
 	int ret = 0, pool_failure = 0;
-	struct ice_pf *pf = vsi->back;
 
 	if (qid >= vsi->num_rxq || qid >= vsi->num_txq) {
 		netdev_err(vsi->netdev, "Please use queue id in scope of combined queues count\n");
@@ -378,18 +377,11 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 		goto failure;
 	}
 
-	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
+	if_running = !ice_rebuild_pending(vsi) &&
+		     (netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi));
 
 	if (if_running) {
 		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
-		int timeout = 50;
-
-		while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
-			timeout--;
-			if (!timeout)
-				return -EBUSY;
-			usleep_range(1000, 2000);
-		}
 
 		ret = ice_qp_dis(vsi, qid);
 		if (ret) {
@@ -412,7 +404,6 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 			napi_schedule(&vsi->rx_rings[qid]->xdp_ring->q_vector->napi);
 		else if (ret)
 			netdev_err(vsi->netdev, "ice_qp_ena error = %d\n", ret);
-		clear_bit(ICE_CFG_BUSY, pf->state);
 	}
 
 failure:
-- 
2.34.1


