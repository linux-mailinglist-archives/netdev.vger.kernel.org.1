Return-Path: <netdev+bounces-43082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD627D1542
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9581C20F21
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF38208D8;
	Fri, 20 Oct 2023 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuXvtVNk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB199208AD
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:56:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB8D5B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697824570; x=1729360570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vSfJb6BNiMqaSJhFJEjMTo0eeQ2SvRO0eWxcOtb71jM=;
  b=RuXvtVNkrhX215iQUtunJQOpH6Zm+jF1egwC7xY5077jB8C0SDP8epLw
   ceqGZjCB+joMyZdekZ2uC3rAY6zN6Mjp/fbKk9F0jggKh71l4Uici5nxp
   5y8RcGq46D2Iaao1pPkr8T4DKVYIDlnON3T9Rp6HJ9xfAiLjFWbq4aDa5
   mALhco0niIt8qFfcEGDKyVtUEos7qRVO3blHol1qCelqtxk0VO7gzDk5C
   GocT/c09aVH2gaZZ34Vu3xdQ/OWxrBk0ptX7P4T/3jA/S66jYvgsWp7sX
   e1bmINfMveqNP3stAviCqMQZxpupLWzCV9QsLyS0BdBnVBpx/SHE5uBwO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386357494"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="386357494"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="750997537"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="750997537"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:56:07 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH next 1/2] idpf: set scheduling mode for completion queue
Date: Fri, 20 Oct 2023 10:55:59 -0700
Message-ID: <20231020175600.24412-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020175600.24412-1-jacob.e.keller@intel.com>
References: <20231020175600.24412-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

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
Reviewed-by: Alan Brady <alan.brady@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.41.0


