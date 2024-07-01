Return-Path: <netdev+bounces-108254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125CE91E850
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B279C1F23255
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6816F84E;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMao9yoX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72816F278;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=h+KO/81aKlSSRE1Niy/rTn7vkWgjIgelYexo8pZHH+46MNK8lbHIxQoGX0VEMQOG+7KfgVM0/TxwRUrLZnWVvrXjgKsRDurDyLLO0k++Oz0oU4tXH9bsl8gwQ2wpJuTMQ9d0x5TEuY1zQdtd/W+9J1NaITsI6ARqeRHr03Swlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBj5QrBmnfNOg2eP1ww6mVRppb+dQwJGnmT2uVJWLCoreJOwqaZmd5UHbFp/PiMqXw8t3EYh1hIBu6Bxb11QlwLZkhqlvd/7ycwbsahALWi9a/4VN0KHvCKAVmW+c58wGmyN7DLZTJI6T+nJ8HcuqQ5EK+10sf+A3qJCnUsz2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMao9yoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4989C4AF0A;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861184;
	bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMao9yoX18zMVhMQY5kIolTbGVQ1jNtDDjmsTCB1JdDobR3dwbrFWHV4S6VLmWFQ6
	 8klmPbsi/OtNrbFwfYS/rBPG3KZGTj2fhyS7xNyw5asCH7SzSgCPO5zq4qlbgmJVC4
	 NlzKgmInTFyAWCzXWeqI/pP1k9mxSB9+5iA/G25w4RRI/8F7Fn4l/TaWWuIZgjbV0O
	 4PFTz+aPo3ftiGxkUDdGoJVCN+BSH5sVJriXl+rpVGOiq3qanJo2M802ddSfZPGdfg
	 rZo1KXvtSOciCb+zMGA/Wx9Mm8L8/fQQBF2P5oOH8z0fF+CUrt0RzcxI+SL5n/fjyN
	 gvLwRdyObFs6A==
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
Subject: [PATCH v6 3/6] mm/slab: Introduce kvmalloc_buckets_node() that can take kmem_buckets argument
Date: Mon,  1 Jul 2024 12:13:00 -0700
Message-Id: <20240701191304.1283894-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=kees@kernel.org; h=from:subject; bh=xxet30UEfeVq/dWdKRNFzCWZboWOxErsseLhti/TXwg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++rAHw0U+CEnyXA/4XClLK6QAyqHm8wswfo OqdafG1Bj+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A JnwwEACfJUwABmsGkmhqQnATf7Y0sAvd2R6x4c0rtnoHIuF4bVZHVNfrX+sm0soE98hTF6dJhSb 54g7YCknTpz7GmrfaJ5B+6Nt892AgOuCstHR6q3rMDkpbqRRk7a3VIOEqbNnPUNJpyf4Wj6oTB+ FpKGwepyFVPdvd7Prn6jPRJzZQmnRlJRqG73USLhSw5sSEQjd452tI2JG+gHL/qwx11dQeJHiEr 9+/VZ1zhVvgJ1rrfQ4zOcSEPDuuIKjF75SGADyD6H0y20WrMSuGAHFoJpbJYxDkAJE4Gv1Yq28b NHiH8cJzxNi85ddufgze9mVDh6j/09oxZUB6Q4kZYmqy9Xu+f7qrxqQbLbnKV1XYYP9ZGJN0v8H Ludofn6ojZhgH8KOYlpEMD77aG9nOAYKMFPg5wBqXoXlzfhUVhS1Q3UlodTk7WQR9dhez0JEBpW /jw6xO8QkzUt0yBRT3nry/LJsmZmaeY54ekml6BugsOLniwFjBaq/fs/7a6TIDRO8ESL24TtvrB 1GNHbIRz/GxaxHXegXWceNTTLerX3JSOVEnG3qv1zJsV9XPTMAhmlZAV2DrLasptG6tkwgPC9zo Mf0SCpzv9ElM+HZzsRuDAJL6CkBHzXvbgW0IH4traaTQNdAHVoBKHn0pxZfluvUuUt4eiE9VO3D 14HEVxu1s4wtbJg==
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


