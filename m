Return-Path: <netdev+bounces-250113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF680D2424D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5324530069BD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B6E3793AC;
	Thu, 15 Jan 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFGYVBnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D136D4F8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476223; cv=none; b=sFrDzya8A5qJV52kxvXqEycxWtM/hbX77SZinQKqOEBn1Rh8BggL4YYCphpKTORIMfUMh9XeQ4tfZevEg6TMc0C27kD+fEsQ1VaGajfevMfzQ8bvXFovnGu0iQr2SKUtzaijJKgTRVpiN3ibMnUWv6IEAW2zohpcKn7UZPKC/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476223; c=relaxed/simple;
	bh=h2POPUrCWHpMV2zB1+yXcWrLuXsEUmU/TGPNd3nPd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHlIInoXoKUVO5kgXMvOuX6HckQShkhFVHAgGoOeeExDfWoIHEN6NRahH/nl+zS1iuHrMsrMrKjF07j/9g3AqvF83SgSgph9Y5rjdEmR0RJtPDEciPhyFdntetuPeLsfySL4eJzdMrMMzHSjnKkOnsUDH/bP5aly/ZYNVmWj9KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFGYVBnd; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0d52768ccso5110075ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476221; x=1769081021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YOIKFh1qLe1Kphs2bcVuIDAoYDYGha3UsNg4tIIDho=;
        b=ZFGYVBndCFkxIwpg+wzCMybLlzf1tY0pUNqnwOBkBJPxyY4/DXul94brIJCKpi0QKP
         1fdhc/JTsKue+raqYwPSP0q88BebwWrE6RNdCdWPDFkuEu96wdP7q1JbQxUT8iHuC+d/
         oFn5XjgLBflLMeZK6d+WGBTgiWs7CZ0zJXCxL7+lW5mnX+OjUrm4EAaPBjkt6RK2yllJ
         uCqG7jKg1Lq8Vk9BTpiBYtj0tdrmW7LItJ4Sze6L3RRgscEs2dxBBuVWmQ0FIpOOlk2p
         M5wp/A73+zLRhPkliMmzCnA9x5CPFNnbWd553OYqcogbBR5uGSQFQtlH0xO0xuo2Y7Ca
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476221; x=1769081021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YOIKFh1qLe1Kphs2bcVuIDAoYDYGha3UsNg4tIIDho=;
        b=hXJzXOeDu915O7vl5ncEI1o7xQ2lD5gylaf0Pgtgg6kjwPv+onMbg98p1gyyeKDSZj
         NuJi6+Ub6ASZynXHc8jgAxePrhecrNQOW5Y4iAPoTiPnDJREnHnq84RjsIlsfMeL4itn
         eiB3Z9fiTzz3syc1Pv+BLkPaLE2NA4+PFOM7nTn0gJ2faDcJZHrAD21/PLalC0JBj15a
         wdcpq5Qhu4jFhefv0qFYEQckBCfPFrxND+DoBA3DWhsK320b+pgB91tmaR5GOs0ZGsRP
         6zcWcUC592OZr5vL3/Q/jGVImgU2lfcG+ZYEzTSCK1qmnJGRBe1MVAG/PgD9MtZZbo5j
         KEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8Cj5a3kIGBMJQ9e0Dst0ORQZZ8xywsThib/ffpmOI9GdDUUxp6EjEOYFsmwui7tVfX+bBX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8zv3U7yrYU9Ci75OzNk9z4ybvdk4lLQI1PHmywEmmeSGTv4e
	YDViR92xmn+TjSaqxNbbqdhxbo04OFGLkWTc14cvFGVDcXg5muN7IEdO
X-Gm-Gg: AY/fxX5kVLBC2D3eSCRpPiWVGmB/OYTqc4DrohNGyDU/KUundcGC58l2RqZf6x4m7Tj
	jTo8yQqjYcPcXZDBRhDUZkD3lT/AQwvbX2B+ZR8YBAGRgRL8KRO4bu1YWRJsTCO8cCa5NdkQC1k
	bU3L2/zJZlBSwORYzo1uIURncgX6U1O39O3guYpR6wdKPIiSeaG0fHKLPjcufz7onIdNEM2IpJ5
	DIJ3LeacLMkH/+95XqqRVsFhep7iFkvq/TngmMRzdRT7sXzWum3NiCTwI4vEH/nQ6lNcioMuRgb
	UuWQ0KxRxAS1VLhbT4dFphfRBNVieI0vPm5DFO6M9TJNP95tl43b7B5Ctye20GbjcBqbU6KSDBr
	73kWKhJYKKpaiSpRD2Zx5RREBU9HwPgWMUxDUl9/zmoe1OrUtY6nbbK1jpDvT0xsW0in3HwM974
	T/+LwvgKw=
X-Received: by 2002:a17:903:2f8a:b0:295:59ef:809e with SMTP id d9443c01a7336-2a59bb37a31mr53429035ad.24.1768476220937;
        Thu, 15 Jan 2026 03:23:40 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:40 -0800 (PST)
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
Subject: [PATCH bpf-next v10 04/12] bpf: support fsession for bpf_session_is_return
Date: Thu, 15 Jan 2026 19:22:38 +0800
Message-ID: <20260115112246.221082-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_SHIFT_IS_RETURN)
in ((u64 *)ctx)[-1] to store the "is_return" flag.

The logic of bpf_session_is_return() for fsession is implemented in the
verifier by inline following code:

  bool bpf_session_is_return(void *ctx)
  {
      return (((u64 *)ctx)[-1] >> BPF_TRAMP_SHIFT_IS_RETURN) & 1;
  }

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v10:
- fix the wrong description of bpf_session_is_return() in commit log and
  comment
- rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_
- remove the definition of BPF_TRAMP_M_NR_ARGS
- use 63 for the shift of BPF_TRAMP_SHIFT_IS_RETURN
- check the program type in bpf_session_filter()

v9:
- remove the definition of bpf_fsession_is_return()

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
 include/linux/bpf.h      |  2 ++
 kernel/bpf/verifier.c    | 13 +++++++++++++
 kernel/trace/bpf_trace.c | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41228b0add52..4f72d553f52b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,8 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_SHIFT_IS_RETURN	63
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ed41ba8b54c..2efe458f9bad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22604,6 +22604,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline the bpf_session_is_return() for fsession:
+		 *   bool bpf_session_is_return(void *ctx)
+		 *   {
+		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_SHIFT_IS_RETURN) & 1;
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_SHIFT_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 297dcafb2c55..3f5460a6da47 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1286,7 +1286,8 @@ static bool is_kprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_kprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
 }
 
 static inline bool is_uprobe_multi(const struct bpf_prog *prog)
@@ -1297,7 +1298,14 @@ static inline bool is_uprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_uprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+}
+
+static inline bool is_trace_fsession(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_TRACING &&
+	       prog->expected_attach_type == BPF_TRACE_FSESSION;
 }
 
 static const struct bpf_func_proto *
@@ -3334,34 +3342,39 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
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
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) && !is_trace_fsession(prog))
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


