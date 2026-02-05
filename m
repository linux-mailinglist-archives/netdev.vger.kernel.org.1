Return-Path: <netdev+bounces-257334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHh4LlAahWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:31:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14772F819E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F83B304C55C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F73382E5;
	Thu,  5 Feb 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkC5RpB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3643376A2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330565; cv=none; b=qx8MDtP8MFmQpxJHDDzg9LKz4pz/n5Lb78+rU7jgz/nmlACsqPuyvkKrjD+qd8pKnEQK+2KCgqKugQUiE7RzUqBC6xFVmx7TyEt56xa/XDRVi6tMk/Orwoa7eEWe2rRGp/PNeqKhVSRmehUqsE4hlbwksRFRfFnuGhuPZGEM5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330565; c=relaxed/simple;
	bh=XbF0mIKwmZ3jeFqp8qpRFUqtnJ4p/OsxHkO3rOfLZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN8uxpy81hlkTZZOtj5qYfXPgfHAqL1oK/AmmnMjQm8jGrEMfMBPfyxjDHHkSgOI7PCKq7FXKqY/dTP4thUgz2a+gvsn3aH7am/W3f72eUJ/QXfDlgVSxF8UkQwV2z9UovC8VXpayWvFeVg1l+w63YHoFKHvoqIHPVwgrgYZOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkC5RpB2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso505293a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330565; x=1770935365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZecBFB4izzXMUT8n9UEBoAlLyoZwUDaQwbaSsp943w=;
        b=jkC5RpB2nYpyzJmVahba0D5zaPYkctMMaZxDJeI7Aj95YztGbdmBQMXEcnEVBkOT4o
         URlXjdSx9GCTFTmVAAR7gPAhSUUJkr+1rSvr38zmbIbS+36jTt+7XmVd2e8NK0HPWV1c
         +I6nc73AvDt8mUhfY/j6C/IW9D9afDqPu3jqDr0fzyLGCDJ6fvho6CmRgojiN9qxq7kU
         DGpAJWWZSKZ38AGushcPZ1ZlEzq0xY7xunKpIdcin0RCOhm4OoAp3Lx5sTJxvvWiPyVp
         mShL9mz0ubv2JxHJltdEbCX30Cn7V9CnbfDRGPsFLuM6PM7dN3VWLBZLRDma6npF6syh
         OVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330565; x=1770935365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZecBFB4izzXMUT8n9UEBoAlLyoZwUDaQwbaSsp943w=;
        b=Qkir8PlrtKHvPHx2wPMYkdGwGhfPhRD1Uzm6y1SZ8smTRsOtFxzL5/c0iPgXKZGRxk
         P2Ko6f/ffjvVNjykVyktWgyNh91gnq35s9BanCLv+m85exZSqc09MsKwer4tHlC0qDvK
         pJtPwlageKYqpIwzCT0/MT0aLr4QYxMlup7KRAnEOiQFP/cboC22EwevUIRyZaOP26wm
         tXQ7sWicxHmn9juQIz11nDQMmun4bVcPLoM0jgasiuVSyZE+SO3+uGtjaTCrik4ccB0B
         z/fp1ZQXPE6ypuiYfXwMnaDWtvdruoUQD+LfD1uO88z5TetrcZh44QhPdvKyoIE9eMGW
         u60w==
X-Gm-Message-State: AOJu0Yyr4tOI95dGUHDQXNRZpIFyRAO5QcpqdPYO6tgsGR3Vcr/+qz75
	l/CDCp+mlBRutfCBUAvGRhfu6Oli9XxMXPmRWBKTpqsnYg4Qa3hVuH4T
X-Gm-Gg: AZuq6aKE8YQB7+XZPQDRZ+JzqvBxIgGtJEOOykBwAgnzGeBDfd3xb9dIgnXa+OVYGRD
	pMI6GIa47UXP1UxclCFxcaFUViipIlx2gPfQoBJUAtRNh4LsRf4gJhYOD7hCRcEs3Dk2kKP4LWu
	YxA1y0qoqRY70QHoX1Bou2r7yINMnOVCgvJey9ZLg1Y5MX9+sEqoDz59wu2W5hhATkVsJdKfb8t
	sRVMWc5gO+xcWxVgOnoFE9XVWEofvNV5XUqVhpC5o3Q1cT92uznuE4Ditj2/65UU6UWhX/PUS0D
	UNmhhzFdvQN9+MqA44PMDI5ONRwurXde6Frlv/0ZVTxcz3vo1zCGMF6dMYrv84YkVlAWU9bv6VC
	/6UK/nb+qPOmDhby3e8oSKl/S/3rCxLDlA7/RfdeWDlTg5YlpLdzsl5393r3kue1vT54YUG/PlH
	eX5Q==
X-Received: by 2002:a17:90b:2887:b0:34c:fe7e:850c with SMTP id 98e67ed59e1d1-354b3c53155mr395554a91.1.1770330564593;
        Thu, 05 Feb 2026 14:29:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b2eaaef0sm276983a91.0.2026.02.05.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:24 -0800 (PST)
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
Subject: [PATCH bpf-next v7 06/17] bpf: Remove task local storage percpu counter
Date: Thu,  5 Feb 2026 14:29:04 -0800
Message-ID: <20260205222916.1788211-7-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257334-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 14772F819E
X-Rspamd-Action: no action

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
index b54ec0e945aa..1f9f543bf7c5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2100,12 +2100,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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


