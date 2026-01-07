Return-Path: <netdev+bounces-247597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E5CFC38A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 07:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781603064D45
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE327F736;
	Wed,  7 Jan 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQlbokat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234327603A
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768324; cv=none; b=agqi2ojzqN1tGEM0JnVMIV9ZJhmOhiHLDL+CBPuWBsjDMQY6QN65+5J0k4F5+3awUYXcEoyOzKoOfR1VtB2Vev0OOGVRe+W9SaMcVYdakYesgZUqDL/etqSTNIUqsYq6+ORUvvRHHLoZntP+01eqrpfjbxz8kZel4hWmOYtCwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768324; c=relaxed/simple;
	bh=XHarCaGaxO4UOuhsLfcJy1QlrtGM5hU6MX1y6/kQaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyIlEMCPOGuml506JNkwKeV6lUwLE4RQ3VRVNYpuLMdhYfFHOsAqrhZf54DuLJ5r5wYzm5kVLY4Vw2WAG+OrJ6der7y8YzO6nJCwsvksSiP7FXGiwkLY+3eXoiuE9MQK1RxYyAzzaiMy5vxvKlTLsImUONYlDg6fKpI29KKVeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQlbokat; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78e7ba9fc29so19955387b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768321; x=1768373121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=CQlbokat5/UVYYMK4IsMfRWSdQl3A2/rbIEzQiKT8rTYqaG/PlMKn58qBZHMJqY6PG
         pUgWkrQh6YERUCSBtfhEVNBVzGvPTramctImvSD1ANKCLpXA7dGPjRl4VOM3HpoorRlY
         9XvyjwpRBtitHXWBghhzpFDsr8D3xnCHdvlkLdP7fo/OQgr0xSICPACCb0KM2geTLDSb
         MVJg2ffZWfFJ2CsD8N7TgV7jsQhMwews0/cH4mTk53Et0rCZXha7VKaVrKHsJ/dBZBZE
         2KqBEpoZ8XborpJ5h1gRAG8W0N21iTMFbBDe5MjhP5/8YeA+SnF/DEviNzulB1+JN7qL
         /o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768321; x=1768373121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=DZzZhcI6ANSgGv+eKqk9K7aHo/jfS5ehwviqayPrSDdE837ZugciFvYRryAcXAgjvO
         6xvRU/bAotLMwhcMo9ye6orEDfxxKZ9uVnj78UADkNbwaJLeug48SgYUkWe80uCpz7uD
         1YJzJYCV4DqFTJgU+/C/QXn3nxXBmsbAbzg5F1Ke500wUYc3Jiz+uxff6wSV4MbrRUd0
         TYtZulyKa+T4kHR6xzXgyJrX9mKvSgAWB0J63Q5Hk4+kV4dqprmn7AdRrMh3u8o92oH8
         xieDpei5s0QjAgJZuOazapHxEcHVTwPeJbrpeHFDFNA66J97T3M3T+v953dGX9foGoAo
         GDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRAPg1KbP9kCUEzuISxJUGuhKIA5bXc2XotoY2GPZ+/PbtJag+qfAEp49Qyx9+l4O2hpUbtr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vxfVVWc7GilKe3145KrDmXndw2QqGo/IxWWDgcNZfdzLOJy9
	Z/p1GZbXfw/b2gtx8bZdQre9YsxivKAAzbC8UKQ1y9NonSWJTeVySSfB
X-Gm-Gg: AY/fxX48jCVohZBJHxCYsLPuP6ILB729X18569q2H1LQu2VjVgxMF97tE5nQaQJN8Mk
	HMBpmyfYkrfN9d9bTDAutlQbeXZx1jH3X92pBrmFv5kW+keeV/gcC7m04g9htA7AyY/47u5V8Cf
	U8jPg/AM6wRWf7y1X/bk3ro5ZaFbzG7lbej/9TZe69YQ3UlXmqLyRxyZ2h59yL6ebIN3Z3pdnxm
	JRSYb+KmREN+FVVQ9kbMp0ipytMMM9CVBRAVF+x5rUJQW3WkVp4nb9x+F+iUrE+bdWjih3mItBt
	UVeCrGsHrIpexfMrfAwqUNyS6TzzErA3n0mIsRHssD8jDSXKcthyRM2ayLsOeV5P4suUNxRimt1
	6W+InbNkJ4WLDbMnImrAyEZyK3kBzRpPRjLyl/MqC7/hmxs72qsZUnhFH8KuDwCFWxTKkuDGh8S
	C0elbGZ8ABs9yVn9rkuw==
X-Google-Smtp-Source: AGHT+IFQwZ8JqUgzAhI97yEdL+gAVwRf+HPm2jxhPz+VXVx31xofYms+tNraAMtA1CL3y+eUpP+gmA==
X-Received: by 2002:a05:690c:c85:b0:784:aec5:7042 with SMTP id 00721157ae682-790b567cc26mr18001097b3.38.1767768321214;
        Tue, 06 Jan 2026 22:45:21 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:20 -0800 (PST)
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
Subject: [PATCH bpf-next v7 07/11] bpf,x86: add fsession support for x86_64
Date: Wed,  7 Jan 2026 14:43:48 +0800
Message-ID: <20260107064352.291069-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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
index a87304161d45..32c13175bc65 100644
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
+			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
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
 
@@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
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


