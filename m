Return-Path: <netdev+bounces-116237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9794987C
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9F283E51
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC265156993;
	Tue,  6 Aug 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o1jf0Ioo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9747F4D
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973042; cv=none; b=SpRV+w9WmU1U7ui8RTLlGLF6tFIn7jKUHEg75BY9jAXja6tKAVeCvbSPIxm9PYT+ucuNLqLsyctgKoa+1CJZvP+borqkgjziGHLoPaRsbECJJoIzHXEjADTUUgaJ5pq86Tl+Y6AlPcfn5sfr4FxteBL4W/ZQ+GVZsumZ8VrgZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973042; c=relaxed/simple;
	bh=/5IPclrHsaUvM7TADbV9D1+E/F7dEp3ehWQF8As5Enw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSwgM7+Dn/YrsboIKK532YoQdIR3x/ccLg2Yx6QKl839pTrybpIi4RCtgGNxd7J4AI2AegxLLH62Z/qIFOgi4bF75tcBW6phI3xtY8m1EHkkpLgZUpFxKdujTCEWo8FKpG3tMOYusbXw6e/FIXNrvtizPDE5++oMHYzcocfXVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o1jf0Ioo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476Hwo7d029547
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=iJIbUQsGqOirv
	r18RJKQF+mcN6j/MBiSCm4tDcnBBBk=; b=o1jf0IooXvqVwIK24K5Iv0yVqg16P
	x4Dmz06WPNEb2mk0aW/KOQgkS8nkNScxMq+IpZJ/xCHkOQV3VOh4lo5cUSzebcvT
	n1E/P0GtHzjrRjnTxGQtadQ/Kmn0bfsVMYgdgeH3RLevIX7wB9uwWnsHZ5yDyjDf
	cFVHjHyxbS4AC5KgUb7Yn/H/5anVgByN+FVmOKIZJoU25ZejOYKFB+okCkYnf6Gz
	ct4aRKDI8kn8VajssYzORqw+lxiPWENuvPn75eKooGwzvMfkzN+ReRkOTV6K9FFa
	Q75YoNqaCvs8OofKr9SrUCp0xUxSSWGwz7GAG6u+0dTaFDj37qfCNPVAg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40urpu86r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476H0NdA006406
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13md22b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbDHI54919592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1666058064;
	Tue,  6 Aug 2024 19:37:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDD335806C;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 6/7] ibmvnic: Only record tx completed bytes once per handler
Date: Tue,  6 Aug 2024 14:37:05 -0500
Message-ID: <20240806193706.998148-7-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gGtJcpc9EQtThy4aSWXWSSiqyGvwcHve
X-Proofpoint-GUID: gGtJcpc9EQtThy4aSWXWSSiqyGvwcHve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060137

Byte Queue Limits depends on dql_completed being called once per tx
completion round in order to adjust its algorithm appropriately. The
dql->limit value is an approximation of the amount of bytes that the NIC
can consume per irq interval. If this approximation is too high then the
NIC will become over-saturated. Too low and the NIC will starve.

The dql->limit depends on dql->prev-* stats to calculate an optimal
value. If dql_completed() is called more than once per irq handler then
those prev-* values become unreliable (because they are not an accurate
representation of the previous state of the NIC) resulting in a
sub-optimal limit value.

Therefore, move the call to netdev_tx_completed_queue() to the end of
ibmvnic_complete_tx().

When performing 150 sessions of TCP rr (request-response 1 byte packets)
workloads, one could observe:
  PREVIOUSLY: - limit and inflight values hovering around 130
              - transaction rate of around 750k pps.

  NOW:        - limit rises and falls in response to inflight (130-900)
              - transaction rate of around 1M pps (33% improvement)

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index c9aa276507bb..05c0d68c3efa 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4186,20 +4186,17 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
 			       struct ibmvnic_sub_crq_queue *scrq)
 {
 	struct device *dev = &adapter->vdev->dev;
+	int num_packets = 0, total_bytes = 0;
 	struct ibmvnic_tx_pool *tx_pool;
 	struct ibmvnic_tx_buff *txbuff;
 	struct netdev_queue *txq;
 	union sub_crq *next;
-	int index;
-	int i;
+	int index, i;
 
 restart_loop:
 	while (pending_scrq(adapter, scrq)) {
 		unsigned int pool = scrq->pool_index;
 		int num_entries = 0;
-		int total_bytes = 0;
-		int num_packets = 0;
-
 		next = ibmvnic_next_scrq(adapter, scrq);
 		for (i = 0; i < next->tx_comp.num_comps; i++) {
 			index = be32_to_cpu(next->tx_comp.correlators[i]);
@@ -4235,8 +4232,6 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
 		/* remove tx_comp scrq*/
 		next->tx_comp.first = 0;
 
-		txq = netdev_get_tx_queue(adapter->netdev, scrq->pool_index);
-		netdev_tx_completed_queue(txq, num_packets, total_bytes);
 
 		if (atomic_sub_return(num_entries, &scrq->used) <=
 		    (adapter->req_tx_entries_per_subcrq / 2) &&
@@ -4261,6 +4256,9 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
 		goto restart_loop;
 	}
 
+	txq = netdev_get_tx_queue(adapter->netdev, scrq->pool_index);
+	netdev_tx_completed_queue(txq, num_packets, total_bytes);
+
 	return 0;
 }
 
-- 
2.43.0


