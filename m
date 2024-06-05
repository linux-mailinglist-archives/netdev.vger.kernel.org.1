Return-Path: <netdev+bounces-100903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5238FC832
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824DA1F26420
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27918FDD3;
	Wed,  5 Jun 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VAH+EPJX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B218FC95
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580590; cv=none; b=DKUKIxHMXTYUPYsG7nhr25fnUSU0+1JrVhIbpPwPS3eTxqNBEzyasu+I74lYUG8/zf3PGRMihWuUtx5juzYFLHfPOJkUB1hBIIoRSZbFa3Gzlr8MM8N1UqdWmLXHNBts35dEmojqDF/tnWUO4kR/HZBaGXO7SEmLd6ciE4zdVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580590; c=relaxed/simple;
	bh=AaS0MVDHsIviwS80bGsw+6Ul/ToVvQJ9omBDanURioE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxS+VTZjaAOlHn8BEqk689RsGdQ1Ucjfz6NAPUSxYVnl0c1P0/GAUnsL0lBk1IEqr61rMWJtmGZbar284J1aBCBmstEb+4MV0QRM+gEzBS2vLenNqj3GwUjz6fFmH5a13FtQ/Rdh+7wKJv+0etxzbabkbLck6DTzzyO5dSo/FEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VAH+EPJX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7F0AD201C2; Wed,  5 Jun 2024 17:43:06 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717580586;
	bh=kPxrZD8ZnlmXNhcZBn+cUOOFrPj85ugqV8tA0BpTO7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VAH+EPJXDIC/eArg1iV7uIkXl8OLT+RVVdE1Htlww1wxCaVMzSEgpu8wFdw2PM1mM
	 /AcPfLzu42TXFTSFeuYAhfToexYTeGw1O30NIBgniNJoukIGXuvOaypWux28yh4MAF
	 66MYYZXw9j/pVxNljD2RICU/qgFfimiE6OJ9IEK+M4rqV0FNWvHY3MjesWjp4kJ13H
	 OEWKAQJqmuYAu1GbLeM22HYwWF1Hr1CRrLx386gT5uP1rqfxgnGoz7q9nKrYGNxOa6
	 Y37WJV1hM/kStYcly4DNGu67eeuI0hVbh4slwZNvs5LMdUL3iGSOjZZLsVsjrUBG3w
	 aiTXv/zGHrCFA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 17:42:57 +0800
Subject: [PATCH net-next v2 1/3] net: core,vrf: Change pcpu_dstat fields to
 u64_stats_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dstats-v2-1-7fae03f813f3@codeconstruct.com.au>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
In-Reply-To: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.13.0

The pcpu_sw_netstats and pcpu_lstats structs both contain a set of
u64_stats_t fields for individual stats, but pcpu_dstats uses u64s
instead.

Make this consistent by using u64_stats_t across all stats types.

The per-cpu dstats are only used by the vrf driver at present, so update
that driver as part of this change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - use proper accessor in rx drop accounting
---
 drivers/net/vrf.c         | 38 ++++++++++++++++++++++----------------
 include/linux/netdevice.h | 12 ++++++------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3a252ac5dd28..5018831b2a79 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -126,8 +126,8 @@ static void vrf_rx_stats(struct net_device *dev, int len)
 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
 	u64_stats_update_begin(&dstats->syncp);
-	dstats->rx_packets++;
-	dstats->rx_bytes += len;
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, len);
 	u64_stats_update_end(&dstats->syncp);
 }
 
@@ -150,11 +150,11 @@ static void vrf_get_stats64(struct net_device *dev,
 		dstats = per_cpu_ptr(dev->dstats, i);
 		do {
 			start = u64_stats_fetch_begin(&dstats->syncp);
-			tbytes = dstats->tx_bytes;
-			tpkts = dstats->tx_packets;
-			tdrops = dstats->tx_drops;
-			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_packets;
+			tbytes = u64_stats_read(&dstats->tx_bytes);
+			tpkts = u64_stats_read(&dstats->tx_packets);
+			tdrops = u64_stats_read(&dstats->tx_drops);
+			rbytes = u64_stats_read(&dstats->rx_bytes);
+			rpkts = u64_stats_read(&dstats->rx_packets);
 		} while (u64_stats_fetch_retry(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
@@ -408,10 +408,15 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
 		vrf_rx_stats(dev, len);
-	else
-		this_cpu_inc(dev->dstats->rx_drops);
+	} else {
+		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+		u64_stats_update_begin(&dstats->syncp);
+		u64_stats_inc(&dstats->rx_drops);
+		u64_stats_update_end(&dstats->syncp);
+	}
 
 	return NETDEV_TX_OK;
 }
@@ -599,19 +604,20 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
 	int len = skb->len;
 	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
 
+	u64_stats_update_begin(&dstats->syncp);
 	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
-		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
 
-		u64_stats_update_begin(&dstats->syncp);
-		dstats->tx_packets++;
-		dstats->tx_bytes += len;
-		u64_stats_update_end(&dstats->syncp);
+		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_bytes, len);
 	} else {
-		this_cpu_inc(dev->dstats->tx_drops);
+		u64_stats_inc(&dstats->tx_drops);
 	}
+	u64_stats_update_end(&dstats->syncp);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..f148a01dd1d1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2731,12 +2731,12 @@ struct pcpu_sw_netstats {
 } __aligned(4 * sizeof(u64));
 
 struct pcpu_dstats {
-	u64			rx_packets;
-	u64			rx_bytes;
-	u64			rx_drops;
-	u64			tx_packets;
-	u64			tx_bytes;
-	u64			tx_drops;
+	u64_stats_t		rx_packets;
+	u64_stats_t		rx_bytes;
+	u64_stats_t		rx_drops;
+	u64_stats_t		tx_packets;
+	u64_stats_t		tx_bytes;
+	u64_stats_t		tx_drops;
 	struct u64_stats_sync	syncp;
 } __aligned(8 * sizeof(u64));
 

-- 
2.39.2


