Return-Path: <netdev+bounces-134972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E3F99BB60
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4E1C20C22
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9D13AA5F;
	Sun, 13 Oct 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="FMhEhdep"
X-Original-To: netdev@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06A3E499;
	Sun, 13 Oct 2024 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850688; cv=none; b=FselFT3JHsJ8hvvYJJCuyhckJjC77mS+nLxJdPZALFhJmg+x2k8YQl2YkRKK3k9bKCx0laWoPC7u9vhH4C3Ftpgd/Vyq3YDdpZ4XGDraHALROFmwE1GC7Qa+OzV5NoMa5CfT2jFkMpeNwstaA9566w5gSmGH5hHG7NEjeak/RWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850688; c=relaxed/simple;
	bh=UNde1Ns/wgw684Xp1FDQfaVu7Kt0BWagRFH8YHbgeu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suBIqJEhm3KvJKmJs+cxPf09O0ji2d0ck3cn3AccJY9tmC+MP+zUKh5qvwk6Bgn8nL9GYMHFfHbGCjR00oJGO9/GXCo/gb6RRYbCHaTCSaoExyfCZxJ6r6oJOLdCPV4Qq5T1DVPjHQfmXvoYka3CqyUxGtVK+kYfdxqtdm9x+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=FMhEhdep; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f56yuDs1RrZPsFGiT1se8rmNN2beKZ0tdUTQFaCxX9o=;
  b=FMhEhdepWYT8ih5/hSuqLaee7V7T+XkNGs9UTGtrrNUAmIJeaMSNNdA6
   jkee02w8FZsJgZeHUHjYvPdtRzaIirUNA0GWhFKsVlqDMCzC9jB5YZdrv
   KAouigWnAJYA9EecdQ3cK883AOyYBDj5kT/olPhh87wybJip8LzaUOzK2
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968276"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:58 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] wireguard: allowedips: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:48 +0200
Message-Id: <20241013201704.49576-2-Julia.Lawall@inria.fr>
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
 drivers/net/wireguard/allowedips.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 4b8528206cc8..175b1ca4f66f 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
 	}
 }
 
-static void node_free_rcu(struct rcu_head *rcu)
-{
-	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
-}
-
 static void root_free_rcu(struct rcu_head *rcu)
 {
 	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
@@ -330,13 +325,13 @@ void wg_allowedips_remove_by_peer(struct allowedips *table,
 			child = rcu_dereference_protected(
 					parent->bit[!(node->parent_bit_packed & 1)],
 					lockdep_is_held(lock));
-		call_rcu(&node->rcu, node_free_rcu);
+		kfree_rcu(node, rcu);
 		if (!free_parent)
 			continue;
 		if (child)
 			child->parent_bit_packed = parent->parent_bit_packed;
 		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
-		call_rcu(&parent->rcu, node_free_rcu);
+		kfree_rcu(parent, rcu);
 	}
 }
 


