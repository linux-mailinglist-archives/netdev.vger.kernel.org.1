Return-Path: <netdev+bounces-247935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013BD00AEA
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C303027A41
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713E27FD72;
	Thu,  8 Jan 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhaC/dY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB727D782
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839168; cv=none; b=iY/zfBeeAZxli2iW6FjcYR88q+KzhOSzQ3VV73Mo3kLauo26/dJN0XyXd6CD3gtiLtlf4aIsdWFSdWs1KhH6vQ1TCGkj6o9mG2/rjMCE/h5Gn17zodSAfdkqQxokwJc8pVsKXEEvsM6554Gjv59mTGqBK2cg0Jbu6aTz8xXkOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839168; c=relaxed/simple;
	bh=Vk+W6eyr2IUQD5U+QNmcmmn6L3jEBra1Cbetb1uK2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAX+7yFfYiru5e6lnUyjWQh5KJgdcEJKC6ep0Ph7TOAr/OrqtDnjN1dNVdZ6uv+oOGQoEuhg2zq0Aaxs7PHOYUDtenpOn1fB5LJIItbhocNjrgNAI7y6/g1N0sQJ0zzEcZKBGB9CR6A6NTu8RLYl1uWZQcgABISzGJfxYhFBsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhaC/dY1; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-790abc54b24so25769567b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839166; x=1768443966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=OhaC/dY1ecZoUT3nWAaF14ZYYqd5OMqC4cR4R+s2et4PChFH3oCZF+7cYn0u0tZf7H
         /Do7qhcd5HxUnQyiy5lN/ALWZVmKP0Q6x3V7VsAlgF82zqNnLwWqqP9CXCa8FFssUjE6
         IRn1CUSyQk4GBCGjTcMrR6lcM6odWDsJJZ054chWiBSEM2RpYeoi79KHV480gHqDMrTC
         pTN5jMhdvw5y6+9wUH6R5TAuB71j9u/NeZgzXHzLQ/OpY7Jk6WHLrBvkdNurco46THJX
         T/0s3WxH8nz5sCcpmcjEgtkMRDUo71dl1KQ/gq6xTunyROJfH/XovPTtJTUtDWYHNdVY
         TRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839166; x=1768443966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=bAg8QjAeW9MmIyAaI/SwjewWZUfKVoupmC4M8SKHUCSzj1pUn4B6xKCLAmBmNB5aQa
         4+Y5vUWz97CRELgbiZWd9ZIjUwfTDt+xaqId0fG2xaTzP3SA6ymbmUzH4lmaar30VBoL
         gWYGdldnwSoWWAV42OcnsMjJDb9CjmAzCJekbZTL/4vhSCc1niHN99v3+pMQF2Gv3Emx
         7ZqtrWWubCAozPbVzWLaZ4R8I89Yt8nA7/dnfI+iLwrBsx3mWowtzbHm+B7whBB3EKNF
         nUoNxw0VntUTXpItOixhsM2ujW7wUZS1d4KVSZF57MftZp+wWDxsPlEbknDYZxepCKu0
         x9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUlaqmEdXQGgl7ElfvTCm+UfK+ZimmLNvrhmaKK9MFgtBjLtip63egHa5lN9cZAIGDAwqaXUmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO07ZCZMn7DsWYirpgzTD1+P4muCdaT27yLYRhbogy2zbh4y4x
	axzbUgCDqHRVBl2Og4aH9EZcsbuWJPvifzSFiKtBqZKVCjI1nRpOquJk
X-Gm-Gg: AY/fxX40jNPYAg9mEPLSgqwTEGuyzSAK6mLX6T9TqplDbjAp+5gXRkQFI9eJYUaXl/u
	Voqt1FzS2Fji3q9soE1Ow8OH+tySo199b4lkBIfRbWQUw44O2ZSuCCw1r0Y5mnrZycz+t96O//K
	WVZ0w2j6UxOAjSOIQdewyOgW7sD2u+baop8qe/cDNY+licojT0UAMMSZ2n5G5QeBYKigTYvGaB5
	D6pvoOtvM81BG3lzLzeaaaI2I2a8o99mjS+0YkD1e624wEMlUf8QHGVLEbAr/cK5D44NBK2vPht
	v1t8Yy4hSh6sPI7iS3TOBCISsQM+JdWJc9crLNu/oW4LR6OSdhjKCOpObyjS8jtxv0FDMraclTK
	7lOzOfFx5NQbSKhgGW0x5z1KAM+f3A8I2ModMAsQu4y7JB1WikNVcpJ1Sc3ngotPOYbAMgLWcsB
	ISB6vnOYb3POsGnEdCQQ==
X-Google-Smtp-Source: AGHT+IH3w0PVzJutpZZWvbHJnp14TE6zHYkgRIkeRzvOCfFzjh5nXjFqTNfNUhUJu/4O8mFMK30lFA==
X-Received: by 2002:a05:690c:6285:b0:78f:8666:4ba7 with SMTP id 00721157ae682-790b56add94mr37794607b3.49.1767839165938;
        Wed, 07 Jan 2026 18:26:05 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:05 -0800 (PST)
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
Subject: [PATCH bpf-next v8 06/11] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Thu,  8 Jan 2026 10:24:45 +0800
Message-ID: <20260108022450.88086-7-dongml2@chinatelecom.cn>
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

Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 to
the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..a87304161d45 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
+{
+	/* mov rax, value
+	 * mov QWORD PTR [rbp - off], rax
+	 */
+	emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *   mov rax, nr_regs
 	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	emit_st_r0_imm64(&prog, nr_regs, nregs_off);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * movabsq rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		emit_st_r0_imm64(&prog, (long)func_addr, ip_off);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


