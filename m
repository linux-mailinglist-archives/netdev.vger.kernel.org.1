Return-Path: <netdev+bounces-12423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF4737756
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 00:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBBB281418
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DA18C0F;
	Tue, 20 Jun 2023 22:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2218C08
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 22:17:23 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914810CE
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687299441; x=1718835441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=loMkRYtRIee+d1KI6yv4Df7jjVRdRzsqknZGZE9K95s=;
  b=NwJgT5RfyK17UA2IfWGmjKSwDn2YeliZs4tsQe47AfP6DfHO8Yh2m1uE
   1eU9BXP6lQCzYfQmpARnd4lEWkXmzmkhNXVYmYzQzPC+Zd4CEaGMNFtIW
   CZuGNM3EZ6B2n5EamrucZsrRX/XJWbbfWRbZBrXbFq1JY4X9S09fi3FVg
   7fVEMiE7NZoGSsxBHc6zbCravqy+gvUtaQRI6tuo0aqbsGGPPn7fk4s0+
   ipjQLE0r42a4BwqkK9QdYKmmIZqAP0Zz8Ry/kzrMB1pID2NR8Osd8AG09
   Zl34k5iMGtgc+tPkydvj0da7StYOshpDENf1Yk86EAGThrCjzOF3vQ+Pw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358869100"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="358869100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858744950"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="858744950"
Received: from dmert-dev.jf.intel.com ([10.166.241.14])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 15:17:17 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	daniel.machon@microchip.com,
	simon.horman@corigine.com,
	bcreeley@amd.com
Subject: [PATCH iwl-next v6 02/10] ice: Add driver support for firmware changes for LAG
Date: Tue, 20 Jun 2023 15:18:46 -0700
Message-Id: <20230620221854.848606-3-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620221854.848606-1-david.m.ertman@intel.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
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

Add the defines, fields, and detection code for FW support of LAG for
SRIOV.  Also exposes some previously static functions to allow access
in the lag code.

Clean up code that is unused or not needed for LAG support.  Also add
an ordered workqueue for processing LAG events.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  5 ++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  8 +++
 drivers/net/ethernet/intel/ice/ice_lag.c      | 53 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 22 ++++++--
 drivers/net/ethernet/intel/ice/ice_type.h     |  2 +
 8 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9109006336f0..5ac0ad12f9f1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -200,6 +200,8 @@ enum ice_feature {
 	ICE_F_PTP_EXTTS,
 	ICE_F_SMA_CTRL,
 	ICE_F_GNSS,
+	ICE_F_ROCE_LAG,
+	ICE_F_SRIOV_LAG,
 	ICE_F_MAX
 };
 
@@ -569,6 +571,7 @@ struct ice_pf {
 	struct mutex sw_mutex;		/* lock for protecting VSI alloc flow */
 	struct mutex tc_mutex;		/* lock to protect TC changes */
 	struct mutex adev_mutex;	/* lock to protect aux device access */
+	struct mutex lag_mutex;		/* protect ice_lag struct in PF */
 	u32 msg_enable;
 	struct ice_ptp ptp;
 	struct gnss_serial *gnss_serial;
@@ -639,6 +642,8 @@ struct ice_pf {
 	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 };
 
+extern struct workqueue_struct *ice_lag_wq;
+
 struct ice_netdev_priv {
 	struct ice_vsi *vsi;
 	struct ice_repr *repr;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index acea49007f2a..8936e939f4af 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -120,6 +120,9 @@ struct ice_aqc_list_caps_elem {
 #define ICE_AQC_CAPS_PCIE_RESET_AVOIDANCE		0x0076
 #define ICE_AQC_CAPS_POST_UPDATE_RESET_RESTRICT		0x0077
 #define ICE_AQC_CAPS_NVM_MGMT				0x0080
+#define ICE_AQC_CAPS_FW_LAG_SUPPORT			0x0092
+#define ICE_AQC_BIT_ROCEV2_LAG				0x01
+#define ICE_AQC_BIT_SRIOV_LAG				0x02
 
 	u8 major_ver;
 	u8 minor_ver;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index afcbcf0ae8ed..e2068647151a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2241,6 +2241,14 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  "%s: reset_restrict_support = %d\n", prefix,
 			  caps->reset_restrict_support);
 		break;
+	case ICE_AQC_CAPS_FW_LAG_SUPPORT:
+		caps->roce_lag = !!(number & ICE_AQC_BIT_ROCEV2_LAG);
+		ice_debug(hw, ICE_DBG_INIT, "%s: roce_lag = %u\n",
+			  prefix, caps->roce_lag);
+		caps->sriov_lag = !!(number & ICE_AQC_BIT_SRIOV_LAG);
+		ice_debug(hw, ICE_DBG_INIT, "%s: sriov_lag = %u\n",
+			  prefix, caps->sriov_lag);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 5a7753bda324..d018e68f5a6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -4,8 +4,12 @@
 /* Link Aggregation code */
 
 #include "ice.h"
+#include "ice_lib.h"
 #include "ice_lag.h"
 
+#define ICE_LAG_RES_SHARED	BIT(14)
+#define ICE_LAG_RES_VALID	BIT(15)
+
 /**
  * ice_lag_set_primary - set PF LAG state as Primary
  * @lag: LAG info struct
@@ -225,6 +229,26 @@ static void ice_lag_unregister(struct ice_lag *lag, struct net_device *netdev)
 	lag->role = ICE_LAG_NONE;
 }
 
+/**
+ * ice_lag_init_feature_support_flag - Check for NVM support for LAG
+ * @pf: PF struct
+ */
+static void ice_lag_init_feature_support_flag(struct ice_pf *pf)
+{
+	struct ice_hw_common_caps *caps;
+
+	caps = &pf->hw.dev_caps.common_cap;
+	if (caps->roce_lag)
+		ice_set_feature_support(pf, ICE_F_ROCE_LAG);
+	else
+		ice_clear_feature_support(pf, ICE_F_ROCE_LAG);
+
+	if (caps->sriov_lag)
+		ice_set_feature_support(pf, ICE_F_SRIOV_LAG);
+	else
+		ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
+}
+
 /**
  * ice_lag_changeupper_event - handle LAG changeupper event
  * @lag: LAG info struct
@@ -264,26 +288,6 @@ static void ice_lag_changeupper_event(struct ice_lag *lag, void *ptr)
 	ice_display_lag_info(lag);
 }
 
-/**
- * ice_lag_changelower_event - handle LAG changelower event
- * @lag: LAG info struct
- * @ptr: opaque data pointer
- *
- * ptr to be cast to netdev_notifier_changelowerstate_info
- */
-static void ice_lag_changelower_event(struct ice_lag *lag, void *ptr)
-{
-	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-
-	if (netdev != lag->netdev)
-		return;
-
-	netdev_dbg(netdev, "bonding info\n");
-
-	if (!netif_is_lag_port(netdev))
-		netdev_dbg(netdev, "CHANGELOWER rcvd, but netdev not in LAG. Bail\n");
-}
-
 /**
  * ice_lag_event_handler - handle LAG events from netdev
  * @notif_blk: notifier block registered by this netdev
@@ -310,9 +314,6 @@ ice_lag_event_handler(struct notifier_block *notif_blk, unsigned long event,
 	case NETDEV_CHANGEUPPER:
 		ice_lag_changeupper_event(lag, ptr);
 		break;
-	case NETDEV_CHANGELOWERSTATE:
-		ice_lag_changelower_event(lag, ptr);
-		break;
 	case NETDEV_BONDING_INFO:
 		ice_lag_info_event(lag, ptr);
 		break;
@@ -379,6 +380,8 @@ int ice_init_lag(struct ice_pf *pf)
 	struct ice_vsi *vsi;
 	int err;
 
+	ice_lag_init_feature_support_flag(pf);
+
 	pf->lag = kzalloc(sizeof(*lag), GFP_KERNEL);
 	if (!pf->lag)
 		return -ENOMEM;
@@ -435,9 +438,7 @@ void ice_deinit_lag(struct ice_pf *pf)
 	if (lag->pf)
 		ice_unregister_lag_handler(lag);
 
-	dev_put(lag->upper_netdev);
-
-	dev_put(lag->peer_netdev);
+	flush_workqueue(ice_lag_wq);
 
 	kfree(lag);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 984b381386ff..cdb352e0fa07 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3997,7 +3997,7 @@ bool ice_is_feature_supported(struct ice_pf *pf, enum ice_feature f)
  * @pf: pointer to the struct ice_pf instance
  * @f: feature enum to set
  */
-static void ice_set_feature_support(struct ice_pf *pf, enum ice_feature f)
+void ice_set_feature_support(struct ice_pf *pf, enum ice_feature f)
 {
 	if (f < 0 || f >= ICE_F_MAX)
 		return;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 1628385a9672..dd53fe968ad8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -163,6 +163,7 @@ int ice_vsi_del_vlan_zero(struct ice_vsi *vsi);
 bool ice_vsi_has_non_zero_vlans(struct ice_vsi *vsi);
 u16 ice_vsi_num_non_zero_vlans(struct ice_vsi *vsi);
 bool ice_is_feature_supported(struct ice_pf *pf, enum ice_feature f);
+void ice_set_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c4e4a62b4ec1..f1188fdcc305 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -64,6 +64,7 @@ struct device *ice_hw_to_dev(struct ice_hw *hw)
 }
 
 static struct workqueue_struct *ice_wq;
+struct workqueue_struct *ice_lag_wq;
 static const struct net_device_ops ice_netdev_safe_mode_ops;
 static const struct net_device_ops ice_netdev_ops;
 
@@ -3794,6 +3795,7 @@ u16 ice_get_avail_rxq_count(struct ice_pf *pf)
 static void ice_deinit_pf(struct ice_pf *pf)
 {
 	ice_service_task_stop(pf);
+	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
 	mutex_destroy(&pf->tc_mutex);
@@ -3874,6 +3876,7 @@ static int ice_init_pf(struct ice_pf *pf)
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
+	mutex_init(&pf->lag_mutex);
 
 	INIT_HLIST_HEAD(&pf->aq_wait_list);
 	spin_lock_init(&pf->aq_wait_lock);
@@ -5564,7 +5567,7 @@ static struct pci_driver ice_driver = {
  */
 static int __init ice_module_init(void)
 {
-	int status;
+	int status = -ENOMEM;
 
 	pr_info("%s\n", ice_driver_string);
 	pr_info("%s\n", ice_copyright);
@@ -5572,15 +5575,27 @@ static int __init ice_module_init(void)
 	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
 	if (!ice_wq) {
 		pr_err("Failed to create workqueue\n");
-		return -ENOMEM;
+		return status;
+	}
+
+	ice_lag_wq = alloc_ordered_workqueue("ice_lag_wq", 0);
+	if (!ice_lag_wq) {
+		pr_err("Failed to create LAG workqueue\n");
+		goto err_dest_wq;
 	}
 
 	status = pci_register_driver(&ice_driver);
 	if (status) {
 		pr_err("failed to register PCI driver, err %d\n", status);
-		destroy_workqueue(ice_wq);
+		goto err_dest_lag_wq;
 	}
 
+	return 0;
+
+err_dest_lag_wq:
+	destroy_workqueue(ice_lag_wq);
+err_dest_wq:
+	destroy_workqueue(ice_wq);
 	return status;
 }
 module_init(ice_module_init);
@@ -5595,6 +5610,7 @@ static void __exit ice_module_exit(void)
 {
 	pci_unregister_driver(&ice_driver);
 	destroy_workqueue(ice_wq);
+	destroy_workqueue(ice_lag_wq);
 	pr_info("module unloaded\n");
 }
 module_exit(ice_module_exit);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index a073616671ef..5e353b0cbe6f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -277,6 +277,8 @@ struct ice_hw_common_caps {
 	u8 dcb;
 	u8 ieee_1588;
 	u8 rdma;
+	u8 roce_lag;
+	u8 sriov_lag;
 
 	bool nvm_update_pending_nvm;
 	bool nvm_update_pending_orom;
-- 
2.40.1


