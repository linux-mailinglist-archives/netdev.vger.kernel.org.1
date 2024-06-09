Return-Path: <netdev+bounces-102065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F3901507
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40798B219A9
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F8405E6;
	Sun,  9 Jun 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="VR9ZkR/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F412B9DE;
	Sun,  9 Jun 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921687; cv=none; b=kDuC3jgKXJcFIJRpncpCawW7JxgB+WL5bksZJUgNjzKe11dIx2xJZ+XKahPey36LC05tUzftBCxlkoDdrnC9drb28FVit/ksEh1fHoQmlLD8B2s6Uhgzcr6MqJNVyFHpQNCeF5EaNmqP11E1CFzisUHlp5UVLPXgn9bjx6lBQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921687; c=relaxed/simple;
	bh=qLLVPjhv4+wYws/zoYNgUIy1WO/VEbOv0vP9ijH0hiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQT1bz45xWV+s61mwNrOZi3F1GDIjSwgIlA+ovsXx4UUKkTZGRtgQVuyiatISXjHQq+Bd2S3QtMAiTlZgi8gfjSK2knoA2QOntww/DiR1FXrWk7wKS8Kc3N+RO8UTaowQYFLsXoAgRXnSnoX+J+pQuMk+dOAMzZo9pcTrKuXsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=VR9ZkR/t; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFEsC8pdLHrqgm1R6uMYK9SmKFFJArc3WZMs1JbRrx4=;
  b=VR9ZkR/tb+iYAA9REZgVRsraxFHkhZ11fgfCacvLyn02NmHJfc87gyLD
   Ojt+FUosbkgoSE2C1JMAQN7vG2gd5dwBE+hs3r4NSMfW9A2ghm9xVo/Oy
   EOcbUxpNmR1GmMsTZzlJnUFmbdZ+8sCYfx7nFLbM81IfNLvBurUvDfYLL
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696899"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:48 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: kernel-janitors@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 04/14] xfrm6_tunnel: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:16 +0200
Message-Id: <20240609082726.32742-5-Julia.Lawall@inria.fr>
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
 net/ipv6/xfrm6_tunnel.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index bf140ef781c1..c3c893ddb6ee 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -178,12 +178,6 @@ __be32 xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
 }
 EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
 
-static void x6spi_destroy_rcu(struct rcu_head *head)
-{
-	kmem_cache_free(xfrm6_tunnel_spi_kmem,
-			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
-}
-
 static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
 {
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
@@ -200,7 +194,7 @@ static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
 			if (refcount_dec_and_test(&x6spi->refcnt)) {
 				hlist_del_rcu(&x6spi->list_byaddr);
 				hlist_del_rcu(&x6spi->list_byspi);
-				call_rcu(&x6spi->rcu_head, x6spi_destroy_rcu);
+				kfree_rcu(x6spi, rcu_head);
 				break;
 			}
 		}


