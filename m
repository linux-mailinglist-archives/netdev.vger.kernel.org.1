Return-Path: <netdev+bounces-100837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 735F28FC3C8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EA71F2318F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E95190475;
	Wed,  5 Jun 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YN7nHvC7"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F119046F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569474; cv=none; b=kKMVftMY25aiFJLHvF5PpA6UdtoXgnv1e87OKhBAonuXm8yXWDd6155Gdx3sG9Av0uOkTnnbp9SC2ZwyUVhwGHqpvzepCE8+0UleGeso3JoQDw/xhRgd39cXqp21Q83eKiqlI9X02lhp2TWOe3hFRm2IWdKQ4BLaSUt/zkju7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569474; c=relaxed/simple;
	bh=zmTmh7ASTot7EGoViXDy/73x2dhefg4ZMXJtkUdb7bY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXU4k210xjFsN2m2SS6sI5y0Gw8JI1Wqn4HeUMvqn0RHzwRuOGE4lQaMJT3eUTYxuv3uq1HsLmvA/8zuN2hOd9a49ZXQ9Wi8CgKl8ijWSFCjbCzugv94yWU1hvGDUx37kC13jik+w0ArQlMfNbYy3qN8EmEwPmaxtJ5MBasc6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YN7nHvC7; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id F1C7C2023C; Wed,  5 Jun 2024 14:37:44 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717569464;
	bh=g5F7dqHQbs2dU2CFrRg9ztZqJLFpPNqFa1FMXphKtow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YN7nHvC7oNiY6sZ5x7AKEJ+JG1Q1Sg5UOJVx0okuJnUM8bSud2ihR2gtZ1fM/TZZq
	 2UHsrd1RXSIyVAZFv29ZM2tifzTVowQhgPAYovwsVuxdTBrXGSc7Ii4AW8DfnDv5l5
	 hjKwW7wJU5UfjOgYlZPO6I5Vo4WS4bD9HXXa9ZdrOIus/yCaTQBSQ2Y/xxWps6hzjk
	 dA5fBe3tq4rrjo8pMbG0bb4JXbZ0X9ZpHz6fjbJ4VS+FXYuSRpv33Ei8mL5dkbPR1O
	 dmOhmcnp/3U52CrWj0Myj69EH5dAMHHJZ99f8hCsfEd2e+oD2KFlCbzQMXswJAfDnq
	 06vTuN0IaeCLQ==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 14:37:30 +0800
Subject: [PATCH 3/3] net: vrf: move to generic dstat helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dstats-v1-3-1024396e1670@codeconstruct.com.au>
References: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
In-Reply-To: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
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
index 088732871b27..19d4bd25aca6 100644
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
@@ -1196,7 +1169,7 @@ static const struct net_device_ops vrf_netdev_ops = {
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


