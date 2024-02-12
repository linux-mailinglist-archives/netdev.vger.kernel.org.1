Return-Path: <netdev+bounces-71092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B58520E7
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF281C21E0B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B34D5AC;
	Mon, 12 Feb 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CO51u7KD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D54CB22
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775554; cv=none; b=L84Wezk699HM1iNa9AjGyPSEK1O39iBiIvmNfACmFw1yto6J/GFLjA9PkETHz0U9HbOY6AXdQ8v8pqX7ct7uH864C6a9z6iMtyWKb/b7cXoa55PVU4izfUoDUSQddvoXm93Tc1rFHdcIY1vIRT9x1H8F6TE4m7BS+zcSeECkVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775554; c=relaxed/simple;
	bh=WuVQ9tyy4qXVzj8fg5jT1T8KjKLN2WSR7176fQweBTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lALQh2KKtHce/J3AIBH5ksiwoSCiDaITFp2N7McxSDdIkwm78tU2aNX0wK5fBGiYQsfKQWZMyAqgRf2hIGTPuBh/2B2nftpuH3nyc08aKGO2tYyGyeEYg0yuJ9mlABZeFMX9JvpCtz/g6YhDAP0s4P7bvA7CiQr/ZzzKFxIUxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CO51u7KD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d9b2400910so23888215ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707775552; x=1708380352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=CO51u7KDCAGXK4icFMP5kN+dUJyac2e04AZtcMQjqzytFLGtKz0xvD3j+9DB+ChXHD
         fI+nb8nfAMU7fEQw9AnheUoi9haBp43R2CHpaB31WDjupmKp3Ziv1RE0/Vqboq4uylFf
         liRhJGtFCYXuwOAkbjBnvHAqGgIBxG1ZN5eCmZ2RxqWtlYqKTtlq06dCsNgs1nbXqNJk
         01P7SSTnjH69LyrvQLxtjpUUZ07iWjKK3UhyA9u4eaIszMS66ntjFMBaYKyr0opmg8jm
         rpjCo8Wsksmk0lUBxxE9UzD+Rrh/vT+a5TnugPf7ZJBJ6X0RIXQ63241jtFgLVXJ4Idb
         /Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775552; x=1708380352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=lCHtbOQmFNnGKLHhYp3Ezy4OUUkrrVBWiRGMSzbR6HTfZigc7aya2KrJg0TIzgsi95
         xjFiEZn2OtrMEXTjyAxpcAKotTYuq7DC/LfkhyUUyb6ZiS59Sa3c0W1RG8xJLcYAFgut
         Uvlp7F3IiRC7A/dVNAkY3bAhWsGROF8vwAuI5FtemZZof/tgPr/kc/yrh4SnEnGB4oty
         yLu5CdLKRU8lpwxQjGzrnTDGj5d+y2JGRuIfKPkxwQSpvwaWOL788l5uBWKTDfq1rHDk
         CssiFdIltmpLLjNNRkoNvZGeOFaCEcrbf4DYOf+0zQRS3VhKtIvoXaWzrewr97PcuklQ
         n03g==
X-Forwarded-Encrypted: i=1; AJvYcCWiqvCwg94AjWGabAMEScU2QIIWfcLxaBA+uXwvRgqzbesMAavfMiQcMQ84zEqNb6Bfr+V/IYE7qc3hZpYmDmz0JvoKftON
X-Gm-Message-State: AOJu0YwRbVDbJZEAV7rJUc/6lv5Qwz8Ttr5S+LrPFAclPjI7SJHcvsiT
	QKsJbSh1EhCys5jb1hpiWR0/VUm02bA/gy6VX4tJGvSaucTz2RTHQAEPtIk6EwU=
X-Google-Smtp-Source: AGHT+IEpgBQg5SfXqypwtNJUkX6VoTn+E6MMOsjUyxyIQtua4QrR9IsoWFzTvP6hnjRxSU1Q9kMKTA==
X-Received: by 2002:a17:902:cf42:b0:1d8:cfc9:a323 with SMTP id e2-20020a170902cf4200b001d8cfc9a323mr1106707plg.34.1707775552251;
        Mon, 12 Feb 2024 14:05:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhlsFTf1oNWINmIAJCMDvNkkWn99i3/SIOS6ovhfcegLR8vECHB6hGJQbPMPzKEVu49yRmyGg2j7Z6/m7sZMFgIVrTxbftOLU/R3h0V4vEH4/U7i3znblSCKiKA8gxombFEonWLuTiWaxRvVH6BRBG4JmOyxhGmrzFrdRoS6Gj9EvzYO+QClBiaG/AV5ncmFd9jaN4
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c10500b001d9b749d28bsm797159pli.285.2024.02.12.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:05:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v10 2/3] netdevsim: forward skbs from one connected port to another
Date: Mon, 12 Feb 2024 14:05:43 -0800
Message-Id: <20240212220544.70546-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212220544.70546-1-dw@davidwei.uk>
References: <20240212220544.70546-1-dw@davidwei.uk>
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


