Return-Path: <netdev+bounces-60434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5981F3ED
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31271284029
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2810EF;
	Thu, 28 Dec 2023 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="fJ4eyBee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E71EDB
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3dee5f534so43853705ad.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703727999; x=1704332799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS58+UKX3zYzrUWjdlnAGph2pSrC7waS+cUH+Y73puo=;
        b=fJ4eyBee2IhvMjzYjaluNxfiMMX6fivDgdFEk28pheMXerSaReV72+llUVzjJwO3jO
         lgeqaStMf9GWIf1NiVaK4EM+vEaBp8Tbt5zsT2fr04MmAGZPo0R8/jkZKX1FxwDL1nE3
         DJHuo3DWCj6timqzZfdgUQZDrEIHh2q9NU9bwTsJxFy0Zq8eHVs2HKDcQcHyqyGsoeOh
         SJaiT3NLneQLMRnZDSDclg/A8ZTZnNhQnEYyvvT1bSrDVQ1ge7xaD8PksNJqemTAqzVq
         8vsEro8YE7FreVt2e93IBYjhWLC5Kp7Fo4+TeEJa0G47n3AXv9UgF0z4yc6eYHhEr/7v
         YKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727999; x=1704332799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS58+UKX3zYzrUWjdlnAGph2pSrC7waS+cUH+Y73puo=;
        b=pdh6giTgZtvUqwB2f3abo4KaHnciKo7GGLaG5G46/zDiPXnCjMlIS+srFoRh5ppd01
         vkseuhv3kYh50teEEVbiOVhhn7ROBepbFJL2OtpDNm8Lmc4O4r3cYj0L8/iYHjvaJcMB
         aSkq/qsDP1KFgvM6+FHDDAIGyAQ0MjeNBOOeYPLW65HY9nhWS46QYJXzSVwNLDCisMQI
         QrYkl6TYr8AtBoJIXmBvCk1AEojQMLMN6xx018f9Qy7qss2NbWzU94iG6Yav8xXLFftr
         1OZaHKkU16cnq9McZgNakTB0il3iZLCzQg2JIjNCHRk9TL8kMHSY3K4fbQYaGBbnpWV0
         ZGEA==
X-Gm-Message-State: AOJu0Yx/tEbO4tpCbyh4uz6UgBXCbwYHrSk6S1X4kAxY9+8usYNt/YgS
	kdOCt5eWmFWVxJnSduULTQxuacGzlHALwcJLQo/JtZR3Iok=
X-Google-Smtp-Source: AGHT+IFnOA+MNP93s632NzdRvC0WCNfXwdY10gKVyb8pXRHMLOQl8Wj7VCzhtMpDUmfN91AXSabj6w==
X-Received: by 2002:a17:903:40cc:b0:1d3:f7ce:c187 with SMTP id t12-20020a17090340cc00b001d3f7cec187mr11372196pld.17.1703727999727;
        Wed, 27 Dec 2023 17:46:39 -0800 (PST)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001d3a9676973sm12650854plb.111.2023.12.27.17.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:39 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 3/5] netdevsim: forward skbs from one connected port to another
Date: Wed, 27 Dec 2023 17:46:31 -0800
Message-Id: <20231228014633.3256862-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231228014633.3256862-1-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++---
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 434322f6a565..0009d0f1243f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,34 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct netdevsim *peer_ns;
+	int ret = NETDEV_TX_OK;
 
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out;
 
+	rcu_read_lock();
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_stats;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		ret = NET_XMIT_DROP;
+
+out_stats:
+	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
 	ns->tx_bytes += skb->len;
+	if (ret == NET_XMIT_DROP)
+		ns->tx_dropped++;
 	u64_stats_update_end(&ns->syncp);
+	return ret;
 
 out:
 	dev_kfree_skb(skb);
-
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static void nsim_set_rx_mode(struct net_device *dev)
@@ -70,6 +85,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +318,6 @@ static void nsim_setup(struct net_device *dev)
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


