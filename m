Return-Path: <netdev+bounces-108250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BE91E84C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B41F221E4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D016F827;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwTCjn01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C2C8C7;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=QHqFbq7tvgZ5ZVlzsY8ZFiJSBODQ1HixWGK6Q+uISnstTBAAVEeeq1pma1Y+WbN7LeWFo4l5bJYkglYJ+PfW09gIdhMnlaQZ4jNORXZ5fpu+2FYuiNBEjTNj0njDK+tv7Jsc1HoKMHHfAZoWM7z+zifIoYmRUXDXadWU7Vh+WVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=Fh8hn82A6Gkidq5L2q9k9Jp9kuNH5GwUiFNzo6MraKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLnBp8w+BK2kvFgS4Zb9kGR/SHh3crD139Tjmg2hVXF0Ao1aI95nVyW4KlTyLm0WNr02so1OZdXC7YWCEi9D98EW8nX0LaXbHI1wg5VUSZFqztTqBk+W547H0fKkMq2986hbQlId1I611e5r/CxBB9H+GP9fm/RQfHnXExCEH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwTCjn01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62BBC32786;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861184;
	bh=Fh8hn82A6Gkidq5L2q9k9Jp9kuNH5GwUiFNzo6MraKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwTCjn01rIrhnVzozUC8nSU9ygzSVOAWK2NwHfiIHz88ZxMfH78DfyBNZqPbgJhjt
	 1En0azbb+FzKarKw46ht5i47ODAV8FDJFJbLHdekbKlVvgy5q2vCiB5ZeWkJHdln/1
	 X/PkEyTnjr7iDbFCSDom1lDpgFvDRDsuB5rKrjSiBxCflX6oYP8LjJDXDPiaqt+j7M
	 RBONoQcMp3d6DSSp4xZJsxVObs45dqtw4EetmwIMSdOBCvf/DloxqKQ6RMiW96hV6N
	 /cF9uMmOesCr4A/8eGfvuj0uaKnoLQtFvne4BkLbRHuhb57/TY8sS7eCV1LW5/3Wjz
	 tp4ark47oZ4pw==
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
Subject: [PATCH v6 2/6] mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
Date: Mon,  1 Jul 2024 12:12:59 -0700
Message-Id: <20240701191304.1283894-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10530; i=kees@kernel.org; h=from:subject; bh=Fh8hn82A6Gkidq5L2q9k9Jp9kuNH5GwUiFNzo6MraKY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++vHvQ6T0Eu3tRk8QttwaaXPyJTfZbfA7bS LQp+ltrjfuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A Jl9uD/0f7gAetPdbAgu8momSOZv6Cae+I/11HPjOsFzUo49cNUJlFFs/A+yXPo0sZUGd6BWGT8b 4z3V/y10bQjSk2Ce5NdLROSleTVt5Z0kKP4znE7LRvawxxIMcE6NRSE239WY8ClZprrMQFAFota z2qwPKdBLlvhsvt8prwxl4AtS3MSqFWNiQTOyFNXvqwzNzx7q0R3yGSHR11TyMPdDITDPCMfKFJ ql4xYz4/P/0hJ61sbBSCKo6HU3NmOnPYGDe/WkXIB3bTn++2ACQsbkcihNSU3jLY/Oc0Pfr53XA L3Rm69795J6HaMBcRy1JF5ff+JNuyhBe0fA2iH5NlrjNJpi1vh0qA3azfgQtcF3usL1kxLzwCy1 tkfMp8MyYUIzs/PPx+0AHGKFLqRk+brl+1t8vYB2nZ3eHv9BC/ow8/GbPG5A0+BJOHBFNzEQuha ACPwzCjwKOzUZTBeIjK+93446+7EpROWkRRNgNk1wsqQ8eMs0l5RVVAfMT1gH74tDWYlyIYro5z KgthZkHBkTsGnii0Twa5PwMkHLtwdf5khBhW6/geyBph5Lk2lbU9LozhwbbEQPenvXSj1hAEoaC LXc/OOvyAxp8ZKJIZZVEGbqvjTRyg32q6V36pjHIrB6OMsSgFlZMwaI63511/yR3zN3r8GxPbvU mWcGxNfTGQUNs+w==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
support separated kmalloc buckets (in the following kmem_buckets_create()
patches and future codetag-based separation). Since this will provide
a mitigation for a very common case of exploits, it is recommended to
enable this feature for general purpose distros. By default, the new
Kconfig will be enabled if CONFIG_SLAB_FREELIST_HARDENED is enabled (and
it is added to the hardening.config Kconfig fragment).

To be able to choose which buckets to allocate from, make the buckets
available to the internal kmalloc interfaces by adding them as the
second argument, rather than depending on the buckets being chosen from
the fixed set of global buckets. Where the bucket is not available,
pass NULL, which means "use the default system kmalloc bucket set"
(the prior existing behavior), as implemented in kmalloc_slab().

To avoid adding the extra argument when !CONFIG_SLAB_BUCKETS, only the
top-level macros and static inlines use the buckets argument (where
they are stripped out and compiled out respectively). The actual extern
functions can then be built without the argument, and the internals
fall back to the global kmalloc buckets unconditionally.

Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h            | 27 ++++++++++++++++++++++-----
 kernel/configs/hardening.config |  1 +
 mm/Kconfig                      | 17 +++++++++++++++++
 mm/slab.h                       |  6 ++++--
 mm/slab_common.c                |  2 +-
 mm/slub.c                       | 20 ++++++++++----------
 scripts/kernel-doc              |  1 +
 7 files changed, 56 insertions(+), 18 deletions(-)

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
 
diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 8a7ce7a6b3ab..3fabb8f55ef6 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -20,6 +20,7 @@ CONFIG_RANDOMIZE_MEMORY=y
 # Randomize allocator freelists, harden metadata.
 CONFIG_SLAB_FREELIST_RANDOM=y
 CONFIG_SLAB_FREELIST_HARDENED=y
+CONFIG_SLAB_BUCKETS=y
 CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
 CONFIG_RANDOM_KMALLOC_CACHES=y
 
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..e0dfb268717c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -273,6 +273,23 @@ config SLAB_FREELIST_HARDENED
 	  sacrifices to harden the kernel slab allocator against common
 	  freelist exploit methods.
 
+config SLAB_BUCKETS
+	bool "Support allocation from separate kmalloc buckets"
+	depends on !SLUB_TINY
+	default SLAB_FREELIST_HARDENED
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
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 95a59ac78f82..2791f8195203 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1729,6 +1729,7 @@ sub dump_function($$) {
     $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
     $prototype =~ s/__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
     $prototype =~ s/__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +//;
+    $prototype =~ s/DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)/$1, $2/;
     my $define = $prototype =~ s/^#\s*define\s+//; #ak added
     $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__attribute__\s*\(\(
-- 
2.34.1


