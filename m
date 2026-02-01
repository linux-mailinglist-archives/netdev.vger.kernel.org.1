Return-Path: <netdev+bounces-255657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCUxKjCTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:53:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5059FC6D26
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38BF93034B2F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78A280A51;
	Sun,  1 Feb 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JluWyEN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB784283FCF
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968267; cv=none; b=K3mn+rTgOf3iy6ggv/mnqlAu9e23iQm1EuySbJ7c4BmUxGjgX3GoK+F2RCKJy+m5YOW7Pi8VDXvPF7AEKy/fKGRzzwEZRNLTfesSwxZuD2K1zFzPL3Ll3icNRaLaRp1P//zxIrRQytZSj0l9W1y1q2KrECopIzg8P5SaNDjuMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968267; c=relaxed/simple;
	bh=j9okROgC3d3IWDzv7hV5iNjpBOxFqifQ//DYr9QTOPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzOvLprVMWPkayYZfbvqpduzj4y+jnxIAa/Zjd+yvRRIIwm7ulYi85ZNk0sZUvZ9zd9Sbq2sMwrOOIrhtCh0Edtz4fAnbv7P8Wt/nAhYNFwoOaBhKkvaoHB/GmAHI5SQQqXPuSfvAN5+hdH0cN3sAu+5QxebT/S43x5h8E4UCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JluWyEN1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c47ee987401so1585600a12.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968265; x=1770573065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm7oC+xgIKCvXxrSGiuTDF0Hzayvzv2tP2HFWM+MKaM=;
        b=JluWyEN1OEoU5vHI2PEFxuTHIAdJr0gwK0Whuc+aBMiu8KW01mQXIi+4BvpiZx06SS
         +jgfRFMvaPmh0mB9mMaMZK17DPAfEgXbKz66q0a7Aq6g89oK0Dq2ueP58WkCvwwQkmOP
         LiL+kwGKXWgU2Jc0B8zX+DeiwAeDNVRTHBPVY8toMbHmnPcA1J9UllhgjFXi/jUOc+/m
         +3LIGnXOrnSTOAi42la9P70G/0K885Z1uptBV91dxiczAFuvoA2qxJaGUHvv7+Og+uTv
         LPHandBqu0boMgcL7wOWH0T/JM/PIyA5ruT3iIwhmKuZpVVaatPdjNiTg/lAcqIW5h8F
         q9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968265; x=1770573065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xm7oC+xgIKCvXxrSGiuTDF0Hzayvzv2tP2HFWM+MKaM=;
        b=p7aAIdGx7DTWjhpCoKmMu9vw5l0QTpx0lgQVGNBHuFziQFlsCo3J3I4qEpQBXCjZi6
         buT4gpEG2CKW3i+r3TktizMBhjeTKhb2Z5sh3BzVJqVIWFek9PPEH4tKifH4IWN0k/Xp
         ArDYISRCxgcM4kPd96NvOBLXeeU4Gs+gAKqVVN+XPWer6lCcG8poMOtte6p+v1sGp24y
         T+N2RdV0KU1sa+uLD+G/ChAzjOaz4Izb5vqNGx5+G+2yziIMSjIWFkS0CUAZATgFBPwA
         YuaKcxpvi25qwYK7CsI83Q0AyU7hCjUNYrNnWp02V13LJdNyCcfzSZrGg2zp0lakBAc+
         JUdA==
X-Gm-Message-State: AOJu0Yze/mCnbBfPM+PAt6I9eHL8KhHaKf2tPjboq/ybIz+CpiHFWu9f
	yjDFi16PM4U8BSg02PSlA7Dkuf7sRkpZaoI/w2UjZoGT9FYlzQShGfN4
X-Gm-Gg: AZuq6aKDSCZOSgF5knyt5K8jm7H8Cl81cU2lJsWVID/jLSiMFNCqlqNfj4qy3nzQc23
	tZmRjk7gseKIGAV35Bfr6XiUspkcH+rEVmA/v96QZjX0k2tnkLtYKMsIzifyW1j6V7i3I9k0tmq
	l3TdqSF0hhJr8r9N+pSfG7pIgODTLesqFduqGFG9hX+wOelDu/Ac50lSrGMATwtC1xS4lWmVaJ5
	usjAlh2m/E7HZP3QVexhAFpcz/ad9SpHNqb28Ok3dEYbf6OuYO64+tJc7AgRkW9C1J9D8MnGJEX
	+OOl9ZZwBx9kYwoDGzl8up/SGi0cWPlRDgGzAPG0e4JSFc74EBUkBzm0S1jmg8yxUC/vA2+bjRj
	V7pP/yrUj1BE00lbpsFa6vq1cwPJ7D4rX84GQJe4a3qvky5iDjoKdRWiT2XEoQnfnBBKmB7390F
	R3Cw==
X-Received: by 2002:a05:6a21:e92:b0:351:cf08:93de with SMTP id adf61e73a8af0-392cc6fa8e3mr11302255637.26.1769968265000;
        Sun, 01 Feb 2026 09:51:05 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a42b3fcsm12739227a12.20.2026.02.01.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:04 -0800 (PST)
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
Subject: [PATCH bpf-next v5 11/16] bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}
Date: Sun,  1 Feb 2026 09:50:44 -0800
Message-ID: <20260201175050.468601-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255657-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5059FC6D26
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
index cfa301ccc700..0d04f6babb2e 100644
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
 		       struct bpf_local_storage *local_storage,
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
index 1846067e6e7e..d02ad9052bd6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -381,7 +381,11 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
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
@@ -415,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, reuse_now);
+	bpf_selem_free_list(&selem_free_list, false);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, false);
 
 	return err;
 }
@@ -648,7 +652,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
-	if (!local_storage || hlist_empty(&local_storage->list)) {
+	if (!local_storage) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
@@ -696,17 +700,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (err)
 		goto free_selem;
 
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
@@ -810,13 +803,16 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
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
@@ -827,33 +823,44 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
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
 		smp_mb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */
 	}
+
+	local_storage->owner = NULL;
+
+	return sizeof(*local_storage) + local_storage->selems_size;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -947,11 +954,14 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
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
index d2164165a994..a8d277f9604f 100644
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


