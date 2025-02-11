Return-Path: <netdev+bounces-165289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A7A31748
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291D016674D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279C264F9C;
	Tue, 11 Feb 2025 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atKQrAsb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C21264F97
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308086; cv=none; b=R6dMpMaG7M7chJtP4/xKWx/rUbJMf3bmLnS68CfPXV0dqMIAtS6elFTxwHwRWUqdLuTdqEcepEYX+XGDpOWHqb5Bd/aORMOI4PFlH51tYK/3azuPxaiycQqGo59Sv1wnvz1sErJWisN1ftStw9yp6oetUDEtYbIOqXdHe0Bvdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308086; c=relaxed/simple;
	bh=F2A1sbBGDTliqI1hNPU4g+3NM7tTstsUVo9xnNsPJLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3yJCtbC38Esrt4IMnAPosflwSfXUZ3mJHnwgmDwq34rfkZiZlQlm1Dn70FhAy1yAHTC29V94AZm1GnlJ4E5zfyz6kjKQZFdO71qJGiY/Kc0UOhoBrD5mjrNw93UZj3RRAqxcsGJpOilJZMC0qgCrZv/jv6OMbKkfzUTAC3GBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atKQrAsb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308082; x=1770844082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2A1sbBGDTliqI1hNPU4g+3NM7tTstsUVo9xnNsPJLA=;
  b=atKQrAsbG0wTJ5WrcBrYg891YJOEsDdXLWIkwKWsV8bGaDwYD7aCrjtj
   BwSq29fJ7CWbWcD31qgEUZj+8EqHp82nfAPXx7L+Nh3ZATvIfccXMtf9W
   3plEuvEL6RazNmkqo/vAaxe4kpowfz0Vc0uUObIgmB14IBBXq1rUhlUUt
   mUfUOpfo2Ud5pKoP8zUPJ2pNbufCAxgO1H58YsmXq9FpRM+tF2fhp6JVN
   VRXbad6kBYbLvdEuDC8yhzvhHGZ23GcndQonihKA7eXPbO+s0fPF4JLxt
   3UOqrusgHnV3zl6IJoeII2/eMJl2qhRM47YZ7hEiDi7B4GVLnOsJY5f+j
   g==;
X-CSE-ConnectionGUID: vEb7UHp3S2yAe+vxMFke0w==
X-CSE-MsgGUID: veacGK+fRJOv0jQ07a0deg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51339718"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51339718"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:08:01 -0800
X-CSE-ConnectionGUID: SDtLU0I+SPaXgR1ZFf1VFA==
X-CSE-MsgGUID: Sf/be9hPThGqJbQ0kV/TkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116713280"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:55 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 6/6] idpf: use napi's irq affinity
Date: Tue, 11 Feb 2025 14:06:57 -0700
Message-ID: <20250211210657.428439-7-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211210657.428439-1-ahmed.zaki@intel.com>
References: <20250211210657.428439-1-ahmed.zaki@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 22 +++++++--------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++----
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b4fbb99bfad2..078f71733d1d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -814,6 +814,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->hw_features |= dflt_features | offloads;
 	netdev->hw_enc_features |= dflt_features | offloads;
 	idpf_set_ethtool_ops(netdev);
+	netif_set_affinity_auto(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
 
 	/* carrier off on init to avoid Tx hangs */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 2fa9c36e33c9..f6b5b45a061c 100644
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
@@ -3771,8 +3767,6 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
-		/* assign the mask for this irq */
-		irq_set_affinity_hint(irq_num, q_vector->affinity_mask);
 	}
 
 	return 0;
@@ -4184,7 +4178,8 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
 static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
 {
 	int (*napi_poll)(struct napi_struct *napi, int budget);
-	u16 v_idx;
+	u16 v_idx, qv_idx;
+	int irq_num;
 
 	if (idpf_is_queue_model_split(vport->txq_model))
 		napi_poll = idpf_vport_splitq_napi_poll;
@@ -4193,12 +4188,12 @@ static void idpf_vport_intr_napi_add_all(struct idpf_vport *vport)
 
 	for (v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[v_idx];
+		qv_idx = vport->q_vector_idxs[v_idx];
+		irq_num = vport->adapter->msix_entries[qv_idx].vector;
 
-		netif_napi_add(vport->netdev, &q_vector->napi, napi_poll);
-
-		/* only set affinity_mask if the CPU is online */
-		if (cpu_online(v_idx))
-			cpumask_set_cpu(v_idx, q_vector->affinity_mask);
+		netif_napi_add_config(vport->netdev, &q_vector->napi,
+				      napi_poll, v_idx);
+		netif_napi_set_irq(&q_vector->napi, irq_num);
 	}
 }
 
@@ -4242,9 +4237,6 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 		q_vector->rx_intr_mode = IDPF_ITR_DYNAMIC;
 		q_vector->rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
 
-		if (!zalloc_cpumask_var(&q_vector->affinity_mask, GFP_KERNEL))
-			goto error;
-
 		q_vector->tx = kcalloc(txqs_per_vector, sizeof(*q_vector->tx),
 				       GFP_KERNEL);
 		if (!q_vector->tx)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 0f71a6f5557b..13251f63c7c3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -401,7 +401,6 @@ struct idpf_intr_reg {
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
  * @v_idx: Vector index
- * @affinity_mask: CPU affinity mask
  */
 struct idpf_q_vector {
 	__cacheline_group_begin_aligned(read_mostly);
@@ -438,13 +437,12 @@ struct idpf_q_vector {
 	__cacheline_group_begin_aligned(cold);
 	u16 v_idx;
 
-	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_q_vector, 120,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
-			    8 + sizeof(cpumask_var_t));
+			    8);
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
@@ -940,7 +938,7 @@ static inline int idpf_q_vector_to_mem(const struct idpf_q_vector *q_vector)
 	if (!q_vector)
 		return NUMA_NO_NODE;
 
-	cpu = cpumask_first(q_vector->affinity_mask);
+	cpu = cpumask_first(&q_vector->napi.config->affinity_mask);
 
 	return cpu < nr_cpu_ids ? cpu_to_mem(cpu) : NUMA_NO_NODE;
 }
-- 
2.43.0


