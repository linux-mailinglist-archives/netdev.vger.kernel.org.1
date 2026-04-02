Return-Path: <netdev+bounces-274355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFLNIa/jzWlVigYAu9opvQ
	(envelope-from <netdev+bounces-274355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503238330B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DA02302B831
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BA3537E4;
	Thu,  2 Apr 2026 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AjBkHBHl"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A108299943
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100722; cv=none; b=Y9Q3T07PkI5OZ6+L/oK3a5LTb0i2W1owGkXKXHE1xVZl4PhKdAXBVFlhVX5YnB/R6JC1mtO9ZAlzJNG2fSTO1poYJLuYxdPrGL7muaqx6sA3Fp3lxGVVnTSwbjLRgNxwvel/pq82ClZFThtZn65ZHYRZz5Iu5O8Y7R7sCTzlP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100722; c=relaxed/simple;
	bh=DDYL00tsA5dVafrHYaZ2fX3qZJ9OYC4SIx9vshfJkO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVIaruOtGSLhoWTn8e3UGm3OQ8K9dicfBjYOhJA7c5teSq+Se095XpzSmr/0320zo1N1deASmkBYpAhSWNwNv/CQE1PPMwT5c7Y9PKZzsJfin7WxDpapiGrX3Xu7ummdlZaaVTyWJ2+13HO7Xiox8ZbskBCKBZtN2n/6q+GQU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AjBkHBHl; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775100718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CA5IhrV4IVVDrsGLYwbUCdRv82E13FPWvHWrhHjIK9Y=;
	b=AjBkHBHls0y0rxzZbnZfQbgiwEpjsNse17M7S4vQbf1r20yX5r8nWzk67BmOUxXJqYlAP1
	OEx9JwbznzRu7hMB2iK/E7dMydBNbKuCKCr5c9d9+6TiZqumRoafyZQe68bxjLD7DJpO/F
	JtHQ+OPuTGQsRp7QhZEKfxWrlWAhyzs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Antonius <antonius@bluedragonsec.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v1] net: skb: fix cross-cache free of KFENCE-allocated skb head
Date: Thu,  2 Apr 2026 11:31:33 +0800
Message-ID: <20260402033138.388574-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,bluedragonsec.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,fb.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274355-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bluedragonsec.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 0503238330B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
bucket sizes. This ensures that skb_kfree_head() can reliably use
skb_end_offset to distinguish skb heads allocated from
skb_small_head_cache vs. generic kmalloc caches.

However, when KFENCE is enabled, kfence_ksize() returns the exact
requested allocation size instead of the slab bucket size. If a caller
(e.g. bpf_test_init) allocates skb head data via kzalloc() and the
requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
slab_build_skb() → ksize() returns that exact value. After subtracting
skb_shared_info overhead, skb_end_offset ends up matching
SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
the object to skb_small_head_cache instead of back to the original
kmalloc cache, resulting in a slab cross-cache free:

  kmem_cache_free(skbuff_small_head): Wrong slab cache. Expected
  skbuff_small_head but got kmalloc-1k

Fix this by adding an is_kfence_address() check in skb_kfree_head().
When the head is a KFENCE object, we skip the kmem_cache_free() path
and fall through to kfree(), which correctly handles KFENCE objects
via kfence_free(). The check compiles away when CONFIG_KFENCE is
disabled.

Fixes: bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb->head")
Reported-by: Antonius <antonius@bluedragonsec.com>
Closes: https://lore.kernel.org/netdev/CAK8a0jxC5L5N7hq-DT2_NhUyjBxrPocoiDazzsBk4TGgT1r4-A@mail.gmail.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a..87cecd40381b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -91,6 +91,7 @@
 #include <linux/user_namespace.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/textsearch.h>
+#include <linux/kfence.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -1083,7 +1084,8 @@ static int skb_pp_frag_ref(struct sk_buff *skb)
 
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
-	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
+	if (end_offset == SKB_SMALL_HEAD_HEADROOM &&
+	    !is_kfence_address(head))
 		kmem_cache_free(net_hotdata.skb_small_head_cache, head);
 	else
 		kfree(head);
-- 
2.43.0


