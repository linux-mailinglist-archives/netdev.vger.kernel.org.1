Return-Path: <netdev+bounces-152486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CB9F42B1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D4F188FA5D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1B14F135;
	Tue, 17 Dec 2024 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bViq+Wzf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EE13BC18;
	Tue, 17 Dec 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734413037; cv=none; b=k894jHt1si3Cn5EZ8bkQktBvOwbzu3w+XTlbQQ5cOUt58x5pqC5mwY0B9q45pN+s/ZCmHJfZnoW2nRx1HGC7nxiIuthaJM0rHMXrW0+GBgx7F1LccxcSx59powqtswrCAElQCTgM2D45AyEzybriPawU5QKmipKVWl0kSrB42Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734413037; c=relaxed/simple;
	bh=3s+0u4xd4GmR1sqz3OLBDTkSUWqK+I+fbJYwRbzSKEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcpZWflxVITDNEezqUD3lr8h8FdJjmXYvcOlx37NVWJfAEUqJyjH0vXkvYnYLlK3z76sn8a0LE+BVvOSsMkhzxWx/q4vHZJmapR1wWTPS/kfNYclH65bkLWtptp3gKDOvFaowhq5AhIcE55r5ynpdgMSlcfv7UHFQSH7s0cj0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bViq+Wzf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1tujx011210;
	Tue, 17 Dec 2024 05:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=R/mA3PoDoSR2Tz4MWnyVegA3EQUHc
	WBcFN+6dNs1SXw=; b=bViq+WzfzvCRsBghAJEYpiot8d6v4vMQ5GDiWdOxh5BEj
	EV3y+XXbWBb8e4KQhAeMdPDybQbMnu5+MhsOR6tW6AZekspmtOXZPZXhpFSQ+5WP
	Ffe4+vv5ilnMRyOgK1Dz1S9MWDEdV/MhDJUg4PTHa8bvtk0sJ39t0a42PkwiAqpd
	a/EbOeAnhqmBuIcVQkc1XyxWM1CIo+yTz2H01+aR3zgUZlxCuP7aBTTBTLE7ENzK
	AnaiqJ+gR/CLP9F6acw/7Iw65rXCKpEzFEFAyej9YXxBOCsQHi8stJN4YW+IpDx2
	cVEigiKVa3NQlv+OXcR0vgHJZ4wjBkE1vemss3bhQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xaw7ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 05:23:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH52mO6032664;
	Tue, 17 Dec 2024 05:23:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fe76jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 05:23:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BH5Nb9n019585;
	Tue, 17 Dec 2024 05:23:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43h0fe76e5-1;
	Tue, 17 Dec 2024 05:23:36 +0000
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
Subject: [PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in rvu_rep_create()
Date: Mon, 16 Dec 2024 21:23:24 -0800
Message-ID: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2024-12-17_01,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170042
X-Proofpoint-GUID: Uvu985dQsfp8qkZYvgG5DlwsJ3pwT3rD
X-Proofpoint-ORIG-GUID: Uvu985dQsfp8qkZYvgG5DlwsJ3pwT3rD

When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
incomplete iteration before going to "exit:" label.

Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1-->v2: Change the Fixes tag to the correct one as pointed out by Przemek
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
2.46.0


