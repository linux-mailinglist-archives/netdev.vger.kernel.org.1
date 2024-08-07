Return-Path: <netdev+bounces-116610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0094B1F5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B3B21F62
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770B149C52;
	Wed,  7 Aug 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDES0Vfh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D123BB24
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065503; cv=none; b=UF88eat5OEzNHspI5DVLc5nvWjWZvDtF2pdKObV3kMtQxejWt2+21v+J6B0sOh1/pFI94ax08Zsf4tvxbzfoa/7dDDhbo6e6A7DSj+7vV4fieAf41rhtm2QNJRFfoMudS8GrkUrsNYa0ww4v5ABseQwT7PF6wXLoENi44RFv3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065503; c=relaxed/simple;
	bh=5aRgmwjzDXGtjq+Vbl0Pa8AXRWww+jkev0i51c5eepY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYKMIpDIS45FfCtuQX+4LcvK5aWE3nX89gKnKp+bA2ny8lOfbIhz/KSF79frL+wqSvqEdo5eN4EaVrClq3W+DPCLHqQ5y7vDRxVwo8C2kwzTUNU3CHeaxlPfoXNmUGsybPF8Pn8FnyHrYh0cwMqhEYGwvhBlMKhtno3zgv+TAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDES0Vfh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4774Qb8t017805
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=QIAYAXrsT1CXG
	d3IRy+2NikBB5/uSeba2Bjjl1+FiqE=; b=lDES0VfhFawX1mvg93cKpq445K4OA
	VbdFdH3BGxFDI3Dy8o6t2BOiEHdreyn9XDLNJZUx5mNXa3e4S7dk1lVnnuTMKCgM
	AJqET1E520VFl2hbRP7eeK7+jC630/tTR3brB9aWGQcyLOle1lTBaNnsO8jamW3h
	Tom5XGKGqEeBWx4Tg5wqKDbZRlJVz7XV3jts6ztyO92MSqeotnMIJsoZ9/EwHNL5
	NU9bOQI7DHdLZmdsJJTm/KYeyb+wddrr7qp3Vasu4F2HgcrBX5AgOHI1fmtoTXUv
	9sYRIWsDUAlZ0vcdzo6Du3Mxv5pgD+WPr2u/FI2ADh02ARK5qLSKK5udA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40unmk3pn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477K06Ml006490
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13mjsyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIC1O45613456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387B458078;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AA8158064;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 1/7] ibmvnic: Only replenish rx pool when resources are getting low
Date: Wed,  7 Aug 2024 16:18:03 -0500
Message-ID: <20240807211809.1259563-2-nnac123@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: rCpVWJ051l7FdEN2f9fabQpOXBxApAKa
X-Proofpoint-GUID: rCpVWJ051l7FdEN2f9fabQpOXBxApAKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=556 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070146

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


