Return-Path: <netdev+bounces-116233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E111949878
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 179F9B22D05
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078AB146A6D;
	Tue,  6 Aug 2024 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ozAc5PAD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9838DD8
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973040; cv=none; b=DtiSpU8GLky05QRLAWbmz6cN2uKk48p4XBfDh2G9f5maPwnrRMnEW5t5RBBUaaO7sxJ45k87l8RZ3vJMLXA1eLBZvOyyP6p07au86IGGpNN1KWihou6RPuqP8g5+S7dpbxrVdhhEm2rxV6e6CGY0OEGgRPbmalIsfcpoGT+Jvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973040; c=relaxed/simple;
	bh=7Z9pwhGpZAMRodoyQmwJ8e45wXSk1R/84HMrEdYsOnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkrjCjwJoDY3mTn425ip7vfcLETub91BocQPERRwbJi2N2qc4mXuMu+WIrUv5ZQPCiHjwnjxHaFcOWEw1jW8gzubZ0rSVkYUFwylzC1kT+SRwxiujFsEd/2v4NNAFcTKZaIXW8piXPhjB/MmSjNbMXkKSYW3ZKtkTF16PGA5Hq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ozAc5PAD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476JRiwA028662
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=basNJjkCJCNKd
	sRXdSDW7RxLhtyZjBK/tFUMy7UDFnI=; b=ozAc5PAD/UAM3yXGdvi/556CE2zfp
	4qwr+WCS7Jdd0wQ0HYa7uWm/AUK6KEGbzKLPB2aC/KmRfcVv5Hd5LtbPtLYZl1pH
	8nkTmEC7/pe3nkPLoskUVNzNVjCbg787uZRcL7DlkeVjG+nUzaKE7mI5eZVvoXYN
	PH30Q/nLoh4kekfnWcm408QMCZikE1nHLvXJ9b72Z+OQiQUvp2t8UvgG0C2Y6OVI
	GO5Js+/Aq6ocwek+Q2c8hxrtIEepFLRrFPknN0z3tYFWBQnOOjNDArvhEIhM9KCR
	iH7J1BXFlL2bA81RmX3rvgXogSuxgjaOrapoh+7hb8wG4OA7a637AUerA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40u5t3tnwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476Gshtc006385
	for <netdev@vger.kernel.org>; Tue, 6 Aug 2024 19:37:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13md222-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 19:37:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476JbCtx3998344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 19:37:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415805805D;
	Tue,  6 Aug 2024 19:37:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBBFD58073;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.153.213])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 19:37:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next v2 4/7] ibmvnic: Remove duplicate memory barriers in tx
Date: Tue,  6 Aug 2024 14:37:03 -0500
Message-ID: <20240806193706.998148-5-nnac123@linux.ibm.com>
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
X-Proofpoint-GUID: nFrLwu6tEIqVa4uGJcoj0KZ251-2YKGR
X-Proofpoint-ORIG-GUID: nFrLwu6tEIqVa4uGJcoj0KZ251-2YKGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_16,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=695
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060137

send_subcrq_[in]direct() already has a dma memory barrier.
Remove the earlier one.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 4fe2c8c17b05..533e79a0c6ac 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2456,9 +2456,6 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		skb_copy_from_linear_data(skb, dst, skb->len);
 	}
 
-	/* post changes to long_term_buff *dst before VIOS accessing it */
-	dma_wmb();
-
 	tx_pool->consumer_index =
 	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
 
-- 
2.43.0


