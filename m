Return-Path: <netdev+bounces-246745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C3CF0EC0
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D18B304791A
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27612C3272;
	Sun,  4 Jan 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv0c9l1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94122848A4
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529752; cv=none; b=OIliUJU5YPRZ/BPIpUew9MXd3XHp335Fq9foDSveiNCP85ckXCSRqpXRdLbXgBqmVvb2KAuz6ux9ds8X/OTGE+w8QJ8zVv2lXUgVv7wsaYZmz3kRRg+DvYodTl7aww7rD854YCkhEfsNGxZUcUVB16yzDDVgmkCSyrwu6Qhd81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529752; c=relaxed/simple;
	bh=e9VHlm6n7hVwJkXAyd+w0i3/OabKQu+CT+qxcSN8VMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acld4pGFlHNF6QMlh/AV/meeMCswIJ0O/oH9a+VokIM7utNG9xtCnWIKxs5FN+497J4SOlbgUGtDo/h665JRnOPogsuIKxWimHauICxUuWreL/nqYPgEOD1j9zXlqATXvXl1RLw8NCL86YGahbuOXJSnKV9vTY3CbE08aIol1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv0c9l1n; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64669a2ecb5so1087064d50.1
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529750; x=1768134550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeLX9Qb7FxErvthvcRCs2SbJfJEM0Z2UtyZWl6yDR8g=;
        b=fv0c9l1ndXBM+oIbu73oRmhdnsBPPKKh+s66CwAB+uaPCs67LTa9gvHT542iDbs2iv
         SqsWZ7DVaBvw5C6Mbh0WfpPyMuI7ONMDKvVO/v38HFj63nNvp4W+0j/4fIaA6nqBsKFW
         DLy2gql80PQwyhW2wA7hkqresBuKWG4AJle+1gRautl0F7nY9Eq1p3DMW+zWNUc5o5Tc
         u8ek0KIYSXmg/sL0GDrTXQ/LE4zUCpad6a0afeZF74proLyz2mWpLj6n23ABr7XyiaGR
         FcyAFWzKztvP6q3+RGbNvVP9cBi+YvO5wX8LdYgB+6DBdAFcUI+w+HQ0uzskkAvoLSr6
         XtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529750; x=1768134550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jeLX9Qb7FxErvthvcRCs2SbJfJEM0Z2UtyZWl6yDR8g=;
        b=i8tMjJsgVXjRWG0DdrXp7GzOvne0b1jh/fL+r3xTBAGDiXXnDKJUTeIdutoNplgVaJ
         QP6h4nxcj1Do9XBToGkoFeZkEbSrjRj+PBM4qF80iwtp6gD8p2Dk41zzp+XFy3yANzXk
         rofxRSUB6vlxns8fIELOPSOkj7NXDYRG5uCqqUvC1wFJUOx5jaowN2Ia1rcHZSKcE845
         86C85xAfoLa3LXOqkg+0D7wJCT2d8KGYjPcbkjCpRtuQlFP3MNNROHa8T/kv5Oa8qgas
         JJmnOyIlzagIeuJpAZgIcXd5+qEo71kJW7ehLJW/NYvppLRI7f/DTfcT+bi59LlRdtpD
         BzFg==
X-Forwarded-Encrypted: i=1; AJvYcCUzEshG0XJJzr65JyKuPVMk1RC9HLRtJBHvucsfIvaVWisYmHht4j0PNlm/Pi9Wyj6wwPeGWpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxhPiG9yz7sMoqAdO2AxMKvx7Fiw843+/t+xVUg3072JeXry9
	uOVNkiktnmK6Prna9KA5I0g77WBswGmjURorGna4ppFK3nEkoHr1pIC/
X-Gm-Gg: AY/fxX5TwLgu86uP5ytEdq+2w6akNUFR4daPXlefmPyin2asIPAxWGq6gdSoy67D53A
	o1f1hodTWoDAKXRBdBB9+Rwqz2LO7ZPeeEbk1xGKA12V6k68ykcAGsqQmkOr+mi5pJlCzmKv6a0
	yXDKKUwb+7JSvEWI7tQ65Qo1ri9otscZngyulthNStYrtJAXHDBmgqnhvV6yvWI/pInNXaI/2lz
	wc9woKthDc9uLXwVLaIY2D7f0gPNfxKACtg2YtVry3oPFPIKE2zCaA/Q6SBUstyFQqhZDgI4Dbm
	NqaM815SUQTOGd3D3bJvhTyjIVJImE1tHkL6fVQ88HePUAowev4D4qMdKCM7dbpRZVQPJsPh9GP
	NvlzzRujJKlgu4VEQS/cFOZ9truKC95Vm6ap5NEJw00Iw2vzGvnVYNyyLtnfpkk8gKaUHKfDl3d
	tOU4xEz1rJVwcies1Epw==
X-Google-Smtp-Source: AGHT+IGkUlFO4z0/g19cOG2YiYyn/dQtce3ZzXHBdsMotbF8XUgoRS6HZP38KUsbyHhpRIIGLJ8tYA==
X-Received: by 2002:a05:690e:169c:b0:644:44d2:a9cc with SMTP id 956f58d0204a3-646e33312abmr3461150d50.7.1767529749663;
        Sun, 04 Jan 2026 04:29:09 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:09 -0800 (PST)
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
Subject: [PATCH bpf-next v6 03/10] bpf: add the kfunc bpf_fsession_is_return
Date: Sun,  4 Jan 2026 20:28:07 +0800
Message-ID: <20260104122814.183732-4-dongml2@chinatelecom.cn>
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

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

Introduce the kfunc bpf_fsession_is_return(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/verifier.c    | 11 +++++++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 565ca7052518..de6f86a56673 100644
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e7dd2f0296f..0a771be6cb73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12372,6 +12372,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume_impl,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_fsession_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12448,6 +12449,7 @@ BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_fsession_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12502,7 +12504,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -22548,6 +22551,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_is_return]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b58f9a4dc92..d6f0d5a97c4d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_fsession_is_return(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_fsession_is_return, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_FSESSION)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &tracing_kfunc_set_ids,
+	.filter = bpf_tracing_filter,
+};
+
+static int __init bpf_trace_kfuncs_init(void)
+{
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


