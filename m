Return-Path: <netdev+bounces-105014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13490F703
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1CC1F22A6D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A6158DC6;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg3uS92q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18632158A2D;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=qPo4qJ8DOmFxr31/uen8adoTut1xLB6DABllB+lpZjkM9CLkc6gvudbVSI9w9rcAyL39sBNzSNowDKGYmdKHREeZTEHwOyk8RwntlDd4/JUDId8bNEeJfrAvyobLzo7dsx0Xa/L8KDBX+F22EkjgpIHqz1UHaIzsOuZL1fCRVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=/RmCJ4F/4ng/Khq7qR9N0HAZnD/jFStWnmxtCKBK+GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGnCdRexNyCDHSp5a/yvMKd9PW5VxLecy4GDIO0B/5rxh3fBrhnedmStnwwYzQXl9NOxE8jGWAxMgT5GrIbwd7oMqs/WL7+KJk7h0mU2YERZtezJFwW3oI5uFNbcFwlAs5kfIhRP+YSXOVFhb2w6xeDSQHP7HzaRtukSdlCoChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg3uS92q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E7DC4AF09;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825637;
	bh=/RmCJ4F/4ng/Khq7qR9N0HAZnD/jFStWnmxtCKBK+GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yg3uS92qwownEjYk+KrHqmmBxErM9MDG9GWHoFjllUlVSitrJzN/cCkCIxz9m8kG9
	 kKoYDXC55Gf2FwYsZgznS1yoHOWjYGoi+I0Z6o0Gm5TXB/JtXNVfbtLFKKjgll+gOR
	 CVuFaIrDPLPbOhR1s/D38SWARmQueikUJkNoAqYKhvnRvsXp23H82MaQHLHr5bjLze
	 9djumIEXDuJJaKmToURyjFbfB9pEA6aj9VayWX/uc1mN3yBbyG5UQB7bA5tqX7afHH
	 qvlaU7v3WU6YTKxQi8wrAE3TOP/f0TTQhbZb/ao4H72plbBlMPtDyeYKOxizgoQpN+
	 infour+aBOrTA==
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
Subject: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and family
Date: Wed, 19 Jun 2024 12:33:52 -0700
Message-Id: <20240619193357.1333772-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6964; i=kees@kernel.org; h=from:subject; bh=/RmCJ4F/4ng/Khq7qR9N0HAZnD/jFStWnmxtCKBK+GE=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBmczKh21zJZgyIFpVjar+3GzcqV57oOAwiaPyFf 9lg6kUOpTKJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JnTnD/i2CjxP6n3FrmWS5Y2ZF/qTuu2v5aeKrAb1+69yKucXGvlFE1sS0j8g/4CcTgYD2Knvk0Z HJqxN0EMNzWhABAciSgOkzbDhOQyDLUvP+JcxuHiDxOp8K73MMFTWwXPiVjTcCUoqXiMGq3JNzx qesEPnvQM+Tg2kCxyZKlrcdSgRSpNAyOzt/YguC+V5/5tBzhRwfv/4wT8D50QkT/RgzPLjEM/cF LLXlmYAH4ftrzzTwHVPFydtRp3z/LXpUVh5wphBnpJ5tYkkBcEY8WNG5VJCoZbd2HIp58ex6Ypg mlp4bEfdmLCY0m8uqpdycuoTdXpRplIW30Y+VT8NG6JUz/Pmo3TPkDTlyIkFXRmgCwAY7yJ9lcO t5PXQjfhG3j4+JzW0kkDAi8PCZSuB5K+mMSpHGg/KUxut0vaVf/FUqZLaKFbtDtDt3j5Hi2Zxsc McIfFUN7qSQw1oeXD+WFrbTDLVTt7Kvs/PYdqdnswzMcTHKQVyl7k2mwUtibR2uTSs0F1GW3zgb 5kFMEd+FNidxfUztUA449ujJ8F1IbS2inC6b/xfGpEt0PqtKBDgpX2GcDhveoJO/0N4g5S7s5jF 08LkkH5XKfseBz0goioeJ+0E2Lercac875NHpziSFZtCVDzjqgDLDH5gQKsxmNXSXcJ5xqI33VM LRyiGlHiaNTFf
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
 include/linux/slab.h | 13 ++++++++
 mm/slab_common.c     | 78 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8d0800c7579a..3698b15b6138 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -549,6 +549,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset, unsigned int usersize,
+				  void (*ctor)(void *));
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
@@ -681,6 +686,12 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
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
@@ -808,6 +819,8 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
+#define kmem_buckets_valloc(_b, _size, _flags)	\
+	alloc_hooks(__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
 static inline __alloc_size(1, 2) void *
 kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9b0f2ef951f1..453bc4ec8b57 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,80 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
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
@@ -931,6 +1005,10 @@ void __init create_kmalloc_caches(void)
 
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


