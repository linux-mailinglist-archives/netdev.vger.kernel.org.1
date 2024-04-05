Return-Path: <netdev+bounces-85118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D989985A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4937B2254B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C715F319;
	Fri,  5 Apr 2024 08:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27415F323
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306759; cv=none; b=FVf+huXdunnUh27IRoxIREnj8ZLIEqD198JpJ/01JMZTaM5lXHy7NEteo9flxML5QMlbxe8ZycJrZfS4tgJ1idCkPccnwdRnFazSw9L9bmBTMgkWnBukNeXqYTjMBNRZggkWQ6HzAcan0L8j5lGhSv/agUnUOuy+I9SA9cnDcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306759; c=relaxed/simple;
	bh=09ykad7wqMAPdkpzRudqhgGkPdqeo7zTl81NpX9eARs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPuSHE5Mgpbj4jnfeueVwrqiJcEpuYlm/SD3i0eKFi/X7jm+Rvs3AgouYC7BhRkHo0zeM6K4yq6A1jl+oarihbALJVya0dHC/EcWluWlfFe4jN2wonMq7mdbEYex1XlBg5vOuWAcWHrPUokPmvZdEHq8wI/wB0IaniqpT91E4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p5de1fdf8.dip0.t-ipconnect.de [93.225.253.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id E7016FA102;
	Fri,  5 Apr 2024 10:45:55 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/3] batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks
Date: Fri,  5 Apr 2024 10:45:48 +0200
Message-Id: <20240405084549.20003-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405084549.20003-1-sw@simonwunderlich.de>
References: <20240405084549.20003-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

Drop 'batadv_tt_local_entry_free_rcu()', 'batadv_tt_global_entry_free_rcu()'
and 'batadv_tt_orig_list_entry_free_rcu()' in favor of 'kfree_rcu()' in
'batadv_tt_local_entry_release()', 'batadv_tt_global_entry_release()' and
'batadv_tt_orig_list_entry_release()', respectively.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 47 ++----------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b95c36765d04..0555cb611489 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -208,20 +208,6 @@ batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
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
@@ -236,7 +222,7 @@ static void batadv_tt_local_entry_release(struct kref *ref)
 
 	batadv_softif_vlan_put(tt_local_entry->vlan);
 
-	call_rcu(&tt_local_entry->common.rcu, batadv_tt_local_entry_free_rcu);
+	kfree_rcu(tt_local_entry, common.rcu);
 }
 
 /**
@@ -254,20 +240,6 @@ batadv_tt_local_entry_put(struct batadv_tt_local_entry *tt_local_entry)
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
@@ -282,7 +254,7 @@ void batadv_tt_global_entry_release(struct kref *ref)
 
 	batadv_tt_global_del_orig_list(tt_global_entry);
 
-	call_rcu(&tt_global_entry->common.rcu, batadv_tt_global_entry_free_rcu);
+	kfree_rcu(tt_global_entry, common.rcu);
 }
 
 /**
@@ -407,19 +379,6 @@ static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
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
@@ -433,7 +392,7 @@ static void batadv_tt_orig_list_entry_release(struct kref *ref)
 				  refcount);
 
 	batadv_orig_node_put(orig_entry->orig_node);
-	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
+	kfree_rcu(orig_entry, rcu);
 }
 
 /**
-- 
2.39.2


