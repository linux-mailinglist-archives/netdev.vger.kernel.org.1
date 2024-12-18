Return-Path: <netdev+bounces-152922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8769F655A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DB51655C7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11111A2399;
	Wed, 18 Dec 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ke8jwy3U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A31A2396;
	Wed, 18 Dec 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522704; cv=none; b=MRw1+7w43GQXqwcHcf1s5Oy/d7P/SMsQzeGCeDeJy6hT4oJgO3Y/zCUcmlcNipi9zurGf4GY7Fqa0yTkzVeLiXUZKcvPM0qTfqGa/OOPHszk2Fo/8bPc9Z02jpWfs5vrW4Z+YCkMHf0JHn/HZJ5Lo8tuEPRTx/7k824Mw1NSk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522704; c=relaxed/simple;
	bh=ZPjwKF14+rWlR5d+TGWlLYgioHcW+JlqPJprVfdsPis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E11VJ/6ntowWtaQtzwmLAUsGIHLNHXvstLQ+2lqNpXmFE9Yrwyg9uvrBEoRidAs8XQqcZBRJtLTjHVTh45MyTRP8nlUlbpub7IoQV6cIbB9eGyRwOAGPzymvoBqrHiocCs0gIr/xBdtDyjs9LQNHE4yVDhOQFoUILYeDBqK/LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ke8jwy3U; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIAHSvc012776;
	Wed, 18 Dec 2024 03:51:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	hC4ok/dwsisZqXaQNIlsz/9j5ntvdyV0p89AtJl++U=; b=Ke8jwy3U19E94SllL
	MEKsN/35Lz3WFl5V7VfvB3OIo6jPfFVDotgxlc7XvvCtLdJctaEVvZiS5/3Fd+U5
	XOncxb6kuXWXjDt67Ls8XS555/4QhcyoKzEHzB+FS362Pld9sPsGStIkxZBajCkz
	g1nh16+Bz+z0Shh+vrEBCtIpm0bZyASKVaHyihX0GK88c+fPksBXIoHhx4u58wHY
	Dn93eJ2J20VZJr+bTncmTJv34V9Gp3sSCNAOJ4+jLjo3+8IBL7jPQzz90TNsutdj
	V2LMnxxRyg5sijCTcWJQOM7gWbZEjDTtehob9tRCAtA5kWjaaJJrVHLqA3IJ3S8B
	w0zYQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43kvgvr505-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:51:23 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 03:51:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 03:51:23 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 8A63C3F706B;
	Wed, 18 Dec 2024 03:51:22 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3 4/4] octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64
Date: Wed, 18 Dec 2024 03:51:11 -0800
Message-ID: <20241218115111.2407958-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218115111.2407958-1-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3uwPDK3mVs22R-hvh3sAWT-3_Dx4aWRC
X-Proofpoint-ORIG-GUID: 3uwPDK3mVs22R-hvh3sAWT-3_Dx4aWRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Added warn log that happened due to rcu_read_lock in commit message

V2: https://lore.kernel.org/all/20241216075842.2394606-5-srasheed@marvell.com/
  - No changes

V1: https://lore.kernel.org/all/20241203072130.2316913-5-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index e6253f85b623..75dd3bd2b9ba 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -800,14 +800,6 @@ static void octep_vf_get_stats64(struct net_device *netdev,
 	stats->tx_bytes = tx_bytes;
 	stats->rx_packets = rx_packets;
 	stats->rx_bytes = rx_bytes;
-	if (!octep_vf_get_if_stats(oct)) {
-		stats->multicast = oct->iface_rx_stats.mcast_pkts;
-		stats->rx_errors = oct->iface_rx_stats.err_pkts;
-		stats->rx_dropped = oct->iface_rx_stats.dropped_pkts_fifo_full +
-				    oct->iface_rx_stats.err_pkts;
-		stats->rx_missed_errors = oct->iface_rx_stats.dropped_pkts_fifo_full;
-		stats->tx_dropped = oct->iface_tx_stats.dropped;
-	}
 }
 
 /**
-- 
2.25.1


