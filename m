Return-Path: <netdev+bounces-116239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8567B94987E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405852847BC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F314B965;
	Tue,  6 Aug 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EZeBOF1h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9212C499
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973043; cv=none; b=FCgj99Uj+IbVNLjVuPrEXu1Pk5+bBpWk8/3Os8GPSwMZ3miB6IbejpgyAwQ3M4jK8ZhQF4AREvLhZGCmqYVIk4yvSKG3wN3+fWqmt/iU07hM55XiyCKQ0BS/ldPSMNOCSIX4rg0smTmioyyHsGHmbyl/q6n97xGf6RhLIi4XH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973043; c=relaxed/simple;
	bh=t/1BK2+tpAaAfFQB+q8K22HzLFSh7Meh2ZHVRJ/qz7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4k3uV5qNiBnNU3TSD5idE+ed2mZocbDunaNRZfXIa84sFRLtkJo5U8vwtYpILFfjcgkDsmiKFjq5Ll9nvw7v0INy67W3fNglGTJZU4qn+TJqq38gMhDq3+YBYxepYsuJ1U006h6lKFNzrj3eeSxAbMwI0+KRuDWS1ySYEbbLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EZeBOF1h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DLSDC009287
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=j7s1Ev9EV0hKr
	e5G+8Ibj5+DunSsTusQJb1T8kvtq6E=; b=EZeBOF1hYGmNVmUTyZ1P9iyp7ihJ1
	thhYMCKVhj8mmJ6Qu5G835O/fYpQVijkAnQPOtcqUTLpAXQIZgfF5mtu/noJTInW
	tSbFv97jM4VvWFEKYLxU3c7ULnB4tPqeapGBogYK0aRlh4+ki5hlIGAmsoh3mbTM
	99394u6DwAt7Tf4tGcUO/2MsxEPBK5N8uyoQ0rjLCZ69KWykzRSO5Ju6Td8H74Ct
	lH1JDx4wyDFH6Ltcu4UMuyW7m9kt0ZrVjdPUtmx8/k6b/Akl/DumVGihqFq0nX7w
	uKOYo8/mhJiGw5sRWHGPZgriWIHyVnDYfg2IdFvqr6th4v/eqw+ImbuWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk02h2hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476H4bo2030631
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k34yu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbEc02097710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9665805F;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EBD55806C;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 5/7] ibmvnic: Introduce send sub-crq direct
Date: Tue,  6 Aug 2024 14:37:04 -0500
Message-ID: <20240806193706.998148-6-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806193706.998148-1-nnac123@linux.ibm.com>
References: <20240806193706.998148-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZrdCHJMrK6okCLeTbHWJ6vr_aKs0LDAD
X-Proofpoint-ORIG-GUID: ZrdCHJMrK6okCLeTbHWJ6vr_aKs0LDAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_15,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=742 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060133

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
index 533e79a0c6ac..c9aa276507bb 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -117,6 +117,7 @@ static void free_long_term_buff(struct ibmvnic_adapter *adapter,
 				struct ibmvnic_long_term_buff *ltb);
 static void ibmvnic_disable_irqs(struct ibmvnic_adapter *adapter);
 static void flush_reset_queue(struct ibmvnic_adapter *adapter);
+static void print_subcrq_error(struct device *dev, int rc, const char *func);
 
 struct ibmvnic_stat {
 	char name[ETH_GSTRING_LEN];
@@ -2331,8 +2332,29 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
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
@@ -2347,7 +2369,13 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
 
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
@@ -2405,7 +2433,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 		goto out;
@@ -2423,7 +2451,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_send_failed++;
 		tx_dropped++;
 		ret = NETDEV_TX_OK;
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_err;
 		goto out;
@@ -2518,6 +2546,16 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
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
@@ -2527,7 +2565,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->num_entries = num_entries;
 	/* flush buffer if current entry can not fit */
 	if (num_entries + ind_bufp->index > IBMVNIC_MAX_IND_DESCS) {
-		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq, true);
 		if (lpar_rc != H_SUCCESS)
 			goto tx_flush_err;
 	}
@@ -2535,15 +2573,17 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
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


