Return-Path: <netdev+bounces-79520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A065879B4E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E6D2859FD
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898B139571;
	Tue, 12 Mar 2024 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="blukgp81"
X-Original-To: netdev@vger.kernel.org
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF7273FC
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267867; cv=none; b=ebjHLoMYiS9Eu/iLPFbmB1wFHP7N7ykP3AUQgqOcQ1pgJDDZExWPXvT5erZM1cw2Xh3EkyUVX4buhkO3+NkvsO1S3gYRuJwD7eFi/h+yOUlRqGA8lkOCb3fEyhLCm6mUfTEKDzHBQW0cZZTCv4ZhnO8vaTzB221oAubxVRIAwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267867; c=relaxed/simple;
	bh=noKRIZa3z8ahG781JAMkOlhIyOyQ4CABCp76eFR5XDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tak2RfRBl+kmFas4BCSHiAYrwQGS8IHv12O8GqStXl1tBCWH2M602dlOKMB0uRL7nO/JqjLRs7Jr394rbpz4823lVl/Qol2TUOmAGJmE44Fi6o0zdTmLpasDZruC/SDQrIQZSx8K4pPcXhAf3bofgn04ZTlbZ6AUzt0w7aKsmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=blukgp81; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 9B79665255
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 21:18:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 45AFD608F2;
	Tue, 12 Mar 2024 21:18:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GIrKTj0ZpGk0-rcqrrxig;
	Tue, 12 Mar 2024 21:18:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710267497; bh=o/jEyIn0N1qjBhCbDmOuWB1YSE6SbgxzJw3WAakd7MI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=blukgp81coHZyPihJK8DJqeo+lDXjwExPsAJgZVcsvswHmF42KT9ZlMpZ1rE4Wg/5
	 lNqgdiOcwhVQkDGWR4AGIRIWwvB2w6RxC3FTNZT9jg0jObQFGR4gimARlwz/c6oWig
	 2PqFq2ygGitxF133F64HYtUQt69tMs9lzszovlcQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
	Jakub Kicinski <kuba@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks
Date: Tue, 12 Mar 2024 21:16:28 +0300
Message-ID: <20240312181628.2013091-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop 'batadv_tt_local_entry_free_rcu()', 'batadv_tt_global_entry_free_rcu()'
and 'batadv_tt_orig_list_entry_free_rcu()' in favor of 'kfree_rcu()' in
'batadv_tt_local_entry_release()', 'batadv_tt_global_entry_release()' and
'batadv_tt_orig_list_entry_release()', respectively.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
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
2.44.0


