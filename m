Return-Path: <netdev+bounces-253013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD5SIQI+dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222F7C5B5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C07FA30692E5
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D3286A9;
	Sat, 24 Jan 2026 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1823paZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09532199FAC
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225556; cv=none; b=plEZYSeuugiISJxsk5uei63WN4v7epDzJzd+JmKXS3BMDRCbfxLNR9fH6Dr0FF7UNPGU1AZPIOaVBgWaq/kMoX/xjlM7MikUbZUNGZVZBZPt47ZWjfGIhKuzbj5aLAuimCg1JXm79I6J8givgdpLmoi9hoX0XSlrUQathuf2i5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225556; c=relaxed/simple;
	bh=EjnGJ2RP/1JCMlZMGRd+YlmPnDkDXdlwIR1/R/iLIq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud2TXNb86rTwEDMBy14+TGYKb98Q9dlpqyyXVbzhNk4xAS5T4MPbL1cWf3ULH9bBVaSk3Nj+19dEe5LRUK/EcZPLZkLc3CIvGT+I7YuYgw6QhiApwuMsZdlyq01D6DW6OPxsXnWJ4HVxCd5tJSSBthzx3171vDih5tz/1CoKgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1823paZ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a2ea96930cso18406035ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225554; x=1769830354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=d1823paZw4r9MzXNS6avly14JwvRFGvzDY3Ytv+15ec7wlm1ovNNzyxhH+pndekILI
         9wwLRbTSJLNQSOc4l2ah2K1dt5xKLFVRwer0GjDPJWMC0ecRk2SSGCoJxDn9HIelmZZw
         2/UkTeTtqIn82iOHEIczaE8BAqWt1tIBQBG652Cummr08BZJqtIj20j9/PL5r4N6o/AP
         PlCePVsTOzMELu+Cz/7YCXLhtaaj+5J+LC5sD7RXojTNoOnPrvS9cd13qB87fShvoObh
         F3F5V1W9emwyAe+ytnZbQ/QxijvAW5nEwwnehCwTsFlcV/Z1zUvnxdz3hkQ6c/PJXwZ1
         L8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225554; x=1769830354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=osBmkLk+Q/gc8kzZ8+xrLlx40NAm/v7G6OV8EsCeULoyJYoZn6gd6QU7QkW1ZQiFaW
         fT0iSrQe06w6tfjB+XwueoNsbUsz6GzrxlQEVMqE85DeOGjmg8LMg8bufIsHc/gNj42X
         jsKWAcfECO8zdABw1GaEIYp/pdrb43ZWkhRonfVLkqbp9Y3qPSb/H8UP7f3DOjfRPxRL
         8dmTwivM9rGKwI1AXFSjtFmJHCuG+qaDoiRj9gnV7oiq8a1eNkogc03QTvu4Zxqppb0J
         fP87C2KkZYD29/8zv9E9qhRep5dwZatwMQCDXDOost4mb8lwFNydKprVxkdOa/XpCFyG
         uECg==
X-Forwarded-Encrypted: i=1; AJvYcCVt5muLwfjeVhb+AeUkIe4uryNg4T3pEAgf87f1kgGoLx3uMUBRmZchNSClxUZikidKDy5iYI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVH8NJ/K5BxOJguYmlHMe8GRjSbdVGEm5SLmotd7bC/ykDsAXC
	afPVLvqAHmeBMy+75GK3h8m9Z7oLCxpAcsHqahjfjE/g2rG3oQm1W6/3
X-Gm-Gg: AZuq6aIJ99Rjn1g2Q9ALLxej+Dz09JkP9gBFbZGGlX+ghpp4a5S0Ys1C7SiZR6Yl6q+
	EqRKfliSPLs7O3x1VUH5ECnsQXDut1Dx0Fz3H4lfztdEE8j2Xmd0sp/atemUzT/amAt4RcpZN+t
	JKzj3KFvAbSPMv/IYYfs74KU65QrLdyOvvL4nZ3KLJZsCyzYLmxD+fJm277CkwNGMRPViDFgAcz
	dLpRfOSPHeAJsZ3LvUOvQ5H3iedZntMDM0s56j651g0yDaOQOFxTZ2cPvCpeLwKCJ8bfrC8IsLJ
	lrnDzpQCsr/U6xMxMwidxZs4kD9ZneMlfn3t1naNeXP9TQ+VMZB3q/TEHk2ZI3YyTmd+X0iJ9e5
	Ot4ZDtbCQvtquq6O4k6xK7ezWQyLB4rkMz8PfNaRZl4mQxHdDE0PXzb8Hb+/CklUzGpOqMpBMz6
	kMaaoJ2fKN
X-Received: by 2002:a17:902:e884:b0:2a7:80bf:3131 with SMTP id d9443c01a7336-2a7fe77b3fdmr47454115ad.58.1769225554264;
        Fri, 23 Jan 2026 19:32:34 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:33 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
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
Subject: [PATCH bpf-next v12 07/13] bpf,x86: add fsession support for x86_64
Date: Sat, 24 Jan 2026 11:31:13 +0800
Message-ID: <20260124033119.28682-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253013-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.936];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email,linux.dev:email]
X-Rspamd-Queue-Id: 0222F7C5B5
X-Rspamd-Action: no action

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
v10:
- use "|" for func_meta instead of "+"
- pass the "func_meta_off" to invoke_bpf() explicitly, instead of
  computing it with "stack_size + 8"
- pass the "cookie_off" to invoke_bpf() instead of computing the current
  cookie index with "func_meta"

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
 arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2f31331955b5..5a075e06cf45 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      int run_ctx_off, int func_meta_off, bool save_ret,
+		      void *image, void *rw_image, u64 func_meta,
+		      int cookie_off)
 {
-	int i;
+	int i, cur_cookie = (cookie_off - stack_size) / 8;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off,
+				func_meta | (cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT));
+			cur_cookie--;
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3218,12 +3224,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int regs_off, func_meta_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3259,7 +3267,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                 [ ...             ]
 	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
 	 *
-	 * RBP - nregs_off [ regs count	     ]  always
+	 * RBP - func_meta_off [ regs count, etc ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -3282,15 +3290,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	stack_size += nr_regs * 8;
 	regs_off = stack_size;
 
-	/* regs count  */
+	/* function matedata, such as regs count  */
 	stack_size += 8;
-	nregs_off = stack_size;
+	func_meta_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8; /* room for IP address argument */
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3358,8 +3371,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
+	func_meta = nr_regs;
 	/* Store number of argument registers of the traced function */
-	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
+	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function */
@@ -3378,9 +3392,18 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_store_stack_imm64(&prog, BPF_REG_0, -cookie_off + 8 * i, 0);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -8, 0);
+	}
+
 	if (fentry->nr_links) {
-		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, func_meta_off,
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       func_meta, cookie_off))
 			return -EINVAL;
 	}
 
@@ -3440,9 +3463,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
+
 	if (fexit->nr_links) {
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, func_meta_off,
+			       false, image, rw_image, func_meta, cookie_off)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


