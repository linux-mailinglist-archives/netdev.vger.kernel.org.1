Return-Path: <netdev+bounces-159206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB9A14C54
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07B93A34F6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FCA1F9A8B;
	Fri, 17 Jan 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LmROjyxK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B391F7910;
	Fri, 17 Jan 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107235; cv=none; b=E+XEuWKnRa3AR0TMI+l7Y8y19cyyZIthh6W8R3UAqwWYMWnfvWUo0XgYr60igpZAOdFfEhOinlfcsB7XoHqjZW9cxs3rc7GmPf6Lu/JBrCQ2GEKiazXO/04lBhoAcZFfl9T9al+/lBXUBTAWu6hBnejj7g2frWZzpAiU1gBXMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107235; c=relaxed/simple;
	bh=eL+vxw3RmPqv2xsgtgIQlo2wSxstEHOekaPcnV+/rSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hga1pPB64cLb31GvBBaAD2xbmkIqUIZO9V4gwS5a86XbtYRVls+CtdfqBgP2IK0CxUE+sZcvVMg726uxhnda9hjoTr0OITnr0xiE6kLh7aFm5rwRKJnX200m1LZy5THr+Wxo/UjdbZ+1oNJNeOiHoLNOGS9KF4I36sG3UTQD3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LmROjyxK; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9VdIi002542;
	Fri, 17 Jan 2025 01:46:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	WLsOBYYollykV7XV4Cmz6D2z0GtCyW62rR7/CNrWDc=; b=LmROjyxKNWbkygd3l
	Z/4F2dW2fRsubeghI1LckVaHxZbzJrb+zA5/Hir74irIkonCuohvMiIa7HknDwoU
	6ShKdv/ekoNdjZiWWr56TBdvQxdJ3Fx/RExNH/IQ80fDqc3ulBWf4wsxDnLpXj+C
	xs9xnmmqi4NAbmhQtmKZ71SDriQ2YjfxswfMg17LTJD74zMGHIMavTeOksOOanfO
	vPKen/uuHmOK3dQDNHHNr3mGH5gObQIeVyOqrsABNQQY5b8t1lv94KpEnAgUz4qv
	1xLw+JMbBHleDvu4stKjM8VY3Id9xyBqpDfugiwxUoU55Cnbtp/zm5uSvsqz+lAv
	UKb7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 447mnc80rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 01:46:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 Jan 2025 01:46:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 01:46:57 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 54CA33F707C;
	Fri, 17 Jan 2025 01:46:57 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        Satananda Burla <sburla@marvell.com>
Subject: [PATCH net v9 1/4] octeon_ep: remove firmware stats fetch in ndo_get_stats64
Date: Fri, 17 Jan 2025 01:46:50 -0800
Message-ID: <20250117094653.2588578-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117094653.2588578-1-srasheed@marvell.com>
References: <20250117094653.2588578-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rOI_JqSgt2MCLvtQ3plUrfSS6GNzm9TG
X-Proofpoint-ORIG-GUID: rOI_JqSgt2MCLvtQ3plUrfSS6GNzm9TG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01

The firmware stats fetch call that happens in ndo_get_stats64()
is currently not required, and causes a warning to issue.

The warn log is given below:

[  123.316837] ------------[ cut here ]------------
[  123.316840] Voluntary context switch within RCU read-side critical section!
[  123.316917] pc : rcu_note_context_switch+0x2e4/0x300
[  123.316919] lr : rcu_note_context_switch+0x2e4/0x300
[  123.316947] Call trace:
[  123.316949]  rcu_note_context_switch+0x2e4/0x300
[  123.316952]  __schedule+0x84/0x584
[  123.316955]  schedule+0x38/0x90
[  123.316956]  schedule_timeout+0xa0/0x1d4
[  123.316959]  octep_send_mbox_req+0x190/0x230 [octeon_ep]
[  123.316966]  octep_ctrl_net_get_if_stats+0x78/0x100 [octeon_ep]
[  123.316970]  octep_get_stats64+0xd4/0xf0 [octeon_ep]
[  123.316975]  dev_get_stats+0x4c/0x114
[  123.316977]  dev_seq_printf_stats+0x3c/0x11c
[  123.316980]  dev_seq_show+0x1c/0x40
[  123.316982]  seq_read_iter+0x3cc/0x4e0
[  123.316985]  seq_read+0xc8/0x110
[  123.316987]  proc_reg_read+0x9c/0xec
[  123.316990]  vfs_read+0xc8/0x2ec
[  123.316993]  ksys_read+0x70/0x100
[  123.316995]  __arm64_sys_read+0x20/0x30
[  123.316997]  invoke_syscall.constprop.0+0x7c/0xd0
[  123.317000]  do_el0_svc+0xb4/0xd0
[  123.317002]  el0_svc+0xe8/0x1f4
[  123.317005]  el0t_64_sync_handler+0x134/0x150
[  123.317006]  el0t_64_sync+0x17c/0x180
[  123.317008] ---[ end trace 63399811432ab69b ]---

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V9:
  - Update commit messages to reflect reordering.

V8: https://lore.kernel.org/all/20250116083825.2581885-2-srasheed@marvell.com/
  - Reordered patch

V7: https://lore.kernel.org/all/20250114125124.2570660-3-srasheed@marvell.com/
  - No changes

V6: https://lore.kernel.org/all/20250110122730.2551863-3-srasheed@marvell.com/
  - Corrected patch to apply properly

V5: https://lore.kernel.org/all/20250109103221.2544467-3-srasheed@marvell.com/
  - No changes

V4: https://lore.kernel.org/all/20250102112246.2494230-3-srasheed@marvell.com/
  - No changes

V3: https://lore.kernel.org/all/20241218115111.2407958-3-srasheed@marvell.com/
  - Added warn log that happened due to rcu_read_lock in commit message

V2: https://lore.kernel.org/all/20241216075842.2394606-3-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20241203072130.2316913-3-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..730aa5632cce 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -995,12 +995,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	struct octep_device *oct = netdev_priv(netdev);
 	int q;
 
-	if (netif_running(netdev))
-		octep_ctrl_net_get_if_stats(oct,
-					    OCTEP_CTRL_NET_INVALID_VFID,
-					    &oct->iface_rx_stats,
-					    &oct->iface_tx_stats);
-
 	tx_packets = 0;
 	tx_bytes = 0;
 	rx_packets = 0;
@@ -1018,10 +1012,6 @@ static void octep_get_stats64(struct net_device *netdev,
 	stats->tx_bytes = tx_bytes;
 	stats->rx_packets = rx_packets;
 	stats->rx_bytes = rx_bytes;
-	stats->multicast = oct->iface_rx_stats.mcast_pkts;
-	stats->rx_errors = oct->iface_rx_stats.err_pkts;
-	stats->collisions = oct->iface_tx_stats.xscol;
-	stats->tx_fifo_errors = oct->iface_tx_stats.undflw;
 }
 
 /**
-- 
2.25.1


