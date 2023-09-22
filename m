Return-Path: <netdev+bounces-35854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E102E7AB5C5
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92CDD282050
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D14177A;
	Fri, 22 Sep 2023 16:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCA41773
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:21:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71718F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695399692; x=1726935692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MVHsb1hX19s0UbaJH6I80TECq8Yl3GkfDPzwBHRL6Tw=;
  b=hA8jMW5HTNslIShaxjjYENZ/9MDCn22XxwMpObC1COS9bF0hA3VklgAt
   Lr3eg4lPv7KRRWPBQqHMUTHouZ5gvRQfEzGXOUNHHbB3mT24nQ5UnectS
   K7ne6XB+jC1B/7fB+ew6f9AnhhcY26Pg0+VAs92b/WLVs8xvdspmgl1Ed
   F1WGNvSq3Sh7BtyOYSvayaUqMq9rlYuf+0r77zYpJh5MdB9Sfo4QvrqpA
   a+ENBr4z2xB37fxiEifUFuVaYrDeLrJZeUhITdFdurT+F4p1zr9+fNOuY
   Dyh7h5eaHavGhxLcSX+mNe+YXol3T+cb4ouAuHJlsTSfru29J0h7lmKzT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="384707090"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="384707090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813116698"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="813116698"
Received: from kkazimiedevpc.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.102.224])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:16:53 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	alan.brady@intel.com,
	joshua.a.hay@intel.com,
	emil.s.tantilov@intel.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-next] idpf: set scheduling mode for completion queue
Date: Fri, 22 Sep 2023 18:16:03 +0200
Message-Id: <20230922161603.3461104-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The HW must be programmed differently for queue-based scheduling mode.
To program the completion queue context correctly, the control plane
must know the scheduling mode not only for the Tx queue, but also for
the completion queue.
Unfortunately, currently the driver sets the scheduling mode only for
the Tx queues.

Propagate the scheduling mode data for the completion queue as
well when sending the queue configuration messages.

Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 10 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6fa79898c42c..58c5412d3173 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1160,6 +1160,7 @@ static void idpf_rxq_set_descids(struct idpf_vport *vport, struct idpf_queue *q)
  */
 static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 {
+	bool flow_sch_en;
 	int err, i;
 
 	vport->txq_grps = kcalloc(vport->num_txq_grp,
@@ -1167,6 +1168,9 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 	if (!vport->txq_grps)
 		return -ENOMEM;
 
+	flow_sch_en = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+				       VIRTCHNL2_CAP_SPLITQ_QSCHED);
+
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 		struct idpf_adapter *adapter = vport->adapter;
@@ -1195,8 +1199,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 			q->txq_grp = tx_qgrp;
 			hash_init(q->sched_buf_hash);
 
-			if (!idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
-					     VIRTCHNL2_CAP_SPLITQ_QSCHED))
+			if (flow_sch_en)
 				set_bit(__IDPF_Q_FLOW_SCH_EN, q->flags);
 		}
 
@@ -1215,6 +1218,9 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 		tx_qgrp->complq->desc_count = vport->complq_desc_count;
 		tx_qgrp->complq->vport = vport;
 		tx_qgrp->complq->txq_grp = tx_qgrp;
+
+		if (flow_sch_en)
+			__set_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 9bc85b2f1709..e276b5360c2e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1473,7 +1473,7 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 	/* Populate the queue info buffer with all queue context info */
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
-		int j;
+		int j, sched_mode;
 
 		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
 			qi[k].queue_id =
@@ -1514,6 +1514,12 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 		qi[k].ring_len = cpu_to_le16(tx_qgrp->complq->desc_count);
 		qi[k].dma_ring_addr = cpu_to_le64(tx_qgrp->complq->dma);
 
+		if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags))
+			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_FLOW;
+		else
+			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_QUEUE;
+		qi[k].sched_mode = cpu_to_le16(sched_mode);
+
 		k++;
 	}
 
-- 
2.33.1


