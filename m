Return-Path: <netdev+bounces-246746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AA3CF0EC9
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C023026AAE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737C2D321B;
	Sun,  4 Jan 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0hXhPKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CE27E1C5
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529767; cv=none; b=m7JCg2FTHgPVo5dGfObauCqeZRQexkN0/S/EXQ9mPwfzFtqxjp4Zfc/HWQW1s39ErFNf8JkzQOMLBp98lRR7fgpMOvJ83s155z2WmgXYocGlAMXn9iNcqRiS/OdboJNY6tXZJvCdDugGKejtHiJcUzoCmzEzc6hCvmVXeZxPuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529767; c=relaxed/simple;
	bh=K+EU/S4XNqCczE5NOitx3rx5MF3vZYRuMMv9sYvUq2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZvYzppAx17Vfb9rEucpMNrlS8yk0GYZepEZegaKKBcB/7o0HCKeP64GrBnCSxMYP2+kWBtLEnGnIhQit4qSUlFKbrl+aMacOD1kt4bPYl1yxvtakdtO2XY3BXK3bCtMih2nALMPnvCr9LFY9vG7b9naB3V7sUQuZVNnN9gzsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0hXhPKU; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fc0f33998so86383397b3.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529765; x=1768134565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjpuND+cM6PNH+whys9cSmd7/ZmHiaSR1eTVw3ZGpU0=;
        b=N0hXhPKU+Zvo86icqIHMAyNtmKE7TtNoWxwL/q/NsoxL/7FLD0rbGkJe7omVMM2SGf
         9GD3UKC8eIeS4abKhMjRGHtt11ZGU+Azww9nE0y1/myFg9GV6id79lhO8OcPgzPM6K9O
         z5oNsL/2BGBLzUq1nzki27GxRostnAY6UEs1WE2MoxATFkGJjbIjUm2EJAQL1VMW/Ljn
         1+24lMPYmZ1vSTacISW7ob1/FpP5zGNd7Gkct+do6zxQQqkj/CeMyJvAqpgX3Ix+kPQJ
         JSgd2F1Ha+5ptpWmmY0xOOpxZmQf4P5hMVlqpr1B2bgS8jZYfHi0XJ+zPwKBqvz4NdeV
         JBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529765; x=1768134565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SjpuND+cM6PNH+whys9cSmd7/ZmHiaSR1eTVw3ZGpU0=;
        b=owXqH/X7Xt2At9do/ee80DfWwINNXWbmihxB2rbMciTsAReg3TLBJhgT9gYvFDsicO
         7g3GTWOZpEexMhcdlBPK0b5C6rouxv1daoIU4G1AeYOvfDhaDX84NxtSvD+IntTLP67l
         gz9InYDsgOsASM175zR3oGSYr4SuE8CxPWSVG08Dw1TMvz9ys2NGMm+MS3DF/7Ill0SY
         BP8CtE7Ugvxfa+Vnx8K166y7Oyo0jvoVN24n6vsvOSBaAD5VW/LwRa/Yg76DHZyG+LMc
         yLqleZ+iqY8AB1vzuYFFOD0gTuARBpugdLewWltqGmHXd5zGLUhAuQS34swVM+2xYpBe
         vH/A==
X-Forwarded-Encrypted: i=1; AJvYcCVpWp4kPb0rZyBPPLLa1r9++LmBA8J1U1Laf204JlwPHYzS9AGLGkU5pHZQbYjuV42bz1Elois=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3S1eWYXtecg7C47raUT3LSahRXJfbM7Hdejw54UOAs7DW5uc
	gIZdeiWR7x6VTC0dq6zQJ6MvN5Xsv8uuGI+cOoHCEF7nV22mVDGmMaK2
X-Gm-Gg: AY/fxX50qSB4Sj1u50aINXyzQ6qATMBlsYzPm7aSKSYpg5U8tY/HK1AktERIfTgX+V1
	aje1UtohiWAtK2weAnavIWoEyUe86ubabmp9D9I3i+zqMHNgp7NhPO4565rXgLfFTxOl6ZPqj1R
	O9BGV17dNR2gQbfnSovAv2s/ZiaddvYSz9qhQH/1UyVSg5shg9Ebch6V4mRQe/B/bAPKX77kUmC
	QTWF33BLLX7ubdzu4HQaFFwF9DS3cdPkPJuCJLihmOy9hg5HKDhD6GcQZntKcCpTMchUoDDNYMS
	kbzrcGRLQ08hrQ6sC7JYiH1hdkCl//bYPXdZx63Ife+nNvfuerZSVeFshfkfYJiK753i4/99xyn
	FpW3sSEX+xiz9/Q6Tb1CCT1fQZsRHn2B52tfBfuo3DZHWhZkyKCPHJ7L3s8D8csK0BmE+i+6nyJ
	ekUhKsMJF4UPNMc9/AZQ==
X-Google-Smtp-Source: AGHT+IFE61D8Ekii1BgyPXdmbHdTo+gvI4aNQG4564OpeAhpj2Qrl+e5Fy8EIIPd4zle35knweXVow==
X-Received: by 2002:a05:690c:7309:b0:784:88df:d9d with SMTP id 00721157ae682-78fb3f040efmr784710007b3.2.1767529765001;
        Sun, 04 Jan 2026 04:29:25 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:24 -0800 (PST)
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
Subject: [PATCH bpf-next v6 04/10] bpf: add the kfunc bpf_fsession_cookie
Date: Sun,  4 Jan 2026 20:28:08 +0800
Message-ID: <20260104122814.183732-5-dongml2@chinatelecom.cn>
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

Implement session cookie for fsession. In order to limit the stack usage,
we make 4 as the maximum of the cookie count.

The offset of the current cookie is stored in the
"(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
session cookie with ctx[-offset].

The stack will look like this:

  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

Inline the bpf_fsession_cookie() in the verifier too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h      | 15 +++++++++++++++
 kernel/bpf/trampoline.c  | 13 +++++++++++--
 kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
 kernel/trace/bpf_trace.c |  9 +++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index de6f86a56673..988ec1e34e83 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1231,6 +1231,7 @@ enum {
 
 #define BPF_TRAMP_M_NR_ARGS	0
 #define BPF_TRAMP_M_IS_RETURN	8
+#define BPF_TRAMP_M_COOKIE	9
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
@@ -1783,6 +1784,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2191,6 +2193,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->call_session_cookie)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 11e043049d68..29b4e00d860c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -592,6 +592,8 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
+#define BPF_TRAMP_MAX_COOKIES 4
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog)
@@ -600,7 +602,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	struct bpf_tramp_link *link_exiting;
 	struct bpf_fsession_link *fslink;
 	struct hlist_head *prog_list;
-	int err = 0;
+	int err = 0, cookie_cnt = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -637,11 +639,18 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		/* prog already linked */
 		return -EBUSY;
 	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
+		if (link_exiting->link.prog != link->link.prog) {
+			if (kind == BPF_TRAMP_FSESSION &&
+			    link_exiting->link.prog->call_session_cookie)
+				cookie_cnt++;
 			continue;
+		}
 		/* prog already linked */
 		return -EBUSY;
 	}
+	if (link->link.prog->call_session_cookie &&
+	    cookie_cnt >= BPF_TRAMP_MAX_COOKIES)
+		return -E2BIG;
 
 	hlist_add_head(&link->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0a771be6cb73..e3d7a0fbf4c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12373,6 +12373,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_fsession_is_return,
+	KF_bpf_fsession_cookie,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12450,6 +12451,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_fsession_is_return)
+BTF_ID(func, bpf_fsession_cookie)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12505,7 +12507,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	bool arg_mem_size = false;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -14000,7 +14003,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
 		meta.r0_size = sizeof(u64);
 		meta.r0_rdonly = false;
 	}
@@ -14284,6 +14288,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22557,6 +22564,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d6f0d5a97c4d..b4914ceed8cc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3364,10 +3364,19 @@ __bpf_kfunc bool bpf_fsession_is_return(void *ctx)
 	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
 }
 
+__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
+
+	return &((u64 *)ctx)[-off];
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(tracing_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_fsession_is_return, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_fsession_cookie, KF_FASTCALL)
 BTF_KFUNCS_END(tracing_kfunc_set_ids)
 
 static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.52.0


