Return-Path: <netdev+bounces-70701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9AC850138
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D36289595
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EE1FC8;
	Sat, 10 Feb 2024 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JcgjU6po"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEE652
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525182; cv=none; b=HKZm/21TCxNUf4aN+CBYrP6COVyMJbaUTSeuZbf9snQ767N0+72zq4lFTQt4JjAxCjVYnz819fc6sSm9Ldj6fTux1O874l3YriRKmNMncbma358TdGkFDS8h0cRxIA+xZCptQyb6FuIr2NiSqR91nlYyY3zAW5Vy0MKheTulI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525182; c=relaxed/simple;
	bh=CbrBjdCJZVNgm7/r6FMlMVyJdljO71fGEsbpOnVsSPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYmXaQ9NpHQV38KI7kGAzOKM21bnBLUR035dv19AY7QktzjuayDRPY4wo6t7M2GNivOgvs6TVOfMvbVk+/ZePsJzG6bQyvF49bXgRxhbvpcxpmF5vzAoSsNGHcWFPMTM8df7pYDtDDO5EOsLj/ikg5uXTvHMyP1pNpuDnxbsbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JcgjU6po; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7858a469aso11762155ad.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 16:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707525180; x=1708129980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pDjhVSjaegSSMNXa3GUHfuVucfP0rlcP/EmOTiSZb8=;
        b=JcgjU6poaN9bmPimLTLS75OXayf1KIhe6mOhuOrRGb2R1N5nbn8ngjU7Nkj+OXjlZu
         DFOTlVqwnvrlDAO61VIlQKeCskv0lEi37gZnRyvo0Ym4duu2c5x+M9VoaMnQpNlxWuCI
         pPxCCMDJ+OjUhMyNNeb+Vt2sxKtEbJSTNZaL58YKVfkrcRzbGB+GsE+a24hWf4+r4qi3
         0JDVYX6t0uXdzQasf0L+kUQ3/jBcPeC16TDnfJO7UBrGvUtHBavAqKU3dopcY/yCRFgV
         WEPrczkCHC0p763+guiriIK//YuEQrJrNeWr9vqQp2J3t3oowyIY0qjD+OfmUINatuIx
         kH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525180; x=1708129980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pDjhVSjaegSSMNXa3GUHfuVucfP0rlcP/EmOTiSZb8=;
        b=eDtNEzDCzPHHJHh3sZfLC6dRBMunj+vDu7E2X05rOae2Dhgn37Logxrrz0AFAn9xZL
         fXg4dys610ppTh2FkeyV+vzcdbSKT3OlyhKeFgCZFpDgLXQ9uHqNR3a4Z9W7BPymhFrz
         hN7uWWFkKZxWaLpvJrVuIdTX5cr2eHtLa/MfmoCU73uVwPbqHwFERhr9v9SAA04RdzLV
         ps/UZPqimQQVuZ1GNXYkdAGIqQuTD0yTaCvmQAQFDF2Aqxej2X6UY8lo9Ya2cm2z2mjU
         NniowlEGL/trHy/zOl+riq3pKsQVs4AeBx7m99DlPqcaYMfqPX54klRbGLiiLLtn44/D
         cjTw==
X-Gm-Message-State: AOJu0YzyRVabgZBsr9HjG0XBY+yFpMmqkhILV0vm7a4wJL0JmLzKKqNy
	ApbEJRvBw9ZxYPkRINQkN8I4Ma8wO29iOoULXWnXu3Au+B+m+e9gvbudQ8Qts5Q=
X-Google-Smtp-Source: AGHT+IG6PM+9qD0ZPdMsC9jFgIS+sZI3BffyDPkqHXfiI+nzzikWqZphiFoFcTZqRBZP3qcOHEDPFA==
X-Received: by 2002:a17:902:c949:b0:1d9:8942:d280 with SMTP id i9-20020a170902c94900b001d98942d280mr1047144pla.69.1707525180081;
        Fri, 09 Feb 2024 16:33:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAzX3+xjuS10Ccm/AgtGSu42NDwRzyOUD8b3Xf+TNqcs9QGXBMbTx4Qx/SMhAqpbaVZPhi6lTltAKnI/2qcSfjO77jELASGH5JgdLFj25Z0OYPyrIz9WyEI6bIgjduzArG1AMKQ+SrNVKMDQPJurvs+BsNDtmgDLV0vHcubeoXBjgoyPDbxDRM8A1dsSvX80N4IBI4
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id mi3-20020a170902fcc300b001d944bf2d83sm2080103plb.7.2024.02.09.16.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:32:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v9 2/3] netdevsim: forward skbs from one connected port to another
Date: Fri,  9 Feb 2024 16:32:39 -0800
Message-Id: <20240210003240.847392-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240210003240.847392-1-dw@davidwei.uk>
References: <20240210003240.847392-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c    | 28 +++++++++++++++++++++++-----
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 9063f4f2971b..13d3e1536451 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,19 +29,37 @@
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
@@ -70,6 +88,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +321,6 @@ static void nsim_setup(struct net_device *dev)
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


