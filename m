Return-Path: <netdev+bounces-116611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E394B1F6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6791C212F7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712314B087;
	Wed,  7 Aug 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KbjnWLmf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D034D5BD
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065504; cv=none; b=cPdDHygtLvKg6S+QwIDPL6i8wlp5AI2X5+I+hyA1ManlXT30SVTd86rDOaRAcPfmNucUv6S8tOh8GP5N9YeYRgfq8BhGPVaew8r0oKtjuO9tykiP1my/C87lbSqjW7Q+0tkNqYlSv1dYSiG7hL2oytCY9TWOgavuR9GB1kgAIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065504; c=relaxed/simple;
	bh=Prv/K3HM+hivt3B+7RuhgiXWL6jYztMfavPOwv59A8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzPRRgtw+Ofw1zJJQ60g7oGl+7dF+zSeVgq11CPqV1FURwhN3W7XYBEA2qB3iXUAcV8kru+Pp5psghsFjX39ciKg91wlSkrSMEWLcRDjk4Kjq3yW2/s6e/Q0Q2YeTk1+eVVxS2/4yMaWwBuRi6x3P9OqZV5+Yc5lOfOR2yU+kHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KbjnWLmf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HdCfk004198
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=AdbWvYEUFN3Y0
	4j3jbz+2wNkCxAabedN945X2raDZww=; b=KbjnWLmfqeEDdv6kfjDuVOa/tJKFk
	dw7yb3cfEyY0d7ANhVZBp05km/3ATiuZ6Gvpj9ZBuNdz87DWJWI9RWyUGF1BPNzj
	ljCob6l39TLiVnr95Nr+2ceHmKEzMgqgfvwnfn+Jh+zjti6CwJYGjMf7JIEDFTR0
	HE1gQXmCt5HNiKt/EhZGqJzDWsU7ho3WZJ0+LdaU0F5EzvZV0vBALcTf7xrLZs8e
	71WoHWPWEuNHTX/0r1J/n/565FcYpOXhVZzo/lH2wPRVGSoFo/gQOa5xkZFOtx2G
	O2ULKS280pP6IN1gLM3AdkhyWWFONeSSIFIvVvxV4ZG8bNer+1XXSVEYA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vdgerf39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477ISrLr024311
	for <netdev@vger.kernel.org>; Wed, 7 Aug 2024 21:18:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90u7ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:18:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477LIDF338339082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 21:18:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB3425806E;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B3358073;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
Received: from tinkpad.austin.ibm.com (unknown [9.24.4.192])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 21:18:12 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v3 4/7] ibmvnic: Remove duplicate memory barriers in tx
Date: Wed,  7 Aug 2024 16:18:06 -0500
Message-ID: <20240807211809.1259563-5-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: 1Q9ebM1BAfB0cZfqee9Kl5eJWP3vyqve
X-Proofpoint-ORIG-GUID: 1Q9ebM1BAfB0cZfqee9Kl5eJWP3vyqve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=704 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070146

send_subcrq_[in]direct() already has a dma memory barrier.
Remove the earlier one.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 58a517ecbda3..256feac588ef 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2459,9 +2459,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		skb_copy_from_linear_data(skb, dst, skb->len);
 	}
 
-	/* post changes to long_term_buff *dst before VIOS accessing it */
-	dma_wmb();
-
 	tx_pool->consumer_index =
 	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
 
-- 
2.43.0


