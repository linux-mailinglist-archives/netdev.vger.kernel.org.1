Return-Path: <netdev+bounces-99819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1E8D6987
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D7DB22C2D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622017CA1D;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHGi1HA+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9220DCB;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182899; cv=none; b=hfFTwPdeYX/POKx4umyz2DfDQdumEOSMDUjPDIC91EM+xDAx/Gh4kJiyRLTfNjPCHPRm05dNNnB0QEcbGkkBOnzAOqgpr3ieiJAMbwdwkdAsWeg7jvKpp/LejBOR3o04+Efk5Ravf7ZoIDK9QLnQBxRmvL69WMAa4IpX5G9iUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182899; c=relaxed/simple;
	bh=dfqToh7vJ1YdlsbBNUJ40Ep+NVn/iVSzZcDLrQiUMXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OupuLf9xe021ISE6ays99dThXhCVe6w/5wfn9VXCEPEqz6xjb5n55SYLvXP/coX3+c3elSvVsON6XU6OZEJzDJmfHSMUmIrizvHWlmG5Mgd5RKajMb4cEF8fVweGn//0lm3IwmQ8vVcFWbS/Pate7wMCelcY4S/GjFgGRyw/Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHGi1HA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C3C116B1;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=dfqToh7vJ1YdlsbBNUJ40Ep+NVn/iVSzZcDLrQiUMXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHGi1HA+mzpuDY95w6H9YHJnw7WoyCFefutajsvDEH22EdiD0jj78sajTrMgn9adg
	 TXDxyJJM4IE3Qdcos5NJb1MV+ZM3Zmu/miiojHyruPwoIB8AcJSNAzFAB0YmyCpRnt
	 +y+8LtkiuXr2iVUb2WcMRmk/cRL8xV4MCcE15GIIxrrkwaoIUTDsvwyQ7lCfb5dyrk
	 TTUPH6rfBXfZmwFnGkpaIlmEm/vNmeA6sXvxDJ+ALSEpp1MyFEKoPLjDEcDAQDB1JX
	 HJKQsARO9fdZ2oh/YYwgUsjLZIRqc/oMGDVREh4MNuK0Jd45N+l89FplmVwbjLA7O3
	 LA34z61hB+QTw==
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
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 2/6] mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
Date: Fri, 31 May 2024 12:14:54 -0700
Message-Id: <20240531191458.987345-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11282; i=kees@kernel.org; h=from:subject; bh=dfqToh7vJ1YdlsbBNUJ40Ep+NVn/iVSzZcDLrQiUMXs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxybA7iklkH7CPjAeV9H2xh/8ul0Vb4HEpp dLpSS9ljiSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A JtQAD/wPaCCfMzSt/HVD8r+nVIYMHyOAmxIoyIWlpmRaiu9RHSahTTRl+7hs0hlNJQKR0yR1ejv fyc94zIhyG6mTVmGD7qUUlF4Hbts6YianRXMHkq0vy2p1rNHoaRoU9Un/Zl0hrsyrH4d0eh91j7 LCU2gdpF4DztZdQ/79u6bKb5eyCFaGGJL8ouliSPwgXZq4SE+EJ4apzFLQBPa59UA0g30lvS5D2 wJlE+PXHL8j1iq/agqqyilTfX4DkfLEo/U3cGjgRUuxDbnRfA2HNwm1TTGI0lnR8iHsAm2v9KlO sc/ORVvVLcoqzSvBfmfBadt4fAXNZo4IKH/qMEDiPAD5SB4RsCbCjLqi0WkkXF9YkyeHiUpfvGI zF/g8bLCePUzlRMr5XXQyUHFb41aNdcVYaCvWjAFfB3u3C7qqyOpnkWKYnKfg+24/hjK+D3Vocl RbLziaXt2XLOQXp/k1oOsXI6YGugC38gqDa5HaI9c3+oKSmh8Sne4OexY1Qn26BzZyH6sOQ8x5U cfJhSNPWiiiNjDidIHGlZ+lFSioOsARR1/RYOjqcoXyIcH/sGEMymk6MXYa+2xFGdKxB+AkgM5C uRvt799u2/ClGdVRmZZ9qjHwDgFvrTzFI5t/h4xsBms7u8g3JenTGTdJ4PnsoHfQ2ym+j004zfX WRN8dbxsmM8kp2A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce CONFIG_SLAB_BUCKETS which provides the infrastructure to
support separated kmalloc buckets (in the follow kmem_buckets_create()
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
Cc: linux-hardening@vger.kernel.org
---
 include/linux/slab.h | 34 ++++++++++++++++++++++++++--------
 mm/Kconfig           | 15 +++++++++++++++
 mm/slab.h            |  6 ++++--
 mm/slab_common.c     |  4 ++--
 mm/slub.c            | 34 ++++++++++++++++++++++++----------
 mm/util.c            |  2 +-
 6 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index de2b7209cd05..b1165b22cc6f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -569,8 +569,17 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
+#ifdef CONFIG_SLAB_BUCKETS
+void *__kmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+				__assume_kmalloc_alignment __alloc_size(2);
+# define __kmalloc_node_noprof(b, size, flags, node)	\
+	__kmalloc_buckets_node_noprof(b, size, flags, node)
+#else
+void *__kmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
+				__assume_kmalloc_alignment __alloc_size(1);
+# define __kmalloc_node_noprof(b, size, flags, node)	\
+	__kmalloc_buckets_node_noprof(size, flags, node)
+#endif
 #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
 
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
@@ -679,7 +688,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node_noprof(size, flags, node);
+	return __kmalloc_node_noprof(NULL, size, flags, node);
 }
 #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
@@ -730,10 +739,19 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
  */
 #define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
-				  unsigned long caller) __alloc_size(1);
+#ifdef CONFIG_SLAB_BUCKETS
+void *__kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node,
+					 unsigned long caller) __alloc_size(2);
+# define kmalloc_node_track_caller_noprof(b, size, flags, node, caller)	\
+	__kmalloc_node_track_caller_noprof(b, size, flags, node, caller)
+#else
+void *__kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
+					 unsigned long caller) __alloc_size(1);
+# define kmalloc_node_track_caller_noprof(b, size, flags, node, caller)	\
+	__kmalloc_node_track_caller_noprof(size, flags, node, caller)
+#endif
 #define kmalloc_node_track_caller(...)		\
-	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
+	alloc_hooks(kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, _RET_IP_))
 
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
@@ -746,7 +764,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
 #define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
 
 #define kmalloc_track_caller_noprof(...)	\
-		kmalloc_node_track_caller_noprof(__VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
+		kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
 							  int node)
@@ -757,7 +775,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
-	return __kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node_noprof(NULL, bytes, flags, node);
 }
 #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..8c29af7835cc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -273,6 +273,21 @@ config SLAB_FREELIST_HARDENED
 	  sacrifices to harden the kernel slab allocator against common
 	  freelist exploit methods.
 
+config SLAB_BUCKETS
+	bool "Support allocation from separate kmalloc buckets"
+	default y
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
 config SLUB_STATS
 	default n
 	bool "Enable performance statistics"
diff --git a/mm/slab.h b/mm/slab.h
index 5f8f47c5bee0..f459cd338852 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -403,16 +403,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
  * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
  */
 static inline struct kmem_cache *
-kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
+kmalloc_slab(kmem_buckets *b, size_t size, gfp_t flags, unsigned long caller)
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
index e0b1c109bed2..b5c879fa66bc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -702,7 +702,7 @@ size_t kmalloc_size_roundup(size_t size)
 		 * The flags don't matter since size_index is common to all.
 		 * Neither does the caller for just getting ->object_size.
 		 */
-		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
 	}
 
 	/* Above the smaller buckets, size is a multiple of page size. */
@@ -1179,7 +1179,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 		return (void *)p;
 	}
 
-	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
+	ret = kmalloc_node_track_caller_noprof(NULL, new_size, flags, NUMA_NO_NODE, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..ec682a325abe 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4099,7 +4099,7 @@ void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(kmalloc_large_node_noprof);
 
 static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
 			unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -4115,7 +4115,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, flags, caller);
+	s = kmalloc_slab(b, size, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
@@ -4123,24 +4123,38 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+#ifdef CONFIG_SLAB_BUCKETS
+# define __do_kmalloc_buckets_node(b, size, flags, node, caller)	\
+	__do_kmalloc_node(b, size, flags, node, caller)
+void *__kmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+#else
+# define __do_kmalloc_buckets_node(b, size, flags, node, caller)	\
+	__do_kmalloc_node(NULL, size, flags, node, caller)
+void *__kmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
+#endif
 {
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+	return __do_kmalloc_buckets_node(b, size, flags, node, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc_node_noprof);
+EXPORT_SYMBOL(__kmalloc_buckets_node_noprof);
 
 void *__kmalloc_noprof(size_t size, gfp_t flags)
 {
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+	return __do_kmalloc_buckets_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
-				       int node, unsigned long caller)
+#ifdef CONFIG_SLAB_BUCKETS
+void *__kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags,
+					 int node, unsigned long caller)
+#else
+void *__kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
+					 int node, unsigned long caller)
+#endif
 {
-	return __do_kmalloc_node(size, flags, node, caller);
+	return __do_kmalloc_buckets_node(b, size, flags, node, caller);
+
 }
-EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
+EXPORT_SYMBOL(__kmalloc_node_track_caller_noprof);
 
 void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..80430e5ba981 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -128,7 +128,7 @@ void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
 {
 	void *p;
 
-	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
+	p = kmalloc_node_track_caller_noprof(NULL, len, gfp, NUMA_NO_NODE, _RET_IP_);
 	if (p)
 		memcpy(p, src, len);
 	return p;
-- 
2.34.1


