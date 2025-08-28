Return-Path: <netdev+bounces-217976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C7B3AB15
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5042A1B230F0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56822538F;
	Thu, 28 Aug 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VNas6Vxg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913713AD38
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410556; cv=none; b=p8lg+umYUnpLTGCmTXoaxEwIp50C4OJetL5M2QcND0uLPIbFnq5yiR+3rtVnZmMDNT+DxgEh1wDJlwcNKLrS79g1qoBfwkPHfuAn5nytpadhPJIdobDD3k33IcBhyeB0xgFLLYqGfvzgwkBTBMAe+KMiVrnlCjuOeLd1EcC7otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410556; c=relaxed/simple;
	bh=fGJsitskjNuG5mGhWP63zK1qFjXgMDleamWsdzwKh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JxzS9gLO2QMtgNxS0PIK1STmIdcn2O85BGgGHhNVRhIZWJWxSHllE3btRcK1qpCKiB/6bX4njTHYIh60+5g1fkfWBfcFEw4B+XFq/13HJdxhXulTnfprimwuPzRfZ9vWo+Kc6GFsYUNR3Wo76lVFfAOk3UroGPJuyLQId14RDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VNas6Vxg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHNYIm006264;
	Thu, 28 Aug 2025 19:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=53uAywPxLjpWIyV07QsPsbQgGQ36O
	/ziTCSQUGiifIc=; b=VNas6VxgWppJu+TP36I40ih42UN5TTuvklwZg1uFMC+qy
	nT0VpQGcnFKZVcz3tbH2ZtBzCtb2wuLOedbM7HY7MGGZyZQ+ThM1CtJ0T+nZB+lS
	115UPLkUG2VzF8keXKNWilGEUJkvJDoAYrWioD+WLFdj1Ko8Q8JXAvZAIDjfihed
	oPBe5BF4rG0Cift85Rnu9L7oZK8Who82apDksj+WEaWHoetkbVPCf4HzW9YQrejv
	CjZG9q4gmTPq0hcKtEO76Nu0Konmq0d1XNOjphmkfPCXO66HAQqz3zwFU3azAmou
	/ScqFc0FOUw6eRjCtks4XTkebhTdqT8HpqIEXdjWw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q67919vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 19:49:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SIctgb005002;
	Thu, 28 Aug 2025 19:48:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cf8v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 19:48:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57SJmx1B005371;
	Thu, 28 Aug 2025 19:48:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48q43cf8up-1;
	Thu, 28 Aug 2025 19:48:59 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] bnxt_en: fix incorrect page count in RX aggr ring log
Date: Thu, 28 Aug 2025 12:48:54 -0700
Message-ID: <20250828194856.720112-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280166
X-Proofpoint-GUID: Hzdx6Suj1VyZUIcHgA9g0MRkgr6KEh1e
X-Proofpoint-ORIG-GUID: Hzdx6Suj1VyZUIcHgA9g0MRkgr6KEh1e
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b0b2ae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=ngdfp8rUJ6vPqw3KiKAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXzd7TQyfUhlO2
 t7IwzlRqVy/iiFtwibWBfAVnL9XivmVleL7a3Rc5gdDbLKpCRcA+nE9kHrXA8sDzvD7//5TDw39
 cUyTpyEt4Rgad0zQiIg5QyanEYqVA8sOraRqnjYpLXDcaG2u7spidYqbG0ogmpe82EqQlkQjv1k
 sEYi5hFZoVAXhIjHd9IFwNZ9qYqQVb6zqgPSc3F3eKE0F5erj1ToXI0zR8IaO9kbnQ9iz3zCZ98
 6Xz+PCOMfRLvFl4dBSCxA1XIKsikonwchO9EnEMRUUt9ao6hDNvGHVn7588eJIqLNJllngXs5Hu
 4HKGlTllDBryYeedLb2Lj3GcC3ATPCduHXEnwkaAN7Y3P0FfEfgxh3Q9zrIpYcWu5nplKCg5uat
 2YF8jh0F

The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
of pages allocated for the RX aggregation ring. However, it
mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
leading to confusing or misleading log output.

Use the correct bp->rx_agg_ring_size value to fix this.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 207a8bb36ae5..0d30abadf06c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4397,7 +4397,7 @@ static void bnxt_alloc_one_rx_ring_netmem(struct bnxt *bp,
 	for (i = 0; i < bp->rx_agg_ring_size; i++) {
 		if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_KERNEL)) {
 			netdev_warn(bp->dev, "init'ed rx ring %d with %d/%d pages only\n",
-				    ring_nr, i, bp->rx_ring_size);
+				    ring_nr, i, bp->rx_agg_ring_size);
 			break;
 		}
 		prod = NEXT_RX_AGG(prod);
-- 
2.50.1


