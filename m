Return-Path: <netdev+bounces-150148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68919E92B3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7800281FC2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D22163B1;
	Mon,  9 Dec 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="UGQDfeG0"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293C221D92
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744777; cv=none; b=LNimN0gcn7f53r+RvjGI7hKg5Kgcp/4boXzwfvpZpdXolnzRJ/6/kDI31rqQclTDyP3xwnqcAc8/ScXscl7Q1iZs3YfncQjD0+99UrmXgur9VAttaC1yeMiJDmGF71+aUozHhqxrOwrKc+j78cXxWVmz6yN59H856wZJrsp1bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744777; c=relaxed/simple;
	bh=YmVW5YtdsyVkEuLgntkxS2vrC8GUTUJo4JdlFsooOEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJknvzCnYDyQ/+ws84NmODQcGATs4pkpwNHSCEWfeE4deFR3iQIoXm5chgBTcyezJkCnL7O51guoNGneid1/M7zlw7HoBJgng6HWKJa7uzf2SjwuZuD+UL1aoO5DRv4zX87a6ks7Ra7386dZNZSJwhekUyv2nLs2poOd/s2ABA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=UGQDfeG0; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:25fb:1d7a:7e2b:b2c8])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 494EA7DCCF;
	Mon,  9 Dec 2024 11:46:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1733744767; bh=YmVW5YtdsyVkEuLgntkxS2vrC8GUTUJo4JdlFsooOEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09hor
	 ms@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09aleksander.lob
	 akin@intel.com,=0D=0A=09ricardo@marliere.net,=0D=0A=09mail@david-b
	 auer.net,=0D=0A=09gnault@redhat.com|Subject:=20[PATCH=20net-next]=
	 20l2tp:=20Handle=20eth=20stats=20using=20NETDEV_PCPU_STAT_DSTATS.|
	 Date:=20Mon,=20=209=20Dec=202024=2011:46:07=20+0000|Message-Id:=20
	 <20241209114607.2342405-1-jchapman@katalix.com>|MIME-Version:=201.
	 0;
	b=UGQDfeG0BJW+O8hcaIiIShZGjXQRzJ+o900cT/zgbv5xsMAx8jFaNWSdjlYi1yBc1
	 dJzjKWCyJSYRwQwH9bNbS5ta9+ZiaDMBnsp57zd/NioHfOk5t4ztVk/cBAQHDETn+Q
	 PaHRDtIr2/3kuFEL2vFKv+o3sezr2pRlis6VNvHxaV9fsFpsB7UnZXK73pzpc8l5He
	 u75kUu9ndVgNdIF2DlqVGV2Qs6HLko8QIMkI1B4Krp+j7Re5xkU0+xr3cMF0jaZUh6
	 c5sa1wa90M1rAcp1ullBcOEYMniO6fqkawb67hfPpAzWaz5D/Fpob1JUu7Wc0j3hWa
	 1srTWVqwyyTBA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tparkin@katalix.com,
	aleksander.lobakin@intel.com,
	ricardo@marliere.net,
	mail@david-bauer.net,
	gnault@redhat.com
Subject: [PATCH net-next] l2tp: Handle eth stats using NETDEV_PCPU_STAT_DSTATS.
Date: Mon,  9 Dec 2024 11:46:07 +0000
Message-Id: <20241209114607.2342405-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp_eth uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX
and TX packet counters and DEV_STATS_INC for dropped counters.

Consolidate that using the DSTATS infrastructure, which can
handle both packet counters and packet drops. Statistics that don't
fit DSTATS are still updated atomically with DEV_STATS_INC().

This change is inspired by the introduction of DSTATS helpers and
their use in other udp tunnel drivers:
Link: https://lore.kernel.org/all/cover.1733313925.git.gnault@redhat.com/

Signed-off-by: James Chapman <jchapman@katalix.com>
---
 net/l2tp/l2tp_eth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index d692b902e120..e83691073496 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -73,9 +73,9 @@ static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev
 	int ret = l2tp_xmit_skb(session, skb);
 
 	if (likely(ret == NET_XMIT_SUCCESS))
-		dev_sw_netstats_tx_add(dev, 1, len);
+		dev_dstats_tx_add(dev, len);
 	else
-		DEV_STATS_INC(dev, tx_dropped);
+		dev_dstats_tx_dropped(dev);
 
 	return NETDEV_TX_OK;
 }
@@ -84,7 +84,6 @@ static const struct net_device_ops l2tp_eth_netdev_ops = {
 	.ndo_init		= l2tp_eth_dev_init,
 	.ndo_uninit		= l2tp_eth_dev_uninit,
 	.ndo_start_xmit		= l2tp_eth_dev_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
@@ -100,7 +99,7 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 	dev->lltx		= true;
 	dev->netdev_ops		= &l2tp_eth_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
+	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_DSTATS;
 }
 
 static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
@@ -128,7 +127,7 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 		goto error_rcu;
 
 	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS)
-		dev_sw_netstats_rx_add(dev, data_len);
+		dev_dstats_rx_add(dev, data_len);
 	else
 		DEV_STATS_INC(dev, rx_errors);
 
-- 
2.34.1


