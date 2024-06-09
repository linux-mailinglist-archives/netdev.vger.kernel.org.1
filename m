Return-Path: <netdev+bounces-102064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED941901500
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CF91F21712
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 08:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DF52B9CD;
	Sun,  9 Jun 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="F/R38cNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1731A29A;
	Sun,  9 Jun 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921684; cv=none; b=SxS0UwzBM9yPbwdMmWfLwSU+XSdbZc1k7LEuPkDatNtOYY9s36SCyGwbQNRechzjyKVu1lcmmli8n2p/4IVgVIeyIbI/ih2+f9tFl7Bak1nm3xjjpF8J4HQenu7MPQTbFEiRCjTeHgVtwlHhpZ9HiSOMEqNq5/Bx9DxJ9dY7ZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921684; c=relaxed/simple;
	bh=8EOTu8NZ4aHBZgpM4sxRA7ZWvdlSMq3KQ0y6cMJN7EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR3zwsckDkEdXJRsdpyYYa4mVEffDKWk7KIvMciLQFC1mUOwPcH0c12AHF053AMkHCBbRrBd4o3YZRLSVhl2R/rtZmklWj1Y5gboPimsFFfpXeMxONBtTm4dvUYKcH76C9dzFCGqP5tyrUOUfasJzJyCCtfiI7yyZMy84tYAMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=F/R38cNn; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAvqrV96Fd95umTQHo+JdDNYWaawM6mlWB63mVkkehs=;
  b=F/R38cNn+JijIjLHTLOX5+YPa5oWs1wb9JyMvpLOTRx9OetOCootFXIw
   V88tEZuxx6Phy2thcxn8H6+fL5njGx+5It8ZdyEN69Dug8nJemoyTfVTA
   DNoYk+4n4yCjlrIaGjp1/sbibgwL2/KkGyeRLdL44lGPeBKvxJbt91Sdt
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696897"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:48 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "David S. Miller" <davem@davemloft.net>
Cc: kernel-janitors@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 02/14] net: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:14 +0200
Message-Id: <20240609082726.32742-3-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240609082726.32742-1-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed, it is not necessary to use call_rcu
when the callback only performs kmem_cache_free. Use
kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
@r@
expression e;
local idexpression e2;
identifier cb,f;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
)

@r1@
type T;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,x);
|
   T x;
   x = ...;
   kmem_cache_free(...,x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n"
   cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f;
position r.p;
@@

- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)

@r1a depends on !s@
type T;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,x);
)
- }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
 net/ipv4/fib_trie.c |    8 +-------
 net/ipv4/inetpeer.c |    9 ++-------
 net/ipv6/ip6_fib.c  |    9 +--------
 3 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index f474106464d2..3ed92e583417 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -292,15 +292,9 @@ static const int inflate_threshold = 50;
 static const int halve_threshold_root = 15;
 static const int inflate_threshold_root = 30;
 
-static void __alias_free_mem(struct rcu_head *head)
-{
-	struct fib_alias *fa = container_of(head, struct fib_alias, rcu);
-	kmem_cache_free(fn_alias_kmem, fa);
-}
-
 static inline void alias_free_mem_rcu(struct fib_alias *fa)
 {
-	call_rcu(&fa->rcu, __alias_free_mem);
+	kfree_rcu(fa, rcu);
 }
 
 #define TNODE_VMALLOC_MAX \
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
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index d9c9a542a414..bf6908010641 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -198,16 +198,9 @@ static void node_free_immediate(struct net *net, struct fib6_node *fn)
 	net->ipv6.rt6_stats->fib_nodes--;
 }
 
-static void node_free_rcu(struct rcu_head *head)
-{
-	struct fib6_node *fn = container_of(head, struct fib6_node, rcu);
-
-	kmem_cache_free(fib6_node_kmem, fn);
-}
-
 static void node_free(struct net *net, struct fib6_node *fn)
 {
-	call_rcu(&fn->rcu, node_free_rcu);
+	kfree_rcu(fn, rcu);
 	net->ipv6.rt6_stats->fib_nodes--;
 }
 


