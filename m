Return-Path: <netdev+bounces-255346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALirD7aOfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4556C0AED
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A94B3023342
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABD32ED28;
	Sat, 31 Jan 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFN/BOpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE423242B3
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836166; cv=none; b=lSnNtWbKLay+Gqub20gzNFcX4PtyjFBW55xFIbyQ3wv1Cy4xVQiaRM1adTJYgcxYJRAr1gvZW89XKhO6k4SdaQTLgXYM3djNcM90uB++4FrhWAYj7PBtSmfhBADINMT+ExVQLB0upMc8zkL8FxKLPRSaxtHcOdhvI6KcyQwUln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836166; c=relaxed/simple;
	bh=HKyxJh/TE9weNh9hBUS8dcLutGo6BFBn3cFPQyoN+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJqhIQv1VnfbAvwkouyltWv6MUBtGVK2Z+OuQkqJNS+jYSxft0KEUNIEr5efD9C317Rs1FsMUZjNhIUon4retGz9exqrbmBhbS8rSYqoHT3H2wqViy5G6ANCud9NrqTJB7/GSkx9fG69p4+5L9YRsoVOaRYhuyXwbGaEPZaxJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFN/BOpR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so1515804a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836164; x=1770440964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA8gq9rHoGvEhlwYo+zpKmTWxRaKvI/zuKbxDRSjsYM=;
        b=eFN/BOpRdCPTE+kIpGOHpcrZN5p08sknqblgmjE9p4j19ip6xRNFf88yIc1GbfnHef
         iW0vSCEid3P69cLesUyr+q51/vxVjb9BFUHo3exH73OpU7qqckMm0lJwDez86Q3nffAS
         aJiiXPBDKS00ctHFSDrmqJ/5yUhuBKR5/wgb+wd4IJjZhIFlq4lYEv+W5JL1vmFPy0CA
         sWq8/Dj6yp7GGFYb7ZQGlztN1Lepyd0Bc7oE0PhXX8MlSqlw5XrUy+wiVSpFEf63L+0c
         5ajBzrRvk/Mv8WyJeFX51H2FWvj/2Uhb38idKnHtAXYxyjdaGgoOIIS8DDPdmrDNsqwx
         IjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836164; x=1770440964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kA8gq9rHoGvEhlwYo+zpKmTWxRaKvI/zuKbxDRSjsYM=;
        b=Bp/QwHGT79gU+uZwHStSfl8FEo6yqPkzTmGGUq2FDximr2s2wWmAMLknzwgGsQm5Vi
         P0q19TA5dUBH9l9Ft7mrILwRbdM/iOf7O57tLP2rTv9ovUtzeADtz7UrdgTjgYn64oH2
         +a3B/DzP4B5cgiHU6/zckOxBKrJYZX+e//4jL0zq5w81UhlLTPv2tumv59BNAn45BuG5
         AOKslhos5t4vikAhKklzKvqyuDaYi5k5O+ZD1hqHfo9ESEKqK3IswVz/UUekmxesAdYJ
         tfzujPg6YpR7WYE0DsseiDk0Ni9BbB5w2KJ0ErYKcpLNG5pNUZQT5lO1esR/XvUYrRYt
         RwbA==
X-Gm-Message-State: AOJu0YzQA+z/HY+LVP727TLmxUAUVox/PM0YNBL+0VrD+7OFYCtQo+SQ
	ujeXlFIl6iIoja197iZ+cTuhJj+pLqY81RDBE/+3Ugooptgejc+dvTQt
X-Gm-Gg: AZuq6aIt3zZNzlsXA7TS+4kM57NsCrBhfx62qseBmJwOTyqfHYLWAMZYgIPHkeCgQs3
	dHZSdsJLV6luoxrRn2zf9dqXvc3jnaVt/kY67I7QxNBIRWe3EzTH7y0EOENMOlsi/mmA7KuK/x4
	byFRrh7x7oWz4Yup0T1byOWJVCbSwvHWxQ7fIbyIex9uVtdOqWjm12uEl2Kf4sLPmq308P+iD8j
	6oaqyjNKvrhrtkBFGc4hCEfDRQNwDA5dSwz2EKqFgKTXAZ9ZTxfzcqWRojqcLK1MLqopK1yuiCM
	AEX9qjq4hrWDjZzwxzvZNPFrUtjMspS5QzcXtZrb8o5cDYSLRfqdJa3C/J0f0od2IINZMX8pt8G
	K2W86puLgXYCDklMSiif+onSnQgBaX6yFu9BNZ99yZRaAoZcfREPJrJks0SuwqzVGOLY1mComOI
	yqeQ==
X-Received: by 2002:a17:90b:4ec5:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-3543b3ee220mr5291804a91.35.1769836164139;
        Fri, 30 Jan 2026 21:09:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543bef5782sm1483411a91.3.2026.01.30.21.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:23 -0800 (PST)
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
Subject: [PATCH bpf-next v4 02/16] bpf: Convert bpf_selem_unlink_map to failable
Date: Fri, 30 Jan 2026 21:09:05 -0800
Message-ID: <20260131050920.2574084-3-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255346-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C4556C0AED
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
commom paths (not bpf_local_storage_map_free() or
bpf_local_storage_destroy()), will be unlinked under b->lock and
local_storage->lock and therefore no other threads can unlink the selem
from map at the same time.

In bpf_local_storage_destroy(), ignore the return of
bpf_selem_unlink_map() for now. A later patch will allow
bpf_local_storage_destroy() to unlink selems even when failing to
acquire locks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 58 +++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 6615091dd0e5..1916ea2aee4b 100644
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
@@ -383,13 +381,24 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
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
 
@@ -431,6 +440,8 @@ int bpf_local_storage_alloc(void *owner,
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned long flags;
 	int err;
 
 	err = mem_charge(smap, owner, sizeof(*storage));
@@ -455,7 +466,10 @@ int bpf_local_storage_alloc(void *owner,
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
-	bpf_selem_link_map(smap, first_selem);
+
+	b = select_bucket(smap, storage);
+	raw_spin_lock_irqsave(&b->lock, flags);
+	bpf_selem_link_map_nolock(b, first_selem);
 
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
@@ -471,10 +485,12 @@ int bpf_local_storage_alloc(void *owner,
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
 
@@ -496,8 +512,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-	unsigned long flags;
+	unsigned long flags, b_flags;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -581,20 +598,25 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 	}
 
+	b = select_bucket(smap, local_storage);
+
+	raw_spin_lock_irqsave(&b->lock, b_flags);
+
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
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


