Return-Path: <netdev+bounces-34375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7C7A3F7C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC012813AD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14530EA5;
	Mon, 18 Sep 2023 02:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386C636
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:41:23 +0000 (UTC)
Received: from out-229.mta0.migadu.com (out-229.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205411F
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 19:41:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695004880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kCSUcAtTd0hKjmGAppoVTb+EEz2LPzSDyK6JtUSP2o4=;
	b=mU27p+F3UEK7SyGBy8bwlgUd8sVCSmLkTmvLW1oO4Vr4mS4A+p80U8AMgKlCyPrfpaPUqf
	Zhk7+t/zCrlOXBQUqE/tj6MiTeKL+wNs+c6Lkuxm45ZBh/hGQvcCea0e292hKekQNJnl2B
	63qp/wsAN8neRPsKuwf/Mwjb5hIR72k=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v4] net/core: Introduce netdev_core_stats_inc() for trace
Date: Mon, 18 Sep 2023 10:40:55 +0800
Message-Id: <20230918024055.221900-1-yajun.deng@linux.dev>
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

Although there is a kfree_skb_reason() helper function that can be used to
find the reason why this skb is dropped, but most callers didn't increase
one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

For the users, people are more concerned about why the dropped in ip
is increasing.

Introduce netdev_core_stats_inc() for trace. Also, move dev_core_stats()
and netdev_core_stats_alloc() to dev.c, as they are not called externally.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v4: Introduce netdev_core_stats_inc() instead of export dev_core_stats_*_inc()
v3: __cold should be added to the netdev_core_stats_alloc().
v2: use __cold instead of inline in dev_core_stats().
v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
---
 include/linux/netdevice.h | 21 ++++-----------------
 net/core/dev.c            | 26 ++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..cddd4873b5b0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3980,32 +3980,19 @@ static __always_inline bool __is_skb_forwardable(const struct net_device *dev,
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
+void netdev_core_stats_inc(struct net_device *dev, u32 offset);
 
 #define DEV_CORE_STATS_INC(FIELD)						\
 static inline void dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
 {										\
-	struct net_device_core_stats __percpu *p;				\
-										\
-	p = dev_core_stats(dev);						\
-	if (p)									\
-		this_cpu_inc(p->FIELD);						\
+	netdev_core_stats_inc(dev,						\
+			offsetof(struct net_device_core_stats, FIELD));		\
 }
 DEV_CORE_STATS_INC(rx_dropped)
 DEV_CORE_STATS_INC(tx_dropped)
 DEV_CORE_STATS_INC(rx_nohandler)
 DEV_CORE_STATS_INC(rx_otherhost_dropped)
+#undef DEV_CORE_STATS_INC
 
 static __always_inline int ____dev_forward_skb(struct net_device *dev,
 					       struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index ccff2b6ef958..f4cccdf05450 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10475,7 +10475,8 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
 }
 EXPORT_SYMBOL(netdev_stats_to_stats64);
 
-struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
+static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(
+		struct net_device *dev)
 {
 	struct net_device_core_stats __percpu *p;
 
@@ -10488,7 +10489,28 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
 	/* This READ_ONCE() pairs with the cmpxchg() above */
 	return READ_ONCE(dev->core_stats);
 }
-EXPORT_SYMBOL(netdev_core_stats_alloc);
+
+static inline struct net_device_core_stats __percpu *netdev_core_stats(
+		struct net_device *dev)
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
+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+	struct net_device_core_stats __percpu *p;
+
+	p = netdev_core_stats(dev);
+	if (p)
+		this_cpu_inc(*(unsigned long *)((void *)p + offset));
+}
+EXPORT_SYMBOL_GPL(netdev_core_stats_inc);
 
 /**
  *	dev_get_stats	- get network device statistics
-- 
2.25.1


