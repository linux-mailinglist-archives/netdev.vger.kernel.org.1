Return-Path: <netdev+bounces-94113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FC98BE26B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EE7284A09
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28B15B995;
	Tue,  7 May 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV0pymax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC04158D9C;
	Tue,  7 May 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085860; cv=none; b=PNxTrclI+TtC4aJ+eCqctHncLilKAILfC/lc5yq6X+yErLefMOx7al9makha2p51kGg4gsIV47AuKBT7NQR2SARaPri/F8UE3nw3SsUcFhKVXz4GOREkSzDuXrKtMJW8T4c/Nbv9o2oOnU4XGVmWz89RAHO1YBkyF3exOtpx9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085860; c=relaxed/simple;
	bh=uM5sJnWrOplndwtlhh0T7d3Eeti4vJVik1sqvT2i43A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pjIUxWz7Fn7Zg0Ln+kHfWvplmCWlbl37Zam9s2swpGRqDfnzhyGo5A0KrkRN+vvMtqg7UD07MG1Mf6b/RnjhnT7p0glJydN+thhTr9TmBsgL61WKNQxXyVPADQDw9Jq+jAlFTGObkpjSdhStVbbTChgJIJoRR5tAjwFSTVNGTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV0pymax; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso1996057f8f.1;
        Tue, 07 May 2024 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085857; x=1715690657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWpqb3t6CANxEDWhaC7kiYcjYm92T0oXtF4rwdCOiDo=;
        b=JV0pymaxgFKwP2tlaOKWQ2DUoQ9ZW0aRvOM6w1YCEzKbI+LvZXIXf1yP8xQBIqqUZO
         Hj//BAwgECR3AV1xNSO9+NjLSBKooJnK099P/VTE7BDzV6gmPLT3W0Zy9z7CjWSLk9VJ
         DFo/Egvkqe4dLUa7KUUegz1uCQAOpxntiURYzsE/eoF1sxlWuHiXcarSQF0VPvw4kzyO
         x3TFsNpbxlzVxOeeaWJ+Cb/tqoeSwVqrRex36lkbS/aaaYHqDOU3sd1M/tiSShVL2efA
         rZ85TnVRy7UaobFQakyFPE42Lxrx2WfR8xNj8LXL4LUnF08nPv4En8SlzGRIIO7uMNVV
         TDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085857; x=1715690657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWpqb3t6CANxEDWhaC7kiYcjYm92T0oXtF4rwdCOiDo=;
        b=soePD6Ef5kGSQySnRNdAoV8vh4ZYOHHIkKv7A6GR+ro16LPaufpflXNQitUz6VMlal
         DVeCSMvP8DfCjoSocyo1he1VtBKdYqPFfUMjCJaQ92uCKP+r17fTFJlgaYH6XxUXlG6a
         hQRroIQCZ8C+OvnY2vipRd5VgRdHTxVnvvfN5LmoqokRp3jy0a+dxJpU/ob8snLxQBd9
         /Z5Xp6EcHKoJl78I30541JSdBt5VWEy5FzWNspFCCnEIUTv7JGVEaS4XfgL/RBfU0Xtd
         S4Iqw/t6sQWctatsTqFCGZ1BFRmBwJc4IDMUTUOX9LWqI+XiG2OlA/p3PscR2lwKUM7d
         MQyw==
X-Forwarded-Encrypted: i=1; AJvYcCX4tipqnd2kpUguqtQ0tukOcZs4y+HCKH+gcrmH5dxVVUQCdIPekZR4KFo5XTVzfqamu2QuJ8h9RIzEV3XUZ3FDA3i1CTxL+/H+BiWSg/HVdjbIG1/vrxvTskULyDEULjnH9FTW
X-Gm-Message-State: AOJu0YyuNZhlbbKMXskwhSnzFNyl0HMvI8iwV4ZPkZSo2mUPXGKJt6PL
	ty7hNou0FQIt/lCDkGkj3fHcshziwQ1zXgIynqwrREAR4l0ar7Jx
X-Google-Smtp-Source: AGHT+IHgawRJtasMMLApQc5OHFyDRvuX4yFM6a3R+XcG8MbgkY8XrJ4Xajdc8fdCyowexgppBftf2w==
X-Received: by 2002:adf:ebd2:0:b0:34f:824:17b2 with SMTP id v18-20020adfebd2000000b0034f082417b2mr3978192wrn.65.1715085856605;
        Tue, 07 May 2024 05:44:16 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm12864608wrr.12.2024.05.07.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:44:16 -0700 (PDT)
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
Date: Tue,  7 May 2024 14:42:27 +0200
Message-Id: <20240507124229.446802-3-leone4fernando@gmail.com>
In-Reply-To: <20240507124229.446802-1-leone4fernando@gmail.com>
References: <20240507124229.446802-1-leone4fernando@gmail.com>
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
index df6622a5fe98..b6f012ffeb86 100644
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
index 0c0bdb058c5b..843da4679488 100644
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
@@ -181,3 +185,131 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
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


