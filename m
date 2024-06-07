Return-Path: <netdev+bounces-101782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2652B9000C0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDF91F255F0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBF15D5BD;
	Fri,  7 Jun 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LAtEr3+E"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FF15B99D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755942; cv=none; b=KD0GO6GyiMafPhgRKRDNe4pGPl0o39nPOb2ssAwSy4DBsUxeIuNpns10bFubZacE3LBswwcgCDdWkUrlofWWTZCLu4ML0exsuyN5WYhF7O+EkXn8IESmqkR8ki5V4NzIwJxXGLyI8M/rmQgUNTfZRdwEECuzuF3TceKHMCjy/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755942; c=relaxed/simple;
	bh=piPU+g0nbMTOuvekb9iGPxz9qQk6qA1/h7C8xUzER2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6vCbL78GgZR9SJZ6LNWl7h8ajAU+2VPzpybtYGhXyE9bDAawVO6yn1eWarvoL5fU3q1q90cjzjG0/zDyUrQoZdI+oirAAWbqfRSmAJR8lHBBNptZzaF7s34hQq+Y2Jl0WBINttqYDtOwwkRrf9zEwf5qtLgWW6IkFwr8mPcpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LAtEr3+E; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2D2F72024E; Fri,  7 Jun 2024 18:25:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717755938;
	bh=SGCjoIO9SaSjlyIO6j/HHQ1TU4mgED8jsS/7EgCYwaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LAtEr3+EotKHF7pmCTS/trVrBjeaoxFjophkZBePCch+66IeWZLHxctUUtZLNfoKi
	 8c6DFGdOVxG5eEhsCnSFfUVpzvroYBpIGW9qfU+eTqPF6pXcla00qhcLIbblfKmhUM
	 hmg/IVBZMGqML9TiD0WdoOPe1pmpz5Ly2io9ZNOqtGr6rd9ZUT0gZe6WFNNAK8/hrW
	 ubyF2gFY8AJKW0auq1glXVe6fsyXV56opF696sYjmmZyaAqE+NT7o28gdTV62chYO6
	 TwUfzlPUTAtS7KKBFsE/r5j4+v6BHZtFpaBVgYLa5xu5S2pPY9wnFmeXt/ytJT8fDN
	 fdqq4Zdq2nm+Q==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 07 Jun 2024 18:25:26 +0800
Subject: [PATCH net-next v3 3/3] net: vrf: move to generic dstat helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-dstats-v3-3-cc781fe116f7@codeconstruct.com.au>
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
In-Reply-To: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.13.0

The vrf driver has its own dstats-to-rtnl_link_stats64 collection, but
we now have a generic implementation for dstats collection, so switch to
this.

In doing so, we fix a minor issue where the (non-percpu)
dev->stats->tx_errors value was never collected into rtnl_link_stats64,
as the generic dev_get_dstats64() consumes the starting values from
dev->stats.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v3:
 - we no longer need ->ndo_get_stats64, as the collection is now
   performed by default for NETDEV_PCPU_STAT_DSTATS devices.
---
 drivers/net/vrf.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 5018831b2a79..9af316cdd8b3 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -137,33 +137,6 @@ static void vrf_tx_error(struct net_device *vrf_dev, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
-static void vrf_get_stats64(struct net_device *dev,
-			    struct rtnl_link_stats64 *stats)
-{
-	int i;
-
-	for_each_possible_cpu(i) {
-		const struct pcpu_dstats *dstats;
-		u64 tbytes, tpkts, tdrops, rbytes, rpkts;
-		unsigned int start;
-
-		dstats = per_cpu_ptr(dev->dstats, i);
-		do {
-			start = u64_stats_fetch_begin(&dstats->syncp);
-			tbytes = u64_stats_read(&dstats->tx_bytes);
-			tpkts = u64_stats_read(&dstats->tx_packets);
-			tdrops = u64_stats_read(&dstats->tx_drops);
-			rbytes = u64_stats_read(&dstats->rx_bytes);
-			rpkts = u64_stats_read(&dstats->rx_packets);
-		} while (u64_stats_fetch_retry(&dstats->syncp, start));
-		stats->tx_bytes += tbytes;
-		stats->tx_packets += tpkts;
-		stats->tx_dropped += tdrops;
-		stats->rx_bytes += rbytes;
-		stats->rx_packets += rpkts;
-	}
-}
-
 static struct vrf_map *netns_vrf_map(struct net *net)
 {
 	struct netns_vrf *nn_vrf = net_generic(net, vrf_net_id);
@@ -1201,7 +1174,6 @@ static const struct net_device_ops vrf_netdev_ops = {
 	.ndo_uninit		= vrf_dev_uninit,
 	.ndo_start_xmit		= vrf_xmit,
 	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_get_stats64	= vrf_get_stats64,
 	.ndo_add_slave		= vrf_add_slave,
 	.ndo_del_slave		= vrf_del_slave,
 };

-- 
2.39.2


