Return-Path: <netdev+bounces-134975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28399BB70
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CBB20CC9
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3213155389;
	Sun, 13 Oct 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="W5ceyRck"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9DF1547C8;
	Sun, 13 Oct 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850693; cv=none; b=Oj0bE0mhuQUoGwADK1qT+0RSnI2MIS+vyCrkG6Uio25wSeYyKpgfdjTLEdkcTw6LopNlx3JsBsolIAxFpzKHtL8QtiQUYCK77sitXMz0pl8dHq0kje4uvlopVlEsRonkH+0zZG1fBRXYaP0Qm25tBCft+hxbfFWFwthds2YClwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850693; c=relaxed/simple;
	bh=V5PBUsKncn96bjJ6u6sEVK5EB02JGY/yi9/jA8dXD+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJPXniyOWj+Hw/dsrcoJ4SEdgzj7lzIWGaGyYze6Ojd8qCa7HQOovfq1KcwBzzZr+4KXSbfhn29R5hFMTC1gyaaGDGwAl4xh2tyXKUwafYO+mkwXHvuM8Jb+kwwsW35QsYasMwLKnZ7OxzqqJIK/8g9L5ybVTxb42xl5lNtSN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=W5ceyRck; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6aCSwa7ytGQWGO1WgXKWjeSpz8ULYiZpM+CVF4UzPA=;
  b=W5ceyRck/ORTx4UMgMCOzTVZ8kE7KmD5/3/1h/Ie5UWlkhD6xyV3+AVL
   pKdsJBVojKwRj9U9bH6xhs6Fu81wmnvMcktusXNX0fozRk1yBzUCrhC8G
   Wk4uPXSuqiyVXkOG0y+JDvO/W3Pv3CCsltP8MG5K8x78paS5b+ENsr+ca
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968278"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:58 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/17] inetpeer: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:50 +0200
Message-Id: <20241013201704.49576-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/ipv4/inetpeer.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 5bd759963451..5ab56f4cb529 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -128,11 +128,6 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 	return NULL;
 }
 
-static void inetpeer_free_rcu(struct rcu_head *head)
-{
-	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
-}
-
 /* perform garbage collect on all items stacked during a lookup */
 static void inet_peer_gc(struct inet_peer_base *base,
 			 struct inet_peer *gc_stack[],
@@ -168,7 +163,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
 		if (p) {
 			rb_erase(&p->rb_node, &base->rb_root);
 			base->total--;
-			call_rcu(&p->rcu, inetpeer_free_rcu);
+			kfree_rcu(p, rcu);
 		}
 	}
 }
@@ -242,7 +237,7 @@ void inet_putpeer(struct inet_peer *p)
 	WRITE_ONCE(p->dtime, (__u32)jiffies);
 
 	if (refcount_dec_and_test(&p->refcnt))
-		call_rcu(&p->rcu, inetpeer_free_rcu);
+		kfree_rcu(p, rcu);
 }
 EXPORT_SYMBOL_GPL(inet_putpeer);
 


