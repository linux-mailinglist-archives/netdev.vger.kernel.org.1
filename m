Return-Path: <netdev+bounces-105016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7D90F70B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC20287512
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861F15B0FE;
	Wed, 19 Jun 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc6m2Jyd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C015921D;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=k57D+O9B8kun7RBMxFIBOWM00CsT837xceeZ3ALtWULwCeXF55OQWFYZ0lbIFadcHzGNuPTj2h9lOBYy6Hmux4WYPBe2ooKrm9wdLZn1Br4Ai85X27QTROuEnN78DCs+rfFnwjmYzTim9jsnMQUqy1rl1OPshs015c1t75e6M/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=LrnolFNHWclGZ9p3hY/QGRuJsr6+6G+8GF/8xJCY8DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYG+zqaNvNblG7g8GGyaUT99qmzktI1gyGulXz17l8oSZ8oe3QW6i37E0F6zUz9XFwgfhwfkqdhBWhxVmzN8JVFP4Fx+r/scDYvHlA9kH+lyNtDg0nM8NsySbZm/GTEAec5x5ECqKmOOJpF9nmOxxxQ/d8YX1qjKKiwe/JR/D+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc6m2Jyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6FAC4AF0A;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825638;
	bh=LrnolFNHWclGZ9p3hY/QGRuJsr6+6G+8GF/8xJCY8DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pc6m2JydDigHX1wPdvV7BSO6pjR4OiuefHdkKa1fdpttENlQLKGuUfbGFFSu2l4Lm
	 lQD5iAks3gvBoAIfaXZXsbn9df6WJYs3vBKiEbv3bJ4PaaLahoIa4QSNZ1SYfuLbBH
	 EC/g9SUx1BXID0KIUyOFIJTu1RoIyozImXz+TkjeVy0SusKmCLRASggim94z6rYRCM
	 tO4C6jMpK8ZWUlJKguJ9sfCfZZJc1MVWVRiBXSV+GO5TXMdXWOzrdcFw/b8i8cgg7U
	 lBK0Q0+bcSuO5G7slNZJMYU9DBvzN/fxnRHAqOvcn3r1IAoqVZP9OzadrVNBk/NTEU
	 Fodm/pnVMavLA==
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
Subject: [PATCH v5 6/6] mm/util: Use dedicated slab buckets for memdup_user()
Date: Wed, 19 Jun 2024 12:33:54 -0700
Message-Id: <20240619193357.1333772-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=kees@kernel.org; h=from:subject; bh=LrnolFNHWclGZ9p3hY/QGRuJsr6+6G+8GF/8xJCY8DU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKhEAWYa/Ji7QXOW1GAYZ9rnB+j1DB6dbkqF TcWKMWXK8GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A Jna9D/9jn8FgmhtJGIsF1k6FXqxnOb5H/Edjil/UGnza0ThNC5KYFYysA7NmGEt75u5Ul8yTo/m mPSLD5BsKR+jO9ra+Jb1otzerSK7RPkiM6Imdxr4fUVqJRDIyZfow5kmiqU9kP3XohZkW6L9tCf Gg3Gf3IyVqjtN6r7kMQfjfEwb0asp7l19n+RBG+Y+rCjuwW9f0zVuora95LsN+puXykCTSHPd8l triyydYzJHXgpSTHex+MpUFovzc22Spf+qmwDTaHqtewlJLtF0Yv2hU8zovuwGlpfr8ByOElpfK Vk+S54XYZnxOLQ67p3popKVW0MElvIx5m8o5iUKZDmwhhLvPBOzUH1bT6we+7qxY02Rjs8l7tcq 2WQdGuzFjXnYo2mAqRN7l7S7Cq1nPwRpwtPoUinjqbvdFIV/NRq9GABynRSpDqxH5qrbas9689/ gvJkHTXbL+PSnY6Qs32jdRqdMuCqHzXkPa02gx1uuVpAPC8z9C0JsTzVOz30ZPQ9b0RmeBt9pE6 lT0nq+2zyjP5Wa+1oEckM/FhVlBq0s4VsGGABVI6DWi7oWRyz/ZZfn5gV0N4qWgfnHJalyM3cFC 3O6fBUVeH3zAlDMwpz+DEypq18nKLYt6AtEq5WMurqTQR+ES3H6DKAtjc5xSYw6hrbgAMWMSOLR smdpkS6OJkKmNzw==
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
index 28c5356b9f1c..6f0fcc5f4243 100644
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


