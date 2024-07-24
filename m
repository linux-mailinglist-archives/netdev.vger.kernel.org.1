Return-Path: <netdev+bounces-112772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E628693B1CF
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B52F28355B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751115A87C;
	Wed, 24 Jul 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIbZ+vUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591C15A85A;
	Wed, 24 Jul 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828453; cv=none; b=QR9KLRTuBrijfmY5W3IbSqLurETkdP5lBbCO0Lv2zvwL6+SuOxqbV34DK6s3yABPihtTRFAxf8rJIa21/vr44hVxeq+cKMAt6pbtiT43KhwayTqHVKxEhE8jAulUQR91AnZzjWVdOoLdByerPTMRZbJ54EGRAUe0qtTpy91BUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828453; c=relaxed/simple;
	bh=rsgxUZRTvl1cNNXgw08umMqld3Xw6cnIB2s9pqul3jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjb3Ij5OSm656Y8LynYQJVdvirlh7D32Bb2WJ6SOLSzqGocnD8DPPvKefn7N24r2+CSQYI8XiiEIMjl0y/uUgUDATgu4WT2wN3HkBjnFLNYqhf0oftV0Q5d7pOMRshaVMGqwayQtR/lMNkISDlF8SoHezVi9oMqw7e0edvEpQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIbZ+vUQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721828452; x=1753364452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rsgxUZRTvl1cNNXgw08umMqld3Xw6cnIB2s9pqul3jY=;
  b=ZIbZ+vUQpdv/mvur0DrzVzwl8gAMb1zxha66lqS6uHAfM8IggUqQGfji
   hq/m8m4KXg+axbQeU6WuB/gYywueU3UZc/HEL3HAK9kJBM3L0qoV39OyG
   nuyDQuxRlivTeHn2A7cbIIA3uIzEJkaLyr1huXdJeP62r2mmgHVnspH0A
   aimB2iSYz7cUZKMk3j45F5Bhcq/jp1ntWQLPrYPNWunyuiRZMI2ZdHI4Z
   TFOJDhn23KBUJJce/iDOhrqaL0vmliqMW24sUI+oCcIeUx+13UInzEZVQ
   bzlXtiprTr+/FlQWdILOyiinPjX8dnfV2iivZ536l7QS4k6FUQuRjaUTv
   Q==;
X-CSE-ConnectionGUID: pbrrooP5QGSIcD3kvyemaw==
X-CSE-MsgGUID: /XeA5E9/RVSSiySvg6JKHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19469396"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19469396"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 06:40:52 -0700
X-CSE-ConnectionGUID: 5Wvo4E6OSBSepv5zfWDn3A==
X-CSE-MsgGUID: FkMY7tQeSLOee0112W9Z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52615665"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 24 Jul 2024 06:40:49 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net 3/3] idpf: fix UAFs when destroying the queues
Date: Wed, 24 Jul 2024 15:40:24 +0200
Message-ID: <20240724134024.2182959-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second tagged commit started sometimes (very rarely, but possible)
throwing WARNs from
net/core/page_pool.c:page_pool_disable_direct_recycling().
Turned out idpf frees interrupt vectors with embedded NAPIs *before*
freeing the queues making page_pools' NAPI pointers lead to freed
memory before these pools are destroyed by libeth.
It's not clear whether there are other accesses to the freed vectors
when destroying the queues, but anyway, we usually free queue/interrupt
vectors only when the queues are destroyed and the NAPIs are guaranteed
to not be referenced anywhere.

Invert the allocation and freeing logic making queue/interrupt vectors
be allocated first and freed last. Vectors don't require queues to be
present, so this is safe. Additionally, this change allows to remove
that useless queue->q_vector pointer cleanup, as vectors are still
valid when freeing the queues (+ both are freed within one function,
so it's not clear why nullify the pointers at all).

Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Reported-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 24 ++++++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 24 +--------------------
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 10b884dd3475..0b6c8fd5bc90 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -900,8 +900,8 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 
 	vport->link_up = false;
 	idpf_vport_intr_deinit(vport);
-	idpf_vport_intr_rel(vport);
 	idpf_vport_queues_rel(vport);
+	idpf_vport_intr_rel(vport);
 	np->state = __IDPF_VPORT_DOWN;
 }
 
@@ -1349,43 +1349,43 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	/* we do not allow interface up just yet */
 	netif_carrier_off(vport->netdev);
 
-	err = idpf_vport_queues_alloc(vport);
-	if (err)
-		return err;
-
 	err = idpf_vport_intr_alloc(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to allocate interrupts for vport %u: %d\n",
 			vport->vport_id, err);
-		goto queues_rel;
+		return err;
 	}
 
+	err = idpf_vport_queues_alloc(vport);
+	if (err)
+		goto intr_rel;
+
 	err = idpf_vport_queue_ids_init(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue ids for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_rel;
+		goto queues_rel;
 	}
 
 	err = idpf_vport_intr_init(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize interrupts for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_rel;
+		goto queues_rel;
 	}
 
 	err = idpf_rx_bufs_init_all(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize RX buffers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_rel;
+		goto queues_rel;
 	}
 
 	err = idpf_queue_reg_init(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_rel;
+		goto queues_rel;
 	}
 
 	idpf_rx_init_buf_tail(vport);
@@ -1452,10 +1452,10 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
 intr_deinit:
 	idpf_vport_intr_deinit(vport);
-intr_rel:
-	idpf_vport_intr_rel(vport);
 queues_rel:
 	idpf_vport_queues_rel(vport);
+intr_rel:
+	idpf_vport_intr_rel(vport);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a2f9f252694a..585c3dadd9bf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3576,9 +3576,7 @@ static void idpf_vport_intr_napi_dis_all(struct idpf_vport *vport)
  */
 void idpf_vport_intr_rel(struct idpf_vport *vport)
 {
-	int i, j, v_idx;
-
-	for (v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
+	for (u32 v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[v_idx];
 
 		kfree(q_vector->complq);
@@ -3593,26 +3591,6 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 		free_cpumask_var(q_vector->affinity_mask);
 	}
 
-	/* Clean up the mapping of queues to vectors */
-	for (i = 0; i < vport->num_rxq_grp; i++) {
-		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-
-		if (idpf_is_queue_model_split(vport->rxq_model))
-			for (j = 0; j < rx_qgrp->splitq.num_rxq_sets; j++)
-				rx_qgrp->splitq.rxq_sets[j]->rxq.q_vector = NULL;
-		else
-			for (j = 0; j < rx_qgrp->singleq.num_rxq; j++)
-				rx_qgrp->singleq.rxqs[j]->q_vector = NULL;
-	}
-
-	if (idpf_is_queue_model_split(vport->txq_model))
-		for (i = 0; i < vport->num_txq_grp; i++)
-			vport->txq_grps[i].complq->q_vector = NULL;
-	else
-		for (i = 0; i < vport->num_txq_grp; i++)
-			for (j = 0; j < vport->txq_grps[i].num_txq; j++)
-				vport->txq_grps[i].txqs[j]->q_vector = NULL;
-
 	kfree(vport->q_vectors);
 	vport->q_vectors = NULL;
 }
-- 
2.45.2


