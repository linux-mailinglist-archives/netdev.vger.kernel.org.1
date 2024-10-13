Return-Path: <netdev+bounces-134973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FC99BB67
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41C81C20ADF
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0E153812;
	Sun, 13 Oct 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kXPfAbHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FE14A4D1;
	Sun, 13 Oct 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850691; cv=none; b=cfefXfUzPXSZUdIu1v08fPgjfgh8GzDwJz6A7//49wrpkP30OsJgRFZf5xF0onffE3korKai47fG0lGyO5rtwF2rA6tUal5bemNzZqWiYsV8WG4e65670RsrjZ8NF+K+ho0ufaFYqAFAuz37ovKiKFFg7Zzm8vWxCqovNTJTlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850691; c=relaxed/simple;
	bh=zDeSKBxm2z8O2RbPJ9sII8/fJpOe3if41TWqeXw6hJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rod4FUr0jE9ZUYCc1MwPQgcjiUHNTEExy1daQs6LPGuzerjTEvzL5dCpq7ljsUm9SSlLp9rHIzYa1hxOGpDHbLbQ3wsKjx3iLBk9p0Xydk/LyQhiQSBrfeeZSpHApCj/dbgUbOZnLWbm8kQzUc9kJAO2oGbNdT2lcFXVnOJvHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=kXPfAbHE; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1tYeT9VeCXpALXQ0bc1ciiw3Tk4RkmKTcpa+Vc2tJM=;
  b=kXPfAbHE9s/JEwRLLDQseG0jzQD4031m8cn79HtXCapqYMMDRcR2wMtp
   UgWJV+ZlOr5YNheV5bxu0aRjysYhcA3rxgAnXoresyTL84JnBBwHfKEJx
   nUr3JX5GTSn/YPGfE/XwHfGo+Y2jSUaM12teN+fwkXW+NJExFVBxEkIzS
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968277"
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
Subject: [PATCH 02/17] ipv4: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:49 +0200
Message-Id: <20241013201704.49576-3-Julia.Lawall@inria.fr>
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
 net/ipv4/fib_trie.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 09e31757e96c..161f5526b86c 100644
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


