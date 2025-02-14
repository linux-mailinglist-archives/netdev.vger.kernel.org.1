Return-Path: <netdev+bounces-166491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4FAA3624C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAEE7A3BAA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94A267387;
	Fri, 14 Feb 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JvLFmTVR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DE245002
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548375; cv=none; b=Vvy9njazuD29bJ9Ote7MFSCNFRGAVcjrgcXbTrVSLKnUUs5KYtmBDGmp7RE0vyXv+mfTKfgXEprXjSI8WZEKILSY4LKPS82mZiJLJTpRX0aNAJhfSefqnc81udcDFUtSHgbmSlPZ8U4Whr1u4jtuI4sKcyq01Es30SP4Nsvsgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548375; c=relaxed/simple;
	bh=XYCM4Qn0sBWmedzQsZgmy7RBwJAb+ClCBo73YWIhMVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uasAfIlqKQ0cyO2VYbTgIEjn9USYUkIJRp9Be0obbt2bIvvIh4XotBwu1Dst9FuPkGp1G/o7gnsGG+8DGiIwX/zUuAHp1Zh/dy98zhTixpp8FbB2GZ3OgYJRCK3/+b/pkXSJntk88n6OOG7X3mqr4b48rSRysGrbaP0kko7Twlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JvLFmTVR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EDWJSL002535
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qFl9vA3GuXbD+UjIwRJYmAtB0ot91W//9W8HG2Svj
	lM=; b=JvLFmTVRnlscJ4D8j4T5vTItJAeSthOd1rmNWxgz+I0gnFlYX8ELEtyua
	QVwYNhLhlf+zb32RSjtd8D8bxn3yxl4l8+tzlJLVdwm/Zti5IKWlKkrTkZ3rVFYI
	LkfzmiCA5cdiQW0z1Fu/mZ0Dxj6EZsevWhs4xfY4QAp7ykfDM1bLeUA8sHE1NEbP
	3r4sqJDd3UC1WZRNRUXl4EJhi1T/6jjp5DXyrED+1DGE6R1TBMqLx457YPmeAbyR
	P+Hwk6UOI4UsWih30F5Yj4p6QumdViBbcUU2huBLtixiDgbpKngkUCwlcmHEJ32j
	JNxyvidxMoo3/tFUXL64Z53e6G2sw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44suwa3qjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EFRX8R001355
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknmask-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:52:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EFqlxo8978944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 15:52:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA2358055;
	Fri, 14 Feb 2025 15:52:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7769D58059;
	Fri, 14 Feb 2025 15:52:47 +0000 (GMT)
Received: from li-4c4c4544-0047-5210-804b-b8c04f323634.lan (unknown [9.61.91.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 15:52:47 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, nick.child@ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net] ibmvnic: Don't reference skb after sending to VIOS
Date: Fri, 14 Feb 2025 09:52:33 -0600
Message-ID: <20250214155233.235559-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m-2g1yeAZd5RjdprmnZc8vkZxu27VexK
X-Proofpoint-ORIG-GUID: m-2g1yeAZd5RjdprmnZc8vkZxu27VexK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=430 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140111

Previously, after successfully flushing the xmit buffer to VIOS,
the tx_bytes stat was incremented by the length of the skb.

It is invalid to access the skb memory after sending the buffer to
the VIOS because, at any point after sending, the VIOS can trigger
an interrupt to free this memory. A race between reading skb->len
and freeing the skb is possible (especially during LPM) and will
result in use-after-free:
 ==================================================================
 BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
 <...>
 Call Trace:
 [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
 [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
 [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
 [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
 [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
 <...>
 Freed by task 0:
 kasan_save_stack+0x34/0x68
 kasan_save_track+0x2c/0x50
 kasan_save_free_info+0x64/0x108
 __kasan_mempool_poison_object+0x148/0x2d4
 napi_skb_cache_put+0x5c/0x194
 net_tx_action+0x154/0x5b8
 handle_softirqs+0x20c/0x60c
 do_softirq_own_stack+0x6c/0x88
 <...>
 The buggy address belongs to the object at c00000024eb48a00 which
  belongs to the cache skbuff_head_cache of size 224
==================================================================

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e95ae0d39948..0676fc547b6f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2408,6 +2408,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	bool use_scrq_send_direct = false;
@@ -2522,6 +2523,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -2614,7 +2616,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
 	goto out;
-- 
2.48.0


