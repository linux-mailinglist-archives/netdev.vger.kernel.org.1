Return-Path: <netdev+bounces-100905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D08FC834
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B78D283699
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5219048F;
	Wed,  5 Jun 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Uq+Tzt3s"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF418FDC9
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580590; cv=none; b=K3N4M3O7jawrlG9/TPNQWtOQdXR9TTvFgaaJ2kIo3XSLXMgQyTn4O39kD0DciwtWqZJ91zGaEvJEaUwy8C3ch0BPMPC3pJFUb+9l/s1fx/r16yW434NnENruoTyUA8ZbUgOU60XTSmvj+0HGk/aee3HLcDOknTZr5upjP0sKWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580590; c=relaxed/simple;
	bh=8h4KA730AC68bPqqFEuhTfKfCsp4IXk916+cvlcF4u4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPrjYKSow3z2et0o47tyrFJ1qhazFkAb3P/TsRihJouR1nfoikhqUdZSMRR3m2hDaK2NzI/wMDzC7waJ18fmipYeTwvBk8GCBhvJRBErQ+SQp/NwITMFsZR7IZ8Hzh1I0UupBtpZuuVQIHlMncGg0bzZCKI3t7CyX4ZGFNRTsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Uq+Tzt3s; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 2B2832023C; Wed,  5 Jun 2024 17:43:07 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717580587;
	bh=e6aXlOyS5hCIHkSa9U6t3BEST756oDv8nTcE+MOWgXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uq+Tzt3s++kICaq8IL9H90BWV0KVGtcTSWCQxVcT5KRC5ovcT3ni2ogLq+LmPTBo9
	 zYO2pj+LfWO9/2TZIykbMIZSJ4ZN78c0+RJu4xYXxaiaP57HeG5G2xxg0A9gO0mH52
	 hNH1P2WPmcYTcqwksNFSH15ORY64/mjG4NWwfZ9ULeZttMV0L5ESlDWS7IOHphRIfz
	 WQ/gF/rfq6OIL4+ozfZj5ADcIC9gCJ66xsbbveHAftlQQqpSvI1Ccxo7eZLCxkQgjK
	 HlCvgqwD1Ypq6X6fhgLOUrW8zMFj0fj2z7dDoM+jTtvdIXgQNi3e9ySQ4qxTONZdwd
	 t1Mulr1zkhjDg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 17:42:59 +0800
Subject: [PATCH net-next v2 3/3] net: vrf: move to generic dstat helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dstats-v2-3-7fae03f813f3@codeconstruct.com.au>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
In-Reply-To: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.13.0

The vrf driver has its own dstats-to-rtnl_link_stats64 collection, but
we now have a generic helper for this.

Switch to the generic helper.

In doing so, we fix a minor issue where the (non-percpu)
dev->stats->tx_errors value was never collected into rtnl_link_stats64,
as the generic dev_get_dstats64() consumes the starting values from
dev->stats.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/vrf.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 5018831b2a79..b1083620aeea 100644
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
@@ -1201,7 +1174,7 @@ static const struct net_device_ops vrf_netdev_ops = {
 	.ndo_uninit		= vrf_dev_uninit,
 	.ndo_start_xmit		= vrf_xmit,
 	.ndo_set_mac_address	= eth_mac_addr,
-	.ndo_get_stats64	= vrf_get_stats64,
+	.ndo_get_stats64	= dev_get_dstats64,
 	.ndo_add_slave		= vrf_add_slave,
 	.ndo_del_slave		= vrf_del_slave,
 };

-- 
2.39.2


