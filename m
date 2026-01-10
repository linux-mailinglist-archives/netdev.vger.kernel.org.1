Return-Path: <netdev+bounces-248669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4879D0CD94
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367A43021E49
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2F1A9F88;
	Sat, 10 Jan 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMZF1YLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819D7FBA2
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013160; cv=none; b=MS2MCUvLwzB/ambJdYTt8h2ZrQXo3hVFt1lJbFZQaD92jQipa8BYaMHQ2HLrP2aepzfejBQBjskwez8sgLHGPYtR//L7Ts5BmIzGDj1PJRxb+hu0KT7YS27rplrdwRyksP4WWh+MrAkYDZRtFs+S9WIhojnk5sLNUpM1A7/R/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013160; c=relaxed/simple;
	bh=HGS5i/bwK9do9AbGu5Bk+XTcjGjLJ/j4a6YuSB6D8O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MulMm+rw/rUEEype0PZixNUCZyi9cck89LBNyHMd979tJoLQBQYvVN7M4c8vicIGZg6ZSDKBy0V9zDqdkjsQssMjY+imklQ5r7mtoOmV29I8oeYGohhOVaucDs/6VnMbYwc12GsCKQ8GzQqUxupTwJowQhAMV0LLLpmfjDTTPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMZF1YLn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432dc56951eso736237f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768013157; x=1768617957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwYbTxY+6sNh9pUQjEhDOwvA5XNTBh+AVIQ+84UfZos=;
        b=hMZF1YLnDNl3dZOGT0ySm6M7Auxlybo1bH23oOmHqpfzRHZPuXrNKBDmM48O2LbwCj
         c56BxfPW+Eep8ttYVCRz8gErGehU2YvGDbNSKBPqJjzG9anvm/QkGMXLr3HK1O04jmX1
         q39IaQ7uoqReWnP/ETz800p3kQhXU5rh/Ckl6w7jmkmvWPuBRkzoLGzOLw2r2ilZ/Nb5
         ecgGF3Gkut7wSJjXaAqGYNrVqNwjBqZuOb6Gi8AxWFjNiqmeeyQTCu3Zk+UB4jI9FY0R
         IXqbG6wSp7GN0BZAUPvWTqBvA0GkMdeaMX7s89FWZbgShFgJ04dXImi8hxpwAYdkUOdN
         XniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768013157; x=1768617957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwYbTxY+6sNh9pUQjEhDOwvA5XNTBh+AVIQ+84UfZos=;
        b=Fozhro7pK2CVdBgdyMc+b+ypyZ3XsOD/HjIZGGEglFIrvoPH7R8rBE4to210mLSt1s
         awbt+waSUICb15aO31Ds9HCUB1mtIXTjiGREeVgtu8Kvm3s+IwISCa864/NwAgjAZdKu
         S3eFBx40lDxD6d3WsUZULTt8BGDxj5r9mWcUrvAMrGxGfunx8PLWQHP7DwzFS2igZUG0
         +oUt+MvfpHh1RXXgCpltHJbPtNYHRGBOTqCQ6ii+1ZPiXzl5ABVqHQS2c+ZMDFg1nspk
         5AilnWLcxl0GaIHUl//StAeaLtkgnvK6qQdwXnrLnXGn5TKRetID0zS+U0My0skub/FF
         BjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVP9PAfXlGTsQ3mfPpXnVDeMg62605PF9EwC12xuaILnAe6wmrg2Rw2KRInG+r9jvSr5yVfrU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytsl90J8FtcqkHzgzMP2uhalAgBeZiMNhFsCasBtXEwcAEz+tD
	FuNx0vsCXd8tK/GjAwBo5PCWuwtEPN7jhflaDo4fiXkSEmnCtV438ra3MtlCvoFsfeIVZhOA856
	KxXQOAlXlSQlMY1ulkplUaH3pZlWdOOI=
X-Gm-Gg: AY/fxX4cXDpI4DBv1eHKCsf82oKzbFHVbrT5VyJZa4rHJ9dElkQeKR8CO+jGzNI78f5
	NqmmlvzlFgvTIA1WkA8WPWTsRTxwUs7feyRkjH6s3M8dttMt4Qd9BLXinWKwdYIK+1m+mSGedJg
	yYsKdTL8YqN42sBqWmDveX6uG5FxqY/xwcFOzQFTZPsHcmIqtoPZgcqOylLqkzgZVP3PylOU19G
	pobpCdCrAsD5cRik2/NhBUuwN+Uov1hkfQptYeUB5MfiXL+mEBucUaNcnCJncwL0s1ecWz4j/+z
	IHyJqJiWQnVwa7lQwVG5SPVWtLnX
X-Google-Smtp-Source: AGHT+IFyKTbnI4lKo1y4Hh1ZjltMkH97jV1VSUbwqAlhtBFbyTcWPPuOKi4eRAH/l9vVlSh/4LeGMIaozvU/qmPAhC0=
X-Received: by 2002:a05:6000:2287:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-432c3790b85mr14055887f8f.14.1768013156844; Fri, 09 Jan 2026
 18:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-7-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-7-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:45:45 -0800
X-Gm-Features: AZwV_Qgh-6_3lbLhgq-yUgBHMGqryJkJT_EbPajilXClrF34_Lyzir343UkqXWM
Message-ID: <CAADnVQKUZsEvv64Y-U-hzCY-wc1iTfXTjhFhqG6Nq4fDsu_HsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 06/11] bpf,x86: introduce emit_st_r0_imm64()
 for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 t=
o
> the stack with the help of r0.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..a87304161d45 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
> +{
> +       /* mov rax, value
> +        * mov QWORD PTR [rbp - off], rax
> +        */
> +       emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
> +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
> +}

The name is cryptic.
How about emit_store_stack_imm64(pprog, stack_off, imm64) ?
or emit_mov_stack_imm64.

