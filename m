Return-Path: <netdev+bounces-148358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF09E13E1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6EE1644D8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165918E76F;
	Tue,  3 Dec 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eQlD6yK2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A2189F57;
	Tue,  3 Dec 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210515; cv=none; b=BbObTD7jYvIGiyYn7jt3CB/QnkuyQnD8o4BdBCvhqBu9PRskYkMtamiPwar5BxxCygDAbdxSw40GceecZ+Fzjt2MH8MYo9VZie5SbUQafX7gKFMEt6hvCxDDc7AMO7hokvJCH778Q6KMtFxcucdJ4vbL5fslkEbJ//ZTFBCuDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210515; c=relaxed/simple;
	bh=B4ORKtmQbDZW6rXiKO+gEhBszYqvclrSSoGsvMz8erQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouPbO11sRIJuhoRjwkCtOXNyElxl9YWlgRvtwQZzcuK8HyDHczdGQGj2ycOHI6ORAUAOF3gr1bNmcS17UZCJ3uold5W/+vcQOO/db5AqOkKE6bxf8jsREfyJGnR1qTuP8vuGsysGuf5pLJm3sjADwRteIk8u4vHCPzsk6yZAnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eQlD6yK2; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B34pcmg024494;
	Mon, 2 Dec 2024 23:21:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	YFLRzd3emvRso5V0wEae5aHl+XO2hgus5vXr+N/jF0=; b=eQlD6yK2rrv7PdApz
	hE37RoG9ptc8rc2myZuWVLr9wgPFyhGq+BgfNztK10Vl9meMo0y9LcBloyOccqgz
	dvVqITL+ncC1jD+6MriTGGki29cN+UTROTIgStyQf5onHZ6C7eYbQUgrqcU/F19c
	YTP6VTT5CeAylNvKaspE58QW7dxdnyQ+FLYgRxNxDz+e41VnZFRC90XPms06FtZh
	yKPXVTiGszCSXE26lnZGKrUQdJwUFUBXJJ7JQEyyDA6HKkyTgWE0tXdz3It09Avh
	sdrBLt+iazr9L+F78Wgpssz57POZ4lbWgnF6yX9AoXE+VsRN2mHjBtLbw3K+Y7Vc
	rdFNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 439t7y0c4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 23:21:41 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Dec 2024 23:21:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Dec 2024 23:21:40 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 620925B6952;
	Mon,  2 Dec 2024 23:21:40 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
        <einstein.xue@synaxg.com>, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v1 4/4] octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64
Date: Mon, 2 Dec 2024 23:21:30 -0800
Message-ID: <20241203072130.2316913-5-srasheed@marvell.com>
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
X-Proofpoint-GUID: 0Lt8hKUCreRKGll-EGwCY_y_ggtomjBr
X-Proofpoint-ORIG-GUID: 0Lt8hKUCreRKGll-EGwCY_y_ggtomjBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

The per queue stats are available already and are retrieved
from register reads during ndo_get_stats64. The firmware stats
fetch call that happens in ndo_get_stats64() is currently not
required

Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 12b95fb21e64..38e93d79ae59 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -824,14 +824,6 @@ static void octep_vf_get_stats64(struct net_device *netdev,
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
 	clear_bit(OCTEP_VF_DEV_STATE_READ_STATS, &oct->state);
 }
 
-- 
2.25.1


