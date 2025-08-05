Return-Path: <netdev+bounces-211737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834EB1B64D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C183AB22E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D5275863;
	Tue,  5 Aug 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNf7mjPR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2820B7EE
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403841; cv=none; b=HHR2fqOc9tFauRTvMB6iUKBZIhwEqbMapwA+ifUDftwzLHKJpCj0zsgUmLluCZbBzxR6nWWSOeGsHhgdM08oKGlzt1X1alcc+48xhzZZUEDyLwjhp9eowkwJTDBXd8GnBBV+Mc5bEVWtGWP8QEfkA1noDsynEF4V0zYPPCWK2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403841; c=relaxed/simple;
	bh=7AsaHOKXLXTVp8yEnFb9kBWUGOwaJGcRIKzX/wehjig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LER6B5+4/fAEdPn+yrW5kiSqYI2J4/X2xnAFMOa0pLa87NmnCl9zX2T4e28sCqlSaXHqPedb4BubED8xJjwNzM9aC8bndWorWuaMZp84irF285jGmE7gv8qSXopHHhWqfqiUdaXTC/RjalyDaFlFutVITU1B7Po8TfGohjg1ZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WNf7mjPR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575DgDPJ007975;
	Tue, 5 Aug 2025 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=afTZ9f/1Kv9hLZur/SAw85tGhYSHN
	DRknQv5QNz4kF0=; b=WNf7mjPRwYXEuMJ8oPvRUarImm+QynhcB1S/QQ8whnn8o
	GAZ9B3CwtFziH2qhBaq7LcsfA4rW/MtLhfzpYM88cNiRbCM7Ge8NqhMDi6Z9wtbH
	xb5rqwI44ND9mPhdgHweRM9Fl//aqEsLFej+5DrMHiG6TP8N5Jl06TQmvjCnseqq
	BBnjj/TScWMHoPrn6V8Oa4QU92MiD5PmxJ+lX0TqxRuvSWWNTevsVSmKgjunW1dE
	YqfaxYcqEck5IMmCp5AxY37CoMPLNIk/pFiAptz949mIaN3o7P1A8hBTs/K/tLvn
	RGH7MBgsQtdavZ07bu2gTrXhaOmUYo97KdYbutzvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48993fvtyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:23:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575DsDGD017843;
	Tue, 5 Aug 2025 14:23:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jx9vst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:23:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 575ENaPP025936;
	Tue, 5 Aug 2025 14:23:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48a7jx9vjp-1;
	Tue, 05 Aug 2025 14:23:36 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: danishanwar@ti.com, rogerq@kernel.org, m-malladi@ti.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net] net: ti: icss-iep: Fix incorrect type for return value in extts_enable()
Date: Tue,  5 Aug 2025 07:23:18 -0700
Message-ID: <20250805142323.1949406-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050105
X-Proofpoint-ORIG-GUID: 47hjl_cP3wqkod0xnF_R4HHUsI-V0keY
X-Authority-Analysis: v=2.4 cv=bYxrUPPB c=1 sm=1 tr=0 ts=689213e9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=ZQReVaAHnRrKmcKX:21 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8
 a=QfqS0IvoF7k-OVw7uH4A:9 cc=ntf awl=host:12065
X-Proofpoint-GUID: 47hjl_cP3wqkod0xnF_R4HHUsI-V0keY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfXyw9K4j3TG5QY
 3qD2MYzORrEbWcXC887dEEp/QVTkNUg7FC+8Ou5/r78tChIyWYfBU7x3eddudVWHRLA32XeVIeW
 TRMrRHXUALYLKu/vzL8xMt2RRemfNstkDInyZdUKzYUD8+w5oqpj9O73OuyG8xBjL53Grzl1SR9
 Im2A7+orlhxFGnDJJtND8zmnFNThRBjkkxg45wZnI1KAqe9eL0QSjxkkPcRQh03YFuYh/S9xh/J
 XoJ+vCqfEzZvOeBaiCpLdLHLCLBv6pARt7SiSN967SR+JSlu+hRhXTGWrWqqpOX06Ey7hkjRKeI
 p53y4qg3BGpZD+/Gx3JZOcAQB+39plC+rpk9tVRmEzmyJ3ylAuoRzaUb/jjc3peEnM498GwOFYC
 oRoDBjNfwIkWuwfc96Fj8tkI3YNf4qm6v0p7x9j4AkohBfxvwU2QhNfzPf6u1KHu7gMr3pFY

The variable ret in icss_iep_extts_enable() was incorrectly declared
as u32, while the function returns int and may return negative error
codes. This will cause sign extension issues and incorrect error
propagation. Update ret to be int to fix error handling.

This change corrects the declaration to avoid potential type mismatch.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 2a1c43316f46..6d31c274281f 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -621,7 +621,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 
 static int icss_iep_extts_enable(struct icss_iep *iep, u32 index, int on)
 {
-	u32 val, cap, ret = 0;
+	u32 val, cap;
+	int ret = 0;
 
 	mutex_lock(&iep->ptp_clk_mutex);
 
-- 
2.47.1


