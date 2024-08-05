Return-Path: <netdev+bounces-115748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B63947A7A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2574281BF6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0915884B;
	Mon,  5 Aug 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="HONT4PYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A4156F3C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857746; cv=none; b=j5sj4u990dp2lYCr21BQ4oLTaOpFaFbGqMgcYDAx6H4nfJUxBq4EGroQ+9ps86gH4ISQkiOd1gXKZbgcWVDxoDMgYP2t9rLrDDggSsiVbDQMC+HYkjFNW2hfSMATlu6wN/SGGakza0vDyS3nM7S10TsheujtBiTkcLD9FUpPTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857746; c=relaxed/simple;
	bh=s95ys+JICvnxYBeOEzmmoTGlTlrTr+PpkvVTsVC0eqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RX6L7K4CZ40bGEdGgUktDbMNs0XfWadQVtkURkneLLWFph2WPyBsTo1zl/OUc1PqnSA+OllBH61gB7MRmXA/a9qLUY3E8UxsgvDgyGHQE2rUyUGeQzz4N9BefPbVnpk1yJHgRnU0AmL7SCsCS6bzadnRlYa9YkBTxzpY09ruvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=HONT4PYU; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:326:9405:f27f:a659])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B88297DD04;
	Mon,  5 Aug 2024 12:35:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722857735; bh=s95ys+JICvnxYBeOEzmmoTGlTlrTr+PpkvVTsVC0eqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=207/9]=20l2tp:=20l2tp_eth:=20use=20per-cpu=20counters=20fr
	 om=20dev->tstats|Date:=20Mon,=20=205=20Aug=202024=2012:35:31=20+01
	 00|Message-Id:=20<ae182e6000c53fd3c1f00ffb1af28a7aa54de851.1722856
	 576.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1722856576.git
	 .jchapman@katalix.com>|References:=20<cover.1722856576.git.jchapma
	 n@katalix.com>|MIME-Version:=201.0;
	b=HONT4PYUvF6iSikRe1Mxhpv+eQWRzaobCCLVbIgfXjURwojUnKJDpNfSTvhEtvbEO
	 //HwLsprmyw7Z9Ms+btKoCT4j41ZUiOdHOMQJgiQQach5Sro1tGfPHQO7uPfngkK1x
	 701IlFI+CO+Nd/szmiEqi8oZIieWIUN19Ru4MIuW26oD4EbQQkaw3+G8Np/hdt1buE
	 79aI2lM008m4pD60SD+LQ7CJpzoa6s70qXC4dTKsvGtmlfS72jANBnlS4+8Mix71Rm
	 UFhm55wohaoaCmiG1hdNoJuYWX+mrX7GCzzhGNGCYd2iuvUhx4KhTJrx3qimr4llkG
	 7ycILA56cu0Fw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 7/9] l2tp: l2tp_eth: use per-cpu counters from dev->tstats
Date: Mon,  5 Aug 2024 12:35:31 +0100
Message-Id: <ae182e6000c53fd3c1f00ffb1af28a7aa54de851.1722856576.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722856576.git.jchapman@katalix.com>
References: <cover.1722856576.git.jchapman@katalix.com>
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


