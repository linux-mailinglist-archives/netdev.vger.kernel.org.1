Return-Path: <netdev+bounces-182091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5FCA87BC4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6267A24F0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE725E804;
	Mon, 14 Apr 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="idDiZPys"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86998188CB1;
	Mon, 14 Apr 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744622537; cv=none; b=saQ1Z0hLRuohtnnxU1CYB6wWlUnDbbqcI6QDSEsZESJwyiuIYVpVRSU9DCOMpeidHrGb46CwGitJ91BFEm4ga4Gez9r0ngmNNFYbJdJYaGqT/MbmJl4hW0zIIPuJRtLE1NeNNlWo+FcQWrzT6DDyypD93ksbVl1K8JYMCitdY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744622537; c=relaxed/simple;
	bh=/I1I6gM4BgOqEOPcMUnOxile0McowWm1N5nrImjyqcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/mNkJtL89MN1lVZB4loqo2VBE0OrYpYqDuZanZsAXRvJgwo5bivDfptGYhL5zEIDdY2jfZLn5uTfEkp6hIbhd/GMnY3yjopa18CBUVegeV2va+oak2tTpafaGsbQOR/d2NkqyM+TrS0zMy2d1M8irVofZjhfnttXnMXPq0+Teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=idDiZPys; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DNEBAR020104;
	Mon, 14 Apr 2025 02:21:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=0fTT/GF2pWHYSVHxCMPJdpG
	QygpaeHfVz/vvbPop8H8=; b=idDiZPysU5GXklyxQZbpLZpgpFQe4olShuRHJ+9
	Z5L/+dIbN0qN1ORRA6aSNBIPLWCFrtZUz2GMNevY9RwJoBT+7Pn69lVqo3YWoLU5
	2Kl4eiZpZp2XzHAsazxSlMMLWBkgx5/Bl+J7Ouoq5GbClniO97K8SawddlCFwFaE
	8zJSpTN+0X+iIRrQ+QQtxo6vqSjrQz3HOMjxskqLQPK1yjm3VWT/CU/2N2MvomyO
	xgZfidR3BAEEoxMbUoUR/56rBH0ZKNG91ZGPbSAkbNrWhMw40Y+8d8kH1We/xVOP
	8XWZP3HfZ8U9tNubnCWQY0Q2DqjNbY2fc5EVBsCeZyZsC5Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjbb08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 02:21:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 14 Apr 2025 02:19:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 14 Apr 2025 02:19:03 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 004CE3F7062;
	Mon, 14 Apr 2025 02:19:02 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net v2] octeon_ep_vf: Resolve netdevice usage count issue
Date: Mon, 14 Apr 2025 02:18:55 -0700
Message-ID: <20250414091856.18765-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xFm9l7l3bI-jgtU0QdEQ9jP0rCAI3jUZ
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67fcd3a9 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=8UtXAm7dt4rhr6CWwt8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xFm9l7l3bI-jgtU0QdEQ9jP0rCAI3jUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01

Address the netdevice usage count problem in the following scenarios:
- When the interface is down
- During transmit queue timeouts

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Changes:
V2:
  - Removed redundant call

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 18c922dd5fc6..5d033bc66bdf 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -819,7 +819,6 @@ static void octep_vf_tx_timeout_task(struct work_struct *work)
 		octep_vf_open(netdev);
 	}
 	rtnl_unlock();
-	netdev_put(netdev, NULL);
 }
 
 /**
@@ -834,7 +833,6 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 {
 	struct octep_vf_device *oct = netdev_priv(netdev);
 
-	netdev_hold(netdev, NULL, GFP_ATOMIC);
 	schedule_work(&oct->tx_timeout_task);
 }
 
-- 
2.36.0


