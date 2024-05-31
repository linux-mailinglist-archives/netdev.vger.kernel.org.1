Return-Path: <netdev+bounces-99821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E38D6986
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5341C2467B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE517D363;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcThVp9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C17B51D;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182899; cv=none; b=ZXoeAaPapy9yYcl5qJh4LbyZu0XjSV9YViBsMcRH1IhrEJSyKIyNuekwGsJvKdBZBNjQPoKPgjtGrXUXcrvnwRX68tg1id3VC89t/K+s+qmiPH9QDxraAJZ+FIYYmugFy5k2f7LjwewkKw+y7SmXHpUZntSvwpgrT19qI5Y3FYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182899; c=relaxed/simple;
	bh=GCCmwO/29MDWHdLt+3VUIvxE5UJuxve2yweYGuL7qiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVihNRSBl7TG+UIsHMyQFc6cw2bYgdueWH/lqK2J3hM33xgS3wgCjW2GwcYDgnO0HBt5pv5LabqeizMN2Y00zZ6cZ3vT/Aewt3oxCUTtHWW3tggkFbvzlhED9OtWzbtpj+ThEqwTwzEDCUFu6GlVbo6svVXIzg2d29UoZeP3mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcThVp9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D812C4AF0A;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=GCCmwO/29MDWHdLt+3VUIvxE5UJuxve2yweYGuL7qiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcThVp9ODciDqR4t3BBbXTS6sQt/cbQ6XFTUxaxOcLk0CsG9Ctv6ST/2n88UxDg1i
	 cTmfdZrqxOqWGGQr5jpF0d7AyiP3J1Aj5rgbLC8nfsT7EIw7Z4U7NqzNMW+xVh7N5p
	 OsQImzr+tvg427WjiNLLdXg4mPwTJhgtCCTCiHWGC+r1TFZCq6JaSsR8s9KaEIHqWf
	 OBHhQRCU/Cb5tOIWIP7oGBkHZ6k+sAB7d1yJg6JddK+brFv7eiTdaaVZ0RuPDOhYvU
	 6vztMnE/2hYdUKAqCUrWgEkWRpoGXwe5todNt35PgbRx7Al8iN1/YfFuqTl2oaHGq/
	 1ii38BhumuqBw==
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
Subject: [PATCH v4 1/6] mm/slab: Introduce kmem_buckets typedef
Date: Fri, 31 May 2024 12:14:53 -0700
Message-Id: <20240531191458.987345-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=kees@kernel.org; h=from:subject; bh=GCCmwO/29MDWHdLt+3VUIvxE5UJuxve2yweYGuL7qiA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxJyLrOsUa6xU6DBGw+2yp7OUHaMAtvGnjr vnReswagR2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A Jod5EACfz20WkxqWJaAiwfbSw0tisbkRIA7NQR5NKbhxr5QTTLMcM49PatlGCuMu/uVIDNgCnCE 632ua5oc0HCyQXf9IfE35ke9Jo/QNgyG9S++26daItquqVgKQW/8Ast7pQagboaHUxQW1NTdCI0 wUhT3zl16pYuO0Vc4sp/ECUxMl7ZzGTGEkNHtxcsq+5BM194IPqUFUeT/DoxgrR0GtpUCojtFyi 8As8UtO0GYv5rG76w2Q+67MOKcVsQNvA4pJ31EvnjPpKYhjFD//n+/gHC2XY0eGckm0hN43T88b y1LlH5ThWVmIKeP1JV7fgv0NCN4WMOZKqW1dlxJEVywCaL+0n9KmVUJ4Jm92aWqv7767SrgcLY3 h0/q5nAsQuoCgHFyi7u9WhVFxqr0j3InRibsVIOQRxImTET8qh6Wtmxv373Sf2atQP8a0xlcPMv VOVZg6X+un864Nh7tQ2+bMWltaqq9X6xIQN0Gun88AfPH1AHnujDjbKV1P4fEkfmvu5E8XgKd+E Av5G8lClHZxbCosNd7q33lZXSjwr3g8zRTFM9A3lGpWI6jPnTpDDsUInP37Ll9haL4zGGxaQZW7 +LIUy00LcQUCdv6Czd8IMansxZ7b7xBd+q6+zUMM/ktgono3dI7fSFrN4K80saSpy5mUEgjzqLE HK9LKzxl7bkm78A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Encapsulate the concept of a single set of kmem_caches that are used
for the kmalloc size buckets. Redefine kmalloc_caches as an array
of these buckets (for the different global cache buckets).

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
 include/linux/slab.h | 5 +++--
 mm/slab_common.c     | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..de2b7209cd05 100644
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


