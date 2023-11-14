Return-Path: <netdev+bounces-47795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621D7EB63E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FC21C20C31
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC83FE5D;
	Tue, 14 Nov 2023 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEZs7fiX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A32FC24
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB90FD
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985726; x=1731521726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l54GLRaBaI61RtfuyJyZZg5Ru6YTJgszvjuT93D6f2A=;
  b=bEZs7fiXy4UR69MXKnxEw2uVRyQV9K1cexyZwXN+EHlDjCjwRa0FunK1
   ch3BnMj4rSs+iBC6haLtyKN/rD0bgS5AANukIWjno9bG0f8ItX4qiUlDU
   1l6AbwqDyUvMtO+zeEtFWtSPP67YoVfjtzApRJCqo24FCcnGclK8QgCTE
   gZPoXelaR3MNWVcpxRkYvUCOnFH2nKDIY6SsfaFxkAmN8qGA0PIaBCVY0
   +9QjfmTKtMKGYh2Zj5u/iTLLumIYwOvm3hqr5WQP2pidooiPcArROUgx2
   IbHywi+YYSmDyLXEo3+GKgPq6YIC8r2Y8YJjDNFWGX+0Ult+UuYYICLuY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514541"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514541"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160975"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160975"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 15/15] ice: reserve number of CP queues
Date: Tue, 14 Nov 2023 10:14:35 -0800
Message-ID: <20231114181449.1290117-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Rebuilding CP VSI each time the PR is created drastically increase the
time of maximum VFs creation. Add function to reserve number of CP
queues to deal with this problem.

Use the same function to decrease number of queues in case of removing
VFs. Assume that caller of ice_eswitch_reserve_cp_queues() will also
call ice_eswitch_attach/detach() correct number of times.

Still one by one PR adding is handy for VF resetting routine.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


