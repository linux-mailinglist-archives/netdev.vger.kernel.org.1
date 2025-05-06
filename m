Return-Path: <netdev+bounces-188223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4717AAB971
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54DC3BB2D0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F128AB15;
	Tue,  6 May 2025 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PT90DV6U"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBC2F8DFC
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496766; cv=none; b=V+UH2cUkvFDuATZJSFHTVzYDUqtZCiofUDS4HP3hd0jiYGGUBpMRS0EaSOzuz1LfmhyxGyyeEI7EyTCCUoxzZqxaIjFipCzHJOgcY8/GV5KUUFh06pk9fIRXGQBo6w63FldK4dXldrfowhZzh4emvAtyfvLCguUsJGQ1+McXMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496766; c=relaxed/simple;
	bh=IC2DFeGDnaJV0AsGdsc00/VL8Jg2PXjB4wsUnDx79yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9DiTVng3V51tDtmCqi5xye+8IvGjyX6iEpFMNjMfEUECQX8u1mcpqb909uNBl2y/uvj+KAL9rrjT/ejutdaaJitJa44mRpxXvX6eGvYR3W2xNKrLuZQk1ZI7uvkiu4dGzPdMvdzKKyAoZlWItU3Lm4YUPF7nyqCQkdzmZIR+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PT90DV6U; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746496763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrSRj6u5dDFn+U6UhyI/q+bYbViTrcuI6lxB/1P47+A=;
	b=PT90DV6UiUAOrPSb/vjzkz0EBuEM1jfCSJ8oAhe7qLu8k4zUYTx8A1clOdFqquBxLl56OE
	oj1S/7Lmzwl9AT2md+EvuJOquRUFzGgnvNpvtq6lqgZ4/3fir9X0Lwk5lzAUklCOxtbei/
	Ej30oyCPMz6VCYn9YZqXdb/t1iIzfsc=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Kumar Kartikeya Dwivedi ' <memxor@gmail.com>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 7/8] bpf: Add bpf_list_{front,back} kfunc
Date: Mon,  5 May 2025 18:58:54 -0700
Message-ID: <20250506015857.817950-8-martin.lau@linux.dev>
In-Reply-To: <20250506015857.817950-1-martin.lau@linux.dev>
References: <20250506015857.817950-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In the kernel fq qdisc implementation, it only needs to look at
the fields of the first node in a list but does not always
need to remove it from the list. It is more convenient to have
a peek kfunc for the list. It works similar to the bpf_rbtree_first().

This patch adds bpf_list_{front,back} kfunc. The verifier is changed
such that the kfunc returning "struct bpf_list_node *" will be
marked as non-owning. The exception is the KF_ACQUIRE kfunc. The
net effect is only the new bpf_list_{front,back} kfuncs will
have its return pointer marked as non-owning.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/helpers.c  | 22 ++++++++++++++++++++++
 kernel/bpf/verifier.c | 12 ++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 36150d340c16..78cefb41266a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2293,6 +2293,26 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, true);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (list_empty(h) || unlikely(!h->next))
+		return NULL;
+
+	return (struct bpf_list_node *)h->next;
+}
+
+__bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (list_empty(h) || unlikely(!h->next))
+		return NULL;
+
+	return (struct bpf_list_node *)h->prev;
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -3236,6 +3256,8 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acb2f44316cc..99aa2c890e7b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12079,6 +12079,8 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12124,6 +12126,8 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_front)
+BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
@@ -12160,6 +12164,8 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_front)
+BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12598,7 +12604,9 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back];
+	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_back];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13903,7 +13911,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id = id;
 			regs[BPF_REG_0].ref_obj_id = id;
-		} else if (is_rbtree_node_type(ptr_type)) {
+		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
 
-- 
2.47.1


