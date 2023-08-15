Return-Path: <netdev+bounces-27709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19A77CEEB
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F49B280D39
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D3134CB;
	Tue, 15 Aug 2023 15:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCE14AB1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:17:42 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 06313C433C8;
	Tue, 15 Aug 2023 15:17:38 +0000 (UTC)
Subject: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, vbabka@suse.cz
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Christoph Lameter <cl@linux.com>,
 roman.gushchin@linux.dev, dsterba@suse.com
Date: Tue, 15 Aug 2023 17:17:36 +0200
Message-ID: <169211265663.1491038.8580163757548985946.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Since v6.5-rc1 MM-tree is merged and contains a new flag SLAB_NO_MERGE
in commit d0bf7d5759c1 ("mm/slab: introduce kmem_cache flag SLAB_NO_MERGE")
now is the time to use this flag for networking as proposed
earlier see link.

The SKB (sk_buff) kmem_cache slab is critical for network performance.
Network stack uses kmem_cache_{alloc,free}_bulk APIs to gain
performance by amortising the alloc/free cost.

For the bulk API to perform efficiently the slub fragmentation need to
be low. Especially for the SLUB allocator, the efficiency of bulk free
API depend on objects belonging to the same slab (page).

When running different network performance microbenchmarks, I started
to notice that performance was reduced (slightly) when machines had
longer uptimes. I believe the cause was 'skbuff_head_cache' got
aliased/merged into the general slub for 256 bytes sized objects (with
my kernel config, without CONFIG_HARDENED_USERCOPY).

For SKB kmem_cache network stack have other various reasons for
not merging, but it varies depending on kernel config (e.g.
CONFIG_HARDENED_USERCOPY). We want to explicitly set SLAB_NO_MERGE
for this kmem_cache to get most out of kmem_cache_{alloc,free}_bulk APIs.

When CONFIG_SLUB_TINY is configured the bulk APIs are essentially
disabled. Thus, for this case drop the SLAB_NO_MERGE flag.

Link: https://lore.kernel.org/all/167396280045.539803.7540459812377220500.stgit@firesoul/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 net/core/skbuff.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a298992060e6..92aee3e0376a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4750,12 +4750,23 @@ static void skb_extensions_init(void)
 static void skb_extensions_init(void) {}
 #endif
 
+/* The SKB kmem_cache slab is critical for network performance.  Never
+ * merge/alias the slab with similar sized objects.  This avoids fragmentation
+ * that hurts performance of kmem_cache_{alloc,free}_bulk APIs.
+ */
+#ifndef CONFIG_SLUB_TINY
+#define FLAG_SKB_NO_MERGE	SLAB_NO_MERGE
+#else /* CONFIG_SLUB_TINY - simple loop in kmem_cache_alloc_bulk */
+#define FLAG_SKB_NO_MERGE	0
+#endif
+
 void __init skb_init(void)
 {
 	skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
 					      sizeof(struct sk_buff),
 					      0,
-					      SLAB_HWCACHE_ALIGN|SLAB_PANIC,
+					      SLAB_HWCACHE_ALIGN|SLAB_PANIC|
+						FLAG_SKB_NO_MERGE,
 					      offsetof(struct sk_buff, cb),
 					      sizeof_field(struct sk_buff, cb),
 					      NULL);



