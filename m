Return-Path: <netdev+bounces-66361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F583EAD6
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5207B1F25294
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91112E41;
	Sat, 27 Jan 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NmWO1Gln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3611CB3
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328249; cv=none; b=Sp4+msR7YJb/ea5i9SHmhqJ3s5X3WXJVaU/eD1X3L1ozsZgxj6Pt7ttt/vkZ6xeWtGjSQM8aVQYWARpQInv4voceknZ702XMniodZx5fPm6XNoo0OfTKTkV25ODwXoU2qEU/pE2cEZNjkAafUzmbDmoflQkezsvxvwE69PgBD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328249; c=relaxed/simple;
	bh=rPFoX7y/FzQ327gtbuNYIq04xHE3Rh0Jdtm1iHJQRlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfn431Ebjgn3RQCFdtActVaq+Korszv1NNgsTyPTqHzaFCKItpTab/S494909qTbXN294d4HiyJCGF0Sa4YNbf0/6oH5CRGPRjUhmX6Ny+tO+/oRk3YLDeVnRsB4n6Q+/2eBa/xqHMkxBVabj6NdUVNZR072BD0luOu0udn1u5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NmWO1Gln; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5955a4a9b23so628425eaf.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706328247; x=1706933047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJHkq4nBwIbVK7YyQ6gC40pBf6pJSM8m6eSQit08k5c=;
        b=NmWO1GlnHO/Ha8691SxTwaADc3lzxk0J4TDd0rgKA/iPjI9OHyNsYmSLlI8cdCplmw
         mTFCjfSxJ3KQ00dEOX8ESWRm3F7RpVVrFBEcQ4N2UhngUFdpNlpq/Tp3GrypSg+nr+79
         GAYy+D5ScM0camGO6U1symfg2fImJ1VVS2GIzwdD+knfSZZOVmvYkB7KGXLvnMTrpSxm
         UhiteLUKHmRpciqh/nEFUBEmrTTAEgJ/6pkVQUkY9C/DLgaCnVOpM9VqJFNQRw4aiovf
         KmeiUdNQ0hzSpCdeCwQ4Gx1hLuYSU5WfIIZaUQ9MDEQmOIXN7HLIG2rNuD+kdP2oVnix
         ZFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328247; x=1706933047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJHkq4nBwIbVK7YyQ6gC40pBf6pJSM8m6eSQit08k5c=;
        b=fQ3LJ6yfbIK9a7V0jkt+GvRtPwBtynGEWiODOws18fzySfFSuJq5WIjz6qVpMy33bd
         hOfRCsb2HXsNY3YTZThw3MDi0sPAJLJFyb/iAdofT4sMJOjmt6wlTqS4lKx52gnrjzk1
         2MdWgWsGRLvM1sFgqS48x+QgjNJoazpk4Th9bk3/U6LIfi6csONvSXM4qVVDnqFGBZiD
         R9sjangi4G6LiVA39UP1YcczGiOm2Y6agwMe0kqlhKM+wG8idJo17hJFJAk76FKkMM33
         2JK1VSTl4CYnCAUBHSJwnEiWgFg4Bu/5ywHOgOs8xygE8I0gLZQe9+VbvzLuAPUSXZpE
         XVtA==
X-Gm-Message-State: AOJu0YwPsbT4kwWnbhjmQ9n4KnDpFgoKvD29WZATwMXi1zHQps8bmv5v
	ShWyQH7vn1srk7NNcbtOtwJ1wDDu5duvCr1O/DdJJfERazE9SRDkizldYlO/f9o=
X-Google-Smtp-Source: AGHT+IEdcrMAr2goRdDrz6gN6KsKfUHcPpHE/r4BoIgdpKNb0bqokXEuBFSTWCBAoXmHzVKY+Q/HKw==
X-Received: by 2002:a05:6808:128e:b0:3bd:c1b2:b1d5 with SMTP id a14-20020a056808128e00b003bdc1b2b1d5mr1035941oiw.46.1706328247271;
        Fri, 26 Jan 2024 20:04:07 -0800 (PST)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006d9c216a9e6sm1866263pfo.56.2024.01.26.20.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:04:07 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v7 2/4] netdevsim: forward skbs from one connected port to another
Date: Fri, 26 Jan 2024 20:03:52 -0800
Message-Id: <20240127040354.944744-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240127040354.944744-1-dw@davidwei.uk>
References: <20240127040354.944744-1-dw@davidwei.uk>
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
index 969248ffeca8..120a24d74d28 100644
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


