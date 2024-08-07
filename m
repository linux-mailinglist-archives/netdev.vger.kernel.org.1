Return-Path: <netdev+bounces-116614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D789894B1F9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90049282B67
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B514EC71;
	Wed,  7 Aug 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZSOH0vj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00F149DFA
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065505; cv=none; b=eaA6yesDUSBCtBKxy7zOtTfm9bMeVsgFEf0PCe7G0Gzdtn/La0z0n5Q5+P3nap1XMp+1DmImXo5TumDHRGjL6G2HB/P04vson+nG+uj539iCjtbpoxnwgvlGBOKbpttVhPrlSUiMDA4oH727+Uvjj/Umoinrz7Q98t7Vh+YqKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065505; c=relaxed/simple;
	bh=Zm1+zmMN7mVOBZ2oTcNiHktbC1y4+T7jrQCwUx+Mp+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFiy5CG+Oy75tm2Lg9+3806FqlmjTPOn/n/5uDMOlGcncJmc9aVagYKHnO6vD/bu3bd6i1fulU9fLZSytXRcDaM5Gq8ObyYpvaLusOS8hkEr48orCM7N1SOAf0hfajTgIMNi8qzSDxzD2PsNQ6YNS3NpjlEELvGCIB5QlodHQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZSOH0vj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4773oVh9005550
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=cMimASxI3Eekg
	W34nsZq39u6otlGd1p6TEdtqgLlIVo=; b=iZSOH0vjvywg5O3ZXUXbb4BcaBi1l
	SmG8Bxp2h2QkZx/bBbvwsiES3/+3dFnAydSMIDwrTKZO8MzpX406kk928EsK/IqH
	wf0fH0azDyK7kjvAX/HQDBeQFmdd0NlDWjO7iVLttM+db9oR37zit6JICp7UGtr6
	K1V/0y4jxIFiwVDG88ccBwupxWGkytJUQE6LXF+CwVIulDho7SZP/0dCvFrBOkh/
	Cq7Q6h/Kod54xWBop7dg8P2fKlhXo9eJ/A+E6H/yb/GD/0/qMSIUTsbbfhSAYCxp
	wNsBJyA5yys0P1HO+NYgYDeP+2awTERBI0rQNDvFRxGTnu0JdjD3Qipag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ub2x4xs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477K0a5g006390
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mjsyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIFQ338339084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 754435807A;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C03F5807C;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:13 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 6/7] ibmvnic: Only record tx completed bytes once per handler
Date: Wed,  7 Aug 2024 16:18:08 -0500
Message-ID: <20240807211809.1259563-7-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: zzlj4JXiLBBP4EwseVJtXT7uXcFKy7MI
X-Proofpoint-ORIG-GUID: zzlj4JXiLBBP4EwseVJtXT7uXcFKy7MI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070146

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
index d7262674eab7..b687e5396e11 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4189,20 +4189,17 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
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
@@ -4238,8 +4235,6 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
 		/* remove tx_comp scrq*/
 		next->tx_comp.first = 0;
 
-		txq = netdev_get_tx_queue(adapter->netdev, scrq->pool_index);
-		netdev_tx_completed_queue(txq, num_packets, total_bytes);
 
 		if (atomic_sub_return(num_entries, &scrq->used) <=
 		    (adapter->req_tx_entries_per_subcrq / 2) &&
@@ -4264,6 +4259,9 @@ static int ibmvnic_complete_tx(struct ibmvnic_adapter *adapter,
 		goto restart_loop;
 	}
 
+	txq = netdev_get_tx_queue(adapter->netdev, scrq->pool_index);
+	netdev_tx_completed_queue(txq, num_packets, total_bytes);
+
 	return 0;
 }
 
-- 
2.43.0


