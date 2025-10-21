Return-Path: <netdev+bounces-231431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3BBF9362
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC013A1B51
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E972C2363;
	Tue, 21 Oct 2025 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwV0kIMG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C62BE7C0
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088819; cv=none; b=cuv37zbaijhsvsWAc24R00h+j3S1U5S0lcIgsA84jrvmzmeC2nXTsQ277dEvAIiZhSXswvTaobVdxaoI93UOMgtqm+QirjifvKDdiTo2KFOF0RjiQGKWTQLb7NEw1CjLZ/ZSlP1wDaKr6GdN1fzn/gSGZnbYlsBQupkjJ0h6h1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088819; c=relaxed/simple;
	bh=VgrwEjjaDNAaxuYBR2KWAis34kOAfhOnE4z57HApI8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ET/xhN+aBTtrAINpSI84GSN2rJbt7oJT1wQ8jUHY5N9FLZ2kmVNJTlMYkg3UJx+hGayZbLZyvwaLzIAMFOu9Z4g67hy8aeKeIUizZyZ9rCtEXniTKgxUP4p/Lamd+DPuAKSknb4d6S4pQpy0IjuS1LLkx5JrwjuBuph19gT9Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwV0kIMG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761088818; x=1792624818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VgrwEjjaDNAaxuYBR2KWAis34kOAfhOnE4z57HApI8A=;
  b=NwV0kIMGGcAz88IBL+zw3glnECEgHe+4A1OwZ25SM46GclUoP8BBU9y3
   bia05Lh+sxGDVnsO6Ym5d/COGJLTAHpa953nW2TFupWbq+iQQqME43t+m
   vT94b2pPAvNVNMkAE3c7GjC+V6XBeVigrwFLA6DmEuLLtY9VA6iHJg6fv
   CZwFvik7lPhrS6PiMIjuSMcN2Az5/QRcNHNnKZv5sHF7H4Teym9c6ebV0
   jAtrxbQ2/ZRi1r09GL7CvTc6TvC4xZD2fPkWNqt7HN/OsjGRXVLLKEwzq
   aRuizbY7hJtY4Qc3SM6jChehnvuncw1Sxgn/qwR+0g3ZFQt+zKDKDXuJd
   g==;
X-CSE-ConnectionGUID: owbvj/8aSrykdXkthUDDNw==
X-CSE-MsgGUID: iwej//rqSoeJGW155AZflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66868450"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66868450"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 16:20:11 -0700
X-CSE-ConnectionGUID: sI48zOAbSh+7sSrwud26rg==
X-CSE-MsgGUID: TzKmHhIhTMKIlPmgoQYF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="214352307"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2025 16:20:11 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v9 06/10] idpf: add rss_data field to RSS function parameters
Date: Tue, 21 Oct 2025 16:30:52 -0700
Message-Id: <20251021233056.1320108-7-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251021233056.1320108-1-joshua.a.hay@intel.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Retrieve rss_data field of vport just once and pass it to RSS related
functions instead of retrieving it in each function.

While at it, update s/rss/RSS in the RSS function doc comments.

Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
---
v8: rebase on AF_XDP series
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 16 +++++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 34 +++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  6 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 24 ++++++-------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  8 +++--
 7 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 40f1ce901500..03df59829296 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -9,6 +9,7 @@ struct idpf_adapter;
 struct idpf_vport;
 struct idpf_vport_max_q;
 struct idpf_q_vec_rsrc;
+struct idpf_rss_data;
 
 #include <net/pkt_sched.h>
 #include <linux/aer.h>
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 564fb25bc309..9b272ebb9a71 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -481,7 +481,7 @@ static int idpf_set_rxfh(struct net_device *netdev,
 			rss_data->rss_lut[lut] = rxfh->indir[lut];
 	}
 
-	err = idpf_config_rss(vport);
+	err = idpf_config_rss(vport, rss_data);
 
 unlock_mutex:
 	idpf_vport_ctrl_unlock(netdev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 244868307e81..947a953f5ed9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1019,8 +1019,8 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 	u16 idx = vport->idx;
 
 	vport_config = adapter->vport_config[vport->idx];
-	idpf_deinit_rss(vport);
 	rss_data = &vport_config->user_config.rss_data;
+	idpf_deinit_rss(rss_data);
 	kfree(rss_data->rss_key);
 	rss_data->rss_key = NULL;
 
@@ -1426,6 +1426,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
 	struct idpf_queue_id_reg_info *chunks;
+	struct idpf_rss_data *rss_data;
 	int err;
 
 	if (np->state != __IDPF_VPORT_DOWN)
@@ -1522,10 +1523,11 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 
 	idpf_restore_features(vport);
 
-	if (vport_config->user_config.rss_data.rss_lut)
-		err = idpf_config_rss(vport);
+	rss_data = &vport_config->user_config.rss_data;
+	if (rss_data->rss_lut)
+		err = idpf_config_rss(vport, rss_data);
 	else
-		err = idpf_init_rss(vport);
+		err = idpf_init_rss(vport, rss_data);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize RSS for vport %u: %d\n",
 			vport->vport_id, err);
@@ -1545,7 +1547,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 	return 0;
 
 deinit_rss:
-	idpf_deinit_rss(vport);
+	idpf_deinit_rss(rss_data);
 disable_vport:
 	idpf_send_disable_vport_msg(vport);
 disable_queues:
@@ -2044,7 +2046,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_vport_stop(vport, false);
 	}
 
-	idpf_deinit_rss(vport);
+	idpf_deinit_rss(&vport_config->user_config.rss_data);
 	/* We're passing in vport here because we need its wait_queue
 	 * to send a message and it should be getting all the vport
 	 * config data out of the adapter but we need to be careful not
@@ -2243,7 +2245,7 @@ static int idpf_vport_manage_rss_lut(struct idpf_vport *vport)
 		memset(rss_data->rss_lut, 0, lut_size);
 	}
 
-	return idpf_config_rss(vport);
+	return idpf_config_rss(vport, rss_data);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d1ceedfb0a5c..bea2fd0154a2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4649,33 +4649,32 @@ void idpf_vport_intr_ena(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 /**
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  *
  * Return 0 on success, negative on failure
  */
-int idpf_config_rss(struct idpf_vport *vport)
+int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 {
 	int err;
 
-	err = idpf_send_get_set_rss_key_msg(vport, false);
+	err = idpf_send_get_set_rss_key_msg(vport, rss_data, false);
 	if (err)
 		return err;
 
-	return idpf_send_get_set_rss_lut_msg(vport, false);
+	return idpf_send_get_set_rss_lut_msg(vport, rss_data, false);
 }
 
 /**
  * idpf_fill_dflt_rss_lut - Fill the indirection table with the default values
  * @vport: virtual port structure
+ * @rss_data: pointer to RSS key and lut info
  */
-static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
+static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport,
+				   struct idpf_rss_data *rss_data)
 {
 	u16 num_active_rxq = vport->dflt_qv_rsrc.num_rxq;
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
 	int i;
 
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-
 	for (i = 0; i < rss_data->rss_lut_size; i++) {
 		rss_data->rss_lut[i] = i % num_active_rxq;
 		rss_data->cached_lut[i] = rss_data->rss_lut[i];
@@ -4685,17 +4684,14 @@ static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 /**
  * idpf_init_rss - Allocate and initialize RSS resources
  * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  *
  * Return 0 on success, negative on failure
  */
-int idpf_init_rss(struct idpf_vport *vport)
+int idpf_init_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
 	u32 lut_size;
 
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-
 	lut_size = rss_data->rss_lut_size * sizeof(u32);
 	rss_data->rss_lut = kzalloc(lut_size, GFP_KERNEL);
 	if (!rss_data->rss_lut)
@@ -4710,21 +4706,17 @@ int idpf_init_rss(struct idpf_vport *vport)
 	}
 
 	/* Fill the default RSS lut values */
-	idpf_fill_dflt_rss_lut(vport);
+	idpf_fill_dflt_rss_lut(vport, rss_data);
 
-	return idpf_config_rss(vport);
+	return idpf_config_rss(vport, rss_data);
 }
 
 /**
  * idpf_deinit_rss - Release RSS resources
- * @vport: virtual port
+ * @rss_data: pointer to RSS key and lut info
  */
-void idpf_deinit_rss(struct idpf_vport *vport)
+void idpf_deinit_rss(struct idpf_rss_data *rss_data)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct idpf_rss_data *rss_data;
-
-	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
 	kfree(rss_data->cached_lut);
 	rss_data->cached_lut = NULL;
 	kfree(rss_data->rss_lut);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index b40d4e8e4d95..3bf6cff60394 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1097,9 +1097,9 @@ int idpf_vport_intr_init(struct idpf_vport *vport,
 			 struct idpf_q_vec_rsrc *rsrc);
 void idpf_vport_intr_ena(struct idpf_vport *vport,
 			 struct idpf_q_vec_rsrc *rsrc);
-int idpf_config_rss(struct idpf_vport *vport);
-int idpf_init_rss(struct idpf_vport *vport);
-void idpf_deinit_rss(struct idpf_vport *vport);
+int idpf_config_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data);
+int idpf_init_rss(struct idpf_vport *vport, struct idpf_rss_data *rss_data);
+void idpf_deinit_rss(struct idpf_rss_data *rss_data);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index ce67150de97a..ab3a8ed86e96 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2821,24 +2821,24 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport)
 }
 
 /**
- * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set rss lut message
+ * idpf_send_get_set_rss_lut_msg - Send virtchnl get or set RSS lut message
  * @vport: virtual port data structure
- * @get: flag to set or get rss look up table
+ * @rss_data: pointer to RSS key and lut info
+ * @get: flag to set or get RSS look up table
  *
  * Returns 0 on success, negative on failure.
  */
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
+int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get)
 {
 	struct virtchnl2_rss_lut *recv_rl __free(kfree) = NULL;
 	struct virtchnl2_rss_lut *rl __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_rss_data *rss_data;
 	int buf_size, lut_buf_size;
 	ssize_t reply_sz;
 	int i;
 
-	rss_data =
-		&vport->adapter->vport_config[vport->idx]->user_config.rss_data;
 	buf_size = struct_size(rl, lut, rss_data->rss_lut_size);
 	rl = kzalloc(buf_size, GFP_KERNEL);
 	if (!rl)
@@ -2896,24 +2896,24 @@ int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get)
 }
 
 /**
- * idpf_send_get_set_rss_key_msg - Send virtchnl get or set rss key message
+ * idpf_send_get_set_rss_key_msg - Send virtchnl get or set RSS key message
  * @vport: virtual port data structure
- * @get: flag to set or get rss look up table
+ * @rss_data: pointer to RSS key and lut info
+ * @get: flag to set or get RSS look up table
  *
  * Returns 0 on success, negative on failure
  */
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get)
+int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get)
 {
 	struct virtchnl2_rss_key *recv_rk __free(kfree) = NULL;
 	struct virtchnl2_rss_key *rk __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
-	struct idpf_rss_data *rss_data;
 	ssize_t reply_sz;
 	int i, buf_size;
 	u16 key_size;
 
-	rss_data =
-		&vport->adapter->vport_config[vport->idx]->user_config.rss_data;
 	buf_size = struct_size(rk, key_flex, rss_data->rss_key_size);
 	rk = kzalloc(buf_size, GFP_KERNEL);
 	if (!rk)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 26fd16d49b5f..a07f80ac8a2c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -192,8 +192,12 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
 int idpf_send_ena_dis_loopback_msg(struct idpf_vport *vport);
 int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
-int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
-int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get);
+int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport,
+				  struct idpf_rss_data *rss_data,
+				  bool get);
 void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 int idpf_idc_rdma_vc_send_sync(struct iidc_rdma_core_dev_info *cdev_info,
 			       u8 *send_msg, u16 msg_size,
-- 
2.39.2


