Return-Path: <netdev+bounces-247936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E4D00AB7
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E5B53064EE5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40163285C96;
	Thu,  8 Jan 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRNYeYPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69107285406
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839178; cv=none; b=eAMcYFAybE9n8A/9Lxwf4XrjZahYh3AwX1fT66lvzJCz0xyqlGsw2YjclRVI41sPqLW9S3z7KRKdGJBb/tSrHGJ7nK6IEDL5aZPcbv8DwR84o98NIkqwn5SbdPprxOQXkjg4uticM7cTWFrmTTMUophEuaCsEl9SZaWAiUKw6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839178; c=relaxed/simple;
	bh=XHarCaGaxO4UOuhsLfcJy1QlrtGM5hU6MX1y6/kQaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kvCZikBQsIPUKry6k4tVBQHpJAyEsNG2NJzA7uFmuGDQmXSofquaxk84dxU5H1J14/KUIChyCtVovW+j36/vJIc6d5cB+v6SggyKI9mQix9bddTzVflAwNqa45RAIHg/TeGNVN/bakGjzaNHZIILJIx7LszGiXBGqBAls9vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRNYeYPC; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7900ab67562so27464437b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839175; x=1768443975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=jRNYeYPCTZV36MVyBhM2QbDsGL6xJpiOmOW//F8EBOd/vZTzoS8B/zvXndagQ+9deu
         TUtUYv56IkZ2B2MprQPzCN+IXMoX8TGI8rN0NLXiO/tcBwR1yLTlBh1AS2cjRRGbmH3/
         YZ3clLPwnykHobwYkgMiOcmexGiy1ryFFrSG3r+J1obsobBW8h4ZfIPwgylYS91ra91T
         teH8hq2bqH6ByPPrSRhMDxYBM/dbWzkRz9IZUaF+k7JF1Z46dUcDGBposkS9Y7UNLdSG
         0OuHL2NvPff0h+0jeCFGWTFG8SlEFpDBQ8HVXhbYzr9w8ts8zQnSpFOkMszhLSIAJq48
         6+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839175; x=1768443975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=gFQtYRL0LOTIjFmEQJqBOHsMqEtjgEM6x3b+vLGDAApDFxwICF803z5Ji2dyS/148r
         0y29TJNLASgwEBdqk3jQ9FscaElgwl8g24MAlwcnPdOK+28tTSLzyhM4bao/nQ1zG0Iz
         eH1FQqhluQo8nz9JRPQlsN8JgCsIVcIzkajsglpPXA1X7qgb07dF0+I5puIEForjT75u
         rM7a+wtuvKxQYu0kAIIUlLkBMKn/p2VPd1DWgxRwH86pcaM0e5AKkfFMQ3JmaS9+fjSW
         v5QLEZWQCGCeQoUV/vqksU12PbOf3Vs8eMvcfIJ/6YMICul+9x3FSWi2pulp8ljzGUZv
         9phg==
X-Forwarded-Encrypted: i=1; AJvYcCU7kOYs4WiWj9XOymvJ90mPKe8g275kmoar1DvXxV7Du7go0/bp1B7NkfSiKxdYiiEVbdcLrhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3o6uwkm006AgnJamhODJKaDTqQauo/KE8TTcfDla6w74Xb/M
	vVFhjgFxzsJ1PzmhlYbdxvWWe+JEibgVwR8MGYccMdf4l2qr36p/Bzc7
X-Gm-Gg: AY/fxX7lvviPLU+uNby7Lcx9bfxjnj63X/WfNGCacikgwPOdYacl6MfQZybpKZz3Qzy
	/HCJTRaUAvIdHHrruFHdOnNSXq9GQT/993RzzYHSPlSqcqI618xU3gO5LKq8mXE1aiU+d52MTkf
	zKtaMfA0eulApSjQnyaubTT1HdvzOQPFHsrLX4U3VstxcTpzTMSHMmj9Y1mMQ8llcLGiWzutOiX
	jb86IioUOp9Ne8WCS3c0scosHnWkC/o3w535H04eFKisz7SKeYpFY8vW3Remq/mV485ed/1Rgly
	tsuxSLLlGBIHQ/d44HhbYLrZbWMkNGyNS9UqLDfKGixrv5hj8W189IxSRhp+8/Myz1VcShQNgni
	QBBiGDO6xeEIZf59846BOVGObmbl2gB3L4ZH9fLwCJHWJ8HLpbuPCxxnW6s48COyUfAjR7jG24z
	X2BGgUrpo=
X-Google-Smtp-Source: AGHT+IHMnVMqZPVaDxTm0y829YCzu+J8Kf2pktn+5NZgmMCz24JmIVyO3P2a8IsNKjk6erI9ANmAxg==
X-Received: by 2002:a05:690e:4106:b0:642:836:f27 with SMTP id 956f58d0204a3-64716c58afbmr4344656d50.44.1767839175262;
        Wed, 07 Jan 2026 18:26:15 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:15 -0800 (PST)
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
Subject: [PATCH bpf-next v8 07/11] bpf,x86: add fsession support for x86_64
Date: Thu,  8 Jan 2026 10:24:46 +0800
Message-ID: <20260108022450.88086-8-dongml2@chinatelecom.cn>
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


