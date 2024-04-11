Return-Path: <netdev+bounces-87184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13C8A204C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D10F1F22213
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832B29417;
	Thu, 11 Apr 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QupZcvgs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9829425
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867697; cv=none; b=FaDn39M8GKWbCPKOp1n7zj4jSZisAOh9u/bq2MwD1YApSC247OAOEvXX1qhZTd9eWjM2vrQdE5BWl+976YgXL+ifW9/udarMLmXCZzYqtdQJWK75zpt9enP9Ps59/msBvR5ofd70+7uTXSnr/Jj2ghU4nOdREzb22XN6n6+4zXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867697; c=relaxed/simple;
	bh=vOKY0q5eSsDwDgkkwlZIO5+DlS/iarqDbWDJMkKHzas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpiAnN1ULZoVUSzQAUg/+B/wgbDuJdWwWK4chRM7YVBQJDhI729zDtjdISy9uMjgHlUCbX+C/7XC9PjEu0fldWiiU+vfvrLkguXFhJsoBQFgHruI+y8cbBhor/SSLzY+VHWExHO0bUjL+cpDyRZCwjJhFccyaYWOQoRGsruPfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QupZcvgs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BJSTrI011690
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=14XH7WXYfha/I0/6ANApvyuqYdl3RJrK+5miWXJWz+k=;
 b=QupZcvgsszhtLaZerlIKJbvdOJ/4CYLOmksR2uF4GqpnQMnEFeDT+VvpUvV7J+CEDGnH
 zPTwQpaqnwYnVPvYb3kDKv08WYaudMhRgM1ECu7xuAXpCZ/Y46Sp6IaCoasfATez8TUL
 28iZtgT1IWRr4khFUKq8jaWLCEKie0j/oSHxtZn31V54zCKrip0H9DHy0qiEUJHEQtE+
 Xpvh5Z8JUPDgvj4i4gyKJfO9K47AkBldmlDj1AuVHjj38C7e3u/mdtJ5MKMVA1nOWgBN
 O95odCym6t+rkT0rGOLV9szZ+ED4FvHlXbpkHkpfOrux7Hwt7WkeptNx8pnZa/CXyUgg sg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xep1r04tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:34:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43BJxq3X016982
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:34:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbke2w6xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:34:52 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43BKYjk026542686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 20:34:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F935805D;
	Thu, 11 Apr 2024 20:34:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A820A58057;
	Thu, 11 Apr 2024 20:34:45 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.5.26])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2024 20:34:45 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, mmc@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next] ibmvnic: Return error code on TX scrq flush fail
Date: Thu, 11 Apr 2024 15:34:35 -0500
Message-Id: <20240411203435.228559-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9YODJEpKScIzej0P7M-L4sYDMQJHwnVj
X-Proofpoint-ORIG-GUID: 9YODJEpKScIzej0P7M-L4sYDMQJHwnVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 mlxlogscore=986 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110149

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
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 30c47b8470ad..f5177f370354 100644
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
-- 
2.39.3


