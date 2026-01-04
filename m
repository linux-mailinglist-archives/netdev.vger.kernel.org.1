Return-Path: <netdev+bounces-246747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE489CF0ED2
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE03306647B
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29C281520;
	Sun,  4 Jan 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwEi3rOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C229155C82
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529783; cv=none; b=oCwmhZ9MnW8tNHESvpYcI33oQLS7ZXePNEj97llOpnM0mh8778KnQTSvDlkm+2kJd64fxDGQCLiUsyvlhiG9wpjbHDIMlxU3v25AHfqPrA1N9K4hWe92GC14UocVxuWyVsMD8YGAoz2xXAL/csUdM6eilRcONLCe6+M7lyL5j+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529783; c=relaxed/simple;
	bh=Vk+W6eyr2IUQD5U+QNmcmmn6L3jEBra1Cbetb1uK2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLu546eKdWcI8YmZIP87v47kTLEWWkCMs+8VG+iCp+jlaVL/8+U5kekSFlENgo4AHitQUv6YhIN/qaBFqpcg2sEDI0xMWbPfxZxxLGdYL1xvoNyO8WJuoXwUn/rH2Im4A+wk2MZ+d6dDEZrkBWIz3t3xPk02Vd76v35gsmzcewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwEi3rOG; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78fc7893c93so95591557b3.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529781; x=1768134581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=HwEi3rOGl6rs7txLQ4Yv/AkTui8CkINcKNwZzquuNTQS+kF3yzQpJ2DWZT52+YW16/
         GUKIkmT7rx+EVAuNqfY+s7GKEwRUID7s1JNqceE8rN8hD3HzTb3uT56srz5wXXe9kSBb
         l1qosiDkixwzlcXkhn/44sBzdqrRPk2acLWna3R9Kyvsz97Qq53AKilPNATiKAlM/RaF
         WA2+ciI43D+2IKNozAdC7FkXnysFkoEn9SIQqrc0RNSxGXfRoOoSmsI2z8XKpDAN9B36
         23783O5HhrW3dhefzjo3Irg6t+r6RXPmYFB0rT4luSXoOjNbVveU266b9zOFiyAAX0bk
         usDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529781; x=1768134581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6UQnELg0jWNEfAf+zm6n+6F3yec3GYQzyGkx+3yxZQ=;
        b=THssdX8fEKd4lPEhgx0Ze3p4VIjQsLL1qLkvrHLjTBzd4nTSjZ6SbmSAIxccoL71G3
         DdpbFDBIofpwGzK1YZZPFRQQdwMpPV3DjwI/ranIl0XCI4muavbk6igGLcSvpcK++YA3
         TSNreV6ALlpXDDm5zmEkjUVbsqkhBsoA8/FUqaCZ1l8h0PIMsOcuZrlOjmn5ltUdRebX
         WMEtrjoAQQrMdHgnvDwcxNzktlfIUjBwyI78TRGOGY3qfUlyHq3aYsehe55H4qVhgkic
         4QvzaIO3nvQpFS7gHrEUkdWA61RXaGXSbq83GTsZne1thDq7BdeliIfz0LIXRfl/krZm
         gzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl/r3c1lkym3AOWFu2wJXNt/TrPOcgFJPkPgR41V1Vejy/UhGF6xJYo+EYYcvSzGTp1XCJwLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMzQWFHV6Bbnd2pgW3DgNjvN9O1qQfX3P91dZ9H0QWFhyKfXZ
	MhoZAaVgniHgM2BbNQB9/1HQa1+935h1BxcrhGDnPKiwCgMeEKoodr/W
X-Gm-Gg: AY/fxX606PZQsmBGSoUx16d4WVQE9YQV56EynqP/+Wji0xfTpysZkkuiAbZLtTtWaR7
	zdc0aBGc0s2tRiDNa8L78mjHVGUIXbu7zdurGHY3cg0vTbhzTOqRyQuaM/xq+4eUDMnbKbFqCO4
	GRdlMVsAdTkwIOsWlRFcIGNy2CuXZGA8pzkfPMZb+CmP216mgNAkXGkwOuNs6ksDyGPbbRl+a8f
	QJdNS/yTtXZehGzj+CP5OoKl0BtUgGlv7r0mtK7IEtSt6JUldBk4j8is0IQGKqoQZS7f285r20y
	X2BrWQQPNFD7g0Ru7cJkPyDRs2Pq+XpXl0qvGhxLETqyVFxjEf6UVSNGGZ8gyVNr1fGy7GKNQWg
	yka0BfBNSyjjsX3amtgw7X/LjL0BRw6roT/kfVgqxMPxkt+rh5Q5Ws2/5Es8sr3FmbK2vPkWOV3
	GqPRktREk=
X-Google-Smtp-Source: AGHT+IExCIUIES0rpnVBP5Dw4YstZJa342yIXF0UaDhHyPx4G8VhE1josRA+AJAHrW7AJglmeJ+vqA==
X-Received: by 2002:a53:be51:0:b0:644:2e5b:410a with SMTP id 956f58d0204a3-6466a901132mr28541542d50.71.1767529781214;
        Sun, 04 Jan 2026 04:29:41 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:40 -0800 (PST)
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
Subject: [PATCH bpf-next v6 05/10] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Sun,  4 Jan 2026 20:28:09 +0800
Message-ID: <20260104122814.183732-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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


