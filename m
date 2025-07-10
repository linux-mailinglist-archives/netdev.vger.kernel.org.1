Return-Path: <netdev+bounces-205898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5796B00B85
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA05B48731A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4F2FCE11;
	Thu, 10 Jul 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OZoBjmni"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437C27466C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172701; cv=none; b=fphbuRxV8ToJO64ue99P7IdgsDv25ZSiZN68BbmpvzzP6DNpChwDSTicvIjeFzKjKVpFFd0/EUKtsm49ai+EcFJPxXfpgsxpiVefQ6zflIllyS4xkYaL9lCAsG/J+Gyq7nbzFmYGH2B9NjnrYcshGeGZRxlkm/sh0iNhO23ZlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172701; c=relaxed/simple;
	bh=gNuRjSvtv+S06Kl+Z7YVyXAIfykFhDAEGNxCYXmGV+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XULpvyzk33/sAaJaSyQrowUkwG/YprBhtF1YfS0igyMGeM52zhXBDadEmVdih9Q8EvDu1PJSh4ihKNhVaPmTSs18xPE/2wAjy+2YPJ4mrIPpxqbsG5fubHEh7rBkZX7WuXbXExdCSkbgUPWCfbPzAlQCYETnuJ5sooPFjkgpyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OZoBjmni; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHYvKt013163;
	Thu, 10 Jul 2025 18:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Hii5oHNBbhd/DGcPkYXER2yINTnlL
	Ye0wc2T1VFJ/RI=; b=OZoBjmniWpcbERNu0pYYA6Mg81vv7N0pG0HwTTwtMNvpe
	eqeGRkgD2M6bRNWE2p9WXOqFY21Igw52m/N9mWEypcHpy7NN6UmgETZ4tjc7AGXA
	TU4zDPJJfQ2cDnBsB32yHlNf/8QahytPkrONA9ZBEmRYQ54qwB3dL9iLdwBEecCw
	IgTlj9VB1n8kxw2SIdekBkWQ3IAFOLMkiDN6pGxX+iFbcakSwyCRudFUXnav4YyX
	qVQQOW7/SbX9dL1VQVZTEVGda9ZxGfATSV6rbRDtO5BaQfd6qRgULjQOrxhu5rqc
	9F3om6ASnvdOT4GrNxH3Dmds98NMT1dU8Y4F2tyUg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47thwxr53d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 18:38:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHKqbi024387;
	Thu, 10 Jul 2025 18:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcw1h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 18:38:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AIc7AT011475;
	Thu, 10 Jul 2025 18:38:07 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ptgcw1g1-1;
	Thu, 10 Jul 2025 18:38:07 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, darren.kenny@oracle.com
Subject: [PATCH net-next] net: ll_temac: Fix incorrect PHY node reference in debug message
Date: Thu, 10 Jul 2025 11:37:34 -0700
Message-ID: <20250710183737.2385156-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE1OCBTYWx0ZWRfX/8thKAWyp/UE Rk1aMQZYkKgv7tcmOR48wYyVu65C6TLGX9jgMf6DInBk7i+qstVxG9mkNqBb7de8gfeKka48a8r lVGdF2+efBIQXhcrtoP8ZVL063qos6ZGYO+s3gUxBuzvr4CA3lfTKqG59si+LrLulmFsdAitm+F
 TwxO3CGEsxoXnnxsxwfZYALvv75GsexndyL/X8SVHlUQC7VJraSB3WvkiA6SBPCRducDtHONW4+ v9JWHlRojaiXPmdd0zL/IG2zxUlkHcnz46nUCnMwNNM9VN0nLbnLjb691CqnbsUS1skNpDTDB0/ Gg624duDoxHfr7MaJERX3dn0tZcRf06VOIFnGg72YFvIyAtYkrxRB0YyViDeVdiaOVbN9zHTZx5
 6vdUYqETHnng0mzDuLEx7moZ4hn1Rj6PNhrHsOQ+n3lLp5So8QASucqSJyKTIG+bIE7Fl3Zn
X-Proofpoint-GUID: mYAz9UZf535vcUQIDOddxYyDYPGK0iny
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=68700891 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=w5Q3M98bzMszbH52DAMA:9
X-Proofpoint-ORIG-GUID: mYAz9UZf535vcUQIDOddxYyDYPGK0iny

In temac_probe(), the debug message intended to print the resolved
PHY node was mistakenly using the controller node temac_np
instead of the actual PHY node lp->phy_node. This patch corrects
the log to reference the correct device tree node.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 6f82203a414cd..711ed9c2631b0 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1595,7 +1595,7 @@ static int temac_probe(struct platform_device *pdev)
 	if (temac_np) {
 		lp->phy_node = of_parse_phandle(temac_np, "phy-handle", 0);
 		if (lp->phy_node)
-			dev_dbg(lp->dev, "using PHY node %pOF\n", temac_np);
+			dev_dbg(lp->dev, "using PHY node %pOF\n", lp->phy_node);
 	} else if (pdata) {
 		snprintf(lp->phy_name, sizeof(lp->phy_name),
 			 PHY_ID_FMT, lp->mii_bus->id, pdata->phy_addr);
-- 
2.46.0


