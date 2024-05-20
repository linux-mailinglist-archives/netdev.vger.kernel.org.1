Return-Path: <netdev+bounces-97180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DD8C9BBA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8361F2117B
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B5446D1;
	Mon, 20 May 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrY8PqCN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537B225AE
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202813; cv=none; b=mKxlD2TkBrZ7FtagoEyNZo5hWfJZmyuzyOKjCjN5gCQFgSpELp927cYvWfIDMhf7ih7inI4YJVfEX+dN1Yef7E6cSJW2JK1vnawcQwQ8OPBDu7qmjiFmxgLE/n0MTw/HPJzFnmh2TQGrBO0AGqcIv2+NpSS1Jprfq2/0DoPoTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202813; c=relaxed/simple;
	bh=1MqSejSVzwrUHZP1S3sZbtj2OlmBf5HrWT/JjmPLoYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tE0HLGGUqcIjfznLonzW7aRLqHrbMQ55DljKRv4fQ9Lgy/ge4Yq39tW4dc85BBKU8DcHAaaJm1g3ewlzePzXmxgr4NQBef8Ryp7wr/8fnyd9VP/Wxf9PJu7JljwSaR4FBDoXu7YHTtBtE5LQ1/IGykMvNiMqv8cu5jjKbvPHkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrY8PqCN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716202810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFjt+LndmWrx4uf6imk82Wpuwv4oWRNDmX2W1i8/T0g=;
	b=YrY8PqCNgKLwUYkcHSMfl6zzTQibpz4SbaI2mM7YzmWDV93C0wxJsYo6+w9slr8AUV43+b
	vULFeENPYfQFtOv+7G429rTP1yXf1ptrKXbzMckNDXHhX4f9ZyRVaP0gI0c1g27c9Fv5tr
	M3V7+YMYRMEStbWHDS2acsjMT4XwOm0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-S_yIO5NDPU6wE9Uwz7eGSw-1; Mon, 20 May 2024 07:00:03 -0400
X-MC-Unique: S_yIO5NDPU6wE9Uwz7eGSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B694857A81;
	Mon, 20 May 2024 11:00:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.221])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 791B4C15BB1;
	Mon, 20 May 2024 11:00:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [RFC PATCH] net: flush dst_cache on device removal
Date: Mon, 20 May 2024 12:59:14 +0200
Message-ID: <13bccadd7dcc66283898cde11520918670e942db.1716202430.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Eric reported that dst_cache don't cope correctly with device removal,
keeping the cached dst unmodified even when the underlining device is
deleted and the dst itself is not uncached.

The above causes the infamous 'unregistering netdevice' hangup.

Address the issue implementing explicit book-keeping of all the
initialized dst_caches. At network device unregistration time, traverse
them, looking for relevant dst and eventually replace the dst reference
with a blackhole one.

Use an xarray to store the dst_cache references, to avoid blocking the
BH during the traversal for a possibly unbounded time.

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 911362c70df5 ("net: add dst_cache support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I can't reproduce the issue locally, I hope somebody able to observe it
could step-in and give this patch a shot.
---
 include/net/dst_cache.h |   1 +
 net/core/dst_cache.c    | 100 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index b4a55d2d5e71..4d0302e143b4 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -11,6 +11,7 @@
 struct dst_cache {
 	struct dst_cache_pcpu __percpu *cache;
 	unsigned long reset_ts;
+	u32 id;
 };
 
 /**
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 6a0482e676d3..22921cc9d42c 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -7,6 +7,8 @@
 
 #include <linux/kernel.h>
 #include <linux/percpu.h>
+#include <linux/xarray.h>
+#include <linux/rcupdate_wait.h>
 #include <net/dst_cache.h>
 #include <net/route.h>
 #if IS_ENABLED(CONFIG_IPV6)
@@ -14,6 +16,13 @@
 #endif
 #include <uapi/linux/in.h>
 
+static DEFINE_XARRAY_FLAGS(dst_caches, XA_FLAGS_ALLOC);
+
+struct dst_cache_entry {
+	struct dst_cache_pcpu __percpu *cache;
+	struct rcu_head rcu;
+};
+
 struct dst_cache_pcpu {
 	unsigned long refresh_ts;
 	struct dst_entry *dst;
@@ -140,27 +149,60 @@ EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
 
 int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
 {
+	struct dst_cache_entry *entry;
+	int last_id, ret = -ENOMEM;
+
 	dst_cache->cache = alloc_percpu_gfp(struct dst_cache_pcpu,
 					    gfp | __GFP_ZERO);
 	if (!dst_cache->cache)
 		return -ENOMEM;
 
+	entry = kmalloc(sizeof(*entry), gfp | __GFP_ZERO);
+	if (!entry)
+		goto free_cache;
+
+	ret = xa_alloc_cyclic_bh(&dst_caches, &dst_cache->id, entry,
+				 xa_limit_32b, &last_id, gfp);
+	if (ret < 0)
+		goto free_entry;
+
+	entry->cache = dst_cache->cache;
 	dst_cache_reset(dst_cache);
 	return 0;
+
+free_entry:
+	kfree(entry);
+
+free_cache:
+	free_percpu(dst_cache->cache);
+	dst_cache->cache = NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dst_cache_init);
 
+static void dst_cache_entry_free(struct rcu_head *rcu)
+{
+	struct dst_cache_entry *entry = container_of(rcu, struct dst_cache_entry, rcu);
+
+	free_percpu(entry->cache);
+	kfree(entry);
+}
+
 void dst_cache_destroy(struct dst_cache *dst_cache)
 {
+	struct dst_cache_entry *entry;
 	int i;
 
 	if (!dst_cache->cache)
 		return;
 
+	entry = xa_erase_bh(&dst_caches, dst_cache->id);
+
 	for_each_possible_cpu(i)
 		dst_release(per_cpu_ptr(dst_cache->cache, i)->dst);
 
-	free_percpu(dst_cache->cache);
+	if (!WARN_ON_ONCE(!entry))
+		call_rcu(&entry->rcu, dst_cache_entry_free);
 }
 EXPORT_SYMBOL_GPL(dst_cache_destroy);
 
@@ -182,3 +224,59 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
 	}
 }
 EXPORT_SYMBOL_GPL(dst_cache_reset_now);
+
+static void dst_cache_flush_dev(struct dst_cache_entry *entry,
+				struct net_device *dev)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct dst_cache_pcpu *idst = per_cpu_ptr(entry->cache, i);
+		struct dst_entry *dst = READ_ONCE(idst->dst);
+
+		if (!dst || !dst_hold_safe(dst))
+			continue;
+
+		if (!list_empty(&dst->rt_uncached) || dst->dev != dev)
+			goto release;
+
+		dst->dev = blackhole_netdev;
+		netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
+				   GFP_ATOMIC);
+
+release:
+		dst_release(dst);
+	}
+}
+
+static int dst_cache_netdev_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct dst_cache_entry *entry;
+	XA_STATE(xas, &dst_caches, 0);
+
+	if (event == NETDEV_UNREGISTER) {
+		rcu_read_lock();
+		xas_for_each(&xas, entry, UINT_MAX) {
+			dst_cache_flush_dev(entry, dev);
+			if (need_resched()) {
+				xas_pause(&xas);
+				cond_resched_rcu();
+			}
+		}
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block dst_cache_notifier = {
+	.notifier_call = dst_cache_netdev_event,
+};
+
+static int __init dst_cache_notifier_init(void)
+{
+	return register_netdevice_notifier(&dst_cache_notifier);
+}
+
+subsys_initcall(dst_cache_notifier_init);
-- 
2.43.2


