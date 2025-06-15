Return-Path: <netdev+bounces-197886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F59ADA26F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4674D3B0C3F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269D27A448;
	Sun, 15 Jun 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3Gilx35"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89298189F56;
	Sun, 15 Jun 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750002069; cv=none; b=iqc9Wvhn1GA4mvBUe9vGAOG+3NJ2nmV0i9Lpg76Sxr4EwhPZHXDPBw/Xre4r9nXKcId8JzkPKhqGtq5pBk7+H2tXh0M+c1H7nmIWeFFh2Gq8Ol+peHtMc6AdnMtqFKlaRUoVi3XVqdGpCFnytXUmPS3zCR+Ma/MgP/B6JXuubdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750002069; c=relaxed/simple;
	bh=ACD2c5XiMTl1/8iV/BJSYXEzFUIUhxeP9UcdzQGkmlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afAVjyeYyJuPJBkfYyoLbXQu3az8+mBGv1dtTjDuks9IjrbnlkRJ2mEodLNhs9nd2JVXx/VIsNKNmxNvGLjOwQcjiKS4o2fBm6NIvnds6AiRY9ApwqCiQGX+zVx8WFb5LKumsODOWL+vsznB4JJWO4C5yvFuiWGtzNE60ckjpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3Gilx35; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FFVssV015280;
	Sun, 15 Jun 2025 15:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FD71qapWxgJ5exCy9LbY8g0+dUBto
	c+BFfSsKBmZ3DI=; b=R3Gilx35vzMgmM75fbGusgR41/GnI2ziMxdbUTtbCiCm6
	8x7dELZFaAarA0OUOm+9v2UYFxpmSBBx41TuhaxAjSJ9ypLh7ncuJJOX+PJYOvY2
	apnk2G8QVPTjBHPyjV5jQvEhNsfEjw6fnM9GWbvJGMpETTSOYpUpWLN+0Un9ZfcS
	sjWX3qkjxAwVcTnPDAQ1aKoe7VjD1ItU6bcjzGQJ74Q+BpqORzMCNS8GH8aJYTCX
	Ew5WQcC9hRUddsZp9727ZSXPJbDGjHRJ73WMS9SXw4djhng+sEX8FWe9o2qnY2Xa
	6Eo9uVMv4NWyki/SRbyZtFDmim7DFGSP/06b6K67Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r0ddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:40:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55FBS88w000818;
	Sun, 15 Jun 2025 15:40:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh73wwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 15:40:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55FFetgA028210;
	Sun, 15 Jun 2025 15:40:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 478yh73ww6-1;
	Sun, 15 Jun 2025 15:40:55 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: netdev@vger.kernel.org, michael.chan@broadcom.com,
        pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alok.a.tiwari@oracle.com, darren.kenny@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt_en: Improve comment wording and error return code
Date: Sun, 15 Jun 2025 08:40:40 -0700
Message-ID: <20250615154051.1365631-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506150115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDExNSBTYWx0ZWRfX74AnHnA6vFYi KlXrZwTASZWnCMEJy5bNsobfK0yAfE3pLENFa6ZRaYmTipPQpC7hC/fc/BEUpIeqppNNsYEx+Qd QG8xaM4yhy2wM6cHh5IODwFdaOOGOfvWtILp53u1da977g0bKZwf7nZhNcSm53hbOSTs25M4mvC
 Vvtzu0q+wTv+TPBwCV9kSJqfofu2cCWZxwkef5oLLDADM9DR3PJqip17aut4nvnRcda8xG8cssw 7JhHhs7Xh8qf6DsfzBxzjIeyWBHbP9GHMMwCf/ZvUr5xGUEFvHqLdkKzH0+uyfnN2QfdP6Oz2da wy+yoIqBIDlaPjOlHUgRuZwFj1I8MjAvuMVrvsO6IIPhq/M8ilD6oA9woz2F1iCEVsbslo9eRYO
 69Yd3ptMS4jnB1C1qMGTYc4O/ZVNgoHJpGuuG1iMP5b6qAE+EDN9mE9QB4vx96NQXPN4S0NI
X-Proofpoint-GUID: 1txj7uUi4vwW8BOU4C_S-2Cp62koCfOT
X-Proofpoint-ORIG-GUID: 1txj7uUi4vwW8BOU4C_S-2Cp62koCfOT
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=684ee989 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=I_VNuqamIqGh25PhsTgA:9 cc=ntf awl=host:13206

Improved wording and grammar in several comments for clarity.
  "the must belongs" -> "it must belong"
  "mininum" -> "minimum"
  "fileds" -> "fields"

Replaced return -1 with -EINVAL in hwrm_ring_alloc_send_msg()
to return a proper error code.

These changes enhance code readability and consistent error handling.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 869580b6f70d..00a60b2b90c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1810,7 +1810,7 @@ static struct net_device *bnxt_get_pkt_dev(struct bnxt *bp, u16 cfa_code)
 {
 	struct net_device *dev = bnxt_get_vf_rep(bp, cfa_code);
 
-	/* if vf-rep dev is NULL, the must belongs to the PF */
+	/* if vf-rep dev is NULL, it must belong to the PF */
 	return dev ? dev : bp->dev;
 }
 
@@ -7116,7 +7116,7 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 	default:
 		netdev_err(bp->dev, "hwrm alloc invalid ring type %d\n",
 			   ring_type);
-		return -1;
+		return -EINVAL;
 	}
 
 	resp = hwrm_req_hold(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 5ddddd89052f..bc0d80356568 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -823,7 +823,7 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 	int tx_ok = 0, rx_ok = 0, rss_ok = 0;
 	int avail_cp, avail_stat;
 
-	/* Check if we can enable requested num of vf's. At a mininum
+	/* Check if we can enable requested num of vf's. At a minimum
 	 * we require 1 RX 1 TX rings for each VF. In this minimum conf
 	 * features like TPA will not be available.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d2ca90407cce..0599d3016224 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -1316,7 +1316,7 @@ static int bnxt_tc_get_decap_handle(struct bnxt *bp, struct bnxt_tc_flow *flow,
 
 	/* Check if there's another flow using the same tunnel decap.
 	 * If not, add this tunnel to the table and resolve the other
-	 * tunnel header fileds. Ignore src_port in the tunnel_key,
+	 * tunnel header fields. Ignore src_port in the tunnel_key,
 	 * since it is not required for decap filters.
 	 */
 	decap_key->tp_src = 0;
@@ -1410,7 +1410,7 @@ static int bnxt_tc_get_encap_handle(struct bnxt *bp, struct bnxt_tc_flow *flow,
 
 	/* Check if there's another flow using the same tunnel encap.
 	 * If not, add this tunnel to the table and resolve the other
-	 * tunnel header fileds
+	 * tunnel header fields
 	 */
 	encap_node = bnxt_tc_get_tunnel_node(bp, &tc_info->encap_table,
 					     &tc_info->encap_ht_params,
-- 
2.47.1


