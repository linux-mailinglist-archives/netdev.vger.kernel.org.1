Return-Path: <netdev+bounces-88417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5448A71A6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156611F213FB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E839FCF;
	Tue, 16 Apr 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Flv3GWAh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5E37165
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286113; cv=none; b=gA2kiylK5uPrJtwhYw42knFzytRtLswZxCMRfawCxZVdJZSnuOw+6LdvV0wHRV+OhlUgn5zSujo11OC9P635jc9RkDdvQSUFUueIsnDXu198oT17EKlDBFnDInvQsbeTnehrLbF0R+PliZbYeWu8ZSpbPIO6+8IaFvCHA2ttAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286113; c=relaxed/simple;
	bh=hhL9YC42AxZ31cC7ksJqTvYmpcwQRAoX4BjrVD6H3jI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHybi8xubZUI2HXX5BSOtsKu6nPTI7aNDx0GcStTJx1KbgiYjIg8EkD3MAAaN0GPwD2Bh8iqAPZsZ0jISE3RUw4VR/Jq2b3fEk2rRjBEXPUmSEXEdGKSSfdeRm8di3F5/Qix5xm0BUqh/ysf/hZ9vSvGrpmEbHHmBYhJBhLrcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Flv3GWAh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GGmAXI002517
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=sjYiRT5qx99G4nCeAfBOwzFkqon8oVmryUsZSL2Tb+M=;
 b=Flv3GWAh+AQgdGQhIvWW5cdk4ayWRmskrylTal/E/dliSCWkkNdw0caSCkmCcvSsVYST
 +B+7EFfzEXdLbs5UIg7wXSwsdKSH6OUGx64uRqOSxgF5n0UWEJ1gRbmKj1YFcsWGSE3C
 F6z/PzupIeMKKoL5MlUM7uktdbTuREXvOZchxB62N/HlrjYQgYGrug10+sDoGbK7PMiF
 Oc0FtDRl5LtbnTcEy88QHMMe+3buEtXIdzjC+hBMFwqXkOz/qyVzWeA3eVjgW5yRVfqe
 ykMTdV9NrWmeyk54LvhItzrqYD077pQd2YQCn+Wu6CUorBRUlekL6FvdfsHF8o2X2zNO sg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhw5s001a-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:48:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEtQZQ018218
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:41:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct7gbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 16:41:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43GGfaKt8716904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 16:41:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76F3F5805B;
	Tue, 16 Apr 2024 16:41:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 142DC5806B;
	Tue, 16 Apr 2024 16:41:36 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.5.26])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 16:41:35 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, mmc@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH v2 net-next] ibmvnic: Return error code on TX scrq flush fail
Date: Tue, 16 Apr 2024 11:41:28 -0500
Message-Id: <20240416164128.387920-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CTs4rb2n5sltmeRDO7ybl0Q81A2ZeTRF
X-Proofpoint-GUID: CTs4rb2n5sltmeRDO7ybl0Q81A2ZeTRF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=914 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160104

In ibmvnic_xmit() if ibmvnic_tx_scrq_flush() returns H_CLOSED then
it will inform upper level networking functions to disable tx
queues. H_CLOSED signals that the connection with the vnic server is
down and a transport event is expected to recover the device.

Previously, ibmvnic_tx_scrq_flush() was hard-coded to return success.
Therefore, the queues would remain active until ibmvnic_cleanup() is
called within do_reset().

The problem is that do_reset() depends on the RTNL lock. If several
ibmvnic devices are resetting then there can be a long wait time until
the last device can grab the lock. During this time the tx/rx queues
still appear active to upper level functions.

FYI, we do make a call to netif_carrier_off() outside the RTNL lock but
its calls to dev_deactivate() are also dependent on the RTNL lock.

As a result, large amounts of retransmissions were observed in a short
period of time, eventually leading to ETIMEOUT. This was specifically
seen with HNV devices, likely because of even more RTNL dependencies.

Therefore, ensure the return code of ibmvnic_tx_scrq_flush() is
propagated to the xmit function to allow for an earlier (and lock-less)
response to a transport event.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
v1 - https://lore.kernel.org/netdev/20240414102337.GA645060@kernel.org/
Changes:
 - Edit based on Simon's review (thanks!), all callers of
   ibmvnic_tx_scrq_flush should respoind to the return code
 
 drivers/net/ethernet/ibm/ibmvnic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 30c47b8470ad..5e9a93bdb518 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2371,7 +2371,7 @@ static int ibmvnic_tx_scrq_flush(struct ibmvnic_adapter *adapter,
 		ibmvnic_tx_scrq_clean_buffer(adapter, tx_scrq);
 	else
 		ind_bufp->index = 0;
-	return 0;
+	return rc;
 }
 
 static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -2424,7 +2424,9 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		tx_dropped++;
 		tx_send_failed++;
 		ret = NETDEV_TX_OK;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
@@ -2439,8 +2441,10 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		dev_kfree_skb_any(skb);
 		tx_send_failed++;
 		tx_dropped++;
-		ibmvnic_tx_scrq_flush(adapter, tx_scrq);
 		ret = NETDEV_TX_OK;
+		lpar_rc = ibmvnic_tx_scrq_flush(adapter, tx_scrq);
+		if (lpar_rc != H_SUCCESS)
+			goto tx_err;
 		goto out;
 	}
 
-- 
2.39.3


