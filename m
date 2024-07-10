Return-Path: <netdev+bounces-110638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3288292DA18
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BD51C21C24
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F1198A33;
	Wed, 10 Jul 2024 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxYBAye8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDD198A01
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643447; cv=none; b=uCar5Bd0gkuVv95OoMWqySia4c9ZWQ6LOeOxNl+MOoCAp+eOYrdVmtThXdWxc/gJhl72T/amB2p7YmnS9s4aiJr/AlkYKGvrwXFm5l3rTp9Ggmlia1tMJkKR7/JO1zQDhgpb/cG+CcDexwTW9NVU7Xkt7s/vX2NL69pihITe/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643447; c=relaxed/simple;
	bh=pzTjtnHiF5zZr1kPqbnAqbvrHYOHsDj+4jjIpx7TTV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1fN4g47p/Vg2yU90a5d1TXkmZWr3Q0L9fcAdGX0Xrv8eMtV7Xa/MiSiMe5Vt3hy8bRAFhQ4i0Fex8HSkbmPnJGIXVPQ7/m5qxvO+cOciYDRAF1t1heukLTaeHyTJ5mW6HwsnJeULUeqfoh7fjv5wmGdXO63Uvu4dcu/dJQwyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxYBAye8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643446; x=1752179446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pzTjtnHiF5zZr1kPqbnAqbvrHYOHsDj+4jjIpx7TTV4=;
  b=IxYBAye8vXsErfJ6BT/ThuVR92Z/ZxJege5vbZesaRyaFMXuj8JZ8n0g
   qVxauwCGQFPAENuJVbVpI39HtUhj2H6WBbDP8B+yZEi03v/geMQ5IzJL4
   RtOxBgj+YMxumq4Z315vDtus0qQLvSStL2hUS0xZ9umCUfLkhOvO30vqh
   PnW6hqs918wuYRT/jQCN8ftXDGdg9MhgTEfgBc+/Ld/FsLBelEndu3YTU
   WgNFB23nipQUhenPi8E3pIqPS0WzYz9lwGRkNE8xdO09+JMxW2eeVwI9u
   ZRrfbHk9i+oU5jTKGA5SB2Ts7QNXWZJ1jP0diyTSesqqfBfCvX+Zof7sQ
   g==;
X-CSE-ConnectionGUID: qX9xWKP2RUuEiurkNb4Yqw==
X-CSE-MsgGUID: rDHUM5OFSISs8m5j2CzD9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483764"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:42 -0700
X-CSE-ConnectionGUID: gcLRK9n2QgaGlGh1Nmvp3w==
X-CSE-MsgGUID: zVQEg/rWRn+57SZMQBjakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223872"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 06/14] idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
Date: Wed, 10 Jul 2024 13:30:22 -0700
Message-ID: <20240710203031.188081-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

With CONFIG_MAXSMP, sizeof(cpumask_t) is 1 Kb. The queue vector
structure has them embedded, which means 1 additional Kb of not
really hotpath data.
We have cpumask_var_t, which is either an embedded cpumask or a pointer
for allocating it dynamically when it's big. Use it instead of plain
cpumasks and put &idpf_q_vector on a good diet.
Also remove redundant pointer to the interrupt name from the structure.
request_irq() saves it and free_irq() returns it on deinit, so that you
can free the memory.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 13 ++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 20 +++++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  7 +++----
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a5612120ad51..fafd279127a3 100644
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
index 7be5a723f558..f569ea389b04 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 704aec5c383b..5daa8f905f86 100644
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
-- 
2.41.0


