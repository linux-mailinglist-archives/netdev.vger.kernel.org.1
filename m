Return-Path: <netdev+bounces-116089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58F9490A0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8B1C236B5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6961D47C2;
	Tue,  6 Aug 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H++nrYr4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC81D4174;
	Tue,  6 Aug 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950015; cv=none; b=pF9fnRrvSD6T6Q5wZu8lMDr1ruS/7touzB4K4PrZuxRw8FtgxB09MytLlwhRKwlk9M2CuaVRuntv/gIgkgWvbxx2/RyDPUIUppPQ6BP9q/yaop76/9hjnrrDl8lkgeCg3aq8czR12ReyNOLZ6lH7xVkIQ67GL8/bYBPBUncvpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950015; c=relaxed/simple;
	bh=In6QrPvQnSDhQJM97UyCLeQgTMymS/F0mWTXu7iL4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=petp+PDkPkBx2khpvz4UlAMUHstutij3bZ5G1fzf22O+7EWo8KSL5LBPwTgEuxf/icnxyW69T1nA12usxo8KzXPtqrHMVYhI+qrRzEQhzaXrOV6ajAkXrn5hD0mNXKfTpkf9qzgy0jFEaEKnc06sEqkZK8WfWAdMnYVIWxObYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H++nrYr4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722950013; x=1754486013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=In6QrPvQnSDhQJM97UyCLeQgTMymS/F0mWTXu7iL4fo=;
  b=H++nrYr4nnofgoOrKkNVZKdFDqAbTrbQzPpAGMNjwkQqEpEGNyISQ8A1
   TnpwkJVK257eYYW0sgrI1R4X/vo9tOryaWUyOHVlEp+QQplm6pAq7jG6z
   H0CZjcNhogMeNAzHdjtzrPvbylnyU0+DrKW0jcqSu+ItpIQp0fHSvSwxZ
   Q0JoOjwxNqhVxFLxukKudZtyHTlGWO286B/Xnr01QoyWZDoZK68RV9jUc
   I0iCHUeO5fQLR13Kz9TTPRk1U9/U5fGReH1uiXw3kW1fdLL8vbo/hKkQp
   x9KphDaqR0TjMrKpH4Vyy3ztt4XEhSbldVj4dpvgeJByaFtuDt/Hp9atg
   g==;
X-CSE-ConnectionGUID: jCnTYenFSDGIs4yPDEkZuA==
X-CSE-MsgGUID: 6ePn1RUHRxWSt9A9DlXW0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20842146"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20842146"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:13:32 -0700
X-CSE-ConnectionGUID: OleXau5/Qy+Gs3X6kJrlVA==
X-CSE-MsgGUID: Cj0QYa8jQS2rfFWTRUdL7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56475826"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 06:13:30 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 8/9] idpf: enable WB_ON_ITR
Date: Tue,  6 Aug 2024 15:12:39 +0200
Message-ID: <20240806131240.800259-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806131240.800259-1-aleksander.lobakin@intel.com>
References: <20240806131240.800259-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

Tell hardware to write back completed descriptors even when interrupts
are disabled. Otherwise, descriptors might not be written back until
the hardware can flush a full cacheline of descriptors. This can cause
unnecessary delays when traffic is light (or even trigger Tx queue
timeout).

The example scenario to reproduce the Tx timeout if the fix is not
applied:
  - configure at least 2 Tx queues to be assigned to the same q_vector,
  - generate a huge Tx traffic on the first Tx queue
  - try to send a few packets using the second Tx queue.
In such a case Tx timeout will appear on the second Tx queue because no
completion descriptors are written back for that queue while interrupts
are disabled due to NAPI polling.

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 27 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  2 ++
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  6 ++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  7 ++++-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  2 ++
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index df3574ac58c2..b4a87f8661a8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -349,9 +349,11 @@ struct idpf_vec_regs {
  * struct idpf_intr_reg
  * @dyn_ctl: Dynamic control interrupt register
  * @dyn_ctl_intena_m: Mask for dyn_ctl interrupt enable
+ * @dyn_ctl_intena_msk_m: Mask for dyn_ctl interrupt enable mask
  * @dyn_ctl_itridx_s: Register bit offset for ITR index
  * @dyn_ctl_itridx_m: Mask for ITR index
  * @dyn_ctl_intrvl_s: Register bit offset for ITR interval
+ * @dyn_ctl_wb_on_itr_m: Mask for WB on ITR feature
  * @rx_itr: RX ITR register
  * @tx_itr: TX ITR register
  * @icr_ena: Interrupt cause register offset
@@ -360,9 +362,11 @@ struct idpf_vec_regs {
 struct idpf_intr_reg {
 	void __iomem *dyn_ctl;
 	u32 dyn_ctl_intena_m;
+	u32 dyn_ctl_intena_msk_m;
 	u32 dyn_ctl_itridx_s;
 	u32 dyn_ctl_itridx_m;
 	u32 dyn_ctl_intrvl_s;
+	u32 dyn_ctl_wb_on_itr_m;
 	void __iomem *rx_itr;
 	void __iomem *tx_itr;
 	void __iomem *icr_ena;
@@ -383,6 +387,7 @@ struct idpf_intr_reg {
  * @intr_reg: See struct idpf_intr_reg
  * @napi: napi handler
  * @total_events: Number of interrupts processed
+ * @wb_on_itr: WB on ITR enabled or not
  * @tx_dim: Data for TX net_dim algorithm
  * @tx_itr_value: TX interrupt throttling rate
  * @tx_intr_mode: Dynamic ITR or not
@@ -413,6 +418,7 @@ struct idpf_q_vector {
 	__cacheline_group_begin_aligned(read_write);
 	struct napi_struct napi;
 	u16 total_events;
+	bool wb_on_itr;
 
 	struct dim tx_dim;
 	u16 tx_itr_value;
@@ -431,7 +437,7 @@ struct idpf_q_vector {
 	cpumask_var_t affinity_mask;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 104,
+libeth_cacheline_set_assert(struct idpf_q_vector, 112,
 			    424 + 2 * sizeof(struct dim),
 			    8 + sizeof(cpumask_var_t));
 
@@ -989,6 +995,25 @@ static inline void idpf_tx_splitq_build_desc(union idpf_tx_flex_desc *desc,
 		idpf_tx_splitq_build_flow_desc(desc, params, td_cmd, size);
 }
 
+/**
+ * idpf_vport_intr_set_wb_on_itr - enable descriptor writeback on disabled interrupts
+ * @q_vector: pointer to queue vector struct
+ */
+static inline void idpf_vport_intr_set_wb_on_itr(struct idpf_q_vector *q_vector)
+{
+	struct idpf_intr_reg *reg;
+
+	if (q_vector->wb_on_itr)
+		return;
+
+	q_vector->wb_on_itr = true;
+	reg = &q_vector->intr_reg;
+
+	writel(reg->dyn_ctl_wb_on_itr_m | reg->dyn_ctl_intena_msk_m |
+	       (IDPF_NO_ITR_UPDATE_IDX << reg->dyn_ctl_itridx_s),
+	       reg->dyn_ctl);
+}
+
 int idpf_vport_singleq_napi_poll(struct napi_struct *napi, int budget);
 void idpf_vport_init_num_qs(struct idpf_vport *vport,
 			    struct virtchnl2_create_vport *vport_msg);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index 3df9935685e9..6c913a703df6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -97,8 +97,10 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl = idpf_get_reg_addr(adapter,
 						  reg_vals[vec_id].dyn_ctl_reg);
 		intr->dyn_ctl_intena_m = PF_GLINT_DYN_CTL_INTENA_M;
+		intr->dyn_ctl_intena_msk_m = PF_GLINT_DYN_CTL_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = PF_GLINT_DYN_CTL_ITR_INDX_S;
 		intr->dyn_ctl_intrvl_s = PF_GLINT_DYN_CTL_INTERVAL_S;
+		intr->dyn_ctl_wb_on_itr_m = PF_GLINT_DYN_CTL_WB_ON_ITR_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_PF_ITR_IDX_SPACING);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 5ba360abbe66..dfd7cf1d9aa0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1120,8 +1120,10 @@ int idpf_vport_singleq_napi_poll(struct napi_struct *napi, int budget)
 						    &work_done);
 
 	/* If work not completed, return budget and polling will return */
-	if (!clean_complete)
+	if (!clean_complete) {
+		idpf_vport_intr_set_wb_on_itr(q_vector);
 		return budget;
+	}
 
 	work_done = min_t(int, work_done, budget - 1);
 
@@ -1130,6 +1132,8 @@ int idpf_vport_singleq_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (likely(napi_complete_done(napi, work_done)))
 		idpf_vport_intr_update_itr_ena_irq(q_vector);
+	else
+		idpf_vport_intr_set_wb_on_itr(q_vector);
 
 	return work_done;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 26ef064972d4..7af4ec83fd0a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3710,6 +3710,7 @@ void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector)
 	/* net_dim() updates ITR out-of-band using a work item */
 	idpf_net_dim(q_vector);
 
+	q_vector->wb_on_itr = false;
 	intval = idpf_vport_intr_buildreg_itr(q_vector,
 					      IDPF_NO_ITR_UPDATE_IDX, 0);
 
@@ -4012,8 +4013,10 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	clean_complete &= idpf_tx_splitq_clean_all(q_vector, budget, &work_done);
 
 	/* If work not completed, return budget and polling will return */
-	if (!clean_complete)
+	if (!clean_complete) {
+		idpf_vport_intr_set_wb_on_itr(q_vector);
 		return budget;
+	}
 
 	work_done = min_t(int, work_done, budget - 1);
 
@@ -4022,6 +4025,8 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (likely(napi_complete_done(napi, work_done)))
 		idpf_vport_intr_update_itr_ena_irq(q_vector);
+	else
+		idpf_vport_intr_set_wb_on_itr(q_vector);
 
 	/* Switch to poll mode in the tear-down path after sending disable
 	 * queues virtchnl message, as the interrupts will be disabled after
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 629cb5cb7c9f..99b8dbaf4225 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -97,7 +97,9 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl = idpf_get_reg_addr(adapter,
 						  reg_vals[vec_id].dyn_ctl_reg);
 		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
+		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
+		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.45.2


