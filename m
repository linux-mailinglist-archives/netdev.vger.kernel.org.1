Return-Path: <netdev+bounces-207170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A915BB06198
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3335C5027EB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BB253356;
	Tue, 15 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REd6qW+s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CC246BA1
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589911; cv=none; b=NAXL3zFN5Ok99H4qq0QQ0qaTqhSl0LjlA17wMFYsKVlybuYMATbEp7ZUN0rm81uCmb9pF0clgHsNW4oaEM4fs/DOHbcO866IFex4IsiRIdLUVImKQaASQImfp/K1goEv1ZxY/qPFUw0rr4vohM/+lTdtsniNxpJTyljzNeyIBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589911; c=relaxed/simple;
	bh=pPc9K1zPwNQ2SyKo3CD4vW82JEngmf4m4SBpD25eocw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akVO8BrQYCUnS4FSSp9MjVutm6gqBvcZM15xez+7W3NWZmRGO4wj/35iYByjIJ4n5a3v1y1F20tRVMSMxSgsdV7/3axxaM3iv3sFgluJkND3+bU5Uwacm0edJ4ywa0OGYmBaFBU9xeHj/1hlh5m8UuBniMoZV26Nk6tqRLun2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REd6qW+s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZCCb003484;
	Tue, 15 Jul 2025 14:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ldbJHSGD6BN1tNm6JoquLLyny5cpn
	WSKdxNIJd0j03I=; b=REd6qW+sb+kmKnx6614RWXCTVg0BPjgC6zke0szCjLoSg
	/UmTm7fKZ07+GKrj6qBW45uVxwxOb8AvS7Xub78zLu2Ux/GfSiDDfzT/bP/Qky2S
	Ate2pCo43c+GshO/pNbUdX28RKooljTAe8pEjant68ZdnsZMrDxeraKPZ1JvmzMk
	ijaMBCtEiEgXLoxhmnP8GuDyz5tXRkmAMZnu1/oLuXL6B6tc1rsdK5hVIAhMYL2g
	27WdCnts69IAE4eQzhs4S5K0cv5p57+cnsqpQ2aJPmxlsC6rKQWPlNIuE3hzfSTe
	KbHUYHFY6lQ+w6KQH77qD8Gsfu/w4daP8/gsM3v1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7y0sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDkV2B039729;
	Tue, 15 Jul 2025 14:31:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a2mmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:31:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56FEVXSX003538;
	Tue, 15 Jul 2025 14:31:33 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5a2mjp-1;
	Tue, 15 Jul 2025 14:31:33 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sayantan.nandy@airoha.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2] net: airoha: fix potential use-after-free in airoha_npu_get()
Date: Tue, 15 Jul 2025 07:30:58 -0700
Message-ID: <20250715143102.3458286-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150133
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68766646 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=OuZqvr71sMSAxPmhYTsA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: yq85vw0bhCZ9pqyw5f9UCXT-YXd9hfet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMyBTYWx0ZWRfX3lXcLIo5kx/O Q/PXuvI1OaA1ufqy8ECfGaZ6oarJI4vX77QsAgAx0s21XJVbIdN3wcN15n9xvDRILIG+RrcKJa+ J2Y14NXBdmOfmNJgbIR2YvGr3gvDKP4aDIRRj04iYpgNjj9+csBc7+ygOUEqdNyb9e8E+p141dR
 bWYu/LgItRg8HBYDHKmAxJsub4ypZ+YLXcbF815NZfuCeAunMmxBLOkVqYYbxO0jgQFbkYRWsKB Lp7L9Y3erWXH6+cUbawrIQg8syZSe1N8Oh9sZwloolD0pHO3NvIgPCdL0GbDLXbGUQocSBEbQsd 4E6u5QPvXdXU4ASSZSzB1yysIq3oW86xCbQAOn1idjRagGxeNChpjWPkcbHxcIwQWFMa2nsEZoK
 trdKqZLUC+DlSIKOzpv263BprOWBn2/fDjopK39l/J6GVB3mQNenJZlORcYJmScmP2LI0ryy
X-Proofpoint-GUID: yq85vw0bhCZ9pqyw5f9UCXT-YXd9hfet

np->name was being used after calling of_node_put(np), which
releases the node and can lead to a use-after-free bug.
Previously, of_node_put(np) was called unconditionally after
of_find_device_by_node(np), which could result in a use-after-free if
pdev is NULL.

This patch moves of_node_put(np) after the error check to ensure
the node is only released after both the error and success cases
are handled appropriately, preventing potential resource issues.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1->v2
call of_node_put(np) after printing np->name, as per Andrew's comment.
https://lore.kernel.org/all/555d7fb6-091e-4c10-bfea-85898e644481@lunn.ch
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 0e5b8c21b9aa8..1e58a4aeb9a0c 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -401,12 +401,13 @@ struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 		return ERR_PTR(-ENODEV);
 
 	pdev = of_find_device_by_node(np);
-	of_node_put(np);
 
 	if (!pdev) {
 		dev_err(dev, "cannot find device node %s\n", np->name);
+		of_node_put(np);
 		return ERR_PTR(-ENODEV);
 	}
+	of_node_put(np);
 
 	if (!try_module_get(THIS_MODULE)) {
 		dev_err(dev, "failed to get the device driver module\n");
-- 
2.46.0


