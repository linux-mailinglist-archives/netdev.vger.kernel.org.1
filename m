Return-Path: <netdev+bounces-255649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKj3LKmSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE0C6CAC
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757B0300F9C0
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094D284896;
	Sun,  1 Feb 2026 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY256FMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B328280335
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968256; cv=none; b=Y5ZaTE64zFJmfxSjoglt/zmLk30trPvlx7Yfxi+8dMKn0rAB1MBOT44Eiv2DylCYEGsi5/1rCkduBNrndh7FnKan2eGJnB48O9+XYfah97XFHODo5AWYMcYmHeeF3vQ8BD084NozwP4MqdkKwBOhIrzyPZaVVZaOikolVOWCIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968256; c=relaxed/simple;
	bh=+qPw4038eS2y9kHNs6zcJcVnfSIT1Z4cjnQ1bz/GUeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHNyvhJdNnK1mAsQGk4oMlAUowrWg2jgxctYzC9fW8AytcIIEbH4RznNuC7zW8Nxnlgp3WW+Veam6qw7WIQBaqIqNgcUnyBjAeCY5CsuNeivL48dERY4Vt+HdSePrd5GrBkQnvI0TFYwqQMVDJpRLZm9+Qmz8wICRdXDik1zO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aY256FMS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07fac8aa1so27432455ad.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968255; x=1770573055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=aY256FMSBKW+o47a00gVj/1fNbC/7OYVjiDHBWZ1bc43Nq9HGs37ybCwR/VmPtOtkn
         g4k1f6lrY9/IzJlzGYfrtpmILEbGOk+ZnEN+uL9ZtUpxNRMP54ESw+09fhKGWdZCJQrx
         2L7ti+1x8pQIIWARv6RvbtfkmzMbt9AMoR9BXG25b6SwOfjnN/u2QssOF4o28cur9NR2
         wWvh7ljIiXbBn7sujA+QQ55RqgxnDMEBtwZtfncBsFqe8GbLfbjAQcQ6UBOVtUwSurLz
         yozjZOWWlZ4ypR/+zY5u2/X9lstzQ7RA1X/0IgODlMc4T2Cd6K/0Dex/W0s1JPBrXXa4
         vAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968255; x=1770573055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUj0HFkDrL7UYCdDezay2A0SQorq6cGviwCSfX9SRxA=;
        b=EOWKHEJuDZhxlgNtjKTofZ0ZP8sEeznqYCTCZHt+Fz8A5sxVz72/sb/w7rK0512ERX
         xVk7UhaHBBmHGOl+6hbdu6Dfv5wRfYd5zuwAJ/B/e0auXNZBH1fyuoaBaXM9sVLjoZPp
         enzLO6KS2KZbod2j1dpgJmA0QEY6fgPd7FlJBm/1rTk8Azv4blFDLu85QWRQSPymBXxR
         jwlhAvE3VndaW9x+mGb6iK7t6NtgJEIT/LXbgGNl+eNLZT3kpDbI75PHdsQXnWm+hZHE
         RCF88pwYe3WPFxFfLvpHRAXxLv/gLvxo37e+fOdArw3xFMEsQktyTHY/nuCj0bmhaveS
         fNWw==
X-Gm-Message-State: AOJu0YwwZHPSbCnjuxmltzBpazGIN2nJY7xLLVIaKO6qpvESTB90/tzq
	GXbHV1b4xXmO7fscJwuetMyezVL1JYPoqC4fxh2ZVRdbN/bFUxUZF96B
X-Gm-Gg: AZuq6aKoSdcwjJscD2iRypYeS4d3l/eR9qvRvQVsT8Fteujxf+kI23QVNutTdJl/gJi
	DHZE5RhdqR4+Og7LzY/NCKC/B2PnEi0mS0r2hP2fsLINtFufIC+u5YZP+P9vHf1q1u8obDPrxYm
	iR0EMbBWBK+fmIvalC5WuUbf901FL59xPcJ1uYlCslfu0QL2B5dmSxAVg62V9D8K3qR55KhNxaA
	VKu64UQdODLTSarcDlEwxlz2dk7W+nHljjugIiHNKP12Yf6pXX+w4GtggZ8cwsxptRxi2ze3tTZ
	Puma+Sa/bpumJAK4524wH3tiVpJRJNqGlAtvzIptzg0opKvBXdvdLoK34Cj+6Ce1YZnLT8n4V2s
	NHKfrTkhqXw/QTV5trcJH/tUZFFILX4tqdzde8j5Cq/labEflRfUkEVECM6OOK1iFie1cWH2itZ
	f3
X-Received: by 2002:a17:903:1104:b0:2a7:9ded:9b43 with SMTP id d9443c01a7336-2a8d7eedc73mr92205855ad.26.1769968254551;
        Sun, 01 Feb 2026 09:50:54 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eecc5sm130288655ad.17.2026.02.01.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:50:54 -0800 (PST)
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
Subject: [PATCH bpf-next v5 02/16] bpf: Convert bpf_selem_unlink_map to failable
Date: Sun,  1 Feb 2026 09:50:35 -0800
Message-ID: <20260201175050.468601-3-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-255649-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 25AE0C6CAC
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


