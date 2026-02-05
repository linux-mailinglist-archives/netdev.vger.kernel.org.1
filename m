Return-Path: <netdev+bounces-256990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LwJDZZAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9AEF38C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5940301D4E6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA9356A38;
	Thu,  5 Feb 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im8jS4aT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353B3563CD
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274932; cv=none; b=iwwADskCsyV6hgK8T/r1bHarDT2NhOBmUz0fBIJL1c83PXfHl58aU/g4ODBbHoSXxajXZeMoM/X2q+bDqEz0kWap+TQ2TUrkcX4kw9VzBI3MGPWn7t8MS6X4y7SqsOjLfQkfsYtxd3xE842m4Px5oAPb2VcUGOdhI3aulp8QT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274932; c=relaxed/simple;
	bh=a9mtm6JKnLQRSDyhS+B+EekIiklXj9fag9Oezhn2aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1d0KhiPQecKARhx8+VsauVmMEhEscMKALoMh11Ydn0NAxNqpV8Nb3QtEbXeRhTogW7Wa31MizVFZ0M9qjLKyPOGp2AdP4FTLHD5V8gIm8+wRVcIWgMikOkjk7Dhn4/N/j7XRlhMOmxuPMBQaAPREMZKbO7c/LIuHgJAUtYzraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im8jS4aT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c868b197eso372302a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274931; x=1770879731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=Im8jS4aTfKJV5fwVa1wH2e5vEvVNpllp+PzwcTPkg/pCrUsueFLQVhcIG1cuO9q7ul
         GF1hZ5Lzk2q9YUFadAtREOt/KsH+iX2IVwlmj4Axv7q7Uqvrb9h38V0RsnxVFZdiwwNx
         8OEo2SyRvvUy8EHc+WQsXXWjccIKEwvhgzxULxp3jhHv/Y45MgIL2ZDT3uM3G22bXPSS
         Ne6qWJvJvQnchJcNedXB4/RL1SNT2QhsIPcw4PcIloovto0pOqU+ysXRGk4XZb1wtVqX
         9h627VVQKQaMmy+PKenS+zwqTiRu18bsFzYlaBvReumCiDcq3AsWkAQiOwoAiYtgR/k5
         WpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274931; x=1770879731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=ix737Q7Cl9Bcvh3IaLAbSeQARW2dQYO7+mpCpJi777DNzTmheYpPcgvxjIul5MAdA+
         rqPsnsH6FKwjALykE2eOS2+XWhqoWc7aONerVFdCRSuOZTTspLD5/wIIjGXDg7bc+kOH
         ld2SOjWFHz8gyMhbCX1kGBA242sdaT6KVw7IVKgB+eX+T6g/Nr10620vMbDqd2KNHLyg
         dpdlR+EgKezsKG2oH8/6FwysM6xWf5Q1DKL6P3HOZ/VYiS/un1P6xTS/zssVN/AT9YlK
         mMQs32JgFbWQSegMnA+6ig2sidpMbgVuqFEISfrvZDZXkowwOPfsv8oP2IcNvKVJtU1q
         JX9Q==
X-Gm-Message-State: AOJu0Yyf2C1/BIhpmRBaWdNg3hn/EUlvFUsS8PMphT/NJDbbu+rH4gOD
	ycTJS8FkZRoAFqQ7BXm5qoULL5Ci7Yuw1NSFMFkKTtA7+x1jaVU5c1qN
X-Gm-Gg: AZuq6aJDQSznA6e2FCuIdMgK7Iw8n7yhy+Z9D3HVxCUZvBXYrYgrf177tS0paPV0zCZ
	5CYQYYdPN+GpzVU86c4zO+fUlxQVVvyMOGKhonYYQpg6nlAlxXDcrUTQ51v+7zDNVItpTQNdyww
	yhEsD8IMjipMqw2+xaxNxl+RimRsPL6KLnxeCOaqa36O6F262YKhRn2bHTX+2H5TYGzYmdAy4lo
	33vxn0C8Czwa7ejwDaZDYUxEFn0E+pDnr2pPBb2IgNXojVeLw6o6zHXb0myfqYpd3gbWPOKN0qG
	j1srlDK/SVcDxGHlUREUjoGBx3OsvCo0RMUGlzvx7fmm0CHZCc/mWNh2H5cKuWBVi3LY8mnL9JS
	OPGBBcqNzAiHj/d0UusicGUmXq3MbSNuPqy0BuI/XG6t5y1oHNqJyTnukaVdyaG+YbEq2tecnjW
	m5KQ==
X-Received: by 2002:a17:90b:5808:b0:34f:62e7:4cf3 with SMTP id 98e67ed59e1d1-354870d71d3mr5341618a91.10.1770274931219;
        Wed, 04 Feb 2026 23:02:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548910d6ebsm2533800a91.5.2026.02.04.23.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:10 -0800 (PST)
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
Subject: [PATCH bpf-next v6 01/17] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Wed,  4 Feb 2026 23:01:50 -0800
Message-ID: <20260205070208.186382-2-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256990-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0A9AEF38C
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


