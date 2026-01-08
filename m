Return-Path: <netdev+bounces-247933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17FD00A89
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2AA430118F6
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A3271476;
	Thu,  8 Jan 2026 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6klOGME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1726F28A
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839153; cv=none; b=hZNhCa3OXGEv8wPIxaI0DYseyoEJEi5bM0oGUTwTBmnwVAykbqnl+FDQavvuQ6mekg7MtdIIoYuq3QktjIItAhvTNuwVSHQQMk1oLzN3Mh+btsHlfPDJmyxDHfCqRk1bVkRY8MEytsHKczVrw6dXyyn1UETx7kR0lvmDt2rgzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839153; c=relaxed/simple;
	bh=33ZXMJWuCdojUF0ws2zQppZFn+bzB7mAX+06WHAujaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHKGS8JmLXPAH27yQOcvu3JYn1bNJPKWBzale9mlg0EmkWNFJHasEK1Ot6NQkNPrpt4+gxlFBxpCm9s9BOqKOI87ATZoPWUrfzj9OoTOojNlZeTdGr99vcp6m9cspQIyqbmAN3exr6cUAHBgQNbyNX2tE4/wdWe23soiQwUTN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6klOGME; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78f99901ed5so29910027b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839148; x=1768443948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vInP6QyodjCROjJEkJgbYkQF4JZFktsL3Kjqjh+D3Lw=;
        b=W6klOGMEG+C/PvDfFt72phtgKdDwPgV65g4iKCaduLYOAoJBnDlblGbyR9YXSonJuT
         EIAowoEtSNeOSqfRSXuY5LBCKo9LWkBuapI/51NmmIDFKDjGTYftcuWo5r57adFO4XUm
         bOpSd2ZGh4PLQkf62Ex+x0ofGX36uqbIVNKy6FWB4Eu8tAyYzSS7x7HGZDce8sV6HV9B
         Lke5LzT+wqG0ap7r6M84673d588WaV8l6F7Pf0V2LYcAFoLzSxqE1jxwT7GwRobF5Dui
         24P5QnknGvlPodZq5ALNHGEiJOFREgit38bjzUSOCNaOZTKHLnHBq/k3N29widOQtlFl
         ttGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839148; x=1768443948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vInP6QyodjCROjJEkJgbYkQF4JZFktsL3Kjqjh+D3Lw=;
        b=kp5kDT17lrt/v1UaudU3IxCU3NgyUXYzj9o+qlIz6N0mLE1IMicJnJElXejp7+M1LV
         Qb00Ilubdui1dZb41oMQzz2ljruXvc4PMkX9FswDnC8Im26NFhTr05Lx6vhRF6vav82E
         37rh9Ai+iyPETRnHz0802qhAkAc3I2PRi7BGzwoNf8Sw/LjuarHuRRk5zCXGAhsYQtzh
         qL3ScNUij86ul5b5j1VU1+jpRa1udYKGyDS9cJaBZGN1JeYF+AJDe6Q5W89w6yPoAG6k
         6uP0iu5zhxYD0thZzd4ih6RLAZwZh3WfzS8CsoG3qn15phLhPlBYOgTkBGPQjWVV+udX
         sj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyWhTcxybWPGUe/+a6BfqaUOpwHrShinhFTm1l+rbe2cW3aV0xY4N7RLxOSaAtJSl9aodPxVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8tpD1Ysk8dBU/R1+Y+LgIzsDoOb4evT32Qw7lyzLFKjbExkT
	CkPv/dkbYQXPc6PDknG+Q6vr7GUQa3dV6s9X/G/kQJcGOJ7aLrAnfxQX
X-Gm-Gg: AY/fxX7fFMcIS+WqM93UiU0sg6MP/PRBxgb1nP3Feq4guhBRl//Ht85RKvDJPhB/w9t
	mm0+oHpo15a7Y+cMDyLgYEO5h8jqBBKBCaJ2mc3gAMUQh1rapXBgf0j5DlamKuCMFW72NmLQrfs
	4tuIVW9z5a5I540nPrGvZngNvlRpq1/Pef2p7M+kDbMDPj1AXplA/oVWOuiyeRWHaU/0NdbVFrZ
	WyJmH8G/R4GePspVNjthS6cb75GIN5gLHIjLrpKGqe0AnA0OtsxINzDoSUr81/f26WKk/Qcn07w
	NciZ0LdoRqbDGeSICiUbVRH+rnr7u3tabz/zdzSLyImfbi03n52HKrZ87SHQHNETTzfH2dw02SR
	c04bSUw9yt6Bxw2PO/9eqXX/owLqa+4QrMgi3ZbrtljOCilijpEzNegCD8DZ2xnrD4uA+ByY2ZF
	aUs6sXML0=
X-Google-Smtp-Source: AGHT+IHFgjTB5e0Gs+yTOGkTyHd71ZhpHmUP1hLLO3sarTu+JAfQiodWZuFVGmYj6NKPXu4GfA9HHA==
X-Received: by 2002:a05:690c:600a:b0:78c:2916:3ef5 with SMTP id 00721157ae682-790b55c08a5mr42635457b3.8.1767839148092;
        Wed, 07 Jan 2026 18:25:48 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:47 -0800 (PST)
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
Subject: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
Date: Thu,  8 Jan 2026 10:24:43 +0800
Message-ID: <20260108022450.88086-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

Introduce the function bpf_fsession_is_return(), which is used to tell if
it is fexit currently. Meanwhile, inline it in the verifier. The calling
to bpf_session_is_return() will be changed to bpf_fsession_is_return() in
verifier for fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v7:
- reuse the kfunc bpf_session_is_return() instead of introduce new kfunc

v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  5 +++++
 kernel/bpf/verifier.c    | 15 ++++++++++++++-
 kernel/trace/bpf_trace.c | 34 +++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41228b0add52..95248b0d28ab 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,9 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_M_NR_ARGS	0
+#define BPF_TRAMP_M_IS_RETURN	8
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
@@ -3974,4 +3977,6 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+bool bpf_fsession_is_return(void *ctx);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bfff3f84fd91..d3709edd0e51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12374,6 +12374,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_session_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12451,6 +12452,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_session_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12505,7 +12507,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -22440,6 +22443,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
 		if (env->insn_aux_data[insn_idx].non_sleepable)
 			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_session_is_return]) {
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
+			addr = (unsigned long)bpf_fsession_is_return;
 	}
 	desc->addr = addr;
 	return 0;
@@ -22558,6 +22564,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 297dcafb2c55..056f30844de2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3314,6 +3314,12 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 }
 #endif /* CONFIG_UPROBES */
 
+bool bpf_fsession_is_return(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void *ctx)
@@ -3334,34 +3340,40 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_START(session_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_session_is_return)
 BTF_ID_FLAGS(func, bpf_session_cookie)
-BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_END(session_kfunc_set_ids)
 
-static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) &&
+	    prog->expected_attach_type != BPF_TRACE_FSESSION)
 		return -EACCES;
 
 	return 0;
 }
 
-static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_session_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set = &kprobe_multi_kfunc_set_ids,
-	.filter = bpf_kprobe_multi_filter,
+	.set = &session_kfunc_set_ids,
+	.filter = bpf_session_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+static int __init bpf_trace_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


