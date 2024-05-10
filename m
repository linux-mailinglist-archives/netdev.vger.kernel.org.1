Return-Path: <netdev+bounces-95514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3258C27C2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFAA1C21BC1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE2172BBA;
	Fri, 10 May 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVWplveO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C012C526;
	Fri, 10 May 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354869; cv=none; b=nRwnTJqgjNk2ZowQV/Hd+WkU2FHTjr/ee+juu9T2crszp/rvf0dRDnAdiFouD71+KKNmE06EgVJfluv0JYlbwnW830Mya8/E0/+Z0aHmnG5JgRpdbayl5qpRWcex/TPl24xILXf51nRTa9tUBSFQoY7Wj9Fe73/kSHpZLk1hVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354869; c=relaxed/simple;
	bh=IicC0xPQgpcazt740r57XpVtwR2n0DTaEXjZkC02oQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzK1uiLBXM9hROGJ+0IgAo+7w6yGucA5P4P0eiat69T02B0FxyQp8PPjaDFvs1sQIJfqyPK7qxxWqz4gpRA96iq2PtU9TqBb1RAqS9dsqLwPEhq5or96f3jotvYRk/1LWQ8hmRX8lhp6JVgn/H2oICW5VuUyLAYDMYy+8e4eOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVWplveO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354853; x=1746890853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IicC0xPQgpcazt740r57XpVtwR2n0DTaEXjZkC02oQc=;
  b=NVWplveOkbLPSbAFyvj+D6cZkWnwOaxC+BQFT9Kv6q22I4YJniT13K88
   9dgQ85HlgYJjJrYN78Zs70iba05BBNWHAW0KCfpE2itu5tGPQQKDAqQQR
   RNwMqBQGw84R2TXw51GtyK4N12oDFDlG1HGTdwZsFjtJ3DLUq9H/xiNui
   0vW4bwhnu8WD3qLChOzMUWQAa5lEHUk4Mf/z0ctiLhLahZnXA9mn46BMG
   xqPChwyd9ynY9Zj8RzVvmgt4mgTDciPuAbkXgwHGKJeC1GVBLbZo621/1
   IsO4Jn9CT65HwZoF4kzQ35F34UjkBWV5R74UQBw7lrEEm+rwVBCiEr6N+
   A==;
X-CSE-ConnectionGUID: IUOYOIH8T8OxxB/3nD615g==
X-CSE-MsgGUID: yhQNTqLnTZeUYrIQpIADHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152589"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152589"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:32 -0700
X-CSE-ConnectionGUID: 5OjfPU3uT+GseBQ3EZKkmQ==
X-CSE-MsgGUID: xHfSdIytQPeJCZShT2K+0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208262"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:29 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 04/12] idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
Date: Fri, 10 May 2024 17:26:12 +0200
Message-ID: <20240510152620.2227312-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_MAXSMP, sizeof(cpumask_t) is 1 Kb. The queue vector
structure has them embedded, which means 1 additional Kb of not
really hotpath data.
We have cpumask_var_t, which is either an embedded cpumask or a pointer
for allocating it dynamically when it's big. Use it instead of plain
cpumasks and put &idpf_q_vector on a good diet.
Also remove redundant pointer to the interrupt name from the structure.
request_irq() saves it and free_irq() returns it on deinit, so that you
can free the memory.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 13 ++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 20 +++++++++++++-------
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index fb645c6887b3..428b82b4de80 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -505,7 +505,6 @@ struct idpf_intr_reg {
 /**
  * struct idpf_q_vector
  * @vport: Vport back pointer
- * @affinity_mask: CPU affinity mask
  * @napi: napi handler
  * @v_idx: Vector index
  * @intr_reg: See struct idpf_intr_reg
@@ -526,11 +525,10 @@ struct idpf_intr_reg {
  * @num_bufq: Number of buffer queues
  * @bufq: Array of buffer queues to service
  * @total_events: Number of interrupts processed
- * @name: Queue vector name
+ * @affinity_mask: CPU affinity mask
  */
 struct idpf_q_vector {
 	struct idpf_vport *vport;
-	cpumask_t affinity_mask;
 	struct napi_struct napi;
 	u16 v_idx;
 	struct idpf_intr_reg intr_reg;
@@ -556,7 +554,8 @@ struct idpf_q_vector {
 	struct idpf_buf_queue **bufq;
 
 	u16 total_events;
-	char *name;
+
+	cpumask_var_t affinity_mask;
 };
 
 struct idpf_rx_queue_stats {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 3e8b24430dd8..a8be09a89943 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -69,7 +69,7 @@ static void idpf_deinit_vector_stack(struct idpf_adapter *adapter)
 static void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 {
 	clear_bit(IDPF_MB_INTR_MODE, adapter->flags);
-	free_irq(adapter->msix_entries[0].vector, adapter);
+	kfree(free_irq(adapter->msix_entries[0].vector, adapter));
 	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
 }
 
@@ -124,15 +124,14 @@ static void idpf_mb_irq_enable(struct idpf_adapter *adapter)
  */
 static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 {
-	struct idpf_q_vector *mb_vector = &adapter->mb_vector;
 	int irq_num, mb_vidx = 0, err;
+	char *name;
 
 	irq_num = adapter->msix_entries[mb_vidx].vector;
-	mb_vector->name = kasprintf(GFP_KERNEL, "%s-%s-%d",
-				    dev_driver_string(&adapter->pdev->dev),
-				    "Mailbox", mb_vidx);
-	err = request_irq(irq_num, adapter->irq_mb_handler, 0,
-			  mb_vector->name, adapter);
+	name = kasprintf(GFP_KERNEL, "%s-%s-%d",
+			 dev_driver_string(&adapter->pdev->dev),
+			 "Mailbox", mb_vidx);
+	err = request_irq(irq_num, adapter->irq_mb_handler, 0, name, adapter);
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 211c403a4c98..500754795cc8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3613,6 +3613,8 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 		q_vector->tx = NULL;
 		kfree(q_vector->rx);
 		q_vector->rx = NULL;
+
+		free_cpumask_var(q_vector->affinity_mask);
 	}
 
 	/* Clean up the mapping of queues to vectors */
@@ -3661,7 +3663,7 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 
 		/* clear the affinity_mask in the IRQ descriptor */
 		irq_set_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, q_vector);
+		kfree(free_irq(irq_num, q_vector));
 	}
 }
 
@@ -3812,6 +3814,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 
 	for (vector = 0; vector < vport->num_q_vectors; vector++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[vector];
+		char *name;
 
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
@@ -3825,18 +3828,18 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 		else
 			continue;
 
-		q_vector->name = kasprintf(GFP_KERNEL, "%s-%s-%d",
-					   basename, vec_name, vidx);
+		name = kasprintf(GFP_KERNEL, "%s-%s-%d", basename, vec_name,
+				 vidx);
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
-				  q_vector->name, q_vector);
+				  name, q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
 		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
+		irq_set_affinity_hint(irq_num, q_vector->affinity_mask);
 	}
 
 	return 0;
@@ -3845,7 +3848,7 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport, char *basename)
 	while (--vector >= 0) {
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
-		free_irq(irq_num, &vport->q_vectors[vector]);
+		kfree(free_irq(irq_num, &vport->q_vectors[vector]));
 	}
 
 	return err;
@@ -4255,7 +4258,7 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
 
 		/* only set affinity_mask if the CPU is online */
 		if (cpu_online(v_idx))
-			cpumask_set_cpu(v_idx, &q_vector->affinity_mask);
+			cpumask_set_cpu(v_idx, q_vector->affinity_mask);
 	}
 }
 
@@ -4299,6 +4302,9 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
+		if (!zalloc_cpumask_var(&q_vector->affinity_mask, GFP_KERNEL))
+			goto error;
+
 		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
 				       GFP_KERNEL);
 		if (!q_vector->tx)
-- 
2.45.0


