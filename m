Return-Path: <netdev+bounces-256998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHGxAPtAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE4EF3ED
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1FD330137BF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85FF359F8F;
	Thu,  5 Feb 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLbUY+IE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5335CB73
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274940; cv=none; b=lZfs9tZKC6LVqisJLDgA0sHe+5kvrcm0xoVUR8wHhNa3KkFxl0F2COXaQkeyMd6r29x5g0f1dEJhk5ZoGEsBobihFlZJ9KwRp1k3UeoG5z6hAIoyxpaY5eWxkTb+UtyYJOeP2e6qlzIcrIbIpGAyGxKPlYJBiKuyn1pqAKrKVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274940; c=relaxed/simple;
	bh=8up+wZy9RrzSdoWwRf0FZK/yhU97o7sUFXZ6sCudOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pauf/ashLYcxUH/Ww2850onKTqtFTmtqqZ1Z4f5/W1LXdJRYSFPCryrn8VEQCDBZ5CpKfo87Gth8WcFp5Chwge+6odWkAniDW2SlWu8DGra6uCq2R7K2X2w+De4tbn39fG78XbK3kHNeS5Fy8NbjuhKisujdWJ5ZXsMtI3LeJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLbUY+IE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso919478a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274940; x=1770879740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvzLeA7TbKOCQYjLRl0umDrTwnucL4WTJeEfH0WWcV4=;
        b=TLbUY+IE71VTAaUEIsccsXGwPJBuXc9fFSrgOCEyScqIioBOUXIgpZtVuwZ5lvsLs9
         IlwY0RWJ8H8odot9tCi4gUcBG3mks85PmoexBwh/Xn5mCyHDONUOqYg1vl3PEPGVH3lC
         aLjKYzaWBwakdjwDGMfBcC0maf4ogHiCCmGNjjpWBfvBz5bJV9nrs0cOqHeSw4RdpWof
         VjPi1WC5Uqt0gM/CR8bBoh9evMrr7TgT9GQJhYnVGRhhXjSAboDPyXVP1+9HYwt1fj4r
         REmPkKWnYft3D1K69diOsleFV3ffsP7PyKqGKELVX+omSdu0/cZm/e1Y2DZ+Jx1WkMAr
         nlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274940; x=1770879740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvzLeA7TbKOCQYjLRl0umDrTwnucL4WTJeEfH0WWcV4=;
        b=k53c4tDLLTNcIcsiVEhCOa6e99Ausj22HxXFtdlXYkCc5fPkzXjEWbsPIy3XuWnp1D
         YFywWBpgYtSMmezsjq37S40oDBF6kalWO+hgIp+4PImVEl9/6Dt78XJpQxFvT5Eqj8Vs
         x0Ckrvz1826b3eQuhshiFYf7yJqiG3kiEuzPyOPa84amJWUMSFGLUPJHOlOHZr+8VBcv
         y9hGCKF42m0ROWLw2tPE/lGRp1BNybZteH/Z4rA1KNTr9zxLaEqxKHz6/lbjG9IVn8Kx
         ITi3BPjkEIqX55kCQRK46Vtzt4CguSdTRQStCBFHNgcEw9guxvp+M9Whlp9mXXk+3ioV
         uV3g==
X-Gm-Message-State: AOJu0Yzkoj7NbIlGHXdJa40txCDC8hHpb7BteU7mc5sjPpHjPZT+jMSC
	/nthpcDDYcUWSf+sxwYSYE5SKshDpPnrkLTAQP7kk4EYtVeSafIg4ec6HWHwbg==
X-Gm-Gg: AZuq6aLF2w1kB/qUHhdQn9EgHebPfNnXvavMUsPaXETgBzu+03pWWHz1mBquc4xKs5S
	WAPrPw6ckEY04ipcBKUrJxQpsfAN0j8CUImYFM/mcYoIHDsFkckJ8wmJvzHUkCLYbzZ/pYeKQZ5
	Bj61HIsXHDc1oKglk4OT/KugqaaBAkkU5sLaLjoz9zIck0OrcgePVzL/mVk/be1LlthNS1/h+uT
	LLZ3TJV9suF3tb/GViWFC0oWGiF/3l/rSyQhtTPwRB5SvMRINwJpyYy+vqJX4ioQW1vM8yW+Gzg
	svY7nTLRRjdZPLQa5LcmjuXT7G3bL3o96XnTJZn9Lwe5AAOkNYvpTWQIgH0VS+p0Gv+43qzl57q
	3SiCL2gMkNjZ3+OpI3dLLym6iMRL8nusX/FcP1kFM3Jbbty0OEPxEUI1z+D0JRMxDfE3wUsvixz
	u4
X-Received: by 2002:a17:903:1a4e:b0:2a7:5e7a:5e80 with SMTP id d9443c01a7336-2a9411e087bmr18719715ad.26.1770274939853;
        Wed, 04 Feb 2026 23:02:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851050sm43564815ad.5.2026.02.04.23.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:19 -0800 (PST)
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
Subject: [PATCH bpf-next v6 09/17] bpf: Prepare for bpf_selem_unlink_nofail()
Date: Wed,  4 Feb 2026 23:01:58 -0800
Message-ID: <20260205070208.186382-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256998-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25EE4EF3ED
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
 kernel/bpf/bpf_local_storage.c    | 67 ++++++++++++++++---------------
 2 files changed, 37 insertions(+), 35 deletions(-)

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
index 3735f79a7b55..f8cfef31e3b8 100644
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
@@ -266,51 +291,27 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	owner = local_storage->owner;
 
-	/* All uncharging on the owner must be done first.
-	 * The owner may be freed once the last selem is unlinked
-	 * from local_storage.
-	 */
-	mem_uncharge(smap, owner, smap->elem_size);
-
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
@@ -472,10 +473,10 @@ int bpf_local_storage_alloc(void *owner,
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


