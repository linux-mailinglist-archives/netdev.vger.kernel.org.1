Return-Path: <netdev+bounces-98824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908D8D290A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595E8B25452
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF20143867;
	Tue, 28 May 2024 23:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE02.vmware.com (ex-prd-edge02.vmware.com [208.91.3.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786613F454;
	Tue, 28 May 2024 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940490; cv=none; b=hOVzTccIIlQ0v9XAmKZC71mF4fe1chCiw7sSuVLmkWonP4uPwqI6YCInvOrqUxFUXRCcev6FjnDlsLwh4LDh1des2wH1xBt0u/RbN93Brt67fBbupQPt6tUF9WLWpgmg5cKMF9yZvzxQhnJefFj/PxqQVp+gsr4OQjmcrhvewIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940490; c=relaxed/simple;
	bh=ZUcx+8QCazw9xjc75s/IhNpveDS+T7BNPRdLe2JOdsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAsPkDb7lDtt+vEvplitl0a11rTqDPqZnMmWnDv0zHrnaYiPK6stxc/iy1UEMkoIZQjp/WDBPCv2m5TtY5etlUltJkGWQynccmOt9VH51q01rzR4Bo42MxlSS93HYN3bdO58C3Q1zXdAx7pbKotTaVK7B4JGhgZx6G9AlJubr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost1.vmware.com (10.113.161.71) by
 EX-PRD-EDGE02.vmware.com (10.188.245.7) with Microsoft SMTP Server id
 15.1.2375.34; Tue, 28 May 2024 16:39:00 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost1.vmware.com (Postfix) with ESMTP id A8623201E4;
	Tue, 28 May 2024 16:39:19 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id A4419B04C9; Tue, 28 May 2024 16:39:19 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net-next 2/4] vmxnet3: add latency measurement support in vmxnet3
Date: Tue, 28 May 2024 16:39:04 -0700
Message-ID: <20240528233907.2674-3-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240528233907.2674-1-ronak.doshi@broadcom.com>
References: <20240528233907.2674-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE02.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.71 as permitted
 sender)

This patch enhances vmxnet3 to support latency measurement.
This support will help to track the latency in packet processing
between guest virtual nic driver and host. For this purpose, we
introduce a new timestamp ring in vmxnet3 which will be per Tx/Rx
queue. This ring will be used to carry timestamp of the packets
which will be used to calculate the latency.

Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_defs.h |  55 ++++++++++++-
 drivers/net/vmxnet3/vmxnet3_drv.c  | 155 ++++++++++++++++++++++++++++++++++++-
 drivers/net/vmxnet3/vmxnet3_int.h  |  20 +++++
 3 files changed, 225 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_defs.h b/drivers/net/vmxnet3/vmxnet3_defs.h
index 67387bb7aa24..dcf1cf8e7a86 100644
--- a/drivers/net/vmxnet3/vmxnet3_defs.h
+++ b/drivers/net/vmxnet3/vmxnet3_defs.h
@@ -80,6 +80,8 @@ enum {
 #define VMXNET3_IO_TYPE(addr)           ((addr) >> 24)
 #define VMXNET3_IO_REG(addr)            ((addr) & 0xFFFFFF)
 
+#define VMXNET3_PMC_PSEUDO_TSC  0x10003
+
 enum {
 	VMXNET3_CMD_FIRST_SET = 0xCAFE0000,
 	VMXNET3_CMD_ACTIVATE_DEV = VMXNET3_CMD_FIRST_SET,
@@ -123,6 +125,7 @@ enum {
 	VMXNET3_CMD_GET_RESERVED4,
 	VMXNET3_CMD_GET_MAX_CAPABILITIES,
 	VMXNET3_CMD_GET_DCR0_REG,
+	VMXNET3_CMD_GET_TSRING_DESC_SIZE,
 };
 
 /*
@@ -254,6 +257,24 @@ struct Vmxnet3_RxDesc {
 
 #define VMXNET3_RCD_HDR_INNER_SHIFT  13
 
+struct Vmxnet3TSInfo {
+	u64  tsData:56;
+	u64  tsType:4;
+	u64  tsi:1;      //bit to indicate to set ts
+	u64  pad:3;
+	u64  pad2;
+};
+
+struct Vmxnet3_TxTSDesc {
+	struct Vmxnet3TSInfo ts;
+	u64    pad[14];
+};
+
+struct Vmxnet3_RxTSDesc {
+	struct Vmxnet3TSInfo ts;
+	u64    pad[14];
+};
+
 struct Vmxnet3_RxCompDesc {
 #ifdef __BIG_ENDIAN_BITFIELD
 	u32		ext2:1;
@@ -427,6 +448,13 @@ union Vmxnet3_GenericDesc {
 #define VMXNET3_RXDATA_DESC_SIZE_ALIGN 64
 #define VMXNET3_RXDATA_DESC_SIZE_MASK  (VMXNET3_RXDATA_DESC_SIZE_ALIGN - 1)
 
+/* Rx TS Ring buffer size must be a multiple of 64 bytes */
+#define VMXNET3_RXTS_DESC_SIZE_ALIGN 64
+#define VMXNET3_RXTS_DESC_SIZE_MASK  (VMXNET3_RXTS_DESC_SIZE_ALIGN - 1)
+/* Tx TS Ring buffer size must be a multiple of 64 bytes */
+#define VMXNET3_TXTS_DESC_SIZE_ALIGN 64
+#define VMXNET3_TXTS_DESC_SIZE_MASK  (VMXNET3_TXTS_DESC_SIZE_ALIGN - 1)
+
 /* Max ring size */
 #define VMXNET3_TX_RING_MAX_SIZE   4096
 #define VMXNET3_TC_RING_MAX_SIZE   4096
@@ -439,6 +467,9 @@ union Vmxnet3_GenericDesc {
 
 #define VMXNET3_RXDATA_DESC_MAX_SIZE 2048
 
+#define VMXNET3_TXTS_DESC_MAX_SIZE   256
+#define VMXNET3_RXTS_DESC_MAX_SIZE   256
+
 /* a list of reasons for queue stop */
 
 enum {
@@ -546,6 +577,24 @@ struct Vmxnet3_RxQueueConf {
 };
 
 
+struct Vmxnet3_LatencyConf {
+	u16 sampleRate;
+	u16 pad;
+};
+
+struct Vmxnet3_TxQueueTSConf {
+	__le64  txTSRingBasePA;
+	__le16  txTSRingDescSize; /* size of tx timestamp ring buffer */
+	u16     pad;
+	struct Vmxnet3_LatencyConf latencyConf;
+};
+
+struct Vmxnet3_RxQueueTSConf {
+	__le64  rxTSRingBasePA;
+	__le16  rxTSRingDescSize; /* size of rx timestamp ring buffer */
+	u16     pad[3];
+};
+
 enum vmxnet3_intr_mask_mode {
 	VMXNET3_IMM_AUTO   = 0,
 	VMXNET3_IMM_ACTIVE = 1,
@@ -679,7 +728,8 @@ struct Vmxnet3_TxQueueDesc {
 	/* Driver read after a GET command */
 	struct Vmxnet3_QueueStatus		status;
 	struct UPT1_TxStats			stats;
-	u8					_pad[88]; /* 128 aligned */
+	struct Vmxnet3_TxQueueTSConf            tsConf;
+	u8					_pad[72]; /* 128 aligned */
 };
 
 
@@ -689,7 +739,8 @@ struct Vmxnet3_RxQueueDesc {
 	/* Driver read after a GET commad */
 	struct Vmxnet3_QueueStatus		status;
 	struct UPT1_RxStats			stats;
-	u8				      __pad[88]; /* 128 aligned */
+	struct Vmxnet3_RxQueueTSConf            tsConf;
+	u8				      __pad[72]; /* 128 aligned */
 };
 
 struct Vmxnet3_SetPolling {
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index b3f3136cc8be..528bd269c721 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -143,6 +143,32 @@ vmxnet3_tq_stop(struct vmxnet3_tx_queue *tq, struct vmxnet3_adapter *adapter)
 	netif_stop_subqueue(adapter->netdev, (tq - adapter->tx_queue));
 }
 
+static u64
+vmxnet3_get_cycles(int pmc)
+{
+#ifdef CONFIG_X86
+	return native_read_pmc(pmc);
+#else
+	return 0;
+#endif
+}
+
+static bool
+vmxnet3_apply_timestamp(struct vmxnet3_tx_queue *tq, u16 rate)
+{
+#ifdef CONFIG_X86
+	if (rate > 0) {
+		if (tq->tsPktCount == 1) {
+			if (rate != 1)
+				tq->tsPktCount = rate;
+			return true;
+		}
+		tq->tsPktCount--;
+	}
+#endif
+	return false;
+}
+
 /* Check if capability is supported by UPT device or
  * UPT is even requested
  */
@@ -498,6 +524,12 @@ vmxnet3_tq_destroy(struct vmxnet3_tx_queue *tq,
 				  tq->data_ring.base, tq->data_ring.basePA);
 		tq->data_ring.base = NULL;
 	}
+	if (tq->ts_ring.base) {
+		dma_free_coherent(&adapter->pdev->dev,
+				  tq->tx_ring.size * tq->tx_ts_desc_size,
+				  tq->ts_ring.base, tq->ts_ring.basePA);
+		tq->ts_ring.base = NULL;
+	}
 	if (tq->comp_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev, tq->comp_ring.size *
 				  sizeof(struct Vmxnet3_TxCompDesc),
@@ -535,6 +567,11 @@ vmxnet3_tq_init(struct vmxnet3_tx_queue *tq,
 	memset(tq->data_ring.base, 0,
 	       tq->data_ring.size * tq->txdata_desc_size);
 
+	if (tq->ts_ring.base) {
+		memset(tq->ts_ring.base, 0,
+		       tq->tx_ring.size * tq->tx_ts_desc_size);
+	}
+
 	/* reset the tx comp ring contents to 0 and reset comp ring states */
 	memset(tq->comp_ring.base, 0, tq->comp_ring.size *
 	       sizeof(struct Vmxnet3_TxCompDesc));
@@ -573,6 +610,18 @@ vmxnet3_tq_create(struct vmxnet3_tx_queue *tq,
 		goto err;
 	}
 
+	if (tq->tx_ts_desc_size != 0) {
+		tq->ts_ring.base = dma_alloc_coherent(&adapter->pdev->dev,
+						      tq->tx_ring.size * tq->tx_ts_desc_size,
+						      &tq->ts_ring.basePA, GFP_KERNEL);
+		if (!tq->ts_ring.base) {
+			netdev_err(adapter->netdev, "failed to allocate tx ts ring\n");
+			tq->tx_ts_desc_size = 0;
+		}
+	} else {
+		tq->ts_ring.base = NULL;
+	}
+
 	tq->comp_ring.base = dma_alloc_coherent(&adapter->pdev->dev,
 			tq->comp_ring.size * sizeof(struct Vmxnet3_TxCompDesc),
 			&tq->comp_ring.basePA, GFP_KERNEL);
@@ -861,6 +910,11 @@ vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_ctx *ctx,
 	/* set the last buf_info for the pkt */
 	tbi->skb = skb;
 	tbi->sop_idx = ctx->sop_txd - tq->tx_ring.base;
+	if (tq->tx_ts_desc_size != 0) {
+		ctx->ts_txd = (struct Vmxnet3_TxTSDesc *)((u8 *)tq->ts_ring.base +
+							  tbi->sop_idx * tq->tx_ts_desc_size);
+		ctx->ts_txd->ts.tsi = 0;
+	}
 
 	return 0;
 }
@@ -968,7 +1022,7 @@ vmxnet3_parse_hdr(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 					       skb_headlen(skb));
 		}
 
-		if (skb->len <= VMXNET3_HDR_COPY_SIZE)
+		if (skb->len <= tq->txdata_desc_size)
 			ctx->copy_size = skb->len;
 
 		/* make sure headers are accessible directly */
@@ -1259,6 +1313,14 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_tx_queue *tq,
 		gdesc->txd.tci = skb_vlan_tag_get(skb);
 	}
 
+	if (tq->tx_ts_desc_size != 0 &&
+	    adapter->latencyConf->sampleRate != 0) {
+		if (vmxnet3_apply_timestamp(tq, adapter->latencyConf->sampleRate)) {
+			ctx.ts_txd->ts.tsData = vmxnet3_get_cycles(VMXNET3_PMC_PSEUDO_TSC);
+			ctx.ts_txd->ts.tsi = 1;
+		}
+	}
+
 	/* Ensure that the write to (&gdesc->txd)->gen will be observed after
 	 * all other writes to &gdesc->txd.
 	 */
@@ -1608,6 +1670,15 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			skip_page_frags = false;
 			ctx->skb = rbi->skb;
 
+			if (rq->rx_ts_desc_size != 0 && rcd->ext2) {
+				struct Vmxnet3_RxTSDesc *ts_rxd;
+
+				ts_rxd = (struct Vmxnet3_RxTSDesc *)((u8 *)rq->ts_ring.base +
+								     idx * rq->rx_ts_desc_size);
+				ts_rxd->ts.tsData = vmxnet3_get_cycles(VMXNET3_PMC_PSEUDO_TSC);
+				ts_rxd->ts.tsi = 1;
+			}
+
 			rxDataRingUsed =
 				VMXNET3_RX_DATA_RING(adapter, rcd->rqID);
 			len = rxDataRingUsed ? rcd->len : rbi->len;
@@ -2007,6 +2078,13 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		rq->data_ring.base = NULL;
 	}
 
+	if (rq->ts_ring.base) {
+		dma_free_coherent(&adapter->pdev->dev,
+				  rq->rx_ring[0].size * rq->rx_ts_desc_size,
+				  rq->ts_ring.base, rq->ts_ring.basePA);
+		rq->ts_ring.base = NULL;
+	}
+
 	if (rq->comp_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev, rq->comp_ring.size
 				  * sizeof(struct Vmxnet3_RxCompDesc),
@@ -2090,6 +2168,11 @@ vmxnet3_rq_init(struct vmxnet3_rx_queue *rq,
 	}
 	vmxnet3_rq_alloc_rx_buf(rq, 1, rq->rx_ring[1].size - 1, adapter);
 
+	if (rq->ts_ring.base) {
+		memset(rq->ts_ring.base, 0,
+		       rq->rx_ring[0].size * rq->rx_ts_desc_size);
+	}
+
 	/* reset the comp ring */
 	rq->comp_ring.next2proc = 0;
 	memset(rq->comp_ring.base, 0, rq->comp_ring.size *
@@ -2160,6 +2243,21 @@ vmxnet3_rq_create(struct vmxnet3_rx_queue *rq, struct vmxnet3_adapter *adapter)
 		rq->data_ring.desc_size = 0;
 	}
 
+	if (rq->rx_ts_desc_size != 0) {
+		sz = rq->rx_ring[0].size * rq->rx_ts_desc_size;
+		rq->ts_ring.base =
+			dma_alloc_coherent(&adapter->pdev->dev, sz,
+					   &rq->ts_ring.basePA,
+					   GFP_KERNEL);
+		if (!rq->ts_ring.base) {
+			netdev_err(adapter->netdev,
+				   "rx ts ring will be disabled\n");
+			rq->rx_ts_desc_size = 0;
+		}
+	} else {
+		rq->ts_ring.base = NULL;
+	}
+
 	sz = rq->comp_ring.size * sizeof(struct Vmxnet3_RxCompDesc);
 	rq->comp_ring.base = dma_alloc_coherent(&adapter->pdev->dev, sz,
 						&rq->comp_ring.basePA,
@@ -2759,6 +2857,8 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 	struct Vmxnet3_DSDevReadExt *devReadExt = &shared->devReadExt;
 	struct Vmxnet3_TxQueueConf *tqc;
 	struct Vmxnet3_RxQueueConf *rqc;
+	struct Vmxnet3_TxQueueTSConf *tqtsc;
+	struct Vmxnet3_RxQueueTSConf *rqtsc;
 	int i;
 
 	memset(shared, 0, sizeof(*shared));
@@ -2815,6 +2915,11 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 		tqc->compRingSize   = cpu_to_le32(tq->comp_ring.size);
 		tqc->ddLen          = cpu_to_le32(0);
 		tqc->intrIdx        = tq->comp_ring.intr_idx;
+		if (VMXNET3_VERSION_GE_9(adapter)) {
+			tqtsc = &adapter->tqd_start[i].tsConf;
+			tqtsc->txTSRingBasePA = cpu_to_le64(tq->ts_ring.basePA);
+			tqtsc->txTSRingDescSize = cpu_to_le16(tq->tx_ts_desc_size);
+		}
 	}
 
 	/* rx queue settings */
@@ -2837,6 +2942,11 @@ vmxnet3_setup_driver_shared(struct vmxnet3_adapter *adapter)
 			rqc->rxDataRingDescSize =
 				cpu_to_le16(rq->data_ring.desc_size);
 		}
+		if (VMXNET3_VERSION_GE_9(adapter)) {
+			rqtsc = &adapter->rqd_start[i].tsConf;
+			rqtsc->rxTSRingBasePA = cpu_to_le64(rq->ts_ring.basePA);
+			rqtsc->rxTSRingDescSize = cpu_to_le16(rq->rx_ts_desc_size);
+		}
 	}
 
 #ifdef VMXNET3_RSS
@@ -3299,6 +3409,8 @@ vmxnet3_create_queues(struct vmxnet3_adapter *adapter, u32 tx_ring_size,
 		tq->stopped = true;
 		tq->adapter = adapter;
 		tq->qid = i;
+		tq->tx_ts_desc_size = adapter->tx_ts_desc_size;
+		tq->tsPktCount = 1;
 		err = vmxnet3_tq_create(tq, adapter);
 		/*
 		 * Too late to change num_tx_queues. We cannot do away with
@@ -3320,6 +3432,7 @@ vmxnet3_create_queues(struct vmxnet3_adapter *adapter, u32 tx_ring_size,
 		rq->shared = &adapter->rqd_start[i].ctrl;
 		rq->adapter = adapter;
 		rq->data_ring.desc_size = rxdata_desc_size;
+		rq->rx_ts_desc_size = adapter->rx_ts_desc_size;
 		err = vmxnet3_rq_create(rq, adapter);
 		if (err) {
 			if (i == 0) {
@@ -3361,14 +3474,15 @@ vmxnet3_open(struct net_device *netdev)
 	if (VMXNET3_VERSION_GE_3(adapter)) {
 		unsigned long flags;
 		u16 txdata_desc_size;
+		u32 ret;
 
 		spin_lock_irqsave(&adapter->cmd_lock, flags);
 		VMXNET3_WRITE_BAR1_REG(adapter, VMXNET3_REG_CMD,
 				       VMXNET3_CMD_GET_TXDATA_DESC_SIZE);
-		txdata_desc_size = VMXNET3_READ_BAR1_REG(adapter,
-							 VMXNET3_REG_CMD);
+		ret = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_CMD);
 		spin_unlock_irqrestore(&adapter->cmd_lock, flags);
 
+		txdata_desc_size = ret & 0xffff;
 		if ((txdata_desc_size < VMXNET3_TXDATA_DESC_MIN_SIZE) ||
 		    (txdata_desc_size > VMXNET3_TXDATA_DESC_MAX_SIZE) ||
 		    (txdata_desc_size & VMXNET3_TXDATA_DESC_SIZE_MASK)) {
@@ -3377,10 +3491,42 @@ vmxnet3_open(struct net_device *netdev)
 		} else {
 			adapter->txdata_desc_size = txdata_desc_size;
 		}
+		if (VMXNET3_VERSION_GE_9(adapter))
+			adapter->rxdata_desc_size = (ret >> 16) & 0xffff;
 	} else {
 		adapter->txdata_desc_size = sizeof(struct Vmxnet3_TxDataDesc);
 	}
 
+	if (VMXNET3_VERSION_GE_9(adapter)) {
+		unsigned long flags;
+		u16 tx_ts_desc_size = 0;
+		u16 rx_ts_desc_size = 0;
+		u32 ret;
+
+		spin_lock_irqsave(&adapter->cmd_lock, flags);
+		VMXNET3_WRITE_BAR1_REG(adapter, VMXNET3_REG_CMD,
+				       VMXNET3_CMD_GET_TSRING_DESC_SIZE);
+		ret = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_CMD);
+		spin_unlock_irqrestore(&adapter->cmd_lock, flags);
+		if (ret > 0) {
+			tx_ts_desc_size = (ret & 0xff);
+			rx_ts_desc_size = ((ret >> 16) & 0xff);
+		}
+		if (tx_ts_desc_size > VMXNET3_TXTS_DESC_MAX_SIZE ||
+		    tx_ts_desc_size & VMXNET3_TXTS_DESC_SIZE_MASK) {
+			tx_ts_desc_size = 0;
+		}
+		if (rx_ts_desc_size > VMXNET3_RXTS_DESC_MAX_SIZE ||
+		    rx_ts_desc_size & VMXNET3_RXTS_DESC_SIZE_MASK) {
+			rx_ts_desc_size = 0;
+		}
+		adapter->tx_ts_desc_size = tx_ts_desc_size;
+		adapter->rx_ts_desc_size = rx_ts_desc_size;
+	} else {
+		adapter->tx_ts_desc_size = 0;
+		adapter->rx_ts_desc_size = 0;
+	}
+
 	err = vmxnet3_create_queues(adapter,
 				    adapter->tx_ring_size,
 				    adapter->rx_ring_size,
@@ -3992,6 +4138,9 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 	adapter->rqd_start = (struct Vmxnet3_RxQueueDesc *)(adapter->tqd_start +
 							    adapter->num_tx_queues);
+	if (VMXNET3_VERSION_GE_9(adapter)) {
+		adapter->latencyConf = &adapter->tqd_start->tsConf.latencyConf;
+	}
 
 	adapter->pm_conf = dma_alloc_coherent(&adapter->pdev->dev,
 					      sizeof(struct Vmxnet3_PMConf),
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 2926dfe8514f..68358e71526c 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -193,6 +193,11 @@ struct vmxnet3_tx_data_ring {
 	dma_addr_t          basePA;
 };
 
+struct vmxnet3_tx_ts_ring {
+	struct Vmxnet3_TxTSDesc *base;
+	dma_addr_t          basePA;
+};
+
 #define VMXNET3_MAP_NONE	0
 #define VMXNET3_MAP_SINGLE	BIT(0)
 #define VMXNET3_MAP_PAGE	BIT(1)
@@ -245,6 +250,7 @@ struct vmxnet3_tx_ctx {
 	u32 copy_size;       /* # of bytes copied into the data ring */
 	union Vmxnet3_GenericDesc *sop_txd;
 	union Vmxnet3_GenericDesc *eop_txd;
+	struct Vmxnet3_TxTSDesc *ts_txd;
 };
 
 struct vmxnet3_tx_queue {
@@ -254,6 +260,7 @@ struct vmxnet3_tx_queue {
 	struct vmxnet3_cmd_ring         tx_ring;
 	struct vmxnet3_tx_buf_info      *buf_info;
 	struct vmxnet3_tx_data_ring     data_ring;
+	struct vmxnet3_tx_ts_ring       ts_ring;
 	struct vmxnet3_comp_ring        comp_ring;
 	struct Vmxnet3_TxQueueCtrl      *shared;
 	struct vmxnet3_tq_driver_stats  stats;
@@ -262,6 +269,8 @@ struct vmxnet3_tx_queue {
 						    * stopped */
 	int				qid;
 	u16				txdata_desc_size;
+	u16                             tx_ts_desc_size;
+	u16                             tsPktCount;
 } ____cacheline_aligned;
 
 enum vmxnet3_rx_buf_type {
@@ -309,6 +318,11 @@ struct vmxnet3_rx_data_ring {
 	u16 desc_size;
 };
 
+struct vmxnet3_rx_ts_ring {
+	struct Vmxnet3_RxTSDesc *base;
+	dma_addr_t basePA;
+};
+
 struct vmxnet3_rx_queue {
 	char			name[IFNAMSIZ + 8]; /* To identify interrupt */
 	struct vmxnet3_adapter	  *adapter;
@@ -316,6 +330,7 @@ struct vmxnet3_rx_queue {
 	struct vmxnet3_cmd_ring   rx_ring[2];
 	struct vmxnet3_rx_data_ring data_ring;
 	struct vmxnet3_comp_ring  comp_ring;
+	struct vmxnet3_rx_ts_ring ts_ring;
 	struct vmxnet3_rx_ctx     rx_ctx;
 	u32 qid;            /* rqID in RCD for buffer from 1st ring */
 	u32 qid2;           /* rqID in RCD for buffer from 2nd ring */
@@ -325,6 +340,7 @@ struct vmxnet3_rx_queue {
 	struct vmxnet3_rq_driver_stats  stats;
 	struct page_pool *page_pool;
 	struct xdp_rxq_info xdp_rxq;
+	u16                             rx_ts_desc_size;
 } ____cacheline_aligned;
 
 #define VMXNET3_DEVICE_MAX_TX_QUEUES 32
@@ -434,6 +450,10 @@ struct vmxnet3_adapter {
 	u16    rx_prod_offset;
 	u16    rx_prod2_offset;
 	struct bpf_prog __rcu *xdp_bpf_prog;
+	struct Vmxnet3_LatencyConf *latencyConf;
+	/* Size of buffer in the ts ring */
+	u16     tx_ts_desc_size;
+	u16     rx_ts_desc_size;
 };
 
 #define VMXNET3_WRITE_BAR0_REG(adapter, reg, val)  \
-- 
2.11.0


