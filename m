Return-Path: <netdev+bounces-99823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7968D6989
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13601C2455E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ACD17D371;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2OPMeYn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA417C22E;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182899; cv=none; b=f0Z5Uua1+fVcR0yk0ojcLxHmjWFZYzuOIHGZLGqBbvwF+XXu241Y5I5k2ZYTzzoyeA1apIfWLGLaWTb65Gry9CsTjMXqVsd4XluiAqdHy0uYRTqyGI+ukChx+JIUBoxramIGjGss0CObdJ3Hx0/vY+bnNGiC42UW8+4TnjSuH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182899; c=relaxed/simple;
	bh=SEppnjIqapMPAdV3gOtlWmc+MgaX+XeR2G6jWLuYp7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lT88HfHxhhNGyseRbncISRqEOeZbtBPv95A5NQKXnh9wGOiW/Dmv2rFpT+VwsJ2EBz930R+K73s+t5WpSMVm19KkroZuZsKD3/To/+0q7yQnKKpLaX7UxhQKo46LPqcicqKM/Br7SeA0C8FpjI2956s6JZngw72qMn3miHFUeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2OPMeYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDCAC4AF0B;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=SEppnjIqapMPAdV3gOtlWmc+MgaX+XeR2G6jWLuYp7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2OPMeYnvF/RFYKaf/zp7Z8RM2X/F+vCy9GQY8I0Xac+aLT6YtbqxYij5Ro2zWi+a
	 MN9VGaIrehneZvdwFtmr4oRoqYDRm2KSiJtIsuhOObVx1I4PNbOB+Ouoa3tqEvWFDA
	 HSO5HevkfkfN6er7AJp9RlHES2dgJa2zpAhykipseObxwNudHFe0HalIiGVTKVHnmi
	 AqpKV4f8T8pSoz5kt0RKKbLDLOr9OupC6Q7Y7HM7+cbnWHXwXOBdD6b53spXB6kriD
	 6iSMpHTPLoSPE13x9RlwVt49lrgdHsnOwM4iDFAdAiH52QtrgFm7zUF5eHwg63Ugcm
	 gwHZ+zd6FxRTw==
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
Subject: [PATCH v4 3/6] mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument
Date: Fri, 31 May 2024 12:14:55 -0700
Message-Id: <20240531191458.987345-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5214; i=kees@kernel.org; h=from:subject; bh=SEppnjIqapMPAdV3gOtlWmc+MgaX+XeR2G6jWLuYp7Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxmv39xi7SHjeU5Qh9TUaZ7uKF3EFTYjEdf tCKJ2uSBP+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A Jr4cEACEhuBwLvPpMEMM6sggZmXcHry4TE03jPbQd9Mxmy5fFK55DUXqOjb7y21q5sv4rW+FYr+ cxS5RUtfUdTgJDLUlLXIFYuGfkjbVWyf0/UO1wjWEFajzvLZHhctDIxhDXOmz1eNdgiETeCuZy+ 0tK4LLZ7icrZDV64sHkxFdLp+QjgcG9dcn9ddPD+UMyzaehfifqCmbKPTSGQpVlWPDUz/lcu1L9 TpM1bUWcFosoEEoyPwiwzFFGSiB1K2FYqkZduo+6FElV+chVVesLAlL07MVW08zhnM5amAHBtX2 miRaeDPfZ7xIMoweuL4Vvg48VVwgnvfGJH9uu2AXACHy+sUPeUkzpqIeAUbr8pdxPHMbJ7R5p6N IOfEMRRT3t5Sja0RVGPoetNdjckFemnbuYPHydOPHxLEvx2yijFMqhzA21K1v6cp/zULxeNu6/a kAbSOq4OofTYQyu++5F1OmY4bOOeEcEWkLHmC/ZNSYxJI+PudtmIO8QYJSZcWQhhEFbGz2KivPz cdEOaIglVTuJPLq1Jwd6gg19ZqOdrKnyU3QWpKIbkR7YOHpHoc1iDMMIz+Rlg6pXcrnWBlrQeAX ggr1unJKL/WqIBTqG9zmyEyMw39wFI8PexEG8KeNryf3AdYLbv1kgoz2EMLNsURDKu2MjhCcplH x/xz3swVnXdautw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Plumb kmem_buckets arguments through kvmalloc_node_noprof() so it is
possible to provide an API to perform kvmalloc-style allocations with
a particular set of buckets. Introduce kvmalloc_buckets_node() that takes a
kmem_buckets argument.

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
 include/linux/slab.h | 19 +++++++++++++++----
 lib/rhashtable.c     |  2 +-
 mm/util.c            | 13 +++++++++----
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b1165b22cc6f..8853c6eb20b4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -799,11 +799,22 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 #define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_size(1);
-#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
+#ifdef CONFIG_SLAB_BUCKETS
+extern void *kvmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+					__alloc_size(2);
+# define kvmalloc_node_noprof(b, size, flags, node)	\
+	kvmalloc_buckets_node_noprof(b, size, flags, node)
+#else
+extern void *kvmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
+					__alloc_size(1);
+# define kvmalloc_node_noprof(b, size, flags, node)	\
+	kvmalloc_buckets_node_noprof(size, flags, node)
+#endif
+#define kvmalloc_buckets_node(...)		alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
+#define kvmalloc_node(...)			kvmalloc_buckets_node(NULL, __VA_ARGS__)
 
 #define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
-#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
+#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(NULL, _size, _flags, NUMA_NO_NODE)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, (_flags)|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
@@ -816,7 +827,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc_node_noprof(bytes, flags, node);
+	return kvmalloc_node_noprof(NULL, bytes, flags, node);
 }
 
 #define kvmalloc_array_noprof(...)		kvmalloc_array_node_noprof(__VA_ARGS__, NUMA_NO_NODE)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dbbed19f8fff..ef0f496e4aed 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -184,7 +184,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	static struct lock_class_key __key;
 
 	tbl = alloc_hooks_tag(ht->alloc_tag,
-			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
+			kvmalloc_node_noprof(NULL, struct_size(tbl, buckets, nbuckets),
 					     gfp|__GFP_ZERO, NUMA_NO_NODE));
 
 	size = nbuckets;
diff --git a/mm/util.c b/mm/util.c
index 80430e5ba981..53f7fc5912bd 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -593,9 +593,11 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_mmap);
 
+#ifdef CONFIG_SLAB_BUCKETS
 /**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * kvmalloc_buckets_node_noprof - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
+ * @b: which set of kmalloc buckets to allocate from.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
  * @node: numa node to allocate from
@@ -609,7 +611,10 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *kvmalloc_buckets_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+#else
+void *kvmalloc_buckets_node_noprof(size_t size, gfp_t flags, int node)
+#endif
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -631,7 +636,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
+	ret = __kmalloc_node_noprof(b, size, kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -660,7 +665,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(kvmalloc_node_noprof);
+EXPORT_SYMBOL(kvmalloc_buckets_node_noprof);
 
 /**
  * kvfree() - Free memory.
-- 
2.34.1


