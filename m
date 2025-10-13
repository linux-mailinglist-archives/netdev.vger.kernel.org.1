Return-Path: <netdev+bounces-228974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BEBD6B17
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A6405B73
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119EB2FFDCB;
	Mon, 13 Oct 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkIR4kL0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AD2DE717
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396589; cv=none; b=ti2uIYOb4nvOOLNeKLY8au0pN4l4aEjvSiMI2qZUkGaoHBM9k+blkjaQbQrY3bgFER2TwrUiRJI7fG8euVrI5pwOG3GfbyD6InfKBgYa20R22fPfnQBKXW5vPUyPdVHwtO+N+aD1raL07Ghaq7ZFG2m2hiYWbH6UejA97IxGARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396589; c=relaxed/simple;
	bh=dCFezXkgybXbwmSOYCN35XONcGK2M3wNnSWyvL4Tg+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwVy5f4lOcYeG0J+jfg9Ukkln8JEXEt8jfZne5Wbuuj2nQPRxPDJPOt9oDNFMCUcsmL3TuUZiGLY4LZzFK0ZOdxUyxQpX2EyRTWi4ZxlgqYBYqERhVORnCDxNPWLlRM3Sd+vFSS7hkN3LiHiYm/gHcZ5y1HGOfliXG1saxCf49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkIR4kL0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760396586; x=1791932586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCFezXkgybXbwmSOYCN35XONcGK2M3wNnSWyvL4Tg+E=;
  b=AkIR4kL0IQl7vqJHsYdtT1VHCi2/3BxKktJ3IfV9QQdJiAhdZd+yg2bU
   UsPeU4VcNRSF5polwrPK8GtMy3LBNF6N4NSwsslLXzPmCbaisXFKhD9ee
   J4jqeOo3f2CLat2oMiBRatmZQ1N6IFEDgSICaSggX10tj5eAJ6VZQcUAO
   qa6VaAo4gPhlFlWI+yJVCqqTtMmXAJ6GF9f9CyDH/ob+t8bjexIe8Og9v
   McoHdoElyUYakdqUcL8fRmGFu5aM3b4V/6ZN5DhKJ/J2vLKPFYR85RW9Y
   Nx9d1oRtW0xW092P4okDPc9hDqOwYIw0XEAG2mMuzumeAF2BNhaDdxRCC
   Q==;
X-CSE-ConnectionGUID: k3xozjNGT6eay1LIMbXZHA==
X-CSE-MsgGUID: FdclyjbpQv6BwUW9T0jT2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="79989124"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="79989124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:03:00 -0700
X-CSE-ConnectionGUID: O9NRbDMgTyq4FUVCn/bCZQ==
X-CSE-MsgGUID: wyqe/u+bSfy2TArBU+3Qew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="181404276"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa007.fm.intel.com with ESMTP; 13 Oct 2025 16:02:59 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v8 7/9] idpf: generalize send virtchnl message API
Date: Mon, 13 Oct 2025 16:13:39 -0700
Message-Id: <20251013231341.1139603-8-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251013231341.1139603-1-joshua.a.hay@intel.com>
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

With the previous refactor of passing idpf resource pointer, all of the
virtchnl send message functions do not require full vport structure.
Those functions can be generalized to be able to use for configuring
vport independent queues.

Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
---
v8: rebase on AF_XDP series
---
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  74 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 216 ++++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  46 ++--
 6 files changed, 194 insertions(+), 152 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index ee93987f9018..a4625638cf3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -88,7 +88,7 @@ static int idpf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(vport, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index be531593957a..35c1b262043e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -545,7 +545,9 @@ static int idpf_del_mac_filter(struct idpf_vport *vport,
 	if (test_bit(IDPF_VPORT_UP, np->state)) {
 		int err;
 
-		err = idpf_add_del_mac_filters(vport, np, false, async);
+		err = idpf_add_del_mac_filters(np->adapter, vport_config,
+					       vport->default_mac_addr,
+					       np->vport_id, false, async);
 		if (err)
 			return err;
 	}
@@ -614,7 +616,9 @@ static int idpf_add_mac_filter(struct idpf_vport *vport,
 		return err;
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
-		err = idpf_add_del_mac_filters(vport, np, true, async);
+		err = idpf_add_del_mac_filters(np->adapter, vport_config,
+					       vport->default_mac_addr,
+					       np->vport_id, true, async);
 
 	return err;
 }
@@ -662,7 +666,8 @@ static void idpf_restore_mac_filters(struct idpf_vport *vport)
 
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	idpf_add_del_mac_filters(vport, netdev_priv(vport->netdev),
+	idpf_add_del_mac_filters(vport->adapter, vport_config,
+				 vport->default_mac_addr, vport->vport_id,
 				 true, false);
 }
 
@@ -686,7 +691,8 @@ static void idpf_remove_mac_filters(struct idpf_vport *vport)
 
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 
-	idpf_add_del_mac_filters(vport, netdev_priv(vport->netdev),
+	idpf_add_del_mac_filters(vport->adapter, vport_config,
+				 vport->default_mac_addr, vport->vport_id,
 				 false, false);
 }
 
@@ -917,7 +923,9 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
+	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_queue_id_reg_info *chunks;
+	u32 vport_id = vport->vport_id;
 
 	if (!test_and_clear_bit(IDPF_VPORT_UP, np->state))
 		return;
@@ -928,18 +936,18 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 	netif_carrier_off(vport->netdev);
 	netif_tx_disable(vport->netdev);
 
-	chunks = &vport->adapter->vport_config[vport->idx]->qid_reg_info;
+	chunks = &adapter->vport_config[vport->idx]->qid_reg_info;
 
-	idpf_send_disable_vport_msg(vport);
+	idpf_send_disable_vport_msg(adapter, vport_id);
 	idpf_send_disable_queues_msg(vport);
-	idpf_send_map_unmap_queue_vector_msg(vport, rsrc, false);
+	idpf_send_map_unmap_queue_vector_msg(adapter, rsrc, vport_id, false);
 	/* Normally we ask for queues in create_vport, but if the number of
 	 * initially requested queues have changed, for example via ethtool
 	 * set channels, we do delete queues and then add the queues back
 	 * instead of deleting and reallocating the vport.
 	 */
 	if (test_and_clear_bit(IDPF_VPORT_DEL_QUEUES, vport->flags))
-		idpf_send_delete_queues_msg(vport, chunks);
+		idpf_send_delete_queues_msg(adapter, chunks, vport_id);
 
 	idpf_remove_features(vport);
 
@@ -1023,7 +1031,7 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	kfree(rss_data->rss_key);
 	rss_data->rss_key = NULL;
 
-	idpf_send_destroy_vport_msg(vport);
+	idpf_send_destroy_vport_msg(adapter, vport->vport_id);
 
 	/* Release all max queues allocated to the adapter's pool */
 	max_q.max_rxq = vport_config->max_q.max_rxq;
@@ -1285,7 +1293,8 @@ void idpf_statistics_task(struct work_struct *work)
 		struct idpf_vport *vport = adapter->vports[i];
 
 		if (vport && !test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
-			idpf_send_get_stats_msg(vport);
+			idpf_send_get_stats_msg(netdev_priv(vport->netdev),
+						&vport->port_stats);
 	}
 
 	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
@@ -1426,6 +1435,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_vport_config *vport_config;
 	struct idpf_queue_id_reg_info *chunks;
 	struct idpf_rss_data *rss_data;
+	u32 vport_id = vport->vport_id;
 	int err;
 
 	if (test_bit(IDPF_VPORT_UP, np->state))
@@ -1491,14 +1501,15 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_vport_intr_ena(vport, rsrc);
 
-	err = idpf_send_config_queues_msg(vport, rsrc);
+	err = idpf_send_config_queues_msg(adapter, rsrc, vport_id);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure queues for vport %u, %d\n",
 			vport->vport_id, err);
 		goto rxq_deinit;
 	}
 
-	err = idpf_send_map_unmap_queue_vector_msg(vport, rsrc, true);
+	err = idpf_send_map_unmap_queue_vector_msg(adapter, rsrc, vport_id,
+						   true);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map queue vectors for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1512,7 +1523,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 		goto unmap_queue_vectors;
 	}
 
-	err = idpf_send_enable_vport_msg(vport);
+	err = idpf_send_enable_vport_msg(adapter, vport_id);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to enable vport %u: %d\n",
 			vport->vport_id, err);
@@ -1548,11 +1559,11 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 deinit_rss:
 	idpf_deinit_rss(rss_data);
 disable_vport:
-	idpf_send_disable_vport_msg(vport);
+	idpf_send_disable_vport_msg(adapter, vport_id);
 disable_queues:
 	idpf_send_disable_queues_msg(vport);
 unmap_queue_vectors:
-	idpf_send_map_unmap_queue_vector_msg(vport, rsrc, false);
+	idpf_send_map_unmap_queue_vector_msg(adapter, rsrc, vport_id, false);
 rxq_deinit:
 	idpf_xdp_rxq_info_deinit_all(rsrc);
 intr_deinit:
@@ -1985,6 +1996,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
 	struct idpf_q_vec_rsrc *new_rsrc;
+	u32 vport_id = vport->vport_id;
 	struct idpf_vport *new_vport;
 	int err;
 
@@ -2039,28 +2051,21 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	vport_config = adapter->vport_config[vport->idx];
 
 	if (!vport_is_up) {
-		idpf_send_delete_queues_msg(vport, &vport_config->qid_reg_info);
+		idpf_send_delete_queues_msg(adapter, &vport_config->qid_reg_info,
+					    vport_id);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
 		idpf_vport_stop(vport, false);
 	}
 
 	idpf_deinit_rss(&vport_config->user_config.rss_data);
-	/* We're passing in vport here because we need its wait_queue
-	 * to send a message and it should be getting all the vport
-	 * config data out of the adapter but we need to be careful not
-	 * to add code to add_queues to change the vport config within
-	 * vport itself as it will be wiped with a memcpy later.
-	 */
-	err = idpf_send_add_queues_msg(vport, new_rsrc->num_txq,
-				       new_rsrc->num_complq,
-				       new_rsrc->num_rxq,
-				       new_rsrc->num_bufq);
+	err = idpf_send_add_queues_msg(adapter, vport_config, new_rsrc,
+				       vport_id);
 	if (err)
 		goto err_reset;
 
-	/* Same comment as above regarding avoiding copying the wait_queues and
-	 * mutexes applies here. We do not want to mess with those if possible.
+	/* Avoid copying the wait_queues and mutexes. We do not want to mess
+	 * with those if possible.
 	 */
 	memcpy(vport, new_vport, offsetof(struct idpf_vport, link_up));
 
@@ -2077,8 +2082,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	goto free_vport;
 
 err_reset:
-	idpf_send_add_queues_msg(vport, rsrc->num_txq, rsrc->num_complq,
-				 rsrc->num_rxq, rsrc->num_bufq);
+	idpf_send_add_queues_msg(adapter, vport_config, rsrc, vport_id);
 
 err_open:
 	if (vport_is_up)
@@ -2223,14 +2227,15 @@ static void idpf_set_rx_mode(struct net_device *netdev)
  */
 static int idpf_vport_manage_rss_lut(struct idpf_vport *vport)
 {
-	bool ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
 	struct idpf_rss_data *rss_data;
 	u16 idx = vport->idx;
 	int lut_size;
+	bool ena;
 
 	rss_data = &vport->adapter->vport_config[idx]->user_config.rss_data;
 	lut_size = rss_data->rss_lut_size * sizeof(u32);
 
+	ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
 	if (ena) {
 		/* This will contain the default or user configured LUT */
 		memcpy(rss_data->rss_lut, rss_data->cached_lut, lut_size);
@@ -2286,8 +2291,13 @@ static int idpf_set_features(struct net_device *netdev,
 	}
 
 	if (changed & NETIF_F_LOOPBACK) {
+		bool loopback_ena;
+
 		netdev->features ^= NETIF_F_LOOPBACK;
-		err = idpf_send_ena_dis_loopback_msg(vport);
+		loopback_ena = idpf_is_feature_ena(vport, NETIF_F_LOOPBACK);
+
+		err = idpf_send_ena_dis_loopback_msg(adapter, vport->vport_id,
+						     loopback_ena);
 	}
 
 unlock_mutex:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4aca03e8f408..c1cb4b77e07e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4658,13 +4658,15 @@ void idpf_vport_intr_ena(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
  */
 int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 {
+	struct idpf_adapter *adapter = vport->adapter;
+	u32 vport_id = vport->vport_id;
 	int err;
 
-	err = idpf_send_get_set_rss_key_msg(vport, rss_data, false);
+	err = idpf_send_get_set_rss_key_msg(adapter, rss_data, vport_id, false);
 	if (err)
 		return err;
 
-	return idpf_send_get_set_rss_lut_msg(vport, rss_data, false);
+	return idpf_send_get_set_rss_lut_msg(adapter, rss_data, vport_id, false);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index bc47e194fbd2..8c2008477621 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -87,7 +87,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport,
 	if (!reg_vals)
 		return -ENOMEM;
 
-	num_regs = idpf_get_reg_intr_vecs(vport, reg_vals);
+	num_regs = idpf_get_reg_intr_vecs(adapter, reg_vals);
 	if (num_regs < num_vecs) {
 		err = -EINVAL;
 		goto free_reg_vals;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e8b9ee49ad89..92998d7002f3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1304,12 +1304,12 @@ idpf_vport_init_queue_reg_chunks(struct idpf_vport_config *vport_config,
 
 /**
  * idpf_get_reg_intr_vecs - Get vector queue register offset
- * @vport: virtual port structure
+ * @adapter: adapter structure to get the vector chunks
  * @reg_vals: Register offsets to store in
  *
  * Returns number of registers that got populated
  */
-int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
+int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
 			   struct idpf_vec_regs *reg_vals)
 {
 	struct virtchnl2_vector_chunks *chunks;
@@ -1317,7 +1317,7 @@ int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
 	u16 num_vchunks, num_vec;
 	int num_regs = 0, i, j;
 
-	chunks = &vport->adapter->req_vec_chunks->vchunks;
+	chunks = &adapter->req_vec_chunks->vchunks;
 	num_vchunks = le16_to_cpu(chunks->num_vchunks);
 
 	for (j = 0; j < num_vchunks; j++) {
@@ -1653,72 +1653,75 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
 
 /**
  * idpf_send_destroy_vport_msg - Send virtchnl destroy vport message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Send virtchnl destroy vport message.  Returns 0 on success, negative on
  * failure.
  */
-int idpf_send_destroy_vport_msg(struct idpf_vport *vport)
+int idpf_send_destroy_vport_msg(struct idpf_adapter *adapter, u32 vport_id)
 {
 	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
 	ssize_t reply_sz;
 
-	v_id.vport_id = cpu_to_le32(vport->vport_id);
+	v_id.vport_id = cpu_to_le32(vport_id);
 
 	xn_params.vc_op = VIRTCHNL2_OP_DESTROY_VPORT;
 	xn_params.send_buf.iov_base = &v_id;
 	xn_params.send_buf.iov_len = sizeof(v_id);
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
  * idpf_send_enable_vport_msg - Send virtchnl enable vport message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Send enable vport virtchnl message.  Returns 0 on success, negative on
  * failure.
  */
-int idpf_send_enable_vport_msg(struct idpf_vport *vport)
+int idpf_send_enable_vport_msg(struct idpf_adapter *adapter, u32 vport_id)
 {
 	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
 	ssize_t reply_sz;
 
-	v_id.vport_id = cpu_to_le32(vport->vport_id);
+	v_id.vport_id = cpu_to_le32(vport_id);
 
 	xn_params.vc_op = VIRTCHNL2_OP_ENABLE_VPORT;
 	xn_params.send_buf.iov_base = &v_id;
 	xn_params.send_buf.iov_len = sizeof(v_id);
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
  * idpf_send_disable_vport_msg - Send virtchnl disable vport message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Send disable vport virtchnl message.  Returns 0 on success, negative on
  * failure.
  */
-int idpf_send_disable_vport_msg(struct idpf_vport *vport)
+int idpf_send_disable_vport_msg(struct idpf_adapter *adapter, u32 vport_id)
 {
 	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_vport v_id;
 	ssize_t reply_sz;
 
-	v_id.vport_id = cpu_to_le32(vport->vport_id);
+	v_id.vport_id = cpu_to_le32(vport_id);
 
 	xn_params.vc_op = VIRTCHNL2_OP_DISABLE_VPORT;
 	xn_params.send_buf.iov_base = &v_id;
 	xn_params.send_buf.iov_len = sizeof(v_id);
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
@@ -1854,19 +1857,21 @@ static int idpf_send_config_tx_queue_set_msg(const struct idpf_queue_set *qs)
 
 /**
  * idpf_send_config_tx_queues_msg - send virtchnl config Tx queues message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Return: 0 on success, -errno on failure.
  */
-static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport,
-					  struct idpf_q_vec_rsrc *rsrc)
+static int idpf_send_config_tx_queues_msg(struct idpf_adapter *adapter,
+					  struct idpf_q_vec_rsrc *rsrc,
+					  u32 vport_id)
 {
 	struct idpf_queue_set *qs __free(kfree) = NULL;
 	u32 totqs = rsrc->num_txq + rsrc->num_complq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, totqs);
+	qs = idpf_alloc_queue_set(adapter, rsrc, vport_id, totqs);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2040,20 +2045,22 @@ static int idpf_send_config_rx_queue_set_msg(const struct idpf_queue_set *qs)
 
 /**
  * idpf_send_config_rx_queues_msg - send virtchnl config Rx queues message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Return: 0 on success, -errno on failure.
  */
-static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport,
-					  struct idpf_q_vec_rsrc *rsrc)
+static int idpf_send_config_rx_queues_msg(struct idpf_adapter *adapter,
+					  struct idpf_q_vec_rsrc *rsrc,
+					  u32 vport_id)
 {
 	bool splitq = idpf_is_queue_model_split(rsrc->rxq_model);
 	struct idpf_queue_set *qs __free(kfree) = NULL;
 	u32 totqs = rsrc->num_rxq + rsrc->num_bufq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, totqs);
+	qs = idpf_alloc_queue_set(adapter, rsrc, vport_id, totqs);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2184,14 +2191,17 @@ static int idpf_send_ena_dis_queue_set_msg(const struct idpf_queue_set *qs,
 /**
  * idpf_send_ena_dis_queues_msg - send virtchnl enable or disable queues
  *				  message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  * @en: whether to enable or disable queues
  *
  * Return: 0 on success, -errno on failure.
  */
-static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool en)
+static int idpf_send_ena_dis_queues_msg(struct idpf_adapter *adapter,
+					struct idpf_q_vec_rsrc *rsrc,
+					u32 vport_id, bool en)
 {
-	struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
 	struct idpf_queue_set *qs __free(kfree) = NULL;
 	u32 num_txq, num_q, k = 0;
 	bool split;
@@ -2199,7 +2209,7 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, bool en)
 	num_txq = rsrc->num_txq + rsrc->num_complq;
 	num_q = num_txq + rsrc->num_rxq + rsrc->num_bufq;
 
-	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, num_q);
+	qs = idpf_alloc_queue_set(adapter, rsrc, vport_id, num_q);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2376,21 +2386,22 @@ idpf_send_map_unmap_queue_set_vector_msg(const struct idpf_queue_set *qs,
 /**
  * idpf_send_map_unmap_queue_vector_msg - send virtchnl map or unmap queue
  *					  vector message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  * @map: true for map and false for unmap
  *
  * Return: 0 on success, -errno on failure.
  */
-int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport,
+int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
 					 struct idpf_q_vec_rsrc *rsrc,
-					 bool map)
+					 u32 vport_id, bool map)
 {
 	struct idpf_queue_set *qs __free(kfree) = NULL;
 	u32 num_q = rsrc->num_txq + rsrc->num_rxq;
 	u32 k = 0;
 
-	qs = idpf_alloc_queue_set(vport->adapter, rsrc, vport->vport_id, num_q);
+	qs = idpf_alloc_queue_set(adapter, rsrc, vport_id, num_q);
 	if (!qs)
 		return -ENOMEM;
 
@@ -2494,7 +2505,9 @@ int idpf_send_config_queue_set_msg(const struct idpf_queue_set *qs)
  */
 int idpf_send_enable_queues_msg(struct idpf_vport *vport)
 {
-	return idpf_send_ena_dis_queues_msg(vport, true);
+	return idpf_send_ena_dis_queues_msg(vport->adapter,
+					    &vport->dflt_qv_rsrc,
+					    vport->vport_id, true);
 }
 
 /**
@@ -2508,7 +2521,9 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 {
 	int err;
 
-	err = idpf_send_ena_dis_queues_msg(vport, false);
+	err = idpf_send_ena_dis_queues_msg(vport->adapter,
+					   &vport->dflt_qv_rsrc,
+					   vport->vport_id, false);
 	if (err)
 		return err;
 
@@ -2537,14 +2552,16 @@ static void idpf_convert_reg_to_queue_chunks(struct virtchnl2_queue_chunk *dchun
 
 /**
  * idpf_send_delete_queues_msg - send delete queues virtchnl message
- * @vport: virtual port private data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @chunks: queue ids received over mailbox
+ * @vport_id: vport identifier used while preparing the virtchnl messag
  *
  * Will send delete queues virtchnl message. Return 0 on success, negative on
  * failure.
  */
-int idpf_send_delete_queues_msg(struct idpf_vport *vport,
-				struct idpf_queue_id_reg_info *chunks)
+int idpf_send_delete_queues_msg(struct idpf_adapter *adapter,
+				struct idpf_queue_id_reg_info *chunks,
+				u32 vport_id)
 {
 	struct virtchnl2_del_ena_dis_queues *eq __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
@@ -2559,7 +2576,7 @@ int idpf_send_delete_queues_msg(struct idpf_vport *vport,
 	if (!eq)
 		return -ENOMEM;
 
-	eq->vport_id = cpu_to_le32(vport->vport_id);
+	eq->vport_id = cpu_to_le32(vport_id);
 	eq->chunks.num_chunks = cpu_to_le16(num_chunks);
 
 	idpf_convert_reg_to_queue_chunks(eq->chunks.chunks, chunks->queue_chunks,
@@ -2569,50 +2586,51 @@ int idpf_send_delete_queues_msg(struct idpf_vport *vport,
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = eq;
 	xn_params.send_buf.iov_len = buf_size;
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
 
 /**
  * idpf_send_config_queues_msg - Send config queues virtchnl message
- * @vport: Virtual port private data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Will send config queues virtchnl message. Returns 0 on success, negative on
  * failure.
  */
-int idpf_send_config_queues_msg(struct idpf_vport *vport,
-				struct idpf_q_vec_rsrc *rsrc)
+int idpf_send_config_queues_msg(struct idpf_adapter *adapter,
+				struct idpf_q_vec_rsrc *rsrc,
+				u32 vport_id)
 {
 	int err;
 
-	err = idpf_send_config_tx_queues_msg(vport, rsrc);
+	err = idpf_send_config_tx_queues_msg(adapter, rsrc, vport_id);
 	if (err)
 		return err;
 
-	return idpf_send_config_rx_queues_msg(vport, rsrc);
+	return idpf_send_config_rx_queues_msg(adapter, rsrc, vport_id);
 }
 
 /**
  * idpf_send_add_queues_msg - Send virtchnl add queues message
- * @vport: Virtual port private data structure
- * @num_tx_q: number of transmit queues
- * @num_complq: number of transmit completion queues
- * @num_rx_q: number of receive queues
- * @num_rx_bufq: number of receive buffer queues
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_config: vport persistent structure to store the queue chunk info
+ * @rsrc: pointer to queue and vector resources
+ * @vport_id: vport identifier used while preparing the virtchnl message
  *
  * Returns 0 on success, negative on failure. vport _MUST_ be const here as
  * we should not change any fields within vport itself in this function.
  */
-int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
-			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq)
+int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
+			     struct idpf_vport_config *vport_config,
+			     struct idpf_q_vec_rsrc *rsrc,
+			     u32 vport_id)
 {
 	struct virtchnl2_add_queues *vc_msg __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_vport_config *vport_config;
 	struct virtchnl2_add_queues aq = {};
-	u16 vport_idx = vport->idx;
 	ssize_t reply_sz;
 	int size;
 
@@ -2620,13 +2638,11 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 	if (!vc_msg)
 		return -ENOMEM;
 
-	vport_config = vport->adapter->vport_config[vport_idx];
-
-	aq.vport_id = cpu_to_le32(vport->vport_id);
-	aq.num_tx_q = cpu_to_le16(num_tx_q);
-	aq.num_tx_complq = cpu_to_le16(num_complq);
-	aq.num_rx_q = cpu_to_le16(num_rx_q);
-	aq.num_rx_bufq = cpu_to_le16(num_rx_bufq);
+	aq.vport_id = cpu_to_le32(vport_id);
+	aq.num_tx_q = cpu_to_le16(rsrc->num_txq);
+	aq.num_tx_complq = cpu_to_le16(rsrc->num_complq);
+	aq.num_rx_q = cpu_to_le16(rsrc->num_rxq);
+	aq.num_rx_bufq = cpu_to_le16(rsrc->num_bufq);
 
 	xn_params.vc_op = VIRTCHNL2_OP_ADD_QUEUES;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
@@ -2634,15 +2650,15 @@ int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
 	xn_params.send_buf.iov_len = sizeof(aq);
 	xn_params.recv_buf.iov_base = vc_msg;
 	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
 
 	/* compare vc_msg num queues with vport num queues */
-	if (le16_to_cpu(vc_msg->num_tx_q) != num_tx_q ||
-	    le16_to_cpu(vc_msg->num_rx_q) != num_rx_q ||
-	    le16_to_cpu(vc_msg->num_tx_complq) != num_complq ||
-	    le16_to_cpu(vc_msg->num_rx_bufq) != num_rx_bufq)
+	if (le16_to_cpu(vc_msg->num_tx_q) != rsrc->num_txq ||
+	    le16_to_cpu(vc_msg->num_rx_q) != rsrc->num_rxq ||
+	    le16_to_cpu(vc_msg->num_tx_complq) != rsrc->num_complq ||
+	    le16_to_cpu(vc_msg->num_rx_bufq) != rsrc->num_bufq)
 		return -EINVAL;
 
 	size = struct_size(vc_msg, chunks.chunks,
@@ -2773,13 +2789,14 @@ int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs)
 
 /**
  * idpf_send_get_stats_msg - Send virtchnl get statistics message
- * @vport: vport to get stats for
+ * @np: netdev private structure
+ * @port_stats: structure to store the vport statistics
  *
  * Returns 0 on success, negative on failure.
  */
-int idpf_send_get_stats_msg(struct idpf_vport *vport)
+int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
+			    struct idpf_port_stats *port_stats)
 {
-	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct rtnl_link_stats64 *netstats = &np->netstats;
 	struct virtchnl2_vport_stats stats_msg = {};
 	struct idpf_vc_xn_params xn_params = {};
@@ -2790,7 +2807,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 	if (!test_bit(IDPF_VPORT_UP, np->state))
 		return 0;
 
-	stats_msg.vport_id = cpu_to_le32(vport->vport_id);
+	stats_msg.vport_id = cpu_to_le32(np->vport_id);
 
 	xn_params.vc_op = VIRTCHNL2_OP_GET_STATS;
 	xn_params.send_buf.iov_base = &stats_msg;
@@ -2798,7 +2815,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 	xn_params.recv_buf = xn_params.send_buf;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(np->adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
 	if (reply_sz < sizeof(stats_msg))
@@ -2819,7 +2836,7 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 	netstats->rx_dropped = le64_to_cpu(stats_msg.rx_discards);
 	netstats->tx_dropped = le64_to_cpu(stats_msg.tx_discards);
 
-	vport->port_stats.vport_stats = stats_msg;
+	port_stats->vport_stats = stats_msg;
 
 	spin_unlock_bh(&np->stats_lock);
 
@@ -2828,15 +2845,16 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 
 /**
  * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
+ * @vport_id: vport identifier used while preparing the virtchnl message
  * @get: flag to set or get RSS look up table
  *
  * Returns 0 on success, negative on failure.
  */
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 				  struct idpf_rss_data *rss_data,
-				  bool get)
+				  u32 vport_id, bool get)
 {
 	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
 	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
@@ -2850,7 +2868,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
 	if (!rl)
 		return -ENOMEM;
 
-	rl->vport_id = cpu_to_le32(vport->vport_id);
+	rl->vport_id = cpu_to_le32(vport_id);
 
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = rl;
@@ -2870,7 +2888,7 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
 
 		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_LUT;
 	}
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
 	if (!get)
@@ -2903,15 +2921,16 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
 
 /**
  * idpf_send_get_set_rss_key_msg - Send virtchnl get or set RSS key message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
  * @rss_data: pointer to RSS key and lut info
+ * @vport_id: vport identifier used while preparing the virtchnl message
  * @get: flag to set or get RSS look up table
  *
  * Returns 0 on success, negative on failure
  */
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
 				  struct idpf_rss_data *rss_data,
-				  bool get)
+				  u32 vport_id, bool get)
 {
 	struct virtchnl2_rss_key *recv_rk __free(kfree) = NULL;
 	struct virtchnl2_rss_key *rk __free(kfree) = NULL;
@@ -2925,7 +2944,7 @@ int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
 	if (!rk)
 		return -ENOMEM;
 
-	rk->vport_id = cpu_to_le32(vport->vport_id);
+	rk->vport_id = cpu_to_le32(vport_id);
 	xn_params.send_buf.iov_base = rk;
 	xn_params.send_buf.iov_len = buf_size;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
@@ -2945,7 +2964,7 @@ int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
 		xn_params.vc_op = VIRTCHNL2_OP_SET_RSS_KEY;
 	}
 
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 	if (reply_sz < 0)
 		return reply_sz;
 	if (!get)
@@ -3251,24 +3270,27 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 /**
  * idpf_send_ena_dis_loopback_msg - Send virtchnl enable/disable loopback
  *				    message
- * @vport: virtual port data structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_id: vport identifier used while preparing the virtchnl message
+ * @loopback_ena: flag to enable or disable loopback
  *
  * Returns 0 on success, negative on failure.
  */
-int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport)
+int idpf_send_ena_dis_loopback_msg(struct idpf_adapter *adapter, u32 vport_id,
+				   bool loopback_ena)
 {
 	struct idpf_vc_xn_params xn_params = {};
 	struct virtchnl2_loopback loopback;
 	ssize_t reply_sz;
 
-	loopback.vport_id = cpu_to_le32(vport->vport_id);
-	loopback.enable = idpf_is_feature_ena(vport, NETIF_F_LOOPBACK);
+	loopback.vport_id = cpu_to_le32(vport_id);
+	loopback.enable = loopback_ena;
 
 	xn_params.vc_op = VIRTCHNL2_OP_LOOPBACK;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.send_buf.iov_base = &loopback;
 	xn_params.send_buf.iov_len = sizeof(loopback);
-	reply_sz = idpf_vc_xn_exec(vport->adapter, &xn_params);
+	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
 
 	return reply_sz < 0 ? reply_sz : 0;
 }
@@ -4137,12 +4159,12 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
-static void idpf_set_mac_type(struct idpf_vport *vport,
+static void idpf_set_mac_type(const u8 *default_mac_addr,
 			      struct virtchnl2_mac_addr *mac_addr)
 {
 	bool is_primary;
 
-	is_primary = ether_addr_equal(vport->default_mac_addr, mac_addr->addr);
+	is_primary = ether_addr_equal(default_mac_addr, mac_addr->addr);
 	mac_addr->type = is_primary ? VIRTCHNL2_MAC_ADDR_PRIMARY :
 				      VIRTCHNL2_MAC_ADDR_EXTRA;
 }
@@ -4218,22 +4240,23 @@ static int idpf_mac_filter_async_handler(struct idpf_adapter *adapter,
 
 /**
  * idpf_add_del_mac_filters - Add/del mac filters
- * @vport: Virtual port data structure
- * @np: Netdev private structure
+ * @adapter: adapter pointer used to send virtchnl message
+ * @vport_config: persistent vport structure to get the MAC filter list
+ * @default_mac_addr: default MAC address to compare with
+ * @vport_id: vport identifier used while preparing the virtchnl message
  * @add: Add or delete flag
  * @async: Don't wait for return message
  *
  * Returns 0 on success, error on failure.
  **/
-int idpf_add_del_mac_filters(struct idpf_vport *vport,
-			     struct idpf_netdev_priv *np,
+int idpf_add_del_mac_filters(struct idpf_adapter *adapter,
+			     struct idpf_vport_config *vport_config,
+			     const u8 *default_mac_addr, u32 vport_id,
 			     bool add, bool async)
 {
 	struct virtchnl2_mac_addr_list *ma_list __free(kfree) = NULL;
 	struct virtchnl2_mac_addr *mac_addr __free(kfree) = NULL;
-	struct idpf_adapter *adapter = np->adapter;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_vport_config *vport_config;
 	u32 num_msgs, total_filters = 0;
 	struct idpf_mac_filter *f;
 	ssize_t reply_sz;
@@ -4245,7 +4268,6 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 	xn_params.async = async;
 	xn_params.async_handler = idpf_mac_filter_async_handler;
 
-	vport_config = adapter->vport_config[np->vport_idx];
 	spin_lock_bh(&vport_config->mac_filter_list_lock);
 
 	/* Find the number of newly added filters */
@@ -4276,7 +4298,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			    list) {
 		if (add && f->add) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
-			idpf_set_mac_type(vport, &mac_addr[i]);
+			idpf_set_mac_type(default_mac_addr, &mac_addr[i]);
 			i++;
 			f->add = false;
 			if (i == total_filters)
@@ -4284,7 +4306,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 		}
 		if (!add && f->remove) {
 			ether_addr_copy(mac_addr[i].addr, f->macaddr);
-			idpf_set_mac_type(vport, &mac_addr[i]);
+			idpf_set_mac_type(default_mac_addr, &mac_addr[i]);
 			i++;
 			f->remove = false;
 			if (i == total_filters)
@@ -4316,7 +4338,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 			memset(ma_list, 0, buf_size);
 		}
 
-		ma_list->vport_id = cpu_to_le32(np->vport_id);
+		ma_list->vport_id = cpu_to_le32(vport_id);
 		ma_list->num_mac_addr = cpu_to_le16(num_entries);
 		memcpy(ma_list->mac_addr_list, &mac_addr[k], entries_size);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 950b3e51665f..e7b9dbd2284d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -101,7 +101,7 @@ void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
 int idpf_vc_core_init(struct idpf_adapter *adapter);
 void idpf_vc_core_deinit(struct idpf_adapter *adapter);
 
-int idpf_get_reg_intr_vecs(struct idpf_vport *vport,
+int idpf_get_reg_intr_vecs(struct idpf_adapter *adapter,
 			   struct idpf_vec_regs *reg_vals);
 int idpf_queue_reg_init(struct idpf_vport *vport,
 			struct idpf_q_vec_rsrc *rsrc,
@@ -149,16 +149,17 @@ int idpf_send_config_queue_set_msg(const struct idpf_queue_set *qs);
 
 int idpf_send_disable_queues_msg(struct idpf_vport *vport);
 int idpf_send_enable_queues_msg(struct idpf_vport *vport);
-int idpf_send_config_queues_msg(struct idpf_vport *vport,
-				struct idpf_q_vec_rsrc *rsrc);
+int idpf_send_config_queues_msg(struct idpf_adapter *adapter,
+				struct idpf_q_vec_rsrc *rsrc,
+				u32 vport_id);
 
 int idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q);
 u32 idpf_get_vport_id(struct idpf_vport *vport);
 int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q);
-int idpf_send_destroy_vport_msg(struct idpf_vport *vport);
-int idpf_send_enable_vport_msg(struct idpf_vport *vport);
-int idpf_send_disable_vport_msg(struct idpf_vport *vport);
+int idpf_send_destroy_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
+int idpf_send_enable_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
+int idpf_send_disable_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
 
 int idpf_vport_adjust_qs(struct idpf_vport *vport,
 			 struct idpf_q_vec_rsrc *rsrc);
@@ -166,10 +167,13 @@ int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
 			    struct idpf_vport_max_q *max_q);
 void idpf_vport_dealloc_max_qs(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q);
-int idpf_send_add_queues_msg(const struct idpf_vport *vport, u16 num_tx_q,
-			     u16 num_complq, u16 num_rx_q, u16 num_rx_bufq);
-int idpf_send_delete_queues_msg(struct idpf_vport *vport,
-				struct idpf_queue_id_reg_info *chunks);
+int idpf_send_add_queues_msg(struct idpf_adapter *adapter,
+			     struct idpf_vport_config *vport_config,
+			     struct idpf_q_vec_rsrc *rsrc,
+			     u32 vport_id);
+int idpf_send_delete_queues_msg(struct idpf_adapter *adapter,
+				struct idpf_queue_id_reg_info *chunks,
+				u32 vport_id);
 
 int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport,
 				 struct idpf_q_vec_rsrc *rsrc);
@@ -178,27 +182,31 @@ int idpf_get_vec_ids(struct idpf_adapter *adapter,
 		     struct virtchnl2_vector_chunks *chunks);
 int idpf_send_alloc_vectors_msg(struct idpf_adapter *adapter, u16 num_vectors);
 int idpf_send_dealloc_vectors_msg(struct idpf_adapter *adapter);
-int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport,
+int idpf_send_map_unmap_queue_vector_msg(struct idpf_adapter *adapter,
 					 struct idpf_q_vec_rsrc *rsrc,
+					 u32 vport_id,
 					 bool map);
 
-int idpf_add_del_mac_filters(struct idpf_vport *vport,
-			     struct idpf_netdev_priv *np,
+int idpf_add_del_mac_filters(struct idpf_adapter *adapter,
+			     struct idpf_vport_config *vport_config,
+			     const u8 *default_mac_addr, u32 vport_id,
 			     bool add, bool async);
 int idpf_set_promiscuous(struct idpf_adapter *adapter,
 			 struct idpf_vport_user_config_data *config_data,
 			 u32 vport_id);
 int idpf_check_supported_desc_ids(struct idpf_vport *vport);
 int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
-int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport);
-int idpf_send_get_stats_msg(struct idpf_vport *vport);
+int idpf_send_ena_dis_loopback_msg(struct idpf_adapter *adapter, u32 vport_id,
+				   bool loopback_ena);
+int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
+			    struct idpf_port_stats *port_stats);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+int idpf_send_get_set_rss_key_msg(struct idpf_adapter *adapter,
 				  struct idpf_rss_data *rss_data,
-				  bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+				  u32 vport_id, bool get);
+int idpf_send_get_set_rss_lut_msg(struct idpf_adapter *adapter,
 				  struct idpf_rss_data *rss_data,
-				  bool get);
+				  u32 vport_id, bool get);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
-- 
2.39.2


