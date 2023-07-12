Return-Path: <netdev+bounces-17105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C23750591
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C58E281726
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098152AB2E;
	Wed, 12 Jul 2023 11:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5932AB25
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:05:19 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286010C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689159918; x=1720695918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQxsEgsoiBbj0OZ5yKcpijsR9PTbP+sYvkMrlykovDM=;
  b=iNllGQ82VyIszK/fX884T37lMrpYrzA3UfezSuO+p9n7p5jCwMOWy8Zc
   NH71xP0JxtnO5rHuDu7A4+ZjDCboyKzZHr5rRijcRsIIBtO9hacPF0k+y
   B5ifZAxZ0sUhR6IKYHO6lHACsZyWd0gxGMHbuznhWnAmLuVuZ3zXeTrvY
   gI0PRiKNF1dhyLCQg7+TuuD5diRCE9t6pG91HM//2KICwtXvfGwPb7SxI
   2LAx+NxQtEAsxx1sqhrF6XhemrGKL/jgBzhvDv6cnlVCZBXlAQgoOv/qJ
   tIxRtBKsMVk1xGBKxSuTSVOhlYpMMPpFkCUayo10vXVsJX1xMEtaTjumK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430993840"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="430993840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835093806"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="835093806"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 04:05:04 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3C93E369EF;
	Wed, 12 Jul 2023 12:05:03 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	david.m.ertman@intel.com,
	michal.swiatkowski@linux.intel.com,
	marcin.szycik@linux.intel.com,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	pmenzel@molgen.mpg.de,
	simon.horman@corigine.com,
	dan.carpenter@linaro.org,
	vladbu@nvidia.com
Subject: [PATCH iwl-next v6 11/12] ice: implement static version of ageing
Date: Wed, 12 Jul 2023 13:03:36 +0200
Message-Id: <20230712110337.8030-12-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712110337.8030-1-wojciech.drewek@intel.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Remove fdb entries always when ageing time expired.

Allow user to set ageing time using port object attribute.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2: use msecs_to_jiffies upon definition of
    ICE_ESW_BRIDGE_UPDATE_INTERVA
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 48 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_eswitch_br.h   | 10 ++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 20355c633000..9ccd082f9ac4 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -8,6 +8,8 @@
 #include "ice_vlan.h"
 #include "ice_vf_vsi_vlan_ops.h"
 
+#define ICE_ESW_BRIDGE_UPDATE_INTERVAL msecs_to_jiffies(1000)
+
 static const struct rhashtable_params ice_fdb_ht_params = {
 	.key_offset = offsetof(struct ice_esw_br_fdb_entry, data),
 	.key_len = sizeof(struct ice_esw_br_fdb_data),
@@ -406,6 +408,7 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
 	fdb_entry->br_port = br_port;
 	fdb_entry->flow = flow;
 	fdb_entry->dev = netdev;
+	fdb_entry->last_use = jiffies;
 	event = SWITCHDEV_FDB_ADD_TO_BRIDGE;
 
 	if (added_by_user) {
@@ -805,6 +808,10 @@ ice_eswitch_br_port_obj_attr_set(struct net_device *netdev, const void *ctx,
 		ice_eswitch_br_vlan_filtering_set(br_port->bridge,
 						  attr->u.vlan_filtering);
 		return 0;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		br_port->bridge->ageing_time =
+			clock_t_to_jiffies(attr->u.ageing_time);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -976,6 +983,7 @@ ice_eswitch_br_init(struct ice_esw_br_offloads *br_offloads, int ifindex)
 	INIT_LIST_HEAD(&bridge->fdb_list);
 	bridge->br_offloads = br_offloads;
 	bridge->ifindex = ifindex;
+	bridge->ageing_time = clock_t_to_jiffies(BR_DEFAULT_AGEING_TIME);
 	xa_init(&bridge->ports);
 	br_offloads->bridge = bridge;
 
@@ -1171,6 +1179,7 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
 	if (!br_offloads)
 		return;
 
+	cancel_delayed_work_sync(&br_offloads->update_work);
 	unregister_netdevice_notifier(&br_offloads->netdev_nb);
 	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
 	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
@@ -1185,6 +1194,40 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
 	rtnl_unlock();
 }
 
+static void ice_eswitch_br_update(struct ice_esw_br_offloads *br_offloads)
+{
+	struct ice_esw_br *bridge = br_offloads->bridge;
+	struct ice_esw_br_fdb_entry *entry, *tmp;
+
+	if (!bridge)
+		return;
+
+	rtnl_lock();
+	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list) {
+		if (entry->flags & ICE_ESWITCH_BR_FDB_ADDED_BY_USER)
+			continue;
+
+		if (time_is_after_eq_jiffies(entry->last_use +
+					     bridge->ageing_time))
+			continue;
+
+		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
+	}
+	rtnl_unlock();
+}
+
+static void ice_eswitch_br_update_work(struct work_struct *work)
+{
+	struct ice_esw_br_offloads *br_offloads;
+
+	br_offloads = ice_work_to_br_offloads(work);
+
+	ice_eswitch_br_update(br_offloads);
+
+	queue_delayed_work(br_offloads->wq, &br_offloads->update_work,
+			   ICE_ESW_BRIDGE_UPDATE_INTERVAL);
+}
+
 int
 ice_eswitch_br_offloads_init(struct ice_pf *pf)
 {
@@ -1233,6 +1276,11 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
 		goto err_reg_netdev_nb;
 	}
 
+	INIT_DELAYED_WORK(&br_offloads->update_work,
+			  ice_eswitch_br_update_work);
+	queue_delayed_work(br_offloads->wq, &br_offloads->update_work,
+			   ICE_ESW_BRIDGE_UPDATE_INTERVAL);
+
 	return 0;
 
 err_reg_netdev_nb:
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index 978e9ce8e277..85a8fadb2928 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -5,6 +5,7 @@
 #define _ICE_ESWITCH_BR_H_
 
 #include <linux/rhashtable.h>
+#include <linux/workqueue.h>
 
 struct ice_esw_br_fdb_data {
 	unsigned char addr[ETH_ALEN];
@@ -30,6 +31,8 @@ struct ice_esw_br_fdb_entry {
 	struct net_device *dev;
 	struct ice_esw_br_port *br_port;
 	struct ice_esw_br_flow *flow;
+
+	unsigned long last_use;
 };
 
 enum ice_esw_br_port_type {
@@ -59,6 +62,7 @@ struct ice_esw_br {
 
 	int ifindex;
 	u32 flags;
+	unsigned long ageing_time;
 };
 
 struct ice_esw_br_offloads {
@@ -69,6 +73,7 @@ struct ice_esw_br_offloads {
 	struct notifier_block switchdev_nb;
 
 	struct workqueue_struct *wq;
+	struct delayed_work update_work;
 };
 
 struct ice_esw_br_fdb_work {
@@ -88,6 +93,11 @@ struct ice_esw_br_vlan {
 		     struct ice_esw_br_offloads, \
 		     nb_name)
 
+#define ice_work_to_br_offloads(w) \
+	container_of(w, \
+		     struct ice_esw_br_offloads, \
+		     update_work.work)
+
 #define ice_work_to_fdb_work(w) \
 	container_of(w, \
 		     struct ice_esw_br_fdb_work, \
-- 
2.40.1


