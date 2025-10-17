Return-Path: <netdev+bounces-230579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35037BEB644
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E990C3BA5A0
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E72FC01B;
	Fri, 17 Oct 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5W26Oty"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BED2FFDC8
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729750; cv=none; b=UZfsEmMViGSQnoHTT5Y4L85zsucq+wO0yAVvfaCpGmIfos6nVo6iWdH+L4kwtd24biwyp4zmWn9DugslKLjIAd4LIrvZjHTy9W7VImyOE+DVH41WK6iP+l2ozEryGxYqzW9Jsf8bykPhwJoT/EWQhDoG06Nerobffx5p25PoSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729750; c=relaxed/simple;
	bh=lHUS07uIm8oGOlrzclYnfRMC2yOVwBFSChAU3anPmDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkRjlIDKlXIGYF1K4o0SScyrPRM87bR9akhdN2z8TNIZLkYXCRQVRVF/yafCQd66C6Y5QKnVUYod3qY33sNpUQ1lVzaBufG2mNPW01UdDn2LE4jEcIShOmhV3tBmYjjiXwypV1fw+WxlykMUThxFiePmj3dSvaXREXz/l9xLumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5W26Oty; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdbW6014080;
	Fri, 17 Oct 2025 19:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VDofITKn4jBZUHN5FlZGELEg2U44C
	gPmOTJfRGvDkz0=; b=I5W26Oty/CXAlzyjGW3lIzJi+TD3CQ69ktJiZ+/UF6Ac/
	lrQIMF/7tOghunZWAjUpdeQBNkOsTjPE+ilT4rJrxNPWWBXk327m9q2VTRInjaN7
	662BMbKeO1RDvrAFllwrgFyF55IazQrv5zhO4QKS6z1Sg84jx/UVp+l8Ugx1HYyr
	nsI/wrfbgH5OkgTsdPKZnDfS3iGbmlBiqXRkyRGkYvBQkdH7uLEsqfrCwBqq986t
	m5/EVHseYRhM1TtE7mnTXfgJQlksBQi6+Rc0W8qpZfLYtrceMmKerwZ0bNUg5rb/
	CJQZ3cF8onxWtKXKxKGm2ccRNwIouwRRXtxVl2zEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c3qgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 19:35:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJNESj002326;
	Fri, 17 Oct 2025 19:35:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpkg5tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 19:35:30 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59HJZUVN017300;
	Fri, 17 Oct 2025 19:35:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpkg5t3-1;
	Fri, 17 Oct 2025 19:35:29 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: hkallweit1@gmail.com, andrew@lunn.ch, kuba@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH net-next 1/2] net: phy: micrel: simplify return in ksz9477_phy_errata()
Date: Fri, 17 Oct 2025 12:35:20 -0700
Message-ID: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170149
X-Proofpoint-GUID: uico2pkeUbnPgVypnGePExTFayZNV8hQ
X-Proofpoint-ORIG-GUID: uico2pkeUbnPgVypnGePExTFayZNV8hQ
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f29a83 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=fxyIGaWVqRnF3hTsbVAA:9 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX2LzC2C7IQMtG
 6VEhKRMVoS4o1IrUQ7sbTsm/hMrdnXj+uMgKTjINVQ/cSI3owNTe37FyhzXJuVGz43fH0Un4vZD
 yrBwbDMBHiA/jWvm5JRi03VjYW1sPorFFAEC6gK+q4ZmrCG/TUeP/YTXeoGm3/bQY738FktDwN6
 T6HJv+mt6UqiLhAmN0tI1phy/fVYFAyQyKim0nV7Maz2tTR2/a2M+sXFoEtKceF37VhgViR2KLi
 6PqDVFjPcVSiRn3TdeYgbgLp0orriKP0hJ7oOawHx/k5yVmsc2mhwroR1HcQN1pdWU9g9pB44mD
 Y2jjYNBqLPZMfYlQFivPdmrRD/tkh00BR1rdj65cYbDGPnnJwRg38ad/dKc6Tr+WL6d1PBxx56z
 vUyU7LlcnTYhsQXXJqC7Wo4xLbXVnVhqOB0hyKYQX05XtkiPwMg=

ksz9477_phy_errata function currently assigns the return value of
genphy_restart_aneg() to a variable and then immediately returns it

    err = genphy_restart_aneg(phydev);
    if (err)
        return err;

    return err;

This can be simplified by directly returning the function call
result, as the intermediate variable and conditional are redundant.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/phy/micrel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 79ce3eb6752b..65994d97c403 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2095,11 +2095,7 @@ static int ksz9477_phy_errata(struct phy_device *phydev)
 			return err;
 	}
 
-	err = genphy_restart_aneg(phydev);
-	if (err)
-		return err;
-
-	return err;
+	return genphy_restart_aneg(phydev);
 }
 
 static int ksz9477_config_init(struct phy_device *phydev)
-- 
2.50.1


