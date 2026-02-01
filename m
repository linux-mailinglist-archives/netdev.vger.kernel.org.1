Return-Path: <netdev+bounces-255651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK05AJiSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4044C6C8E
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED873007881
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6BA284672;
	Sun,  1 Feb 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8HfEo9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAA27F759
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968259; cv=none; b=dFnHTdjPtHv1WAgStsvKSCTNFK3d5VBIRYmNCdo1B6Vec/dxjp5XkZwQnLjbz0fAIkJtSSvRonMdiGn05Axs/sHpmeDZPhGSFHQ4lr4vON1gg99jQ+lrt8Q3ntW9E4Oa1zsNctBbcztNiu8PdrjerW/FdEJHI303VFBbqXpjkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968259; c=relaxed/simple;
	bh=GrLV5gijxoE7NSW6SK7VgXZ5qFlInWugStQsPetpfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBFEskKOeqLs9tMyyTQ7rNCJSTwlIYgilSS1uA5hGB8WlJal4GMeN+xvsKZgVClYH7jXBQtDLXtKXKcgTNGZgkKDQugP78cgPX95ZNL4TtL9a6ON7zABfAn2aG74tR44CngxYZ3FXbX3hYjbw0Rbp7knsh2WVSPSHtLN3gxRE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8HfEo9W; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso1411256a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968257; x=1770573057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wyGHQfdqlOcSTajpA9fKceqwUXV3jdUWCFJw8oPo2A=;
        b=m8HfEo9WYpB4BiUbpoCfZHpPhoWJ75Sgd4mc8L3ucDQcM0tErvPjjoVRACaVoZYw4b
         APGwHGfNT6KE3VFFt4S8cmGuAVvc9kEajg4xH2G1kt1a8kvZv8/lTjJyQHvppKhOG/xE
         shTQs4HlH0EQsKcp1qkov3672QEYOlWZEYzvv8FRZhcItKCE5l4Fg8wilNycxjJtZWru
         qqXykDk2GsimrzVQlIloqyI71SY3dQDt666t5eCDJSb776za1/7x7UhvnfyzZONAmvOk
         tLj/3wZNbRYWBj0f7IVoMx4Kn8+VHAQ6jWvKlxYgvjpvFXME7f+bXgyfowMs6kUXiqnR
         3YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968257; x=1770573057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wyGHQfdqlOcSTajpA9fKceqwUXV3jdUWCFJw8oPo2A=;
        b=Xw3DOlfusq/+D39DzPrwRB/m/Tc38prWrk6LTC4Oqe6O6fM9hflN3D4ll7u6Lk5SHc
         B1fvMOPkgrSWo1olWJtg/ZYFhjXaRClTzNn4alz2HcOscQYKwDDnhSLcrJFYlfoGhZLd
         9RNguw+YvG0R72DizpXEQ/wsLbvUcyRYwdS7EzxyRT6nlI1ones8dzf1o4CeIROKICwW
         HrtEjAlY5MWUsCEFBvCsj8shHRcNF313ptaVEX3GGJCffu4QiyayAg4x/+1ASURbeYIq
         8zGSpAc7Ox/UPspunkdB/hFj4eoJMmeO9mkzbtlom+ROLvCm3qQgG6IbklsdI1KT54+i
         ilIQ==
X-Gm-Message-State: AOJu0Yx83RPEPVq8Y9Yb0JjgfdcbHuArGzSxfgh/vzU5hCsEgBvwiVDc
	7gNN4CVVW6iC+pYRbV9NYbiT6Hd1bjGVaKiZPnD19QHwvGYbDfe5aPDn
X-Gm-Gg: AZuq6aIX7QQ791NX6ZLtiquocMaytqu/djK4ib7S8q1HQS0YO2h7ZEo45kXoT35Uzzo
	3tnP2EEBnnkTbR9lBM6k3GoIMnDyr3jkl8t9znSRvi4f4RmgwYwG4tCsLAiWqoxc1T4nCoH/tcC
	4nMFuV+NeBKzRDErHhKX+Le2aI+Uu5UWoPgAARkHORIniwHCIw3JbBkOb+/Cl1VWAKvQYqdWF7X
	L6QBRVSqKXy6SUOahFXo2ijOugbkU+CgFGs5rWakW7Osc8l4Z1ARcUQncyg680DrhNJ5CLRJlCi
	H78gR7oQkD3r/Zu/rgtEJPodoPCMojbBfLMyNkypqLxRn8xswpGIm0y6mGyzE9+Z2jXRjX6zVCE
	xGxw7Bg9lW0iADJau+KP4iWhldNuw4jVOkBGUVehtsohlZWXEa6QiNxSrIT5Gb3hrpZsairx1Ux
	V2jw==
X-Received: by 2002:a17:903:3b83:b0:2a7:682b:50af with SMTP id d9443c01a7336-2a8d99327f5mr93280165ad.40.1769968256815;
        Sun, 01 Feb 2026 09:50:56 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40e1sm124295215ad.55.2026.02.01.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:56 -0800 (PST)
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
Subject: [PATCH bpf-next v5 04/16] bpf: Convert bpf_selem_unlink to failable
Date: Sun,  1 Feb 2026 09:50:37 -0800
Message-ID: <20260201175050.468601-5-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255651-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4044C6C8E
X-Rspamd-Action: no action

To prepare changing both bpf_local_storage_map_bucket::lock and
bpf_local_storage::lock to rqspinlock, convert bpf_selem_unlink() to
failable. It still always succeeds and returns 0 until the change
happens. No functional change.

Open code bpf_selem_unlink_storage() in the only caller,
bpf_selem_unlink(), since unlink_map and unlink_storage must be done
together after all the necessary locks are acquired.

For bpf_local_storage_map_free(), ignore the return from
bpf_selem_unlink() for now. A later patch will allow it to unlink selems
even when failing to acquire locks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_cgrp_storage.c     |  3 +-
 kernel/bpf/bpf_inode_storage.c    |  4 +-
 kernel/bpf/bpf_local_storage.c    | 71 +++++++++++++++----------------
 kernel/bpf/bpf_task_storage.c     |  4 +-
 net/core/bpf_sk_storage.c         |  4 +-
 6 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 709506e982a6..f74e0f7656a1 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 0687a760974a..8fef24fcac68 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -118,8 +118,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..cedc99184dad 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,9 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bcf7e7f42d18..5dcdf8e523b4 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -308,33 +308,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool reuse_now)
-{
-	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
-	HLIST_HEAD(selem_free_list);
-	unsigned long flags;
-
-	if (unlikely(!selem_linked_to_storage_lockless(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference_check(selem->local_storage,
-					      bpf_rcu_lock_held());
-
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &selem_free_list);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
-
-	bpf_selem_free_list(&selem_free_list, reuse_now);
-
-	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
-}
-
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem)
 {
@@ -387,19 +360,43 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
-	int err;
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
+	unsigned long flags;
+	int err = 0;
 
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	err = bpf_selem_unlink_map(selem);
-	if (err)
-		return;
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
+		/* selem has already been unlinked from sk */
+		return 0;
+
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
+
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	if (likely(selem_linked_to_storage(selem))) {
+		/* Always unlink from map before unlinking from local_storage
+		 * because selem will be freed after successfully unlinked from
+		 * the local_storage.
+		 */
+		err = bpf_selem_unlink_map(selem);
+		if (err)
+			goto out;
+
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, &selem_free_list);
+	}
+out:
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_unlink_storage(selem, reuse_now);
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
+	if (free_local_storage)
+		bpf_local_storage_free(local_storage, reuse_now);
+
+	return err;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..ab902364ac23 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -167,9 +167,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 0b85d8f2c17e..d7b5c4551997 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,9 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), false);
-
-	return 0;
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.47.3


