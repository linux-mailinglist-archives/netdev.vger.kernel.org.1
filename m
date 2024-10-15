Return-Path: <netdev+bounces-135448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF099DF86
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A087B21CB0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94211AD418;
	Tue, 15 Oct 2024 07:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED11A0B15
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978343; cv=none; b=ELpzF3Ze08BGr0l+EpaY/VDOnHQE5f1kb2dr1JmNHISWac+e3OBtxyUg/YFhCXOY2QKOcBYbbQJG7xNmd+r+rOnwTJa0GeW22qUb/FFTxL9/glvNXQU1cVC2IRuESgXrzlUld4UI3lsqjv2PAMBrY+dNcLQr83/CRLshQfj3Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978343; c=relaxed/simple;
	bh=aKy2eSD2H8iEe2Cs/9wyx9D0Vx7gXXDva4TPzCHSAuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjrM4p3DQnrt9nubP4jXIWv8gSuvD+F5Ygq16yicq/XlzHiLzPfMTfD4EkDPUpVv8MLGxptN4ZoAZ5mMvhNiI81S1Tr/puMr1LnMcvCJiT2zCAKcget9K0qpvhlOrpFBOPecIsrlL6ouRpToGpv7FMvzjiyw2pTb9weqzeuNHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E13F7FAA33;
	Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/4] batman-adv: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Tue, 15 Oct 2024 09:39:46 +0200
Message-Id: <20241015073946.46613-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073946.46613-1-sw@simonwunderlich.de>
References: <20241015073946.46613-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Lawall <Julia.Lawall@inria.fr>

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 47 ++----------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6815d1262feb..b44c382226a1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -209,20 +209,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 	return tt_global_entry;
 }
 
-/**
- * batadv_tt_local_entry_free_rcu() - free the tt_local_entry
- * @rcu: rcu pointer of the tt_local_entry
- */
-static void batadv_tt_local_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_local_entry *tt_local_entry;
-
-	tt_local_entry = container_of(rcu, struct batadv_tt_local_entry,
-				      common.rcu);
-
-	kmem_cache_free(batadv_tl_cache, tt_local_entry);
-}
-
 /**
  * batadv_tt_local_entry_release() - release tt_local_entry from lists and queue
  *  for free after rcu grace period
@@ -237,7 +223,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 
 	batadv_softif_vlan_put(tt_local_entry->vlan);
 
-	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
@@ -255,20 +241,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
 		 batadv_tt_local_entry_release);
 }
 
-/**
- * batadv_tt_global_entry_free_rcu() - free the tt_global_entry
- * @rcu: rcu pointer of the tt_global_entry
- */
-static void batadv_tt_global_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_global_entry *tt_global_entry;
-
-	tt_global_entry = container_of(rcu, struct batadv_tt_global_entry,
-				       common.rcu);
-
-	kmem_cache_free(batadv_tg_cache, tt_global_entry);
-}
-
 /**
  * batadv_tt_global_entry_release() - release tt_global_entry from lists and
  *  queue for free after rcu grace period
@@ -283,7 +255,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 	batadv_tt_global_del_orig_list(tt_global_entry);
 
-	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
+	kfree_rcu(tt_global_entry, common.rcu);
 }
 
 /**
@@ -408,19 +380,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
 	batadv_tt_global_size_mod(orig_node, vid, -1);
 }
 
-/**
- * batadv_tt_orig_list_entry_free_rcu() - free the orig_entry
- * @rcu: rcu pointer of the orig_entry
- */
-static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
-{
-	struct batadv_tt_orig_list_entry *orig_entry;
-
-	orig_entry = container_of(rcu, struct batadv_tt_orig_list_entry, rcu);
-
-	kmem_cache_free(batadv_tt_orig_cache, orig_entry);
-}
-
 /**
  * batadv_tt_orig_list_entry_release() - release tt orig entry from lists and
  *  queue for free after rcu grace period
@@ -434,7 +393,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 				  refcount);
 
 	batadv_orig_node_put(orig_entry->orig_node);
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	kfree_rcu(orig_entry, rcu);
 }
 
 /**
-- 
2.39.5


