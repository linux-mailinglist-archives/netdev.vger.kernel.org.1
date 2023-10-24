Return-Path: <netdev+bounces-43834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF157D4EF8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703B32819CB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0D273CC;
	Tue, 24 Oct 2023 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWTS8td/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743A262AB
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:35:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685FAC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147317; x=1729683317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EAMD0jNiRaewglGSb4G3nZUn8vvQClD5emTa18/MaeY=;
  b=QWTS8td/R9FIqld01zQjRoUYFwXwaDI8eWH3SR82ABgFzfahmJ1OiPaQ
   hrUhnuaPhd8Fk5WjnPKfyCnCBgsFCKj+PSmdTSx35gNi05jfUixhWRjAk
   HItA1wfY5RUcRytBkBrUDLZgASF6B18buWB9lxGbGEf7FTz+jgUOg56EV
   r8sgG1jE/bD5ZX0t/yFBKBtq+grvn2H91nTfQ/VlYrc6Od8I3vqe61JiB
   Uh8l+rYJ4kDMgv8+fr6H195eTYI+4TQQpJlSr5vpp9PQYfj0YRjvC1h3Q
   BoD8bAMUY6DNq3ZFqQf3L+6uX5oes9ZKJS0Ld57zbhYj2QqV3UPj1C3B9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660579"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660579"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146314"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:56 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 15/15] ice: reserve number of CP queues
Date: Tue, 24 Oct 2023 13:09:29 +0200
Message-ID: <20231024110929.19423-16-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebuilding CP VSI each time the PR is created drastically increase the
time of maximum VFs creation. Add function to reserve number of CP
queues to deal with this problem.

Use the same function to decrease number of queues in case of removing
VFs. Assume that caller of ice_eswitch_reserve_cp_queues() will also
call ice_eswitch_attach/detach() correct number of times.

Still one by one PR adding is handy for VF resetting routine.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  6 +++
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 52 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_sriov.c   |  3 ++
 4 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 597bdb6945c6..cd7dcd0fa7f2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -528,6 +528,12 @@ struct ice_eswitch {
 	struct ice_esw_br_offloads *br_offloads;
 	struct xarray reprs;
 	bool is_running;
+	/* struct to allow cp queues management optimization */
+	struct {
+		int to_reach;
+		int value;
+		bool is_reaching;
+	} qs;
 };
 
 struct ice_agg_node {
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 9ff4fe4fb133..3f80e2081e5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -176,7 +176,7 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_eswitch *eswitch)
 
 		repr = xa_find(&eswitch->reprs, &repr_id, U32_MAX,
 			       XA_PRESENT);
-		if (WARN_ON(!repr))
+		if (!repr)
 			break;
 
 		repr_id += 1;
@@ -455,6 +455,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 		return -ENODEV;
 
 	ctrl_vsi = pf->eswitch.control_vsi;
+	/* cp VSI is createad with 1 queue as default */
+	pf->eswitch.qs.value = 1;
 	pf->eswitch.uplink_vsi = uplink_vsi;
 
 	if (ice_eswitch_setup_env(pf))
@@ -487,6 +489,7 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_vsi_release(ctrl_vsi);
 
 	pf->eswitch.is_running = false;
+	pf->eswitch.qs.is_reaching = false;
 }
 
 /**
@@ -615,15 +618,33 @@ static void
 ice_eswitch_cp_change_queues(struct ice_eswitch *eswitch, int change)
 {
 	struct ice_vsi *cp = eswitch->control_vsi;
+	int queues = 0;
+
+	if (eswitch->qs.is_reaching) {
+		if (eswitch->qs.to_reach >= eswitch->qs.value + change) {
+			queues = eswitch->qs.to_reach;
+			eswitch->qs.is_reaching = false;
+		} else {
+			queues = 0;
+		}
+	} else if ((change > 0 && cp->alloc_txq <= eswitch->qs.value) ||
+		   change < 0) {
+		queues = cp->alloc_txq + change;
+	}
 
-	ice_vsi_close(cp);
+	if (queues) {
+		cp->req_txq = queues;
+		cp->req_rxq = queues;
+		ice_vsi_close(cp);
+		ice_vsi_rebuild(cp, ICE_VSI_FLAG_NO_INIT);
+		ice_vsi_open(cp);
+	} else if (!change) {
+		/* change == 0 means that VSI wasn't open, open it here */
+		ice_vsi_open(cp);
+	}
 
-	cp->req_txq = cp->alloc_txq + change;
-	cp->req_rxq = cp->alloc_rxq + change;
-	ice_vsi_rebuild(cp, ICE_VSI_FLAG_NO_INIT);
+	eswitch->qs.value += change;
 	ice_eswitch_remap_rings_to_vectors(eswitch);
-
-	ice_vsi_open(cp);
 }
 
 int
@@ -641,6 +662,7 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 		if (err)
 			return err;
 		/* Control plane VSI is created with 1 queue as default */
+		pf->eswitch.qs.to_reach -= 1;
 		change = 0;
 	}
 
@@ -732,3 +754,19 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 
 	return 0;
 }
+
+/**
+ * ice_eswitch_reserve_cp_queues - reserve control plane VSI queues
+ * @pf: pointer to PF structure
+ * @change: how many more (or less) queues is needed
+ *
+ * Remember to call ice_eswitch_attach/detach() the "change" times.
+ */
+void ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change)
+{
+	if (pf->eswitch.qs.value + change < 0)
+		return;
+
+	pf->eswitch.qs.to_reach = pf->eswitch.qs.value + change;
+	pf->eswitch.qs.is_reaching = true;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 59d51c0d14e5..1a288a03a79a 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -26,6 +26,7 @@ void ice_eswitch_set_target_vsi(struct sk_buff *skb,
 				struct ice_tx_offload_params *off);
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
+void ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
 
@@ -76,5 +77,8 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	return NETDEV_TX_BUSY;
 }
+
+static inline void
+ice_eswitch_reserve_cp_queues(struct ice_pf *pf, int change) { }
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 51f5f420d632..5a45bd5ce6ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -172,6 +172,8 @@ void ice_free_vfs(struct ice_pf *pf)
 	else
 		dev_warn(dev, "VFs are assigned - not disabling SR-IOV\n");
 
+	ice_eswitch_reserve_cp_queues(pf, -ice_get_num_vfs(pf));
+
 	mutex_lock(&vfs->table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
@@ -930,6 +932,7 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 		goto err_unroll_sriov;
 	}
 
+	ice_eswitch_reserve_cp_queues(pf, num_vfs);
 	ret = ice_start_vfs(pf);
 	if (ret) {
 		dev_err(dev, "Failed to start %d VFs, err %d\n", num_vfs, ret);
-- 
2.41.0


