Return-Path: <netdev+bounces-134976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85299BB76
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6471C20E22
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21215749A;
	Sun, 13 Oct 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="h8O5zAoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EC154C0D;
	Sun, 13 Oct 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850695; cv=none; b=PgVZAlcjUv6Ahe9ZhESj0zD7r6zn/s+Y60zZPrJn2ZELeUYrgdt+KhN1wg9pmPvbGu9SWp7/8Z7SJYM4fyoUp7tMEMoHGzW+rDwbkOQVbe0P4Tnp+XBgrGfFi7KT21DxTYZNfY86e2IEEuCSKEd+YchxPQOtIfCLoN1UdsYG5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850695; c=relaxed/simple;
	bh=yW708ymNXET2POwetW52X/q9M+jWgYaprMUFc1XH+KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpVwx9D5uszEMr5G3R3UIWhWBClIFGpuIFBTMw5J2yZHyK5I2+aoICj4GFPFVXmRAc240RJuaOsAyYmteQTj2bKIbFPMfWs20koGVCs0kIEdFfX5YmDJzRVCg5A49C7djauvsM1sxKPXWnPKdFpy00gaIXfwn8EnHEuoZqfhNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=h8O5zAoY; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEupsITxPV+cd5nWI7EVwYHWMykqTZ1CZVXuXfofYSE=;
  b=h8O5zAoYCF49NE36/OotUYfFdc1sg3QS2yfv+tZU2yY5RoWEaUAhj1VW
   T9jrFQapLlobnkHjTrxvAaBAjmPsBv5CjTLP74MElCijrmizSHNbdX+wZ
   nBEMCwv0397L1wp2xEJ95MQRKnDc2UiRi+4rMs+TsRaxOu8ItQ88/KOue
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968279"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:59 +0200
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
Subject: [PATCH 04/17] ipv6: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:51 +0200
Message-Id: <20241013201704.49576-5-Julia.Lawall@inria.fr>
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
 net/ipv6/ip6_fib.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..24c57c1a52dd 100644
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
 


