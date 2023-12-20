Return-Path: <netdev+bounces-59125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD058819681
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A1BB207F5
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57649BA45;
	Wed, 20 Dec 2023 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pgGYOQpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186A8F42
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4790788b3a.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036872; x=1703641672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSg5u81ARGsA2V0Hw9iYeP01VuoNONJOQ+m4l2NA7u0=;
        b=pgGYOQpDtfCFIuUJ8Q0KQcTH3qgR25+Pf1PeuuuSVYpEg8MenuqanBh1wL/fSb6pPm
         +osbJFPpBMe4QCWMLpz6Ot4+urzaWAu+cPkYriS2Rwgd7gklVmICOtIQGYfcoDGoF/c7
         H+PIYIB2lHjykJSXzgKYFimx3cb47Gz+9WCgHwb8Kz7+7QssDhPlPqXgiNkeaJqk9kc0
         x0EAhU/QWydLrxCHUBfhFYw/P25UoCp9jhfx3JA9Pj7q1XbBV2a9Zzo6M6+xQd3Y/ffF
         3KBVg7zU48vprVp55julLRKysYLM5Q93zpmS4+1/kAyT/C9uHoM0S5H/gFxSwUZJisFp
         jrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036872; x=1703641672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSg5u81ARGsA2V0Hw9iYeP01VuoNONJOQ+m4l2NA7u0=;
        b=k/gWcDFVxiZY9ZStDNtgo8tumBzbnZH+cbH/LzR+sif3ntswrRaXxdRxpEF4/a1Zr4
         JEsw9SvKP3BZXH7//1CGOTm0EZCNAsit6VgIwEieIOUlyoxqgXe8BKpOqJZwpNtccdEH
         OVJ0EprN26vC3EKt4CRhPsSUaqc4tqBAcRB7v+dwhSwV6XcU3Ylhx9a8E+ziuoEckvTb
         DwgIMI4tiC2BoxGT5QTX3FYQGlc2bjIXXSwOQB9+7znNyJjl3vOukbuXWDuzx9LGroxE
         AZ+Ip2grRaazS5D2BnJJ6D6QJ6x5Jj1e+ncrVsoAZcShWl1td+/XEZ7oJR+XnaiXzXjg
         Td2w==
X-Gm-Message-State: AOJu0Yy/bP03Q0yDBwOcMoZwZE5OU4HMSU2PRu8y5wdb7WqHIOP668HD
	K6WviVaCR5UgLuN2HmBdc6kUjQ==
X-Google-Smtp-Source: AGHT+IH7HlKSNUD7U447zMjXp6LMVCC2ZOTyRJ7TKZ1xtQ76vYFwJKjEk+pYn5m2xz6ZXL+H0loNhQ==
X-Received: by 2002:a05:6a21:3286:b0:194:503d:1ab1 with SMTP id yt6-20020a056a21328600b00194503d1ab1mr5927840pzb.70.1703036872303;
        Tue, 19 Dec 2023 17:47:52 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b006ce77ba135esm14236280pfa.217.2023.12.19.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 3/5] netdevsim: forward skbs from one connected port to another
Date: Tue, 19 Dec 2023 17:47:45 -0800
Message-Id: <20231220014747.1508581-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220014747.1508581-1-dw@davidwei.uk>
References: <20231220014747.1508581-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c    | 25 ++++++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 434322f6a565..00ab3098eb9f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,6 +29,8 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer_ns;
+	int ret = NETDEV_TX_OK;
 
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out;
@@ -36,12 +38,29 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
 	ns->tx_bytes += skb->len;
+
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_stats;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP)) {
+		ret = NET_XMIT_DROP;
+		ns->tx_dropped++;
+	}
+
+	rcu_read_unlock();
 	u64_stats_update_end(&ns->syncp);
 
+	return ret;
+
+out_stats:
+	rcu_read_unlock();
+	u64_stats_update_end(&ns->syncp);
 out:
 	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -70,6 +89,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +322,6 @@ static void nsim_setup(struct net_device *dev)
 	eth_hw_addr_random(dev);
 
 	dev->tx_queue_len = 0;
-	dev->flags |= IFF_NOARP;
 	dev->flags &= ~IFF_MULTICAST;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE |
 			   IFF_NO_QUEUE;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 24fc3fbda791..083b1ee7a1a2 100644
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


