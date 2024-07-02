Return-Path: <netdev+bounces-108513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E836C9240C5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DE71C231AE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC41BA869;
	Tue,  2 Jul 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGPOrTsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842201BA09E;
	Tue,  2 Jul 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930377; cv=none; b=C/T7V2/DDtGlu6xS/BIi/Kt6fuafcuZWi2Md2PjFRQ4Mi8zUWNxdl2IAwqtQg4iOQ2RJFhMOeZsxzRCtp5TnEiUyqzguVolq2FqfBYrux0qFfIDVHYrBYDOil6ebq/2hnA/0Ai+HnrrXf/9Dj0Yk8i0MNe8Ub3MSc5dZGkoMW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930377; c=relaxed/simple;
	bh=KHCrWkl9Se/TbfbJJGjjfw7jH7ZiLIy1EKVjnOWIHYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7BHGyRuKdrDfWb9zZbbWCw+OHo4PEsqC28IkKo0RkTOaBqW2kQkrIdpC0JdMLwok4DkwDZNAXS0jhHu6Yt/z5arS6WRkQeoqGg/hV7c07PIlisZ5m4WXUas1j+64kObBWEHZIPpN7rFlsFZ7zPbBp6ZUZcZ4DSYM1VAcWY3fYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGPOrTsH; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-425680b1d3aso29693455e9.2;
        Tue, 02 Jul 2024 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930374; x=1720535174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQPrrltauyj4cq2R5p8oo5i6avmreGA0Gnt1HK9Fs3o=;
        b=NGPOrTsHSHiGJtV8fybzP84w+ggoVubvyJH8C9uGw15Wbx4UnkMUgvQXLHW3M5NVqo
         DP3H9X4EnkMt//BYss4x58MmYqLReUPbnIRQ74zy7x8bd8gpiVEAFsmRAIXPVCKn3Odz
         V9exDQn+eldRaI+lOywU/Q94fzRe1bo9yelhCwkBvxsx0CYvJTIK8QZuRiTn9RikyxQL
         JA3QGZXHxFVWjDzS+rAXX9HgO0NdRqEKq64vLz1VBypehb57CY0r0ReQE6svSx562llk
         bkLNGjKLWv6CyHOCgWTZytrfsHQJR3xRHHJSqHbNZIMpJ2Lm19+E458eUhbV4vIy77Io
         N+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930374; x=1720535174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQPrrltauyj4cq2R5p8oo5i6avmreGA0Gnt1HK9Fs3o=;
        b=KSE02q6jUAbV5cuoySk7ek+ySRqOGm05lluISRglCdzI7Vtof/bBzi/EfRLXZMJ7U+
         Bs7SKtEgDXYW/9znjBINy2mHi9aadzdhi+C0vxttqh9YMicLATlio3pqYiWVOmGBIuAC
         5r8rg5JsjzsUBCq5CZ3+U7hMlQojD4LR68QP/WjzMmvRvAmChIe1U+Ivxs0x1BUS9GHJ
         si+H/BHTYWdGZJHzSCBx/QxfBqLalF4RsYKY3N1NpLFblUyWf0xlHxs9Yo+DsaHgDDsQ
         dj1tD2sWSjRHxU514TFVI5jdEvyUT5bI5VP5koERIaSjFtODt01dYb45cfLermT0KdrF
         BBPw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcqWlstfM7sXK2IdnZunepIPdJ8Trt+mpobB6mIB2FfMnT1YZ5jPAiSxvMG+e3o74QRuL3/TNi4FeyFwhMIWIFfxQm9Db0KIEoYJGX13jOfQb6Nzh9w2aX/YA2EHKKH+Tbg+r
X-Gm-Message-State: AOJu0Ywm4a2hesEma7krc/e5/0f7hN4YTaYIKm/8V3tm0FuhCq1HZiKK
	SX92QCl7wm/kPcxwTw3/XyoRyiCiXjLtuZC1ob3Q8b1BxDCn/sxT
X-Google-Smtp-Source: AGHT+IFSNK2gBuL1gmt/Jpoyd+WxHJjZK7yJyQGrccllLCNNbRljlwpZH9aeQSKFQVfkUomEdhEy8w==
X-Received: by 2002:a05:600c:4792:b0:425:6207:12b4 with SMTP id 5b1f17b1804b1-4257a03c80emr70301695e9.24.1719930373805;
        Tue, 02 Jul 2024 07:26:13 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b66csm196719445e9.18.2024.07.02.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:26:13 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 2/4] net: dst_cache: add input_dst_cache API
Date: Tue,  2 Jul 2024 16:24:04 +0200
Message-Id: <20240702142406.465415-3-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-1-leone4fernando@gmail.com>
References: <20240702142406.465415-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The input_dst_cache allows fast lookup of frequently encountered dsts.

In order to provide stable results, I implemented a simple linear
hashtable with each bucket containing a constant amount of
entries (DST_CACHE_INPUT_BUCKET_SIZE).

Similarly to how the route hint is used, I defined the hashtable key to
contain the daddr and the tos of the IP header.

Lookup is performed in a straightforward manner: start at the bucket head
corresponding the hashed key and search the following
DST_CACHE_INPUT_BUCKET_SIZE entries of the array for a matching key.

When inserting a new dst to the cache, if all the bucket entries are
full, the oldest one is deleted to make room for the new dst.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/net/dst_cache.h |  68 +++++++++++++++++++++
 net/core/dst_cache.c    | 132 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index b4a55d2d5e71..97500536c421 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -7,12 +7,40 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_fib.h>
 #endif
+#include <net/ip.h>
+
+#define DST_CACHE_INPUT_SHIFT (9)
+#define DST_CACHE_INPUT_SIZE (1 << DST_CACHE_INPUT_SHIFT)
+#define DST_CACHE_INPUT_BUCKET_SIZE (4)
+#define DST_CACHE_INPUT_HASH_MASK (~(DST_CACHE_INPUT_BUCKET_SIZE - 1))
+#define INVALID_DST_CACHE_INPUT_KEY (~(u64)(0))
 
 struct dst_cache {
 	struct dst_cache_pcpu __percpu *cache;
 	unsigned long reset_ts;
 };
 
+extern unsigned int dst_cache_net_id __read_mostly;
+
+/**
+ * idst_for_each_in_bucket - iterate over a dst cache bucket
+ * @pos:	the type * to use as a loop cursor
+ * @head:	the head of the cpu dst cache.
+ * @hash:	the hash of the bucket
+ */
+#define idst_for_each_in_bucket(pos, head, hash)		\
+	for (pos = &head[hash];					\
+	     pos < &head[hash + DST_CACHE_INPUT_BUCKET_SIZE];	\
+	     pos++)
+
+/**
+ * idst_for_each_in_cache - iterate over the dst cache
+ * @pos:	the type * to use as a loop cursor
+ * @head:	the head of the cpu dst cache.
+ */
+#define idst_for_each_in_cache(pos, head)				\
+	for (pos = head; pos < head + DST_CACHE_INPUT_SIZE; pos++)
+
 /**
  *	dst_cache_get - perform cache lookup
  *	@dst_cache: the cache
@@ -106,4 +134,44 @@ int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
  */
 void dst_cache_destroy(struct dst_cache *dst_cache);
 
+/**
+ *	dst_cache_input_get_noref - perform lookup in the input cache,
+ *	return a noref dst
+ *	@dst_cache: the input cache
+ *	@skb: the packet according to which the dst entry will be searched
+ *	local BH must be disabled.
+ */
+struct dst_entry *dst_cache_input_get_noref(struct dst_cache *dst_cache,
+					    struct sk_buff *skb);
+
+/**
+ *	dst_cache_input_add - add the dst of the given skb to the input cache.
+ *
+ *	in case the cache bucket is full, the oldest entry will be deleted
+ *	and replaced with the new one.
+ *	@dst_cache: the input cache
+ *	@skb: The packet according to which the dst entry will be searched
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_input_add(struct dst_cache *dst_cache,
+			 const struct sk_buff *skb);
+
+/**
+ *	dst_cache_input_init - initialize the input cache,
+ *	allocating the required storage
+ */
+int __init dst_cache_input_init(void);
+
+static inline u64 create_dst_cache_key_ip4(const struct sk_buff *skb)
+{
+	struct iphdr *iphdr = ip_hdr(skb);
+
+	return (((u64)ntohl(iphdr->daddr)) << 8) | iphdr->tos;
+}
+
+static inline u32 hash_dst_cache_key(u64 key)
+{
+	return hash_64(key, DST_CACHE_INPUT_SHIFT) & DST_CACHE_INPUT_HASH_MASK;
+}
 #endif
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 70c634b9e7b0..435fd5595fe2 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -13,6 +13,7 @@
 #include <net/ip6_fib.h>
 #endif
 #include <uapi/linux/in.h>
+#include <net/netns/generic.h>
 
 struct dst_cache_pcpu {
 	unsigned long refresh_ts;
@@ -21,9 +22,12 @@ struct dst_cache_pcpu {
 	union {
 		struct in_addr in_saddr;
 		struct in6_addr in6_saddr;
+		u64 key;
 	};
 };
 
+unsigned int dst_cache_net_id __read_mostly;
+
 static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
 				      struct dst_entry *dst, u32 cookie)
 {
@@ -184,3 +188,131 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
 	}
 }
 EXPORT_SYMBOL_GPL(dst_cache_reset_now);
+
+static void dst_cache_input_set(struct dst_cache_pcpu *idst,
+				struct dst_entry *dst, u64 key)
+{
+	dst_cache_per_cpu_dst_set(idst, dst, 0);
+	idst->key = key;
+	idst->refresh_ts = jiffies;
+}
+
+static struct dst_entry *__dst_cache_input_get_noref(struct dst_cache_pcpu *idst)
+{
+	struct dst_entry *dst = idst->dst;
+
+	if (unlikely(dst->obsolete && !dst->ops->check(dst, idst->cookie))) {
+		dst_cache_input_set(idst, NULL, INVALID_DST_CACHE_INPUT_KEY);
+		goto fail;
+	}
+
+	idst->refresh_ts = jiffies;
+	return dst;
+
+fail:
+	return NULL;
+}
+
+struct dst_entry *dst_cache_input_get_noref(struct dst_cache *dst_cache,
+					    struct sk_buff *skb)
+{
+	struct dst_entry *out_dst = NULL;
+	struct dst_cache_pcpu *pcpu_cache;
+	struct dst_cache_pcpu *idst;
+	u32 hash;
+	u64 key;
+
+	pcpu_cache = this_cpu_ptr(dst_cache->cache);
+	key = create_dst_cache_key_ip4(skb);
+	hash = hash_dst_cache_key(key);
+	idst_for_each_in_bucket(idst, pcpu_cache, hash) {
+		if (key == idst->key) {
+			out_dst = __dst_cache_input_get_noref(idst);
+			goto out;
+		}
+	}
+out:
+	return out_dst;
+}
+
+static void dst_cache_input_reset_now(struct dst_cache *dst_cache)
+{
+	struct dst_cache_pcpu *caches;
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+	int i;
+
+	for_each_possible_cpu(i) {
+		caches = per_cpu_ptr(dst_cache->cache, i);
+		idst_for_each_in_cache(idst, caches) {
+			idst->key = INVALID_DST_CACHE_INPUT_KEY;
+			dst = idst->dst;
+			if (dst)
+				dst_release(dst);
+		}
+	}
+}
+
+static int __net_init dst_cache_input_net_init(struct net *net)
+{
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
+
+	dst_cache->cache = (struct dst_cache_pcpu __percpu *)alloc_percpu_gfp(struct dst_cache_pcpu[DST_CACHE_INPUT_SIZE],
+									      GFP_KERNEL | __GFP_ZERO);
+	if (!dst_cache->cache)
+		return -ENOMEM;
+
+	dst_cache_input_reset_now(dst_cache);
+	return 0;
+}
+
+static void __net_exit dst_cache_input_net_exit(struct net *net)
+{
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
+
+	dst_cache_input_reset_now(dst_cache);
+	free_percpu(dst_cache->cache);
+	dst_cache->cache = NULL;
+}
+
+static bool idst_empty(struct dst_cache_pcpu *idst)
+{
+	return idst->key == INVALID_DST_CACHE_INPUT_KEY;
+}
+
+void dst_cache_input_add(struct dst_cache *dst_cache, const struct sk_buff *skb)
+{
+	struct dst_cache_pcpu *entry = NULL;
+	struct dst_cache_pcpu *pcpu_cache;
+	struct dst_cache_pcpu *idst;
+	u32 hash;
+	u64 key;
+
+	pcpu_cache = this_cpu_ptr(dst_cache->cache);
+	key = create_dst_cache_key_ip4(skb);
+	hash = hash_dst_cache_key(key);
+	idst_for_each_in_bucket(idst, pcpu_cache, hash) {
+		if (idst_empty(idst)) {
+			entry = idst;
+			goto add_to_cache;
+		}
+		if (!entry || time_before(idst->refresh_ts, entry->refresh_ts))
+			entry = idst;
+	}
+
+add_to_cache:
+	dst_cache_input_set(entry, skb_dst(skb), key);
+}
+
+static struct pernet_operations dst_cache_input_ops __net_initdata = {
+	.init = dst_cache_input_net_init,
+	.exit = dst_cache_input_net_exit,
+	.id   = &dst_cache_net_id,
+	.size = sizeof(struct dst_cache),
+};
+
+int __init dst_cache_input_init(void)
+{
+	return register_pernet_subsys(&dst_cache_input_ops);
+}
+subsys_initcall(dst_cache_input_init);
-- 
2.34.1


