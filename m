Return-Path: <netdev+bounces-228885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B1BD5828
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762BA3B8E95
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBD29BDAD;
	Mon, 13 Oct 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uv729pU7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAD298991
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376000; cv=none; b=JIq81E2MEKSo4FTRVQM+zFJHaCRuQyofWfJ2aVyYyUYW+aE+bjzJCL8EA1n7mTqz1DTS/NaijKuptwfeqnkj6Gz5+N4N44yHTBfKIwsc/X7Szg4punDrgm1w5AmoJlFsK9A6S6Niq5OlNj3GvQiaZGU3NoO7TAPcdmM/9V1ElE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376000; c=relaxed/simple;
	bh=ChhKMoiWyisIzEnfRrD8YbshUi28xZz1qyNXzmv+j9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vk/mhsmKR8Iwp9wGBN0zFcnIpN0cacSJ/3S0naxURJ5zCvJKNh5PIMWXsntI38MPyrWijU5K4uyUjoynqQPiKZdutXJkNAGyJ6vHaT2KxAhIxZk6sfVko0hLCSkVq3oCPUR0fXIrejljek/e7MFPW4ERUa92WbhZ/elcsR92HfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uv729pU7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu3eT026298;
	Mon, 13 Oct 2025 17:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=lYiq+1JmAEI6qGvM
	+X5d7jCgC6y9CCfdCCNO40Tb0WA=; b=Uv729pU7Coh41EcZ568VxgY0FxPyjYqZ
	QuRpXpne/k+j3Q3spoWCDrp6JHtPgcxN71CZcoUao7gUgxCcLGnyVvkkeC1m4UcZ
	Oe7xngGedUJqNV0MvwKLuejXDSJqSM3joCIWFoE0vtOWXmfKvllQ8GX70qUYxgBQ
	bwG+f863Ac2JIcIzTTzA9MVocet6BHQeoQQsswlnk0XSjo5zjBDfP+omgSpRmMX+
	YO3z0lfCkAnyygf5c/ALNW2YTBuzo61iKbakjVs1L1/5BAq4hWFlb3Ah4aDDrHro
	oEY8hcdk+6b/Q9Q6fBE/B0Ch3pkpi9enSNtZS/xMIr6k1DMpciOE3A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyjs6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 17:19:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFl66h017433;
	Mon, 13 Oct 2025 17:19:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7kk76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 17:19:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59DHJa0O003791;
	Mon, 13 Oct 2025 17:19:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp7kk70-1;
	Mon, 13 Oct 2025 17:19:36 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: Shyam-sundar.S-k@amd.com, kuba@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] net: amd-xgbe: use EOPNOTSUPP instead of ENOTSUPP in xgbe_phy_mii_read_c45
Date: Mon, 13 Oct 2025 10:19:28 -0700
Message-ID: <20251013171933.777061-1-alok.a.tiwari@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130080
X-Proofpoint-GUID: aykzky11LoEEDwhRRNmrvHp-s7Npp79R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX5kBiHtweYIcX
 9D2Og3IxMoZZDrFcAgEDACqmQJPvgymeu7XGsguk2Z8Bz2hzY3JAo1Pt1l3rfP649+qloO6CaJO
 M+zc7J8vWxvkDd4ZoXDm+VK32DYTFF+i+LqGM74utjjxAiDrPHORqTb5swn26RS3cgdwZ62RlsJ
 58n9ZUMPlHFDWBNZnqjC/vAMbmZtrEg0/4HRa6q2jKkiEf2pKYTBquXIYPtz/DjMc4rYD3ryyX9
 hZxdGUfuTDiAwWzCJnauwGeFebm57o2drubcWUbEVljqUSIi1GQHqsNFgl44+W0PhuY8S94tjgL
 IJiPLAvwgK4s8AdnirjFf/dUgHsD/DQiIyf/hPEZwGCdWR0XtDqsFtNfgk0zRiuuAYdYdoriE56
 dsWZD6X5rGLGRcWhOLpL7HRDjxYAvg==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ed34aa cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=3eh59cdDJJsn2wao1y8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: aykzky11LoEEDwhRRNmrvHp-s7Npp79R

The MDIO read callback xgbe_phy_mii_read_c45() can propagate its return
value up through phylink_mii_ioctl() to user space via netdev ioctls such
as SIOCGMIIREG. Returning ENOTSUPP results in user space seeing
"Unknown error", since ENOTSUPP is not a standard errno value.

Replace ENOTSUPP with EOPNOTSUPP to align with the MDIO core’s
usage and ensure user space receives a proper "Operation not supported"
error instead of an unknown code.

Fixes: 070f6186a2f1 ("amd-xgbe: Separate C22 and C45 transactions")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
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


