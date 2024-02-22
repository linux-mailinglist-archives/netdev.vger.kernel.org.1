Return-Path: <netdev+bounces-73882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBA85F0B8
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D001C21AC3
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5479C8;
	Thu, 22 Feb 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NJLx7Joz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458994C8A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578526; cv=none; b=GlS0kpIth85ej3Bbj2Y467WQYFyyPQd+TpSChkCmcMXOBvIxkA5XCn/PwmLNFI48kN+kEgIXrhAfIsKxgUVQdqmBJkTxwVa+5LNUCOrkJjedWtX+d1kPKT+ob+2r1qp+p516lScdzY/LWaiXKqjUm8jRSTb6W7JmAX/NwGN/2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578526; c=relaxed/simple;
	bh=WuVQ9tyy4qXVzj8fg5jT1T8KjKLN2WSR7176fQweBTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjdNMfHweLe1ThqQJyWnnyOtZz6x06EcxTIbWq5l9dlYyKEFUq89wumSJIteBKGmRX+5EgseUENlCynoJ3s/W0VquSSXhVNcHIBmt8lYEHPRol64ldFeOagLro4/Ylmg/SQTqneFg86K3XRRb4Olw7NU0hlLmsnBzWNq+6gR9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NJLx7Joz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d934c8f8f7so70046065ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708578524; x=1709183324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=NJLx7Joztro5XviN021gh5Ar0innpxwXkRtKeEaGWg8Mqb5u2yQFp7DGtXUFtwnzDq
         QFV6ndzVE/SahJ4aa7aFGuxMV+WNUUEGTYpa1dky77De1iXqCwswz1J1wlmCSUYO9yt7
         2uBerQtYgkfxHYUM2azGPXRFRUNxnegXss/6mCWYg6WMAg3G+c04ThoT5+nTjm5Mg7y2
         1HeDvjlrgK01WpoOy9o7qXe3UKXQhS6seQsZJYpqiogNlpTRL7A2lAgqpk7o1UiEzEmB
         Xlwo8LAf/3+C7MSEdrml1+1P+//JTA2pbh261U/79RmuE0swQLEhuhTdsLi8SDWp97xi
         I91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578524; x=1709183324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=cbDtB+3ScM60qMvA50cpEZFYF0MsIRpAJExlWpJFFXBffiSaiCFkPYh9Uzrn9K6oar
         u3xHsN+FxjoWW7wFcw+rRRZ5ANn8/oHWu7XTO6eNXklqN0aQ3Jvvtg9ghEIK83ehnSBn
         Rf4vz1hPIK/09Qbf0QYTtvL6JEJs811uMeyGs1zZlnYTuW1DQrRzc/Wl7DGWLtVVTag4
         EDjYjOMqZMuzVChkh6Ow97e2wNJ7l8MD9PrA/9Z5KxAvqygUVi87iU1iDrolFhO6MRBe
         Uxp1jY2glJ+muwSRMN8E1SDal3la6PnjmbykXAvcXGL8jjFTnJfeoJEIUn27STGSBu0u
         JPOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlfS0elnqkL2DwJh3JJXvnjiaYxS99KMh/sFHUfGaVqrpaZKBY2GJfpwrriXh5rT2d67xZt2EotEanJyq1rsUpQTnTubRb
X-Gm-Message-State: AOJu0Yw3vHuUV/KK6nQInnp1ARJPmJImWQOimwk6/3ItmipnB4YZTQxH
	AZRyHbWHVWxc4YB6oBTrhMR+w8iC8wYhR6NvPWiqSFlU0hptm67KzJoioDvIxbT++xS7XLH5OZE
	H
X-Google-Smtp-Source: AGHT+IEzhoI6LKlAev/iJAdJ6+AUdBSvh7br44RBQgAoinytCvh1L5tzOM7x3rulz5tHkzE5d4klVw==
X-Received: by 2002:a17:902:c246:b0:1db:d256:932d with SMTP id 6-20020a170902c24600b001dbd256932dmr11747999plg.10.1708578524317;
        Wed, 21 Feb 2024 21:08:44 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001dc0cb0413fsm4911895plb.155.2024.02.21.21.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:08:44 -0800 (PST)
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
Subject: [PATCH net-next v13 2/4] netdevsim: forward skbs from one connected port to another
Date: Wed, 21 Feb 2024 21:08:38 -0800
Message-Id: <20240222050840.362799-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240222050840.362799-1-dw@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
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


