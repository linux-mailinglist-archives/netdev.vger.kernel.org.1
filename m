Return-Path: <netdev+bounces-32958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD979AC07
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AD71C209A0
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C08F43;
	Mon, 11 Sep 2023 22:24:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44023D9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:24:41 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429DA47BD4
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:22:41 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMC1pF003337;
	Mon, 11 Sep 2023 22:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MIysLhStdiujWuzi46a+Vs2E8oNICriG5rIiN72H/2A=;
 b=IWZj4a+VWegjehBAdPD8JvtK1SVqTaaRJMgtV3neiED31VKs5THzZhZcpJTWoKyvrLsF
 5HMlPyVE5Qyh4DyCR+7+RyYtTYM1+6pQ9IDplEgDNCgku70NcZfXgj5shxI6RuHLQE2t
 5XoeokTzfc+e59llKqvOe/Jo1Yk1xMwlQFkDLHjbnsYeAeA24QqiF69ndNJzxZhy40Yy
 BoNeYYCFQGXxcqnRiftMbBOz4k+c7JHNFVZPXVtX7C9u2iMMJY6mHNiaBOz6B+1kfVlT
 nbRVApB0yI55Zy73UFb7RO2Y5Bbl6jsJ9rOgGwRzyVaSlQ9nxJHZV652Kzp+8Q5Ek/QP 8w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2bfpr64k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 22:22:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMKASd002779;
	Mon, 11 Sep 2023 22:22:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkp2d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Sep 2023 22:22:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BMMJqF8585852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Sep 2023 22:22:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6456058043;
	Mon, 11 Sep 2023 22:22:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10A5C58055;
	Mon, 11 Sep 2023 22:22:19 +0000 (GMT)
Received: from ltc19u30.ibm.com (unknown [9.114.224.51])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Sep 2023 22:22:18 +0000 (GMT)
From: David Christensen <drc@linux.vnet.ibm.com>
To: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io
Cc: netdev@vger.kernel.org, David Christensen <drc@linux.vnet.ibm.com>
Subject: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
Date: Mon, 11 Sep 2023 18:22:12 -0400
Message-Id: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4dFKLqIn8DpNhlm6ED2WCCj3j70diaEG
X-Proofpoint-ORIG-GUID: 4dFKLqIn8DpNhlm6ED2WCCj3j70diaEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_17,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110203
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The function ionic_rx_fill() uses 16bit math when calculating the
the number of pages required for an RX descriptor given an interface
MTU setting. If the system PAGE_SIZE >= 64KB, the frag_len and
remain_len values will always be 0, causing unnecessary scatter-
gather elements to be assigned to the RX descriptor, up to the
maximum number of scatter-gather elements per descriptor.

A similar change in ionic_rx_frags() is implemented for symmetry,
but has not been observed as an issue since scatter-gather
elements are not necessary for such larger page sizes.

Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 26798fc635db..56502bc80e01 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -182,8 +182,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
 	unsigned int i;
-	u16 frag_len;
-	u16 len;
+	u32 frag_len;
+	u32 len;
 
 	stats = q_to_rx_stats(q);
 
@@ -207,7 +207,7 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
@@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		/* fill main descriptor - buf[0] */
 		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u32, len, IONIC_PAGE_SIZE - buf_info->page_offset);
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -471,7 +471,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 			}
 
 			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
+			frag_len = min_t(u32, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
-- 
2.39.1


