Return-Path: <netdev+bounces-72182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA26856DFA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC301F23FE6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 19:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33613A89C;
	Thu, 15 Feb 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nJX0Li4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AD213A864
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026211; cv=none; b=AZt/obWy1i8Gkqxc74tJUXUTniJPrIJFh0n9ENd64GVzaNtn8Mf5sHd0Av6XOjxIu/drmnlHwgP3mtuMAuZ3dm4I0ZyHQb4ZRkYkkJaHrw4dSk2DEcWfz9EJsdK9mkrf3VUlZ/41+/YlrEXXzAjapyC+iBne1tb+AYBzp2l+pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026211; c=relaxed/simple;
	bh=WuVQ9tyy4qXVzj8fg5jT1T8KjKLN2WSR7176fQweBTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U354y2mXmJ7WXMONmXZl/xXXh0vbhaGVKIVwJTR5UF8/3cQY3UYtb3aw/o/Ix0q/urz78VwL8VLh47tbPFPPiQlJEx0h1881TnTHpeCg7ymyLtHbXdnHVCi2bv4V6MrCjwJDgi5n2TkNHERolMmV1iT3m68rDgNGYpwR163eO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nJX0Li4y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7393de183so10824525ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708026209; x=1708631009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=nJX0Li4yFNKBI8kN69ms8rD+IVTlmC16abKW7rQ6pz1wVaO03drSRsVuFwS4Y1CFQy
         vAPLd+QV2EvDNFK+y0FnpTE9ontKtO7c41SDgMV0fhP2dT1TMpnliEOu47CRNbLSWCuh
         SEX2IYB5BDwek4OwSmpUXpvFXUQ/FmYC4/r5w+Qeu4qR6uYaxt/5MaOJWFwel/Z5nlPJ
         bd8JLhpJ2Pyw1tjXn9Y938go3mBMCZvU6PgOEXU7yY6Fa+Q1ncZO6gYr55gYaQBAVK3p
         dfOtxByKEvpgNN3icR43sK1giGFXqCajBrby4ijPzOppfjYcGgj4kBv+79Y3+dwSAhhu
         LzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026209; x=1708631009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=pT2dMP+p/XwkjMFOX1ysy0AwNpwH6QDju8w0T8ipUQ0AOtspDiHk7T53+l/BDRMzP1
         /VctcahzmRFJ3snwpGKyNQONlMjV3IlhrqLtbB+r4IxZZ5FG6D4MKXqLIw4hnWicNIpb
         O0wspaNiq2FF6IUuLUJhv3Zzq59mhd3Wwk0heXUvpxJraAbuMj9YNkeOOIfnoh7tbOHr
         f/Z6um/dUZMx05+F0WJja7qsQBGjtsKkFBq4+uS2/satMI3HMlpJjwSVvvkLfA0K2nMr
         O60Ax1ZYqOpIM74u8T5+5KFHJZKTaPNP/IxLgulgIfBRScWaQjs54EEdDnF/IV4QV8EF
         wUNg==
X-Forwarded-Encrypted: i=1; AJvYcCWYfNYQ/H/RmX+KfK+xTZn/ivFJwQ9y2eVxmrHM3uoBQjieSX89W+1wn5OUJil3ATcTS6clfr/ys2NiLs4TtZdXyLDo5WPL
X-Gm-Message-State: AOJu0Yzhwp9q4ME5k/Bd2vX4q8Law/jO7OuJkBqNokHFJQcpKRt+tiMQ
	iyUCOPfoAVVKzdQJ1R6CVZLrbhc2XCLzUxnAzBKvYvN5l5Tc4FzRNJbAZYfdMcY=
X-Google-Smtp-Source: AGHT+IG8KsGzzymvkYoQrDvGFMozbWo0M2bmO3grIunI1becpu0a7ObwoRqfWkShsSAA9SUakQt+Ng==
X-Received: by 2002:a17:903:264e:b0:1db:94a9:f9f7 with SMTP id je14-20020a170903264e00b001db94a9f9f7mr1589864plb.20.1708026209112;
        Thu, 15 Feb 2024 11:43:29 -0800 (PST)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id bh6-20020a170902a98600b001d9537cf238sm1620782plb.295.2024.02.15.11.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:43:28 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v11 2/3] netdevsim: forward skbs from one connected port to another
Date: Thu, 15 Feb 2024 11:43:24 -0800
Message-Id: <20240215194325.1364466-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240215194325.1364466-1-dw@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forward skbs sent from one netdevsim port to its connected netdevsim
port using dev_forward_skb, in a spirit similar to veth.

Add a tx_dropped variable to struct netdevsim, tracking the number of
skbs that could not be forwarded using dev_forward_skb().

The xmit() function accessing the peer ptr is protected by an RCU read
critical section. The rcu_read_lock() is functionally redundant as since
v5.0 all softirqs are implicitly RCU read critical sections; but it is
useful for human readers.

If another CPU is concurrently in nsim_destroy(), then it will first set
the peer ptr to NULL. This does not affect any existing readers that
dereferenced a non-NULL peer. Then, in unregister_netdevice(), there is
a synchronize_rcu() before the netdev is actually unregistered and
freed. This ensures that any readers i.e. xmit() that got a non-NULL
peer will complete before the netdev is freed.

Any readers after the RCU_INIT_POINTER() but before synchronize_rcu()
will dereference NULL, making it safe.

The codepath to nsim_destroy() and nsim_create() takes both the newly
added nsim_dev_list_lock and rtnl_lock. This makes it safe with
concurrent calls to linking two netdevsims together.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c    | 30 +++++++++++++++++++++++++-----
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 9063f4f2971b..d151859fa2c0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,39 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	unsigned int len = skb->len;
+	struct netdevsim *peer_ns;
+	int ret = NETDEV_TX_OK;
 
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out;
 
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns) {
+		dev_kfree_skb(skb);
+		goto out_stats;
+	}
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		ret = NET_XMIT_DROP;
+
+out_stats:
+	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
-	ns->tx_packets++;
-	ns->tx_bytes += skb->len;
+	if (ret == NET_XMIT_DROP) {
+		ns->tx_dropped++;
+	} else {
+		ns->tx_packets++;
+		ns->tx_bytes += len;
+	}
 	u64_stats_update_end(&ns->syncp);
+	return ret;
 
 out:
 	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -70,6 +90,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +323,6 @@ static void nsim_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->tx_queue_len = 0;
-	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
 			   IFF_NO_QUEUE;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c8b45b0d955e..553c4b9b4f63 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -98,6 +98,7 @@ struct netdevsim {
 
 	u64 tx_packets;
 	u64 tx_bytes;
+	u64 tx_dropped;
 	struct u64_stats_sync syncp;
 
 	struct nsim_bus_dev *nsim_bus_dev;
-- 
2.39.3


