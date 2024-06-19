Return-Path: <netdev+bounces-105013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95990F704
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7FEB21ACD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B1158DC5;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQhXPL1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F21586C9;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=trAmQiAcAuuodvDB40yuAy2f+bbrNwQ0leEXa3jgsGyD5qZWUYeH3GUiH4I1GZm8UkT08UifmVAc2JQTaN8z9w38jGNGrpOE+SqIrcBu3iPOYPFuUvcnCzi1+5L/jbaz/+UgbXeHHqxv6vIFQS3doxjkRjvWR3Dh/rTIm6/CLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGMYIxg270vhxIPmDJPG/tLt7M9gnxS9y1SsNKXLsBah6HQ9covjQi+ye/S+d2rYa7zrAe/gPWkDJZJMKaHsMiSDSt1JgHlET8HNUN9xcSyZGlQ7NsdnwqppODIHzupPsw+bH7F4rTJfvF2ZgBKJJS4DZylS5HZmgmDcnXG4IeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQhXPL1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91B1C4AF0B;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825637;
	bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQhXPL1C3OHH54U1cVXlN7BmiNba91nmMpHH/d0Mozd9pLGODxYsU7/g/xaYKeK74
	 uso2CWUwa29eAbBPUx1NxMjoMXhj69h8q+Zp/a+uOzTPKuQhzXxbPmbRZy8MRamEGm
	 Eq5OqHkAcxj6qcRj+HbzAxcJ3YK6x+2cdgEc8OtPdakCmbRx7cc2M5BRuSgQGJFXvI
	 +erQKYRCHeYgMRlL070hUjRJ/cXNQmSS+bkGqwddmeGyhgNESjn27Oez2GGjmPrsfT
	 v1HHi19jFtlWwsrVClErAHoUMqrOOjoxKqxj//KZ1AUrI+BUpNCZAbbiMwkmVGOULG
	 Th+do/dczDw0g==
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
Subject: [PATCH v5 3/6] mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument
Date: Wed, 19 Jun 2024 12:33:51 -0700
Message-Id: <20240619193357.1333772-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=kees@kernel.org; h=from:subject; bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKhrAHw0U+CEnyXA/4XClLK6QAyqHm8wswfo OqdafG1Bj+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JpVcD/99ig6OdPl7DaH+0pAyKM3SG549CREJbtJi4lqSfP7oUzPpDpw8cC8JaJM3I8Gdu+iTiYd KOcNq3k5dY7YRMKVw2/U/+T4xUbQ5Z60fgOHRiBp0PHwY2C0TqjCVz4MfH23F9rTtFTteXh+jba gUikGWelLqlSjwS57roBtFMNzGUG3o+1/PXg6bar8KmwUY1yb/PQmLTy901tuQ8FD3qgBJ+5PWV PMi0V2v1xjAn5dLtUGtl6vX2+CB5sVP4LiSls41wOtBLOGDMzo/OV84jqpO5uZsAzaS7dcEX9NQ 1MU1fY3W2R8Ne9sPruomOQ7CHvTiRjRG3w1GQPMGqJb6iyHSwPe858NullL22+vxFriTW9+kDSN QmNul/Briq2wF6Xh/UYxhuMNLRbIcK6MVtJZebpKyfw7D5aXV2/In1sY/pUmT0+MKrb4CSBCgAm 4Qbky6Wd7FowZT8jYT2c1gI+SrjZ46v3qqjw0v9dmtfheYHutq5I9VYvtTBuJlA1cnlECnD9tTk l+W4f58PKW0aibacXzUL8jzPF9YBzqqJTb2urpfvAT57xT4bZ7K7ihli33K0/D01oCCYM/1bmyQ XbZKRQRIyRpMaOdFRLiZdAjDpphSYA9yPZgKBmyeXHZRsg/wFujguqKPECQKlqdl0uR0CG5N9Uh wXG82K7TQBZbhbQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Plumb kmem_buckets arguments through kvmalloc_node_noprof() so it is
possible to provide an API to perform kvmalloc-style allocations with
a particular set of buckets. Introduce kvmalloc_buckets_node() that takes a
kmem_buckets argument.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h | 4 +++-
 mm/util.c            | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 708bde6039f0..8d0800c7579a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -798,7 +798,9 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 #define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_size(1);
+void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node) __alloc_size(1);
+#define kvmalloc_node_noprof(size, flags, node)	\
+	__kvmalloc_node_noprof(PASS_BUCKET_PARAMS(size, NULL), flags, node)
 #define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
 
 #define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..28c5356b9f1c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -594,9 +594,10 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 EXPORT_SYMBOL(vm_mmap);
 
 /**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * __kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
  * @size: size of the request.
+ * @b: which set of kmalloc buckets to allocate from.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
  * @node: numa node to allocate from
  *
@@ -609,7 +610,7 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -631,7 +632,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
+	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b), kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -660,7 +661,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(kvmalloc_node_noprof);
+EXPORT_SYMBOL(__kvmalloc_node_noprof);
 
 /**
  * kvfree() - Free memory.
-- 
2.34.1


