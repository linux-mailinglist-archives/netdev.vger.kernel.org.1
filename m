Return-Path: <netdev+bounces-255354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgBNVKPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6FC0B4D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181FA30581B7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94531ED88;
	Sat, 31 Jan 2026 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAldh1us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B432937D
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836175; cv=none; b=ax6PSNEigXl90I/cBAs1TkOHUmiZLTXkqrwHgkGtv5pnXx9Rn5QcBK4H98wjvqep2jmz+664u/0nX8vD0/uZITx/0c7LYhguL1vnTMPGilZOvNtb8MylbhM8xsKXRxBQ74IydQUd0p7t8ODvhV7FgPjNyFvsx6Tx1NAN4fRFb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836175; c=relaxed/simple;
	bh=DYsQJwJxTwIiG92pWwyWOyQqI9xs2mj+H6kO95JVCPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnL4lDUJaCtgcuJqUCFIBlqUjfGr/ZmN5s8eV7R3ws6EpZ/9BUZ5GcxGGEsfLCJE2muaYcSmUC41mzJGbE0QL7z8KDA7A/6FLPW1IpzzjRhPHdh7rdTl5G4HZfidxY5hccfAwn++I+wLGRXLlggNP43GnwMZiJvNMF/H37yTgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAldh1us; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871c8b171so16881155ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836173; x=1770440973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2MLcSYw152EfT0lI1nmhmaRVogHx3EwhEnx84Pv+RQ=;
        b=DAldh1usQLkRsZR2oUDzikzUcN1SjDeIVlxlexHIqQ76LPmz+K/JeqqI9QZzKobsG4
         MTVb9+Se9cLLPHAu19XHXkvz/tCKL/eNt4/OxZOwg0gS0XUzAr77LHXhvgLSeWS6dnHF
         I2+aO+8/brjHWJzADYq+nDQppRNqWNWhSqATtxh3PUbqTUDqWXoxUneclHqB39TiGV+D
         g4vrP3QutSO3gf4y+ikrWk8meH+yKPpdZhFJ2BBgGVyXP+RphBOhw0BVjvBDydRneRo7
         MeUmCAtJQWo02fN3kfdwQqHW5+K23hSwqvoZ7Nn5VxIY15bEiWe+M7/zrd2oNrgy8LfA
         YnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836173; x=1770440973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2MLcSYw152EfT0lI1nmhmaRVogHx3EwhEnx84Pv+RQ=;
        b=NBdNZX7W2c9SlZ1ao/3tGctZRl5qcTLDdpg3meeAIeMM9tHA3q0SErD1IpLQjIy05Q
         15fM4Slyddd8WSBmzInYGP821rTSYEzQkfAM2xa2zHvk7w1fm6W5O21rso5YfVoKUs6o
         0sWnurSifkH5FpPDgesiDkVTAMLi3MYxVXkKjjzPN6ylNM719m2/Yy0iCrNodA+SMTV1
         hJB+NV1Thu/netJFoHT+ikoS4fXilQcLNRjN2NkbLeVPsriMv3JjJYU7hwAsmRu57vrZ
         ybKK7czYs5aP8Z80vH7ZQRcHjCDm832G0568UOBsi4Qim6BgFdrRLiMZA1iJQyauGVxy
         I1kQ==
X-Gm-Message-State: AOJu0YwygIP5IZAttqrQSDOdZ8Ys5I8mxglrdsxBNB5ep+ie2Z/NNs0a
	iAT0BEwM2K8Zx5MWCBVTkHLbgCwJpRICmg2PMLOCLH8sB7gDMT0jOPXS
X-Gm-Gg: AZuq6aJFqD2Dfolej6E46RAyYExio0sdL5NbVI2NzAymJ6479oL7rrjNWLApXmwK9JY
	2FuGq0aOAHLO9UU0Nibv9jNCO7xvX1O+qd59TPJjCu6LXKRzN4i5A6oadx4yc3O0PR/DQS3qI2f
	nJMrizKTNWr8IPhQdHB7j15EWRWWvySTpT1ymaHkDINoVC2lRXll9zcBZG+MdO5rOkiLNvwPynp
	voz7vkbXqTSCtHfvUMCn1uyXkybZT66hQStFhwHyOLB11dA4JzJ/Fz8L30fIvA1+dTt3qovNQAT
	J7o1C2UnOo1GbErM/D5NWmW0L63kX/EETSMC6jtyrO7mWUmZCH3gYjirX6EhpmV1nSJyKKclX99
	vYPUjDO0mi3V1NAokrzsN3KHkKBa6YtUJwiqpXbyPxLCiolJRYqrAQDe9qIYxXZtMxDdMeFIdP7
	mpNw==
X-Received: by 2002:a17:903:246:b0:2a8:f8c2:bf2c with SMTP id d9443c01a7336-2a8f8c2c08fmr2528105ad.59.1769836173401;
        Fri, 30 Jan 2026 21:09:33 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef68sm93625465ad.16.2026.01.30.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:32 -0800 (PST)
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
Subject: [PATCH bpf-next v4 10/16] bpf: Support lockless unlink when freeing map or local storage
Date: Fri, 30 Jan 2026 21:09:13 -0800
Message-ID: <20260131050920.2574084-11-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255354-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 00C6FC0B4D
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
index ece32f756d86..4e1ebfb3b9e8 100644
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
index b8f146d41ffe..54d106ebbfe5 100644
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
@@ -421,6 +425,96 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
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
+	 * map_free() and destroy() each holds a link_cnt on an selem. Prevent called twice
+	 * from the same caller on the same selem.
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
+			 * In the common path, map_free() can call mem_uncharge() if
+			 * destroy() is not about to return to owner, which can then go
+			 * away immediately. Otherwise, the charge of the selem will stay
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
+	 * Normally, an selem can be unlink under local_storage->lock and b->lock, and
+	 * then added to a local to_free list. However, if destroy() and map_free() are
+	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
+	 * the selem only after both map_free() and destroy() drop the refcnt.
+	 */
+	if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
+		bpf_selem_free(selem, false);
+}
+
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem)
@@ -487,6 +581,7 @@ int bpf_local_storage_alloc(void *owner,
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
+	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
@@ -754,6 +849,12 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, true);
+
+	if (!refcount_dec_and_test(&local_storage->owner_refcnt)) {
+		while (refcount_read(&local_storage->owner_refcnt))
+			cpu_relax();
+		smp_rmb();  /* pair with refcount_dec in bpf_selem_unlink_nofail */
+	}
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
-- 
2.47.3


