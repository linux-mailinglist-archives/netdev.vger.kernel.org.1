Return-Path: <netdev+bounces-148357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223CA9E13DF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB419282BC7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E10189BAF;
	Tue,  3 Dec 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k8H0m4Gi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752EE16FF44;
	Tue,  3 Dec 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210513; cv=none; b=cZS6McapMnCRzowCbWcODDA+JbKFDoXxgYZd2WJZYSivgfVslfol+BJLzlLtZSlNs/5VLjv2DFCAlaRx3Tr7jhXJ65k6lM0JKzhOcSpHs4IG+bymArYQIdNp39YX0yQQIO/zHsxOr1xZ3A4fGvUGtFVm1ZaiuMvHAmSymoWFGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210513; c=relaxed/simple;
	bh=sEdAioFmf9Lv9Bzh6KE1MU1PkU2fq233DbnGmvjON7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9bIrzWQPhuTZJ/ETbH756HqoFCxATjJ7q8YcYPRlCCDTJxvPblShx7/FrkoiAlzDULdOvGDEFF19XrhFAXAJu5fKCXqth8Rg1mYpK2w8sUTLHXbE+aS9Jt3r6TizvzyNVHEYB6iTxaiQJAvfM8cpD3a88rMHBrOncsHru4KMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k8H0m4Gi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3425fT025988;
	Mon, 2 Dec 2024 23:21:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	jy6BB6VduUyPdEuxxU2kGiraZEi6RInQ4CSuJ+p5fg=; b=k8H0m4GiVTV1JJvuS
	tn1vGuMW4fsoAeXgORTV/pJAi270BBC3lxkY3Ydazgxl76++VIA+ybO9L+ypse7d
	H9Gq8/0hcdZ/GDhGzNmaL4Rgdb0osP9iZ6GMdhGGf/n2+NsYhFyZ+EchNabNrZwv
	02mYUmCtt2BDkWaF2lP0zFbI9u1Wyv8mvQMVzW83Ffu2UuHptM4npJ5ratev8ald
	y1i1e54vzBxtUKX7EKV0n6P7YewHWa33wKZGr9Tw8cNZg3Wip8Ql+YK7wIM5ckk1
	iz1P9RmF0IFj9GKw0XhWQFVxpjELa01lgxK8n4ojF21FsaA+bTdZ+BVQGbcI6s5F
	kGrcw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 439tkw8ay2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 23:21:37 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 23:21:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 23:21:37 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 6F1C85B694F;
	Mon,  2 Dec 2024 23:21:36 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "Satananda
 Burla" <sburla@marvell.com>
Subject: [PATCH net v1 2/4] octeon_ep: remove firmware stats fetch in ndo_get_stats64
Date: Mon, 2 Dec 2024 23:21:28 -0800
Message-ID: <20241203072130.2316913-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203072130.2316913-1-srasheed@marvell.com>
References: <20241203072130.2316913-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: a-SoDUzvR_nYhptRavZE2XrxNPVFJG1t
X-Proofpoint-ORIG-GUID: a-SoDUzvR_nYhptRavZE2XrxNPVFJG1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

The per queue stats are available already and are retrieved
from register reads during ndo_get_stats64. The firmware stats
fetch call that happens in ndo_get_stats64() is currently not
required

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 872b4848027c..8c0a955a02dc 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1009,12 +1009,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	struct octep_device *oct = netdev_priv(netdev);
 	int q;
 
-	if (netif_running(netdev))
-		octep_ctrl_net_get_if_stats(oct,
-					    OCTEP_CTRL_NET_INVALID_VFID,
-					    &oct->iface_rx_stats,
-					    &oct->iface_tx_stats);
-
 	set_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
 	/* Make sure read stats state is set, so that ndo_stop
 	 * doesn't clear resources as they are read
@@ -1042,11 +1036,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	stats->tx_bytes = tx_bytes;
 	stats->rx_packets = rx_packets;
 	stats->rx_bytes = rx_bytes;
-	stats->multicast = oct->iface_rx_stats.mcast_pkts;
-	stats->rx_errors = oct->iface_rx_stats.err_pkts;
-	stats->collisions = oct->iface_tx_stats.xscol;
-	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
-	clear_bit(OCTEP_DEV_STATE_READ_STATS, &oct->state);
 }
 
 /**
-- 
2.25.1


