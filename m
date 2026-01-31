Return-Path: <netdev+bounces-255355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGBxLXGPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:13:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51065C0B62
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7797A30131E1
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF29133B6DD;
	Sat, 31 Jan 2026 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTBvBNmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E225F7A9
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836176; cv=none; b=bAoT6gSHssNmn4brxuH6kHv+hTMTGVQ57v6YCTwDWIwhzUI0ralJ66OWbtda1N7ehP12+19BRHMtgLi5DpS3mtOikbY7C5AljwZ4RnY4fvsY3M9fXV4uwBQh4QCEsJB8SYvexh5trpkTGSZpJ+EdjC5VXi12k1yuzpEc0rHDcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836176; c=relaxed/simple;
	bh=G1cXaUmEwNFR793lSG48IY6N+pxw3IjCoG/pyG0R0tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUFfhb6rfmVKn35QcM5ubYa24t7RoLk2aCtK9QbA2K0JuyL4Rox8q2r3nMZOYe1Pg3CDtf0dwGWSNILUzk4elMl3wHr2TJ4rNo/KSZ5/NhP9tlxbsG4/G1y63coEm8WXDm2yhM5Cd2fpvfYTav3b00Mg+REmcppR2B/mvPfdqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTBvBNmZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82307c6902eso1355014b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836174; x=1770440974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo3Mx683gVydDY1lXMp+F1vTUx30KCwfwK4ZvZrOy8M=;
        b=VTBvBNmZ0LQf++072nhP/apiVYTUePbFtUJtqmdTUeFrJmxb3s4vYOek1wjIbpJ/JB
         Ni/jD5sd7uyLCpa61Sgwo4iVwVo76DsRe4J0c1JpbO2y8SA5aoKI2epj8D7NplgnAx00
         PqitsfsFO0Egsz7WoFFd7oqLQtReY4f0G3YgduPwY1Gyye8kvGP01cpdnL5Sc+kofYfM
         Zc5OXH31cn6ERx+ODG8huTpg106uV0hdyuvPFYOElHi3/KUiA286r2/H789sJMaz6d1Y
         N0uRjQrO5O1VNDH8oSyrYm6YnrgaO2rXJvcoBY/ue0nHqzfWKdk4t/K/TiRbJSNE7gj0
         LZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836174; x=1770440974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eo3Mx683gVydDY1lXMp+F1vTUx30KCwfwK4ZvZrOy8M=;
        b=Ox1LQObUIFpBXNiOIrKKkteYw1NzSmH7m2ciyYy+qfIeiSCExFtcsDB5JvvUclMMfU
         G7+9IHXyR4IFRYn8E4Ch9HvJvEfqW9HqOI+Vj3FW+6YTbnHKkYPL/bjxpN2IldX4Uywk
         TxusE8bIWOwRJ78y94vvx3ngGIPwlhr0wcs6mELaUfP5Zfm+YZtMDggPBJxbv4Xe2FyX
         DOffq89DhPLLRB1DSKPzxjTkyhh6NEJmZdgdsxDYOmKoxgjtUvD+38pGV42V4y7ykRBd
         qijSStiI6jJmOgOgiBdrs2EVTtzU82XYvtjxobfDsohTrpNQbLnkLeP6xxfAvR1WneVP
         fprQ==
X-Gm-Message-State: AOJu0YwP7pJDOYgnfwoRuUwCs0x7quUODKT3yaqfw9LIfaHm8z/4X3/m
	wKAuEvHMR51zQgCcQ8TAfl7r9Ne5ULZbaNN+qL3uicKKrdKapJViV63U
X-Gm-Gg: AZuq6aLH38+8A4O+T3WdpUKKFSos2TDHrOx61ERo08i7og+L6EnjhibZuppF99dulB0
	M/2RSVBd9U8pLlnNPd6UT0PTGblCuya+K071B+Ga0UqlfTpEWbzlGGdPfEp35a+SI3vlnQ1lbyh
	kJifzkwa3M9O2qFnovP3d8cdTqBRU7PxBLG2sduf3wPLYiqLPeZnA+f1W7NbYuQKOxKwynhA+Df
	DJ4pCvJ4RBkwD1KdSmNyBN1VZx5/gmoiA2KX5KftaJI+Gt9ItKLfD//WG9OXx6fxU43+/TZYfN3
	k4jlm45813QA5oPtPVz9AFkO4Z2eSJUqMrRNHkSxooo7aSrgRw3+/8y7mX33Fp7XtCtMogJNjZb
	AKG4GFs6+bUlFEYVsUOVf2fNUSuav2Dfz2FYQxb+Y5rHndaOWNsfGB4LpUpkQ6+YT15F2/iLp1w
	Ll
X-Received: by 2002:a05:6a21:6f83:b0:38b:e398:9955 with SMTP id adf61e73a8af0-392e019dcdfmr4758378637.74.1769836174459;
        Fri, 30 Jan 2026 21:09:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f32bfsm94863945ad.96.2026.01.30.21.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:34 -0800 (PST)
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
Subject: [PATCH bpf-next v4 11/16] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
Date: Fri, 30 Jan 2026 21:09:14 -0800
Message-ID: <20260131050920.2574084-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255355-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51065C0B62
X-Rspamd-Action: no action

Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}()
properly by switching to bpf_selem_unlink_nofail().

Both functions iterate their own RCU-protected list of selems and call
bpf_selem_unlink_nofail(). In map_free(), to prevent infinite loop when
both map_free() and destroy() fail to remove a selem from b->list
(extremely unlikely), switch to hlist_for_each_entry_rcu(). In destroy(),
also switch to hlist_for_each_entry_rcu() since we no longer iterate
local_storage->list under local_storage->lock. In addition, defer it to
workqueue as sleep may not always be possible in destroy().

Since selem, SDATA(selem)->smap and selem->local_storage may be seen by
map_free() and destroy() at the same time, protect them with RCU. This
means passing reuse_now == false to bpf_selem_free() and
bpf_local_storage_free(). The local storage map is already protected as
bpf_local_storage_map_free() waits for an RCU grace period after
iterating b->list and before freeing itself.

bpf_selem_unlink() now becomes dedicated to helpers and syscalls paths
so reuse_now should always be false. Remove it from the argument and
hardcode it.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 +-
 kernel/bpf/bpf_cgrp_storage.c     |  3 +-
 kernel/bpf/bpf_inode_storage.c    |  3 +-
 kernel/bpf/bpf_local_storage.c    | 96 +++++++++++++++++--------------
 kernel/bpf/bpf_task_storage.c     |  3 +-
 net/core/bpf_sk_storage.c         |  9 ++-
 6 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 4e1ebfb3b9e8..605590a8f98d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -101,6 +101,7 @@ struct bpf_local_storage {
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 selems_size;	/* Total selem size. Protected by "lock" */
 	refcount_t owner_refcnt;
+	struct work_struct work;
 	bool use_kmalloc_nolock;
 };
 
@@ -168,7 +169,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	return SDATA(selem);
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache);
@@ -181,7 +182,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 853183eead2c..0bc3ab19c7b4 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -27,6 +27,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(cgroup->bpf_cgrp_storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock();
@@ -89,7 +90,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 470f4b02c79e..eb607156ba35 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -68,6 +68,7 @@ void bpf_inode_storage_free(struct inode *inode)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(bsb->storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock_migrate();
@@ -110,7 +111,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 54d106ebbfe5..364198959053 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -383,7 +383,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+/*
+ * Unlink an selem from map and local storage with lock held.
+ * This is the common path used by local storages to delete an selem.
+ */
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -417,10 +421,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, reuse_now);
+	bpf_selem_free_list(&selem_free_list, false);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, false);
 
 	return err;
 }
@@ -650,7 +654,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
-	if (!local_storage || hlist_empty(&local_storage->list)) {
+	if (!local_storage) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
@@ -698,17 +702,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (err)
 		return ERR_PTR(err);
 
-	/* Recheck local_storage->list under local_storage->lock */
-	if (unlikely(hlist_empty(&local_storage->list))) {
-		/* A parallel del is happening and local_storage is going
-		 * away.  It has just been checked before, so very
-		 * unlikely.  Return instead of retry to keep things
-		 * simple.
-		 */
-		err = -EAGAIN;
-		goto unlock;
-	}
-
 	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
@@ -811,13 +804,16 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+/*
+ * Deferred looping local_storage->list to workqueue since sleeping may not be
+ * allowed in bpf_local_storage_destroy()
+ */
+static void bpf_local_storage_free_deferred(struct work_struct *work)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_elem *selem;
-	bool free_storage = false;
-	HLIST_HEAD(free_selem_list);
-	struct hlist_node *n;
-	unsigned long flags;
+
+	local_storage = container_of(work, struct bpf_local_storage, work);
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -828,33 +824,44 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_res_spin_lock_irqsave(&local_storage->lock, flags);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		/* If local_storage list has only one element, the
-		 * bpf_selem_unlink_storage_nolock() will return true.
-		 * Otherwise, it will return false. The current loop iteration
-		 * intends to remove all local storage. So the last iteration
-		 * of the loop will set the free_cgroup_storage to true.
-		 */
-		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &free_selem_list);
+	rcu_read_lock();
+restart:
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode) {
+		bpf_selem_unlink_nofail(selem, NULL);
+
+		if (need_resched()) {
+			cond_resched_rcu();
+			goto restart;
+		}
 	}
-	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+	rcu_read_unlock();
 
-	bpf_selem_free_list(&free_selem_list, true);
+	bpf_local_storage_free(local_storage, false);
+}
+
+/*
+ * Destroy local storage when the owner is going away. Caller must clear owner->storage
+ * and uncharge memory if memory charging is used.
+ *
+ * Since smaps associated with selems may already be gone, mem_uncharge() or
+ * owner_storage() cannot be called in this function. Let the owner (i.e., the caller)
+ * do it instead.
+ */
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+{
+	INIT_WORK(&local_storage->work, bpf_local_storage_free_deferred);
 
-	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+	queue_work(system_dfl_wq, &local_storage->work);
 
 	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
 		while (refcount_read(&local_storage->owner_refcnt))
 			cpu_relax();
 		smp_rmb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */
 	}
+
+	local_storage->owner = NULL;
+
+	return sizeof(*local_storage) + local_storage->selems_size;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -948,11 +955,14 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
 		rcu_read_lock();
 		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(
-				rcu_dereference_raw(hlist_first_rcu(&b->list)),
-				struct bpf_local_storage_elem, map_node))) {
-			bpf_selem_unlink(selem, true);
-			cond_resched_rcu();
+restart:
+		hlist_for_each_entry_rcu(selem, &b->list, map_node) {
+			bpf_selem_unlink_nofail(selem, b);
+
+			if (need_resched()) {
+				cond_resched_rcu();
+				goto restart;
+			}
 		}
 		rcu_read_unlock();
 	}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4d53aebe6784..ea7ea80d85e7 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -53,6 +53,7 @@ void bpf_task_storage_free(struct task_struct *task)
 	if (!local_storage)
 		goto out;
 
+	RCU_INIT_POINTER(task->bpf_storage, NULL);
 	bpf_local_storage_destroy(local_storage);
 out:
 	rcu_read_unlock();
@@ -134,7 +135,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 7ec8a74e7ce5..abb0e8713a04 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,20 +40,25 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata), false);
+	return bpf_selem_unlink(SELEM(sdata));
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
+	u32 uncharge;
 
 	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		goto out;
 
-	bpf_local_storage_destroy(sk_storage);
+	RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+
+	uncharge = bpf_local_storage_destroy(sk_storage);
+	if (uncharge)
+		atomic_sub(uncharge, &sk->sk_omem_alloc);
 out:
 	rcu_read_unlock_migrate();
 }
-- 
2.47.3


