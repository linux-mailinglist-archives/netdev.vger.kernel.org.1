Return-Path: <netdev+bounces-247934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEDFD00AA2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E16E7302DB30
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFC2773DA;
	Thu,  8 Jan 2026 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWQ/R0Ao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00A26ED4F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839160; cv=none; b=f0/uuuG5kP6s1M2tQnJISrm2U043Ksm/PCiCjYKe9jD2tjy5B/oUrua5jzqwp0G6KUwgCeR7aUwG6JkcaS9j2i9hLOh5uF471EoNA0jTuvHuTthFkTwqahro7uXtqLWnW4QtlGqjc82TdbBKMesM+d1vK1MNhqL0spUV3dxlLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839160; c=relaxed/simple;
	bh=LjFav+AyfQwuJtu4HS3krhAm4CaZVulpYAJZCeHKUb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coMisH4Bx+ycSCevSomxCXYP69vbfs+x0TFW/BarH65RxguAnkqE8ksB2c/1ZTYcygKo6LT6K6LBztvu6eopdlSS4se3JBN4rLMRaKNtaqo8NTv/xHYYbS0B7ydHOKLHRJtGyGsC6yeQ4fUacvNxyOCnGG4Hof0PhEUwVV+KpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWQ/R0Ao; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78c6a53187dso26046187b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839157; x=1768443957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk7bj0ctcXIlEAHnRAyKA/DsnStulYh/7klRUEuuWF0=;
        b=nWQ/R0AoBK9z9jXKqJRih0PXVPHQtJ95lPE1pANUupCY3lRCvweVAaF8GKnw79hXXT
         L9tKw/cEkx6L0Ui9OSF/wbzyeQsSNz0RRrXhXzF/QY5/80uZrdYvY3CbH1QTPJ9/rBDl
         h6me+9nsGMRrvgBe+LhOerzOS0m+MnzUwmMSoJr3sYx7L7vI2iski/YE4+VTinM6Pgcm
         WLDLvMikrNMes6Qc7VntwcfB8BnrIk8DUlpS8FiHLFwoivh7znmFMKNC20lGzz4pe58I
         am+tfyOnuNrcWdmxzHekeaQMdqKf2+jPZjMOy27DmIFzZpnktMiB7VddIrgDE9QQuKQ6
         2FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839157; x=1768443957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wk7bj0ctcXIlEAHnRAyKA/DsnStulYh/7klRUEuuWF0=;
        b=iHDnXF6V+Y6CsmLOoIhN3I/giZhrFzN6Lf8L0vYGRED0aLCw6s/KNP3Rz689pfISM/
         rsK1Zo2T/m4kNG7T2Qt28gqRPRs6tAZPOs9BdK7Eh9TL/Jkj+5AL3J2zL7V0BemEu77r
         CaFsJTiuvbDFvWGhmNgrTOgDtSAPAKlGhnA+f0k5meJwPSdAfeE0QJTjZWnPp/Up+itk
         PJNNCfD0vAVTiXLQ9pNXW8fcWOMSjCc8wR3Qd10yHRzGs5l9kwY1II1XQb5n0m903Pnv
         L0JLL4JAz3brEobqH6x63yRf3VTFlImM9sP8bKz5g8J9j1IzkN7lqpeGZG1c91vhv4+O
         9bvg==
X-Forwarded-Encrypted: i=1; AJvYcCXLDFP4Pl4+LVC9722vtULl3tWNEx3zkag76l0Fz9mkn2fv//n/Ja7xOJy7Sc518polTCUyZTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrML2AG3aUEgMOSxqTQlYOfGiuUX37A7gmILmrAfHFlfkp+AR
	de7LQ8RVP1ha9l2ldOrJOTmvjAlwpq0fvm6/P8zKS0nY/XYe9vWSdUgC
X-Gm-Gg: AY/fxX7X4ZUps+UvjGGlHyUniA2HlFdVdyldUXrh8D+BE+ip4aIMbNK0Ya5W/wfISjK
	hqc+MmGY3blkID1wbDZcZl4GKQg6wBWBya0jES3fb0/w5me+8kD9ERvTMsSL/cLzfK0Slo78lVj
	aBTuk+wsle2cfpfG8f/FJVeHxJRGGgGpanApH38/OsqrSfdgJcsiV4enX6hyUlpc/Uw+/fB+Hvr
	mXZgDyCa++H9TLUOn9mA4XrJkmvGTI2G2m/WOZCRmHvK9bd/ng1Ldq6zVElXgM/HsnUwlKaVO5O
	7nSK9Fijs2SF8CKpFgpYsgYuXsESxkfVirSXGfR0G5O/Eif31Ok9zizsul+T9CUCsKl2NkoXqNB
	NR6+sCEM4/uGJgW7IXG2xUmkEDGuNsBTEqmTM7xgvRQ2fmDUZEhpCSQNl/0hgXf3P0q4OVRtChC
	MIpqasM6E=
X-Google-Smtp-Source: AGHT+IEfrCShXnIKPT7paSEPLV3+G4mS4kDBvBZJtVyyPsqm/wN+sAbofDDMUu1IxiHGN/iuNlgaZA==
X-Received: by 2002:a05:690c:3581:b0:78f:c27c:92c9 with SMTP id 00721157ae682-790b56a62c9mr48402297b3.39.1767839157460;
        Wed, 07 Jan 2026 18:25:57 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:57 -0800 (PST)
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
Subject: [PATCH bpf-next v8 05/11] bpf: support fsession for bpf_session_cookie
Date: Thu,  8 Jan 2026 10:24:44 +0800
Message-ID: <20260108022450.88086-6-dongml2@chinatelecom.cn>
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

Inline the bpf_fsession_cookie() in the verifier too. The calling to
bpf_session_cookie() will be changed to bpf_fsession_cookie() in verifier
for fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v7:
- reuse bpf_session_cookie() instead of introduce new kfunc

v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/bpf/trampoline.c  | 13 +++++++++++--
 kernel/bpf/verifier.c    | 19 ++++++++++++++++++-
 kernel/trace/bpf_trace.c |  8 ++++++++
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 95248b0d28ab..699ad06e2465 100644
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
+				call_session_cookie:1, /* Do we call bpf_session_cookie() */
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
 
@@ -3978,5 +3993,6 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 }
 
 bool bpf_fsession_is_return(void *ctx);
+u64 *bpf_fsession_cookie(void *ctx);
 
 #endif /* _LINUX_BPF_H */
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
index d3709edd0e51..210af94e3957 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12508,7 +12508,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	bool arg_mem_size = false;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return])
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -14294,6 +14295,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22446,6 +22450,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_session_is_return]) {
 		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
 			addr = (unsigned long)bpf_fsession_is_return;
+	} else if (func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
+			addr = (unsigned long)bpf_fsession_cookie;
 	}
 	desc->addr = addr;
 	return 0;
@@ -22571,6 +22578,16 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
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
index 056f30844de2..665f10197fd7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3320,6 +3320,14 @@ bool bpf_fsession_is_return(void *ctx)
 	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
 }
 
+u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
+
+	return &((u64 *)ctx)[-off];
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void *ctx)
-- 
2.52.0


