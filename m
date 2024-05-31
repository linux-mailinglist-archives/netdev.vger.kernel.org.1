Return-Path: <netdev+bounces-99822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092848D6988
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A96A1F29B7C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFE17D36D;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHyvid1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6017C223;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182899; cv=none; b=R58pE8utdr/kActYAhvpmSWthGiGjBdSzDZO9xLcJQF5+sqYmvI2CC6UDbU9vhD9+jjxwJjFOzk0pf/EP/ZjHfoZSa4Wmcywb6/LR3PZM8jHf0hBDxe866mqIFmU8a50FtcmYFk10NI6FQyOKT6ppXQ7GnlN9G3Yx/oAt8hSd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182899; c=relaxed/simple;
	bh=XkviX316F0sKgldrjJOcJuBh0F8cjTJAd80cswOqbm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQ0nQePeKPjZHCML/FEs+Dz8Ax5XCH6FV0Ef09uYEpuHU5s5v9q7Mq6HDQehpioMNaiGS4xpLuk6E+NRP2aAFXJ/441cv70yTGnXeMxeXQtP3V0upIpA3GCn7jNHhOyI5asd+Qn8BJUL/2TQJr1jjLxLGtGTMkXPo+9PtEX2e3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHyvid1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D6DC2BD10;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=XkviX316F0sKgldrjJOcJuBh0F8cjTJAd80cswOqbm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHyvid1au2bNZGaV6rOixhLrq7MOiYrCabUnzi41Dq7pBGjPqlrp75IbJCIY5pV1Z
	 BEm+D3cxHrLXZ6YiK+11FkthPYzaZXvGMGzmn081Ctt/wSWCsyKbSmE6XUrZ7z87eb
	 N6IBJnM/Xv6hLwqjIuh9H0aihfk+/hmR7CY65Qv1zbDJ9BtEqoTj6H1Z//O+JerERB
	 JoRXwfHXZ0u9sWPlaPHEpPTrnoSduKydpPnSfUWAqz0zlSHm+I7LYMO0l7f7H6U/A8
	 V2OF+fc6wwDMCbv1IZKXPIBB5tKaSAMcncdfuRdhNH+FQDjrHVxfX+LB7pR9DvRDEU
	 7GbSSSOQzhbHg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 4/6] mm/slab: Introduce kmem_buckets_create() and family
Date: Fri, 31 May 2024 12:14:56 -0700
Message-Id: <20240531191458.987345-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7297; i=kees@kernel.org; h=from:subject; bh=XkviX316F0sKgldrjJOcJuBh0F8cjTJAd80cswOqbm0=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxnRjACCy8SltAtPJOUgvzuMWkk/lDRtsU9 8AFAnMMLhKJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A JmRFD/Yw7w25q4idmyi+jo6FRdhQJPYOuBOFidTy9RvWqBz1zWPQuzhkSUGAXjN/ByB2Y58w1JG sv0e4eT7HMslHpN1JuKhEYglPdnqig7jCvw7zR7tMHIMYuB58h6pSw5CdMrElEYWfHUnI1NXvfI bTijuUKytN0+0E/2fUVW//rL53sD7JuG3txA1pu9nUoyBS7r+ogR6m7HgXTsU/bHV6Fa+ZRNa9D AzGRLS8Z3SS1WuMVKTDu7oZuJICWhmUQxMd59lcHarzVLpgZEj9cFH/UHAaATCZfYWKV7FuzxdT CsQcqCFrSQZdC/LCPo2nybSbW7rbispbqmN4kfbseeL6nyL5EEQUr9pffGRjOzRb1QMD0nc77Fn 5WuLA8Yo5/s1fnxsFJhVva/+CsSg05hAxcY+v51ovPWU12jhGUZ6clUUCxfAN2R4YjGErfciFUs WUnvRKK2whpyvkSSaoPCjpd7ADLtoyjHvyS3+FItuX1VBYeYdQr/TjOQ+TewIdE84mfagZs+4pU tc5TQVK8DqFOlTgbn01Dg+IJXu2kMn8pGt2bPeoUJbkd/Z4BpBFOggRgzv9bqVIlRKL5yQPQIoz pCtUfQX+Xprqna3AI6wAJhX+GZqNwUz870Dh+ucmRCkyTg1dJAfpUAbpVesEAuqmhDRRb83mU0P qHABF5VsQA6PM
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Dedicated caches are available for fixed size allocations via
kmem_cache_alloc(), but for dynamically sized allocations there is only
the global kmalloc API's set of buckets available. This means it isn't
possible to separate specific sets of dynamically sized allocations into
a separate collection of caches.

This leads to a use-after-free exploitation weakness in the Linux
kernel since many heap memory spraying/grooming attacks depend on using
userspace-controllable dynamically sized allocations to collide with
fixed size allocations that end up in same cache.

While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
against these kinds of "type confusion" attacks, including for fixed
same-size heap objects, we can create a complementary deterministic
defense for dynamically sized allocations that are directly user
controlled. Addressing these cases is limited in scope, so isolating these
kinds of interfaces will not become an unbounded game of whack-a-mole. For
example, many pass through memdup_user(), making isolation there very
effective.

In order to isolate user-controllable dynamically-sized
allocations from the common system kmalloc allocations, introduce
kmem_buckets_create(), which behaves like kmem_cache_create(). Introduce
kmem_buckets_alloc(), which behaves like kmem_cache_alloc(). Introduce
kmem_buckets_alloc_track_caller() for where caller tracking is
needed. Introduce kmem_buckets_valloc() for cases where vmalloc fallback
is needed.

This can also be used in the future to extend allocation profiling's use
of code tagging to implement per-caller allocation cache isolation[1]
even for dynamic allocations.

Memory allocation pinning[2] is still needed to plug the Use-After-Free
cross-allocator weakness, but that is an existing and separate issue
which is complementary to this improvement. Development continues for
that feature via the SLAB_VIRTUAL[3] series (which could also provide
guard pages -- another complementary improvement).

Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: jvoisin <julien.voisin@dustri.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 12 +++++++
 mm/slab_common.c     | 80 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8853c6eb20b4..b48c50d90aae 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -552,6 +552,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset, unsigned int usersize,
+				  void (*ctor)(void *));
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
@@ -675,6 +680,12 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define kmem_buckets_alloc(_b, _size, _flags)	\
+	alloc_hooks(__kmalloc_node_noprof(_b, _size, _flags, NUMA_NO_NODE))
+
+#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
+	alloc_hooks(kmalloc_node_track_caller_noprof(_b, _size, _flags, NUMA_NO_NODE, _RET_IP_))
+
 static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
@@ -818,6 +829,7 @@ extern void *kvmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
+#define kmem_buckets_valloc(_b, _size, _flags)	kvmalloc_buckets_node(_b, _size, _flags, NUMA_NO_NODE)
 
 static inline __alloc_size(1, 2) void *
 kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b5c879fa66bc..f42a98d368a9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,82 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+static struct kmem_cache *kmem_buckets_cache __ro_after_init;
+
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset,
+				  unsigned int usersize,
+				  void (*ctor)(void *))
+{
+	kmem_buckets *b;
+	int idx;
+
+	/*
+	 * When the separate buckets API is not built in, just return
+	 * a non-NULL value for the kmem_buckets pointer, which will be
+	 * unused when performing allocations.
+	 */
+	if (!IS_ENABLED(CONFIG_SLAB_BUCKETS))
+		return ZERO_SIZE_PTR;
+
+	if (WARN_ON(!kmem_buckets_cache))
+		return NULL;
+
+	b = kmem_cache_alloc(kmem_buckets_cache, GFP_KERNEL|__GFP_ZERO);
+	if (WARN_ON(!b))
+		return NULL;
+
+	flags |= SLAB_NO_MERGE;
+
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		char *short_size, *cache_name;
+		unsigned int cache_useroffset, cache_usersize;
+		unsigned int size;
+
+		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
+			continue;
+
+		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
+		if (!size)
+			continue;
+
+		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
+		if (WARN_ON(!short_size))
+			goto fail;
+
+		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+		if (WARN_ON(!cache_name))
+			goto fail;
+
+		if (useroffset >= size) {
+			cache_useroffset = 0;
+			cache_usersize = 0;
+		} else {
+			cache_useroffset = useroffset;
+			cache_usersize = min(size - cache_useroffset, usersize);
+		}
+		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
+					align, flags, cache_useroffset,
+					cache_usersize, ctor);
+		kfree(cache_name);
+		if (WARN_ON(!(*b)[idx]))
+			goto fail;
+	}
+
+	return b;
+
+fail:
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		if ((*b)[idx])
+			kmem_cache_destroy((*b)[idx]);
+	}
+	kfree(b);
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_buckets_create);
+
 #ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
@@ -931,6 +1007,10 @@ void __init create_kmalloc_caches(void)
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
+
+	kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
+					       sizeof(kmem_buckets),
+					       0, 0, NULL);
 }
 
 /**
-- 
2.34.1


