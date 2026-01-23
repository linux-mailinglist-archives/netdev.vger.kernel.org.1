Return-Path: <netdev+bounces-252664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNmQBfslc2nCsgAAu9opvQ
	(envelope-from <netdev+bounces-252664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5D71DDC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 716DE302C74A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60F334373;
	Fri, 23 Jan 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehBnYl5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F293128BE
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153804; cv=none; b=Gk9rGbkMhrq9JXNTDn45V1RAIX5b0xvi39KdFN/LKKmZQ/1E36Bnz7iDj39gIlZkDtArDWNmvZ2K0PHqzq9zVcemkdvwP8qrWfAVMqNZs6evhLF4novrVy4h18KIJiF/YCtZwPyLf7SZ2maNeTOLS+8wTxlbY4B4u+s90u20YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153804; c=relaxed/simple;
	bh=EjnGJ2RP/1JCMlZMGRd+YlmPnDkDXdlwIR1/R/iLIq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQzxcoYL9KveDjgSJnmvM6Pd5BQ1HHox8JjXK9kFxLGa688TF7W7XHE3JdVBsWFTsVsvMtbEVVdADvQVy/WDWvltxit1KIgJHLqMHhIyc8qdIt7qLN6wjTSBcmkdk8YsSR9elIDuYibOk6PbBDRwXICQJ4tf7uHpBkzREDFjNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehBnYl5D; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81db1530173so1031399b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153802; x=1769758602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=ehBnYl5D5LAYfo69BHwiHfRDXqKkvsFFmZvVl9HEheKQJbu/WwTLTt0Xk2FzlgFvD9
         VlBZZOWfkJzf7brJORXTwaPURO5ySJ+3u7ICI7ALvqmrPbqgxqRwNkYhRF2GRicDEglZ
         ggdBdjLOrYZgugAOAPq82KrVgJ2skVq2y+anStGs8maZc1h+01nvVWwTFbl/Bx8mx+j6
         hvBQFNVVUaAzjmQ5r9ZlwXlYdemevZ5dgr0uWztB89pSj5POm2JZkOM04w9Po2mtrbWk
         Psq33nyTTy0x4nGquCU8+RCr2sueBLMD4VZ7FNSqfDzROEcTnQpW4sCW0XZl2jYMYM0J
         LeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153802; x=1769758602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1d8/vt9Be4w9qa2wV5mcrLfqVviutZM7Jiw2hF3kLB8=;
        b=Am89SNIqSVmbqCNDhe47Yg5YsVhIDzuBrlA4xmeIJH2fCosdPxoMmhHBF1QAC5wW4f
         rQBy0pKSzXAGjCJLxg9phTyle7oS9QqEdNkDmGEOjh+nVHHbU06UoOPc67ryBrazPUNw
         yb5zosHPgSgzklLZ+OodmNrJHNwRFmk8HYbGwgM2ZunZ5eT0RkhkyyyEBwOKPQ6oL25W
         D9LSIIZPi1x4pF02NvRRLsjNIkOJu+wiEzs5bgTa31r/CRwLmU73Auun1ZRo5ygZGHXD
         BtdZE5F5jeqwdmFtQIw/qmI7sOLZJHkqeK2jlkdE834kMftQgyBRxKzsz2wS7DGj+s2y
         +4cw==
X-Forwarded-Encrypted: i=1; AJvYcCUMHf+LZyMV2jgP/i1Sg1k8gtDpu3u7OET9Km/eHf8vM76LhXYKD56hc+/OIKYVYrtSt7WJvGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnT7nJ5Va8YPMuvaFtNT2D8UOoAgPA6sWVY8tiRUf0tew/o60
	CtP/09P9rBmqrsLUYDSrsAvdYsCDilMIu6gMYHSJBciUXKwS2pmahgw3
X-Gm-Gg: AZuq6aI3VkxuSM/neH6qDarAdvhlcr1HkmnnrfHIROb5iv9haGGa3QRLWWf3ZSWYQCQ
	XzRs4z+bEp5XrAUo5YYxQbxk4fFWpuGobjez94cvrBan1xHjUH/bKyVQ7I+GIq7LRNXriDqXGux
	pQAVHL2szq+yJvkP8IBRN3Ee+xrQ8mRH0AF8R8YuJPVh6n25Cg05kk5OpVk5l1AkWba82y4dZeG
	CEB14ap+KTe9d0pdsKRfLA3v0wzcLmZ3sgZZGXNNgCk44Sl/SrNU9j1GT1YfQugfER/dL0pfSW5
	of8gVGoSv4LPhZk6lRMzfTRJvM5jgnxpwNnNmwtvdhRMx0u76z3vx5Xf79MoHYCczpyfzjwCUI6
	/L7JzSNAuzucrATlHM0uA+J5+OEDvkviuzFe4iYFVQ4kvBEBn1wdys7Du4yqSINQFpKf85XG+q6
	6RTVDV4TLo
X-Received: by 2002:a05:6a00:4ac7:b0:81c:9f57:3090 with SMTP id d2e1a72fcca58-82317dd882amr1651384b3a.24.1769153802384;
        Thu, 22 Jan 2026 23:36:42 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:42 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v11 07/12] bpf,x86: add fsession support for x86_64
Date: Fri, 23 Jan 2026 15:35:27 +0800
Message-ID: <20260123073532.238985-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252664-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 86B5D71DDC
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


