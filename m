Return-Path: <netdev+bounces-257337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJAnGJEahWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:32:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5315F81CA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0635B305CDCE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED533890A;
	Thu,  5 Feb 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFvjQoxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C213382F1
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330568; cv=none; b=lRom3UL2WJ9jfCdtVTrPOlLxmMQXCkT0cr/7uXr6z/iC9UGimbXXLdIzKo5PBxAop8ig7F37Hyy6dmpw3HrgnY9p6oQT5X2XOyzifdocOP+NPKjvbxEl3iWDpohxItgy/nGB9NihObgKL8ZyOWUDo441/QEwaggqL3FVK/K14zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330568; c=relaxed/simple;
	bh=7yR9+YHp1RkNT1a7BlXW5HCa9dPz59Ra9Z4hFpWq00E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5bXlB5+J7VHMaub2LTuqSIg1AS/qncdM2YwwRSVPIYtS7TcE6hZ3fmzWg1YxvoGyNtbqpVfZJpIdy/59wmJG9HDN4Q6nzJbDyeMUd4VdtRa1pLpIsdUI0QK7LXsrYHY8Dw0COaQ2Id1PfTrOKw2qhzzdUJwqhzphiAMoT0qp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFvjQoxu; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so109378b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330568; x=1770935368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTz6jdn9HQWwkM1E/PJ2ctwZr1RsErnR1/qAIfEoEwg=;
        b=KFvjQoxuHRo7Y0vV240Y3/QHHJ72M7g9eHfzQ+l2SOs7SSiOySVGcHJ8zDwQQvmyFY
         c3NTbmFTk81ntj0u5VIEziNdHP40heT7N7eXLEl//vm0BRFH9tZ/MMBng2nuQoE/41/F
         Yn/Rr6i9Lg9BJ/UBslAZbK+j4Zcoq3NTUI7gimqJ4DuB066c00WXAy9BFUd5WcLPS1Hh
         TJRMI8K6JiIhRw/n6ppSOOhwKrwnmoSI9dO1SZu+p0WO03gj8mv6t8902jL+MYJfMPoe
         o8Ex9KgZRF58g6PWZsvOAn4zIsno/hEGT6ioc2+Q7O+GWsJhHxx1gb3Jzs4LV1r/EaYh
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330568; x=1770935368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JTz6jdn9HQWwkM1E/PJ2ctwZr1RsErnR1/qAIfEoEwg=;
        b=GFYwnA3jjqbXllksUin6agjpu0rQkF7ix2BU6e+AH9AymVw4o/WmCccUzoDLXYVTbp
         FZCpxZKX1KhKtrkZNNsWOf3rkncbHMNW0435KOvH6loWXJJH6JJSp8pFWnDa7MnVokaj
         QRo7ntmQorBQ06kLIVTi8rK7/iYCno+BPvvLTvRfihLaiOfvkdzOpP62UKACjcq2lG84
         NKwNqly7B+Tm0TGtJNcX/19e6pGL/DwyVkhiwyyAlhQQeA8dI3p4o+Hjv1JAEdOqCN7h
         t3NIJZa8Kt2hKyMC9xjQxAub0jKyxaFAejCpXaEz2Tljyx6yPzRTDA+qKxPcIpm2n2Xa
         sbfg==
X-Gm-Message-State: AOJu0YwLZyg7JEJ4Z2yeEEqSMBNdwJyfZMMgIrDDMvtMkoRgHjInzjel
	MKmaDKO+YQq+efLdDCOAi6GxNJXILb1fikKqljgYMv6zqrz/5Qr2LF1x
X-Gm-Gg: AZuq6aLfsL09F25IcQxrvam/XeafrzwXWsaoBOBmiFARjxFTzzEpo29tuw3z2tU49cf
	AFtRo7Dben5ITCfsKCf1Fnp9xnt1g76NVzIzy3czL7x0LEzM6c6EVMqgp8+dVCw5wIu3/ifEz6/
	RhGwByVPgHCCgc3h7rI6xV1QCzgYejmAOliyL5KrWotahAhR43EkBc7VIv6905WykMMD5TYhWHI
	yjzaz8ZQYx1piryYqpwhiFZDh2sSw3VfCcZru3bwUGbq/cNS9fvP3U5Ao7w2Cauf0fwgxsUxb/f
	D9iImDzA//N6lBEZ0Ibqg74ZLpa52lRe+q0vFTmHuIhE2czAV2NqwjfctJOECfzzSXhkccavFb6
	uRqCOyncAI3Gy6fGF8IjbyR3ifG8W/bCIuaAb/MS1QMx6+xC+a3f+9lIfEYqpQU/YRcEubO8/QF
	vPZQ==
X-Received: by 2002:a05:6a00:a22a:b0:81f:b3d1:2d17 with SMTP id d2e1a72fcca58-824416f79d4mr495219b3a.35.1770330567959;
        Thu, 05 Feb 2026 14:29:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418812d2sm314869b3a.43.2026.02.05.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:27 -0800 (PST)
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
Subject: [PATCH bpf-next v7 09/17] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Thu,  5 Feb 2026 14:29:07 -0800
Message-ID: <20260205222916.1788211-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257337-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B5315F81CA
X-Rspamd-Action: no action

The next patch will introduce bpf_selem_unlink_nofail() to handle
rqspinlock errors. bpf_selem_unlink_nofail() will allow an selem to be
partially unlinked from map or local storage. Save memory allocation
method in selem so that later an selem can be correctly freed even when
SDATA(selem)->smap is init to NULL.

In addition, keep track of memory charge to the owner in local storage
so that later bpf_selem_unlink_nofail() can return the correct memory
charge to the owner. Updating local_storage->mem_charge is protected by
local_storage->lock.

Finally, extract miscellaneous tasks performed when unlinking an selem
from local_storage into bpf_selem_unlink_storage_nolock_misc(). It will
be reused by bpf_selem_unlink_nofail().

This patch also takes the chance to remove local_storage->smap, which
is no longer used since commit f484f4a3e058 ("bpf: Replace bpf memory
allocator with kmalloc_nolock() in local storage").

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 69 +++++++++++++++----------------
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fba3354988d3..a34ed7fa81d8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,7 +80,8 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
-	/* 8 bytes hole */
+	bool use_kmalloc_nolock;
+	/* 7 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -89,13 +90,13 @@ struct bpf_local_storage_elem {
 
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
-	struct bpf_local_storage_map __rcu *smap;
 	struct hlist_head list; /* List of bpf_local_storage_elem */
 	void *owner;		/* The object that owns the above "list" of
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
+	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 76e812a40380..0e9ae41a9759 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -214,7 +215,7 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->use_kmalloc_nolock) {
+	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
@@ -251,6 +252,30 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 		bpf_selem_free(selem, reuse_now);
 }
 
+static void bpf_selem_unlink_storage_nolock_misc(struct bpf_local_storage_elem *selem,
+						 struct bpf_local_storage_map *smap,
+						 struct bpf_local_storage *local_storage,
+						 bool free_local_storage)
+{
+	void *owner = local_storage->owner;
+	u32 uncharge = smap->elem_size;
+
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
+	    SDATA(selem))
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
+
+	uncharge += free_local_storage ? sizeof(*local_storage) : 0;
+	mem_uncharge(smap, local_storage->owner, uncharge);
+	local_storage->mem_charge -= uncharge;
+
+	if (free_local_storage) {
+		local_storage->owner = NULL;
+
+		/* After this RCU_INIT, owner may be freed and cannot be used */
+		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
+	}
+}
+
 /* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
@@ -261,56 +286,30 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	void *owner;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	owner = local_storage->owner;
-
-	/* All uncharging on the owner must be done first.
-	 * The owner may be freed once the last selem is unlinked
-	 * from local_storage.
-	 */
-	mem_uncharge(smap, owner, smap->elem_size);
 
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
-	if (free_local_storage) {
-		mem_uncharge(smap, owner, sizeof(struct bpf_local_storage));
-		local_storage->owner = NULL;
 
-		/* After this RCU_INIT, owner may be freed and cannot be used */
-		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
+	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
+					     free_local_storage);
 
-		/* local_storage is not freed now.  local_storage->lock is
-		 * still held and raw_spin_unlock_bh(&local_storage->lock)
-		 * will be done by the caller.
-		 *
-		 * Although the unlock will be done under
-		 * rcu_read_lock(),  it is more intuitive to
-		 * read if the freeing of the storage is done
-		 * after the raw_spin_unlock_bh(&local_storage->lock).
-		 *
-		 * Hence, a "bool free_local_storage" is returned
-		 * to the caller which then calls then frees the storage after
-		 * all the RCU grace periods have expired.
-		 */
-	}
 	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
-	    SDATA(selem))
-		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	hlist_add_head(&selem->free_node, free_selem_list);
 
-	if (rcu_access_pointer(local_storage->smap) == smap)
-		RCU_INIT_POINTER(local_storage->smap, NULL);
-
 	return free_local_storage;
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+	local_storage->mem_charge += smap->elem_size;
+
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
@@ -471,10 +470,10 @@ int bpf_local_storage_alloc(void *owner,
 		goto uncharge;
 	}
 
-	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
+	storage->mem_charge = sizeof(*storage);
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-- 
2.47.3


