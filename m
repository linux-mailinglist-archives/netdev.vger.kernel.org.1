Return-Path: <netdev+bounces-245412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1808CCD0A6
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E888C30484EB
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC8302779;
	Thu, 18 Dec 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ginfWadY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320B2E040D
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080593; cv=none; b=Sm3VJ2DsMv4GrnxOGYiDhz3CH82qGTG7FB+hzfVolGCTK+qp/J8VMg8EZp9a2Z01evbpC5O9qwMmNRvHPuAcO3u6YKad7tgOa5MHhw1TPTqrBRvE5LY+Xt7cA+gnCp8lnVOXx40dEuzdSZWsuCE/KxKsi7fMm8oWzlcrp4LIBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080593; c=relaxed/simple;
	bh=Zm/2J2Gp/7MOUwKbpHPeot/xaphLr02d/7QUcCjBCAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyyCyiuDyejFpz2vcb46c4oD9qbk5foJ8+rACgKvKYT2W5LI+d9YcPalQjQJtIje3f3UqLB5ZF35G7ZnJP/kwQ3clm0LTE4LO6yzG6dozbpJLhwJoSC2NwB7qmLkzBjT9JqQHqsgEGu2lF0NfF+jwger+WQSAdHQtljHOnqcnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ginfWadY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso1335359b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080591; x=1766685391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMxWWMICz468XY7xt2inPsxvaZWi3Dfhd4srr2vNxVc=;
        b=ginfWadYpuUh2pVA+uLnyGLw9ro9JNTWrclBbHiTqPsGRKs66x0vSyS5LbiVEGFg/z
         N+BzpOeHXILAhnmP+qrzbr/JitVYh0uiAODGqM4szoYYg/KVtvIRZLt7horJHe/rSuYG
         FWVrNhe4ImtseE1fvcxX3++e4kBvTyz6E21Ww4NuCsHH4gNlnJqBOG/LWfVtZEIcSN1Q
         ISfssaZLWmdvHwkKXn/e7tL2ccWBlJCqyEaExu9SiNWvp1lF5WWxBOPjAlPyHUIiUpYb
         opXpRgHEd1cWEGnbMqcaWKJwveso2Gwpx4+540koQs46Pk3Kh3tZ6akxpu78fkkatSs9
         j8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080591; x=1766685391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMxWWMICz468XY7xt2inPsxvaZWi3Dfhd4srr2vNxVc=;
        b=Qb8jbmxmCNMm8DxCtelOqQuHRYZGv409qTDGKLNYtUJhWiRJ9GkHfWjRdrJjETKJin
         HGsAemI6OyOyWoOYxhV4x5w1keRip9N12wUnNCQJa6hRowkGGFATZwlLs+ayXi5+VcFN
         dv9f3LG8OBTeGprviaSlqnTmRBh+Km1Tny5JTIfzx3iDmV5I7AJDUJU9Wun/HNq+gCAM
         xggs/Flq5XXdeIW6/QlCQWmPWZ37hDzRWPAu4WWCptSxnza3LlaynNgd5CYJ8dkAxZ5Q
         hwYb+oH6Fb1n6gptpPwD5JJg5b6KfPHQ2k7Bsow+aVJETqRkItcwDpeXItzcjaHvJPH0
         pi8Q==
X-Gm-Message-State: AOJu0YzFCUIl0ODlozX8p5Dp6PXrA23JuM0iZudzec5gAEYfzK590Fon
	DoRFdK+N5rVWScNk9tqdJx8mg0ZKrzDQv6uLtpzrPSDJTlbuJBdzR1F0
X-Gm-Gg: AY/fxX7TD2vMLWCRG9sqN/4K6L3Xz0hKkQ9NtEHkjPZgkAhMdVLq4gVk1uSfcxxzSQS
	NmXk0a2cCIYgTJdeAtz2m1QqQLVX5FgQvCe/xsiCmxzJkuZOt74U88ZYCNZ6y+/+W5qc0XkVC5E
	Bg89tr7FidTbko+gsHfpttjpJCafnpEIm1x422ZDZBqhINB+g9C7S9iHYo+qFU5+u+VwGA1T/Xm
	T2hi0hC+9YQpQZuBJnKuY7M2JwhrxgzHXgH6hA/xzpytSEOoEWYY0fQr/WtIgGQCGezA2fbMWUd
	jkif0Mw5t2VuPWGLmMD8UHHRlx2OWjS7el0zmxow1v2d+1O2hEBN7p67mm2GHSxEKknSWBgpuFa
	VBwvM3N8OCGntK3HasFL32v+uuI/2rrtm9W95LN2snJ3OwaDx+uUQb90vQSA4VA/92Yg93TC2md
	RTHrMH9v8o3hr6YA==
X-Google-Smtp-Source: AGHT+IHrlWRYqtYM79QJT4r0eaN0ZCB3vFfm2N8n/1p6ldMPPQXfKmGY8zwR1W0BfIco5ME7ff+YvQ==
X-Received: by 2002:a05:6a00:6c94:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7ff648ee293mr194806b3a.20.1766080591496;
        Thu, 18 Dec 2025 09:56:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe11856e88sm3266746b3a.7.2025.12.18.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:30 -0800 (PST)
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
Subject: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to failable
Date: Thu, 18 Dec 2025 09:56:11 -0800
Message-ID: <20251218175628.1460321-2-ameryhung@gmail.com>
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

To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
convert bpf_selem_unlink_map() to failable. It still always succeeds and
returns 0 for now.

Since some operations updating local storage cannot fail in the middle,
open-code bpf_selem_unlink_map() to take the b->lock before the
operation. There are two such locations:

- bpf_local_storage_alloc()

  The first selem will be unlinked from smap if cmpxchg owner_storage_ptr
  fails, which should not fail. Therefore, hold b->lock when linking
  until allocation complete. Helpers that assume b->lock is held by
  callers are introduced: bpf_selem_link_map_nolock() and
  bpf_selem_unlink_map_nolock().

- bpf_local_storage_update()

  The three step update process: link_map(new_selem),
  link_storage(new_selem), and unlink_map(old_selem) should not fail in
  the middle.

In bpf_selem_unlink(), bpf_selem_unlink_map() and
bpf_selem_unlink_storage() should either all succeed or fail as a whole
instead of failing in the middle. So, return if unlink_map() failed.

In bpf_local_storage_destroy(), since it cannot deadlock with itself or
bpf_local_storage_map_free() who the function might be racing with,
retry if bpf_selem_unlink_map() fails due to rqspinlock returning
errors.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 64 +++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e2fe6c32822b..4e3f227fd634 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -347,7 +347,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -355,7 +355,7 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
-		return;
+		return 0;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
@@ -363,6 +363,14 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
+}
+
+static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
+{
+	if (likely(selem_linked_to_map(selem)))
+		hlist_del_init_rcu(&selem->map_node);
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
@@ -376,13 +384,26 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
+static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
+				      struct bpf_local_storage_elem *selem,
+				      struct bpf_local_storage_map_bucket *b)
+{
+	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+}
+
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
+	int err;
+
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
 	 * the local_storage.
 	 */
-	bpf_selem_unlink_map(selem);
+	err = bpf_selem_unlink_map(selem);
+	if (err)
+		return;
+
 	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
@@ -424,6 +445,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -448,7 +471,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+
+	b = select_bucket(smap, first_selem);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -464,10 +490,12 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map(first_selem);
+		bpf_selem_unlink_map_nolock(first_selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
+	raw_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -488,9 +516,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
+	struct bpf_local_storage_map_bucket *b, *old_b = NULL;
+	unsigned long flags, b_flags, old_b_flags;
 	struct bpf_local_storage *local_storage;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, selem);
+
+	if (old_sdata) {
+		old_b = select_bucket(smap, SELEM(old_sdata));
+		old_b = old_b == b ? NULL : old_b;
+	}
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+
+	if (old_b)
+		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
+
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
+	bpf_selem_link_map_nolock(smap, selem, b);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
 						&old_selem_free_list);
 	}
 
+	if (old_b)
+		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
@@ -679,7 +725,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		/* Always unlink from map before unlinking from
 		 * local_storage.
 		 */
-		bpf_selem_unlink_map(selem);
+		WARN_ON(bpf_selem_unlink_map(selem));
 		/* If local_storage list has only one element, the
 		 * bpf_selem_unlink_storage_nolock() will return true.
 		 * Otherwise, it will return false. The current loop iteration
-- 
2.47.3


