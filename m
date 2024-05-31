Return-Path: <netdev+bounces-99824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB68D6990
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E46B26079
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34E17FAAB;
	Fri, 31 May 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfluF7TZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29D17DE1D;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182900; cv=none; b=WaKzJlZWHVqp8DvmBAZedB/KNJF8Axe0Q4N06u/0FgyGgn+gKIA7FrZ/GW71+a8VR6X3DkkXGBjhkeM3mJK9M5GOESRd6L334GfVIqhEFbWnw3R0IWYpwGOINK3GOvONpY8gxD6o0e+1FHoQDMsNICGIWaJ8AN1G85Rdw2DHhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182900; c=relaxed/simple;
	bh=Mz67Iw49GR9dHuxCXZEK5DP7jtaPkYbVmfaXomUh4Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2VBwwyT6chmqpgkNmbCJ2a8Nb0MdB/yIxzPymQ7boXn4mbsdASgy42hUbnBfXD9NQO37v9QjgYUaIIBg0H8MvjtStc/jgHUCFCuRUqaBFjIY+oysDGcz2aRjXsU9VDU45VcpdnTrihrKY0fAjuEU1QlGxfrVjVGdDHzNoKXS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfluF7TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83B3C4AF14;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=Mz67Iw49GR9dHuxCXZEK5DP7jtaPkYbVmfaXomUh4Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfluF7TZUaUoGLyXwpABguT3qbLtGxJfRuvK1/sobxp2PtxVb1OvM+4f6W0OqHeBZ
	 HVCzHLuNgSXNbiDvOWo9b7sp150CFJMu2u5Um36A0qhgQrBPy7TMnrLGv3uzbjkyag
	 ETb5sbk1uj1K2LerZ6n2j87yVt5dO/HIggUL9fZR7Aul0NbBjm/n43QC1+Hv51nB1k
	 mp09o+nVaHmN5D0x1KPcjGlapgB2ZG4WFgEWl5AlJB9c52+E8mPLywMYlQsclIHxnr
	 9KCd1BNYNPs9QuW+MPJzXFiKHsSxEdrofPeS5TkNIhK1n3PkfEQEpc0GwQ/T7EUEsr
	 q8HVHOW9Ln5Yw==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	linux-mm@kvack.org,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 6/6] mm/util: Use dedicated slab buckets for memdup_user()
Date: Fri, 31 May 2024 12:14:58 -0700
Message-Id: <20240531191458.987345-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3128; i=kees@kernel.org; h=from:subject; bh=Mz67Iw49GR9dHuxCXZEK5DP7jtaPkYbVmfaXomUh4Hg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxTogF+aXNFJapX/Rt8xhEoMFuFnyE/DJdq wqt+/Xyp5mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A JjfaD/9HhI1ZsSAtkAsPWK/ezBjLTmg9GWtl4cRE5dSCRoRpeonv9zJFzQSi/z6q8G0WsUdqG3O q3/OwvDkzuj5PVGBcnx18cxE+4jWy8wzjmDguTWCRaey3mtxit/8c4XHxisL60NntcKaMbwh1TN oi5hUUUDQgI71vHIiuoXRO7zD2LY7dCXiUhbTkKyehfUbQRNzSdc/2Pk73vDhtorWRkwDBJmAt0 uJkgJBPYxsUVHdzXRNgA49jdAloxUMLEOmlZE05GQz2kMjakueNT/8zW4hXJ7jhtvqRqOReYkWa CEnpQa2OzgwYHWFfEWJWI7MsyPy4M4h8Wy4r9jHIAPv1ZI/zkUTPZU9UmIpqDWi86FrEhYHDeqP 4CzdIm2QHlf9rFaFB3G8u+OmTO+U4UQPGxK10sZ/JNM5bmYPRvtF136Lz2cZZp6pDXpW5RIA31c pW3P212pGt3TZNiDXGRd6TG/m06XADFHeuA1H2z1/DCG0Pn0C2r1aG4jC/EWrlOH+81naGmWRHk YVXH7L3KauzmbodVlUZRHUYFlOFEtHjHjfnJWGZw1CIhpNZexJHeN8T4/Fl3NWTgqC6GdfKMkWI xvelqd86qCJCCvYtZVCbFr4MHOoTH1oyU+I8dvyKYQlqyqeJi07lpI6JnOevOTL03LyuLUsgq9e +5WiQK2W0zfBIpA==
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
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
Cc: jvoisin <julien.voisin@dustri.org>
Cc: linux-mm@kvack.org
---
 mm/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 53f7fc5912bd..f30460c82641 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -198,6 +198,16 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
+static kmem_buckets *user_buckets __ro_after_init;
+
+static int __init init_user_buckets(void)
+{
+	user_buckets = kmem_buckets_create("memdup_user", 0, 0, 0, INT_MAX, NULL);
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


