Return-Path: <netdev+bounces-253041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKmyHf5ldGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:26:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2C7CB40
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0B94301A390
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4527E045;
	Sat, 24 Jan 2026 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9AfUlqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A3279DCE
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235686; cv=none; b=E1YhmlmWbw6nMcb2agIXjviqYRPx49uNTKh1KaJWHMcIjMUd+zr9OOOkTztoN8ZLDinmn8qCkCqJulum+oC+J5varsjGiNV5xfxTuAvaCKtv2JICmnQcqN5LYkcBx4ZrcSj58yD/usSO2hZWjVcqeBLTMMjr4x7DAkfSiyBL0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235686; c=relaxed/simple;
	bh=EjnGJ2RP/1JCMlZMGRd+YlmPnDkDXdlwIR1/R/iLIq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AW7LTWrQnR06sH5KXlIxQcmMt39hmg3qXacFq+z9w2WmNP8T+k7InRiOLj7FbSXsC8tjkHS/eRo48cTSd54hfD0gy2XWfLKZasqhjNiUgy8ZJ8H9RM6o0Dpp319p04Q+yi23CI7KCgJmclq615mCjphNzzbBoxprpYSX37DS9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9AfUlqG; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1085555a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235684; x=1769840484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=J9AfUlqGapkafb6DnWCLl9AYfCDHXitdfIGFhHP1lvLhOA5izbVNp2ETNCUgqSzYb7
         IVwYIpcpmYRF6+KW8t4gDXyJ3Ko8kybz87TQGcwqu2COv8Qs+y9FcO562NXsreYukUrH
         2oTqQnAunKW8+weBx67nC9avAFwgeSr83U5XfEb0Ti50aLU7Ms7kery7/yEh6lRAImGk
         ATbayV/XJIlgqEgasSzGzrSb7HJnI46oq0hbx2hQkhj9eOSGth8p8SCKp30uU8sfqUlS
         tDHZOkF3TKl9xNUjnmjn0r/g/epT32NZ8KrpSMZ4U/C1Nv/wggYiSAn/msmrffFPmGP4
         46Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235684; x=1769840484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=UsXil/IGL+vWupxBfiJZIl2v5mUPuve1h/9gCDDrKtMExO/dWNLxQHAA/OjLac0HLs
         X6WkeEYLPKRWM0/ROUM6XDBcN210VdcLQKBnCVsrfpUU4h2EG8y9Qu50w+QFBqK/0S49
         uHkBaR6UhLHmaKivmuJeoccwHPQ+Cyuf/sZnCzsEiAjNKD7QRN/poDi+KnrXccCIPx65
         jvrnW85Rf0DBA4IPZi698xZ7aQp0qQXPV4a8RSd9e3rtsvg831Bm47rqIMOY9VnafCMG
         IF5ne3xgYKVm7qxD1h5SMz8b+TVcn0YMrA1CbKXr23ZqDtx/iCIikpZwR8JCCEcxlMpH
         ItPg==
X-Forwarded-Encrypted: i=1; AJvYcCWpipQWmsFB2u9B1s1aZcy6fZkjlUlKlyXans41bx1EhE6R/z6yj/+0NJtDv81TCvvxPbuVDbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwx648MFJTta78uNPtQ0sNwOafEo6rqwJLhaLx+yWqt3k1hxF5
	tz7d17InOYR0r6F4qAdxOcT0YQvMRaGXyj7gVqESHMQNglAZSs2d80ur
X-Gm-Gg: AZuq6aKBtWkkE3Vv/IHdidqeZBWzCXKnDbG8n14oUcLMgTE/NEYNjls7zL/oXkzKnIJ
	D+s5ZaGz42QqPrIgYo1qmVrsz1ERf+gnrjm3q+wj80J3yYaGdSaMkUGkTCvzQWDP1hTat2rAiHx
	xxIXKBor9GyayWdauo8AaOtSVFqJfhKAljjIYBmOrQrkiJxTRH8ZaERV59fh4ZPacba4sjXzqVn
	hVhkXSsW1eeqQG35PCiHHVjE+YJzuuFo7MA/PHIxWKll6W+jGq36aeJgoYZo7ftPX5hwXl3QMWL
	mk3OxQmBqGuV6SqBnI+MCn8NzAcDpUsjfq4aUQjCItzaBiM6sVmkat59ZNnMye7LZ/a37RoIFhE
	18JHtypH8ORyjmlouNbN8GF20p2EikziAWvi7QKIb7Y+XotSnGYvWN/ltxV48AepJGGEH8hJEUy
	OmFe3tIoGT
X-Received: by 2002:a17:90a:e7c2:b0:340:d1a1:af8e with SMTP id 98e67ed59e1d1-35369024853mr4563026a91.37.1769235683967;
        Fri, 23 Jan 2026 22:21:23 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:23 -0800 (PST)
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
Subject: [PATCH bpf-next v13 07/13] bpf,x86: add fsession support for x86_64
Date: Sat, 24 Jan 2026 14:20:02 +0800
Message-ID: <20260124062008.8657-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253041-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: C2B2C7CB40
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


