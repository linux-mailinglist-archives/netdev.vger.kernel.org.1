Return-Path: <netdev+bounces-115127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4CA945415
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03211C22A06
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053314B940;
	Thu,  1 Aug 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HmhWJHCj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647B1494DD
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547435; cv=none; b=N9S5HKHnK+Isp7D6+ZTuz4Icfr8fEZXv8K+jEP2SmCb8/dsTgps2rNTK0iv+GHMTZcAWGsiqm5vzFjIddol5HlJDqqIlW9TyZsvy4P64TzNaPxQItI3kSECxu2psdeJWSur88SOZ6yo8jzLnBlJEhZVJGIprdaljsInj5fX4MPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547435; c=relaxed/simple;
	bh=/5IPclrHsaUvM7TADbV9D1+E/F7dEp3ehWQF8As5Enw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGdKnycJyOHIzPcihjNx6qUsFvXpx2vlSc1PRUHUvgYqTeXf5/jZkjiLqt9rk26hNbRapPq4L9X/f5ss4PXaH/yYnU+W2t0CF/TQnIOsblqjLxRoHBxhvgA1R0Xo0qyNKWX6GWAoj/feLnIx0nD6y/1XeOJF54VbXC/0K8ABPCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HmhWJHCj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471L006B017788
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=iJIbUQsGqOirv
	r18RJKQF+mcN6j/MBiSCm4tDcnBBBk=; b=HmhWJHCjwatx9sWK7mrqPHB5cZOwm
	2S6e9umsqfVkgZQkBzIeRaI2w507uaXyEOhgam2YIpsAzSOIGC/QP4dLKr41mm2c
	p8mPckDt92le4geaHnW+9fttnz8rI9/PBO8ydEOpBlWqqNfZHkGXiyXW2FDFeoJY
	aYHlh9aX7QST0CbdpuBkpx0MtnmBv0vRj7YDMENxuRF4oZKNvgmLCQxP9LXedn3s
	qUAkDgx9I/Jympges5TabtIZyunxQpd2LV0HP11St5wLbG6z7hJQ10BoWgwftHnY
	AxVoBLCiaMxkgFb0EAZQw5S156euG9i9DLwViKXFoJEYyTA5PpV1goEug==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhvm01kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471LDCAM007479
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7um7a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LNkKl18547446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:23:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE3E5806A;
	Thu,  1 Aug 2024 21:23:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45CE65805C;
	Thu,  1 Aug 2024 21:23:46 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:23:46 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 6/7] ibmvnic: Only record tx completed bytes once per handler
Date: Thu,  1 Aug 2024 16:23:39 -0500
Message-ID: <20240801212340.132607-7-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801212340.132607-1-nnac123@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8KPuvrnHDV9q_4yEIe9Uv6z0JqCfT-3o
X-Proofpoint-GUID: 8KPuvrnHDV9q_4yEIe9Uv6z0JqCfT-3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_19,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010142

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


