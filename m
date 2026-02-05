Return-Path: <netdev+bounces-256991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAHPLZNAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-256991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB36EF385
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF215300847B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A9359FB3;
	Thu,  5 Feb 2026 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpsY8LVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA81359F90
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274933; cv=none; b=norpdzj66VIWtNJigGQWH9IXmgjqD+edrKaGbnCMlw9VgNEfEd8XL+1iBIzq0zl23xLxDrYb8m21dGohYQLhM05uQ7tIK0jc+Xcksk+X2gz44M+ERrn9ZLsSvu9C7xRKEYkh8GuzQ3dH8WGxINJLgTimf/+lzMZKFArgdM9H2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274933; c=relaxed/simple;
	bh=+qPw4038eS2y9kHNs6zcJcVnfSIT1Z4cjnQ1bz/GUeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmiiUMEU3qEF+9BjmkPOoPPbn4R4z8QnOjzIeMcIvTj9Gx4+wbAQHxHEVisJ6wm2rjqzKNIwRgLdIQihbtXYE9bVUZRHEzX/RQSW9cFWDHsvcpAgDQcWWqDqCrt2aXzQhEX7sdq6DcR7TaH6Zuj2jXEFpUoTBPwEhGOKkVMw5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpsY8LVS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81f47610542so473811b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274932; x=1770879732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=DpsY8LVSgMirlbas/p0fA94uXy2wiugsVCJ2ZEPBmetD7JRABN9aiEidiBu7uDi8mA
         Fy09lo/1mrG3XYT2gHN9IQtkt0MGY/B6VNH9f/ZkQFAD2atHW90m/nuA8GxF0LIskX5Q
         ByxeDJW1+cz0v35HGx6yCnDVNodM9j4lo0W2vvxBaWfN3k1qsWfsYYKMcZPlSS6YVN2V
         ZfgrZXHzOcd3iQ/zY8FdDK9JjAyD0dlliIrVClddvakCVw0MzQaN7q1pVK19ZDN3hi7f
         mKnQZYZ3TM2GN60f8tERQ/j2sceWSOEd3EmOEMaQktooq6ZWjKaf5BsTlHw0eDf5kfST
         0gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274932; x=1770879732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=obOfzh9ozz8Drd18DAW/yBBtWeRWD0OjifcF87e6NBxDHboiEddWi677kqbxTIOiGn
         8pfXkVZPjajKSFlRJoZfLyfsOu9UIkA5GYfzekAFn6y0xeeJPOdpV2Y7ta09KGtJG/W9
         obDsBfd8MqKFPTEFQMbZpTgkTVx79fdftSll0ymRe5LMQgyBTI36XD+NcZzqk17pu9ms
         qJ6Y9bJDi13PkkomciWTDegCDe7QX/o6l1BObSc3ws08ckDyM0ilrJOl2y5w/SWBj6LQ
         cYwssR7Wb7BVQKdML+s0JLkKrtdow+VG0L5U4frwzsiA2yYBpPZOeV6VIu00HNS2BcKm
         hXew==
X-Gm-Message-State: AOJu0YwpLhTS9GrkydFF98HOIf4t3S47XblDEYrOtG3Jwgd6GWKv1Fz5
	fW8T0nkWGDDsQVQkUldirDjGsT2bYwCX5lvdcrGCeIGo3wZR70EweqIS
X-Gm-Gg: AZuq6aI9qGDSy9fjMnLYylnRQAReJuunT5z7Ldt9aTThMcKJcsPpPktS5FpSV38bNHt
	uuSmkbdZSuaLv41D6t5ACmY2ro7Is2NRLMeqH9NxoC9VgcG7QH4hwxTnocMe0PvkL1rfqlplcic
	u0Ulf2HIV7oWoLYbfLR1ZiAuygWVDf1KfMVsw1/JJJG1SZyOSqoS8FAj7SpQGKALnphpK1ZNqFX
	+suJucTM80GV3LQ0/ZbEg/9v/jDPTDHbc8iCupL41Jh/QDc+kR3DD7VoTaYFTnEyDHSq7yajJ/4
	Qlp/MH8ebbB9SyG/K7BSSKnk0tKnN7SnNF7fGK5jzUIg65lHgi0Yxn+jKQOX9VrjiCdjwg0TOH5
	NL67vCt+QphX397AVOaarVCMtZ3ZudtVX5OJ4XvnjtRqoALHIruCPsTTB9iUeDG5zM/dmv5q9uF
	uHeA==
X-Received: by 2002:a05:6a00:12c9:b0:81f:3c5b:f437 with SMTP id d2e1a72fcca58-8241c2c42c1mr5211180b3a.35.1770274932357;
        Wed, 04 Feb 2026 23:02:12 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d45b996sm4360533b3a.45.2026.02.04.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:11 -0800 (PST)
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
Subject: [PATCH bpf-next v6 02/17] bpf: Convert bpf_selem_unlink_map to failable
Date: Wed,  4 Feb 2026 23:01:51 -0800
Message-ID: <20260205070208.186382-3-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256991-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBB36EF385
X-Rspamd-Action: no action

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
Remove the selem_linked_to_map_lockless() check as an selem in the
common paths (not bpf_local_storage_map_free() or
bpf_local_storage_destroy()), will be unlinked under b->lock and
local_storage->lock and therefore no other threads can unlink the selem
from map at the same time.

In bpf_local_storage_destroy(), ignore the return of
bpf_selem_unlink_map() for now. A later patch will allow
bpf_local_storage_destroy() to unlink selems even when failing to
acquire locks.

Note that while this patch removes all callers of selem_linked_to_map(),
a later patch that introduces bpf_selem_unlink_nofail() will use it
again.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 91b28f4e3130..5f7869078c4f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -61,11 +61,6 @@ static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 	return !hlist_unhashed(&selem->snode);
 }
 
-static bool selem_linked_to_map_lockless(const struct bpf_local_storage_elem *selem)
-{
-	return !hlist_unhashed_lockless(&selem->map_node);
-}
-
 static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
@@ -347,25 +342,28 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+/* Only called in common paths */
+static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map_lockless(selem)))
-		/* selem has already be unlinked from smap */
-		return;
-
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
 	raw_spin_lock_irqsave(&b->lock, flags);
-	if (likely(selem_linked_to_map(selem)))
-		hlist_del_init_rcu(&selem->map_node);
+	hlist_del_init_rcu(&selem->map_node);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+
+	return 0;
+}
+
+static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
+{
+	hlist_del_init_rcu(&selem->map_node);
 }
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
@@ -381,13 +379,24 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
+static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
+				      struct bpf_local_storage_elem *selem)
+{
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
 
@@ -429,6 +438,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -453,7 +464,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, storage, first_selem);
+
+	b = select_bucket(smap, storage);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(b, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -469,10 +483,12 @@ int bpf_local_storage_alloc(void *owner,
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
 
@@ -494,8 +510,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -579,20 +596,25 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, local_storage);
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, local_storage, selem);
+	bpf_selem_link_map_nolock(b, selem);
 
 	/* Second, link (and publish) the new selem to local_storage */
 	bpf_selem_link_storage_nolock(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
 						&old_selem_free_list);
 	}
 
+	raw_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
-- 
2.47.3


