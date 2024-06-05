Return-Path: <netdev+bounces-100839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928EB8FC3CA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B998B282C4
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64719190480;
	Wed,  5 Jun 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fYROE1Me"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187A190466
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569474; cv=none; b=YxR9ee4X0HFZPhFj9RYwnhJS5HzfKr0GoTfbatYsUpzL1FfKDCfkD5YybtBRoIt9jntNbPymSLEl38Q6zzB9tjeEt8xZ9Vwi8ut8pEQUZfQYFGZl+blhmW4BC/jvNP2y0plKxiEYf2Q9CDupO1kVDIPSF77DoyKzNREpDb2cU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569474; c=relaxed/simple;
	bh=6483Ud8fB0KT6IlGhXfCWrZwwT6n5TdXKHLMG1M/Xh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUcpF804eoRdrenm+JUV4bdCGc2DU8dhUGIdTLvC9fNycQEhVhTQlT9J8Fas9DFecV3rBSW4VWGflLAsoYRXv0phaTlvFEq0TcGtXfp98F5WzG9PhnFrROwlKHcQuPl4a/6NCNoN09fyI82vUsOkcpMROlZuzwZdJk1YnksKWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fYROE1Me; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 4A17B201C2; Wed,  5 Jun 2024 14:37:44 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717569464;
	bh=RJ5wg+Bux1ZQ8XAmUCobCbdMLuJBBe176/0x/0oFLD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fYROE1MeXb4rNjp0cBRNU6QiEv6MNClo78ZJJSQ7yZqII9fud3mY7QOZwlexlmI8h
	 LqGK08H9eC0gfHZETsulDwLd3juyzrU2F64RwcI79t4aYbdRiXTXs+NAKQvVe4CR9v
	 JG9TwkUCMyYrhGLmDZafSHv5Y/J/xo6RyLHK6buv/URr/ivDBTEehse+Y0042gKtX2
	 +gxKqeEeHG8xhLvwwXbaaN3soZIvRPwY7KCO4Qbda6pO4Kw6g3lClCo7+wedblZbVm
	 LK9GB/n4ATRa0qhlztwXIQcDIzuvkWf9MONz+kinkbK24dPqhcWkEzxuAMYpIBeChi
	 47uUtbbRrkeYg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 14:37:28 +0800
Subject: [PATCH 1/3] net: core,vrf: Change pcpu_dstat fields to u64_stats_t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dstats-v1-1-1024396e1670@codeconstruct.com.au>
References: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
In-Reply-To: <20240605-dstats-v1-0-1024396e1670@codeconstruct.com.au>
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
 drivers/net/vrf.c         | 29 +++++++++++++++--------------
 include/linux/netdevice.h | 12 ++++++------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3a252ac5dd28..088732871b27 100644
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
@@ -411,7 +411,7 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
 		vrf_rx_stats(dev, len);
 	else
-		this_cpu_inc(dev->dstats->rx_drops);
+		u64_stats_inc(&dev->dstats->rx_drops);
 
 	return NETDEV_TX_OK;
 }
@@ -599,19 +599,20 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
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


