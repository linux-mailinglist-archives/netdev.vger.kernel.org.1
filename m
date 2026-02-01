Return-Path: <netdev+bounces-255648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLZ0JoWSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1547EC6C80
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8953005AFD
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A62820AC;
	Sun,  1 Feb 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAyvjTg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2621CC55
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968255; cv=none; b=ojARTNBiCxNWucRRPDNMQx4bybUVjCYqU7QSgVirUWtcfVc0XvPX6uU81cNbC+vRW4uK0I12QbDdp/YPp9tlr5xZdeeNPAcUGyUIM3+OHPrUixxWEiU4ELImqBCXR2pNgPzOGHddEiXlx97LuwXjujuRiLhwqUI+4hBj+uqoEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968255; c=relaxed/simple;
	bh=a9mtm6JKnLQRSDyhS+B+EekIiklXj9fag9Oezhn2aVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF75i9h5YuPx84k9Ozc0CL32jsc6zVGTMJhum/evFzWDdXfCEckzxTJnUFDOoVbUsAO7IKUl83yZyeHPfIbVoKIwrpA6ElX7Uj5tb04tDVE2sIEm9cv4w1ZwbD8nJdqXqQamXCRw0FZOtEfAcVrcqIAGhKmGRWLGH8I3B+BSD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAyvjTg+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a8fba3f769so4124675ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968253; x=1770573053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=MAyvjTg+jdniSE1Kkwvj4ybSuImk1fOehxkxQRMdNcNkCZCWNxFbWAhbpGAodboFhb
         DBbx0glhnxafwWKGueDZTGCJF1cRWuMgee8xCUl6zzRzpUDAb9b7udoG6sdVChhJGF1g
         ZFV5qdw+6eadOwn2iro9bE+UZ8OlVUTkYLCDaSjqS5AeR+FRIH5uQDBkpb4LFo+P/Bjw
         GiUdL/kJpTqnCBHKk4+GkpjWZbn2sdUxh59kVMGj+PggJTkqjFSxs+xIc2rY0ZL6AmWv
         yjQ5d5BC4NHWUgNmvuN+iEm4eQ/GLoMjmD7o9QSm2I1Q5xSZQw4sQhIcN3l/wpg+HBMg
         d6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968253; x=1770573053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Acngkvk/SJDpuSIXTzDxVJ6in1fJVE/cZK66EwuF7jA=;
        b=FXTP8PvRQqxuWbY58qpU92s2RH1GRw6Gij9Qs0mDNmctzw+/wdVFCFa77nBaDLOkmX
         I0i4KkN92MZDXSU8+OXF57xrAlnAH2xyD1CesTPX1MDj0sA7MrcSM3vJJP/NryFUDZ8P
         oVjKASFKZANDXpKTIbGbE9UhUidTspNSTt3EGBVKDJBsAw8mKKyi1KfNdggrW2C4HPVg
         3BGTKJOphz29WOH7JXS7lFZa3pXoYf6A+ifzHa662DF9OofVrIoHBQ8cihMIpYe/bYWa
         A0QnFJu/QS8SjlrT4LGzgjpFkdAiV3yQJux3P18y8BCt+DJmx8xmM3tOhWFOQOyz+6Fl
         M62Q==
X-Gm-Message-State: AOJu0YwiDR2OpZ8WMyLP1dblZB9S9FED+FjLCfuiStj0+tBYtoYUXgIJ
	Dvg6tHxqMZqtGFUc7WyGkdoQpQYon9QUNPw14N8iR0dy7JCdE7DehBGK
X-Gm-Gg: AZuq6aLZTb1JSb2qSLMF0cd5Z8UYy20hmKyy5vwZwseb3zu+56iI7J6V4m75pbqUmLQ
	5s07pjvq2XOz31YmpOKNwwmYGUCJVXXyOFT8OPR1klA4NvwMfKJaKO/3OJyILyAD5WfFId7amM5
	epRq7K2URfURQ3pDXE+kd53zkiRTcJjm75/oRW81aE9eVZFVgczs/ZBlOcOaNdBW3mOPzjD+5m/
	7IMLhxYRCpIvtjr0mapErVAnr/5++t/9aLPXH2f6vQMYHJEAjyJrjfJLCuZ3xJQ5OVAopMHqEg+
	BfXjPwIXZwOf69kBukjVjE3mojqrJdeGuheGvGvLp5XO2q24UAJli1iLFFKC6x6qazYB310TFVJ
	4CgRhdxfS7SrHJF256HiBXD77/gQ9ZUPcJzvzWHIldxFT3tWfpcMai3zy0RQ5yqseZAgJI+Rg08
	5l
X-Received: by 2002:a17:903:f85:b0:2a7:a9e4:babc with SMTP id d9443c01a7336-2a8d9a7d456mr87144725ad.61.1769968253319;
        Sun, 01 Feb 2026 09:50:53 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b417394sm122463165ad.42.2026.02.01.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:52 -0800 (PST)
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
Subject: [PATCH bpf-next v5 01/16] bpf: Select bpf_local_storage_map_bucket based on bpf_local_storage
Date: Sun,  1 Feb 2026 09:50:34 -0800
Message-ID: <20260201175050.468601-2-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255648-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1547EC6C80
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


