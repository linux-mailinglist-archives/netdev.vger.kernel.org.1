Return-Path: <netdev+bounces-134977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7499BB79
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67645280DD5
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A315B0EC;
	Sun, 13 Oct 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="eT+56RwI"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1C155C83;
	Sun, 13 Oct 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850696; cv=none; b=EH2SdbsfIOKbNb2DfQ6VzZxwTsySOZ2k78D21hfi/XVwRJyernpBb6gN1T5ND0UyfLdv+P3SMxXKmHr3PRREn9L3vcq7CxXVUcPRqk48as/PgpVnx1KJjuZ0ci6zYuXFxsjAF+kt/1gKw7Qb8nBVpMDqWWdWqNcbrrQ2yRlP2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850696; c=relaxed/simple;
	bh=o0N3G9ENhIknJWVvvONf6hvcyY1p7SFx5FdS9eQeuxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMbYD1N1EE0KU6KLJM2zmgcGp5dlXa3BF7mjxx6fDDIgbdA8kg/wL7xrTDXVLlPsukXDiFLjbz3mM4sOGz/juml16BEoawVqW5PWZzoOai3u2Luq648o11ZgXygHeQZNcQQkunGlGSoXQht9cNAeKNgrfPk8t9trPQQ1+HVqW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=eT+56RwI; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CsmPga33U/wzuS+05NRR4Fye8SxmqJNxPr+e/ktLXFM=;
  b=eT+56RwIamMj0u2oquwnJ6TxMvMZp4O6tN8ThLBCWgvwy9Gb+OEUZqCu
   592WbwjoWkEw57RcFq7A9rFFj4TT1V/3hf2TF7vv4i0/WkuOlQuzTkxcB
   eglj5z2MdXgKhSkCZv9b2rF2v828SCD2GtmshvCLJc0D7JwJ3C03LZwhC
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968280"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:59 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] xfrm6_tunnel: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:52 +0200
Message-Id: <20241013201704.49576-6-Julia.Lawall@inria.fr>
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


