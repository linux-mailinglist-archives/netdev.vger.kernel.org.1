Return-Path: <netdev+bounces-108256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7D91E857
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CFC1F22588
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC49171641;
	Mon,  1 Jul 2024 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFl59nSl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D416F8E0;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=NMgIwQ8MXZqObKVJMeFzB42UPITBQt94pr+qS8ofjudzt3JluCE6jN0Kr3Bk4vW+an+KLOMBlp4pu2GTNNejCmqLqlEbaVv+CPfPjKynGQnzaPaE7ib88dxNJLP1AuMybCYbZ0PnbHZaLZhT2tkuviQUNy0TeP1mEU2nHcRN3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=BZ80Ejo56zseoiz3weNc0AtXfj9+HOXw5S5R0du1E70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxGPtB5ST5ZzZFX9JJwQPeFDALcRgpjkAJzdxshp3521tCHkUJUjTZCKuQm1ExgODg7FMGGLzmtLTphIr45LB6KlfEWJjSaf9hQw1pxJ2biLVvkP16o1FTAescI2+tir6EURJ1hH4hREXEBJJ/VlbKuctGGO0pmoP1kYS2ZATJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFl59nSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA58C4AF0D;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861185;
	bh=BZ80Ejo56zseoiz3weNc0AtXfj9+HOXw5S5R0du1E70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFl59nSlnVaSRU4+0HTFQ/YeTaJahbBTt5u256YqqA/IZQs7WUOzBvYKYRUR7Jmb+
	 wChXJYbVxmTLzNRLpAAdNpOUmpNsdgtdPYaJohsJXrbZU6BCCf7ByLGnDH/BQ216L3
	 560Mu5RiCeTyUZ/1umQVt9bDpooP1+0DEUxtHU2rZe8fjdKsqR/lSu/h5TyYmL36gl
	 B+EZzQJtEw/HTSqmuDqIJgLCnr4S7c9/dCzAmRxEeHSGjY5ypxgKwo/Qu6ELpXbvlh
	 V1yE6QbOqM4goWOm1jibPASL3Mm/dft5RrFbUr9E7X9HNaKn/bgWcHd4IL6jWnK2Nr
	 qPcQDrAj7jZcw==
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
Subject: [PATCH v6 6/6] mm/util: Use dedicated slab buckets for memdup_user()
Date: Mon,  1 Jul 2024 12:13:03 -0700
Message-Id: <20240701191304.1283894-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=kees@kernel.org; h=from:subject; bh=BZ80Ejo56zseoiz3weNc0AtXfj9+HOXw5S5R0du1E70=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++lHHVc7IaWVXSWcs6s/+88cmgFNyMQ+/tk NfYGR7ScZKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A JqpJD/9rs0Nsc8oYdGcPhljjR3Oz9ava6B9ExnvhV2nq0WD+FJVM5EdnZQAwoNyWeBpcuY2PjdX lGeJh61ZCUx/6o593wAWAgLwf2e/Mhg8nSPBCedp2wVFCHCVtzZhrNBAaQlXjO3gqzsR3DB03kj bchxInUC1Jscc86bOfbjVaIQ5IEy5V7YzHU6nQndBY2UIg+uZZmOkFzlZJpnMapIejOc6SpanQA hV6NVDpX2xdgr7MF4aOqxOwTrZz75rZo/5GXBqomoCrJB/fD4y99gSAraNxMJGvzAIKI8sJVGKr nsL6Q/dH6LCFuZlplSg3SIYt9Gos+RIxGQkllf9g7DUjeUG95w+fsoV1avbkZXjgQnI2mfAyjMF LgFIqrfiAFybNMFQqTOyMz5qVVeFFFi/KS+LDgZLc8yQlhZP519x+tJ6F4oVUtqM4dW5u4yP6Vp DG21pqkK6pZGhWARTM64DaxCBk/pN0rgw4Kuu/yLd29xhS7+fvJkksPam8vLip8OXe83i4Euu0m JTpZvCyJaLkwRmeqjgLa8fTykUMXm3m1HS9xyfPOrqmY9zOiJg6hGNR8aS7wdw+z9wjeph7E6pc z2OqisDHlJ0Pad2aMEfBofKXW2BKrBAxRPKjOnkC7biQAMODdjv2mPwU4BWxkHlSZwtHdrCs+GE Lj0ThhUc9z01RFQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both memdup_user() and vmemdup_user() handle allocations that are
regularly used for exploiting use-after-free type confusion flaws in
the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
respectively).

Since both are designed for contents coming from userspace, it allows
for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
buckets so these allocations do not share caches with the global kmalloc
buckets.

After a fresh boot under Ubuntu 23.10, we can see the caches are already
in active use:

 # grep ^memdup /proc/slabinfo
 memdup_user-8k         4      4   8192    4    8 : ...
 memdup_user-4k         8      8   4096    8    8 : ...
 memdup_user-2k        16     16   2048   16    8 : ...
 memdup_user-1k         0      0   1024   16    4 : ...
 memdup_user-512        0      0    512   16    2 : ...
 memdup_user-256        0      0    256   16    1 : ...
 memdup_user-128        0      0    128   32    1 : ...
 memdup_user-64       256    256     64   64    1 : ...
 memdup_user-32       512    512     32  128    1 : ...
 memdup_user-16      1024   1024     16  256    1 : ...
 memdup_user-8       2048   2048      8  512    1 : ...
 memdup_user-192        0      0    192   21    1 : ...
 memdup_user-96       168    168     96   42    1 : ...

Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
Link: https://etenal.me/archives/1336 [3]
Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 mm/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 28c5356b9f1c..29189f48ee04 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -198,6 +198,16 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
+static kmem_buckets *user_buckets __ro_after_init;
+
+static int __init init_user_buckets(void)
+{
+	user_buckets = kmem_buckets_create("memdup_user", 0, 0, INT_MAX, NULL);
+
+	return 0;
+}
+subsys_initcall(init_user_buckets);
+
 /**
  * memdup_user - duplicate memory region from user space
  *
@@ -211,7 +221,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmem_buckets_alloc_track_caller(user_buckets, len, GFP_USER | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -237,7 +247,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kvmalloc(len, GFP_USER);
+	p = kmem_buckets_valloc(user_buckets, len, GFP_USER);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1


