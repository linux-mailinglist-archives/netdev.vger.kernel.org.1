Return-Path: <netdev+bounces-116613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B933294B1F8
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CE2825AA
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFF14D6EB;
	Wed,  7 Aug 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H4X6EQW9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD852145333
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065504; cv=none; b=O9C7c7Ne4k+bQQSCEIQJFWVP69c3JC64MKDoc5JMg1lin2qFvqJWyk6hlYIqeRP6/RmpyoPDRxYLfaFurdKbv3q43b0psgs79OF017+I+ui5zGHClpr1hC5vWZBK1SiM3vGa1RTjfWGWWcBveTKUHVUe3M+LY67lltxWk9zAEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065504; c=relaxed/simple;
	bh=2pwCcByUcVOn8KyWvgAUOOulIrsrC7YWrY2u4gEoUFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ25lqy79CmhKsMdhw8/AGLpX9TMPNpNct77TN6+Nhek9QSwqwuC5W2JaqJ3SUHZZATNtbXdY3jgKHnMIjrQ/8puCPHkXyhw7dPgFCkp64a9VXr9nCj8+97Z3s9JvtEpz06JTnZFFA5hOrvjHpWLLzUMi1cj5Fq0f7dcXCMWISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H4X6EQW9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477Gvxgt001682
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/zcWHd6Kb/HcY
	7jjLp2J3kX437pszol2MTZSYCdrBmY=; b=H4X6EQW93XJV2cPcIBpImxRui/xCX
	hZRT6zDkILxBOCZ/14UCu42bq5mzFElV5DqaPssPBdfTLQ+RfBvDDWAKVK7gkzRK
	yVAVxPGPz1vFgRbIafke/5P6QuwNKt0oLImDBHNyLqcHCLM5/+PC6BMDDbAChlgR
	gB9a7QHlVzsd1N3f7wTVVxJjRFIkwcBdgrpMCP8qTbUJXv3Ft1evbngoGnNLedC5
	rlZq9YppluKuZcLl3NO5atc8goGBL6cBV7n91V5Tl72WIfChRQWXzUr1RD0NArA+
	7yBwIYWYL9uIN9BJpktyJ6qp7Mct8iaFs35+MQDYnCu/90/gy7FKsnRQw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02bxmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477K48OX018020
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cmtyr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIDTT58851640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D3058071;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029EB5807A;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 5/7] ibmvnic: Introduce send sub-crq direct
Date: Wed,  7 Aug 2024 16:18:07 -0500
Message-ID: <20240807211809.1259563-6-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807211809.1259563-1-nnac123@linux.ibm.com>
References: <20240807211809.1259563-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Q66heEtSTm8qOAa5xzXy8M_R2LIXRKc
X-Proofpoint-GUID: 3Q66heEtSTm8qOAa5xzXy8M_R2LIXRKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=742
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070146

Firmware supports two hcalls to send a sub-crq request:
H_SEND_SUB_CRQ_INDIRECT and H_SEND_SUB_CRQ. The indirect hcall allows
for submission of batched messages while the other hcall is limited to
only one message. This protocol is defined in PAPR section 17.2.3.3.

Previously, the ibmvnic xmit function only used the indirect hcall. This
allowed the driver to batch it's skbs. A single skb can occupy a few
entries per hcall depending on if FW requires skb header information or
not. The FW only needs header information if the packet is segmented.

By this logic, if an skb is not GSO then it can fit in one sub-crq
message and therefore is a candidate for H_SEND_SUB_CRQ.
Batching skb transmission is only useful when there are more packets
coming down the line (ie netdev_xmit_more is true).

As it turns out, H_SEND_SUB_CRQ induces less latency than
H_SEND_SUB_CRQ_INDIRECT. Therefore, use H_SEND_SUB_CRQ where
appropriate.

Small latency gains seen when doing TCP_RR_150 (request/response
workload). Ftrace results (graph-time=1):
  Previous:
     ibmvnic_xmit = 29618270.83 us / 8860058.0 hits = AVG 3.34
     ibmvnic_tx_scrq_flush = 21972231.02 us / 6553972.0 hits = AVG 3.35
  Now:
     ibmvnic_xmit = 22153350.96 us / 8438942.0 hits = AVG 2.63
     ibmvnic_tx_scrq_flush = 15858922.4 us / 6244076.0 hits = AVG 2.54

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 52 ++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 256feac588ef..d7262674eab7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -117,6 +117,7 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
 static void flush_reset_queue(struct ibmvnic_adapter *adapter);
+static void print_subcrq_error(struct device *dev, int rc, const char *func);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -2334,8 +2335,29 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
 	}
 }
 
+static int send_subcrq_direct(struct ibmvnic_adapter *adapter,
+			      u64 remote_handle, u64 *entry)
+{
+	unsigned int ua = adapter->vdev->unit_address;
+	struct device *dev = &adapter->vdev->dev;
+	int rc;
+
+	/* Make sure the hypervisor sees the complete request */
+	dma_wmb();
+	rc = plpar_hcall_norets(H_SEND_SUB_CRQ, ua,
+				cpu_to_be64(remote_handle),
+				cpu_to_be64(entry[0]), cpu_to_be64(entry[1]),
+				cpu_to_be64(entry[2]), cpu_to_be64(entry[3]));
+
+	if (rc)
+		print_subcrq_error(dev, rc, __func__);
+
+	return rc;
+}
+
 static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
-				 struct ibmvnic_sub_crq_queue *tx_scrq)
+				 struct ibmvnic_sub_crq_queue *tx_scrq,
+				 bool indirect)
 {
 	struct ibmvnic_ind_xmit_queue *ind_bufp;
 	u64 dma_addr;
@@ -2350,7 +2372,13 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
 
 	if (!entries)
 		return 0;
-	rc = send_subcrq_indirect(adapter, handle, dma_addr, entries);
+
+	if (indirect)
+		rc = send_subcrq_indirect(adapter, handle, dma_addr, entries);
+	else
+		rc = send_subcrq_direct(adapter, handle,
+					(u64 *)ind_bufp->indir_arr);
+
 	if (rc)
 		ibmvnic_tx_scrq_clean_buffer(adapter, tx_scrq);
 	else
@@ -2408,7 +2436,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 		goto out;
@@ -2426,7 +2454,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_send_failed++;
 		tx_dropped++;
 		ret = NETDEV_TX_OK;
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 		goto out;
@@ -2521,6 +2549,16 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_crq.v1.flags1 |= IBMVNIC_TX_LSO;
 		tx_crq.v1.mss = cpu_to_be16(skb_shinfo(skb)->gso_size);
 		hdrs += 2;
+	} else if (!ind_bufp->index && !netdev_xmit_more()) {
+		ind_bufp->indir_arr[0] = tx_crq;
+		ind_bufp->index = 1;
+		tx_buff->num_entries = 1;
+		netdev_tx_sent_queue(txq, skb->len);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, false);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
+
+		goto early_exit;
 	}
 
 	if ((*hdrs >> 7) & 1)
@@ -2530,7 +2568,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->num_entries = num_entries;
 	/* flush buffer if current entry can not fit */
 	if (num_entries + ind_bufp->index > IBMVNIC_MAX_IND_DESCS) {
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_flush_err;
 	}
@@ -2538,15 +2576,17 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	indir_arr[0] = tx_crq;
 	memcpy(&ind_bufp->indir_arr[ind_bufp->index], &indir_arr[0],
 	       num_entries * sizeof(struct ibmvnic_generic_scrq));
+
 	ind_bufp->index += num_entries;
 	if (__netdev_tx_sent_queue(txq, skb->len,
 				   netdev_xmit_more() &&
 				   ind_bufp->index < IBMVNIC_MAX_IND_DESCS)) {
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 	}
 
+early_exit:
 	if (atomic_add_return(num_entries, &tx_scrq->used)
 					>= adapter->req_tx_entries_per_subcrq) {
 		netdev_dbg(netdev, "Stopping queue %d\n", queue_num);
-- 
2.43.0


