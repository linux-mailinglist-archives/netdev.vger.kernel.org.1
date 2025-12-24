Return-Path: <netdev+bounces-245977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA9CDC591
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4F630B6474
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AAB340A72;
	Wed, 24 Dec 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LodgkAyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A238337BB4
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581755; cv=none; b=n3hHPJiZMWfdJn9SQQsD5X2kcF4U6cxhfBjI44Rr1w3I5CsywzDT8K61wfIzkalzEHwVTs5PeiAfwB0NOBXiYXfSx3hmdol3oKz8a/tcV5gBFCHkSagUfK6YEmdVUbNJKp88JWfqK0nqA/w8iPmfc+LFYY/3KSEL5a9zDQAVQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581755; c=relaxed/simple;
	bh=BuxKbcBrUFkCQTWuuGPow1baEXCjbvqcptp8SFeoSZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAmg/iTekDF3dnBDMbL6heH7C4T3CxeH0PsdNKyB19pAfZdetyMtDdG4bwxrweybdkLnfsHL9d9xWPIA1NlVmoWX1a3rYjholzUXtBMceKaFQk3mrjGptuwVhpzGqZk3ZQBhPePdqKxVlAX3FVOotxkGFmPjhwWuPvw3jmIAJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LodgkAyF; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-803474aaa8bso1602956b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581753; x=1767186553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkdxNwrKHZWUlyJi0H/o6p25K3Dv2TUlLie18QFj2IY=;
        b=LodgkAyFvwshuW3a4wofzL1emlX8STwJ47qAEUjimgnWJyiILWsOPxfX/3GNkRZfu8
         eNTlVIa9ks4j3CrxkWt0T3G2mL793BUDNLG2soVf7SzCdD0oSz20Fs8WEQv+Ri51gMLv
         0aKo4Jb1vbg41UbKA8DeYrJ+qcry3ga4QQWZBbnrGuCGcVsQaHZ//CZJ+HeMLSAY31WI
         XKUa5D28J8SADrJ98NIJWNDsXX9TcL0gdA977aHdOnyr/w8If78soQ8axjud69KtMLPC
         FBmmE+z0xCllaf8Vov1+hmbZXdbTmACJwI7t2LYKx6v2cnh8MbkBw1bSbtWm913gkuqP
         bBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581753; x=1767186553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkdxNwrKHZWUlyJi0H/o6p25K3Dv2TUlLie18QFj2IY=;
        b=TsqMbi9360sixk2QzrIqL/bNUsPhiJ3g6yOcSqiusU9hVT9ZjfAI7/n9Iw19vqF1A8
         MhgTAMG39EKdfzVbeKZ20YP29m0MRVgIf18h9lEZKCjHhnvpORVzwBPv/SzY3V/x7xqM
         rfh8Z8sPihkT+3FIQfxiUrZMWjY5PZFJEV+VMqnSpcwJMj5n5xlk/4kFwYATV6Bvg2tQ
         kTXGhPor0tnMww65bzNbN9nbj7bXW8oxlNA/zP9DqtyxbXWmLqYGCRmONXYHnmhgAmL1
         j63CpIBvStNY8ykEw1W1p3rWjAeikLuue7UELCMQlbpOFftoKZA7esAgLvnl1ffBDmzr
         LeYw==
X-Forwarded-Encrypted: i=1; AJvYcCXiIQC+yzadGvS3leOhOzlFdmJXFqtTAMKIrYBXNZN3aEOj38xunTxwJ3/Ioqq51IYZwvnuMY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxC450DtqaCfsDuPo4nn4/2vaQeEYDDWwOP/wt8cFLqOWp/I+J
	elqlArVO/dv4kMiyPrcWNRllobb6CVJeqdtDpWjG1wal4Z0wb6/eyUw/
X-Gm-Gg: AY/fxX4gkU2H7fiayYjfseVwnN9iMD8c/GpbUs1bHzyeml7uzUX5kGieTCarkmTMJVz
	VWMICeoFB1wrGT/alhh85OM9gCvdPzd6qafyx7g1uDnZYvcW3NGaO6bN9eVU+PxINdD/IqZzDJh
	jHM+h8BlqFLk/gNT7Uo9p7U7YbWvcwEG0gIfroeDWaN5xSL6abiTsNBHUoU06ysVkZ5la8M+g7p
	/wFd8m5e2X1luyM2V8vLIjfPPhQvU8+0VoQB8c6lNf3Ni5nHNzBbBPw4ZalY7J2ldLjq6L+8esD
	YtaEwFzXWlSWY+bpqrnqRo/LUUmGeUR5MaSE3CZIG28pQEWraYEL3v1q5/pkjb0YDj1ZLwalI4b
	F6IUnAPsSM/Lf69gPwNfIDq4RXvkzIAJosgFb21Hlf5e9/b6S15gDU4syCePMh1PvvHSaW7LW1a
	2TQOI5BIM=
X-Google-Smtp-Source: AGHT+IEvbeG5Y7HTA0JguFBt4RGFYeAY9Iecwxakklqa5khgBk4AEDlJru0Y7JITWH5XUCwrC1OI9Q==
X-Received: by 2002:a05:6a00:3404:b0:7a9:7887:f0fa with SMTP id d2e1a72fcca58-7ff5284c3famr18711266b3a.1.1766581752881;
        Wed, 24 Dec 2025 05:09:12 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:12 -0800 (PST)
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
Subject: [PATCH bpf-next v5 06/10] bpf,x86: add fsession support for x86_64
Date: Wed, 24 Dec 2025 21:07:31 +0800
Message-ID: <20251224130735.201422-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION supporting to x86_64, including:

1. clear the return value in the stack before fentry to make the fentry
   of the fsession can only get 0 with bpf_get_func_ret().

2. clear all the session cookies' value in the stack.

2. store the index of the cookie to ctx[-1] before the calling to fsession

3. store the "is_return" flag to ctx[-1] before the calling to fexit of
   the fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v5:
- add the variable "func_meta"
- define cookie_off in a new line

v4:
- some adjustment to the 1st patch, such as we get the fsession prog from
  fentry and fexit hlist
- remove the supporting of skipping fexit with fentry return non-zero

v2:
- add session cookie support
- add the session stuff after return value, instead of before nr_args
---
 arch/x86/net/bpf_jit_comp.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8cbeefb26192..164c745d913c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3086,12 +3086,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
 		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      void *image, void *rw_image, u64 func_meta)
 {
 	int i;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			/* 'stack_size + 8' is the offset of func_md in stack */
+			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
+			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3214,7 +3219,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3282,6 +3289,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3372,9 +3384,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_st_r0_imm64(&prog, 0, 8);
+	}
+	func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
+
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       func_meta))
 			return -EINVAL;
 	}
 
@@ -3434,9 +3456,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_st_r0_imm64(&prog, func_meta, nregs_off);
+
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, image, rw_image, func_meta)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


