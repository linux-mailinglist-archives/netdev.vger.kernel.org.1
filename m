Return-Path: <netdev+bounces-218459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D30B3C87B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 08:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E41BA78C9
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA622153ED;
	Sat, 30 Aug 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojstmGQc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050291E47A5
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756535037; cv=none; b=uIr5chIaY9bNR3Kk193aGeBN97oQhUtwGlDtLydpthtzzjQ+HfUign41yCYBkaCSXeMnrASLwvs9xAYMQcEmqYvNxw2csjY+/5o0jxxBCGY4QP93JoakPND/Er1U7MzXIapSHqZiqVtaJpUZtBnrRb7dH4hV7YyYr7XxGWKDUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756535037; c=relaxed/simple;
	bh=pbSp8Q2+97lrsXqDPYWYOToPrimi/u8UGLEzZsq9/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgCgOXKnayUNo27ZrwYRdHZjJwyZ5Mw7VnLD2Kuij9XLgO0jmWqHk0FPFXvOw0fVOaH6alfn8g/yAil4Y7pggfjrgN9FwpNHosUFukz/etEmTIIVCb1wsaTsI5HiLlERdH3BBWLdIydW9DXl1zyl7Ckw2wDQ2xOFy+QXhfr4Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojstmGQc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U4EE5j018212;
	Sat, 30 Aug 2025 06:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=XNxhhV+4LB41xWI4lgiZZwEqzj/nz
	4eVYclJ9doZt4M=; b=ojstmGQccVUIhx3y5V552H06/DBaxIWnetjRysOIkRnFc
	Ey+XUAW4dBaGg/SPdbbxoe4Uf4/mzicUciYE2+AtBeLFxezF66BA5o2WvQeZT6E/
	Adt7aUWaAeH3LJqlfqI8knQB31bXY6K4Kxv2iB0Rq2XyPNdllspcpjUVMk2AU0w7
	A+8Y+zcrpbdB5rhz2YMUhqUKYY4GjRmgDxIUR9YuDHHzpCkzNgoTMXDU1KN9kpPH
	VrOoz+nB5sJ1lA49cwgQx/K80U+F4Z+FYCEor+d57CTGXMemYra06ATiUGWJuufF
	qv0H02q6BdTd8M1iOG3VsGDf4LF6Y/Q0+5Mstyizg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmn82g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Aug 2025 06:23:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57U3hlBQ004192;
	Sat, 30 Aug 2025 06:23:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr6ma5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Aug 2025 06:23:34 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57U6NYB9030452;
	Sat, 30 Aug 2025 06:23:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqr6ma5s-1;
	Sat, 30 Aug 2025 06:23:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: michael.chan@broadcom.com, jacob.e.keller@intel.com,
        somnath.kotur@broadcom.com, pavan.chebbi@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] bnxt_en: fix incorrect page count in RX aggr ring log
Date: Fri, 29 Aug 2025 23:23:27 -0700
Message-ID: <20250830062331.783783-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-08-30_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508300057
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b298e7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=Q-fNiiVtAAAA:8
 a=ngdfp8rUJ6vPqw3KiKAA:9
X-Proofpoint-GUID: yffYu-BryOO5KsL6al7hKoufV_sq1nWI
X-Proofpoint-ORIG-GUID: yffYu-BryOO5KsL6al7hKoufV_sq1nWI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX81ZieP4ksQva
 o1xMrg92wTS7qo4MJdqj1tMVyGwmQEyt7PSCQwu+ricfpGJSuFJdNtA5mNyem4NWPPDkUWJ8o0w
 NkYoa1MQanMYwn23VI2r3X5NjIrIajzT06F1gov0QL6Yt2WuO3ag9H7wMFJOLKtNZdxyzUwfenF
 gu64onqGaT9asu/pOLk+oIRJVH1TEN684b2mPOxi3dOdWAMAM0ROc2xXIXinROTcsk+parndb8V
 6jOOds130d/Rsn+8Soehim3neGCSn0DrKyDcf8urilEvIllCT7Xfn9C3sCW42Pe7kPnU/qhwui6
 raqHN90X2Hha4LpUoKJtv0hojMxvQIvj+gIUOGEro979uB1ckv1SlXDqnfWbU2DwWjrnLxSJwd9
 Gml34dAi

The warning in bnxt_alloc_one_rx_ring_netmem() reports the number
of pages allocated for the RX aggregation ring. However, it
mistakenly used bp->rx_ring_size instead of bp->rx_agg_ring_size,
leading to confusing or misleading log output.

Use the correct bp->rx_agg_ring_size value to fix this.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
---
v1 -> v2
Added Reviewed-by Jacob, Michael, Somnath
Added Fixes tag
Changed subject line
- Target tree switched: net-next -> next
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


