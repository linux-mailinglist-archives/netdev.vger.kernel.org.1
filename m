Return-Path: <netdev+bounces-152097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB899F2AAB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87AA17A32F9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAF1CEAB4;
	Mon, 16 Dec 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQ/5qs/6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C821BB6BC;
	Mon, 16 Dec 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332752; cv=none; b=BePoPwK7TtK0vzVUFA1hdcEne4jJRcr8f01Sx3Pmp7xC9hpcGl+40e8otkRX3UsuYDPtSwGxIy0L692zrTes64biGKRtmgktv1oovKUyuKirS8qaGirrAw4L3YdmWVCedr6jItxfulIG5CwmcO5IfnwkHQJwbVYU1yjSfmsr6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332752; c=relaxed/simple;
	bh=4y3B6aMFn1eoenrkXnU3k2Tv5oBr5Nb8HQ53NLrFcW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHAfsCo1Cl3qKztN2a/13RLliGk9LUbHsfUiEK0vrvJrrAXsStzlnwq2nNB5pWGaSOvohcoE5eK3BuNyWo9ECP21RGRzMv/u4oJesJpsRASOQJBxdghqgF8ItKO7wBy3i492yW2lKyB669r1+DtNewzRfcHb2CP5i77IPK58uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KQ/5qs/6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6awKM010745;
	Mon, 16 Dec 2024 07:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=5Qrb2beLEr5QULPbn/VFzdqtBRamu
	KI5HzqWRZ6+Yg0=; b=KQ/5qs/6Eou2HegllwJ4jikwp51NhaiL2XCa4krRZl2Nv
	hHraoZC33gy4fSUfN1uYmFry4Q5EduWibhINkWxj0NpGKtlmydCYUXAeCqPZDT3E
	e06H1Th9mlz7EKJdINOg8ZULHseYcsRuXLFCZrrXhzDbeRm0TWdvTN/nYxz9jwNR
	qJtfDcXSZOjWmyiv8W7GqJLwvnePDdEo6xaJR+Sz2wZbbOpuEc2hNqxtOOfBUHQl
	jgvNgkClWeAv8y2HMIA/Sh8ZlPnol549PU0lxZyBLccMG2z+lcRJFSR3HVpN+rfa
	8aXZHaa6GFak5eupVG+Rb7u58x89jrmSMKvxNZvPQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj58cr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:05:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG51O6e035464;
	Mon, 16 Dec 2024 07:05:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6pnd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 07:05:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BG75Nur002855;
	Mon, 16 Dec 2024 07:05:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43h0f6pnc5-1;
	Mon, 16 Dec 2024 07:05:23 +0000
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
Subject: [PATCH next 1/2] octeontx2-pf: fix netdev memory leak in rvu_rep_create()
Date: Sun, 15 Dec 2024 23:05:14 -0800
Message-ID: <20241216070516.4036749-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.46.0
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
X-Proofpoint-GUID: 31o0SqpWJa3fVTuYHxnlauMSj94BYFdc
X-Proofpoint-ORIG-GUID: 31o0SqpWJa3fVTuYHxnlauMSj94BYFdc

When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
incomplete iteration before going to "exit:" label.

Fixes: 3937b7308d4f ("octeontx2-pf: Create representor netdev")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is found by Smatch, based on static analysis, only compile tested.
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 232b10740c13..9e3fcbae5dee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -680,8 +680,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		ndev->features |= ndev->hw_features;
 		eth_hw_addr_random(ndev);
 		err = rvu_rep_devlink_port_register(rep);
-		if (err)
+		if (err) {
+			free_netdev(ndev);
 			goto exit;
+		}
 
 		SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
 		err = register_netdev(ndev);
-- 
2.39.3


