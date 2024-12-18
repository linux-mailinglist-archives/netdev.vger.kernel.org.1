Return-Path: <netdev+bounces-153080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C09F6BC4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A37D188DB61
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0561FAC3E;
	Wed, 18 Dec 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beQQWIZI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5B1E9B33
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541188; cv=none; b=SY49NjA38DZiU/547+esHOJCmzJzZwcxkQxJfflhWRIeXBBOkWngS4WRk8UMFEBoFuUxpi2hO5pYHm1YGzKBqaa2XCtXdR1CTl9kYqMruDpfnYUflepif/KMvbpJ1z3JLYj1CJ/nCxkwocHx+u+HcAFfNNMxOPSx9JmyvDjT5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541188; c=relaxed/simple;
	bh=+EBJQNSey1vuYHbtBWymdjwof1PcAwjficYMP7V+1UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfJyggwTTwPlS8ndYFhjqfJ9NZ3iM094RxVRABwDozK1SwhgZ6DNwX5jCFOfZj2V4J3EpqWkPayBFfm0u/aqbUS3pNVAUbpBatkdmOPCFd9xmdi30zk0quhcuIP6VBKvzIjl0wOe19pgZHWvXZgUbMk+nNk/0ZsTUxSbOD24Kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beQQWIZI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541187; x=1766077187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+EBJQNSey1vuYHbtBWymdjwof1PcAwjficYMP7V+1UA=;
  b=beQQWIZIG9Kgf4aGdqU3X0oSjw4CseVVp5aygPndgHoZAfOlMZlJ0acS
   QqnI2Z3uBqLlXq1c9SjZJ16MaxekbGCkiDP1Jvir9bxrHg6jIDhLKknay
   nIm9dun+oubta3LjZg2l5doDdLljBuWEz7MjMKmp7Go7J8BA//dNadgek
   3W6mhyafk90Q6s9XqR2+qJRaB0pts52wBoEIuoeqOMvAVBfrfujWlWrso
   /hn/+ZDPAjOMEISb/nvuf5xrWM9Sr1C0SFPAiDVjGkhUOtIuTiRfKwqAB
   fShtz/w2dAXs/YHWIy/V09U82evIem2Opq0asjgDQVIiZME81FpDnnci+
   Q==;
X-CSE-ConnectionGUID: 2v995p4vS5WZdu8rHA4PGg==
X-CSE-MsgGUID: TFkG9mrESsC5AAjiv4KMhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415623"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415623"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:46 -0800
X-CSE-ConnectionGUID: PrHYwGCyR7CYpkgsAEZfzw==
X-CSE-MsgGUID: CwmyFyM5R16wAF9WKU73SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102532077"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:41 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 7/8] idpf: use napi's irq affinity
Date: Wed, 18 Dec 2024 09:58:42 -0700
Message-ID: <20241218165843.744647-8-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218165843.744647-1-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the driver CPU affinity info and use the core's napi config
instead.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 19 +++++--------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++----
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 34f4118c7bc0..5728f0bfc610 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3554,8 +3554,6 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 		q_vector->tx = NULL;
 		kfree(q_vector->rx);
 		q_vector->rx = NULL;
-
-		free_cpumask_var(q_vector->affinity_mask);
 	}
 
 	kfree(vport->q_vectors);
@@ -3582,8 +3580,6 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
-		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(irq_num, NULL);
 		kfree(free_irq(irq_num, q_vector));
 	}
 }
@@ -3762,8 +3758,6 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
-		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, q_vector->affinity_mask);
 	}
 
 	return 0;
@@ -4184,12 +4178,12 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
 
 	for (v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[v_idx];
+		int irq_num = vport->adapter->msix_entries[v_idx].vector;
 
-		netif_napi_add(vport->netdev, &q_vector->napi, napi_poll);
-
-		/* only set affinity_mask if the CPU is online */
-		if (cpu_online(v_idx))
-			cpumask_set_cpu(v_idx, q_vector->affinity_mask);
+		netif_napi_add_config(vport->netdev, &q_vector->napi,
+				      napi_poll, v_idx);
+		netif_napi_set_irq(&q_vector->napi,
+				   irq_num, NAPIF_IRQ_AFFINITY);
 	}
 }
 
@@ -4233,9 +4227,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
-		if (!zalloc_cpumask_var(&q_vector->affinity_mask, GFP_KERNEL))
-			goto error;
-
 		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
 				       GFP_KERNEL);
 		if (!q_vector->tx)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9c1fe84108ed..5efb3402b378 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -397,7 +397,6 @@ struct idpf_intr_reg {
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
  * @v_idx: Vector index
- * @affinity_mask: CPU affinity mask
  */
 struct idpf_q_vector {
 	__cacheline_group_begin_aligned(read_mostly);
@@ -434,13 +433,12 @@ struct idpf_q_vector {
 	__cacheline_group_begin_aligned(cold);
 	u16 v_idx;
 
-	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 112,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8 + sizeof(cpumask_var_t));
+			    8);
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
@@ -934,7 +932,7 @@ static inline int idpf_q_vector_to_mem(const struct idpf_q_vector *q_vector)
 	if (!q_vector)
 		return NUMA_NO_NODE;
 
-	cpu = cpumask_first(q_vector->affinity_mask);
+	cpu = cpumask_first(&q_vector->napi.config->affinity_mask);
 
 	return cpu < nr_cpu_ids ? cpu_to_mem(cpu) : NUMA_NO_NODE;
 }
-- 
2.43.0


