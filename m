Return-Path: <netdev+bounces-116234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EEC94987A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81260B231FC
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED99149C74;
	Tue,  6 Aug 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BD9Rq1Tj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA2145FFE
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973041; cv=none; b=A6wY34rXcHT30I5EUplJVsvtkp88/FnO+udWLZGS6K7YM0NqwoP4HU6Bg+ihWMP2yohRGGIoomkRTXoZcWIvEf/3ge3lnM+Xptku4VB8ES1Cgug1Ryl843pzAo/5+7iFwG8k1BaHQj36rBLAUzmoeWQohPAREg/RGpyEFGC1kIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973041; c=relaxed/simple;
	bh=5aRgmwjzDXGtjq+Vbl0Pa8AXRWww+jkev0i51c5eepY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdhBcH0RUfFG68BRCoFI+Z5Vro9syI2b8Vr+bGG6Pb1npWEQjbcspf4rk0H/jB+7BRjmgT9aMJTA5qD4kres8A81ySoRp6FEAl6Utk3evOpYuGBxaqnJWstCzo76h5Gkg5+QSjcwIKlqLD8GhpihXaI68Q37iruBtQkJJa4diBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BD9Rq1Tj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476IvZHg007179
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=QIAYAXrsT1CXG
	d3IRy+2NikBB5/uSeba2Bjjl1+FiqE=; b=BD9Rq1TjhgiM3VGYjifhCT+rILmbI
	J+odUKMz/gRE14ZUodiauTMfHUXIH0HsEHXvt2A8efiTIeCCykH7Hk6xDsuZp5ZX
	RZPRaI5KM+eOYAnzCIoI/PiYeB5jIy6Q9kxzQavN4rUP81iHqVx3QRVqiq9TTrTh
	eBzKE7aV9nKA2SnFCny0Vvo8dxkc3uP9HPGPtqIeK9WHIL+I6wD+m+gcvuZtwUCS
	cm/rx93Z6Fm7J4YoQSAYYUwp0mpJCVMZWqV90xee5delQ78Y606BtfeG+vvjxoEv
	iEJyLQ/QCz7bztSfEdLXi/mtPdtWZOHzuTOD/BIwpWIOfDbspu8Az2qxA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ucd21yq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476J7uOd024155
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvpdc1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbB6u17171096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B8DC58054;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4F815805D;
	Tue,  6 Aug 2024 19:37:10 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:10 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 1/7] ibmvnic: Only replenish rx pool when resources are getting low
Date: Tue,  6 Aug 2024 14:37:00 -0500
Message-ID: <20240806193706.998148-2-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: JhGGkf4ssODD0wmZ8lxj23L1ruIbYIlw
X-Proofpoint-ORIG-GUID: JhGGkf4ssODD0wmZ8lxj23L1ruIbYIlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=565
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060137

Previously, the driver would replenish the rx pool if the polling
function consumed less than the budget. The logic being that the driver
did not exhaust its budget so that must mean that the driver is not busy
and has cycles to spare for replenishing the pool.

So pool replenishment happens on every poll which did not consume
the budget. This can very costly during request-response tests.

In fact, an extra ~100pps can be seen in TCP_RR_150 tests when we remove
this conditional. Trace results (ftrace, graph-time=1) for the poll
function are below:
Previous results:
    ibmvnic_poll = 64951846.0 us / 4167628.0 hits = AVG 15.58
    replenish_rx_pool = 17602846.0 us / 4710437.0 hits = AVG 3.74
Now:
    ibmvnic_poll = 57673941.0 us / 4791737.0 hits = AVG 12.04
    replenish_rx_pool = 3938171.6 us / 4314.0 hits = AVG 912.88

While the replenish function takes longer, it is hit less frequently
meaning the ibmvnic_poll function, on average, is faster.

Furthermore, this change does not have a negative effect on
performance bandwidth/latency measurements.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 23ebeb143987..857d585bd229 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3527,9 +3527,8 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (adapter->state != VNIC_CLOSING &&
-	    ((atomic_read(&adapter->rx_pool[scrq_num].available) <
-	      adapter->req_rx_add_entries_per_subcrq / 2) ||
-	      frames_processed < budget))
+	    (atomic_read(&adapter->rx_pool[scrq_num].available) <
+	      adapter->req_rx_add_entries_per_subcrq / 2))
 		replenish_rx_pool(adapter, &adapter->rx_pool[scrq_num]);
 	if (frames_processed < budget) {
 		if (napi_complete_done(napi, frames_processed)) {
-- 
2.43.0


