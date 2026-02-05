Return-Path: <netdev+bounces-257330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eWUYAPkZhWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1407F8139
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E923034DC6
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E4337699;
	Thu,  5 Feb 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvVqlW0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1511337B9C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330561; cv=none; b=MzmWeJdhjOZSn1NB4tOEGqVnwV7rPyto9QLKnkyTNPysQ2ydFfOjUAWS9uuZ/MkOvfjYoGQAXUAVyQn4XUdJVr5JpXRw8i96+m00xPwaPs/CROYYIFl0upjYWW7+hnI5nBaxyOZuMd+IBNY/gzVOBXK+uGHghjVExlsGVR1mIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330561; c=relaxed/simple;
	bh=cEJWShfTQldZSJBXnR+JnnQboKhpw3f4nHdCn7wKrME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKBwCPILOht5nTv+70oO7NtHWR+LibonDafE9mcboiReZxCIYTOPfFbRTay7c04bSybp7G7G2JE1zAJkC+8H3b2/ZwUoTy/SV/OciMLe8z8shWGX9wOjIgOEHGIAG2heTigknL4rcfPsE9xem0m3TyWq/T/YRTyy4F77hS99gIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvVqlW0K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a743050256so10387325ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330560; x=1770935360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erdtvjKomL8ymRcjF7aQTU8XY3ytmUzoMZYhmeUhK0g=;
        b=FvVqlW0KkHOMX+J52naK9ZG4PknG5JC8OgZncRX9ro7QWuAXIayG4c5HrFP378mEMU
         1uUKTH3gwlnFDk+yjR8oO3zxXskYLBvvJiQfu8EywIv+9cO+K/JzHlWPDxmReebV4rLw
         yvCZ2r6tic0Lk1t02xqMk6amqbFRDl3LPe8fksZjyX4Vw4gFw1ix4zlBOHnEx6xCM+7x
         vK4JNvqy5fj0BiXmSxCBXd78tfGtO2o0YE+6kw6aKj/VkF9JFXFWd1trZfAkJBM24ee1
         aNBdkk7a1gYDs9eOguq7koNIdZRltJMZMrySg8YvTsA45NIM5AVP0E9DHngbqmNCz6aJ
         5Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330560; x=1770935360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erdtvjKomL8ymRcjF7aQTU8XY3ytmUzoMZYhmeUhK0g=;
        b=hKR8plLGNqEuIxVhYPoi7w7F/jYMK9ovcdVzeSDnuPE299irn9GXIe6AiHZ+Aa04Kw
         ZFTd0It22+XPqGbgqHBeMCYHgFVcJlRUzu9T7e9PEc3gUZP282i6JNKFuFegHn6h0zTE
         aqFBM7vUxsDcXC6LWOe3QzWmkF9mmmKiV08JUJR2K5inHM0oddOnOWF4ZjM9TrS6pAx+
         mq4PO3paAxoPqZeQXnLF0fXxC0tKrE2b5ysTode2Z2sDNxBd2d6hUXYSOwjWq6YVg2J9
         aTLIFGyDIsXaNlTPYgcWNn1d7pstX+2asF1cx+D+h6DZ9k80pdWCmvhiEMKifvi4w+9I
         9caA==
X-Gm-Message-State: AOJu0YzUK/gSGGm5lvos6jB66O1jjcUlDqjBjOy9RAXVIGkEAB/DFQkd
	4FHCkQ7hOD+M5DSbwmore+sVItAG6rLYL/It0SJkRzptVeHoOTTr3xiD
X-Gm-Gg: AZuq6aKG72wJr1X472wDys4Dd7/HWJa/ltkUopvpUIc9VMOllhSauAgzhWMoTyFh0o9
	1CfNc9eFr3/wxMOmVEkIY4A0SxpskOiMYj9ecKkBNB0ZUQzbyGY2QrdctqEIDgaKlOesTFaa71W
	RBoFPiBj5RybhiyT1OMUVb/QHEVRQoor43j9mjl5KS7lbLNnTiOUOwSl5I90ju99Rb+ZNTuPuz4
	d+oev0nUjBk1M/IKSSdvqzMkK8QJiyetsQ02ZEHjK7+qErveeYgCksVISXly9F6cpcsBZRsuPYB
	SOuEtC7Xnx4GmPO7gQMsyq1CYxQ4OW7FQ4Z5WcHBHK44iX/oxei9oloZH9ZUJddLV3NGwec8k7k
	e0HU3/jMkWlhUPKRqQbGeyK/9QwgsA9KwToA0FUAPF2MxM3b1HH+SC2BmiwjXm1eTcJkYBOpUen
	Mk0w==
X-Received: by 2002:a17:902:f788:b0:2a9:4ba4:1986 with SMTP id d9443c01a7336-2a95167551bmr7865675ad.6.1770330560278;
        Thu, 05 Feb 2026 14:29:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f3b6asm3673405ad.77.2026.02.05.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:19 -0800 (PST)
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
Subject: [PATCH bpf-next v7 02/17] bpf: Convert bpf_selem_unlink_map to failable
Date: Thu,  5 Feb 2026 14:29:00 -0800
Message-ID: <20260205222916.1788211-3-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257330-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E1407F8139
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
 kernel/bpf/bpf_local_storage.c | 57 +++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 91b28f4e3130..6fa71502c7d7 100644
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
@@ -347,25 +342,27 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 	hlist_add_head_rcu(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
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
@@ -381,13 +378,24 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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
 
@@ -429,6 +437,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -453,7 +463,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, storage, first_selem);
+
+	b = select_bucket(smap, storage);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(b, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -469,10 +482,12 @@ int bpf_local_storage_alloc(void *owner,
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
 
@@ -494,8 +509,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -579,20 +595,25 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
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


