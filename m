Return-Path: <netdev+bounces-32771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E379A5E5
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6262810D7
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3CAD39;
	Mon, 11 Sep 2023 08:20:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5773D8C
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 08:20:41 +0000 (UTC)
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5891BB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 01:20:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694420436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8KgKH+XjJLXOnaYRASDb5V6iMHBTszQ5jP3aUDJPyM=;
	b=GDg0wedFWadWwg2xEaAmtg9r1uKbJBgDY3VuvBno+uV/us+TU+Tybz0KzEK8T5xLHRyM0G
	sn5ysv8xw9YFLGSxuvaZFhKQrIyWAWnjITVN2FTSMpmgBMRssfGpMLmranpvZXpvV/oTG8
	mW9Gq3w7upw/hJnUq8YZITIoGDihbDQ=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Date: Mon, 11 Sep 2023 16:20:16 +0800
Message-Id: <20230911082016.3694700-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Although there is a kfree_skb_reason() helper function that can be used
to find the reason for dropped packets, but most callers didn't increase
one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

For the users, people are more concerned about why the dropped in ifconfig
is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
which users would trace them know why rx_dropped is increasing.

Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
and netdev_core_stats_alloc() in dev.c, because they are not called
externally.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/netdevice.h | 32 +++++---------------------------
 net/core/dev.c            | 30 ++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..879b01c85ba4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3954,6 +3954,11 @@ int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);
 bool is_skb_forwardable(const struct net_device *dev,
 			const struct sk_buff *skb);
 
+void dev_core_stats_rx_dropped_inc(struct net_device *dev);
+void dev_core_stats_tx_dropped_inc(struct net_device *dev);
+void dev_core_stats_rx_nohandler_inc(struct net_device *dev);
+void dev_core_stats_rx_otherhost_dropped_inc(struct net_device *dev);
+
 static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
 						 const struct sk_buff *skb,
 						 const bool check_mtu)
@@ -3980,33 +3985,6 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
 	return false;
 }
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev);
-
-static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
-{
-	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
-	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
-
-	if (likely(p))
-		return p;
-
-	return netdev_core_stats_alloc(dev);
-}
-
-#define DEV_CORE_STATS_INC(FIELD)						\
-static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
-{										\
-	struct net_device_core_stats __percpu *p;				\
-										\
-	p = dev_core_stats(dev);						\
-	if (p)									\
-		this_cpu_inc(p->FIELD);						\
-}
-DEV_CORE_STATS_INC(rx_dropped)
-DEV_CORE_STATS_INC(tx_dropped)
-DEV_CORE_STATS_INC(rx_nohandler)
-DEV_CORE_STATS_INC(rx_otherhost_dropped)
-
 static __always_inline int ____dev_forward_skb(struct net_device *dev,
 					       struct sk_buff *skb,
 					       const bool check_mtu)
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..32ba730405b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
+static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
 {
 	struct net_device_core_stats __percpu *p;
 
@@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
 	/* This READ_ONCE() pairs with the cmpxchg() above */
 	return READ_ONCE(dev->core_stats);
 }
-EXPORT_SYMBOL(netdev_core_stats_alloc);
+
+static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
+{
+	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
+	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
+
+	if (likely(p))
+		return p;
+
+	return netdev_core_stats_alloc(dev);
+}
+
+#define DEV_CORE_STATS_INC(FIELD)				\
+void dev_core_stats_##FIELD##_inc(struct net_device *dev)	\
+{								\
+	struct net_device_core_stats __percpu *p;		\
+								\
+	p = dev_core_stats(dev);				\
+	if (p)							\
+		this_cpu_inc(p->FIELD);				\
+}								\
+EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)
+
+DEV_CORE_STATS_INC(rx_dropped);
+DEV_CORE_STATS_INC(tx_dropped);
+DEV_CORE_STATS_INC(rx_nohandler);
+DEV_CORE_STATS_INC(rx_otherhost_dropped);
 
 /**
  *	dev_get_stats	- get network device statistics
-- 
2.25.1


