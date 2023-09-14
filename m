Return-Path: <netdev+bounces-33972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BA7A107A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31359282643
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C7E266C7;
	Thu, 14 Sep 2023 22:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345A241F8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:03:02 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B632120
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:03:02 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EM1V2P012412;
	Thu, 14 Sep 2023 22:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g310eJVPH+nXcYI11Pht0kGIzprw56k0BiYraYq4Kmg=;
 b=WpSNKAaA4NJjh4vCFqbQcdN+BOnrxtf2DDD0IHmhYz0mpWLfVdsP1OiUXdJ4SHj+Hx/T
 v/7WPAHox66mq1BPno/KDw8hBjl5CM4JIplX7N/M89s/8gSasyJCSPofV9zE+v1sjHfy
 qM/xcsdtORFSQSyIJM947dRpVhu6mjqzFiBvGpn1g9aoNqemEJoSmwJZNE7pqVEHGESk
 8AIFj9lchkDvbQQv9peFTKksd7LwgPECSUJA7y6S50AMQbrsMDJ4y8PQodIKwg5iiufJ
 EX2YOLie9yKRvQiVIM/kPLtgotnzFbiA1N24BaL1TxjqVCJhUL+DQG8gbnh+yuQoMqby Ug== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4akx02vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 22:02:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EL5ebK002752;
	Thu, 14 Sep 2023 22:02:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hmdxmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 22:02:55 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EM2sim37749118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 22:02:54 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C632A58063;
	Thu, 14 Sep 2023 22:02:54 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43A0A58059;
	Thu, 14 Sep 2023 22:02:54 +0000 (GMT)
Received: from ltc19u30.ibm.com (unknown [9.114.224.51])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Sep 2023 22:02:54 +0000 (GMT)
From: David Christensen <drc@ibm.com>
To: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io
Cc: netdev@vger.kernel.org, David Christensen <drc@linux.vnet.ibm.com>
Subject: [PATCH net v2] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
Date: Thu, 14 Sep 2023 18:02:52 -0400
Message-Id: <20230914220252.286248-1-drc@ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8a2EjL4vM2AHtU6mAxOeujuKEbherPD_
X-Proofpoint-ORIG-GUID: 8a2EjL4vM2AHtU6mAxOeujuKEbherPD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140192

From: David Christensen <drc@linux.vnet.ibm.com>

The ionic device supports a maximum buffer length of 16 bits (see
ionic_rxq_desc or ionic_rxq_sg_elem).  When adding new buffers to
the receive rings, the function ionic_rx_fill() uses 16bit math when
calculating the number of pages to allocate for an RX descriptor,
given the interface's MTU setting. If the system PAGE_SIZE >= 64KB,
and the buf_info->page_offset is 0, the remain_len value will never
decrement from the original MTU value and the frag_len value will
always be 0, causing additional pages to be allocated as scatter-
gather elements unnecessarily.

A similar math issue exists in ionic_rx_frags(), but no failures
have been observed here since a 64KB page should not normally
require any scatter-gather elements at any legal Ethernet MTU size.

Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  |  1 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 6aac98bcb9f4..aae4131f146a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -187,6 +187,7 @@ typedef void (*ionic_desc_cb)(struct ionic_queue *q,
 			      struct ionic_desc_info *desc_info,
 			      struct ionic_cq_info *cq_info, void *cb_arg);
 
+#define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
 #define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
 #define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 26798fc635db..44466e8c5d77 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -207,7 +207,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
@@ -452,7 +453,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		/* fill main descriptor - buf[0] */
 		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -471,7 +473,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 			}
 
 			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
+			frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
+								IONIC_PAGE_SIZE -
+								buf_info->page_offset));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
-- 
2.39.1


