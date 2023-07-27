Return-Path: <netdev+bounces-22062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4051A765CDE
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 22:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7199F28249F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431251DA23;
	Thu, 27 Jul 2023 20:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771A1CA0C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 20:04:34 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB62C1BC6
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690488272; x=1722024272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X1FT3wny6V6j1g2WLkfwvfi2J9vyPcS1SHkVUt+rZ+k=;
  b=Xhz5oEJJdCSr2tCvG/MeTuOLNLsbx0jekrQ1Wai3+1jNJ20PlBXhahOG
   nzcTRno9DJRxuWdR6Xl2jvoaAb4V1BeP3rSgzr4tBsJMk9Rh3dcK0RgN7
   DSWOThPMcr3QrgcFnTJVSxhPEsh/IV14CoJdpZIkTuOxaJqCN0JbG97t0
   pR6LbS2DJL0vQEGa6WYIHESyrALx5WLv5rSiZ13F741v8M4N8ZDMtAhAF
   3ycJ0+kuAuzAuQ4oHaO5drY6P1c7Cp3nwLflMSDYCsspnVLcXnpripsr5
   DsVi+r88VjYDny77k541G34YJnMhQOyjcyMhHDXYz6yjSJA6ruxxS/sql
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348030283"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348030283"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756826089"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="756826089"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 13:04:12 -0700
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
Subject: [PATCH net-next v2 04/10] ice: implement lag netdev event handler
Date: Thu, 27 Jul 2023 12:57:54 -0700
Message-Id: <20230727195800.204461-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
References: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Ertman <david.m.ertman@intel.com>

The event handler for LAG will create a work item to place on the ordered
workqueue to be processed.

Add in defines for training packets and new recipes to be used by the
switching block of the HW for LAG packet steering.

Update the ice_lag struct to reflect the new processing methodology.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 124 ++++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lag.h |  30 +++++-
 2 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index d018e68f5a6d..5725772cf8f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -56,11 +56,10 @@ static void ice_lag_set_backup(struct ice_lag *lag)
  */
 static void ice_display_lag_info(struct ice_lag *lag)
 {
-	const char *name, *peer, *upper, *role, *bonded, *primary;
+	const char *name, *upper, *role, *bonded, *primary;
 	struct device *dev = &lag->pf->pdev->dev;
 
 	name = lag->netdev ? netdev_name(lag->netdev) : "unset";
-	peer = lag->peer_netdev ? netdev_name(lag->peer_netdev) : "unset";
 	upper = lag->upper_netdev ? netdev_name(lag->upper_netdev) : "unset";
 	primary = lag->primary ? "TRUE" : "FALSE";
 	bonded = lag->bonded ? "BONDED" : "UNBONDED";
@@ -82,8 +81,8 @@ static void ice_display_lag_info(struct ice_lag *lag)
 		role = "ERROR";
 	}
 
-	dev_dbg(dev, "%s %s, peer:%s, upper:%s, role:%s, primary:%s\n", name,
-		bonded, peer, upper, role, primary);
+	dev_dbg(dev, "%s %s, upper:%s, role:%s, primary:%s\n", name, bonded,
+		upper, role, primary);
 }
 
 /**
@@ -198,7 +197,6 @@ ice_lag_unlink(struct ice_lag *lag,
 		lag->upper_netdev = NULL;
 	}
 
-	lag->peer_netdev = NULL;
 	ice_set_rdma_cap(pf);
 	lag->bonded = false;
 	lag->role = ICE_LAG_NONE;
@@ -288,6 +286,59 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 	ice_display_lag_info(lag);
 }
 
+/**
+ * ice_lag_process_event - process a task assigned to the lag_wq
+ * @work: pointer to work_struct
+ */
+static void ice_lag_process_event(struct work_struct *work)
+{
+	struct netdev_notifier_changeupper_info *info;
+	struct ice_lag_work *lag_work;
+	struct net_device *netdev;
+	struct list_head *tmp, *n;
+	struct ice_pf *pf;
+
+	lag_work = container_of(work, struct ice_lag_work, lag_task);
+	pf = lag_work->lag->pf;
+
+	mutex_lock(&pf->lag_mutex);
+	lag_work->lag->netdev_head = &lag_work->netdev_list.node;
+
+	switch (lag_work->event) {
+	case NETDEV_CHANGEUPPER:
+		info = &lag_work->info.changeupper_info;
+		ice_lag_changeupper_event(lag_work->lag, info);
+		break;
+	case NETDEV_BONDING_INFO:
+		ice_lag_info_event(lag_work->lag, &lag_work->info.bonding_info);
+		break;
+	case NETDEV_UNREGISTER:
+		if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG)) {
+			netdev = lag_work->info.bonding_info.info.dev;
+			if ((netdev == lag_work->lag->netdev ||
+			     lag_work->lag->primary) && lag_work->lag->bonded)
+				ice_lag_unregister(lag_work->lag, netdev);
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* cleanup resources allocated for this work item */
+	list_for_each_safe(tmp, n, &lag_work->netdev_list.node) {
+		struct ice_lag_netdev_list *entry;
+
+		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	lag_work->lag->netdev_head = NULL;
+
+	mutex_unlock(&pf->lag_mutex);
+
+	kfree(lag_work);
+}
+
 /**
  * ice_lag_event_handler - handle LAG events from netdev
  * @notif_blk: notifier block registered by this netdev
@@ -299,31 +350,79 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 		      void *ptr)
 {
 	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct net_device *upper_netdev;
+	struct ice_lag_work *lag_work;
 	struct ice_lag *lag;
 
-	lag = container_of(notif_blk, struct ice_lag, notif_block);
+	if (!netif_is_ice(netdev))
+		return NOTIFY_DONE;
+
+	if (event != NETDEV_CHANGEUPPER && event != NETDEV_BONDING_INFO &&
+	    event != NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
 
+	if (!(netdev->priv_flags & IFF_BONDING))
+		return NOTIFY_DONE;
+
+	lag = container_of(notif_blk, struct ice_lag, notif_block);
 	if (!lag->netdev)
 		return NOTIFY_DONE;
 
-	/* Check that the netdev is in the working namespace */
 	if (!net_eq(dev_net(netdev), &init_net))
 		return NOTIFY_DONE;
 
+	/* This memory will be freed at the end of ice_lag_process_event */
+	lag_work = kzalloc(sizeof(*lag_work), GFP_KERNEL);
+	if (!lag_work)
+		return -ENOMEM;
+
+	lag_work->event_netdev = netdev;
+	lag_work->lag = lag;
+	lag_work->event = event;
+	if (event == NETDEV_CHANGEUPPER) {
+		struct netdev_notifier_changeupper_info *info;
+
+		info = ptr;
+		upper_netdev = info->upper_dev;
+	} else {
+		upper_netdev = netdev_master_upper_dev_get(netdev);
+	}
+
+	INIT_LIST_HEAD(&lag_work->netdev_list.node);
+	if (upper_netdev) {
+		struct ice_lag_netdev_list *nd_list;
+		struct net_device *tmp_nd;
+
+		rcu_read_lock();
+		for_each_netdev_in_bond_rcu(upper_netdev, tmp_nd) {
+			nd_list = kzalloc(sizeof(*nd_list), GFP_KERNEL);
+			if (!nd_list)
+				break;
+
+			nd_list->netdev = tmp_nd;
+			list_add(&nd_list->node, &lag_work->netdev_list.node);
+		}
+		rcu_read_unlock();
+	}
+
 	switch (event) {
 	case NETDEV_CHANGEUPPER:
-		ice_lag_changeupper_event(lag, ptr);
+		lag_work->info.changeupper_info =
+			*((struct netdev_notifier_changeupper_info *)ptr);
 		break;
 	case NETDEV_BONDING_INFO:
-		ice_lag_info_event(lag, ptr);
-		break;
-	case NETDEV_UNREGISTER:
-		ice_lag_unregister(lag, netdev);
+		lag_work->info.bonding_info =
+			*((struct netdev_notifier_bonding_info *)ptr);
 		break;
 	default:
+		lag_work->info.notifier_info =
+			*((struct netdev_notifier_info *)ptr);
 		break;
 	}
 
+	INIT_WORK(&lag_work->lag_task, ice_lag_process_event);
+	queue_work(ice_lag_wq, &lag_work->lag_task);
+
 	return NOTIFY_DONE;
 }
 
@@ -398,7 +497,6 @@ int ice_init_lag(struct ice_pf *pf)
 	lag->netdev = vsi->netdev;
 	lag->role = ICE_LAG_NONE;
 	lag->bonded = false;
-	lag->peer_netdev = NULL;
 	lag->upper_netdev = NULL;
 	lag->notif_block.notifier_call = NULL;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index 2c373676c42f..a4314a46c82c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -14,20 +14,48 @@ enum ice_lag_role {
 	ICE_LAG_UNSET
 };
 
+#define ICE_LAG_INVALID_PORT 0xFF
+
 struct ice_pf;
+struct ice_vf;
+
+struct ice_lag_netdev_list {
+	struct list_head node;
+	struct net_device *netdev;
+};
 
 /* LAG info struct */
 struct ice_lag {
 	struct ice_pf *pf; /* backlink to PF struct */
 	struct net_device *netdev; /* this PF's netdev */
-	struct net_device *peer_netdev;
 	struct net_device *upper_netdev; /* upper bonding netdev */
+	struct list_head *netdev_head;
 	struct notifier_block notif_block;
+	s32 bond_mode;
+	u16 bond_swid; /* swid for primary interface */
+	u8 active_port; /* lport value for the current active port */
 	u8 bonded:1; /* currently bonded */
 	u8 primary:1; /* this is primary */
+	u16 pf_recipe;
+	u16 pf_rule_id;
+	u16 cp_rule_idx;
 	u8 role;
 };
 
+/* LAG workqueue struct */
+struct ice_lag_work {
+	struct work_struct lag_task;
+	struct ice_lag_netdev_list netdev_list;
+	struct ice_lag *lag;
+	unsigned long event;
+	struct net_device *event_netdev;
+	union {
+		struct netdev_notifier_changeupper_info changeupper_info;
+		struct netdev_notifier_bonding_info bonding_info;
+		struct netdev_notifier_info notifier_info;
+	} info;
+};
+
 int ice_init_lag(struct ice_pf *pf);
 void ice_deinit_lag(struct ice_pf *pf);
 #endif /* _ICE_LAG_H_ */
-- 
2.38.1


