Return-Path: <netdev+bounces-81766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F288B14F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF961C38AA5
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92A4E1C1;
	Mon, 25 Mar 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCkpcS4P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B045C08
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398395; cv=none; b=JBVDKu5RM8VQNXl/0ZUXl8HcU4ii8P0DpPb41I9914XhaAj+2ZLo1iX+9Xuy+ElS56YBg40VbKbPmxVOKV7rsdSUvMX6MY5ew1BKIVmcG+vN+BHUw7qAvhhQTeK+XTS/V13/hlg5PutbKR9hdjWXWCBgn7uSCqd+t2CpUhBkVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398395; c=relaxed/simple;
	bh=ibTzgpSt1azRhHQoaI6e3OIxdkCOn3zzmRB6SbSwlgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFQ/tTiq442mqbrcBFoEI9ViYgtH1oY4oKx5xxPp0Krs+mw1UyyRN+t87jf4+jQgGphLkOKE6MyO7L9RbJbsY+PsYaJF07MJgNsbQ2kuUO42QFzAr6hEvPKXcUgmKqYD2tYCLXQsxq4hSAFYguOZrbbSqEfF9x3d9W605wbcG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCkpcS4P; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398394; x=1742934394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibTzgpSt1azRhHQoaI6e3OIxdkCOn3zzmRB6SbSwlgI=;
  b=eCkpcS4Pk+NOtVYyhYnlo+ZfSPITLSQ0C0m6k6TxtvOdtDbWZrcqoWlq
   X2TOEdDytKBPPiPDJKjrED4ACX+8YTG1C9yk39q5n4/w/rfChrRHU+sbz
   JGquKBvz1AkePKbpQtvmszqUpy1q8ZjM0AGbW2XkYZlHmc11tFXjxw+ql
   Iqed07vEU9pSgLecVq3T89Py92Svyzepbq718Q9R3KzaXv81xK2nddF/6
   xZJ713LVN/fkEu4rOC6zqeheh6UmFYOas1PvS18vc+l8flmIezZexJYGF
   vIZwgJU/7NMGktyXncah4a32pnis7SLHDsk7O6GmjhtYoWXQQa0ygYxTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219634"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219634"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787365"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 1/8] ice: remove eswitch changing queues algorithm
Date: Mon, 25 Mar 2024 13:26:09 -0700
Message-ID: <20240325202623.1012287-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
References: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Changing queues used by eswitch will be done through PF netdev.
There is no need to reserve queues if the number of used queues
is known.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  6 ----
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 34 --------------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ---
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  3 --
 4 files changed, 47 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 365c03d1c462..9bb435b4338f 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -527,12 +527,6 @@ struct ice_eswitch {
 	struct ice_esw_br_offloads *br_offloads;
 	struct xarray reprs;
 	bool is_running;
-	/* struct to allow cp queues management optimization */
-	struct {
-		int to_reach;
-		int value;
-		bool is_reaching;
-	} qs;
 };
 
 struct ice_agg_node {
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 9069725c71b4..2e999f801c0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -455,8 +455,6 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 		return -ENODEV;
 
 	ctrl_vsi = pf->eswitch.control_vsi;
-	/* cp VSI is createad with 1 queue as default */
-	pf->eswitch.qs.value = 1;
 	pf->eswitch.uplink_vsi = uplink_vsi;
 
 	if (ice_eswitch_setup_env(pf))
@@ -489,7 +487,6 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_vsi_release(ctrl_vsi);
 
 	pf->eswitch.is_running = false;
-	pf->eswitch.qs.is_reaching = false;
 }
 
 /**
@@ -620,18 +617,6 @@ ice_eswitch_cp_change_queues(struct ice_eswitch *eswitch, int change)
 	struct ice_vsi *cp = eswitch->control_vsi;
 	int queues = 0;
 
-	if (eswitch->qs.is_reaching) {
-		if (eswitch->qs.to_reach >= eswitch->qs.value + change) {
-			queues = eswitch->qs.to_reach;
-			eswitch->qs.is_reaching = false;
-		} else {
-			queues = 0;
-		}
-	} else if ((change > 0 && cp->alloc_txq <= eswitch->qs.value) ||
-		   change < 0) {
-		queues = cp->alloc_txq + change;
-	}
-
 	if (queues) {
 		cp->req_txq = queues;
 		cp->req_rxq = queues;
@@ -643,7 +628,6 @@ ice_eswitch_cp_change_queues(struct ice_eswitch *eswitch, int change)
 		ice_vsi_open(cp);
 	}
 
-	eswitch->qs.value += change;
 	ice_eswitch_remap_rings_to_vectors(eswitch);
 }
 
@@ -661,8 +645,6 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 		err = ice_eswitch_enable_switchdev(pf);
 		if (err)
 			return err;
-		/* Control plane VSI is created with 1 queue as default */
-		pf->eswitch.qs.to_reach -= 1;
 		change = 0;
 	}
 
@@ -756,19 +738,3 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 
 	return 0;
 }
-
-/**
- * ice_eswitch_reserve_cp_queues - reserve control plane VSI queues
- * @pf: pointer to PF structure
- * @change: how many more (or less) queues is needed
- *
- * Remember to call ice_eswitch_attach/detach() the "change" times.
- */
-void ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change)
-{
-	if (pf->eswitch.qs.value + change < 0)
-		return;
-
-	pf->eswitch.qs.to_reach = pf->eswitch.qs.value + change;
-	pf->eswitch.qs.is_reaching = true;
-}
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 1a288a03a79a..59d51c0d14e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -26,7 +26,6 @@ void ice_eswitch_set_target_vsi(struct sk_buff *skb,
 				struct ice_tx_offload_params *off);
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
-void ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
 
@@ -77,8 +76,5 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	return NETDEV_TX_BUSY;
 }
-
-static inline void
-ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change) { }
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a958fcf3e6be..65e1986af777 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -170,8 +170,6 @@ void ice_free_vfs(struct ice_pf *pf)
 	else
 		dev_warn(dev, "VFs are assigned - not disabling SR-IOV\n");
 
-	ice_eswitch_reserve_cp_queues(pf, -ice_get_num_vfs(pf));
-
 	mutex_lock(&vfs->table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
@@ -897,7 +895,6 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 		goto err_unroll_sriov;
 	}
 
-	ice_eswitch_reserve_cp_queues(pf, num_vfs);
 	ret = ice_start_vfs(pf);
 	if (ret) {
 		dev_err(dev, "Failed to start %d VFs, err %d\n", num_vfs, ret);
-- 
2.41.0


