Return-Path: <netdev+bounces-116338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC994A12A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD0028C2FB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6E1BB682;
	Wed,  7 Aug 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FO3jCYZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A41B582B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013698; cv=none; b=VXcOnpPUOztujMudJeRp9ZCfsTiCpGz2mUoSwXVEuLeID0mITYOAgY9c/Yu6dG+EyYDavJQp9wSkl8gpL97V1oZqtS14izxw3FaFlo31v19zzb5aXO1loJxFJm3yw2FsGzhkWd/5nHHVjtzvwgrFcw5NCZb5ZAb2HNxKq+BZe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013698; c=relaxed/simple;
	bh=s95ys+JICvnxYBeOEzmmoTGlTlrTr+PpkvVTsVC0eqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCLPRJFGUsd6D0qWyatRZF8eSBB3gb4G6ekkuaa0MwlvsFJAcjXza9HP/ex2C4IaNPWRvm7LUyoXonlSXbAp9phSGZ9hP0FQUMy0inmBak0jRh+h0MoDLc/DK14IHb80YN4lknsQzX+wG2Z6FqDRjmT4Lqjw0b4UiKAr+WKxDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FO3jCYZM; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 49E5D7DD09;
	Wed,  7 Aug 2024 07:54:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013695; bh=s95ys+JICvnxYBeOEzmmoTGlTlrTr+PpkvVTsVC0eqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=208/9]=20l2tp:=20l2tp_eth:=
	 20use=20per-cpu=20counters=20from=20dev->tstats|Date:=20Wed,=20=20
	 7=20Aug=202024=2007:54:51=20+0100|Message-Id:=20<bfb9b51282b46a1a3
	 5d31af0419511165895e168.1723011569.git.jchapman@katalix.com>|In-Re
	 ply-To:=20<cover.1723011569.git.jchapman@katalix.com>|References:=
	 20<cover.1723011569.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=FO3jCYZMe2uDmK5kFRbQ/437S7o/6QT/gj4ILVZJ9iyXKzvFymARgMKrL84p27X6b
	 FFYc1M5eQ29kRdh2fct1/oHOYr9yhDO39Mq4qpTySd3BSEYApowdTPtTsLPcpPOmgo
	 kiwRcdqfMShwzuvDaPkmfzMDSYehB1j7piFrieUDT1r7rU6FLEYt+ucgAXxscUGdzD
	 bNhlzLrXQ0vCOYWt5vlWTjThzOCQXb+rLee3m1Ij8T8Qm6Z4JsiOoddJoRCVzMtPkG
	 wjfuwToulJ2YnRKcRInezH/tV6YH/x+v4xUeT+3HQF+x+25/mCEckDuZeiw13MTEI4
	 d9CzFW05BOYyQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 8/9] l2tp: l2tp_eth: use per-cpu counters from dev->tstats
Date: Wed,  7 Aug 2024 07:54:51 +0100
Message-Id: <bfb9b51282b46a1a35d31af0419511165895e168.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_eth uses old-style dev->stats for fastpath packet/byte
counters. Convert it to use dev->tstats per-cpu counters.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_eth.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index e94549668e10..15a862f33f76 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -72,31 +72,19 @@ static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev
 	unsigned int len = skb->len;
 	int ret = l2tp_xmit_skb(session, skb);
 
-	if (likely(ret == NET_XMIT_SUCCESS)) {
-		DEV_STATS_ADD(dev, tx_bytes, len);
-		DEV_STATS_INC(dev, tx_packets);
-	} else {
+	if (likely(ret == NET_XMIT_SUCCESS))
+		dev_sw_netstats_tx_add(dev, 1, len);
+	else
 		DEV_STATS_INC(dev, tx_dropped);
-	}
-	return NETDEV_TX_OK;
-}
 
-static void l2tp_eth_get_stats64(struct net_device *dev,
-				 struct rtnl_link_stats64 *stats)
-{
-	stats->tx_bytes   = DEV_STATS_READ(dev, tx_bytes);
-	stats->tx_packets = DEV_STATS_READ(dev, tx_packets);
-	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
-	stats->rx_bytes   = DEV_STATS_READ(dev, rx_bytes);
-	stats->rx_packets = DEV_STATS_READ(dev, rx_packets);
-	stats->rx_errors  = DEV_STATS_READ(dev, rx_errors);
+	return NETDEV_TX_OK;
 }
 
 static const struct net_device_ops l2tp_eth_netdev_ops = {
 	.ndo_init		= l2tp_eth_dev_init,
 	.ndo_uninit		= l2tp_eth_dev_uninit,
 	.ndo_start_xmit		= l2tp_eth_dev_xmit,
-	.ndo_get_stats64	= l2tp_eth_get_stats64,
+	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
@@ -112,6 +100,7 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 	dev->features		|= NETIF_F_LLTX;
 	dev->netdev_ops		= &l2tp_eth_netdev_ops;
 	dev->needs_free_netdev	= true;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
 }
 
 static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
@@ -138,12 +127,11 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	if (!dev)
 		goto error_rcu;
 
-	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS) {
-		DEV_STATS_INC(dev, rx_packets);
-		DEV_STATS_ADD(dev, rx_bytes, data_len);
-	} else {
+	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS)
+		dev_sw_netstats_rx_add(dev, data_len);
+	else
 		DEV_STATS_INC(dev, rx_errors);
-	}
+
 	rcu_read_unlock();
 
 	return;
-- 
2.34.1


