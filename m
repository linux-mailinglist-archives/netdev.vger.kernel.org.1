Return-Path: <netdev+bounces-245416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C4CCD0CA
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA1FE302DA63
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4FF2FF66B;
	Thu, 18 Dec 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkFOZNJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFB3043DE
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080600; cv=none; b=T8sQO2rSECK2RK/4wtNFkWbmOMDecIv7zAJTjDg4j+83IoLTA8xdZlAmoBuA6j16qpKgJK185hrLTxy753+ZXb7tZu9+h9BHcCcTskKzIdQfG1g83mjodeZADx6QXvoqUwfH0Z9mmdYhgUWX87jWOBXledqSasIuRkerw0dalEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080600; c=relaxed/simple;
	bh=HcTKnP5hWjj4jfShdEOmvYnslLs1N5GW3FFvZiIsayc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUB5zaZcr7a4wUrEA5rAMR83HT9PgV4O5M1Cd1v8Zqp7naWBtZ5NqAZUh5OdC2f/f+7qQ26rXRmnpGgrBlADD5oaDFsOGgyHNdTxe4obGwB0UolHDPUxsRoDbU1qBpdZVNDE4+7XEgnyRaW+0JnusvdEGd8Cw+TNgnCALmUIW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkFOZNJF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0bae9aca3so12819125ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080596; x=1766685396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14WW0NFODytesHo+RsYhguguzc5sYzCn9e4nD8A3Nvw=;
        b=fkFOZNJFqn1IrFuW0sHwv/Vqrx3HzzUFlPooJWeFLU3eNdPY5k7Y1NbjTyQ2fIniFh
         ylEa/cB+Jz7A/39FRTDVERu/5U/0blPj6Tn5Wsgeo88knnK+ii27TjP0Sw409BCck+58
         1Q1EuJS1JScIokkqCd0otR54LWQ7S6EnUJzZroZLK+glVdwfAJTskGlAIJrxyM8SsOr0
         lDTj5/Au5dwGS4PtWSVDH6pTQxEy+pikZwBb0g4ttuAFZgNcrzJCS+ECiCeTmMFSdcvO
         EjOHng1oLD4N8fkKei61yLeLskXcNyIhFzYV7io/n0SBXgbIYhV6/RiokMmpT0BLpkwP
         LLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080596; x=1766685396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14WW0NFODytesHo+RsYhguguzc5sYzCn9e4nD8A3Nvw=;
        b=ae2olvhMgsrkH7FNcUHyP9aehRkMPpo+DVt/QlGoJO20dsflA73qri437wQuUgx+Fi
         TrSjVqfF5rWq11xYuLx6rrAyCD1IL8xZx5X0NJmZOxuh/1kgFbKmzji8VlBqN07kwysn
         2Qpi7xzReMfZHSK8rBoILP2TXzHd8TerDAi8OM3GPmpmC80lFAbzCOyEB3m3o/fQdnO4
         5gZFdxmevV7d1LdmUVYEC2aM6Q9ShLn1HjEvUg92Vurj2v1ZDR3tmAGjPbuBlfoMAR3H
         HSHIDtlTFrlK152ylz1x3RGLm5K9PpwAhw26DyXKdnxdsaoq3e0IrUVYYKBJuDGEfmgG
         AMYA==
X-Gm-Message-State: AOJu0YxNT+SASyhokJAUB4mUntYZeWZ3blwxDGmEKVbXL2bP0+1s12mp
	Pt3dY6KxNLN1iRx4ZZZ87ZMNFyRgaG44GX5EtDCS+M3VBKcP3CsVyo7f
X-Gm-Gg: AY/fxX5du8JToov845mweQC7wPbC6ihx3YPSnRPDWc+4Dz+2yzK3GiIBEEWH8gYgSFe
	ASo+V1W1oyupd3RAWxevcNjLVd/5/h/5Tk66ralgHs3Tdah//lTdvMAoUWPXknIQ7CHmtImJQdD
	17cIjxTkLteo4//iD9qjYkltNg45KFJ7jnjAduNtniTpEYsA1Za3DQFKysMiQOOb/KdKZG8xHh5
	gpAdg32wsX9iokPsFZhqlG9st0eIVSqIDL5LSJPadERTRKRDAdDLDRioLQ9qubCuaGLzuqb4Ms2
	s7tC+oeBJC4zeNawxbd5SUgcOMId5vcYsyomvmtsF81sIb22RM6K88qkbxzVdLFbBmef3tZieSt
	ATVriZSty9e7qZjYZV8OAaW/NDsOe/XxTyLsRKO/KXOay9UFnz2429T0yvUcTM/yfJq8Mho6gs9
	kLPcqbI0zN9CYvSg==
X-Google-Smtp-Source: AGHT+IFkQX+0t2XM2ihVsa7tkLG4X3GKoa4wWnodKBwPYoBK2PJQWFkbwfbxdnXSEFXVt+ztOght3w==
X-Received: by 2002:a17:90a:d60c:b0:34c:4c6d:ad0f with SMTP id 98e67ed59e1d1-34e921f0e35mr156896a91.37.1766080596437;
        Thu, 18 Dec 2025 09:56:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769c347asm1173942a91.0.2025.12.18.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/16] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Thu, 18 Dec 2025 09:56:15 -0800
Message-ID: <20251218175628.1460321-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock to
from raw_spin_lock to rqspinlock.

Finally, propagate errors from raw_res_spin_lock_irqsave() to syscall
return or BPF helper return.

In bpf_local_storage_destroy(), WARN_ON for now. A later patch will
handle this properly.

For, __bpf_local_storage_map_cache(), instead of handling the error,
skip updating the cache.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 72 ++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a94e12ddd83d..903559e2ca91 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -15,12 +15,13 @@
 #include <linux/types.h>
 #include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
+#include <asm/rqspinlock.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -94,7 +95,7 @@ struct bpf_local_storage {
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fa629a180e9e..1d21ec11c80e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -325,6 +325,7 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
@@ -332,10 +333,13 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -351,10 +355,14 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 	unsigned long flags;
+	int err;
+
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -382,7 +390,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_storage(selem))) {
 		/* Always unlink from map before unlinking from local_storage
 		 * because selem will be freed after successfully unlinked from
@@ -396,7 +407,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, &selem_free_list);
 	}
 out:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
@@ -411,16 +422,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_elem *selem)
 {
 	unsigned long flags;
+	int err;
 
 	/* spinlock is needed to avoid racing with the
 	 * parallel delete.  Otherwise, publishing an already
 	 * deleted sdata to the cache will become a use-after-free
 	 * problem in the next bpf_local_storage_lookup().
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return;
+
 	if (selem_linked_to_storage(selem))
 		rcu_assign_pointer(local_storage->cache[smap->cache_idx], SDATA(selem));
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 }
 
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
@@ -465,14 +480,17 @@ int bpf_local_storage_alloc(void *owner,
 
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
+	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, first_selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		goto uncharge;
+
 	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
@@ -490,11 +508,11 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map_nolock(first_selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -577,7 +595,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -609,10 +629,15 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		old_b = old_b == b ? NULL : old_b;
 	}
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
 
-	if (old_b)
-		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
+	if (old_b) {
+		err = raw_res_spin_lock_irqsave(&old_b->lock, old_b_flags);
+		if (err)
+			goto unlock_b;
+	}
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -629,12 +654,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	}
 
 	if (old_b)
-		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
-
-	raw_spin_unlock_irqrestore(&b->lock, b_flags);
-
+		raw_res_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+unlock_b:
+	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
@@ -719,7 +743,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	WARN_ON(raw_res_spin_lock_irqsave(&local_storage->lock, flags));
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -734,7 +758,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -781,7 +805,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3


