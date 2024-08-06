Return-Path: <netdev+bounces-116264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF7949AFA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F2E1C220E9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A2171E68;
	Tue,  6 Aug 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNuh8x3U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BB16CD11
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982181; cv=none; b=B6vFIhGVI5kquzgHonn/qTyymxaDwl4TMVnaIz3QKJPCXOzYdffE9ZRsNfjfIPInu5eGhyhb6q14zcaamBGQA+LGCmoHVtS79084jNy9TQFALK1eQOa8VW6g0f2dQWrXFtBXnHI3rTLkCflsjs2k6f/Gd48QAoSptFXxU3GvBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982181; c=relaxed/simple;
	bh=GSjSLjQAJkp5McZkWVtEllhDgA+NMi5790KOCvBjozg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGr35ZgRDKgF9sjwjy+rORkDA3CDPdqDwbz5FkobdiysFC4F0XC5dQU+CNmP7XFGXXJoqgR04OemLDLxJueSjdC3n1cNTTVnM/+lModx9wyTSDN3cECcxfMxzzfatK62EopoRa0a0GEKMBfpWiHEdK9Ek/Dja/qQ9hFqhWk4S0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNuh8x3U; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982180; x=1754518180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSjSLjQAJkp5McZkWVtEllhDgA+NMi5790KOCvBjozg=;
  b=SNuh8x3UmSGMPDoBcH2vz0JNXcXD5exhWnW7hcqW+cezCxgOi+Z5PCSQ
   5gZq/KEOVCm9H+eNidYJUdrOW9A5YI1lTHJTRxfeqPlnqe5N4BhhxQxr/
   0eS3jI09d0TCRHZhq7Drpr3acDNgtFT13rZA4MXYewHqmUDPdVVO0I/N1
   oCST4C/WASFh93v5bQD8uBhigoGJBT3Gdbd2dwcZbzVLOCifDLfLthmf0
   zcMmRDyvQ24koLS+viujDOQyEfKVrOjINFz5+Y1bfrDdh3OA8ny0Y5gcY
   K6Xma8rojwhN8kU7UU7HwD1w7pp5WeDcT+EkvTOkYFbTcHZAaZQvnfzr0
   g==;
X-CSE-ConnectionGUID: WA+BCEWtTg69odcIwWsjHA==
X-CSE-MsgGUID: Z7GDzIc4ReOJVK9aoxx7tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21172205"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21172205"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:09:38 -0700
X-CSE-ConnectionGUID: BPRl6doCRJ22Aj2ZRJwK8A==
X-CSE-MsgGUID: CbC0tQcqQfiFSo2+qgJIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56297929"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 15:09:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 3/3] idpf: fix UAFs when destroying the queues
Date: Tue,  6 Aug 2024 15:09:22 -0700
Message-ID: <20240806220923.3359860-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
References: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


