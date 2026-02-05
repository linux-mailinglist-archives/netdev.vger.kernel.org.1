Return-Path: <netdev+bounces-257329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGl5NOAZhWmx8QMAu9opvQ
	(envelope-from <netdev+bounces-257329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABCF8121
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F7A3026C3B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B13375CF;
	Thu,  5 Feb 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NslB/xwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63D3375AE
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330559; cv=none; b=pipAB0u+In0/xowAeQCtsLs5RGyeNep12Eg3eE57PqvmfiQUDIwL/zByiC4xURaZnOyrVeYodMLW4cdwBx53LIIbjZsoWa93rNmP7azMpHYW6eZvmYdHtWgPkJcyiKAYSNDFLNJaNGSerq33Wl4OLis5JORKyz2DkMRxYFhftv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330559; c=relaxed/simple;
	bh=a9mtm6JKnLQRSDyhS+B+EekIiklXj9fag9Oezhn2aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6xk/BSpThDFAGqAj0BJVB/D3reYdICvItAO4dieTshoj/fpjVgbFTG18gfqD5hYsLRVXGaGwqlhGcvVHDKIUiUqAWj1HB8JZT++fllzhZlFAKGPmbWp84mSf9FAgB7avhSFiu8U8ZswHMnC20yZCT/7oKZYV58krcqtSQtMG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NslB/xwM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82418b0178cso905242b3a.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330559; x=1770935359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=NslB/xwMtOX5n58yTIxR3TLuBsBjBhDvleB3/3nQpFuY4eAO0w7IISGbyZKy3PgFCE
         6YhIlyJvCXbBMWMs9iiSjrfnpUSxkfEq/O51jsEJhbhB1LShbWI32mNVDCNRNBd/qzn/
         OwVYRyWNWOUV5RHPKQHcsWvKZ5YP4r0rMfW1mUFTYR+WiuBH/C/4HVOqkNLlP+lN8n1C
         lRq078Yi2F/Be42s/r8y+gfak1fytKsvCU/LKKz0gutyjiq70VekGeYRf+azkj4T7YgI
         2TscByAaGbwydl+W3XdtSeBAFHnaurPddAWEadC9jRoX/DIDMobw3b66HMNpwNHMEyRe
         nXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330559; x=1770935359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=Z7QQGH1JK2Si4hPCH9LNVYdpcS++CVx4+0uzCih4Da4DMd5mJ4imesyySNl3ZxvkvN
         ZNbeGAyVl5qzBioRPDtRyq7/D7sGTdwgDFWrB7LvLtPA75mjNEmar6B/xh3iog9O9Hkn
         lNm1/mrxjSU9/xngVzPvM/+/2fHdtAtUtyWcSS2gmoDv1AQPDNrOoRMbIQVbCK7GEBYx
         fj5f50h54AtqQfQSU6HiMsW/jMqwVwixLtDb01/AaGz/E+RTniSAlwx+fKvvRMRZvef+
         jbmM1DqlJSqYsdbb38Zc1fiRoJp96rpipcG0seJmQNl+xQZ3vIVY6yA9dwFdw706HQlF
         JhOw==
X-Gm-Message-State: AOJu0YxSu/7hMCL8aw8L4TjOd1lmSe5PeS5kVLmH7z82BekBUu9hW0wq
	U0HIltPV6LgopPD/uGgRmKeLRTzQyp47/XSRSSyjOCcB0Ori2xTnHFY9
X-Gm-Gg: AZuq6aKOXkisYCt9d4t6YdVIdBU46lWEzIjZXyupgT2mJUYfOivhLCvZD0PBqQlQFQz
	/IpqG365zV83kmznjOTJaxBWU9hZhKyESQZZGm6VYXNE6U5PelIF1WItJfdDAGfo98+FtX7Ehlv
	TXbqhFl328u2HutbZxiZct7YoUAuZZh5m0HsFwitaLQSWbwUVJEj5dKmzKsu4tQwn4i+Ds6a2CD
	RE05O7Pe9DOKg0gc6amfT8QfIOWzQUb9gtF2LZ4Da4vT+46heDzBmP1wsdDkt7VWvsoYgUBfpmu
	3P0aTNyndMP3hcjURxSGn234lpVP+9xJArPjB6RMxiwJ4EePKQ9oG53fd6nO/cu9hnD9buWkeBg
	YyFO55Gqd9YY/Tr37GhAwdkDIfjToejVw9nHD4GzG3xHpHjOBfsvqoz0wQJ12GF3OERZxY2z7cp
	5YPA==
X-Received: by 2002:a17:90b:38ce:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-354b3e6d619mr420030a91.34.1770330559125;
        Thu, 05 Feb 2026 14:29:19 -0800 (PST)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b45a2987sm143334a91.4.2026.02.05.14.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:18 -0800 (PST)
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
Subject: [PATCH bpf-next v7 01/17] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Thu,  5 Feb 2026 14:28:59 -0800
Message-ID: <20260205222916.1788211-2-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257329-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 38ABCF8121
X-Rspamd-Action: no action

A later bpf_local_storage refactor will acquire all locks before
performing any update. To simplified the number of locks needed to take
in bpf_local_storage_map_update(), determine the bucket based on the
local_storage an selem belongs to instead of the selem pointer.

Currently, when a new selem needs to be created to replace the old selem
in bpf_local_storage_map_update(), locks of both buckets need to be
acquired to prevent racing. This can be simplified if the two selem
belongs to the same bucket so that only one bucket needs to be locked.
Therefore, instead of hashing selem, hashing the local_storage pointer
the selem belongs.

Performance wise, this is slightly better as update now requires locking
one bucket. It should not change the level of contention on one bucket
as the pointers to local storages of selems in a map are just as unique
as pointers to selems.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 17 +++++++++++------
 net/core/bpf_sk_storage.c         |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 66432248cd81..2638487425b8 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -179,6 +179,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage *local_storage,
 			struct bpf_local_storage_elem *selem);
 
 struct bpf_local_storage_elem *
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..91b28f4e3130 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -19,9 +19,9 @@
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
-	      struct bpf_local_storage_elem *selem)
+	      struct bpf_local_storage *local_storage)
 {
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+	return &smap->buckets[hash_ptr(local_storage, smap->bucket_log)];
 }
 
 static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
@@ -349,6 +349,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 
 static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
+	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
@@ -357,8 +358,10 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 		/* selem has already be unlinked from smap */
 		return;
 
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-	b = select_bucket(smap, selem);
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
@@ -366,11 +369,13 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage *local_storage,
 			struct bpf_local_storage_elem *selem)
 {
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
+	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
@@ -448,7 +453,7 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+	bpf_selem_link_map(smap, storage, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -576,7 +581,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
+	bpf_selem_link_map(smap, local_storage, selem);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index de111818f3a0..e36273e4fcbd 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -191,7 +191,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			bpf_selem_link_map(smap, copy_selem);
+			bpf_selem_link_map(smap, new_sk_storage, copy_selem);
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
-- 
2.47.3


