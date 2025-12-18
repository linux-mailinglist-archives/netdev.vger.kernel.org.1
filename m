Return-Path: <netdev+bounces-245417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC71CCD0AF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D81933022FF5
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378D30649C;
	Thu, 18 Dec 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOxs3CaO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F43043D5
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080601; cv=none; b=K9sRBFB4oDfmNlWvcC6h1ylbe+5NQ7FQQ/t9H41eHbDtV+OnGccuwmYpIcMgdcm9Wq8TlroT/z3s01J0+qB1FHsLllHtd3WNLllGYWdk2GWutT4myA/0O31bPW2bkfasDW86jBBZs3F6D20puCcIkIBSlKQZjKUjGRBdcJ9k54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080601; c=relaxed/simple;
	bh=08RUhYnAjLBqIcM08mcUF3dkyUpCJME0iR282sVf67M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA2EH47sTzIL87mbp9zwCsmVQ4SrQPjfsS164QtGRPuA8DzzrhYg+njIG2UZzjdHyBMrla6HwskxZgepfPuGT6B+BJjK2IAvveH1ZaOxkK92v/j2/7fkx100l5HunJKn1inHvG1ldMofv9Y2NZc7yGwYis4obE4nCXPFh5N4DZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOxs3CaO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34e730f5fefso903547a91.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080598; x=1766685398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th1N9o4rygkfwtZW+phQ3aKaCx+hkJcyHDT4emJuu5U=;
        b=FOxs3CaOmQ4eFEpVDJEPTiEGVB7tAZof/0VgB5yTJa3GyhsExDno0C7knV0MbVIiwt
         U8gMkUiWATxZV8kvcI/C/LxIQL1O/E2+E8tIL8AGPupHLFf5jNVsPAkwb9wBwtlJcGge
         sq4yrgMp9i8rURLUSuiAP5FMmR1ylba6OLobpxfBOCz2KkAHZegSKrOg4A9zXyvGAZvo
         8PEznAVs1XW1rPu/9L7Pocd5OdYDE1KzbHBaL4pmjMeXKCxjsE6NPI3yVhkx1vNS52j8
         jKqOd4JRXEewkeBiVTz9SEF9sPRyEoT/wD618M6H/Uu2fdSTUR5jsc5oWlzNgJTAjcC9
         AQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080598; x=1766685398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=th1N9o4rygkfwtZW+phQ3aKaCx+hkJcyHDT4emJuu5U=;
        b=FrZh69BbF/wX4Pmmd0qZIGNvL0R0wJnzxl5VLzNGwYetw5RWTY+IxQRrMnry66k7yt
         zMC6G4w1YXTKDjkyIwXLXNcmn8UBWmBNprKqp8JRbmUq/xZTUSZxKsHDid8zSkuUwbJ1
         eJbbTSGbTjuf7THyJHMXYHGSBu3NxZ0pC2E7arkDRxph+ljOzTXwT1fayULteQ1ozUG+
         +5+z74e2qvZaTj1ZBkwSm2bYXQYMqxk7vyCMxWwy6tSmMpgoIwomvA+sRVDPZemRckxp
         oX/daD8vJw9KDVOUq4jZZ9EBvNUEpQaijWoAJoMAhO3DeUhJkvvklwrmkDsXEu0+m+Jr
         v6KA==
X-Gm-Message-State: AOJu0Yw7yramrgr7/q5PMUyQJL5VjE/CTGqkB7FUPA2y258MhWmXp7+o
	ZYox8bpJYMDOFnQQ0KYfjBRaNAsTGSLqEcORZTx2g4zhQMx8moHsJE91
X-Gm-Gg: AY/fxX67FGSkDyXNTH4LjzBAqkM3SMX8VDc0zy2aFT3Ce62lVElClEJSK9PlcUOwbCe
	1xzxKdE3jcn8v0ASeeTY/6uA4OkFBIZ6OTgbP3fvz/QFW005vUlyc2Dz23mUzSYi1KSoCLimraw
	TEeVkWjmptj69cYwGDvBo6l8inZSxL+or0zFCZ8oYDSrVPtLC51vo4d96x1+hP2yr5AAlWwNBq1
	p35iFMGWflce2pb/uf4lR+E6E+5DkSFfWae67vB3puJOaZU42CqtmRPFlzgKV8HgVkN05xFJoio
	LEsDSPozApfIxFHRSX+n7MOJY8v+f2qaqEQVUgeyqx04PhKy1EN4Bgm+jfjM+PhH8csGlHGthNF
	/lurqUzM9Q3Ldmel9ZRxmicaLt9KHWcfoejELiIqvlLbchVo5coobggx2qLdrMh3VJB60YgoT8+
	u6007M1eLQ9socgp4=
X-Google-Smtp-Source: AGHT+IGkmTUwV9iC0Z7ooiTR1sww1bYuHPjBR67hQB8L3vMw+RZqcsZHpE8gMQg/6GgKA2Xh2wSy1Q==
X-Received: by 2002:a17:90b:4c46:b0:347:5ddd:b2d1 with SMTP id 98e67ed59e1d1-34e921ccb5cmr160483a91.27.1766080597818;
        Thu, 18 Dec 2025 09:56:37 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b06besm80535a91.5.2025.12.18.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:37 -0800 (PST)
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
Subject: [PATCH bpf-next v3 06/16] bpf: Remove task local storage percpu counter
Date: Thu, 18 Dec 2025 09:56:16 -0800
Message-ID: <20251218175628.1460321-7-ameryhung@gmail.com>
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

The percpu counter in task local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Since the percpu counter is removed, merge back bpf_task_storage_get()
and bpf_task_storage_get_recur(). This will allow the bpf syscalls and
helpers to run concurrently on the same CPU, removing the spurious
-EBUSY error. bpf_task_storage_get(..., F_CREATE) will now always
succeed with enough free memory unless being called recursively.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_task_storage.c | 150 ++++------------------------------
 kernel/bpf/helpers.c          |   4 -
 2 files changed, 18 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index ab902364ac23..dd858226ada2 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -20,29 +20,6 @@
 
 DEFINE_BPF_STORAGE_CACHE(task_cache);
 
-static DEFINE_PER_CPU(int, bpf_task_storage_busy);
-
-static void bpf_task_storage_lock(void)
-{
-	cant_migrate();
-	this_cpu_inc(bpf_task_storage_busy);
-}
-
-static void bpf_task_storage_unlock(void)
-{
-	this_cpu_dec(bpf_task_storage_busy);
-}
-
-static bool bpf_task_storage_trylock(void)
-{
-	cant_migrate();
-	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
-		this_cpu_dec(bpf_task_storage_busy);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)
 {
 	struct task_struct *task = owner;
@@ -70,17 +47,15 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
 
 	local_storage = rcu_dereference(task->bpf_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_task_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_task_storage_unlock();
 out:
-	rcu_read_unlock_migrate();
+	rcu_read_unlock();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
@@ -106,9 +81,7 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = task_storage_lookup(task, map, true);
-	bpf_task_storage_unlock();
 	put_pid(pid);
 	return sdata ? sdata->data : NULL;
 out:
@@ -143,11 +116,9 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
 		true, GFP_ATOMIC);
-	bpf_task_storage_unlock();
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -155,8 +126,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
-			       bool nobusy)
+static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -164,9 +134,6 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!sdata)
 		return -ENOENT;
 
-	if (!nobusy)
-		return -EBUSY;
-
 	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
@@ -192,111 +159,50 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 		goto out;
 	}
 
-	bpf_task_storage_lock();
-	err = task_storage_delete(task, map, true);
-	bpf_task_storage_unlock();
+	err = task_storage_delete(task, map);
 out:
 	put_pid(pid);
 	return err;
 }
 
-/* Called by bpf_task_storage_get*() helpers */
-static void *__bpf_task_storage_get(struct bpf_map *map,
-				    struct task_struct *task, void *value,
-				    u64 flags, gfp_t gfp_flags, bool nobusy)
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
 
-	sdata = task_storage_lookup(task, map, nobusy);
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
+		return (unsigned long)NULL;
+
+	sdata = task_storage_lookup(task, map, true);
 	if (sdata)
-		return sdata->data;
+		return (unsigned long)sdata->data;
 
 	/* only allocate new storage, when the task is refcounted */
 	if (refcount_read(&task->usage) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
 			BPF_NOEXIST, false, gfp_flags);
-		return IS_ERR(sdata) ? NULL : sdata->data;
+		return IS_ERR(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 	}
 
-	return NULL;
-}
-
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
-{
-	bool nobusy;
-	void *data;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
-		return (unsigned long)NULL;
-
-	nobusy = bpf_task_storage_trylock();
-	data = __bpf_task_storage_get(map, task, value, flags,
-				      gfp_flags, nobusy);
-	if (nobusy)
-		bpf_task_storage_unlock();
-	return (unsigned long)data;
-}
-
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
-{
-	void *data;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
-		return (unsigned long)NULL;
-
-	bpf_task_storage_lock();
-	data = __bpf_task_storage_get(map, task, value, flags,
-				      gfp_flags, true);
-	bpf_task_storage_unlock();
-	return (unsigned long)data;
-}
-
-BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
-	   task)
-{
-	bool nobusy;
-	int ret;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!task)
-		return -EINVAL;
-
-	nobusy = bpf_task_storage_trylock();
-	/* This helper must only be called from places where the lifetime of the task
-	 * is guaranteed. Either by being refcounted or by being protected
-	 * by an RCU read-side critical section.
-	 */
-	ret = task_storage_delete(task, map, nobusy);
-	if (nobusy)
-		bpf_task_storage_unlock();
-	return ret;
+	return (unsigned long)NULL;
 }
 
 BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
-	int ret;
-
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!task)
 		return -EINVAL;
 
-	bpf_task_storage_lock();
 	/* This helper must only be called from places where the lifetime of the task
 	 * is guaranteed. Either by being refcounted or by being protected
 	 * by an RCU read-side critical section.
 	 */
-	ret = task_storage_delete(task, map, true);
-	bpf_task_storage_unlock();
-	return ret;
+	return task_storage_delete(task, map);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
@@ -311,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, NULL);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
@@ -330,17 +236,6 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_owner_storage_ptr = task_storage_ptr,
 };
 
-const struct bpf_func_proto bpf_task_storage_get_recur_proto = {
-	.func = bpf_task_storage_get_recur,
-	.gpl_only = false,
-	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg1_type = ARG_CONST_MAP_PTR,
-	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
-	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type = ARG_ANYTHING,
-};
-
 const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.func = bpf_task_storage_get,
 	.gpl_only = false,
@@ -352,15 +247,6 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg4_type = ARG_ANYTHING,
 };
 
-const struct bpf_func_proto bpf_task_storage_delete_recur_proto = {
-	.func = bpf_task_storage_delete_recur,
-	.gpl_only = false,
-	.ret_type = RET_INTEGER,
-	.arg1_type = ARG_CONST_MAP_PTR,
-	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
-	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-};
-
 const struct bpf_func_proto bpf_task_storage_delete_proto = {
 	.func = bpf_task_storage_delete,
 	.gpl_only = false,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..33b470b9324d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2092,12 +2092,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	case BPF_FUNC_task_storage_get:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_get_recur_proto;
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
 	default:
 		break;
-- 
2.47.3


