Return-Path: <netdev+bounces-231430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56587BF9356
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D154E3553BC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D212D0283;
	Tue, 21 Oct 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhBDf5Yk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DD2C029C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088817; cv=none; b=dGKgoPCnSs3o48LVjd6xA82y3UcxBdWNqWTJfZpYb8KAdVJ7FB0zU3Ot75kSmj/bGXVilPU6m/RCQv1oWBGOAWuLvgDEMvIV0vMoGMGVN7kZ9IOD4PoBhvLQXcWQLk31sBDxXx1CiktTORy9Qf9SOUgBos1ICWoL9ElBxQKPK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088817; c=relaxed/simple;
	bh=KrVPwOYMtDH2Q8UZHRREBsKYa8gcykUgJ8xKnVRoPC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATKHQx5w1pRZtC/V3NPVeRtIt7UO3TM0g67J3ot5Zq0lg/DLorzkZrQoNyUNuA7THmDMKV9AxgrJ9LhKMRtp+WVKrqVxWCtg98PLqyPQ5b7zsLfJU+m3QhjAd1+V6yIgx8xcKR54GXAQ0zZyjDeO4B4wN8M9JR46kQMa4Gumn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhBDf5Yk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761088816; x=1792624816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrVPwOYMtDH2Q8UZHRREBsKYa8gcykUgJ8xKnVRoPC4=;
  b=lhBDf5Ykysd6+GlzKusgV7Hc9VZ6LUcDLxG1SIhfqlvj6vv8K4GG6GdU
   2SSbabd49BrO8LnoqnYUZW2MjjyWSROHIfE1FxxdgW1066ATA0miIGCIv
   vSiToFm9mEoXcIJmRRHUetbIuEjamd3sQk0/YTlH6DxiPK/PLJL+vHfbZ
   kICEYKAZBF2wjmQpTyHr/+lmCOwp/h07k1pTRfFmBNPQ0VTce6cNOvc7f
   ndXazshl947lY6sLdqzGdyuTyjaf6dUwhb0TEauecNVypuS2ZPP5Zu4km
   W9xsKGIWyZj50QvrlVbTK9Q/xTJIY/vkWngzMBn2grMERAjbG3svxOhVw
   w==;
X-CSE-ConnectionGUID: XFL16gFGT72ozcfKR+vUfQ==
X-CSE-MsgGUID: lxR/kYz3Q6S8i6hpjXJ4OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66868448"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66868448"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 16:20:11 -0700
X-CSE-ConnectionGUID: oLV6SBkKTNyQGLvkhN/0Gw==
X-CSE-MsgGUID: R3zZa6SiQJ2ACai/XRI9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="214352304"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2025 16:20:11 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v9 04/10] idpf: move some iterator declarations inside for loops
Date: Tue, 21 Oct 2025 16:30:50 -0700
Message-Id: <20251021233056.1320108-5-joshua.a.hay@intel.com>
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

Move some iterator declarations to their respective for loops; use more
appropriate unsigned type.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 28 +++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 96 ++++++++-----------
 3 files changed, 57 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index f12c35c6f5ec..564fb25bc309 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -649,7 +649,7 @@ static int idpf_set_ringparam(struct net_device *netdev,
 	u32 new_rx_count, new_tx_count;
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
-	int i, err = 0;
+	int err = 0;
 	u16 idx;
 
 	idpf_vport_ctrl_lock(netdev);
@@ -704,7 +704,7 @@ static int idpf_set_ringparam(struct net_device *netdev,
 	/* Since we adjusted the RX completion queue count, the RX buffer queue
 	 * descriptor count needs to be adjusted as well
 	 */
-	for (i = 0; i < rsrc->num_bufqs_per_qgrp; i++)
+	for (unsigned int i = 0; i < rsrc->num_bufqs_per_qgrp; i++)
 		rsrc->bufq_desc_count[i] =
 			IDPF_RX_BUFQ_DESC_COUNT(new_rx_count,
 						rsrc->num_bufqs_per_qgrp);
@@ -1085,7 +1085,6 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 {
 	struct idpf_port_stats *pstats = &vport->port_stats;
 	struct idpf_q_vec_rsrc *rsrc = &vport->dflt_qv_rsrc;
-	int i, j;
 
 	/* zero out port stats since they're actually tracked in per
 	 * queue stats; this is only for reporting
@@ -1101,7 +1100,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 	u64_stats_set(&pstats->tx_dma_map_errs, 0);
 	u64_stats_update_end(&pstats->stats_sync);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rxq_grp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
 
@@ -1110,7 +1109,7 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 		else
 			num_rxq = rxq_grp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			u64 hw_csum_err, hsplit, hsplit_hbo, bad_descs;
 			struct idpf_rx_queue_stats *stats;
 			struct idpf_rx_queue *rxq;
@@ -1143,10 +1142,10 @@ static void idpf_collect_queue_stats(struct idpf_vport *vport)
 		}
 	}
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++) {
 			u64 linearize, qbusy, skb_drops, dma_map_errs;
 			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 			struct idpf_tx_queue_stats *stats;
@@ -1192,7 +1191,6 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
 	unsigned int total = 0;
-	unsigned int i, j;
 	bool is_splitq;
 	u16 qtype;
 
@@ -1211,12 +1209,12 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 	idpf_add_port_stats(vport, &data);
 
 	rsrc = &vport->dflt_qv_rsrc;
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
 		qtype = VIRTCHNL2_QUEUE_TYPE_TX;
 
-		for (j = 0; j < txq_grp->num_txq; j++, total++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++, total++) {
 			struct idpf_tx_queue *txq = txq_grp->txqs[j];
 
 			if (!txq)
@@ -1238,7 +1236,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 
 	is_splitq = idpf_is_queue_model_split(rsrc->rxq_model);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rxq_grp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
 
@@ -1249,7 +1247,7 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
 		else
 			num_rxq = rxq_grp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++, total++) {
+		for (unsigned int j = 0; j < num_rxq; j++, total++) {
 			struct idpf_rx_queue *rxq;
 
 			if (is_splitq)
@@ -1538,7 +1536,7 @@ static int idpf_set_coalesce(struct net_device *netdev,
 	struct idpf_q_coalesce *q_coal;
 	struct idpf_q_vec_rsrc *rsrc;
 	struct idpf_vport *vport;
-	int i, err = 0;
+	int err = 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
@@ -1549,14 +1547,14 @@ static int idpf_set_coalesce(struct net_device *netdev,
 		goto unlock_mutex;
 
 	rsrc = &vport->dflt_qv_rsrc;
-	for (i = 0; i < rsrc->num_txq; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq; i++) {
 		q_coal = &user_config->q_coalesce[i];
 		err = idpf_set_q_coalesce(vport, q_coal, ec, i, false);
 		if (err)
 			goto unlock_mutex;
 	}
 
-	for (i = 0; i < rsrc->num_rxq; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq; i++) {
 		q_coal = &user_config->q_coalesce[i];
 		err = idpf_set_q_coalesce(vport, q_coal, ec, i, true);
 		if (err)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index c84e5b85ed1e..244868307e81 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1393,20 +1393,18 @@ static int idpf_up_complete(struct idpf_vport *vport)
  */
 static void idpf_rx_init_buf_tail(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i, j;
-
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *grp = &rsrc->rxq_grps[i];
 
 		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
-			for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+			for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 				const struct idpf_buf_queue *q =
 					&grp->splitq.bufq_sets[j].bufq;
 
 				writel(q->next_to_alloc, q->tail);
 			}
 		} else {
-			for (j = 0; j < grp->singleq.num_rxq; j++) {
+			for (unsigned int j = 0; j < grp->singleq.num_rxq; j++) {
 				const struct idpf_rx_queue *q =
 					grp->singleq.rxqs[j];
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 92cd25923ed9..d1ceedfb0a5c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -152,15 +152,13 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
  */
 static void idpf_tx_desc_rel_all(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i, j;
-
 	if (!rsrc->txq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++)
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++)
 			idpf_tx_desc_rel(txq_grp->txqs[j]);
 
 		if (idpf_is_queue_model_split(rsrc->txq_model))
@@ -304,13 +302,12 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport,
 				  struct idpf_q_vec_rsrc *rsrc)
 {
 	int err = 0;
-	int i, j;
 
 	/* Setup buffer queues. In single queue model buffer queues and
 	 * completion queues will be same
 	 */
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
-		for (j = 0; j < rsrc->txq_grps[i].num_txq; j++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
+		for (unsigned int j = 0; j < rsrc->txq_grps[i].num_txq; j++) {
 			struct idpf_tx_queue *txq = rsrc->txq_grps[i].txqs[j];
 
 			err = idpf_tx_desc_alloc(vport, txq);
@@ -502,30 +499,29 @@ static void idpf_rx_desc_rel_all(struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_rxq_group *rx_qgrp;
 	u16 num_rxq;
-	int i, j;
 
 	if (!rsrc->rxq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		rx_qgrp = &rsrc->rxq_grps[i];
 
 		if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
-			for (j = 0; j < rx_qgrp->singleq.num_rxq; j++)
+			for (unsigned int j = 0; j < rx_qgrp->singleq.num_rxq; j++)
 				idpf_rx_desc_rel(rx_qgrp->singleq.rxqs[j],
 						 VIRTCHNL2_QUEUE_MODEL_SINGLE);
 			continue;
 		}
 
 		num_rxq = rx_qgrp->splitq.num_rxq_sets;
-		for (j = 0; j < num_rxq; j++)
+		for (unsigned int j = 0; j < num_rxq; j++)
 			idpf_rx_desc_rel(&rx_qgrp->splitq.rxq_sets[j]->rxq,
 					 VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 		if (!rx_qgrp->splitq.bufq_sets)
 			continue;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 
@@ -792,11 +788,11 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 			  struct idpf_q_vec_rsrc *rsrc)
 {
 	bool split = idpf_is_queue_model_split(rsrc->rxq_model);
-	int i, j, err;
+	int err;
 
 	idpf_xdp_copy_prog_to_rqs(rsrc, vport->xdp_prog);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
 		u32 truesize = 0;
 
@@ -804,7 +800,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 		if (!split) {
 			int num_rxq = rx_qgrp->singleq.num_rxq;
 
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				struct idpf_rx_queue *q;
 
 				q = rx_qgrp->singleq.rxqs[j];
@@ -817,7 +813,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport,
 		}
 
 		/* Otherwise, allocate bufs for the buffer queues */
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			enum libeth_fqe_type type;
 			struct idpf_buf_queue *q;
 
@@ -911,17 +907,17 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport,
 				  struct idpf_q_vec_rsrc *rsrc)
 {
 	struct idpf_rxq_group *rx_qgrp;
-	int i, j, err;
 	u16 num_rxq;
+	int err;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		rx_qgrp = &rsrc->rxq_grps[i];
 		if (idpf_is_queue_model_split(rsrc->rxq_model))
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
 		else
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			struct idpf_rx_queue *q;
 
 			if (idpf_is_queue_model_split(rsrc->rxq_model))
@@ -941,7 +937,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport,
 		if (!idpf_is_queue_model_split(rsrc->rxq_model))
 			continue;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_buf_queue *q;
 
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
@@ -1306,17 +1302,16 @@ int idpf_qp_switch(struct idpf_vport *vport, u32 qid, bool en)
 static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 {
 	bool split;
-	int i, j;
 
 	if (!rsrc->txq_grps)
 		return;
 
 	split = idpf_is_queue_model_split(rsrc->txq_model);
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *txq_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < txq_grp->num_txq; j++) {
+		for (unsigned int j = 0; j < txq_grp->num_txq; j++) {
 			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
@@ -1342,12 +1337,10 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
  */
 static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
 {
-	int i, j;
-
-	for (i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
+	for (unsigned int i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
 		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
 
-		for (j = 0; j < bufq_set->num_refillqs; j++) {
+		for (unsigned int j = 0; j < bufq_set->num_refillqs; j++) {
 			kfree(bufq_set->refillqs[j].ring);
 			bufq_set->refillqs[j].ring = NULL;
 		}
@@ -1362,19 +1355,16 @@ static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
  */
 static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 {
-	int i;
-
 	if (!rsrc->rxq_grps)
 		return;
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
 		u16 num_rxq;
-		int j;
 
 		if (idpf_is_queue_model_split(rsrc->rxq_model)) {
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				kfree(rx_qgrp->splitq.rxq_sets[j]);
 				rx_qgrp->splitq.rxq_sets[j] = NULL;
 			}
@@ -1384,7 +1374,7 @@ static void idpf_rxq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			rx_qgrp->splitq.bufq_sets = NULL;
 		} else {
 			num_rxq = rx_qgrp->singleq.num_rxq;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				kfree(rx_qgrp->singleq.rxqs[j]);
 				rx_qgrp->singleq.rxqs[j] = NULL;
 			}
@@ -1443,7 +1433,7 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 {
 	struct idpf_ptp_vport_tx_tstamp_caps *caps = vport->tx_tstamp_caps;
 	struct work_struct *tstamp_task = &vport->tstamp_task;
-	int i, j, k = 0;
+	int k = 0;
 
 	vport->txqs = kcalloc(rsrc->num_txq, sizeof(*vport->txqs),
 			      GFP_KERNEL);
@@ -1451,10 +1441,10 @@ static int idpf_vport_init_fast_path_txqs(struct idpf_vport *vport,
 		return -ENOMEM;
 
 	vport->num_txq = rsrc->num_txq;
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_grp = &rsrc->txq_grps[i];
 
-		for (j = 0; j < tx_grp->num_txq; j++, k++) {
+		for (unsigned int j = 0; j < tx_grp->num_txq; j++, k++) {
 			vport->txqs[k] = tx_grp->txqs[j];
 			vport->txqs[k]->idx = k;
 
@@ -1532,7 +1522,6 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
 	u8 num_bufqs = rsrc->num_bufqs_per_qgrp;
 	u32 num_req_txq_desc, num_req_rxq_desc;
 	u16 idx = vport->idx;
-	int i;
 
 	config_data =  &vport->adapter->vport_config[idx]->user_config;
 	num_req_txq_desc = config_data->num_req_txq_desc;
@@ -1559,7 +1548,7 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
 	else
 		rsrc->rxq_desc_count = IDPF_DFLT_RX_Q_DESC_COUNT;
 
-	for (i = 0; i < num_bufqs; i++) {
+	for (unsigned int i = 0; i < num_bufqs; i++) {
 		if (!rsrc->bufq_desc_count[i])
 			rsrc->bufq_desc_count[i] =
 				IDPF_RX_BUFQ_DESC_COUNT(rsrc->rxq_desc_count,
@@ -1717,7 +1706,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 				u16 num_txq)
 {
 	bool split, flow_sch_en;
-	int i;
 
 	rsrc->txq_grps = kcalloc(rsrc->num_txq_grp,
 				 sizeof(*rsrc->txq_grps), GFP_KERNEL);
@@ -1728,22 +1716,21 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
 				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
 
-	for (i = 0; i < rsrc->num_txq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &rsrc->txq_grps[i];
 		struct idpf_adapter *adapter = vport->adapter;
-		int j;
 
 		tx_qgrp->vport = vport;
 		tx_qgrp->num_txq = num_txq;
 
-		for (j = 0; j < tx_qgrp->num_txq; j++) {
+		for (unsigned int j = 0; j < tx_qgrp->num_txq; j++) {
 			tx_qgrp->txqs[j] = kzalloc(sizeof(*tx_qgrp->txqs[j]),
 						   GFP_KERNEL);
 			if (!tx_qgrp->txqs[j])
 				goto err_alloc;
 		}
 
-		for (j = 0; j < tx_qgrp->num_txq; j++) {
+		for (unsigned int j = 0; j < tx_qgrp->num_txq; j++) {
 			struct idpf_tx_queue *q = tx_qgrp->txqs[j];
 
 			q->dev = &adapter->pdev->dev;
@@ -1811,8 +1798,8 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				struct idpf_q_vec_rsrc *rsrc,
 				u16 num_rxq)
 {
-	int i, k, err = 0;
 	bool hs, rsc;
+	int err = 0;
 
 	rsrc->rxq_grps = kcalloc(rsrc->num_rxq_grp,
 				 sizeof(struct idpf_rxq_group), GFP_KERNEL);
@@ -1822,14 +1809,13 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 	hs = idpf_vport_get_hsplit(vport) == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 	rsc = idpf_is_feature_ena(vport, NETIF_F_GRO_HW);
 
-	for (i = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0; i < rsrc->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &rsrc->rxq_grps[i];
-		int j;
 
 		rx_qgrp->vport = vport;
 		if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
 			rx_qgrp->singleq.num_rxq = num_rxq;
-			for (j = 0; j < num_rxq; j++) {
+			for (unsigned int j = 0; j < num_rxq; j++) {
 				rx_qgrp->singleq.rxqs[j] =
 						kzalloc(sizeof(*rx_qgrp->singleq.rxqs[j]),
 							GFP_KERNEL);
@@ -1842,7 +1828,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 		rx_qgrp->splitq.num_rxq_sets = num_rxq;
 
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			rx_qgrp->splitq.rxq_sets[j] =
 				kzalloc(sizeof(struct idpf_rxq_set),
 					GFP_KERNEL);
@@ -1861,7 +1847,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 		rx_qgrp->splitq.num_bufq_sets = rsrc->num_bufqs_per_qgrp;
 
-		for (j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+		for (unsigned int j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
 			struct idpf_bufq_set *bufq_set =
 				&rx_qgrp->splitq.bufq_sets[j];
 			int swq_size = sizeof(struct idpf_sw_queue);
@@ -1881,7 +1867,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				err = -ENOMEM;
 				goto err_alloc;
 			}
-			for (k = 0; k < bufq_set->num_refillqs; k++) {
+			for (unsigned int k = 0; k < bufq_set->num_refillqs; k++) {
 				struct idpf_sw_queue *refillq =
 					&bufq_set->refillqs[k];
 
@@ -1900,7 +1886,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 		}
 
 skip_splitq_rx_init:
-		for (j = 0; j < num_rxq; j++) {
+		for (unsigned int j = 0; j < num_rxq; j++) {
 			struct idpf_rx_queue *q;
 
 			if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
@@ -4368,9 +4354,9 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 	bool split = idpf_is_queue_model_split(rsrc->rxq_model);
 	struct idpf_rxq_group *rx_qgrp;
 	struct idpf_txq_group *tx_qgrp;
-	u32 i, qv_idx, q_index;
+	u32 q_index;
 
-	for (i = 0, qv_idx = 0; i < rsrc->num_rxq_grp; i++) {
+	for (unsigned int i = 0, qv_idx = 0; i < rsrc->num_rxq_grp; i++) {
 		u16 num_rxq;
 
 		if (qv_idx >= rsrc->num_q_vectors)
@@ -4415,7 +4401,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 
 	split = idpf_is_queue_model_split(rsrc->txq_model);
 
-	for (i = 0, qv_idx = 0; i < num_txq_grp; i++) {
+	for (unsigned int i = 0, qv_idx = 0; i < num_txq_grp; i++) {
 		u16 num_txq;
 
 		if (qv_idx >= rsrc->num_q_vectors)
@@ -4442,7 +4428,7 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport,
 		qv_idx++;
 	}
 
-	for (i = 0; i < vport->num_xdp_txq; i++) {
+	for (unsigned int i = 0; i < vport->num_xdp_txq; i++) {
 		struct idpf_tx_queue *xdpsq;
 		struct idpf_q_vector *qv;
 
-- 
2.39.2


