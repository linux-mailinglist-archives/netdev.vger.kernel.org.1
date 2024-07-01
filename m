Return-Path: <netdev+bounces-108253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75991E84F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28666281EDB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B316F849;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpSfmTgx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FF16F26E;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=ozGDK57V6BoKit1Ifsa8GGbNyd1XfJ0ACiLrr6w5akH42UOBTAxwqpTCYM5QA4eazT/FUaT1cia6Ioc3uwn/b5k05WKRmnz1VQoog4o1e5wYJXGXBimJm26eCVE+eGb/4GQ3lnCWqJLxXSUjQE21puInE2s9S2h22XAMUNC6QHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=iLr1JO1gVFtydBJDlW/Z6SdDIb8sQtIWfFXCMaocDcg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iWUZszIoXylh/EeCXSJBJimz2h86sPt6jvM6ZFOa/QOKgLDBrrQtl30Ccj1459+m2YJWiVkdPOy+4QyKSwf3cnbyqgMC7GtSuQK1OaIlJiT6qxRTobohav95VnnbmbpIDTjhhYEchT/wa/QYQDZEnSvmYUIol7GeW2mnFAQPfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpSfmTgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF06C4AF0C;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861184;
	bh=iLr1JO1gVFtydBJDlW/Z6SdDIb8sQtIWfFXCMaocDcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpSfmTgxm2O1XtuIFl+3ZxeSoxYypsrEU0+nDkunMVjz9fqvzNZXImfKfOgbhxqvZ
	 CWJEEidhNGTyifG0nR+rXVJIx/A2qesIuRGrcbMilA4qSyFRmRnfeGtpcB6RwcdXAO
	 8FlpEO+3qZiqtJZNOnTdQuAwR7KU7OgZ5Fyv++2LC0iKVbRQ6H3cWeLFzRXFvoqnM0
	 eSrGAf0KiZ/UCgZ8S2+lv2V61tOvs+nM9c+XIVf2D9KThxnpza0obf9zEimu91+0nu
	 5mMnT0ywl5hdZUH+bX9G3igqs+pfRNBBTHgMRtShjduDuQlJt4j1RjRb3SuLNeQ4xo
	 mLYYJCU2yV6Ew==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 4/6] mm/slab: Introduce kmem_buckets_create() and family
Date: Mon,  1 Jul 2024 12:13:01 -0700
Message-Id: <20240701191304.1283894-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8116; i=kees@kernel.org; h=from:subject; bh=iLr1JO1gVFtydBJDlW/Z6SdDIb8sQtIWfFXCMaocDcg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++kshPnyXBQpYmXkhyaUZvkPmyCCbIBrXnN 5/UgqpveV2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A Ji6UEACxYLIBboDvKj5qoLIIzqp3hMa09xT5pXc8GbKmY2/GyXBftV83vive0p+5epvrpOMcCJj UdH1IPLxIdnSKJP/L/8+Rv9jj1BGjR6WTWWOv7GcNtMFdeXzAuh6c/mxpLYV8FRSYvFkXuhbab4 ERTeCuecezcFkNxqUYpcRO75k/eyY5twXVS4i42r/VGX1MOQOC00xBBZI4QqwAirHWU7TzmshBX t9dPiM/LqzE54MRSghuxmUFpVavRcaIGqE9gjNIEeV7ELNEBvT3UpdRuImMkWoxNKQE7he5T6h/ NtO+zOa14B1oBkp4YFjZHLuorD9gkhEsxIVkaPxe7eniA1a4r8s8/IY2/MbMeznYldyYmrNsxwY jbAGyovGKjvR/UWHJSNqT7X2ImJ2UdEt8dkJ8Zck+crZ4wBGPUnPgbANbT/OaiY6MSV5H5pwvG0 K7JQntezgoxoQ29Y1GTD0QpiESxigH3wAERxkJaXnMEL59PyEBWblaDhJz76ttKLqon7S79FZpp jAHE5SZWTFjOBBAwCDhsCp0NlD5jAQ70cJkGWgLYmfK8KWb0geMS3TKZs8yGCytCBA8YpTkM1Xc V2jkNV/A54x/ujur4vKgrirvvVJ+uK2WPCIB3AOYVdfxHAL6EknMufnamvya3upXuHwTcD3TU8u RuEkWXQJaZEN9eQ==
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
is needed. Note that these caches are specifically flagged with
SLAB_NO_MERGE, since merging would defeat the entire purpose of the
mitigation.

This can also be used in the future to extend allocation profiling's use
of code tagging to implement per-caller allocation cache isolation[1]
even for dynamic allocations.

Memory allocation pinning[2] is still needed to plug the Use-After-Free
cross-allocator weakness (where attackers can arrange to free an
entire slab page and have it reallocated to a different cache),
but that is an existing and separate issue which is complementary
to this improvement. Development continues for that feature via the
SLAB_VIRTUAL[3] series (which could also provide guard pages -- another
complementary improvement).

Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h | 12 ++++++
 mm/slab_common.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8d0800c7579a..4c083f3196f4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -549,6 +549,10 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
+				  unsigned int useroffset, unsigned int usersize,
+				  void (*ctor)(void *));
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
@@ -681,6 +685,12 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define kmem_buckets_alloc(_b, _size, _flags)	\
+	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
+
+#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
+	alloc_hooks(__kmalloc_node_track_caller_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE, _RET_IP_))
+
 static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
@@ -808,6 +818,8 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
+#define kmem_buckets_valloc(_b, _size, _flags)	\
+	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
 static inline __alloc_size(1, 2) void *
 kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9b0f2ef951f1..641cf513d2d1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,98 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+static struct kmem_cache *kmem_buckets_cache __ro_after_init;
+
+/**
+ * kmem_buckets_create - Create a set of caches that handle dynamic sized
+ *			 allocations via kmem_buckets_alloc()
+ * @name: A prefix string which is used in /proc/slabinfo to identify this
+ *	  cache. The individual caches with have their sizes as the suffix.
+ * @flags: SLAB flags (see kmem_cache_create() for details).
+ * @useroffset: Starting offset within an allocation that may be copied
+ *		to/from userspace.
+ * @usersize: How many bytes, starting at @useroffset, may be copied
+ *		to/from userspace.
+ * @ctor: A constructor for the objects, run when new allocations are made.
+ *
+ * Cannot be called within an interrupt, but can be interrupted.
+ *
+ * Return: a pointer to the cache on success, NULL on failure. When
+ * CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned, and
+ * subsequent calls to kmem_buckets_alloc() will fall back to kmalloc().
+ * (i.e. callers only need to check for NULL on failure.)
+ */
+kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
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
+					0, flags, cache_useroffset,
+					cache_usersize, ctor);
+		kfree(cache_name);
+		if (WARN_ON(!(*b)[idx]))
+			goto fail;
+	}
+
+	return b;
+
+fail:
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
+		kmem_cache_destroy((*b)[idx]);
+	kfree(b);
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_buckets_create);
+
 #ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
@@ -931,6 +1023,10 @@ void __init create_kmalloc_caches(void)
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
+
+	kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
+					       sizeof(kmem_buckets),
+					       0, SLAB_NO_MERGE, NULL);
 }
 
 /**
-- 
2.34.1


