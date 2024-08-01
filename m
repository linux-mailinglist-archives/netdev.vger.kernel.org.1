Return-Path: <netdev+bounces-115125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76AD945408
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95E01C2337E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1CF14AD25;
	Thu,  1 Aug 2024 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MCPBV+Mi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95014B94B
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546763; cv=none; b=APtBM9x8XSsdZXY/0dMV6C11pCA64LN2i8gtLkCfO5zJ3fKBxB9EdD4Ra8orA0sHGU94pqL+W+eKV2YNuzdLoXulISP7L6mertxLXANvxrrFeg63bOBKPTyUZDNYBjqhc/VlOurm/Z26Ak6KOgE3D4tIE8VjArUjEu9VJOIX87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546763; c=relaxed/simple;
	bh=PXhqYm/use9phwM+IUkaPxAFCWcpBkAupltcEmT5V/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giY+xBj70h/BDqSZp3n2xrSopjUJjzzlvKifFVr4UfJJqoyD9LgATtP2nSONbO4769AnDd9yRFxvvqtIzm4C17hAh7rutajywt7Hyr3OZqDsm/zLtxTlvGYmTPUCcPPziau2SC0wKLfK4pTMXbYj6GuzQvm8NeKsH9e17m+IRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MCPBV+Mi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KSXpo015677
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=sOwNFuIkHRvxm
	Q4C0GAoS5Kyc5vKLC5OIph+8MkdRp0=; b=MCPBV+Mi0lpHJzV4+c0d3GIVNAB8p
	7xDRiX423MZlWocRoLU6b3uAe1C6ayGdxfdTHVL57RT/pqCxM4KZ9cywXbLmKZQU
	UapP8bpyGxPZFrXFcH07df7FQDwpwK5tGpvEHaKL4qWCT2JVvkUoTPvYR5Uq3Y9C
	xPl9BheZQA8iGnc1PflTuKHN+HgxL3i906PxwkBWbdTcN0gIsmqmie7H4X6PoS38
	OWVH+DpqTiBL9Hy0MFJC1f8uqWSksnEbSl7B6ZMpYR+jJkzd7GRU5LIZf7lCE3JA
	jTHjYIT6eBUj1P5mo2b6wkegwoVeskyA6vSS7trYnQ/kE9racRX+6c+JA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe4g35w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471JmTbk003773
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:12:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemup10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:12:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LCSbB43516498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:12:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1DFC58068;
	Thu,  1 Aug 2024 21:12:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83FB55804B;
	Thu,  1 Aug 2024 21:12:28 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:12:28 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 1/2] ibmveth: Optimize poll rescheduling process
Date: Thu,  1 Aug 2024 16:12:14 -0500
Message-ID: <20240801211215.128101-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801211215.128101-1-nnac123@linux.ibm.com>
References: <20240801211215.128101-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ZpqGXJRkPYCUvaK-7wBVPBgKjuEd59Z
X-Proofpoint-GUID: 1ZpqGXJRkPYCUvaK-7wBVPBgKjuEd59Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=855 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408010135

When the ibmveth driver processes less than the budget, it must call
napi_complete_done() to release the instance. This function will
return false if the driver should avoid rearming interrupts.
Previously, the driver was ignoring the return code of
napi_complete_done(). As a result, there were unnecessary calls to
enable the veth irq.
Therefore, use the return code napi_complete_done() to determine if
irq rearm is necessary.

Additionally, in the event that new data is received immediately after
rearming interrupts, rather than just rescheduling napi, also jump
back to the poll processing loop since we are already in the poll
function (and know that we did not expense all of budget).

This slight tweak results in a 15% increase in TCP_RR transaction rate
(320k to 370k txns). We can see the ftrace data supports this:
PREV: ibmveth_poll = 8818014.0 us / 182802.0 hits = AVG 48.24
NEW:  ibmveth_poll = 8082398.0 us / 191413.0 hits = AVG 42.22

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 4c9d9badd698..e6eb594f0751 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1337,6 +1337,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	unsigned long lpar_rc;
 	u16 mss = 0;
 
+restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter))
 			break;
@@ -1420,24 +1421,25 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 	ibmveth_replenish_task(adapter);
 
-	if (frames_processed < budget) {
-		napi_complete_done(napi, frames_processed);
+	if (frames_processed == budget)
+		goto out;
 
-		/* We think we are done - reenable interrupts,
-		 * then check once more to make sure we are done.
-		 */
-		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-				       VIO_IRQ_ENABLE);
+	if (!napi_complete_done(napi, frames_processed))
+		goto out;
 
-		BUG_ON(lpar_rc != H_SUCCESS);
+	/* We think we are done - reenable interrupts,
+	 * then check once more to make sure we are done.
+	 */
+	lpar_rc = h_vio_signal(adapter->vdev->unit_address, VIO_IRQ_ENABLE);
+	BUG_ON(lpar_rc != H_SUCCESS);
 
-		if (ibmveth_rxq_pending_buffer(adapter) &&
-		    napi_schedule(napi)) {
-			lpar_rc = h_vio_signal(adapter->vdev->unit_address,
-					       VIO_IRQ_DISABLE);
-		}
+	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
+		lpar_rc = h_vio_signal(adapter->vdev->unit_address,
+				       VIO_IRQ_DISABLE);
+		goto restart_poll;
 	}
 
+out:
 	return frames_processed;
 }
 
-- 
2.43.0


