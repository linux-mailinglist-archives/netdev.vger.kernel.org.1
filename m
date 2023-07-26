Return-Path: <netdev+bounces-21563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE6763E7F
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141F4281E48
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A03D383;
	Wed, 26 Jul 2023 18:28:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC9379BF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:28:01 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD91FC0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690396080; x=1721932080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/6zvG9aZL0ywtyFIa5u6k+eEbkh2Fm5jEMoWan4naQ=;
  b=HrmsTc346h7ZTaCFW6phjX0YJHsy9v29PTZpXQjfNU09KqycRbCL9wd9
   TMy1XaEfbC8qEI25el8f4P9dpQmmqqouq17FAc0x+DItFodKBuHO7snsG
   gqBbS13o9deiSoFIzQHnyb7/+nLEN4EqGPMRow9qxQntHVPx9+2gEZE2s
   Hh/xaHEyqKv+MA+33CsxwT7JBdyZFe67PMyjCh9fdLLdV6gXjCEun6xnc
   kaCgtahr2RmRUu4viUx08RVub0gBDM6C/LoKWcRT0FZv1gRfkCiqz4M9q
   Qe7pTj4aE2LmcORzt4mb+JM1VHNpG8dU3Oh2WnSKurxBod1eGAazs4w0S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368119096"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="368119096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756340051"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="756340051"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 11:27:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	simon.horman@corigine.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 08/10] ice: enforce interface eligibility and add messaging for SRIOV LAG
Date: Wed, 26 Jul 2023 11:21:39 -0700
Message-Id: <20230726182141.3797928-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
References: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Ertman <david.m.ertman@intel.com>

Implement checks on what interfaces are eligible for supporting SRIOV VFs
when a member of an aggregate interface.

Implement unwind path for interfaces that become ineligible.

checks for the SRIOV LAG feature bit wrap most of the functional code for
manipulating resources that apply to this feature.  Utilize this bit
to track compliant aggregates.  Also flag any new entries into the
aggregate as not supporting SRIOV LAG for the time they are in the
non-compliant aggregate.

Once an aggregate has been flagged as non-compliant, only unpopulating the
aggregate and re-populating it will return SRIOV LAG functionality.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 89 ++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index b717d920025d..44dae075aeb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -885,6 +885,7 @@ static void ice_lag_link(struct ice_lag *lag)
 
 	lag->bonded = true;
 	lag->role = ICE_LAG_UNSET;
+	netdev_info(lag->netdev, "Shared SR-IOV resources in bond are active\n");
 }
 
 /**
@@ -1329,6 +1330,7 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 	struct netdev_notifier_bonding_info *info;
 	struct netdev_bonding_info *bonding_info;
 	struct list_head *tmp;
+	struct device *dev;
 	int count = 0;
 
 	if (!lag->primary)
@@ -1341,11 +1343,21 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 	if (event_upper != lag->upper_netdev)
 		return true;
 
+	dev = ice_pf_to_dev(lag->pf);
+
+	/* only supporting switchdev mode for SRIOV VF LAG.
+	 * primary interface has to be in switchdev mode
+	 */
+	if (!ice_is_switchdev_running(lag->pf)) {
+		dev_info(dev, "Primary interface not in switchdev mode - VF LAG disabled\n");
+		return false;
+	}
+
 	info = (struct netdev_notifier_bonding_info *)ptr;
 	bonding_info = &info->bonding_info;
 	lag->bond_mode = bonding_info->master.bond_mode;
 	if (lag->bond_mode != BOND_MODE_ACTIVEBACKUP) {
-		netdev_info(lag->netdev, "Bond Mode not ACTIVE-BACKUP\n");
+		dev_info(dev, "Bond Mode not ACTIVE-BACKUP - VF LAG disabled\n");
 		return false;
 	}
 
@@ -1355,17 +1367,19 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 		struct ice_netdev_priv *peer_np;
 		struct net_device *peer_netdev;
 		struct ice_vsi *vsi, *peer_vsi;
+		struct ice_pf *peer_pf;
 
 		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
 		peer_netdev = entry->netdev;
 		if (!netif_is_ice(peer_netdev)) {
-			netdev_info(lag->netdev, "Found non-ice netdev in LAG\n");
+			dev_info(dev, "Found %s non-ice netdev in LAG - VF LAG disabled\n",
+				 netdev_name(peer_netdev));
 			return false;
 		}
 
 		count++;
 		if (count > 2) {
-			netdev_info(lag->netdev, "Found more than two netdevs in LAG\n");
+			dev_info(dev, "Found more than two netdevs in LAG - VF LAG disabled\n");
 			return false;
 		}
 
@@ -1374,7 +1388,8 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 		peer_vsi = peer_np->vsi;
 		if (lag->pf->pdev->bus != peer_vsi->back->pdev->bus ||
 		    lag->pf->pdev->slot != peer_vsi->back->pdev->slot) {
-			netdev_info(lag->netdev, "Found netdev on different device in LAG\n");
+			dev_info(dev, "Found %s on different device in LAG - VF LAG disabled\n",
+				 netdev_name(peer_netdev));
 			return false;
 		}
 
@@ -1382,7 +1397,15 @@ ice_lag_chk_comp(struct ice_lag *lag, void *ptr)
 		peer_dcb_cfg = &peer_vsi->port_info->qos_cfg.local_dcbx_cfg;
 		if (memcmp(dcb_cfg, peer_dcb_cfg,
 			   sizeof(struct ice_dcbx_cfg))) {
-			netdev_info(lag->netdev, "Found netdev with different DCB config in LAG\n");
+			dev_info(dev, "Found %s with different DCB in LAG - VF LAG disabled\n",
+				 netdev_name(peer_netdev));
+			return false;
+		}
+
+		peer_pf = peer_vsi->back;
+		if (test_bit(ICE_FLAG_FW_LLDP_AGENT, peer_pf->flags)) {
+			dev_warn(dev, "Found %s with FW LLDP agent active - VF LAG disabled\n",
+				 netdev_name(peer_netdev));
 			return false;
 		}
 	}
@@ -1455,6 +1478,58 @@ ice_lag_monitor_rdma(struct ice_lag *lag, void *ptr)
 		ice_set_rdma_cap(lag->pf);
 }
 
+/**
+ * ice_lag_chk_disabled_bond - monitor interfaces entering/leaving disabled bond
+ * @lag: lag info struct
+ * @ptr: opaque data containing event
+ *
+ * as interfaces enter a bond - determine if the bond is currently
+ * SRIOV LAG compliant and flag if not.  As interfaces leave the
+ * bond, reset their compliant status.
+ */
+static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct ice_lag *prim_lag;
+
+	if (netdev != lag->netdev)
+		return;
+
+	if (info->linking) {
+		prim_lag = ice_lag_find_primary(lag);
+		if (prim_lag &&
+		    !ice_is_feature_supported(prim_lag->pf, ICE_F_SRIOV_LAG)) {
+			ice_clear_feature_support(lag->pf, ICE_F_SRIOV_LAG);
+			netdev_info(netdev, "Interface added to non-compliant SRIOV LAG aggregate\n");
+		}
+	} else {
+		ice_lag_init_feature_support_flag(lag->pf);
+	}
+}
+
+/**
+ * ice_lag_disable_sriov_bond - set members of bond as not supporting SRIOV LAG
+ * @lag: primary interfaces lag struct
+ */
+static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
+{
+	struct ice_lag_netdev_list *entry;
+	struct ice_netdev_priv *np;
+	struct net_device *netdev;
+	struct list_head *tmp;
+	struct ice_pf *pf;
+
+	list_for_each(tmp, lag->netdev_head) {
+		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+		netdev = entry->netdev;
+		np = netdev_priv(netdev);
+		pf = np->vsi->back;
+
+		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
+	}
+}
+
 /**
  * ice_lag_process_event - process a task assigned to the lag_wq
  * @work: pointer to work_struct
@@ -1476,6 +1551,7 @@ static void ice_lag_process_event(struct work_struct *work)
 	switch (lag_work->event) {
 	case NETDEV_CHANGEUPPER:
 		info = &lag_work->info.changeupper_info;
+		ice_lag_chk_disabled_bond(lag_work->lag, info);
 		if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG)) {
 			ice_lag_monitor_link(lag_work->lag, info);
 			ice_lag_changeupper_event(lag_work->lag, info);
@@ -1487,6 +1563,9 @@ static void ice_lag_process_event(struct work_struct *work)
 		if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG)) {
 			if (!ice_lag_chk_comp(lag_work->lag,
 					      &lag_work->info.bonding_info)) {
+				netdev = lag_work->info.bonding_info.info.dev;
+				ice_lag_disable_sriov_bond(lag_work->lag);
+				ice_lag_unregister(lag_work->lag, netdev);
 				goto lag_cleanup;
 			}
 			ice_lag_monitor_active(lag_work->lag,
-- 
2.38.1


