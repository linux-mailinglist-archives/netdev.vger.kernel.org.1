Return-Path: <netdev+bounces-152098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E31A9F2AAE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B21884707
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5F1D318F;
	Mon, 16 Dec 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="io9goq7D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57601BB6BC;
	Mon, 16 Dec 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332758; cv=none; b=HFQd3tUZUj4TDGqZAubFG9MQO5kfqgIbAzkmctyzVCr/1qcF++iGTFHRnx2wYDSKwtB1jVg5s/qQDtxQRMTlFc6kBEdyNWbTVVUAHGtIKmH/LWiNrlMUBDQL1E3QhEK/v9bFzTQPXn5gKeJjbaG1VQc46f58FNaaNBQXA+gDmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332758; c=relaxed/simple;
	bh=issfuf4wRr6bIR63SXq9Ky2iM2b3TrVkX+UiX0Z9ezU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKB3mZ7mpQF/LQdN0eictcBymZYssgbuRNGvY7zWmnLCBzqOw6y32jvU6wsClinBi3EOOQG3sDIGUbN5NoX0OLTNYJpUe84dSUWnH7OBXTCFN9cXW7O4C4ef3joDhGzZSodxsWNo2ILSIJ59Sx1UAOHrjlsFg0AHQHpRM7/kTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=io9goq7D; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6asDe024861;
	Mon, 16 Dec 2024 07:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=hthKk
	6JFJyBVcNcGhKJGzXok2nU3dn0y9po0Og2V9X8=; b=io9goq7DzD0h81mQlrCHO
	63wz15BVETnrK3aKOwkT5ty/TFowaW2K1JjHIt+etEofMLfSZhIhEOFUbdENmdCo
	kgVmV+cpnVS5yVw4F2nLgzW40YWAOIJ6zRmvBAZBJv7guFHnXVb6up5i9mgHu071
	JhgYyp2mq5wyNcy4QMJgimAvsQKUkxSYbkz5sTjiqvO62S6YvAMpNGp1nvbz1Pdk
	aCOUSy/yD3+AEdyg4416oD4rmy7TZDoDLaeJLmPhkp9I2WX33dwRFEHpU0515MTa
	s2hlK0OxqXoPI8j/AD4vzm/RjkodEiFi9ihY6g2+vy8m7o9NEuts57KbHNtrDRJt
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt2g7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:05:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG66hBK034862;
	Mon, 16 Dec 2024 07:05:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6pnmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:05:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BG75Nut002855;
	Mon, 16 Dec 2024 07:05:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43h0f6pnc5-2;
	Mon, 16 Dec 2024 07:05:37 +0000
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
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH next 2/2] octeontx2-pf: fix error handling of devlink port in rvu_rep_create()
Date: Sun, 15 Dec 2024 23:05:15 -0800
Message-ID: <20241216070516.4036749-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
References: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_02,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160057
X-Proofpoint-GUID: S6sY--PTTWxkQ-poxcwApZwQKpUzyU6g
X-Proofpoint-ORIG-GUID: S6sY--PTTWxkQ-poxcwApZwQKpUzyU6g

Unregister the devlink port when register_netdev() fails.

Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is from static analysis, only compile tested.
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
2.39.3


