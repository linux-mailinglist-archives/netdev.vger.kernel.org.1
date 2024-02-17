Return-Path: <netdev+bounces-72616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D24858D46
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B701D1C21316
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615E1CA8E;
	Sat, 17 Feb 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="u60yxPNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6D1C2B2
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146264; cv=none; b=fJ9Tl2wQGOBcPyeWrbl+18FltwI43p+EuXt/c3TM3oJs2pa80PWOW09ZekYi8lK7i0DtGbR6Zm5K6pEicdediPnIfwu478fH8XA/FwOb64hvVKoEKoNdfC/2nzOAUz7ybyDZE+DFBRG007oJ9ThxhcmFIujB+Q3XS7uGJrjLh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146264; c=relaxed/simple;
	bh=WuVQ9tyy4qXVzj8fg5jT1T8KjKLN2WSR7176fQweBTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuJuWMKwMpVs2cWrM+W75nNBZDdR1IBrsXZFX6f0+okuIF7aOy21bUSBRvh4gaUYeobEoWYZeGeIUAmnzEi4JKtyGewV6BJsKbNJsg44IqdqXnGbxjrUWNG4HQdlcsTJhxL+0vx9AeL5qycZ3Qp7oGx4mLWRAfM05lK6EqTKOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=u60yxPNG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2163600a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708146262; x=1708751062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=u60yxPNGGiAgo4/Jr5mjmLAFcVthNGBdLdnVZZcW5CEPccWIuzCdjKw7CpXyNG+YYH
         2j/vtdb5wZLbnsD5m3XrPsSGLEuhpFaGlfqJDbg0yM6Ke+gbwNwrtV5RtGf9hjiNXMp/
         QnAn8DGaDMbnWAHBQ+X2ExeLs4sgsKh1Ir39BleTRujLCfwIApYHxc6z78YRTk1C2gOL
         P1O4Fqe/ZOiH7Bl4XYo7pub0XCbh4d710pXqkwGhSJUmoZt3msqsH1qioRftKYRVz70T
         c2SitlLEcYSG0u5dwwun1i5dSyzxwRhkkV2IuB5ANPziUmWFRvzsXtAWZ5qSrcQR1t9H
         pDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146262; x=1708751062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVNOE9NzOpHv+S2/C5c0rGW7n1qxuHkxnBJNavNR7kw=;
        b=kfty+6hmaV2Fb5345MmazTFRFsAZP6uxN0aWnhLgiUQiEUZQhBULHu56J7X4cl4eqR
         qLOfNZb1bdNIR3/5E+qmIRZhKrLm4ON4K9J5l4Ec53km+XTWnuAN/bdF8k8KkvKfXzxx
         PCRK65ljayXBNpKIWhj2i8WvNglDE4qPP7OSVmDqVpLViTzBcGQf/YEhLMkYjXq4lsrB
         2JclRL4nUXuNaGpLS3kIHTCZxxUFD2RIRiMz6SGpYeIHjKmGTmnFLfV+5dyPtikWPOti
         yzJUNk+rV75F8OO6LhvexkfkQa6ZA+PWoMIM0+3vs+5HP92L9+tKSKaGza5SVeQwHjBW
         Ne2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM5nUUslByr9mDz1pNC6ERZ+P9ZvPQCIG+Wvd8g/4RKxIFpi5WiZmrz/AAF8aQkB+YhmTiVcZ/SHA2HjYCD9kLGE7bWLFZ
X-Gm-Message-State: AOJu0YyThEkWNUwCYt/wKU2z4JAoTnUG1H8N2cQ7IZnaaat6EKz2iJbD
	tsjyOYis6NqJa+PNQfBZn0eZdM0GSlXqeD5ORRS+8CBfwpmdVadE0qcZJ1j4FVo=
X-Google-Smtp-Source: AGHT+IE/zDv5gTgvueeCqai2GKPmFMqVjvLyQBvuSmedaqXlH+Zz40BSN4t3E2QmYp+i5NMVHM7tHg==
X-Received: by 2002:a05:6a00:2fd1:b0:6db:d2f5:9e28 with SMTP id fn17-20020a056a002fd100b006dbd2f59e28mr6817820pfb.10.1708146262172;
        Fri, 16 Feb 2024 21:04:22 -0800 (PST)
Received: from localhost (fwdproxy-prn-111.fbsv.net. [2a03:2880:ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id fj36-20020a056a003a2400b006e04d2be954sm773766pfb.187.2024.02.16.21.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:04:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v12 2/4] netdevsim: forward skbs from one connected port to another
Date: Fri, 16 Feb 2024 21:04:16 -0800
Message-Id: <20240217050418.3125504-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240217050418.3125504-1-dw@davidwei.uk>
References: <20240217050418.3125504-1-dw@davidwei.uk>
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


