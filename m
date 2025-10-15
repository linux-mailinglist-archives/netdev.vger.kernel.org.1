Return-Path: <netdev+bounces-229442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A159FBDC45E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC54189F141
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49D258CF0;
	Wed, 15 Oct 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAEBkWko"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6525BEE5
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497090; cv=none; b=F3S3T+IG77zBWHv2pUefEsKCKbVIK8Qmg4fAanVnC5BH3VhlCoMrifOOPlZyALvuNDuk6qUWxaVe6jsPYXC1zuk6wbbQbItmZkabTRA0HFl1DAnMfDocW3skJ0767ynQuzrGIyVuZFP0zm2RXLGk06fJRBPBYK/bS0JaYZwbtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497090; c=relaxed/simple;
	bh=adD1+d1nByFTU0CD1rT3sYqPIXxsnWPFWttWuAG1hxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ve9kbX0+liPKDW1i8fkGyWlPaV0sDeeBi/YsZ6JSfgPcF6PzwTbEcp3NBK2iGViZqiWzyfJ+a9yv63CkowrMLkPr5O/RgJIvzi1CpeQ0brBxPuhDr4UfOdAv1kXEqFnUlDIvQZiK3W33XTYHLK83M51RzGpmbF7zlXNjvPphs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAEBkWko; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1uD3k023722;
	Wed, 15 Oct 2025 02:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YQ2Hsip8XgMDRsmd
	qphhXOsMs8GrErF7TjnkM6m0ELA=; b=VAEBkWkouLsujMtO2kLVGGUGI/3NwxUy
	uvLnM59Ux3Rg/k+x23EL8E4R1L/6uII2xUgmjZXgYAF5XGZiZDPKfGjlMn3G2zWc
	Efo6mrSPzfhb2QacEnuEqFxSPiES5jN8yJZi0+oy57E+4/rezdLTYqEU6pokGsN8
	WOAbCSqTasJHKGKZlikLtCfFL5TZY0rIARkP+MDvvIMAssRCyKZ07/+32anZxXm6
	42tk0K6YpBp+yVHhU7q6CdVFHGATu1kMdOUrfz+H3maoEtzgq8zH1dDfAmlXhv1j
	jl1j25ps91umAfv3UkoTBWVW4OiAeR/btUYOTq+2YT1OCzHWbL9jUw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrwjka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 02:57:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F07gLE018002;
	Wed, 15 Oct 2025 02:57:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9gyuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 02:57:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59F2vrR7010093;
	Wed, 15 Oct 2025 02:57:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp9gyu4-1;
	Wed, 15 Oct 2025 02:57:53 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: Shyam-sundar.S-k@amd.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next v2] net: amd-xgbe: use EOPNOTSUPP instead of ENOTSUPP in xgbe_phy_mii_read_c45
Date: Tue, 14 Oct 2025 19:57:43 -0700
Message-ID: <20251015025751.1532149-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150019
X-Proofpoint-GUID: ZXAop9TeYwESSHGkWZHnY0V_c_5KUqgy
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ef0db2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=3eh59cdDJJsn2wao1y8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX+GPCeR6lE7ye
 lrdYRmowDA7nYBLDw1WbYSqSOaJSfGswRsb+BX2t/4bDuVAF4LlNyLfc3wDN6WSW146FHCkprSo
 y+TBuQnMcY6tDXMpx1h21BXtVAOoOH8bFCVBu8X4U16H4YzafiD8yRe+H+CwJVvtSDWIGYcfHMl
 7eJUpUVCmjBzFM8Y6wxfC0Hk/ipNIvmtsj0dAiF6LB8IO3uUeqQ5R1ON9LEM7oOeJUx9rz5IJ1s
 KWoZ8FsuM0AXvOJ83N+knI3wKmmCuCKzxFBg87b6CXRwTC5zeKuKKX7AoU2dPMCDt21UOL9hsCI
 /gl0dIrr8RUJaBx8j1V0IN0NGbT9SRMHOpOOBMj0z9RZS2nFl90E5c5kEHKNym1STvZjzgKYl2Y
 AAPU0KAb28jWJe3jK+Uc9jK9d5X9SQ==
X-Proofpoint-ORIG-GUID: ZXAop9TeYwESSHGkWZHnY0V_c_5KUqgy

The MDIO read callback xgbe_phy_mii_read_c45() can propagate its return
value up through phylink_mii_ioctl() to user space via netdev ioctls such
as SIOCGMIIREG. Returning ENOTSUPP results in user space seeing
"Unknown error", since ENOTSUPP is not a standard errno value.

Replace ENOTSUPP with EOPNOTSUPP to align with the MDIO core’s
usage and ensure user space receives a proper "Operation not supported"
error instead of an unknown code.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2
Added Reviewed-by tag and marked for net-next
remove fixes tag
---
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index a56efc1bee33..35a381a83647 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -668,7 +668,7 @@ static int xgbe_phy_mii_read_c45(struct mii_bus *mii, int addr, int devad,
 	else if (phy_data->conn_type & XGBE_CONN_TYPE_MDIO)
 		ret = xgbe_phy_mdio_mii_read_c45(pdata, addr, devad, reg);
 	else
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 
 	xgbe_phy_put_comm_ownership(pdata);
 
-- 
2.50.1


