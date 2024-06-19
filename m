Return-Path: <netdev+bounces-105011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A7090F701
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D941C22BE9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F694158DA1;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCyQBt5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11978155759;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=cwK4McwYrzAiJwSq2ZD/XH21qmAZUGk59QGeLUmnTtr4/Yl8r0Jv0jXfW4/v4RGKfo4vHwzEHUNxl9+37p5/1RHmKM4JAiJ9zhArUU/VWrbehIUl5OyeYyO0+XxOuJPIWSgCBtAhZh91jdmC0ctPSW1mMbPTk4cL9eXexyE4/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocvNig5MeyxMT5aMn7Pob4T0T6Yjb8nFYWdmoWb3gPsAVqaPJnq6b0BBXxcvhKVhE+550Bfe+N4gg+EfHMDYxkD39jBjb4cyD6eg1Y3R9P8wKoduF1tWufmP5BOUMqwncYGqjhSIx7vvXTYWvAFhV8D0wfJqWFLp2Dn5rg/fRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCyQBt5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50BDC4AF08;
	Wed, 19 Jun 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825637;
	bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCyQBt5W1LB+VIF0YRwWomc9oJnTKvhC4csl7t1FMqLzr79+LCzMZ4GfPx8Bjh64c
	 K5A5x5XbgSx5bgRgdJgtfY+lYnkb6uee9IXIWSJq2FAtOvKwmMk2w5rYr6qbEb/nMh
	 t+0gx1Sef/GMlGPyl/jpTXLHHwqH5h2rPL3mPe8HNZrXFJKXE0/mz5/9OnvGTG1QFj
	 CCb8pT3aO3iucUMGBBD+k7BbUpejJRBIqxb7hTUa3H77t576ojcEVt9ITWRL832ZtH
	 +kDguxYTHditwu84pRw6xbaV/NsenVniruEylET1/8p1QmUYSru3OQ9+5iIBWPKe6F
	 GgEkkm9+qdgeA==
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
Subject: [PATCH v5 1/6] mm/slab: Introduce kmem_buckets typedef
Date: Wed, 19 Jun 2024 12:33:49 -0700
Message-Id: <20240619193357.1333772-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=kees@kernel.org; h=from:subject; bh=jbXDHZFgMTEqVuIbGpjVHki9R28/opuEqbu8dA+PhS0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKh6T8pqxaDs77JF9cx/6sa+j5FaKjCYQYlt 8Av1OrjnquJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JnDmD/4lPT3IQnslSsmLm0/93PDrMo6dacPrg3fO6iYYge5SRvS8tMrXtla/rIN7FC2Vv9yTvN8 3aMsnyY8X5gSVBi6NnUdOanCs2w+MziAmdDjP4Gaevg1LQRWCzOfOak5shXpArYv+qoZdPw0Ttt LD1n9zWURQ830r1QQ/RiHGcwhlQNTeHINjMW18GIve5hEb2ZaV19FJPBMQP6GyIMeboDi5Zy0m/ RiXCicXZkU2K/T6W7jvQfVD85odLnhPoVFL98TUkeaPAn2aBj54T6GgYlPyc4B1N07E2F7TfLiy OfVAoefI78Tcp2cB03HV8piNNGzhTPM+siCg8NfUxReQDbmLjmWDYw0cPwbZBLrPP+xZ+1vvP0J wmve26MopNZXLnm6/NWvBZQs4gQxk/7OUINSKKWjdRYwClbZWqq0iqM+jyoeuaHxGeb5tpNYp9M FHMNBNVA95dzB3FexZlV/JwN2CkvN4ZnJd163nXWHOHdkxwPQSZcT7/uB1h7U1LJb1urQasc4Pj NUiE6wks+0i9AhkcnSPdNbCqXJMzNe7e9vTU2fFtj6CnSGGGha+HRGmubAwnN7u1F0tTw7tujn+ J+njOxDXJY1DPMy0lGGI+GwZY+8vnPIeWOLFnRXSn/4ph5gnyx7KOyiXxIkxiLJTt5dJbbJJHZF pcTcJxJ0nTDzcHQ==
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


