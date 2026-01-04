Return-Path: <netdev+bounces-246743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF09CF0EA5
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A258E3006999
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC62C15B8;
	Sun,  4 Jan 2026 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD5QCYAh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7C2C0F73
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529728; cv=none; b=YZbUZsscb+m/Wl8bH4yKyQ3sj2BcIKxhNVEZ99XGgRko58ndRHkHy9aLGX56KrWxanJ678azeJPrHdiFRPzvx+tLhyDKktPWQBNC7vilMJbD9UvIfpbEOHH+4sc2YxaCI2GrTeEqupnHlXOQkX8BXHVdcXE6YtSxVZeOpbSLmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529728; c=relaxed/simple;
	bh=jNm9bhkvt7baNwqIKwBWsV2y8q+5qpWWAiLG+QJ3P6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpd/FXvcVj8xcx+5PFOEnqQvwef04M7rhLJzmY7cMksTZMn372TJnj2megmj7roMruACyFyhrjIJ95ll47aIIPweTgEG89dfU7uGMmKGklk1V2jXc/sTYo7pYtv9Sj9raPgjwXqsyZXG8Bp7vLuAn2VoaXzIVAsK9w5Xw52DoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD5QCYAh; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78c6a53187dso98295227b3.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529725; x=1768134525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS/Awj/bKDuMidtlO0YXdiJ382lrIR29ce4hyeJjXKg=;
        b=gD5QCYAh9gQ6gARvH8fwS2oI+CIAdIBH2m8YElm6LNZ+72qlbX1V/huWPgLB7Lwj+I
         WquQlii8rpqp7dp0M4jJObf8kjtOEOH1ceMO5bAyHjlOjZCDs2inio6jlS2zhQbbUu+j
         yQRE/J5Rz76OpjEr3W9vJe0binH5x9Iymgr9BUXGRUZ6NtMGARDGSGMRffhXNMLKIjzu
         392FFeka9yhC6e+PaLb4Xegvm4xgb6mdyWpoSuWRMR8MwlCmp8ebqUuvAjum8017TlmK
         T1GK3lSgC1G5/6oefi/rNiRZmfBggMwIyVmlHfi4/RsHS82ast/QucgqKzZuRHEnGPl3
         GnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529725; x=1768134525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GS/Awj/bKDuMidtlO0YXdiJ382lrIR29ce4hyeJjXKg=;
        b=wqXGFekrmzxBQ4NHZd7cxKQupFJpMdYX2QSsaxUBKOe+zQYRAVPT3q+ZmVjPe5j5T8
         qRTmVukHdIkk8D7mZFcSv981wOGZrRuaHp7ScoAsXCe8Ihwtnnr8/ElreWDwQ4hVVxjo
         PTyEEQUQ+RcD+IPetL2hbH2v5pJUh6GB6QU5zEMqEknc1y1rhlMRukLCvVJy+F6A1L7i
         Wzp7zSCCfkYBGVjQ//NYrH2f5Ce7N9yOHBO6/AwUzFUx1Qvb0GxMmIG8iH9SnpTwqpjZ
         ozBMZnR+kBZIyQ9kPdFhhiNLVzH4Uv/XxaegYQ0SsWz+n5ZRNJkYYFW2G7yn7rCLfh9d
         2Y4A==
X-Forwarded-Encrypted: i=1; AJvYcCXapL7tCCCNMJMBaofgggJ31w2MkEEKsrfhh97lQWCgMjK2nPmSZeZ6s/jalqdDdy5oD0oYGLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRs265bdep0jZaKFUgCKxQMBL6NCRvO4KfbrDA751ypFFG218
	tEaCvy3V1qnCUcLAmM7K0GgU48p+TRVTQP59rwgH0DW9PmMhAmF6hYgD
X-Gm-Gg: AY/fxX5dzNwUVunw0nBfjoC2wgFSWyhOux8pvY5dOts5D5sB7dUyEzYHHX7rAFK+pjm
	V06eSiECCzwpVwBAbear+OALLdr7bXYcS7QBXUjPk65LzUUjFHqFqhyOs+qRV5ErgMHJOySfbwa
	Uelq3v9x/oNbWZnweFpdvRYHnZuZMGmx4MVGR49eeS3Jn8sI+XsohJmIpYF6YVYv8iaepS5Az1e
	WlWVWSqN8IvXT/NVoSmuwmoTWKc2EWBNjWlTbSvrFazigAIR6aqOqQqBfIz0l/ikv0+RdBsviP1
	IkQbAX64dy5ZWBbH4EEFfwuzAQotDyINTaOBSiJSiOjJ7fVCyFLx9nX5pswYI3OwTvpq/SAuLMZ
	gJUqEJaUl3ujkdX2G2eDkYx3JFN8X679wzLW9nrxsSIBPxDX74ymo5UoaOpZcbBpDCrf9aXgZPt
	Df6IlpCUI=
X-Google-Smtp-Source: AGHT+IEijcTO/DQp9Pz2lVmQ6NHSwrPX/yP+1+yGa2fhr+XTewy94lQmGFtojIUsAG6y3nbkdgLr0w==
X-Received: by 2002:a05:690c:4b07:b0:78d:68df:81d5 with SMTP id 00721157ae682-78fb3ecc2d8mr423577837b3.14.1767529725351;
        Sun, 04 Jan 2026 04:28:45 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:28:44 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 01/10] bpf: add fsession support
Date: Sun,  4 Jan 2026 20:28:05 +0800
Message-ID: <20260104122814.183732-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsession is something that similar to kprobe session. It allow to
attach a single BPF program to both the entry and the exit of the target
functions.

Introduce the struct bpf_fsession_link, which allows to add the link to
both the fentry and fexit progs_hlist of the trampoline.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h                           | 19 +++++++++
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/btf.c                              |  2 +
 kernel/bpf/syscall.c                          | 18 ++++++++-
 kernel/bpf/trampoline.c                       | 40 ++++++++++++++++---
 kernel/bpf/verifier.c                         | 12 ++++--
 net/bpf/test_run.c                            |  1 +
 net/core/bpf_sk_storage.c                     |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/tracing_failure.c          |  2 +-
 10 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a63e47d2109c..565ca7052518 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_MODIFY_RETURN,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
+	BPF_TRAMP_FSESSION,
 };
 
 struct bpf_tramp_image {
@@ -1875,6 +1876,11 @@ struct bpf_tracing_link {
 	struct bpf_prog *tgt_prog;
 };
 
+struct bpf_fsession_link {
+	struct bpf_tracing_link link;
+	struct bpf_tramp_link fexit;
+};
+
 struct bpf_raw_tp_link {
 	struct bpf_link link;
 	struct bpf_raw_event_map *btp;
@@ -2169,6 +2175,19 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->expected_attach_type == BPF_TRACE_FSESSION)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 84ced3ed2d21..cd2d7c4fc6e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..8b1dcd440356 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_FSESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6dd2ad2f9e81..64f6eff02f9f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3574,6 +3574,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_FSESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -3623,7 +3624,21 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
 	}
 
-	link = kzalloc(sizeof(*link), GFP_USER);
+	if (prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		struct bpf_fsession_link *fslink;
+
+		fslink = kzalloc(sizeof(*fslink), GFP_USER);
+		if (fslink) {
+			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
+				      &bpf_tracing_link_lops, prog, attach_type);
+			fslink->fexit.cookie = bpf_cookie;
+			link = &fslink->link;
+		} else {
+			link = NULL;
+		}
+	} else {
+		link = kzalloc(sizeof(*link), GFP_USER);
+	}
 	if (!link) {
 		err = -ENOMEM;
 		goto out_put_prog;
@@ -4347,6 +4362,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2a125d063e62..11e043049d68 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_FSESSION)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_FSESSION:
+		return BPF_TRAMP_FSESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
@@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_link *link_exiting;
+	struct bpf_fsession_link *fslink;
+	struct hlist_head *prog_list;
 	int err = 0;
 	int cnt = 0, i;
 
@@ -621,24 +625,44 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 					  BPF_MOD_JUMP, NULL,
 					  link->link.prog->bpf_func);
 	}
+	if (kind == BPF_TRAMP_FSESSION) {
+		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
+		cnt++;
+	} else {
+		prog_list = &tr->progs_hlist[kind];
+	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
 	if (!hlist_unhashed(&link->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
-	hlist_for_each_entry(link_exiting, &tr->progs_hlist[kind], tramp_hlist) {
+	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
 		if (link_exiting->link.prog != link->link.prog)
 			continue;
 		/* prog already linked */
 		return -EBUSY;
 	}
 
-	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
-	tr->progs_cnt[kind]++;
+	hlist_add_head(&link->tramp_hlist, prog_list);
+	if (kind == BPF_TRAMP_FSESSION) {
+		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_add_head(&fslink->fexit.tramp_hlist,
+			       &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
+	} else {
+		tr->progs_cnt[kind]++;
+	}
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */);
 	if (err) {
 		hlist_del_init(&link->tramp_hlist);
-		tr->progs_cnt[kind]--;
+		if (kind == BPF_TRAMP_FSESSION) {
+			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
+			hlist_del_init(&fslink->fexit.tramp_hlist);
+			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		} else {
+			tr->progs_cnt[kind]--;
+		}
 	}
 	return err;
 }
@@ -659,6 +683,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 					struct bpf_trampoline *tr,
 					struct bpf_prog *tgt_prog)
 {
+	struct bpf_fsession_link *fslink;
 	enum bpf_tramp_prog_type kind;
 	int err;
 
@@ -672,6 +697,11 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		guard(mutex)(&tgt_prog->aux->ext_mutex);
 		tgt_prog->aux->is_extended = false;
 		return err;
+	} else if (kind == BPF_TRAMP_FSESSION) {
+		fslink = container_of(link, struct bpf_fsession_link, link.link);
+		hlist_del_init(&fslink->fexit.tramp_hlist);
+		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
+		kind = BPF_TRAMP_FENTRY;
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0..73bbc614b30b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17393,6 +17393,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_FSESSION:
 			range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
@@ -23290,6 +23291,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -24234,7 +24236,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -24249,7 +24252,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 			return -EINVAL;
 		}
 	} else {
@@ -24333,6 +24336,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -24499,6 +24503,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_FSESSION:
 			return true;
 		default:
 			return false;
@@ -24580,9 +24585,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_FSESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/fsession/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..3b0d9bd039de 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 850dd736ccd1..de111818f3a0 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b92b0847ec2..012abaf3d4ac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1145,6 +1145,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_FSESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..f9f9e1cb87bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)
-- 
2.52.0


