Return-Path: <netdev+bounces-248696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323BD0D745
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388F2308DBF2
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7821346AC6;
	Sat, 10 Jan 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr3NB1Ou"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F13469F0
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054367; cv=none; b=cvkgl383cSj1lm1ZvKwdsH6o8aVY1TmAfsSPSOwyC0XuzKuoWqpm7655ezXS4b5HNcvtyrb2vS4Hs7rSJkG/6x9q4IRjd/qe1PBI0FQTVg3Fvc8w4GGxs54njN20ShLxuiQQ6GJe9apt+1EusEHosz4uFaTqK2ktqCvQhA2kseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054367; c=relaxed/simple;
	bh=UKWXQ8lrzEPWgxemDQ6yw1XM1w6GFT2HGNkxpdD4QCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKryw1oL8+shwYZGuJq/1uqjUnSduSjbpKKyNhk6wkbbArccSrBcep3PU0o9TQ+881/infTOggBKsL3vrlqymPRncxfcdIw2Z53HXkGbVQck2zxICZkvMe5au5I4pJz/iV172OWlEX/ZayV8Y9jHxmzppXQEdOxTfpfBmjOMxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr3NB1Ou; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81dab89f286so948452b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054364; x=1768659164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuDJq9OcqlXOoYELFFiMxpUFbHiZNG+R5rDqqX2qwUQ=;
        b=gr3NB1OuUqE8dhGgStPxbNpGmJCzdiGVIJH0J0Ai2da/zqHsC6FhVyDeExcn04poYh
         wteR8fNdsrrD1fvOtPdNNeqSlCibNDmv7WfiMhAh1GyI4c4n147jsGiBW2s9txPrwQg8
         MB1CNUXRhmEHx5Y+YuOnXNjFoCDD/dphHABmucrk0O8APrjuX7MdTOiMDesPoK1CJF1R
         NumXRbBQ4RffGmUY41CrWnK8x08AnopFAB/w/LEg3dqtCyknD29V2MdkS0cy71w2sHo1
         1GSp2PvMFTuVZ5bx4Vx8iNDO3i/ZJujyQ4m8lxs3Z//26ZVGGy4humW9or8toFg/ZXk2
         Idug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054364; x=1768659164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuDJq9OcqlXOoYELFFiMxpUFbHiZNG+R5rDqqX2qwUQ=;
        b=bvhAJJVUkH436t4jqZJpSEsVwe2Pep3K+JhlxoVHgQKaWnr+SxC611t4tmAx7yMkzM
         Oz+YjP3xde8WWvJJ5yl4mJykOpueRXJ1j1MpjB8VltL/xj1HcqfJBJVVwxb3KXXnF4mG
         peQYKl4sx6zzzuPhOOAitvMVMONk2Lklbx/+3LdGADos1ICBwodlzVlejD4Gx3QkZvqx
         EnxCNcLqAWk2AMVLfh8asfHINZYqTRd2vajEN2phc1uPuuB7KfqLVYwa9O7qKJX8xlJI
         bIuNvmnpzsGpt54slhjsAtNM1IbT7xSM+6obuAQIiOdt6uuODI8hoigSLCGYKSjgM5jc
         Qtrg==
X-Forwarded-Encrypted: i=1; AJvYcCVtZR8ChRlbqp0kZ9liKvkJUJ7U68XprIsNwdJE0cdaxhvfn1FFppxyjZ9vMLati1IROT65EI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEe6FLsGzDgKu6X60iY0Qx51A6t9Fq5499F3XHsfCm4WNURFZb
	5sfxdwFBaY9MOPV25XJc6WXW+Kf/2umjnRPr68N6MOWpX7N9UP3FHh5I
X-Gm-Gg: AY/fxX6VOZJkiUzZ3Jt1Ddd2C13yrjkTKLvfqzWhw/1frnETAl1rLVMD3Skq+Qw3a5S
	pVu+H3pkOEuhxw3pSPQWqTWIQEU/KRwM+To8GJxvPjgfIn94US1tEay31zJRyh6nePAXueftTEG
	SgmrEhYoTGGi2uMudR8mF07yMEGCJsl03cQ4TBPKbZ7lBgg8eHQdpOmQPzF1A6QT9RqLQGrMtFv
	kyT65iPaDNxlmZpgBoS6pp7xCAzwCtMu8hxfwYsRorg3WERNbYAk8C+DCoXHBfxoDC7LwFVvGOA
	GVxbadCCV5w5eBiIJjdu4TkVaK3DAFJA8Lb8aLlMXUXCz/5t/6pINbZiEkuYvihqYPsqX0Wjbln
	YgK0ceMLnZQD2Fua47McSlbBYd0K5hT6Sc/Jf6gbmK5Gc2lKiKQU05oofZwuVZJ7mu/F2tFiExY
	93SIieswQ=
X-Google-Smtp-Source: AGHT+IFLWfpiux/Kh9OQtDcuqehT+WANU8TvRohmEzGWI5MjMm7PzROsSMC/B8nDbc23kmcVsN6PRw==
X-Received: by 2002:a05:6a00:ad8a:b0:7e8:4587:e8c5 with SMTP id d2e1a72fcca58-81b80cb141cmr11319417b3a.56.1768054364182;
        Sat, 10 Jan 2026 06:12:44 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:43 -0800 (PST)
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
Subject: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
Date: Sat, 10 Jan 2026 22:11:11 +0800
Message-ID: <20260110141115.537055-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
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
index d94f7038c441..0671a434c00d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
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
+			emit_store_stack_imm64(&prog, stack_size + 8, func_meta);
+			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_store_stack_imm64(&prog, cookie_off - 8 * i, 0);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_store_stack_imm64(&prog, 8, 0);
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
 
@@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(&prog, nregs_off, func_meta);
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


