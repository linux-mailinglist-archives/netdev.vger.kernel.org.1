Return-Path: <netdev+bounces-227395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D24CBAE9CD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E74D17082B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3A29E110;
	Tue, 30 Sep 2025 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTbir+gM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD4238166
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267444; cv=none; b=nlrdYRYVMm6Qi5PCpC1WhXePtShLwqAfr8mL34g1NAelcsGdFyuRqNlfszF7d2RZXSIYBSn4LWiraKfzjRSQxiPu2TPbuazBT/2is+C7OKdSczNfRwzCU9rcsTIiaww4H+wJ6D/x3PPfgysu85T5TBl7/z2mmRqZIWeMcstR1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267444; c=relaxed/simple;
	bh=rqncZq68hccibekHgdYcRpnmE66mPzb8PKoc1oLB2qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6bHxBIQXILI2hiD/LzPovFr5Kf1RtEth4Tm1dzRCGT9XNfOFf+5dheuRI523/B9Bedgr3i27JE1AXi0UrBGLhL3EH7cWj56sGTA93rnRR3ulnGhlnvL5848E4oOOprHdAiTL6WyhMqyRtuZlggDHcSsE8T78z9xzQ+qKjIewqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTbir+gM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759267442; x=1790803442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqncZq68hccibekHgdYcRpnmE66mPzb8PKoc1oLB2qU=;
  b=OTbir+gMrfFkDy12KleDQ/Xex+KEYL3Zv1AMo0xpxfGUq+RkLoBp85yL
   f/MdltsAFT6UJg6Li+S/bBLsf+MSWZZR2z3pv1LoqO8dMeX06SNZmEH9G
   1/ZjwqCRliCfdw7kQmBy9Of1alfeb5QfivcXl6varSShonwys+lCoQTp2
   YEY/ZYAqKR90q7TorbpC06ZSnVEcu1MELMKHfl1NnmwblXv1F24xibXp8
   Pk0Rgg8p+MkgLtNe/NSaljvAZR5i6zl5udS1uG/lBE90SvoKaKCgdQmIm
   +D2IONhdK/Bf5arylYqN7TktiNGASeZc43cNHzaZd50brUAK2Xw3R1V/A
   Q==;
X-CSE-ConnectionGUID: f5PcEDK0T/G8fz4wXXE7eQ==
X-CSE-MsgGUID: Y1C1ZtI+RvWHY8kr9YpcwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65358358"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65358358"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 14:24:01 -0700
X-CSE-ConnectionGUID: sLG7EM4MQFWlAX/DC4768A==
X-CSE-MsgGUID: QdscNH3DTRiOxQDnBShw1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="209336184"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa002.jf.intel.com with ESMTP; 30 Sep 2025 14:24:02 -0700
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: sreedevi.joshi@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 iwl-net 1/2] idpf: fix memory leak of flow steer list on rmmod
Date: Tue, 30 Sep 2025 16:23:51 -0500
Message-Id: <20250930212352.2263907-2-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flow steering list maintains entries that are added and removed as
ethtool creates and deletes flow steering rules. Module removal with active
entries causes memory leak as the list is not properly cleaned up.

Prevent this by iterating through the remaining entries in the list and
freeing the associated memory during module removal. Add a spinlock
(flow_steer_list_lock) to protect the list access from multiple threads.

Fixes: ada3e24b84a0 ("idpf: add flow steering support")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  2 ++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 15 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 28 ++++++++++++++++++-
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index cfbf3a716f34..4f4cf21e3c46 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -525,6 +525,7 @@ struct idpf_vector_lifo {
  * @max_q: Maximum possible queues
  * @req_qs_chunks: Queue chunk data for requested queues
  * @mac_filter_list_lock: Lock to protect mac filters
+ * @flow_steer_list_lock: Lock to protect fsteer filters
  * @flags: See enum idpf_vport_config_flags
  */
 struct idpf_vport_config {
@@ -532,6 +533,7 @@ struct idpf_vport_config {
 	struct idpf_vport_max_q max_q;
 	struct virtchnl2_add_queues *req_qs_chunks;
 	spinlock_t mac_filter_list_lock;
+	spinlock_t flow_steer_list_lock;
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index f84e247399a7..1352f18b60b0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -18,6 +18,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_user_config_data *user_config;
+	struct idpf_vport_config *vport_config;
 	struct idpf_fsteer_fltr *f;
 	struct idpf_vport *vport;
 	unsigned int cnt = 0;
@@ -25,7 +26,8 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
-	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+	vport_config = np->adapter->vport_config[np->vport_idx];
+	user_config = &vport_config->user_config;
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
@@ -37,15 +39,18 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		break;
 	case ETHTOOL_GRXCLSRULE:
 		err = -EINVAL;
+		spin_lock_bh(&vport_config->flow_steer_list_lock);
 		list_for_each_entry(f, &user_config->flow_steer_list, list)
 			if (f->loc == cmd->fs.location) {
 				cmd->fs.ring_cookie = f->q_index;
 				err = 0;
 				break;
 			}
+		spin_unlock_bh(&vport_config->flow_steer_list_lock);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		cmd->data = idpf_fsteer_max_rules(vport);
+		spin_lock_bh(&vport_config->flow_steer_list_lock);
 		list_for_each_entry(f, &user_config->flow_steer_list, list) {
 			if (cnt == cmd->rule_cnt) {
 				err = -EMSGSIZE;
@@ -56,6 +61,7 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		}
 		if (!err)
 			cmd->rule_cnt = user_config->num_fsteer_fltrs;
+		spin_unlock_bh(&vport_config->flow_steer_list_lock);
 		break;
 	default:
 		break;
@@ -224,6 +230,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 
 	fltr->loc = fsp->location;
 	fltr->q_index = q_index;
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
 	list_for_each_entry(f, &user_config->flow_steer_list, list) {
 		if (f->loc >= fltr->loc)
 			break;
@@ -234,6 +241,7 @@ static int idpf_add_flow_steer(struct net_device *netdev,
 		 list_add(&fltr->list, &user_config->flow_steer_list);
 
 	user_config->num_fsteer_fltrs++;
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
 
 out:
 	kfree(rule);
@@ -286,17 +294,20 @@ static int idpf_del_flow_steer(struct net_device *netdev,
 		goto out;
 	}
 
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
 	list_for_each_entry_safe(f, iter,
 				 &user_config->flow_steer_list, list) {
 		if (f->loc == fsp->location) {
 			list_del(&f->list);
 			kfree(f);
 			user_config->num_fsteer_fltrs--;
-			goto out;
+			goto out_unlock;
 		}
 	}
 	err = -EINVAL;
 
+out_unlock:
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
 out:
 	kfree(rule);
 	return err;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 01ab42fa23f9..72685f8b48f7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -440,6 +440,29 @@ int idpf_intr_req(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_del_all_flow_steer_filters - Delete all flow steer filters in list
+ * @vport: main vport struct
+ *
+ * Takes flow_steer_list_lock spinlock.  Deletes all filters
+ */
+static void idpf_del_all_flow_steer_filters(struct idpf_vport *vport)
+{
+	struct idpf_vport_config *vport_config;
+	struct idpf_fsteer_fltr *f, *ftmp;
+
+	vport_config = vport->adapter->vport_config[vport->idx];
+
+	spin_lock_bh(&vport_config->flow_steer_list_lock);
+	list_for_each_entry_safe(f, ftmp, &vport_config->user_config.flow_steer_list,
+				 list) {
+		list_del(&f->list);
+		kfree(f);
+	}
+	vport_config->user_config.num_fsteer_fltrs = 0;
+	spin_unlock_bh(&vport_config->flow_steer_list_lock);
+}
+
 /**
  * idpf_find_mac_filter - Search filter list for specific mac filter
  * @vconfig: Vport config structure
@@ -1031,8 +1054,10 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 
 	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 		idpf_decfg_netdev(vport);
-	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags)) {
 		idpf_del_all_mac_filters(vport);
+		idpf_del_all_flow_steer_filters(vport);
+	}
 
 	if (adapter->netdevs[i]) {
 		struct idpf_netdev_priv *np = netdev_priv(adapter->netdevs[i]);
@@ -1549,6 +1574,7 @@ void idpf_init_task(struct work_struct *work)
 	init_waitqueue_head(&vport->sw_marker_wq);
 
 	spin_lock_init(&vport_config->mac_filter_list_lock);
+	spin_lock_init(&vport_config->flow_steer_list_lock);
 
 	INIT_LIST_HEAD(&vport_config->user_config.mac_filter_list);
 	INIT_LIST_HEAD(&vport_config->user_config.flow_steer_list);
-- 
2.25.1


