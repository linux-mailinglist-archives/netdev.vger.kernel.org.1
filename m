Return-Path: <netdev+bounces-152487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0F9F42B4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EF47A618B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5567170A1A;
	Tue, 17 Dec 2024 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LSVeLXeF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09582165F13;
	Tue, 17 Dec 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413039; cv=none; b=XTwqPj7VGvzlx9Vh28zXPsSIgGEAq5UoGqwBGERAvFh3PG9p4ITZUFKJWuIqSo7JagAbUqgV4UmTc4f2smJF3P80D21X4DnBap6GsoNF45lW5JSis+94SO2WWjQoCHtgP2mDh7tLUrKgSj4+UJ6xNZXHpF4DbojpDgpH3y4aq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413039; c=relaxed/simple;
	bh=8dMVrCuNL7fB5HcLy6Kyr83WTz2E2XiO/yC9dAUUGVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsfkpASqamDsLiuKEQu2KUCSqibv1QOCzfezTe5AsJ9RLTXIS8ZOkVJde7jsRvByi+obPHll1cgF1+lr5iiqE8qRjXmt9365ghHcqhyfIvp43U7u1nUxoicTP4+P/xLJjmvPM1N+r76x8AExrxBt2mJf6F2WR3GxiVZUwfBTAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LSVeLXeF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1ugQv015901;
	Tue, 17 Dec 2024 05:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=o0oF+
	9G3PHCtMIvJGzxUvdhWwwQ8Ia7qj24MUNkZMtc=; b=LSVeLXeF1hGRIE/94Lajn
	RkZ2mudK4mIFVBGwOJxdKu4kiIWfdS9+oiDyGUjZVIcxGqkwZJfnAsS9Azsml0U4
	g11XFf8zXz7+sn7MW01ELcPQB2nw6fXukX+9HjQ2+b7mKt2EJooN57N2n5iJL1D+
	O/zD/pTsL3rSOExDFcwfkWsvS+CzxyBRe5M3tV+hljBMnHALfEuPQoGsrBRdxcOq
	SMcDZyFbxweNPCpNqopqkhAphWywp6bka3gK+6vMM8y2iHRsQGZAkjR5GOwvBq2/
	nyxLoUbv1sjo1FTNy50cvxUI5lDLPY6eJojVmWfhw9Fq+B6VrjTZrU+OgDhBHSFC
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cn5cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 05:23:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2n0fs032680;
	Tue, 17 Dec 2024 05:23:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fe76kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 05:23:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BH5Nb9p019585;
	Tue, 17 Dec 2024 05:23:41 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43h0fe76e5-2;
	Tue, 17 Dec 2024 05:23:41 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v2 2/2] octeontx2-pf: fix error handling of devlink port in rvu_rep_create()
Date: Mon, 16 Dec 2024 21:23:25 -0800
Message-ID: <20241217052326.1086191-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_01,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170042
X-Proofpoint-GUID: kExxXB4qgCZh1j8x-q10VGHOw37H5T90
X-Proofpoint-ORIG-GUID: kExxXB4qgCZh1j8x-q10VGHOw37H5T90

Unregister the devlink port when register_netdev() fails.

Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2:  Add R.B from Przemek
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 9e3fcbae5dee..04e08e06f30f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -690,6 +690,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "PFVF representor registration failed");
+			rvu_rep_devlink_port_unregister(rep);
 			free_netdev(ndev);
 			goto exit;
 		}
-- 
2.46.0


