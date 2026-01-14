Return-Path: <netdev+bounces-249656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10FD1BED4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83B130559EB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9828CF42;
	Wed, 14 Jan 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jiw+OVm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2C280035
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353847; cv=none; b=mxegoj/zCmKC47YnLFKX3zSsLvnkyNEr4ZwjNEzgYyoQqxsyKAQ0KcYyqaep/P7xXgUyCnAiIWee2R7hqicgTc3fkCXYSearLnleExnO5r/SzMOyW1bWsc+Xi2KDTKXfh8aeigA5o155Yh1s0fBEgC7AKcLY3p3XCBmXWcANUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353847; c=relaxed/simple;
	bh=AH47uxadgfiEdcOQwb1ZukuRWMz/dxNoKIcMpvCvfgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJVQdiYMoXhhQdLhMCZJJbMl5MXn9jfSy4AFo0KcquvB22Y/pD+ZXLR2jz41ahUZO4cJSjLVZRqvPOc4Ix0dS1ds74k45MltSsfcmVmXb4YQRceHhrshIReaJ934wMzYy5PH4BtFJsS4WRSHyyoRum4jjO2gP5tkVxzkr3ACOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jiw+OVm6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so667247a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353844; x=1768958644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyCkWzRw27W+PcJc2aWOLu43DBTDJBPxgsYIG4uySlw=;
        b=Jiw+OVm60VGTQi0r+y9HByfnFKrOQ+2CReaqvnB8Fvj52OPwchMaJjbCVTQV0IO7kb
         gSLHBcRbt/6+j024Z8Dzfleobrk+aODqD3EfR2ViVE1pXJniPB6tfVvgriF8ObkvggOs
         WRJT/stqD9lJDs+QYaRJdpo1ilkUyL4DBMR61x1eXSMDCpKO7gmu2XA1KrbmgX7QJEt9
         GTj2ad1i3hL9HoMC9W/glnHMAYjZUhbYhzfJZheQ6utdY59uwYPSdHrGRcnP7/Af2MzS
         0p2bGOkd8xcwyVFyt+SPTknI87FgE7yMi3P8ucmWo3Sojbp/rqa0z5Eup/0tzdogcQio
         yj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353844; x=1768958644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyCkWzRw27W+PcJc2aWOLu43DBTDJBPxgsYIG4uySlw=;
        b=k7M8OUM0OQf2+TNBiLJe9i4kVW3KX8pnZwVGRp33nJXqd5yUCjRTJKF79RlBR9EoUX
         1WcsTlpedOYY/URt4GySh3zfsXVjq1zUOG4qEG8hS29QP08uAsN/AMwDEmNDN21Q3QOu
         FUD7Zh3RXlCEwvuuS6Y8kLib5ihQbW9Gfy1NW9fFv7oouNfJkQczdb4gpQK7p+4OYc3R
         wIsU7th8Qi3tFSWgNZlPtfwhDhar30pOBybRPsLK+Q1lOUcMdTHNiCFkPDpWN1KBLxv3
         0g3ODgl52c/thLmuLjEEvFmI8r+z74VtVyJow4WLYXUcFRuIxgBYsEDgCl0R0F4XwoUK
         1Mog==
X-Forwarded-Encrypted: i=1; AJvYcCWuI2OkzbaW4ye/iM74tQMSkZoG8+U4qi4ZVIpsX2ocNbWIyfxhF+zo2bSj7c06INksSJ3mRYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7vqQj/trruPLKxlBbi2SNLVjLna/On2dwyjDuIYQw2qkAne4
	SYKU4jQbCrnbzhQeDhSPabrQGQMFz47aNkG6684xWslcmhjQGJ4I53+/qgprleThdm2DLrvjxix
	8o80Dan8hurOalpIUdiTYJfaXXUSgnZI=
X-Gm-Gg: AY/fxX7g48qtnW8lEQqinzWfQSthiI6j/WK6CC4U3k8oW7jEZ2+u75IqeuvdTlmrN13
	CyjewQ2P43gQCnMjlHKh5GUoZdApCK3m/dq0fAHfD0EGl5k3ooyxYy0uQGaYqWUG2Aac31n0tf2
	pymFCSkz21JkU/NpFp60VMO3ILCXv90GcBXr9wa/tAa9+S1hHPX68Mh5SWC7el7wnFujUlTLjT9
	LHf8hoc/w1Z+p+0p18Bkd9BqB6lo+vDdBkGzxGD3CoMl5s1uEDA9crqofUYYQGbfcTCo9Z8uINU
	YnyxpkYGmes=
X-Received: by 2002:a17:907:9625:b0:b87:2f29:2054 with SMTP id
 a640c23a62f3a-b8761c1b85cmr73995266b.8.1768353843749; Tue, 13 Jan 2026
 17:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-7-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-7-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:55 -0800
X-Gm-Features: AZwV_QgeW2XUiFqi7ys8fraiqUratkAtDLiI-AOzKNh5gOu7JrWkJaWZDMDPwuQ
Message-ID: <CAEf4BzbKKmNnqQP0g8OVSgwqb2DTidBpKBjyi-QQJBRJ+-6SWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 06/11] bpf,x86: introduce emit_store_stack_imm64()
 for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Introduce the helper emit_store_stack_imm64(), which is used to store a
> imm64 to the stack with the help of r0.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v9:
> - rename emit_st_r0_imm64() to emit_store_stack_imm64()
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..d94f7038c441 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void emit_store_stack_imm64(u8 **pprog, int stack_off, u64 imm64)
> +{
> +       /* mov rax, imm64
> +        * mov QWORD PTR [rbp - stack_off], rax
> +        */
> +       emit_mov_imm64(pprog, BPF_REG_0, imm64 >> 32, (u32) imm64);

maybe make the caller pass BPF_REG_0 explicitly, it will be more
generic but also more explicit that BPF_REG_0 is used as temporary
register?

> +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_off);

why are you negating stack offset here and not in the caller?..

> +}
> +
>  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
>                            u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size=
)
>  {
> @@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
>          *   mov rax, nr_regs
>          *   mov QWORD PTR [rbp - nregs_off], rax
>          */
> -       emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
> -       emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> +       emit_store_stack_imm64(&prog, nregs_off, nr_regs);
>
>         if (flags & BPF_TRAMP_F_IP_ARG) {
>                 /* Store IP address of the traced function:
>                  * movabsq rax, func_addr
>                  * mov QWORD PTR [rbp - ip_off], rax
>                  */
> -               emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, =
(u32) (long) func_addr);
> -               emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
> +               emit_store_stack_imm64(&prog, ip_off, (long)func_addr);

see above, I'd pass BPF_REG_0 and -ip_off (and -nregs_off) explicitly,
too many small transformations are hidden inside
emit_store_stack_imm64(), IMO


>         }
>
>         save_args(m, &prog, regs_off, false, flags);
> --
> 2.52.0
>

