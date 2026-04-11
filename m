Return-Path: <netdev+bounces-277643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBmOMDuq2WnGrwgAu9opvQ
	(envelope-from <netdev+bounces-277643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:56:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A43DDEBA
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED92304E0F1
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FED2571A0;
	Sat, 11 Apr 2026 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B260CKWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089A2773F0
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872466; cv=none; b=PNo2g3vBUWSvbGUQo1VxAzo7Ide5B2NjjBpjlsuivusPm0M7JIjB+jYL9ftWtwiixQnRZSwG7G8qs2sw0/qdNHJZW7f1LNHaU8ngpXTfxg5NliiTAY8V2ZsstIJagx7Rt5kDmbPSXcYSk/p0r/vsmqIqJ3YHZXHJzC+yB76Rs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872466; c=relaxed/simple;
	bh=zN6vuZ9+XkQ9oLJL8FbDpm1zCyCSSppsXwMuzRvBsK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHQzb7Hc1rft4r1k/mTmLIlC53fH2x3ny2ucNCTlQerIweuVytedQtjIZwQsNvLkT1DrJb7NWU9bDK2wkyCHtMo4NG8kKLlgjiFtliidbudo5JIwTpg8xJozgZLAMiyXhHiYw9YM6RFhUFDcZWhessIDnpAFZaGZRMYPVungAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B260CKWT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso1698811a91.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872464; x=1776477264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDprD4bQn21rnOeoSrVphrHghr0odjH32BGymAKfpnk=;
        b=B260CKWTqDpZDus7QmTRdGWqEPUi4QRqpVN5mVUh+M4pPTjHU3McOUPzquftK85Jo3
         7iprYlo2HWzJmIxCriqW7uF8Phl0dsvPrh0DWUoiJt23ZQ3CzFMg+XVG4TPcQzE5Ry0e
         bpQ4QHq7DBs0nOgbDDjMb4Fp6da+Go6ri/bA5MizPGozJkgOYtTz9uQRCKfPiJpZJIDW
         Mi9HNDn9p54jK/eYHyrTJJkPY8plAj2Oy23SuPgirOeh36jcuxhNGXH4fALAxMtk/pGU
         shuCWHWg1KDvJ7T7OSAP6alDhMG4RGz4h1OPeH2Ti8WRvQpr09MMDVTi3Yy2HGpBFFBJ
         pdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872464; x=1776477264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDprD4bQn21rnOeoSrVphrHghr0odjH32BGymAKfpnk=;
        b=mv/NwqiC+vpQYtd9HdpRIRk24PzsYGa7EtMdPirX7tPO5vg7zRZ10tTYT+TzxKAeG0
         oQvJMDzeA04tGyPkRoldbweYoYQ3vUl/cirJ5k9sDwuiFDccDxaqlNkOyDKx/0WyN9HM
         ly8A8yIXV26B3NWo+xsSSm0fN2mq1aXbnA/Xc8KoyR2WrCDwwgrfSlg+shtbWoqdGgFs
         /PfP1BzhfOLSa1QY9cP4ytp8itLSlYRusZ3Jz0U3v/C+HxpSoskdELKn3XrjNwseYel6
         bxYe890AuTscGm9uoHQYKTTLWm+iaXbRnDThechZ93F5+mgC1jE4NDDLGa56cD97u8Vh
         jVVg==
X-Gm-Message-State: AOJu0Yx0kZzhRL1Cs/+PjfFAtJDPjnapZU5PszXM1Qj14GAWB4C60gMk
	zSIADNyIwtq4RdbvhYXaWMGjg1uz76IeucpJnOjBjDkf3ZZOQptbuz5P
X-Gm-Gg: AeBDiet+NB7A3+83AXOP3DtmWJMxMutNgckb+w7y0zZxJ2YOIwZjBEF85O9htdH8tmC
	TA0C9ZmHvtoIz+ojR2XBZkc7LTXB8AniCv5cViOmWempoi2Vkf0srcIxm8zsofhG8Du76gkmOEW
	SvUxK49J8NU36AAndbXqUhsuszcRLQPCN2Nem1d52auP2MiPwF5qzLYdtF/ZgR4KmTPw7M2eyF1
	YCexwJKkHACXskRBraP6iZGznjLAKhi2Lo0pDJUuQw3KHi5tEne9z0F+kP/WVTvyyLoo/E2laUA
	5OeVXWbKC0MYaeFk7126w4C6vlYS/bwYneRXLHtnl4t5FES8hr2pLEwU4Lxb63GCMvHpfVIeoip
	uz9JONOAFH6ikY8ZNzEv/WxgCxn3rcSz3YsUKvIXxVD/ZE9h3RJzQB8+oyshh2oj8Kq1KiWenCC
	/IXsSYKFS04LZuzA==
X-Received: by 2002:a17:90b:2683:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-35e428490dbmr5545219a91.29.1775872464110;
        Fri, 10 Apr 2026 18:54:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08d1bsm44100655ad.54.2026.04.10.18.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
Date: Fri, 10 Apr 2026 18:54:18 -0700
Message-ID: <20260411015419.114016-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411015419.114016-1-ameryhung@gmail.com>
References: <20260411015419.114016-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277643-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B7A43DDEBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the check that rejects sleepable BPF programs from doing
BPF_ANY/BPF_EXIST updates on local storage. This restriction was added
in commit b00fa38a9c1c ("bpf: Enable non-atomic allocations in local
storage") because kzalloc(GFP_KERNEL) could sleep inside
local_storage->lock. This is no longer a concern: all local storage
allocations now use kmalloc_nolock() which never sleeps.

In addition, since kmalloc_nolock() only accepts __GFP_ACCOUNT,
__GFP_ZERO and __GFP_NO_OBJ_EXT, the gfp_flags parameter plumbing from
bpf_*_storage_get() to bpf_local_storage_update() becomes dead code.
Remove gfp_flags from bpf_selem_alloc(), bpf_local_storage_alloc() and
bpf_local_storage_update(). Drop the hidden 5th argument from
bpf_*_storage_get helpers, and remove the verifier patching that
injected GFP_KERNEL/GFP_ATOMIC into the fifth argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  7 +++----
 kernel/bpf/bpf_cgrp_storage.c     |  9 ++++-----
 kernel/bpf/bpf_inode_storage.c    |  9 ++++-----
 kernel/bpf/bpf_local_storage.c    | 16 ++++++----------
 kernel/bpf/bpf_task_storage.c     |  9 ++++-----
 kernel/bpf/verifier.c             | 26 --------------------------
 net/core/bpf_sk_storage.c         | 21 +++++++++------------
 7 files changed, 30 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dced54e9265f..9e4f5c45c974 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
-		bool swap_uptrs, gfp_t gfp_flags);
+		bool swap_uptrs);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now);
@@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 int
 bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *first_selem,
-			gfp_t gfp_flags);
+			struct bpf_local_storage_elem *first_selem);
 
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags);
+			 void *value, u64 map_flags, bool swap_uptrs);
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index d93ac2866748..c76e9b0fabba 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -76,7 +76,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 		return PTR_ERR(cgroup);
 
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-					 value, map_flags, false, GFP_ATOMIC);
+					 value, map_flags, false);
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
 }
@@ -122,9 +122,8 @@ static void cgroup_storage_map_free(struct bpf_map *map)
 	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -143,7 +142,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-						 value, BPF_NOEXIST, false, gfp_flags);
+						 value, BPF_NOEXIST, false);
 
 out:
 	return IS_ERR_OR_NULL(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index efc8996a4c0a..0da8d923e39d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -98,7 +98,7 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
-					 value, map_flags, false, GFP_ATOMIC);
+					 value, map_flags, false);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -122,9 +122,8 @@ static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 	return inode_storage_delete(file_inode(fd_file(f)), map);
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -150,7 +149,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata = bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index bc687b9d25a9..6fc6a4b672b5 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -68,7 +68,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool swap_uptrs, gfp_t gfp_flags)
+		void *value, bool swap_uptrs)
 {
 	struct bpf_local_storage_elem *selem;
 
@@ -475,8 +475,7 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem,
-			    gfp_t gfp_flags)
+			    struct bpf_local_storage_elem *first_selem)
 {
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
@@ -546,7 +545,7 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags)
+			 void *value, u64 map_flags, bool swap_uptrs)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
@@ -563,9 +562,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
 		return ERR_PTR(-EINVAL);
 
-	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
-		return ERR_PTR(-EINVAL);
-
 	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
 					      bpf_rcu_lock_held());
 	if (!local_storage || hlist_empty(&local_storage->list)) {
@@ -574,11 +570,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
+		selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
+		err = bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
 			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
@@ -608,7 +604,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs, gfp_flags);
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, swap_uptrs);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 55f4f22bb212..4b342be29eac 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -118,7 +118,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
-		true, GFP_ATOMIC);
+		true);
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -165,9 +165,8 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -184,7 +183,7 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		return IS_ERR(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 566311dd4fba..c44d81bfce2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -589,14 +589,6 @@ static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
 	return bpf_is_may_goto_insn(&env->prog->insnsi[insn_idx]);
 }
 
-static bool is_storage_get_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_sk_storage_get ||
-	       func_id == BPF_FUNC_inode_storage_get ||
-	       func_id == BPF_FUNC_task_storage_get ||
-	       func_id == BPF_FUNC_cgrp_storage_get;
-}
-
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -24414,24 +24406,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto patch_call_imm;
 		}
 
-		if (is_storage_get_function(insn->imm)) {
-			if (env->insn_aux_data[i + delta].non_sleepable)
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
-			else
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
-			insn_buf[1] = *insn;
-			cnt = 2;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
-			goto patch_call_imm;
-		}
-
 		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
 		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
 			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 9fb22e352beb..14eb7812bda4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -106,7 +106,7 @@ static long bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	if (sock) {
 		sdata = bpf_local_storage_update(
 			sock->sk, (struct bpf_local_storage_map *)map, value,
-			map_flags, false, GFP_ATOMIC);
+			map_flags, false);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -137,7 +137,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, false);
 	if (!copy_selem)
 		return NULL;
 
@@ -202,7 +202,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			}
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
-			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
+			ret = bpf_local_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
 				bpf_selem_free(copy_selem, true);
 				atomic_sub(smap->elem_size,
@@ -227,9 +227,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	return ret;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -250,7 +249,7 @@ BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata = bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, false, gfp_flags);
+			BPF_NOEXIST, false);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -383,16 +382,14 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	return false;
 }
 
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
-	   void *, value, u64, flags, gfp_t, gfp_flags)
+BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
+	   void *, value, u64, flags)
 {
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
-	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags,
-						     gfp_flags);
+	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
 }
 
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
-- 
2.52.0


