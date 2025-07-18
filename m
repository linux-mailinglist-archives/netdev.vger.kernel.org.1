Return-Path: <netdev+bounces-208223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3DB0AA64
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA67D3BC5C8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913062E92A5;
	Fri, 18 Jul 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLKY8lGL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD72E8DF9
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864690; cv=none; b=QxL8HHNtzvNQSLasK7Y/9W+kzvOfUpM1EDS3c8y6jW3PdC2hD64Ld2VfdH9gA+kQjOZRkzcp1cbBnSI+bf/bidVhJLr6YrJIpyuRwmV3I9t4zQxzpOmUTKKdrjebzxL7//UuxU/COYE7MGW2cQTHUz1UHH5bftpo1jr86egAj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864690; c=relaxed/simple;
	bh=uFSs0g3o6u33MVlIc+oWCYC8BODUxaTINXL20DiLRoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEpR2EHolCuvZnmD7GcsHuYf1SoAyAcNKXtCkx6uBF/tpCRr06KVB73yrtJu5jznSN2Wb8R7csIEq/2VyPot6Uxvn1cecimB1CxHi6MYpXjNKafuGt707fGIyssDe9uNysgd+yguwWSVvtFNdc3EpXOcVCF1wJn9N7e1yrvCwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLKY8lGL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864689; x=1784400689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFSs0g3o6u33MVlIc+oWCYC8BODUxaTINXL20DiLRoI=;
  b=kLKY8lGLGlXozbLsebpFLwzvnzLkSIY/DRPL0EI2r4bc51aKcT1xBIfY
   klApZ2jnBR3ZaN1czxwegeMF9yuoXoUy2s/Wmmee2jSJCifZJPwlZYtTz
   bZnr9wYxergB+pRaj2KteSxlOqF8EXjmNvRBTyyCe9ZRHoSebM3R/OGRO
   pOwIGqXMOY7Yr9WFTUa/zhL2McejZfWMbvq39LkyB4g7yJx5GPsbuY4VW
   s24toJz4l6jim61I+RZE6e4iL9lKiA6AyCBR533mBhDD+Ml4GhYwVJtyF
   5j05yjJzm0/jjz9rE7FWZATsHCo8cvhEPO4jV6Ugt199pt4Wi0AlHsfV8
   Q==;
X-CSE-ConnectionGUID: +i25ZvjCQiOf/TVOmb0cIA==
X-CSE-MsgGUID: jwnd3cIjRUeTE0dIJA1cUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320580"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320580"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:24 -0700
X-CSE-ConnectionGUID: orMlD7ITTK2ADAo7NWX7pQ==
X-CSE-MsgGUID: VOlVAY/NRdyk9DO/+NST/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506889"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 05/13] idpf: preserve coalescing settings across resets
Date: Fri, 18 Jul 2025 11:51:06 -0700
Message-ID: <20250718185118.2042772-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

The IRQ coalescing config currently reside only inside struct
idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
re-allocated during resets. This leads to user-set coalesce configuration
to be lost.

Add new fields to struct idpf_vport_user_config_data to save the user
settings and re-apply them after reset.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 19 ++++++++++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 36 ++++++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 18 +++++++++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 13 ++++---
 5 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index fe2caff66fdb..f4c0eaf9bde3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -405,10 +405,28 @@ struct idpf_rss_data {
 	u32 *cached_lut;
 };
 
+/**
+ * struct idpf_q_coalesce - User defined coalescing configuration values for
+ *			   a single queue.
+ * @tx_intr_mode: Dynamic TX ITR or not
+ * @rx_intr_mode: Dynamic RX ITR or not
+ * @tx_coalesce_usecs: TX interrupt throttling rate
+ * @rx_coalesce_usecs: RX interrupt throttling rate
+ *
+ * Used to restore user coalescing configuration after a reset.
+ */
+struct idpf_q_coalesce {
+	u32 tx_intr_mode;
+	u32 rx_intr_mode;
+	u32 tx_coalesce_usecs;
+	u32 rx_coalesce_usecs;
+};
+
 /**
  * struct idpf_vport_user_config_data - User defined configuration values for
  *					each vport.
  * @rss_data: See struct idpf_rss_data
+ * @q_coalesce: Array of per queue coalescing data
  * @num_req_tx_qs: Number of user requested TX queues through ethtool
  * @num_req_rx_qs: Number of user requested RX queues through ethtool
  * @num_req_txq_desc: Number of user requested TX queue descriptors through
@@ -424,6 +442,7 @@ struct idpf_rss_data {
  */
 struct idpf_vport_user_config_data {
 	struct idpf_rss_data rss_data;
+	struct idpf_q_coalesce *q_coalesce;
 	u16 num_req_tx_qs;
 	u16 num_req_rx_qs;
 	u32 num_req_txq_desc;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 075618a6840e..0eb812ac19c2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1377,12 +1377,14 @@ static int idpf_get_per_q_coalesce(struct net_device *netdev, u32 q_num,
 /**
  * __idpf_set_q_coalesce - set ITR values for specific queue
  * @ec: ethtool structure from user to update ITR settings
+ * @q_coal: per queue coalesce settings
  * @qv: queue vector for which itr values has to be set
  * @is_rxq: is queue type rx
  *
  * Returns 0 on success, negative otherwise.
  */
 static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
+				 struct idpf_q_coalesce *q_coal,
 				 struct idpf_q_vector *qv, bool is_rxq)
 {
 	u32 use_adaptive_coalesce, coalesce_usecs;
@@ -1426,20 +1428,25 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
 
 	if (is_rxq) {
 		qv->rx_itr_value = coalesce_usecs;
+		q_coal->rx_coalesce_usecs = coalesce_usecs;
 		if (use_adaptive_coalesce) {
 			qv->rx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		} else {
 			qv->rx_intr_mode = !IDPF_ITR_DYNAMIC;
-			idpf_vport_intr_write_itr(qv, qv->rx_itr_value,
-						  false);
+			q_coal->rx_intr_mode = !IDPF_ITR_DYNAMIC;
+			idpf_vport_intr_write_itr(qv, coalesce_usecs, false);
 		}
 	} else {
 		qv->tx_itr_value = coalesce_usecs;
+		q_coal->tx_coalesce_usecs = coalesce_usecs;
 		if (use_adaptive_coalesce) {
 			qv->tx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal->tx_intr_mode = IDPF_ITR_DYNAMIC;
 		} else {
 			qv->tx_intr_mode = !IDPF_ITR_DYNAMIC;
-			idpf_vport_intr_write_itr(qv, qv->tx_itr_value, true);
+			q_coal->tx_intr_mode = !IDPF_ITR_DYNAMIC;
+			idpf_vport_intr_write_itr(qv, coalesce_usecs, true);
 		}
 	}
 
@@ -1452,6 +1459,7 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
 /**
  * idpf_set_q_coalesce - set ITR values for specific queue
  * @vport: vport associated to the queue that need updating
+ * @q_coal: per queue coalesce settings
  * @ec: coalesce settings to program the device with
  * @q_num: update ITR/INTRL (coalesce) settings for this queue number/index
  * @is_rxq: is queue type rx
@@ -1459,6 +1467,7 @@ static int __idpf_set_q_coalesce(const struct ethtool_coalesce *ec,
  * Return 0 on success, and negative on failure
  */
 static int idpf_set_q_coalesce(const struct idpf_vport *vport,
+			       struct idpf_q_coalesce *q_coal,
 			       const struct ethtool_coalesce *ec,
 			       int q_num, bool is_rxq)
 {
@@ -1467,7 +1476,7 @@ static int idpf_set_q_coalesce(const struct idpf_vport *vport,
 	qv = is_rxq ? idpf_find_rxq_vec(vport, q_num) :
 		      idpf_find_txq_vec(vport, q_num);
 
-	if (qv && __idpf_set_q_coalesce(ec, qv, is_rxq))
+	if (qv && __idpf_set_q_coalesce(ec, q_coal, qv, is_rxq))
 		return -EINVAL;
 
 	return 0;
@@ -1488,9 +1497,13 @@ static int idpf_set_coalesce(struct net_device *netdev,
 			     struct netlink_ext_ack *extack)
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport_user_config_data *user_config;
+	struct idpf_q_coalesce *q_coal;
 	struct idpf_vport *vport;
 	int i, err = 0;
 
+	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
@@ -1498,13 +1511,15 @@ static int idpf_set_coalesce(struct net_device *netdev,
 		goto unlock_mutex;
 
 	for (i = 0; i < vport->num_txq; i++) {
-		err = idpf_set_q_coalesce(vport, ec, i, false);
+		q_coal = &user_config->q_coalesce[i];
+		err = idpf_set_q_coalesce(vport, q_coal, ec, i, false);
 		if (err)
 			goto unlock_mutex;
 	}
 
 	for (i = 0; i < vport->num_rxq; i++) {
-		err = idpf_set_q_coalesce(vport, ec, i, true);
+		q_coal = &user_config->q_coalesce[i];
+		err = idpf_set_q_coalesce(vport, q_coal, ec, i, true);
 		if (err)
 			goto unlock_mutex;
 	}
@@ -1526,20 +1541,25 @@ static int idpf_set_coalesce(struct net_device *netdev,
 static int idpf_set_per_q_coalesce(struct net_device *netdev, u32 q_num,
 				   struct ethtool_coalesce *ec)
 {
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+	struct idpf_vport_user_config_data *user_config;
+	struct idpf_q_coalesce *q_coal;
 	struct idpf_vport *vport;
 	int err;
 
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
+	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
+	q_coal = &user_config->q_coalesce[q_num];
 
-	err = idpf_set_q_coalesce(vport, ec, q_num, false);
+	err = idpf_set_q_coalesce(vport, q_coal, ec, q_num, false);
 	if (err) {
 		idpf_vport_ctrl_unlock(netdev);
 
 		return err;
 	}
 
-	err = idpf_set_q_coalesce(vport, ec, q_num, true);
+	err = idpf_set_q_coalesce(vport, q_coal, ec, q_num, true);
 
 	idpf_vport_ctrl_unlock(netdev);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 4d6a182346e5..2c2a3e85d693 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1134,8 +1134,10 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!vport)
 		return vport;
 
+	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	if (!adapter->vport_config[idx]) {
 		struct idpf_vport_config *vport_config;
+		struct idpf_q_coalesce *q_coal;
 
 		vport_config = kzalloc(sizeof(*vport_config), GFP_KERNEL);
 		if (!vport_config) {
@@ -1144,6 +1146,21 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 			return NULL;
 		}
 
+		q_coal = kcalloc(num_max_q, sizeof(*q_coal), GFP_KERNEL);
+		if (!q_coal) {
+			kfree(vport_config);
+			kfree(vport);
+
+			return NULL;
+		}
+		for (int i = 0; i < num_max_q; i++) {
+			q_coal[i].tx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal[i].tx_coalesce_usecs = IDPF_ITR_TX_DEF;
+			q_coal[i].rx_intr_mode = IDPF_ITR_DYNAMIC;
+			q_coal[i].rx_coalesce_usecs = IDPF_ITR_RX_DEF;
+		}
+		vport_config->user_config.q_coalesce = q_coal;
+
 		adapter->vport_config[idx] = vport_config;
 	}
 
@@ -1153,7 +1170,6 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	vport->default_vport = adapter->num_alloc_vports <
 			       idpf_get_default_vports(adapter);
 
-	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	vport->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
 	if (!vport->q_vector_idxs)
 		goto free_vport;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index b7422be3e967..dfe9126f1f4a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -62,6 +62,7 @@ static void idpf_remove(struct pci_dev *pdev)
 	destroy_workqueue(adapter->vc_event_wq);
 
 	for (i = 0; i < adapter->max_vports; i++) {
+		kfree(adapter->vport_config[i]->user_config.q_coalesce);
 		kfree(adapter->vport_config[i]);
 		adapter->vport_config[i] = NULL;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index cef9dfb877e8..c976d9e15aca 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4355,9 +4355,13 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
 int idpf_vport_intr_alloc(struct idpf_vport *vport)
 {
 	u16 txqs_per_vector, rxqs_per_vector, bufqs_per_vector;
+	struct idpf_vport_user_config_data *user_config;
 	struct idpf_q_vector *q_vector;
+	struct idpf_q_coalesce *q_coal;
 	u32 complqs_per_vector, v_idx;
+	u16 idx = vport->idx;
 
+	user_config = &vport->adapter->vport_config[idx]->user_config;
 	vport->q_vectors = kcalloc(vport->num_q_vectors,
 				   sizeof(struct idpf_q_vector), GFP_KERNEL);
 	if (!vport->q_vectors)
@@ -4375,14 +4379,15 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 
 	for (v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		q_vector = &vport->q_vectors[v_idx];
+		q_coal = &user_config->q_coalesce[v_idx];
 		q_vector->vport = vport;
 
-		q_vector->tx_itr_value = IDPF_ITR_TX_DEF;
-		q_vector->tx_intr_mode = IDPF_ITR_DYNAMIC;
+		q_vector->tx_itr_value = q_coal->tx_coalesce_usecs;
+		q_vector->tx_intr_mode = q_coal->tx_intr_mode;
 		q_vector->tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
 
-		q_vector->rx_itr_value = IDPF_ITR_RX_DEF;
-		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
+		q_vector->rx_itr_value = q_coal->rx_coalesce_usecs;
+		q_vector->rx_intr_mode = q_coal->rx_intr_mode;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
 		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
-- 
2.47.1


