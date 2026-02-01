Return-Path: <netdev+bounces-255659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oONdN1CTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:54:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BBC6D3A
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C78B303A915
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2328688D;
	Sun,  1 Feb 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axdFoIsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002626B955
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968268; cv=none; b=M4wi2j+E1qrgPWv8mvy3oz+9EKEiwBG/4BuYPwWfFPumLvF1jabIErh5S1F/6ZsZmri+5AFTPSKdQm2OYWB7/ShIV0A9sjL8G6H+8FtTXuUuBq4OMFFUuTVFaAuXT3ZJLa3pQZ3uKg7yq44uoZ8ReqMyMK9Htln3paTwdKTFyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968268; c=relaxed/simple;
	bh=nnc6qXNk1kzZ7tys4d3o/g7p4Joi3Z06yqJgP7SPs/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dE0p2b+B/7GLVahpXOV+PHHdOjT35BZJQdCJ++sHu1IXPtTPGZAHEB9fbefyC9gBHzGCrdiBj8fTWjwac0vWDya8wJqZYSgr2Ja2FRs+R0tVrDZQ5whcCbKisxDPz5GDRvt4t/Sgf5RosQORFCXR+G82ZdP+TpWcYd6u+nTaK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axdFoIsQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1434041a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968264; x=1770573064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljxz2twLhahx/0C/tMy2+HBBhtcU72SHzexLBiTytAQ=;
        b=axdFoIsQNtdcbJkFXeqRB/UW8+U4PFhAVyh9+KdHudbMr7YQH/TlGA2sUvKzmDfUTs
         GFMXcT0H6j3O3CV7ar3DA5LE2RkfmIr0VUImB94uTzqY9uuElHsISQ85Ne+TNTNwtpsT
         5ax+NfwUpLp1a3uB/LzTrkZ6kKdFsYLnEh/V7EOObgxk9KrSNOCEWSHzb8Kx/dsfPuXi
         EHFIwQk8nlls2a3m1FYDbhlL2npkX1DTgYkWVomNUynFAW2Ca6BDfQRqxCeZyX2yO3tn
         124SRJinvfycgA4mzYn0qZhI7ETRpHnwRCjrR0eTfJ5iQYmCSvs2RBWaM7T9JFNET/SJ
         wjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968264; x=1770573064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ljxz2twLhahx/0C/tMy2+HBBhtcU72SHzexLBiTytAQ=;
        b=jp47Ko50aFoAyiDTAypV6uUQq93VSEuKGuwhCj+q4f6q+xmqTqoYO1BmCuh9yhke7b
         rzKyrYCNMk6nJLeIqUHOcE1533mEUZ/Wz6Vv3MWQXIqOAg+wvwtgRwAszKst5XOZ/Gn9
         U9Frn6GBdtLwW9UiTWCQcOgpft2r/07ykY0lOxTXfjryM0IR1RdJApx5eAvhU3JWpA3M
         SPrKXhs1BeuK9WQeQ8mPwGUdCAHnnSJjDtXV6IvsZXhC7gTOrbdQA8U/2vxpjVmRxS6V
         xtalAgy+MvUWX7pP6NzEna85pWZf/wX3NOLMh2+s1WqhXAwu+99N9zUck9v2ZuSA8x6r
         FSXQ==
X-Gm-Message-State: AOJu0YwiABGxcnkOOD692wDpNZqHTculmjDqIScTWi5GXHlrncGxbFEF
	WgOlwUTjrTVPhT2lNoMwvAOMH4fEM/rVxlDOiDqViE0/M4venH10xlg0
X-Gm-Gg: AZuq6aIlEvvVWRVtljF7Px/ZTBqJNnF5ZCF4zKRqITroQC3E6hHOkrupRWgrZ8UOL9w
	2YLGo7YFkCw5kfru9VpbmGioNmz+BIN/CYfaeIwlzn6MPwiiVx1VsVfDS56mvfN/ggBA71CW/zI
	ep+V89zVmRpdCvWNBg0uuhdjeWl64mxtWahXVALOY6GR+rDHYw6xRfBWCJAsd0x7tCMX24DAXBo
	goEYHjdSUjUfPvXWS9W3/MsXAwfN4sAO5bCdAOjJznkQa+6W5hokrmv5HF3b7a6uLetaIWI9ANk
	tHzKtqdP3pfGHI226NVOKLyw8MiJ2E5nPMZ12vyERXjqBi5kN196kqfrdm5NlkbjFIMC+SHz9Pf
	rJsJmvcPcDyNxYBXMFyYi5U5MSwWVgUBjzBru78s3Gif9ru1Vmx3DvI+9nXchBRJNaqjdu38MCY
	QQEA==
X-Received: by 2002:a05:6a21:a98:b0:366:14af:9bca with SMTP id adf61e73a8af0-392e0163b6cmr8701998637.64.1769968263756;
        Sun, 01 Feb 2026 09:51:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642aaecd19sm12704059a12.29.2026.02.01.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:03 -0800 (PST)
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
Subject: [PATCH bpf-next v5 10/16] bpf: Support lockless unlink when freeing map or local storage
Date: Sun,  1 Feb 2026 09:50:43 -0800
Message-ID: <20260201175050.468601-11-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255659-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 349BBC6D3A
X-Rspamd-Action: no action

Introduce bpf_selem_unlink_nofail() to properly handle errors returned
from rqspinlock in bpf_local_storage_map_free() and
bpf_local_storage_destroy() where the operation must succeeds.

The idea of bpf_selem_unlink_nofail() is to allow a selem to be
partially linked and use refcount to determine when and who can free the
selem if any unlink under lock fails. A selem initially is fully linked
to a map and a local storage and therefore selem->link_cnt is set to 2.
Under normal circumstances, bpf_selem_unlink_nofail() will be able to
grab locks and unlink a selem from map and local storage in sequeunce,
just like bpf_selem_unlink(), and then free it after an RCU grace period.
However, if any of the lock attempts fails, it will only clear
SDATA(selem)->smap or selem->local_storage depending on the caller and
decrement link_cnt to signal that the corresponding data structure
holding a reference to the selem is gone. Then, only when both map and
local storage are gone, an selem can be free by the last caller that
turns link_cnt to 0.

To make sure bpf_obj_free_fields() is done only once and when map is
still present, it is called when unlinking an selem from b->list under
b->lock.

To make sure uncharging memory is done only when the owner is still
present in map_free(), block destroy() from returning until there is no
pending map_free().

Later bpf_local_storage_destroy() will return the remaining amount of
memory charge tracked by selems_size to the owner.

Finally, access of selem, SDATA(selem)->smap and selem->local_storage
are racy. Callers will protect these fields with RCU.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   5 +-
 kernel/bpf/bpf_local_storage.c    | 109 ++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 6fb02ffdb8aa..cfa301ccc700 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,8 +80,10 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
+	/* Used by map_free() and destroy() when rqspinlock returns err */
+	atomic_t link_cnt;
 	bool use_kmalloc_nolock;
-	/* 7 bytes hole */
+	/* 3 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -98,6 +100,7 @@ struct bpf_local_storage {
 	struct rcu_head rcu;
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 selems_size;	/* Total selem size. Protected by "lock" */
+	refcount_t owner_refcnt;
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 0b8d7eaa2f92..1846067e6e7e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -93,6 +93,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 			if (swap_uptrs)
 				bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
 		}
+		atomic_set(&selem->link_cnt, 2);
 		return selem;
 	}
 
@@ -194,9 +195,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	/* The bpf_local_storage_map_free will wait for rcu_barrier */
 	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
-	migrate_disable();
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	migrate_enable();
+	if (smap) {
+		migrate_disable();
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		migrate_enable();
+	}
 	kfree_nolock(selem);
 }
 
@@ -221,7 +224,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		 * is only supported in task local storage, where
 		 * smap->use_kmalloc_nolock == true.
 		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
@@ -419,6 +423,96 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	return err;
 }
 
+/*
+ * Unlink an selem from map and local storage with lockless fallback if callers
+ * are racing or rqspinlock returns error. It should only be called by
+ * bpf_local_storage_destroy() or bpf_local_storage_map_free().
+ */
+static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
+				    struct bpf_local_storage_map_bucket *b)
+{
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	bool in_map_free = !!b;
+	unsigned long flags;
+	int err, unlink = 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
+	/*
+	 * Prevent being called twice from the same caller on the same selem.
+	 * map_free() and destroy() each holds a link_cnt on an selem.
+	 */
+	if ((!smap && in_map_free) || (!local_storage && !in_map_free))
+		return;
+
+	if (smap) {
+		b = b ? : select_bucket(smap, local_storage);
+		err = raw_res_spin_lock_irqsave(&b->lock, flags);
+		if (!err) {
+			/*
+			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
+			 * exactly once for an selem. Safe to free special fields immediately
+			 * as no BPF program should be referencing the selem.
+			 */
+			if (likely(selem_linked_to_map(selem))) {
+				hlist_del_init_rcu(&selem->map_node);
+				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&b->lock, flags);
+		}
+		/*
+		 * Highly unlikely scenario: resource leak
+		 *
+		 * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
+		 * and both selem belong to the same bucket, if destroy(selem2) acquired
+		 * b->lock and block for too long, neither map_free(selem1) and
+		 * destroy(selem1) will be able to free the special field associated
+		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
+		 */
+		WARN_ON_ONCE(err && in_map_free);
+		if (!err || in_map_free)
+			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
+	}
+
+	if (local_storage) {
+		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+		if (!err) {
+			/*
+			 * Normally, map_free() can call mem_uncharge() if destroy() is
+			 * not about to return to the owner, which can then go away
+			 * immediately. Otherwise, the charge of the selem will stay
+			 * accounted in local_storage->selems_size and uncharged during
+			 * destroy().
+			 */
+			if (likely(selem_linked_to_storage(selem))) {
+				hlist_del_init_rcu(&selem->snode);
+				if (smap && in_map_free &&
+				    refcount_inc_not_zero(&local_storage->owner_refcnt)) {
+					mem_uncharge(smap, local_storage->owner, smap->elem_size);
+					local_storage->selems_size -= smap->elem_size;
+					refcount_dec(&local_storage->owner_refcnt);
+				}
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+		}
+		if (!err || !in_map_free)
+			RCU_INIT_POINTER(selem->local_storage, NULL);
+	}
+
+	/*
+	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
+	 * then freed after an RCU grace period. However, if destroy() and map_free() are
+	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
+	 * the selem only after both map_free() and destroy() drop their link_cnt.
+	 */
+	if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
+		bpf_selem_free(selem, false);
+}
+
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem)
@@ -485,6 +579,7 @@ int bpf_local_storage_alloc(void *owner,
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
+	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
@@ -753,6 +848,12 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, true);
+
+	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
+		while (refcount_read(&local_storage->owner_refcnt))
+			cpu_relax();
+		smp_mb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */
+	}
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.47.3


