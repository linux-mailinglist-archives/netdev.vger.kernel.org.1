Return-Path: <netdev+bounces-115124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F2945407
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758381F2488E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50EB14B09F;
	Thu,  1 Aug 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ll8unhKt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990114AD3E
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546760; cv=none; b=QDhIMQ22PDN0NhNKc4zz24gVLtE7yimrO6c40rAES/p7R0breeR2jD4dFWIbfFG3meR9WKJNPi7c5q8W+mh3SJASbWgakK08wA1LgidqFklfE/hyzxWIK77O/4RwDmFsPgDZU5yjYKn7iwLAVvrB3qiw+e9h29nBM2wGBFaGcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546760; c=relaxed/simple;
	bh=7fFHnYQ2dlI0G474qj0UNhjMnTk3sPkD0DJyw4aB+xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJQtZum9a4LCv/PnDoPncy5RBeGb7Tr2F9H6HJm8xLMzqGTngJtQ8sovXNg+sySFbiKTIT3c1kvIp27ScnKJtd5MJ4rkiY0HrhJNtkI0NoGq4dFj/Imd9jxsvk7CEQ+HGta3zslKbfBQndmmW2iGDs3s2G4y5bJeBFY8BVm79xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ll8unhKt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471Ivw9c030816
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=z0cQ9LwyTrz6t
	0/D8o7pfxdb1FSfurg4XHmODIlQdFo=; b=Ll8unhKt3LoxTfbcDxOygiDscDmo2
	YrDj5e7+NYR2ufp4MO77w2CfoE8mI00U5FGqEPN99PfJ4aU2lqVJf4P9NvcNr+b2
	p/wkVQFdwdGk07W1yE9eewWSXQiSWNiyelBwBlGcu1betzE8yQwUI4XSPqhBLeNN
	PPXj0nf1p9mfbRxcsHL9m55kEJb475klrT2JjZf736sOWJNguGtXOIaVz3kn4oDA
	kuJNryECSm+KLHGNgRwm+i8FpBwrxwfwQ3ZnyF1U4jqyMyx4KMwqfmkgylnbobOO
	aDCEs8+8dbWIukbsJk374lhy/CQH4opHCrkXvP8qKb5LwhP8iGLG5Yrlg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rebqgfe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471JelRH009211
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3bkwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LCUSu2491076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:12:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 764655804B;
	Thu,  1 Aug 2024 21:12:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 229FF58059;
	Thu,  1 Aug 2024 21:12:30 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:12:30 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 2/2] ibmveth: Recycle buffers during replenish phase
Date: Thu,  1 Aug 2024 16:12:15 -0500
Message-ID: <20240801211215.128101-3-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801211215.128101-1-nnac123@linux.ibm.com>
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dCTc7HmEeA9rRXz1fQW-zQ9oZwcMY6D4
X-Proofpoint-ORIG-GUID: dCTc7HmEeA9rRXz1fQW-zQ9oZwcMY6D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_19,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=778
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010139

When the length of a packet is under the rx_copybreak threshold, the
buffer is copied into a new skb and sent up the stack. This allows the
dma mapped memory to be recycled back to FW.

Previously, the reuse of the DMA space was handled immediately.
This means that further packet processing has to wait until
h_add_logical_lan finishes for this packet.

Therefore, when reusing a packet, offload the hcall to the replenish
function. As a result, much of the shared logic between the recycle and
replenish functions can be removed.

This change increases TCP_RR packet rate by another 15% (370k to 430k
txns). We can see the ftrace data supports this:
PREV: ibmveth_poll = 8078553.0 us / 190999.0 hits = AVG 42.3 us
NEW:  ibmveth_poll = 7632787.0 us / 224060.0 hits = AVG 34.07 us

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 144 ++++++++++++-----------------
 1 file changed, 60 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index e6eb594f0751..b619a3ec245b 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -39,7 +39,8 @@
 #include "ibmveth.h"
 
 static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance);
-static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter);
+static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
+				       bool reuse);
 static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev);
 
 static struct kobj_type ktype_veth_pool;
@@ -226,6 +227,16 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 	for (i = 0; i < count; ++i) {
 		union ibmveth_buf_desc desc;
 
+		free_index = pool->consumer_index;
+		index = pool->free_map[free_index];
+		skb = NULL;
+
+		BUG_ON(index == IBM_VETH_INVALID_MAP);
+
+		/* are we allocating a new buffer or recycling an old one */
+		if (pool->skbuff[index])
+			goto reuse;
+
 		skb = netdev_alloc_skb(adapter->netdev, pool->buff_size);
 
 		if (!skb) {
@@ -235,46 +246,46 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 			break;
 		}
 
-		free_index = pool->consumer_index;
-		pool->consumer_index++;
-		if (pool->consumer_index >= pool->size)
-			pool->consumer_index = 0;
-		index = pool->free_map[free_index];
-
-		BUG_ON(index == IBM_VETH_INVALID_MAP);
-		BUG_ON(pool->skbuff[index] != NULL);
-
 		dma_addr = dma_map_single(&adapter->vdev->dev, skb->data,
 				pool->buff_size, DMA_FROM_DEVICE);
 
 		if (dma_mapping_error(&adapter->vdev->dev, dma_addr))
 			goto failure;
 
-		pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
 		pool->dma_addr[index] = dma_addr;
 		pool->skbuff[index] = skb;
 
-		correlator = ((u64)pool->index << 32) | index;
-		*(u64 *)skb->data = correlator;
-
-		desc.fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;
-		desc.fields.address = dma_addr;
-
 		if (rx_flush) {
 			unsigned int len = min(pool->buff_size,
-						adapter->netdev->mtu +
-						IBMVETH_BUFF_OH);
+					       adapter->netdev->mtu +
+					       IBMVETH_BUFF_OH);
 			ibmveth_flush_buffer(skb->data, len);
 		}
+reuse:
+		dma_addr = pool->dma_addr[index];
+		desc.fields.flags_len = IBMVETH_BUF_VALID | pool->buff_size;
+		desc.fields.address = dma_addr;
+
+		correlator = ((u64)pool->index << 32) | index;
+		*(u64 *)pool->skbuff[index]->data = correlator;
+
 		lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address,
 						   desc.desc);
 
 		if (lpar_rc != H_SUCCESS) {
+			netdev_warn(adapter->netdev,
+				    "%sadd_logical_lan failed %lu\n",
+				    skb ? "" : "When recycling: ", lpar_rc);
 			goto failure;
-		} else {
-			buffers_added++;
-			adapter->replenish_add_buff_success++;
 		}
+
+		pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
+		pool->consumer_index++;
+		if (pool->consumer_index >= pool->size)
+			pool->consumer_index = 0;
+
+		buffers_added++;
+		adapter->replenish_add_buff_success++;
 	}
 
 	mb();
@@ -282,17 +293,13 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
 	return;
 
 failure:
-	pool->free_map[free_index] = index;
-	pool->skbuff[index] = NULL;
-	if (pool->consumer_index == 0)
-		pool->consumer_index = pool->size - 1;
-	else
-		pool->consumer_index--;
-	if (!dma_mapping_error(&adapter->vdev->dev, dma_addr))
+
+	if (dma_addr && !dma_mapping_error(&adapter->vdev->dev, dma_addr))
 		dma_unmap_single(&adapter->vdev->dev,
 		                 pool->dma_addr[index], pool->buff_size,
 		                 DMA_FROM_DEVICE);
-	dev_kfree_skb_any(skb);
+	dev_kfree_skb_any(pool->skbuff[index]);
+	pool->skbuff[index] = NULL;
 	adapter->replenish_add_buff_failure++;
 
 	mb();
@@ -365,7 +372,7 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
 
 /* remove a buffer from a pool */
 static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
-					    u64 correlator)
+					    u64 correlator, bool reuse)
 {
 	unsigned int pool  = correlator >> 32;
 	unsigned int index = correlator & 0xffffffffUL;
@@ -376,15 +383,23 @@ static void ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
 	BUG_ON(index >= adapter->rx_buff_pool[pool].size);
 
 	skb = adapter->rx_buff_pool[pool].skbuff[index];
-
 	BUG_ON(skb == NULL);
 
-	adapter->rx_buff_pool[pool].skbuff[index] = NULL;
+	/* if we are going to reuse the buffer then keep the pointers around
+	 * but mark index as available. replenish will see the skb pointer and
+	 * assume it is to be recycled.
+	 */
+	if (!reuse) {
+		/* remove the skb pointer to mark free. actual freeing is done
+		 * by upper level networking after gro_recieve
+		 */
+		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
 
-	dma_unmap_single(&adapter->vdev->dev,
-			 adapter->rx_buff_pool[pool].dma_addr[index],
-			 adapter->rx_buff_pool[pool].buff_size,
-			 DMA_FROM_DEVICE);
+		dma_unmap_single(&adapter->vdev->dev,
+				 adapter->rx_buff_pool[pool].dma_addr[index],
+				 adapter->rx_buff_pool[pool].buff_size,
+				 DMA_FROM_DEVICE);
+	}
 
 	free_index = adapter->rx_buff_pool[pool].producer_index;
 	adapter->rx_buff_pool[pool].producer_index++;
@@ -411,51 +426,13 @@ static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *ada
 	return adapter->rx_buff_pool[pool].skbuff[index];
 }
 
-/* recycle the current buffer on the rx queue */
-static int ibmveth_rxq_recycle_buffer(struct ibmveth_adapter *adapter)
+static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
+				       bool reuse)
 {
-	u32 q_index = adapter->rx_queue.index;
-	u64 correlator = adapter->rx_queue.queue_addr[q_index].correlator;
-	unsigned int pool = correlator >> 32;
-	unsigned int index = correlator & 0xffffffffUL;
-	union ibmveth_buf_desc desc;
-	unsigned long lpar_rc;
-	int ret = 1;
-
-	BUG_ON(pool >= IBMVETH_NUM_BUFF_POOLS);
-	BUG_ON(index >= adapter->rx_buff_pool[pool].size);
+	u64 cor;
 
-	if (!adapter->rx_buff_pool[pool].active) {
-		ibmveth_rxq_harvest_buffer(adapter);
-		ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[pool]);
-		goto out;
-	}
-
-	desc.fields.flags_len = IBMVETH_BUF_VALID |
-		adapter->rx_buff_pool[pool].buff_size;
-	desc.fields.address = adapter->rx_buff_pool[pool].dma_addr[index];
-
-	lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
-
-	if (lpar_rc != H_SUCCESS) {
-		netdev_dbg(adapter->netdev, "h_add_logical_lan_buffer failed "
-			   "during recycle rc=%ld", lpar_rc);
-		ibmveth_remove_buffer_from_pool(adapter, adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator);
-		ret = 0;
-	}
-
-	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
-		adapter->rx_queue.index = 0;
-		adapter->rx_queue.toggle = !adapter->rx_queue.toggle;
-	}
-
-out:
-	return ret;
-}
-
-static void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter)
-{
-	ibmveth_remove_buffer_from_pool(adapter, adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator);
+	cor = adapter->rx_queue.queue_addr[adapter->rx_queue.index].correlator;
+	ibmveth_remove_buffer_from_pool(adapter, cor, reuse);
 
 	if (++adapter->rx_queue.index == adapter->rx_queue.num_slots) {
 		adapter->rx_queue.index = 0;
@@ -1347,7 +1324,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			wmb(); /* suggested by larson1 */
 			adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
-			ibmveth_rxq_recycle_buffer(adapter);
+			ibmveth_rxq_harvest_buffer(adapter, true);
 		} else {
 			struct sk_buff *skb, *new_skb;
 			int length = ibmveth_rxq_frame_length(adapter);
@@ -1380,11 +1357,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 				if (rx_flush)
 					ibmveth_flush_buffer(skb->data,
 						length + offset);
-				if (!ibmveth_rxq_recycle_buffer(adapter))
-					kfree_skb(skb);
+				ibmveth_rxq_harvest_buffer(adapter, true);
 				skb = new_skb;
 			} else {
-				ibmveth_rxq_harvest_buffer(adapter);
+				ibmveth_rxq_harvest_buffer(adapter, false);
 				skb_reserve(skb, offset);
 			}
 
-- 
2.43.0


