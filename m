Return-Path: <netdev+bounces-203470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DDDAF5FC7
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4894E0573
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C921301127;
	Wed,  2 Jul 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pO2Vm+2w"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214130114F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476704; cv=none; b=bA7EAZg6llU6xcaLFbNfUtqUfLvmtVvW3jDCUancGLeL88CdsOaipLNu/60mE2d0U6+lJypPwjz0d2evvfrSog7JxqUVFKYiL2AM7LgGQZ9Dj/j/Iifd2FvHMyxZ78Y35T32SdxAqZGp7t4cmY6PfG7QcEda58NeNbegpBEaito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476704; c=relaxed/simple;
	bh=X1zs64FCQPKyqezWxdOih4UeMHvNNXn7qqcmrXHzRaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KD7qynR9YmPVWINU5vwi6Gf2cZRpMl/medr78hlGgoSCmcc8HXIJqiGsMmBXOGbTA3/6kpAXi4XLm4KVzu6iUCHqqm+rlzoCZIF1gmVrAfjGj2cYReMT0HXozw+E0oAI9jkeMPeRnvdVvbh0uYtuVVT7iGyHBPOH+6sr3ip3Bh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pO2Vm+2w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Bug1T011357
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z0unnCGceLXYTSeiQ
	G6beUR4JMAWHjku935e23W/R10=; b=pO2Vm+2wyFcy09O1+Ql9jzB+cUxvPW1so
	YpDlO0NM7ASCughFesucXOMUY4Fas3CEOcMAzlOMqzkEz4XNCRG1Aae7J7bzijea
	l6hLqLytFy4l1GOJQiovYz3jGEMUp/RNA4p+q4F3IVTfukZ6By9U+ukdGEZI44yo
	mO3k5L6CPwKCkjEsd9fP1hJ25l5ZRA1KftdM71+zwZJgLL57NwaDYIsYYf+WAmfB
	lEjpZKZG8IY1s0wQA50diCXAlEDyYLUIj8BGba++RUs73To+ST52+wmkvXk7KBwd
	8yY/2I47XDI+uJ9nDARhsg9RLWIaBr570CtsNsgYzesL+zOckgiqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrq3qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562F1DHR006841
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmgfdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562HIJO627853064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 17:18:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 449F758054;
	Wed,  2 Jul 2025 17:18:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86B965805A;
	Wed,  2 Jul 2025 17:18:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.2])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 17:18:18 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH v2 net-next 4/4] ibmvnic: Make max subcrq indirect entries tunable via module param
Date: Wed,  2 Jul 2025 10:18:04 -0700
Message-Id: <20250702171804.86422-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250702171804.86422-1-mmc@linux.ibm.com>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=686569dd cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=GHk7DJwBXH6O-4IKGQoA:9
X-Proofpoint-GUID: UBYDF2RgMvUCl4KNSmwziAPXIUla3YLE
X-Proofpoint-ORIG-GUID: UBYDF2RgMvUCl4KNSmwziAPXIUla3YLE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfXzxO2Q7tUw4np J1x9cwtOJZZH9uaSiH/7puDZ2UqIP9Q2x/APVUU+7iw/p/wShkzKXfqkCgzHbE/B/dQu1NGxWy+ Hijd9FV2XkF6EzHYasEFWu25jXJ8OcWDmFyY0Xj1HpOOYus8GQ6JfEG4ZUcAFZ+wd4FOTHSJpbU
 sFr8ky5K0GRYcs6ifIyjW/4AWLkGnZ9AsUxnS8Q9is7X3EfHSHbniNRgBz5uNSlR3BZxvRkAR97 jKDkhUSq37CvG70cPD4IyT74rJ8iI29RUjpOv0rB3FC5scZurk9upQ8PcQTQOGGHfIrk43Q71Po 8w5hCuVG6mIzC0f4oVPoPHpvyG2kBEXf79i14TfU1uLHVvKBsn/g9QyHswIqFSC+J1fRSzPW4Mt
 jITtfkN7bVRMkV9/BYxes5z96zMMjicQ5a3iBq8SNJLERyVgIgdiB+xDKDAfbq8N9k8Ouwd+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020142

This patch increases the default number of subcrq indirect entries from 16
to 128, a value supported on POWER9 and later systems. Increasing this limit
improves batching efficiency in hypervisor communication, enhancing throughput
under high-load conditions.

To maintain compatibility with older or constrained systems (e.g., some POWER8 platforms),
 a module parameter max_subcrq_indirect is introduced as a transitional mechanism.
This allows administrators to manually reduce the limit if needed.

The module parameter is not intended for dynamic runtime tuning, but rather
provides forward compatibility without requiring broader structural changes at this time.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
Reviewed by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed by: Brian King <bjking1@linux.ibm.com>
Reviewed by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 29 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmvnic.h |  7 +++++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 9406ea06d9..33cdcae6a7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -154,6 +154,11 @@ static const struct ibmvnic_stat ibmvnic_stats[] = {
 	{"internal_mac_rx_errors", IBMVNIC_STAT_OFF(internal_mac_rx_errors)},
 };
 
+/* Module parameter for max_ind_descs */
+static unsigned int max_ind_descs = IBMVNIC_MAX_IND_DESCS_DEFAULT;
+module_param(max_ind_descs, uint, 0444);
+MODULE_PARM_DESC(max_ind_descs, "Max indirect subcrq descriptors (16 to 128, default 128)");
+
 static int send_crq_init_complete(struct ibmvnic_adapter *adapter)
 {
 	union ibmvnic_crq crq;
@@ -844,7 +849,7 @@ static void replenish_rx_pool(struct ibmvnic_adapter *adapter,
 		sub_crq->rx_add.len = cpu_to_be32(pool->buff_size << shift);
 
 		/* if send_subcrq_indirect queue is full, flush to VIOS */
-		if (ind_bufp->index == IBMVNIC_MAX_IND_DESCS ||
+		if (ind_bufp->index == max_ind_descs ||
 		    i == count - 1) {
 			lpar_rc =
 				send_subcrq_indirect(adapter, handle,
@@ -2599,7 +2604,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_crq.v1.n_crq_elem = num_entries;
 	tx_buff->num_entries = num_entries;
 	/* flush buffer if current entry can not fit */
-	if (num_entries + ind_bufp->index > IBMVNIC_MAX_IND_DESCS) {
+	if (num_entries + ind_bufp->index > max_ind_descs) {
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_flush_err;
@@ -2612,7 +2617,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ind_bufp->index += num_entries;
 	if (__netdev_tx_sent_queue(txq, skb->len,
 				   netdev_xmit_more() &&
-				   ind_bufp->index < IBMVNIC_MAX_IND_DESCS)) {
+				   ind_bufp->index < max_ind_descs)) {
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
@@ -4015,7 +4020,7 @@ static void release_sub_crq_queue(struct ibmvnic_adapter *adapter,
 	}
 
 	dma_free_coherent(dev,
-			  IBMVNIC_IND_ARR_SZ,
+			  max_ind_descs * IBMVNIC_IND_DESC_SZ,
 			  scrq->ind_buf.indir_arr,
 			  scrq->ind_buf.indir_dma);
 
@@ -4072,7 +4077,7 @@ static struct ibmvnic_sub_crq_queue *init_sub_crq_queue(struct ibmvnic_adapter
 
 	scrq->ind_buf.indir_arr =
 		dma_alloc_coherent(dev,
-				   IBMVNIC_IND_ARR_SZ,
+				   max_ind_descs * IBMVNIC_IND_DESC_SZ,
 				   &scrq->ind_buf.indir_dma,
 				   GFP_KERNEL);
 
@@ -6734,6 +6739,20 @@ static int __init ibmvnic_module_init(void)
 {
 	int ret;
 
+	if (max_ind_descs < IBMVNIC_MAX_IND_DESC_MIN ||
+	    max_ind_descs > IBMVNIC_MAX_IND_DESC_MAX) {
+		pr_info("ibmvnic: max_ind_descs=%u, must be between %d and %d. default %u\n",
+			max_ind_descs,
+			IBMVNIC_MAX_IND_DESC_MIN,
+			IBMVNIC_MAX_IND_DESC_MAX,
+			IBMVNIC_MAX_IND_DESCS_DEFAULT);
+
+		pr_info("ibmvnic: resetting max_ind_descs to default\n");
+		max_ind_descs = IBMVNIC_MAX_IND_DESCS_DEFAULT;
+	}
+
+	pr_info("ibmvnic: max_ind_descs set to %u\n", max_ind_descs);
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "net/ibmvnic:online",
 				      ibmvnic_cpu_online,
 				      ibmvnic_cpu_down_prep);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index e574eed97c..48c16e6f8a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -29,8 +29,10 @@
 #define IBMVNIC_BUFFS_PER_POOL	100
 #define IBMVNIC_MAX_QUEUES	16
 #define IBMVNIC_MAX_QUEUE_SZ   4096
-#define IBMVNIC_MAX_IND_DESCS  16
-#define IBMVNIC_IND_ARR_SZ	(IBMVNIC_MAX_IND_DESCS * 32)
+#define IBMVNIC_IND_DESC_SZ	32
+#define IBMVNIC_MAX_IND_DESCS_DEFAULT	128
+#define IBMVNIC_MAX_IND_DESC_MAX	128
+#define IBMVNIC_MAX_IND_DESC_MIN	16
 
 #define IBMVNIC_TSO_BUF_SZ	65536
 #define IBMVNIC_TSO_BUFS	64
@@ -945,6 +947,7 @@ struct ibmvnic_adapter {
 	int replenish_task_cycles;
 	int tx_send_failed;
 	int tx_map_failed;
+	u32 max_ind_descs;
 
 	struct ibmvnic_tx_queue_stats *tx_stats_buffers;
 	struct ibmvnic_rx_queue_stats *rx_stats_buffers;
-- 
2.39.3 (Apple Git-146)


