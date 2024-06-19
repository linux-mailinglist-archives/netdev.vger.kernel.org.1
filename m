Return-Path: <netdev+bounces-105012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A9A90F702
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4778A1F2546B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F47158DA6;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Yv9EWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B5156C6A;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=ZRsytdJEMmQ5KFw4MzMVzJBQ6qAZAnlvkLlPi29GOAIcHTD/UwcHDjkwH5ShS4kQwHNJIkXhoWxZHVwOEHbFnj33nqtCo7qWTl3s5TOIiwyo19cA+5Tl2ZpXh9UaNMUhwsVEWq8AGtrp0rxLX7+v0x0LMIje9cSghEckQ+44K00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=NjQz1ofxl1LDT7gykHG8dwBhCnofJ5FfmI7SBhvteU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEjBQ1LHz+1wPO1M4+QOSk4D8s9KxCnUWrfeWsCl4mihXUlvUzGwKzSBiNiehd1c7G1X1MBojZnV7/CGDoRMMj95kvZBzgPXRNp+kfTReTHEMH59Ne8VPMWzcqISm0jtkxusTUcGRIJpqSxOTfuX1nxPlcTnsT/zgBvq+LMtDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Yv9EWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6DEC2BBFC;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825637;
	bh=NjQz1ofxl1LDT7gykHG8dwBhCnofJ5FfmI7SBhvteU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7Yv9EWFE5EMKDGgobMPhyAUV9x3AHFCr/pIIZUu98B3OuPUZA8r3svdbB4AFpa5H
	 MxcR2veMw4/vuH1WAWRajznqvscJehUz+cZzYAt+UoaS+ER1GKSl+zQlZz39R8H4nP
	 Ur30YYJyb3nI0TPHIoqcbIf7ywAjK3Sg4s3Jt4Cm1eEtZYOBAN/xHMRq/IsqDcDir6
	 dLDTGDH14fHedHAd4qCXcU7IoKvalI09yiqYt4Co/g9Fw7bjyoixQn7tU5aaKXN1rr
	 8Iuvyq44D4JzWws0H/tWuIt8rAohqd6VZtGnSj8n3S9IfPbOP8J3DHjEfdxMkJO1Qz
	 l/IGcFUt5/iZw==
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 2/6] mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
Date: Wed, 19 Jun 2024 12:33:50 -0700
Message-Id: <20240619193357.1333772-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9065; i=kees@kernel.org; h=from:subject; bh=NjQz1ofxl1LDT7gykHG8dwBhCnofJ5FfmI7SBhvteU8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKhW14Hz9vvOfff9HWHD+CFC5tA89EoayyE9 eX0d7oLv5iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JtTBEACiEpfE7E1Acag1iHwH7KdlseT3HcROajzW5EkeJHpi5+yOPr+lqzOJReVLbn3lC6lfE79 JP81uJK4J3AYRlSy13q1S9JyM0CdH3JzuJrMEZb1CE50OKe9Pn4rwEm23ccHUO4nRAPtihpYBTa Xo1arWYQIEOFn59OQ71Etz23tvsOD2QroL2Anq7VfcV8rOykPLRZYIXLVbDuOadjr72kH9PVkbP OLLkfTpboMqlc8PEXgG3C2zjIhFbYXWWwjXJHZHX/HXCrJFU/So9qi2HdIxIRL3N+BGXKrzW7RM eLR0+XcuHfoXrwsrVt6ofbAXFYtTQEg1a512936/8GAH/36lnwIYSmhnnPNuzH4UrYQ4eDt4dBh THVLE7v7FHg5Z/xoVBrzSbDMPU7pHvUXpkIZVbeGjwhZD0pyCe+wD858zkX6lkOHFmENqVA82Ob FyCZ2SLjzULRC77CTNjMaMixE10e81dBFUsjzVdVZ+TzrYsZpq/3XLor7SXdm7L1d6Zewp4RqvQ bf/aMUAhyxSq9OQQSKkSzHet2KUeldXaIv1Lojont8kdtStLjRJb73wd9/rAhHPsqE1glIj2wSP jlt5ATx6uemqSzJrDFkEQEgi6L6deG36lS1q0i2NaQA167U0HtgliVWczwNV65TXwUZkKMp51m0 bD5LifceuU+wxNQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
support separated kmalloc buckets (in the following kmem_buckets_create()
patches and future codetag-based separation). Since this will provide
a mitigation for a very common case of exploits, enable it by default.

To be able to choose which buckets to allocate from, make the buckets
available to the internal kmalloc interfaces by adding them as the
first argument, rather than depending on the buckets being chosen from
the fixed set of global buckets. Where the bucket is not available,
pass NULL, which means "use the default system kmalloc bucket set"
(the prior existing behavior), as implemented in kmalloc_slab().

To avoid adding the extra argument when !CONFIG_SLAB_BUCKETS, only the
top-level macros and static inlines use the buckets argument (where
they are stripped out and compiled out respectively). The actual extern
functions can then been built without the argument, and the internals
fall back to the global kmalloc buckets unconditionally.

Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h | 27 ++++++++++++++++++++++-----
 mm/Kconfig           | 16 ++++++++++++++++
 mm/slab.h            |  6 ++++--
 mm/slab_common.c     |  2 +-
 mm/slub.c            | 20 ++++++++++----------
 5 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8a006fac57c6..708bde6039f0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -570,6 +570,21 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 				   int node) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
+/*
+ * These macros allow declaring a kmem_buckets * parameter alongside size, which
+ * can be compiled out with CONFIG_SLAB_BUCKETS=n so that a large number of call
+ * sites don't have to pass NULL.
+ */
+#ifdef CONFIG_SLAB_BUCKETS
+#define DECL_BUCKET_PARAMS(_size, _b)	size_t (_size), kmem_buckets *(_b)
+#define PASS_BUCKET_PARAMS(_size, _b)	(_size), (_b)
+#define PASS_BUCKET_PARAM(_b)		(_b)
+#else
+#define DECL_BUCKET_PARAMS(_size, _b)	size_t (_size)
+#define PASS_BUCKET_PARAMS(_size, _b)	(_size)
+#define PASS_BUCKET_PARAM(_b)		NULL
+#endif
+
 /*
  * The following functions are not to be used directly and are intended only
  * for internal use from kmalloc() and kmalloc_node()
@@ -579,7 +594,7 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 void *__kmalloc_noprof(size_t size, gfp_t flags)
 				__assume_kmalloc_alignment __alloc_size(1);
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 				__assume_kmalloc_alignment __alloc_size(1);
 
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
@@ -679,7 +694,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node_noprof(size, flags, node);
+	return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node);
 }
 #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
@@ -730,8 +745,10 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
  */
 #define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
-				  unsigned long caller) __alloc_size(1);
+void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node,
+					 unsigned long caller) __alloc_size(1);
+#define kmalloc_node_track_caller_noprof(size, flags, node, caller) \
+	__kmalloc_node_track_caller_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node, caller)
 #define kmalloc_node_track_caller(...)		\
 	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
 
@@ -757,7 +774,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
-	return __kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(bytes, NULL), flags, node);
 }
 #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..20bb71e241c3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -273,6 +273,22 @@ config SLAB_FREELIST_HARDENED
 	  sacrifices to harden the kernel slab allocator against common
 	  freelist exploit methods.
 
+config SLAB_BUCKETS
+	bool "Support allocation from separate kmalloc buckets"
+	depends on !SLUB_TINY
+	help
+	  Kernel heap attacks frequently depend on being able to create
+	  specifically-sized allocations with user-controlled contents
+	  that will be allocated into the same kmalloc bucket as a
+	  target object. To avoid sharing these allocation buckets,
+	  provide an explicitly separated set of buckets to be used for
+	  user-controlled allocations. This may very slightly increase
+	  memory fragmentation, though in practice it's only a handful
+	  of extra pages since the bulk of user-controlled allocations
+	  are relatively long-lived.
+
+	  If unsure, say Y.
+
 config SLUB_STATS
 	default n
 	bool "Enable performance statistics"
diff --git a/mm/slab.h b/mm/slab.h
index b16e63191578..d5e8034af9d5 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -403,16 +403,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
  * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
  */
 static inline struct kmem_cache *
-kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
+kmalloc_slab(size_t size, kmem_buckets *b, gfp_t flags, unsigned long caller)
 {
 	unsigned int index;
 
+	if (!b)
+		b = &kmalloc_caches[kmalloc_type(flags, caller)];
 	if (size <= 192)
 		index = kmalloc_size_index[size_index_elem(size)];
 	else
 		index = fls(size - 1);
 
-	return kmalloc_caches[kmalloc_type(flags, caller)][index];
+	return (*b)[index];
 }
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e0b1c109bed2..9b0f2ef951f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -702,7 +702,7 @@ size_t kmalloc_size_roundup(size_t size)
 		 * The flags don't matter since size_index is common to all.
 		 * Neither does the caller for just getting ->object_size.
 		 */
-		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+		return kmalloc_slab(size, NULL, GFP_KERNEL, 0)->object_size;
 	}
 
 	/* Above the smaller buckets, size is a multiple of page size. */
diff --git a/mm/slub.c b/mm/slub.c
index 3d19a0ee411f..80f0a51242d1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4117,7 +4117,7 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(__kmalloc_large_node_noprof);
 
 static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flags, int node,
 			unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -4133,32 +4133,32 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, flags, caller);
+	s = kmalloc_slab(size, b, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
 	trace_kmalloc(caller, ret, size, s->size, flags, node);
 	return ret;
 }
-
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 {
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+	return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_node_noprof);
 
 void *__kmalloc_noprof(size_t size, gfp_t flags)
 {
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+	return __do_kmalloc_node(size, NULL, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
-				       int node, unsigned long caller)
+void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
+					 int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, flags, node, caller);
+	return __do_kmalloc_node(size, PASS_BUCKET_PARAM(b), flags, node, caller);
+
 }
-EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
+EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
 void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
-- 
2.34.1


