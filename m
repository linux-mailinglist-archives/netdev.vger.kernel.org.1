Return-Path: <netdev+bounces-158090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68588A10718
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EED71886AEB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C43229633;
	Tue, 14 Jan 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BhfM8vgI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54AD22DC30;
	Tue, 14 Jan 2025 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859124; cv=none; b=iKhn/s825F/rEs48H6mTe/0KxER5qXH0YiPBYzGMVXoNZWf++k+47DuInxgVxMn9SAihvQRg9/kxyC78A2oT7b67x21O7tom3eCczPn5Fgw6wUtJwuFkCsDpzkBZi0GK+5zwkZy1t7RfQKFSiMN3V5ftiQIQ0ht96iVqUgk0Y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859124; c=relaxed/simple;
	bh=SYfZWK9TvFTZe6In6RKVq7NCBphTzJrl+/lNUSQlifE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTQnMrIOaq1qJVEYhwORJaCqJveA+SJsZhZfYlxL9V8vwPj9HdEVYWvYX/et8W5hyg6qKxEeOsZ+pVfhzKIdMr/cGVgFBJF/ynF+SX68vuMyC+TW3flT8Jdcr8zxafsX5+nCJl3oxf89qBf5JHsH5sSOxnS/fvWTv0jTuPY+gME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BhfM8vgI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EB5hh3006236;
	Tue, 14 Jan 2025 04:51:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	t3C1WKDtG6S1RY1nYk1VnH/7KZD3XT6PBtA9dylKOg=; b=BhfM8vgI4ikw9wm0W
	6UGWxZqcZ/cy0yBKvpt9LWLN3Ip3beoENKxhSiT0WYhU+dLf8z2xvKHhcWO+NZg2
	OH6Btpg8VC8XfKu0fTdqm6Q14x0cS4uov9LdPpFNN1JJQkR1vYAmLFUgC5k4un1P
	Kbvgc1n6cvOUDgsP7HnV3QkTilHVnNksPS3CgCi/tzxd0CnKXDd3t5GL3QgtVqo6
	LGR1mIraJ8YTPOxDTgwXAMRr1cnzwhLfTkZ9OhtDNZr717Ob8Fya6t17Isam+hOH
	o6UV2OKGoNBNy52V8lmWR1l3n9aekCn9E1Ybd/t3EV6yGQzOng88x3jVuEbZ3gHl
	zm2IQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 445prd0547-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 04:51:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 Jan 2025 04:51:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 04:51:30 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 3A74F5B6927;
	Tue, 14 Jan 2025 04:51:30 -0800 (PST)
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
Subject: [PATCH net v7 2/4] octeon_ep: remove firmware stats fetch in ndo_get_stats64
Date: Tue, 14 Jan 2025 04:51:22 -0800
Message-ID: <20250114125124.2570660-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114125124.2570660-1-srasheed@marvell.com>
References: <20250114125124.2570660-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Xx-kcL3bVXgSmVHJ7n0hcK_70p_QNgnk
X-Proofpoint-ORIG-GUID: Xx-kcL3bVXgSmVHJ7n0hcK_70p_QNgnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

The per queue stats are available already and are retrieved
from register reads during ndo_get_stats64. The firmware stats
fetch call that happens in ndo_get_stats64() is currently not
required

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
V7:
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
index fdc549f727c4..b622d7146847 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1006,20 +1006,10 @@ static void octep_get_stats64(struct net_device *netdev,
 		rx_bytes += oct->stats_oq[q].bytes;
 	}
 
-	if (netif_running(netdev))
-		octep_ctrl_net_get_if_stats(oct,
-					    OCTEP_CTRL_NET_INVALID_VFID,
-					    &oct->iface_rx_stats,
-					    &oct->iface_tx_stats);
-
 	stats->tx_packets = tx_packets;
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


