Return-Path: <netdev+bounces-277642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODnILziq2WnGrwgAu9opvQ
	(envelope-from <netdev+bounces-277642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:56:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2183DDEB3
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A361304D152
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502627816C;
	Sat, 11 Apr 2026 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqBmDj+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81963280CD5
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872465; cv=none; b=Tpep5bbnoHy78XuDeXGYTBurLZnGWdIbKfc3oJQ6ruW1yAMMwtFqKXM0P7h1rPk7f9kHVWCMj/GyEMg3GYXdEPOsdmv8eAIqKPDT2q3GFHgRHZTVpIPCqu2GTwwwR0SLInbCFDbKRqy904fSiggWOI2f0P19IOyU6xPiyKBS4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872465; c=relaxed/simple;
	bh=LhJQUTCEN/kaSUh5Ak79x59zmsLUgvvgugOBBuXCVWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8z/ThtsMOBcCy64kXqJEN7rKNXGWFsSggJ2DzHuOQ5DgZDYBviWM8L74kJwAnMYjquCkpnefjPrrbUwL57akRLU84jtlMAH90440mUz281lddgXLo9SvU+ocmWzd7uWgRC7AkWx6COxtXXfRAEDprq0zPCZHaw9KOWr5i9nDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqBmDj+C; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2541583a91.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872463; x=1776477263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paGHF+ifsElwT5XkicIeEYcvV8dviWMxDUlDCz2m3v8=;
        b=iqBmDj+CLD8J+fgnJBvTHNLl81slKOaHr8kvnlhP1kDLcrC3xZOmkAH22BeoCf3DBI
         6Fmz4akhTJWcGvglB0x5saknLslRqwq/OLeFEss4KhzXz3lqyuo2CjkKeGaxJK7pJB9P
         8TFSmDCRfvxiQeAD/k/7iqeR0NgLqfzz//hrNKpOPUYuhl1aMxDJ4kSxN6jR3r1jW7yO
         ilWZHrsoMYh3mEaNhm0XjkP9UPD4oYLFgncGsUTdZoHJ62BhBX+AbBsB7yL6aLk9qG9x
         sCBT2ILHw4y9+mOrESELiOlcpmYJx6+fK2CZ1iK5KDnzUMs6xCKdJI9wd0dhRIoi8Wj3
         RiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872463; x=1776477263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=paGHF+ifsElwT5XkicIeEYcvV8dviWMxDUlDCz2m3v8=;
        b=Byx5bp/W5uECj++NgktL6vRD8M0MRxDeD/E8nu46tdetwbCvG2aRlJ4nlHBW89gFbg
         UHeP5aB3VtU6YHY7j2cG5MJV93JnxC9Pccm4UUV5pb1MYr+aCe7z6AY81nucvOWk1koH
         UZzDW+vnSQsPK1lSBaukX8EULHd1OlNt9lEg0a7w8bTV34nLTrPZxqV9eRe9LOUfbbz9
         1Xd6VSMDqoIOgLLfYD7xGD7pb/bwh9WxrxwIswikS7ptlpd8hVGA2gFgTZbgr3qK2QL3
         yv4wLzazLb42b8RM5WxxWv/OMg2cz/duprokwDVnjFHYM2FkA8uxFOMrTIKus/J7tuqy
         EtAA==
X-Gm-Message-State: AOJu0Yyqu98rfqbU1hc7gsXJiM8WSZMANegfH7MdOWbRTQMCVeBjSBnq
	7oll+bT+pyC4Pf4Jagk5pmWuqWDsAnwsvRYLsdJVjxFmUiUbcGs3ByOK
X-Gm-Gg: AeBDietUSRsAZ5mKbyfB0Mk9BQa1855PbywbOyORq7CCryJx4sp5yo/vFgNMB+fhEwA
	C3rFYxfhA8eLVB8mv7nPavioByKstrmZnLtd8BsD/2TS+ri+S50LNAim+5uFv8hcTvBvXEO32LH
	hCDQKFK92+RTU4Rps+phv5GsXxbKeJMz6ILak767td5trXJ1pBNYvhwjlkFt+QG6dnNa72b7U74
	8abb1ecxMjS73RH1IN4VvVBZlG5NVoHRv76wwzjbuWsvgQ+Cb+IQvc7xCdj1IoXp68O7Nn2FLb5
	ScKVpywjdVZjT/dec+b7luZwRnjX1Q0w36thdp7w96toC7ZVaQb956S25XD0Q0TmomB50viFToR
	nop8c7J4ZDVrTqjrwKsR/FWP2E9vSwK3vHMyQGQrQk2d7Lbig8v04zfGYFEbRrxiNQ5gKDxXc6W
	X6uxZN40BPgcMBTg==
X-Received: by 2002:a17:903:3692:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2b2d5943481mr39432165ad.6.1775872462782;
        Fri, 10 Apr 2026 18:54:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3b65asm43850675ad.76.2026.04.10.18.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in local storage
Date: Fri, 10 Apr 2026 18:54:17 -0700
Message-ID: <20260411015419.114016-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411015419.114016-1-ameryhung@gmail.com>
References: <20260411015419.114016-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277642-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D2183DDEB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to kmalloc_nolock() universally in local storage. Socket local
storage didn't move to kmalloc_nolock() when BPF memory allocator was
replaced by it for performance reasons. Now that kfree_rcu() supports
freeing memory allocated by kmalloc_nolock(), we can move the remaining
local storages to use kmalloc_nolock() and cleanup the cluttered free
paths.

Use kfree() instead of kfree_nolock() in bpf_selem_free_trace_rcu() and
bpf_local_storage_free_trace_rcu(). Both callbacks run in process context
where spinning is allowed, so kfree_nolock() is unnecessary.

Benchmark:

./bench -p 1 local-storage-create --storage-type socket \
  --batch-size {16,32,64}

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. There is no measurable throughput change for socket local
storage after switching from kzalloc() to kmalloc_nolock().

Socket local storage

                 batch  creation speed              diff
---------------  ----   ------------------          ----
Baseline          16    433.9 ± 0.6 k/s
                  32    434.3 ± 1.4 k/s
                  64    434.2 ± 0.7 k/s

After             16    439.0 ± 1.9 k/s             +1.2%
                  32    437.3 ± 2.0 k/s             +0.7%
                  64    435.8 ± 2.5k/s              +0.4%

Also worth noting that the baseline got a 5% throughput boost when sheaf
replaces percpu partial slab recently [0].

[0] https://lore.kernel.org/bpf/20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz/

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   8 +-
 kernel/bpf/bpf_cgrp_storage.c     |   2 +-
 kernel/bpf/bpf_inode_storage.c    |   2 +-
 kernel/bpf/bpf_local_storage.c    | 130 ++++--------------------------
 kernel/bpf/bpf_task_storage.c     |   2 +-
 net/core/bpf_sk_storage.c         |   2 +-
 6 files changed, 21 insertions(+), 125 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d4..dced54e9265f 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -54,7 +54,6 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
-	bool use_kmalloc_nolock;
 };
 
 struct bpf_local_storage_data {
@@ -86,8 +85,7 @@ struct bpf_local_storage_elem {
 						 */
 	};
 	atomic_t state;
-	bool use_kmalloc_nolock;
-	/* 3 bytes hole */
+	/* 4 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -104,7 +102,6 @@ struct bpf_local_storage {
 	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	u64 mem_charge;		/* Copy of mem charged to owner. Protected by "lock" */
 	refcount_t owner_refcnt;/* Used to pin owner when map_free is uncharging */
-	bool use_kmalloc_nolock;
 };
 
 /* U16_MAX is much more than enough for sk local storage
@@ -137,8 +134,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache,
-			    bool use_kmalloc_nolock);
+			    struct bpf_local_storage_cache *cache);
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c2a2ead1f466..d93ac2866748 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -114,7 +114,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache);
 }
 
 static void cgroup_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e86734609f3d..efc8996a4c0a 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -179,7 +179,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
 static void inode_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index cad17ca8552f..bc687b9d25a9 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -75,18 +75,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	if (smap->use_kmalloc_nolock) {
-		selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
-					       __GFP_ZERO, NUMA_NO_NODE);
-	} else {
-		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-					gfp_flags | __GFP_NOWARN);
-	}
+	selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
+				       __GFP_ZERO, NUMA_NO_NODE);
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 		atomic_set(&selem->state, 0);
-		selem->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
@@ -102,8 +96,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
+static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
@@ -115,47 +108,14 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 	kfree(local_storage);
 }
 
-/* Handle use_kmalloc_nolock == false */
-static void __bpf_local_storage_free(struct bpf_local_storage *local_storage,
-				     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		kfree_rcu(local_storage, rcu);
-	else
-		call_rcu_tasks_trace(&local_storage->rcu,
-				     __bpf_local_storage_free_trace_rcu);
-}
-
-static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage *local_storage;
-
-	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	kfree_nolock(local_storage);
-}
-
-static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
-{
-	/*
-	 * RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree() directly.
-	 */
-	bpf_local_storage_free_rcu(rcu);
-}
-
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 				   bool reuse_now)
 {
 	if (!local_storage)
 		return;
 
-	if (!local_storage->use_kmalloc_nolock) {
-		__bpf_local_storage_free(local_storage, reuse_now);
-		return;
-	}
-
 	if (reuse_now) {
-		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+		kfree_rcu(local_storage, rcu);
 		return;
 	}
 
@@ -163,42 +123,7 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 			     bpf_local_storage_free_trace_rcu);
 }
 
-/* rcu callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
-
-	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
-	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
-
-	if (smap)
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	kfree(selem);
-}
-
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
-{
-	/*
-	 * RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree() directly.
-	 */
-	__bpf_selem_free_rcu(rcu);
-}
-
-/* Handle use_kmalloc_nolock == false */
-static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
-			     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		call_rcu(&selem->rcu, __bpf_selem_free_rcu);
-	else
-		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
-}
-
-static void bpf_selem_free_rcu(struct rcu_head *rcu)
+static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage_map *smap;
@@ -209,37 +134,24 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 
 	if (smap)
 		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	kfree_nolock(selem);
-}
-
-static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
-{
 	/*
 	 * RCU Tasks Trace grace period implies RCU grace period, do
 	 * kfree() directly.
 	 */
-	bpf_selem_free_rcu(rcu);
+	kfree(selem);
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now)
 {
-	if (!selem->use_kmalloc_nolock) {
-		/*
-		 * No uptr will be unpin even when reuse_now == false since uptr
-		 * is only supported in task local storage, where
-		 * smap->use_kmalloc_nolock == true.
-		 */
-		__bpf_selem_free(selem, reuse_now);
-		return;
-	}
+	struct bpf_local_storage_map *smap;
+
+	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
 	if (reuse_now) {
-		/*
-		 * While it is okay to call bpf_obj_free_fields() that unpins uptr when
-		 * reuse_now == true, keep it in bpf_selem_free_rcu() for simplicity.
-		 */
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+		if (smap)
+			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+		kfree_rcu(selem, rcu);
 		return;
 	}
 
@@ -576,12 +488,8 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	if (smap->use_kmalloc_nolock)
-		storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
-						 __GFP_ZERO, NUMA_NO_NODE);
-	else
-		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-					  gfp_flags | __GFP_NOWARN);
+	storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
+					 __GFP_ZERO, NUMA_NO_NODE);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -591,7 +499,6 @@ int bpf_local_storage_alloc(void *owner,
 	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->mem_charge = sizeof(*storage);
-	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 	refcount_set(&storage->owner_refcnt, 1);
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
@@ -868,8 +775,7 @@ u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache,
-			    bool use_kmalloc_nolock)
+			    struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -901,12 +807,6 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
-	 * preemptible context. Thus, enforce all storages to use
-	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
-	 */
-	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
-
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 605506792b5b..55f4f22bb212 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -212,7 +212,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache, true);
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
 
 static void task_storage_map_free(struct bpf_map *map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf07..9fb22e352beb 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -68,7 +68,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &sk_cache, false);
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
-- 
2.52.0


