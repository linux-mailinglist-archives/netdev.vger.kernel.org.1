Return-Path: <netdev+bounces-227686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EEBB5901
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3503219C5FF6
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E0288530;
	Thu,  2 Oct 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZF7dgAi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CA126F0A
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445641; cv=none; b=EeCxCVen6rKJL484MdmN/eNVEY0Z8XfVulMCOQL0eHGwtQAmTlH3h5ix7oy8nTk1LvWT66SJ/Ccuc0oTM3HHEnPpJSF/e8W+pq1h555QrYWHLB5/Kz22K8kVFQe0cCbg61EhZ0aFOR9bDFIJi7J7jFG2MgdBcZG/Ii3A3YCLBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445641; c=relaxed/simple;
	bh=fG1YuI52b5BEc90LLlrZF2VWyj63t69/EC0cK4J+sKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONfdlFyDIfAKRlXWNiYkE8IfO1x3lj+h4HWG1afKIcdrgpqfRwTtmsksyyjtjNwPJ1kw5GzoR/xFenPf08OVYpfzcQ+DhTue4YI3uRXfSaKLokymkCAnDv6wPAedXmgDFm3XEiRVsCXkpnt50kbhTQEJeWtk9NKC2K0OYD0JMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZF7dgAi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1776391a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445639; x=1760050439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DTn3L9/UuOkcltPOJYswaA4ZGWd2YeJHE0d3yQetD8=;
        b=mZF7dgAixoGMXHPC2OrJv24Fa7TT9xi7lFSNF5MTnh6o7NIWhEnkU0M+A86l9sIlL8
         kWNyoH0nFTZVc6uSr9oybdwbZj2xsO0ioTrBIQsJBzzfWx+Fpn0lW+9MGVVx+Fbtg6Dz
         cgh+e8rE3EsaTUxcNJAjJGS5P0WZ3y4hABQvaZ3rdoXMipW4YJjS06f/dUz3lf6DKYDm
         VS1TTmu+qQL8ba8XZrTTgY9HGcLm8lEvXf7t//o01txn6JtVIBRRS9TzUD8L1m9w0Vkw
         hB6GU3EthAg6Ci7oMkvBqFmtcTgoitppovZVVW3TudZKx7vQlvTlv3jsp65UyaP2iONj
         YhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445639; x=1760050439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DTn3L9/UuOkcltPOJYswaA4ZGWd2YeJHE0d3yQetD8=;
        b=qNFAEKIdzlkO2S6RfIAm0vlCs9F8LL9p9UhS9BCdcYR9G3Al518Ccf7YLXrr0FbTZl
         6TGEic2yE3GBSIkjwy3tmQhXoOx2bShObft3tzVonHzfSnZpym8s7aCV0ajJtuI/c8SI
         8iUHOpNSipq3DC8YJL2yOAF1EdTCVu8dDAqzBRq69PfaCtbVSPEG6797c/4PId1xMb0P
         1Hf7Z4bf5SJorzIrnM/aJVaW26gtwFFyBCzKl2BFqkkAJ06HGD5EVWcHy+a0e+csLL3W
         3MMFhRv0XpQf+u3RDSJ3h9UVYk07BJQGNCRwdaXgegYj51VnYRCqJviRbBd+l4TgVGXo
         fmzQ==
X-Gm-Message-State: AOJu0Yyg5WzO+qD/ruFrx9KJkZUzzbU5/JMcsqmKNP8s0h3D13ci59v6
	4ZtoLfsbHjFSFjl6otA20oV1u81/mirbirKCUz48uN4+WLzV5TlTwmV+
X-Gm-Gg: ASbGncuzpviJP7tV6Ml0UWL0zgITQd6zmyH94yZ4Vbf+OuncNr5TuBq7WNMzd76o2kp
	6bL0ZEIMK2Zudl+St4HrPzdUS1AW0IXvLAoGuRwADk6pwr0ROJ3oWn0nhB82+hooBd/SpyrAUMo
	QrBNCrlgAaCVF04gzl0vk66NByBEXWMgGeMgUyB1QXty54+FyyyX/bO8e+5wCeK6EZZ+cw46FmA
	KVoicsyai33D3lMmkqC4jOmrWxzQmItehD4D4vu6qe+RXnS9lICa14CPbNWfflbvwU8Y1Uq7kw5
	aVy0wrt+w1Apig2GffB2NZ8ZxwPV8/w9m/8/2qYT2cEEmxwxM512rFZvxpYFZ4mUNmTHht/1l4T
	8sKWpO0jW9nBk4kj/wA8za7ZaBgz1yKF2RQcz9+1i7VhqSBE=
X-Google-Smtp-Source: AGHT+IFFH1Yye0wqvzEUNPJTmqr+fbfxZkCDwZiYtcBJcGMGv3jsoyH8HjVgJOywKtLR7kFmEhj/9w==
X-Received: by 2002:a17:90b:38cc:b0:32b:bc2c:f9fd with SMTP id 98e67ed59e1d1-339c276e82amr1128776a91.24.1759445639117;
        Thu, 02 Oct 2025 15:53:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad8dc6sm2860777a12.2.2025.10.02.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:53:58 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 02/12] bpf: Convert bpf_selem_unlink_map to failable
Date: Thu,  2 Oct 2025 15:53:41 -0700
Message-ID: <20251002225356.1505480-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
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
 kernel/bpf/bpf_local_storage.c | 54 ++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index e4a7cd33b455..cbccf6b77f10 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -409,7 +409,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
@@ -418,7 +418,7 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
-		return;
+		return 0;
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
@@ -428,6 +428,14 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
@@ -446,13 +454,26 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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
 
@@ -494,6 +515,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -516,7 +539,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->owner = owner;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+
+	b = select_bucket(smap, storage);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -532,7 +558,8 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map(first_selem);
+		bpf_selem_unlink_map_nolock(first_selem);
+		raw_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 
@@ -546,6 +573,7 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list under rcu_read_lock().
 		 */
 	}
+	raw_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -567,8 +595,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -652,20 +681,26 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, local_storage);
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
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
 						true, &old_selem_free_list);
 	}
 
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
@@ -743,6 +778,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
+	int err;
 
 	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
 	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, NULL);
@@ -761,7 +797,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		/* Always unlink from map before unlinking from
 		 * local_storage.
 		 */
-		bpf_selem_unlink_map(selem);
+		while (bpf_selem_unlink_map(selem));
 		/* If local_storage list has only one element, the
 		 * bpf_selem_unlink_storage_nolock() will return true.
 		 * Otherwise, it will return false. The current loop iteration
-- 
2.47.3


