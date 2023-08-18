Return-Path: <netdev+bounces-28847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E7C781010
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617EC1C21697
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF619BD0;
	Fri, 18 Aug 2023 16:15:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246B19BCD
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:15:04 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14F23C1F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:15:01 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IGCM2G027513;
	Fri, 18 Aug 2023 16:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yOHjP/xxxfjqGPKzj2Z6homSb43GKmI4q7NAlaynQII=;
 b=ZsRE5HqpPIVnA5d+HTsDZxJ3QLyD6mUQULm6tzSBwUFWOGbHHQ1AeGDVnYniqB5CPRYk
 SC7WlzGkv6wW6APSDwJQGwQRS9ypn9FqzPcWjFwdaIXBHQAlphKLn0X7EljHwrXfBvgy
 nDtOLH6VUKIFj0RYjZ5ew5+G97mrCnUBMUHpMpZcD2Mkd3dsTKgNdtvz+2RnA0J75yO+
 npWuutOYGXPZFk6x2UtjKVMgxNljECfri5j8dQ5KDYMgge0TJvHU+hlnKMc/Z9mxmNPX
 NC3qkk1hR1znYliO1REYS3icPAQTGJXYAg43i1KmmTXJyQEtdL6vIRP1crrfcBeCcW3e Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjby1020g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:59 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IGDWru029996;
	Fri, 18 Aug 2023 16:14:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sjby101yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFq5uO002409;
	Fri, 18 Aug 2023 16:14:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendp0ahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Aug 2023 16:14:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IGEurZ31916530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Aug 2023 16:14:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89DC158043;
	Fri, 18 Aug 2023 16:14:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B15C58055;
	Fri, 18 Aug 2023 16:14:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.53.174.71])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Aug 2023 16:14:56 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
        manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
        skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [Patch v6 3/4] bnx2x: Prevent access to a freed page in page_pool
Date: Fri, 18 Aug 2023 11:14:42 -0500
Message-Id: <20230818161443.708785-4-thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230818161443.708785-1-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
 <20230818161443.708785-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AvaXrVCAVtw9TO0O8zU6wv3HzMHyB97V
X-Proofpoint-GUID: sba4wacCgRKVtJjOfFSmCCXCpC3PnAIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=740 mlxscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Verify page pool allocations before freeing. 
Fixes: Fixes: 523224a3b3cd ("bnx2x, cnic, bnx2i: use new FW/HSI")

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 0ad879a5af95..ca3ab06206b3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1016,6 +1016,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
-- 
2.27.0


