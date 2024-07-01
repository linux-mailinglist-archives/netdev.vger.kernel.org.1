Return-Path: <netdev+bounces-108251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F98591E84D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D422815FE
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560116F830;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWa0R0t0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30E15DBD6;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=M0+2G3PFtXhoRzEJOQiiIyHqitorrldo8AGuTzCZTBr7b/+950Y1MpgXOmGOk7g75W3kCFIHlwH8pmzIVp5P8uT5OiX4mOW7GFoauWEwGnSbrZoqUR9yGCzQ6UkLl3pF0EZs0UTrt8m1G4aNbT0HwRpA3lpUzbwVP0mnQn9dD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LibInC9MuFu3CA+m+K7cRgO4B2F8K75T7AJ4hTUEkF/0P3l0O4RKy0RMeMkklvod1fJ3EQD1sznybQeQXZgygsKimKFrsV2nX/2V+Ha+1K9dsUPX5ugBbsBRGHGewXzLpCZAJMPxFKSzIqGN6mU6NuqlEYPZovWADArZts2sk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWa0R0t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F71C116B1;
	Mon,  1 Jul 2024 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861184;
	bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWa0R0t0CPMjfv3nmnvMRYyT+0Li3uUEKN+F63bIWHM5FgA0Zb/H43PrpIm3S1wN+
	 cSuMAUVGcDq0VPaulTBXEjeP2l0TB9xjG+2UEbX0qsjc7rkvAiBsK7+I89ex7LZgPn
	 gSDpEciVyMFmJKwREVaeNILwLmK/hGuEJS/2ULgNgm5mGv1s6E5j7ocWwtsbwUki+K
	 LpaAGUv8GppMD1wiOwENbbpsCWiN8oDvi+xBdQV6MjW9MpuGnMlORr8FgmERKVods9
	 T5l7dWXqZMYSVX7ZmrKdnfa13VayjeNzXw3WFOR4TiMnCppfx/DXKOHiSND+6cIfI8
	 fVtSgUXMY0gnA==
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
Subject: [PATCH v6 1/6] mm/slab: Introduce kmem_buckets typedef
Date: Mon,  1 Jul 2024 12:12:58 -0700
Message-Id: <20240701191304.1283894-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=kees@kernel.org; h=from:subject; bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++6T8pqxaDs77JF9cx/6sa+j5FaKjCYQYlt 8Av1OrjnquJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A JrDmD/41/LShofUlbbo+pT14hOQzRPFxn19omAUJjuXG/RFbAAjGUsA1LVdU477HcV5iEqq9HwZ yownqKuZBSfRj5jSdbb8lWk+EvNPMJcq/bjuHRBHRVzCIF1dak6lCsCilziR3nDfx0QcIBdh9uM ZfgpyACf83OKtGsnoVrd9PtHkCxzzK4gCsg0cYfwsiMY7lZKRpJkm5Ovl/QeoBlcThOt4kLCnPh VK6h7O4Gi07HVvy/hSMdFhZ/Yg3usgb54keafxYrGlWCSoeYcfA7mccU3Fizf91lu9+yuMRRI+Q B6mnj29oSUPJAd63diYXlmeQHMKkR54f1Ugms2s/O2MuxJ5NN2PeSn3IyL3FbkxJlfCWK0XQ13/ FJoWJFVTtq1PfnOsq/2FR2LpfnPbNPfS/mBp2KVYU1xxcNrOTQ6PmfLN8NZ1dJZnWcctqhlAPvx qAyGmwfuj3emanIzCY/cVU6cLqr6IHmmy9Ejo46YzdG7GTbl1t+0VhPhVwMw+dnIFqJ2tHF6ffU 9S0/hRjxjVGzgpaGI3Rrfzzq/1Rg3PTRcuiXzLrK0K0yBR9YXwRUNuyztoKNbfzA9jitdfiuMBO Ro5XeQMITAZry0tFYeSs/l21CrQNLwzrU/+aIm+fSGZ9J74J2UiWplyhtTCe8DH74SORzWApt9Y atfme+bo8XXfHfg==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Encapsulate the concept of a single set of kmem_caches that are used
for the kmalloc size buckets. Redefine kmalloc_caches as an array
of these buckets (for the different global cache buckets).

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h | 5 +++--
 mm/slab_common.c     | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index ed6bee5ec2b6..8a006fac57c6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -426,8 +426,9 @@ enum kmalloc_cache_type {
 	NR_KMALLOC_TYPES
 };
 
-extern struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
+typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
+
+extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
 
 /*
  * Define gfp bits that should not be set for KMALLOC_NORMAL.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1560a1546bb1..e0b1c109bed2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -653,8 +653,7 @@ static struct kmem_cache *__init create_kmalloc_cache(const char *name,
 	return s;
 }
 
-struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
+kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES] __ro_after_init =
 { /* initialization for https://llvm.org/pr42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
-- 
2.34.1


