Return-Path: <netdev+bounces-245421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D213ACCD0D9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552B13051226
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCAA30DD0C;
	Thu, 18 Dec 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvl5uTFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C0303C97
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080604; cv=none; b=nFlV/zPzHUUTuVdMkhz1bR33xGP7MuGpRBmMGHbBxAQIyUJbi+xGx/WfrhT3dr+JlitWyfghQiYKB70gB7POFfskC+HEOQgjcbOBqPf64lJrHVDPKYdOvEY9vNvd8JhzfNxPxFTxNrX7ipRjBJm4xz0jL2i+J6mlOKfw8qH9pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080604; c=relaxed/simple;
	bh=fwRtVg/EoMdMjX0tUVA9osStEVuZ4ri/0yQ2ocJqB8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oelucqneVppUPRra5v6HjJlxp65creUnPr4HOnGduuTUUdEaLAeKlW35J/GhgHnAyxQjqOEeC8U8QOR18bduWSVoY/AePkWXiZ7o2xZ+NCGZp4Utcfkwz8NspSWG/8T+AAD8rh7CKQEbEiJDxqFluDuPqhOhtHYkTq+mRmCF0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvl5uTFE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso1102402b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080602; x=1766685402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnGjAfQwEH5fZmualE8zqKXZNoo3QGgbGbdg1HnpsaA=;
        b=Cvl5uTFEnJWUJmOOlD7TZ3TOvn9M2TmBeuFnc7ZV3XUsn62XnLm/4ng6vsGzu74AM6
         92mcMn2dqpiSkkE9DIrA3WE8cSpfY/5VkW4/JPCeloqu2v1GcBtUqUaXYDFzJTFRCDCE
         oaYoc9XsTUqblSp2s+OyTBYVKOciReCWD5NEcc/neyMAArxSSDVRSAH2iUbr68E3sCt+
         PIvSrkrIem98b0CTKQH8JEZd19ibChIElQocXhTEScsb7FirIxxrLnpmXHBm52zufuPQ
         Bn/TFUB7Fixsys+8Ie6TBUR65TdcRewatm4VmkB3XpMns6XL6MS7Z6hwvkQ0ohdg8a0Q
         B05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080602; x=1766685402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnGjAfQwEH5fZmualE8zqKXZNoo3QGgbGbdg1HnpsaA=;
        b=iIWqYO3m0kpnB0Kvf43xJM93f575pOTehgLyuGCk8GaEluZ9ZUoZfz6FqeRYlDUyZ2
         f/pyXvjpWbH+Op6QKBA5drINUAKSujybE+vAzgU/hxacHRpuWjaEzglR6A9vMBDD7iR7
         w6/7aoG08l9RSWZU4WtFDXoimplOuSd0xFsSbUeLGq/+FJvUm6bIbZWFQ1Ztu7USi1hL
         xdARbRY2nrslkZgy9/eNFjZJriou7LdlN4f2vJilbOgvA6wLmIwMzeqMyBG67VMV0jiD
         8QiRH4DtqzOeTbqnp3AzbMIPgrHyITTOKwtvEzYKmYGaeRQlTupQ/cBFaPtguI+IpsHD
         6thA==
X-Gm-Message-State: AOJu0Ywa61ypJei8XR1eLtobfuxattnfIr17bxyYnHwH7ZiYnCYrISG+
	BpXNUVFuJNl+EpycTtOCumknVEVp4H2m3IFxUYoir0fDfadJPHwajQqW
X-Gm-Gg: AY/fxX49eeOeTwV8STTeL6bq32MTCVXaCQO9sHx9kVAuSLpLtahukYAW7MJDaw43m4K
	GV2dOWuu16mMV7DVxC3b9jWW0JAaD+IGX06898YXgHWvvSmYfhbf55FKufMmKLI7GCybwpl1vvW
	ZvJtLMRyEZ/Th+wuzNWgNWfceAd3wk0znD3MBAIPvi1VTgbGDl/B+fu+Gy+rxd0WeTZsiaZ6s5X
	vCTaJhH3if6So9KshsmWgJijrxIb5JBqMo5ohM710Pu+pAxCvI0MHk0+zgtRQQkFrykTDOaGAsX
	ywIWIFsvFFt5rFv/ajHC+jyoyEmY6Icl+nZB/HtMJMMGrud1R3BUiL3i5kEbZdhlIhV9DCZ6Ixx
	UjGRczprxaMkcOhu3xf6ikKkxD4Dw/h0K+QlCLnCEW+ncwcin5CNd3/KROIRJ1k0dm+JOBGURsM
	BebJKNm8+aRs2daA==
X-Google-Smtp-Source: AGHT+IEKym52aOafOCi0h8wu9DKCnC9TLdFfJREc/viYO9b2QLlQlb6fxve4ltckhsAOAh3zZDkFLQ==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4398:b363 with SMTP id d2e1a72fcca58-7ff66673079mr164247b3a.54.1766080602182;
        Thu, 18 Dec 2025 09:56:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1456bc5asm3222715b3a.55.2025.12.18.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:41 -0800 (PST)
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
Subject: [PATCH bpf-next v3 10/16] bpf: Support lockless unlink when freeing map or local storage
Date: Thu, 18 Dec 2025 09:56:20 -0800
Message-ID: <20251218175628.1460321-11-ameryhung@gmail.com>
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

Introduce bpf_selem_unlink_lockless() to properly handle errors returned
from rqspinlock in bpf_local_storage_map_free() and
bpf_local_storage_destroy() where the operation must succeeds.

The idea of bpf_selem_unlink_lockless() is to allow an selem to be
partially linked and use refcount to determine when and who can free the
selem. An selem initially is fully linked to a map and a local storage
and therefore selem->link_cnt is set to 2. Under normal circumstances,
bpf_selem_unlink_lockless() will be able to grab locks and unlink
an selem from map and local storage in sequeunce, just like
bpf_selem_unlink(), and then add it to a local tofree list provide by
the caller. However, if any of the lock attempts fails, it will
only clear SDATA(selem)->smap or selem->local_storage depending on the
caller and decrement link_cnt to signal that the corresponding data
structure holding a reference to the selem is gone. Then, only when both
map and local storage are gone, an selem can be free by the last caller
that turns link_cnt to 0.

To make sure bpf_obj_free_fields() is done only once and when map is
still present, it is called when unlinking an selem from b->list under
b->lock.

To make sure uncharging memory is only done once and when owner is still
present, only unlink selem from local_storage->list in
bpf_local_storage_destroy() and return the amount of memory to uncharge
to the caller (i.e., owner) since the map associated with an selem may
already be gone and map->ops->map_local_storage_uncharge can no longer
be referenced.

Finally, access of selem, SDATA(selem)->smap and selem->local_storage
are racy. Callers will protect these fields with RCU.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_local_storage.c    | 77 +++++++++++++++++++++++++++++--
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 20918c31b7e5..1fd908c44fb6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -80,9 +80,9 @@ struct bpf_local_storage_elem {
 						 * after raw_spin_unlock
 						 */
 	};
+	atomic_t link_cnt;
 	u16 size;
 	bool use_kmalloc_nolock;
-	/* 4 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 62201552dca6..4c682d5aef7f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -97,6 +97,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 			if (swap_uptrs)
 				bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
 		}
+		atomic_set(&selem->link_cnt, 2);
 		selem->size = smap->elem_size;
 		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 		return selem;
@@ -200,9 +201,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
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
 
@@ -227,7 +230,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		 * is only supported in task local storage, where
 		 * smap->use_kmalloc_nolock == true.
 		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
@@ -419,6 +423,71 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	return err;
 }
 
+/* Callers of bpf_selem_unlink_lockless() */
+#define BPF_LOCAL_STORAGE_MAP_FREE	0
+#define BPF_LOCAL_STORAGE_DESTROY	1
+
+/*
+ * Unlink an selem from map and local storage with lockless fallback if callers
+ * are racing or rqspinlock returns error. It should only be called by
+ * bpf_local_storage_destroy() or bpf_local_storage_map_free().
+ */
+static void bpf_selem_unlink_lockless(struct bpf_local_storage_elem *selem,
+				      struct hlist_head *to_free, int caller)
+{
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
+	struct bpf_local_storage_map *smap;
+	unsigned long flags;
+	int err, unlink = 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
+	/*
+	 * Free special fields immediately as SDATA(selem)->smap will be cleared.
+	 * No BPF program should be reading the selem.
+	 */
+	if (smap) {
+		b = select_bucket(smap, selem);
+		err = raw_res_spin_lock_irqsave(&b->lock, flags);
+		if (!err) {
+			if (likely(selem_linked_to_map(selem))) {
+				hlist_del_init_rcu(&selem->map_node);
+				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
+				unlink++;
+			}
+			raw_res_spin_unlock_irqrestore(&b->lock, flags);
+		} else if (caller == BPF_LOCAL_STORAGE_MAP_FREE) {
+			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
+		}
+	}
+
+	/*
+	 * Only let destroy() unlink from local_storage->list and do mem_uncharge
+	 * as owner is guaranteed to be valid in destroy().
+	 */
+	if (local_storage && caller == BPF_LOCAL_STORAGE_DESTROY) {
+		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+		if (!err) {
+			hlist_del_init_rcu(&selem->snode);
+			unlink++;
+			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+		}
+		RCU_INIT_POINTER(selem->local_storage, NULL);
+	}
+
+	/*
+	 * Normally, an selem can be unlink under local_storage->lock and b->lock, and
+	 * then added to a local to_free list. However, if destroy() and map_free() are
+	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
+	 * the selem only after both map_free() and destroy() drop the refcnt.
+	 */
+	if (unlink == 2 || atomic_dec_and_test(&selem->link_cnt))
+		hlist_add_head(&selem->free_node, to_free);
+}
+
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
 				      struct bpf_local_storage_elem *selem)
-- 
2.47.3


