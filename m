Return-Path: <netdev+bounces-192654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3899AC0AF1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453DE1BA6B73
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385528A1CB;
	Thu, 22 May 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dVWRtVlY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86051EE00C;
	Thu, 22 May 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915149; cv=none; b=pEcBn+f98pL/en1/af+CasRUEg3aqmBT2RPnVy4V7UC9bo9WZOPlLuaz8OKQVfNNij5o7ndaVNL17/cjs6Xm4rTdRJRphEXWVarKjZ9vGy6stHVB/2l5VIVwCAhxK3juWaFQl+3DJ3l7qg2OjxEm21PwonarQP2WM3z2jgPdY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915149; c=relaxed/simple;
	bh=+ORgkMlH1I9NQoexpEQZtsWTzjeSLiJ9Fqc5HfcsgDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxqlUu/b51liSvUprm+CG8m9ThDN4QGPLVWzB/TpCzYWrN4PFrOKs7O7MvnNANmPCc+j8TptCGYSHNiwNweNb9sTpiBWEGe2wnMhgOWFeb+2H1kH4Vj2QU4/1sROOUw9Iij/gk3Pp70vxHqDWxcLhvyW9hS9Kq51W9VcouX4akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dVWRtVlY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MBF0ZR023449;
	Thu, 22 May 2025 04:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=YMnfwGoi1pok6reBJzRJnzk
	AEtrf/C2mJOq10GLOnb0=; b=dVWRtVlYXjr688Eg5a7mC64R43Y8fYFIHaWjNlE
	5DwB50Gatlro435KJCAnJDrVFu4Mmdn/TVCIHpdr12m95pDo3PEi8U5NJ32FScRz
	SB+dFhs+fBPVt9AXw6Dru+ETo6dwbm2o69YAFEc62I9plU6k47/yZgVtvJtq6rFZ
	JpjG/KdGHFI3MqWLzXdNrzPSG58niZ3mu7/pFLw6dGwiQ1noM7AK4UUuxq4r9TMX
	mhCG2nLENlIVxdnw2Ibjliahmn390v0ZMaLgMzCjssApZ7Ci0qeEu9osjQPhUDf3
	nXmINeGxPtsk0rDk3dvO0UjQG7x2g5T73aiTFkOzUvRLvpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46sxr1gh85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 04:58:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 May 2025 04:58:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 May 2025 04:58:56 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 443853F708A;
	Thu, 22 May 2025 04:58:51 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [net Patchv2] octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback
Date: Thu, 22 May 2025 17:28:42 +0530
Message-ID: <20250522115842.1499666-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: S1XzRqRka-swnZzKLE4PoOXX1e6ZvLyh
X-Proofpoint-ORIG-GUID: S1XzRqRka-swnZzKLE4PoOXX1e6ZvLyh
X-Authority-Analysis: v=2.4 cv=LYU86ifi c=1 sm=1 tr=0 ts=682f1181 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=k5zTugwU0-n4PqS4dVgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEyMSBTYWx0ZWRfX98JGANuXmbvy 44ZSg6XxRHQaHHQTyOHK/fQoi6KO1X9vlqdN4cC+tBiQePw4Yq/6Mtg8zR4I/RuYcc+M78DZF4L I/COFgQfiq714kjLYHrr/jYd/9p9Dvr8WzZyAor2ETPBdUrYnrIiAewgaXPfgemh6/o1NnGpeaA
 6CI3E5W6qpHxMtyscSvCuukRx476o84X/vdFNQTFHiGxY4H+lrvpoOfcr0bEIgQFZD83iOl9HIt Fk0zy5mLhPIxneNp9hFkjgmRSEuCR2uWftRbO5Ml5aKffApVPFWRkFzkYzxtWX2LztB8I2MAnQi odC6b+ze84u0kCekguvHuqTN/wMKHvZjC+VdVFAMUV+0Zw/en3tn99i0boygMdVpjaCxIxDT0Lg
 5FaiTcaBiwApQjVDgW+Kh4qnN7+cy6Wk+w1zLY7usaEvTfQLhVpZ1u5GlcL7eZEk3OC04MD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01

This patch addresses below issues,

1. Active traffic on the leaf node must be stopped before its send queue
   is reassigned to the parent. This patch resolves the issue by marking
   the node as 'Inner'.

2. During a system reboot, the interface receives TC_HTB_LEAF_DEL
   and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
   In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
   is reassigned to the parent, the current logic still attempts to update
   the real number of queues, leadning to below warnings

        New queues can't be registered after device unregistration.
        WARNING: CPU: 0 PID: 6475 at net/core/net-sysfs.c:1714
        netdev_queue_update_kobjects+0x1e4/0x200

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
v2* update the commit description about making qid as inner.


 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 35acc07bd964..5765bac119f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1638,6 +1638,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	if (!node->is_static)
 		dwrr_del_node = true;
 
+	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
 	/* destroy the leaf node */
 	otx2_qos_disable_sq(pfvf, qid);
 	otx2_qos_destroy_node(pfvf, node);
@@ -1682,9 +1683,6 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 	}
 	kfree(new_cfg);
 
-	/* update tx_real_queues */
-	otx2_qos_update_tx_netdev_queues(pfvf);
-
 	return 0;
 }
 
-- 
2.34.1


