Return-Path: <netdev+bounces-75945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1786BC21
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ED01F21176
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679972932;
	Wed, 28 Feb 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aLkQgCw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DC72901
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162580; cv=none; b=gsky292SxTHJc0/iYFsZoQY2qm85RxJSC+JaVJPYV1C3FpexbInngQeNpBTvCP0o6+tkRN2cL1YnSi6eK61pR1Y1bVRAn5oN2W7GnAB2dP13YStEPIc6qZYywtdXKVOM3sXsmE/aAHZMSW4cQEMokGy66laoe7dP1Uh+NW8rwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162580; c=relaxed/simple;
	bh=+3sq9lfVb5ZFktgaFs9T5aQVerTPpfw47fVxMi66gv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SelLMqNaUJAbWb/xnvtSzc9ftOqNpQHTZwXYKX6Nx5L2A1u1MOUfCa1XuT08EG1qOexaxB5KKkr/OlFfGt5wKwvdCjhgW9hWYpTqk+EUYgAcAvlGo9JAjaM8rqa5mp3Hmbiy5s2rjJ91N8WJw7CkzE3x1ufTo3CLKtq8+HOyXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aLkQgCw7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608e3530941so3397117b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162578; x=1709767378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6IAN7c925VSRxOVMZAdo+DB7DtBwZEdQgiiRGMzVDQ=;
        b=aLkQgCw7o56IRNaJF8TLs2AqhodAw2dq+5sczDjjaAtNegwp6MAJA5I/73z7xkIadV
         ar+4XegPPRh3BENQsukxnSj8R/t0HyFNr+PULr3MCBqY2GGl7Wu3tWvB6AD9rwaWOKX4
         /jge9rWn4MZ5zMW1cd7hEerO1ZADoASkESNMepx7rhwSz1gEoZ7/SHZazXb7iY+kUaYw
         l63W2hGSBJnmi9DnWIQs5+puff7RWKJfaUs2CravCIjbfvtYpXT7x6O97yRY4c1psaEu
         H3SFz69ya6UiCvOg+qcBOmKXaCijhZbqkRJbxFY9+0rVr1L7HgQok8+XB5AtybOqBBY7
         nqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162578; x=1709767378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6IAN7c925VSRxOVMZAdo+DB7DtBwZEdQgiiRGMzVDQ=;
        b=plCHVxHsspGDomWC7WecPc8iL9aSB9nj6AGA1XEhGx+d7djcT2pqkduMMok4gmSq2j
         nxCJ2INDDO0jE4d3Kx6//ZdJAiT3/VDl8XK0J0itD3JD3d1mfgYI6jukeZsMQe0g5GQ2
         WrboHNaHnoTaXHvqmc8fw5f7+wxTRoWoEbTL4dBXhDNu32MJOS99sy3DtqRQ+PXB/pmB
         IVVmdTnb29+sObf/yatWOjx6FgvVkkbV2UoayoqsPMFJI9mqNiSyHayX4RL73b6tqfCt
         R9qc4k9V9ZKE8dG3QkD7QdKLba5jYE0Hnzo0qfxjKX4GYXv7g7BZ/U58ZBuZl32LAeJz
         zX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW9PzC4U+sG/zeQMiQed3o3Da9cDTi2rU/pQIHcc8b66ALo5lucBLNqoNcThyAb99SEwRQfYtnAHhTG4Bjqhjh0UUkokwC
X-Gm-Message-State: AOJu0YzXWx9Lq1k6TSwetM0Vc7oOPU/7+mNe8TUcru4bUu3hr65WHUMb
	fpzD75m8AZ+l/dPqukmMagC5nxUYw+mpQtJqorjK73StQ7BKTpm45uoGLpAjRXk=
X-Google-Smtp-Source: AGHT+IH7ZoVYh/UQ/uavJdvPDIydc6N55caF51UVuqCxCHB8L26v/tsCJdoa26rgE8yZs5LZGKKDhQ==
X-Received: by 2002:a25:bc88:0:b0:dcd:2aa3:d744 with SMTP id e8-20020a25bc88000000b00dcd2aa3d744mr752770ybk.17.1709162577780;
        Wed, 28 Feb 2024 15:22:57 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id t17-20020a252d11000000b00dcbce4abc32sm14351ybt.36.2024.02.28.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:22:57 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 2/5] netdevsim: forward skbs from one connected port to another
Date: Wed, 28 Feb 2024 15:22:50 -0800
Message-ID: <20240228232253.2875900-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
References: <20240228232253.2875900-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/netdev.c    | 27 ++++++++++++++++++++++-----
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 9063f4f2971b..c3f3fda5fdc0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,18 +29,35 @@
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	unsigned int len = skb->len;
+	struct netdevsim *peer_ns;
 
+	rcu_read_lock();
 	if (!nsim_ipsec_tx(ns, skb))
-		goto out;
+		goto out_drop_free;
 
+	peer_ns = rcu_dereference(ns->peer);
+	if (!peer_ns)
+		goto out_drop_free;
+
+	skb_tx_timestamp(skb);
+	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
+		goto out_drop_cnt;
+
+	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
 	ns->tx_packets++;
-	ns->tx_bytes += skb->len;
+	ns->tx_bytes += len;
 	u64_stats_update_end(&ns->syncp);
+	return NETDEV_TX_OK;
 
-out:
+out_drop_free:
 	dev_kfree_skb(skb);
-
+out_drop_cnt:
+	rcu_read_unlock();
+	u64_stats_update_begin(&ns->syncp);
+	ns->tx_dropped++;
+	u64_stats_update_end(&ns->syncp);
 	return NETDEV_TX_OK;
 }
 
@@ -70,6 +87,7 @@ nsim_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		start = u64_stats_fetch_begin(&ns->syncp);
 		stats->tx_bytes = ns->tx_bytes;
 		stats->tx_packets = ns->tx_packets;
+		stats->tx_dropped = ns->tx_dropped;
 	} while (u64_stats_fetch_retry(&ns->syncp, start));
 }
 
@@ -302,7 +320,6 @@ static void nsim_setup(struct net_device *dev)
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
2.43.0


