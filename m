Return-Path: <netdev+bounces-202698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161A4AEEB0A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BCD1BC3A09
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92F25C6FF;
	Mon, 30 Jun 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bYp0fo0s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFB258CD4
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327305; cv=none; b=ryn2v7Nqtk2P3P94E+OE19UQlbprdoxJIq7cXnpDXkqSYWJ6DRHOCtDqMXcjwZSKF0vKNqlGINn9BFqIOAe2dxv1Q6upaR5iacS4B9ozGju/WOT7yvR9iXjzbw8y8+AOPCKVgjFowGOsSrLPbxRsYkZkdry00gqnv2LQONkHeZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327305; c=relaxed/simple;
	bh=mEkdHZuODYeT/fK2xvMSrPRl+ZEHWaYRd/I6GMExya0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y2TBtq5YBai6JxiuQNkOwMR6qtfyUhsqvZYNXmOL7aj2xzC+6aDs9cQNL443fMOjK3NxP6R86AA7mhhmT2ZAB14iNBSRRjJbfhew1NX9I6STqkNCGMrIk4HSQg6PL8oghX13ynnLH57KO/lmIxq93HIQLHR3m2JA2SIdhWroQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bYp0fo0s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UGU3W5000523
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LOM4M0iKtMMRRubHP
	lTFm538t/7FMkNlBSfMk4dkb3c=; b=bYp0fo0sYVPFYMkWOk7RRDyyg2HNyHLT7
	1G0jhD8Y/oeEPkG+Ie3N7SwyDkPO353qOZmYFDdx7pHjHKVCXyn6zVjzqd26xY5Z
	5mT4OJPl7OqRpm2ia6ZS6Avx8bCfg5OerAo92v0C/WhrzurWVmmDE8j2YJ0odCeN
	g2Ehjq7uaR9d3ccZZS2hCjAVWGcEWfDfpm9wXb0/x9SmAONSfny+RYy0pfYWmxDl
	3ogjSygqmA7lfAi0QnDVXYFuDyy8rPOckxN30bDHh9ddRzSfEDoCyMllKvBkj2Kr
	jOwkkGcsFqqetc6fuO00uhyTKjYnX/J/Nbe0PqBceOrDXxn51XbSQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt4jbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UNVmfK006881
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm7xyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:20 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UNmIMo26018496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 23:48:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9228E5805B;
	Mon, 30 Jun 2025 23:48:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E807958058;
	Mon, 30 Jun 2025 23:48:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 23:48:17 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        mmc@linux.ibm.com
Subject: [PATCH net-next 4/4] ibmvnic: Make max subcrq indirect entries tunable via module param
Date: Mon, 30 Jun 2025 16:48:06 -0700
Message-Id: <20250630234806.10885-5-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250630234806.10885-1-mmc@linux.ibm.com>
References: <20250630234806.10885-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hT4jHXrHsW0Bhn8PSlW6-tf6a6BwmoZc
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68632245 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Gm_6_7DS1KAn-p_J6_oA:9
X-Proofpoint-ORIG-GUID: hT4jHXrHsW0Bhn8PSlW6-tf6a6BwmoZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE5NiBTYWx0ZWRfX+3M1RjPc09fJ ibrVNsLEsg//IEnA8PQUWgGkQM37RXCdLH3iK5wXkJx/UA0qZzLoV08JnuUsvsPMgObJAAYOg+Q bfI+VFSyo41hRCFEXsq6ySuASrX/SryE7wyzhZi9ydLWT4AlJ140SVnuL2HbQ090CmiHzJiSIgv
 ZxY9AemAqzVAviVFLVJV25p1/MZTckqwbzy6rti9O7loRieBSEPgkTvz6L3UcVNHHS773DsFxOM LiRElJgbJ+GnUQICrvjsfw5/7oJ9hI0a2z4PDZg5HTKU4eGIofVqH8/LldWkoJ3mEWSm4b8bphN lg9+/8uD2a8qQ5UguZQMQZU61MNyhfpVWdAaStKCpQWFgpDCDDx2SdVhQkcsj6/uGga8ZX+fYFQ
 pCMFVqOjrfH0ZeOH5QJtF+qNvzDH2joy1bnqr19sc7EHqKnoPXcKjhKdoL9tFVP0wB6HDNRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=952
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300196

This patch increased the default of max subcrq indirect entries ,
and introduces a way to tune the maximum number of indirect
subcrq descriptors via a module parameter. The default now is set to 128,
as supported on P9, allowing for better throughput performance on
large system workloads while maintaining flexibility to fall back
to a smaller maximum limit on P8 or systems with limited memory resources

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
Reviewed by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed by: Brian King <bjking1@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 29 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ibm/ibmvnic.h |  7 +++++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 8c959d5db2..a9c313d6c7 100644
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
@@ -2590,7 +2595,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_crq.v1.n_crq_elem = num_entries;
 	tx_buff->num_entries = num_entries;
 	/* flush buffer if current entry can not fit */
-	if (num_entries + ind_bufp->index > IBMVNIC_MAX_IND_DESCS) {
+	if (num_entries + ind_bufp->index > max_ind_descs) {
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_flush_err;
@@ -2603,7 +2608,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ind_bufp->index += num_entries;
 	if (__netdev_tx_sent_queue(txq, skb->len,
 				   netdev_xmit_more() &&
-				   ind_bufp->index < IBMVNIC_MAX_IND_DESCS)) {
+				   ind_bufp->index < max_ind_descs)) {
 		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
@@ -4006,7 +4011,7 @@ static void release_sub_crq_queue(struct ibmvnic_adapter *adapter,
 	}
 
 	dma_free_coherent(dev,
-			  IBMVNIC_IND_ARR_SZ,
+			  max_ind_descs * IBMVNIC_IND_DESC_SZ,
 			  scrq->ind_buf.indir_arr,
 			  scrq->ind_buf.indir_dma);
 
@@ -4063,7 +4068,7 @@ static struct ibmvnic_sub_crq_queue *init_sub_crq_queue(struct ibmvnic_adapter
 
 	scrq->ind_buf.indir_arr =
 		dma_alloc_coherent(dev,
-				   IBMVNIC_IND_ARR_SZ,
+				   max_ind_descs * IBMVNIC_IND_DESC_SZ,
 				   &scrq->ind_buf.indir_dma,
 				   GFP_KERNEL);
 
@@ -6725,6 +6730,20 @@ static int __init ibmvnic_module_init(void)
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
index 1cc6e2d13a..56f157cd8a 100644
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


