Return-Path: <netdev+bounces-245104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2ADCC6E6E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5280D3033D5E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A56346FDF;
	Wed, 17 Dec 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPrvMR0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CD2E090B
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965316; cv=none; b=DhFbY4Q25OsIswkY4VyV7xvOn8kNRoTTCX/0WEwwJRZLaSTVvhdbGKQ4crH0n+rcU7cftCGJPF9yusaeyunXrtL0h5iveY1kcDGFCQv7Zz1bYB3NlI4hKQpiPrbLYfthnRqJIW80grByt1YICUv5OV89chApCYquFqhwUKdSRRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965316; c=relaxed/simple;
	bh=tymsptnwVqCK+EBcdpyIreeoqu6nppQzBwVci64fanM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBKQKn+pAmdMBShcAm9Kd6iU5YH0lzr8h/md6pVQu1pVcM45UYBuhN/WpFlda2wI2iiG/a7zq1ROBvlfyIpIf8zz+4GTsBgYNOIxcVo1O6cHy6eiZjeW+DWt5cl4mHoIQAVe2PZI3PAJH8vVhHgFsdnnCpqhn43MjHeFhnnx0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPrvMR0I; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0bae9aca3so46721315ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965314; x=1766570114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1qS6JRi8qK9u0+Jx90T9d6NveMH/Z/F2BRN/sKRPm4=;
        b=WPrvMR0I68AEa51oy93aa2+sPcido7jFbtaW2cqw4E/iI8fO994r61dRKuNQb6ACJY
         Os0SsHO+NtT1/w6RQggCcTpICkIyGXpwCx5LLjruEk/phWyi0J0goNIq+38Fs6XYnIkB
         SaWg6JMMGi5/fQCu3JwleGVU5FY4AhZAmdS6WsEYk2hbnIM17U4nBMKZGaaRGOof2aJw
         3zQKFaZvSo/1LFXGe9vit5i/RheUV31zU4663TVfP9CyivXyCvaGJ+hUYXVIDJ/m8ct9
         nWe7xpdFmARaMKzCtPwNj7Bdsp07hEDIkPtwAroUGVai6Ag1poNTHykp9EQ85eV4YTG0
         gH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965314; x=1766570114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1qS6JRi8qK9u0+Jx90T9d6NveMH/Z/F2BRN/sKRPm4=;
        b=PgYofiqWN/01Woy7zWGJJvfFJjxa9prnM0TtKfd9Mhhnu1P+zzgKSksoCQ1zvrKrj7
         /bH0sSfcnr6BmDSEbRQLjr3Pum/dUKID2fI8W8/ks+tABZA8grmvmu9X90wweTaOZssA
         BUzvMyhD/QDvIsfB9Nc+l47PJNQX1D+1ejJkkIroZGhmn0Ph9ovol3dYbDlpF97bkT1r
         x1wNhER4rZAujPmZj9zq2lca+f6cMngw4p2pDMen3KHgwFiJ4jMHsSCY4/3Rl88qFxR+
         j5sLMvBWOnj3fdX3ij1scZ1ZUP/OlUPiTb3xK5vGdMzz9r3mOl8gjpCV2Ho0H/xdpp94
         6X6w==
X-Forwarded-Encrypted: i=1; AJvYcCWlbWR4FirXiJqubVQ8SOa3JaCAHbkVHkWHFPxAFOEQXulZASe/ZH+LMrBl8CTsLR/LH46G/bI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynrh8OUjiL52iDRHhdwjV/uXELHUlFxcRtmyZLkdECaZwWuXYt
	LdNJXHjMr/4MiCoYo1Fa/rPhi7RXsoBaRg3kcdAp6fC6VBwstDLTMtVx
X-Gm-Gg: AY/fxX7OEmvIsoWaKxZr1EMIr8x6O5MXao9TZBD7i2uk0+Cy5rVmMgeTYeRZ5YOfBRC
	km+54JFjUBVUAjqGrwjJzOTAO3qqkW2BhpeIXw8uImsMjNdiv2RnaN++ZxSh6Fe9sSP5EKSFrQr
	ev7rdQXmxiC+Ph4fDviZCG6MdPMH7Rrzrjv5+MMPIr7QDZiTBjF19yW3gkJNMiNxy/GBcoD+hsD
	WinKyzjDhUXtFs1ylbRZ9ioMp7A38cnOec+jxBRsnPkdDZivIx6NU5VJ6SHN/2GOsUoiE0ZPmrN
	Qx920NYEhOI3MUYdEgHC2VwWxF4IXzLZjbSAz17AzTyWV/obB5wyfFgQiKA9qAWA4XScpbVIXAh
	4CX1NYV382pdTEWvLbGvOwHD6Ytj0gOL73NIr7l30M1uSIV4DC4lIhPgnMBZkwZmh5uUe9SRyry
	wUXvGrOwQ=
X-Google-Smtp-Source: AGHT+IEQq8TrbeOE2cQX+Q7hC7HE5fCgUKQ6Wa4zFxEAUFXrwzzRHEwSxyNL7jLjUfh2XRbWv8c0bw==
X-Received: by 2002:a17:902:e750:b0:2a0:f488:253 with SMTP id d9443c01a7336-2a0f4880376mr115598385ad.52.1765965314206;
        Wed, 17 Dec 2025 01:55:14 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:13 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 3/9] bpf: add the kfunc bpf_fsession_is_return
Date: Wed, 17 Dec 2025 17:54:39 +0800
Message-ID: <20251217095445.218428-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If TRACE_SESSION exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN)
in ctx[-1] to store the "is_return" flag.

Introduce the kfunc bpf_fsession_is_return(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/verifier.c    | 11 +++++++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3b2273b110b8..d165ace5cc9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1213,6 +1213,9 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_M_NR_ARGS	0
+#define BPF_TRAMP_M_IS_RETURN	8
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96753833c090..b0dcd715150f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12380,6 +12380,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal_impl,
 	KF_bpf_task_work_schedule_resume_impl,
+	KF_bpf_fsession_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12454,6 +12455,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
+BTF_ID(func, bpf_fsession_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12508,7 +12510,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -22556,6 +22559,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 10c9992d2745..0857d77eb34c 100644
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
+	    prog->expected_attach_type != BPF_TRACE_SESSION)
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


