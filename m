Return-Path: <netdev+bounces-183228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B81A8B6C5
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720473A6CCD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFC2475D0;
	Wed, 16 Apr 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fHsOj4bO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF222472B4;
	Wed, 16 Apr 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799156; cv=none; b=TUs3p2oAiVMWueDey5xJSxexSJtdGusOqbV4YqGDWHREWqyVXrOfHVSDfaSUERmwkiq2XEf1+mnFxQxNVDiRSGjetLsG+E3YemD5qdxGAnaDNC2DuAGE5zKtMLe1624qxX6o3mgmaTytJX953YB9aTJtaN6fXBsnXdzI681M7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799156; c=relaxed/simple;
	bh=/qk5OkmwZUBYyLisMCnfnlBAQRFvNeJqHFv1O/U7SWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DdXaviad0r2jIERYdkKsS5HWjbUtFkHwVX34qIxV1VVwLGv5FQvMu0QQb1RN7ZK8rPr/T/R6TGJLUo42i+b+rB9oz+NyVMyl9GEQzWkFH3MRA9Nbv5t1l4cnf8CR+2edisWRZUXez1tN/CGWyyaduq5MrPORmgDDaiHzR4Ug8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fHsOj4bO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7KfhN019516;
	Wed, 16 Apr 2025 03:25:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Ws0ijbk6aSgPYtqMgyLJEYZ
	5KFgXjxhOsYHcPi7tpd8=; b=fHsOj4bOyhJ6MFEVFVNH+HcpTNFCngwIgaazuqt
	2UQr61Agzt3tmP4S/QWr/I89no5kTpkyycY9IYcR/Oz6yQ1XLMRag/+yAc5f5kM5
	qr2S3N54gCvT8QdmC6Ur8/uu32y/5NseWebJsgw+nUYaymVcHJjQkaFj/snZ82o0
	BUWeleEfi5zk/OiWbJ173N/i568846270xTAtiYqzhBHIN210GKnIgT4Bolw8UJ7
	aIqrcOcIi479fXlLJ0M8ARJ+hbafYKN2V8MNSeHjy7dR0qYCyAt+Rx/jfuBds22D
	kRXHgp1B/lEB+etR0fxIPCJ6IS3rruW4qPJzOvTb6ZwVD1Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 461pg72s8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 03:25:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Apr 2025 03:25:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Apr 2025 03:25:38 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id DCA235B6948;
	Wed, 16 Apr 2025 03:25:37 -0700 (PDT)
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
Subject: [PATCH net v3] octeon_ep_vf: Resolve netdevice usage count issue
Date: Wed, 16 Apr 2025 03:25:32 -0700
Message-ID: <20250416102533.9959-1-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rG1vEaOhqD3KF2WADHe6BtXWv8Et9hqR
X-Proofpoint-ORIG-GUID: rG1vEaOhqD3KF2WADHe6BtXWv8Et9hqR
X-Authority-Analysis: v=2.4 cv=Gp1C+l1C c=1 sm=1 tr=0 ts=67ff85a3 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=8UtXAm7dt4rhr6CWwt8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01

The netdevice usage count increases during transmit queue timeouts
because netdev_hold is called in ndo_tx_timeout, scheduling a task
to reinitialize the card. Although netdev_put is called at the end
of the scheduled work, rtnl_unlock checks the reference count during
cleanup. This could cause issues if transmit timeout is called on
multiple queues. Therefore, netdev_hold and netdev_put have been removed.

Fixes: cb7dd712189f ("octeon_ep_vf: Add driver framework and device initialization")
Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
Changes:
V3:
  - Added more description to commit message
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


