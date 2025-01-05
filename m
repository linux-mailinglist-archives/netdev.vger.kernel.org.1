Return-Path: <netdev+bounces-155262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F22AA018C6
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478447A1477
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336215336D;
	Sun,  5 Jan 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMBCJwym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C73596B
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736068169; cv=none; b=cwE7rs9NrYTR8bp5h7FTzA0hRtWlgYA91sLuPK1WAoMJrlQ+ICcqvonMNaYtGPoMs9SpcUYMwW59QEoQqTNo9Y6Bes0ZqssQfbE0s+dxC9oNze8iyVahM7cn3R4GUMFK5jFCCU5dwhvOJV16TUxi1G90ZuZDF9aIL8X6eorWjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736068169; c=relaxed/simple;
	bh=/xnNO9TISs+yVenEk0v7gT15iZl/b8BbM5ViCal019M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uEm2hlWG+Oe3XoMGgnDQ5cf+Ncb+Oba5yYoAg7S+TTl1NvPauxaJPVqQ+R64KL2xTBBuQLoH5+EdngU/UcXN2GNIR5Cwv/gjGZo5c6MrE6prCva+SU5BW4WxVZR6LUec/VJNsPabb26n+Hy1Qq0b5YCMfuY/MOvmrs8eX4+LaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMBCJwym; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d92efa9ff4so218625766d6.2
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 01:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736068166; x=1736672966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dI0nUrl2pcJCuKnnBYgOFpX8d+4DDDeKXbJGIhURel8=;
        b=sMBCJwymDLppO4u/HUuHsecbSAnP8wUUVpADNCkuJ4EZP7cNN+xOeijYdVx2WsVYkx
         JgpRgejLUoTp7ab6S0Ar8KBXf8Px7uOqqY9cqnrzKwg+T2bGOqZvsZ1whTFddPV3qPke
         v++jxhsisA7NruPr+IGHczDh1DzO5ma+3WngA+PH5+U7z3swMLOXfDR5vKMbjvc8yk1r
         fs6YWe/E9Q/8HeF94x9WQ2/ejfjpA2YO7yU8NWdCsK85lc4H/9I7hNeb44pBNeAH24Z3
         wDdOsiRdqNGVV3e0bAZIP5Npd/mOGZgc38khaSwUkHcrN1LTFKq3j9TH7KXjYw2a54F5
         aKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736068166; x=1736672966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI0nUrl2pcJCuKnnBYgOFpX8d+4DDDeKXbJGIhURel8=;
        b=O1xwlW34hMk+H+ZacA2SalRTabeNLPo2i94foF4xCZF+f2aK96dy2+mhHVpqibaOyA
         qwdv0kkAtPk7h+fC/lTmyiqcO1v8yE3Wc5Xl95FYeviGkUxCIc91QBgxAFyA9cW/nzqT
         IYbQTqHEfUXXkBVCHrGxHi2aCjQS8hFGpUNSc607OqDRkTccBHdo2Kxsus+0V4tSepqe
         K9GMcXe5W+xZr1MZxhf5AOY6AiKl9UmsY8t25iupHepNltgtaYqhklFfnZ2kpMdH8lM6
         VJVDFyzTpaRpJmrnv44j6oNkKd2yUDweNSzX3CUK2UPIhxHdYNMlyzP3fJIB7rlDN35N
         ugsQ==
X-Gm-Message-State: AOJu0YyWw2mrCfOGV4caOuz+AhAJ8gs3sWMkDVe9wH0HxiPhTlGdHgI5
	ZLD3MnEOh1ODgEP3iDPLMLhXE/KFmoD8i1R4wGrVF+IKBtxY++dYUrbY444abGcptcQ1lxrM5KS
	EOxiRIDkJow==
X-Google-Smtp-Source: AGHT+IHy34lkewUo5IuVEzJVmY9LA6RfOw+YGY2bXQyKdJOv5/xhTX2CZIt2Lmosq9qCSLSrGldD4VgkkXq0fw==
X-Received: from qtei11.prod.google.com ([2002:a05:622a:8cb:b0:467:7c6d:5bba])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5ce8:0:b0:6d8:8d16:7cec with SMTP id 6a1803df08f44-6dd23397b76mr735273536d6.37.1736068166369;
 Sun, 05 Jan 2025 01:09:26 -0800 (PST)
Date: Sun,  5 Jan 2025 09:09:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250105090924.1661822-1-edumazet@google.com>
Subject: [PATCH net-next] net: watchdog: rename __dev_watchdog_up() and dev_watchdog_down()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"

In commit d7811e623dd4 ("[NET]: Drop tx lock in dev_watchdog_up")
dev_watchdog_up() became a simple wrapper for __netdev_watchdog_up()

Herbert also said : "In 2.6.19 we can eliminate the unnecessary
__dev_watchdog_up and replace it with dev_watchdog_up."

This patch consolidates things to have only two functions, with
a common prefix.

- netdev_watchdog_up(), exported for the sake of one freescale driver.
  This replaces __netdev_watchdog_up() and dev_watchdog_up().

- netdev_watchdog_down(), static to net/sched/sch_generic.c
  This replaces dev_watchdog_down().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/net/ethernet/freescale/ucc_geth.c |  2 +-
 include/linux/netdevice.h                 |  2 +-
 net/core/dev.c                            |  2 +-
 net/sched/sch_generic.c                   | 33 ++++++++++-------------
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f47f8177a93b46e4456388d33e03b0098d6afa22..88510f822759607b34d99e03225a2621fe3039d4 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1434,7 +1434,7 @@ static void ugeth_activate(struct ucc_geth_private *ugeth)
 
 	/* allow to xmit again  */
 	netif_tx_wake_all_queues(ugeth->ndev);
-	__netdev_watchdog_up(ugeth->ndev);
+	netdev_watchdog_up(ugeth->ndev);
 }
 
 /* Initialize TBI PHY interface for communicating with the
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1614f3b8c037afb4ba4fa740c7d51..7f9d14c549c81ccf6d5acf97dffc3b724e3efdce 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4295,7 +4295,7 @@ static inline bool netif_carrier_ok(const struct net_device *dev)
 
 unsigned long dev_trans_start(struct net_device *dev);
 
-void __netdev_watchdog_up(struct net_device *dev);
+void netdev_watchdog_up(struct net_device *dev);
 
 void netif_carrier_on(struct net_device *dev);
 void netif_carrier_off(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aafea345ea55c576231be3bf1cef02..54a90f7942932679a76c7be1aa5966f6798784fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3233,7 +3233,7 @@ void netif_device_attach(struct net_device *dev)
 	if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
 	    netif_running(dev)) {
 		netif_tx_wake_all_queues(dev);
-		__netdev_watchdog_up(dev);
+		netdev_watchdog_up(dev);
 	}
 }
 EXPORT_SYMBOL(netif_device_attach);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 8874ae6680952a0531cc5175e1de8510e55914ea..bb7dd351bd651d4aa16945816ee26df3c4a48645 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -551,25 +551,20 @@ static void dev_watchdog(struct timer_list *t)
 		netdev_put(dev, &dev->watchdog_dev_tracker);
 }
 
-void __netdev_watchdog_up(struct net_device *dev)
-{
-	if (dev->netdev_ops->ndo_tx_timeout) {
-		if (dev->watchdog_timeo <= 0)
-			dev->watchdog_timeo = 5*HZ;
-		if (!mod_timer(&dev->watchdog_timer,
-			       round_jiffies(jiffies + dev->watchdog_timeo)))
-			netdev_hold(dev, &dev->watchdog_dev_tracker,
-				    GFP_ATOMIC);
-	}
-}
-EXPORT_SYMBOL_GPL(__netdev_watchdog_up);
-
-static void dev_watchdog_up(struct net_device *dev)
+void netdev_watchdog_up(struct net_device *dev)
 {
-	__netdev_watchdog_up(dev);
+	if (!dev->netdev_ops->ndo_tx_timeout)
+		return;
+	if (dev->watchdog_timeo <= 0)
+		dev->watchdog_timeo = 5*HZ;
+	if (!mod_timer(&dev->watchdog_timer,
+		       round_jiffies(jiffies + dev->watchdog_timeo)))
+		netdev_hold(dev, &dev->watchdog_dev_tracker,
+			    GFP_ATOMIC);
 }
+EXPORT_SYMBOL_GPL(netdev_watchdog_up);
 
-static void dev_watchdog_down(struct net_device *dev)
+static void netdev_watchdog_down(struct net_device *dev)
 {
 	netif_tx_lock_bh(dev);
 	if (del_timer(&dev->watchdog_timer))
@@ -591,7 +586,7 @@ void netif_carrier_on(struct net_device *dev)
 		atomic_inc(&dev->carrier_up_count);
 		linkwatch_fire_event(dev);
 		if (netif_running(dev))
-			__netdev_watchdog_up(dev);
+			netdev_watchdog_up(dev);
 	}
 }
 EXPORT_SYMBOL(netif_carrier_on);
@@ -1267,7 +1262,7 @@ void dev_activate(struct net_device *dev)
 
 	if (need_watchdog) {
 		netif_trans_update(dev);
-		dev_watchdog_up(dev);
+		netdev_watchdog_up(dev);
 	}
 }
 EXPORT_SYMBOL(dev_activate);
@@ -1366,7 +1361,7 @@ void dev_deactivate_many(struct list_head *head)
 			dev_deactivate_queue(dev, dev_ingress_queue(dev),
 					     &noop_qdisc);
 
-		dev_watchdog_down(dev);
+		netdev_watchdog_down(dev);
 	}
 
 	/* Wait for outstanding qdisc-less dev_queue_xmit calls or
-- 
2.47.1.613.gc27f4b7a9f-goog


