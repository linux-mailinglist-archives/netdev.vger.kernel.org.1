Return-Path: <netdev+bounces-81733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59388AEC6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F32A305980
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92683DABF8;
	Mon, 25 Mar 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxqezuPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAECC125;
	Mon, 25 Mar 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391660; cv=none; b=qHu/VviZSR9zQUXBq/xlDsu7bvPBRv9tmBYFEW7vorCVg7iKiBAUHkrrdFpbUKTWw+oNoX4snwJMQg+RGx6RxS1cUI1q3ffue0YmBSEOSQvHDOu+BaqiTGwVJ2te8AkKtCbEd0iPTYN5wuqBs7ij59Pn94arhxvDzCGfnXMQ4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391660; c=relaxed/simple;
	bh=FTtw5ckCLrewy/innNigtYZs/cnsMfJP8ftcMpW4cTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHZlCNucTvDE9KMQrbye/xW1IWrDW5s2Cds1IJjbaXBftj7viBnZFJm0w85ta2PWpDd44MH3h6Ukfi2qnXwtJtVkmmqneaP6+wBIrcTAqYWTWOTEUsoby+t1lHlmip3HbzNu6J7j0V05JB5SCi7h3Jzzi1rLLWGOPwc++xhOBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxqezuPm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so3304325f8f.0;
        Mon, 25 Mar 2024 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391657; x=1711996457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea9eOBb1s+yHHAcYxRNr8e9XD1etU46P37uWHKinu3k=;
        b=bxqezuPmc+QQJFKo3+ZxdPYRZlFxQLfunOIyEWs1eVlsL+Aws4+kZxhdTxR7YSHiMn
         dc02fr/MeVmyUqQfmjKoU4QFN4+FG4aNYC8/31/yEi4Wx8PqCXjjIYIlYzHm2hpl/fSA
         HNQVgQ5x9xu/hKUW9u2kMZHeTbn/lC4tDH9ni6/heY1CVKC9wAYuDj5/nHNVvvwahTZB
         BuT4Xpp0tyQfeKyj5QVqO5lKpepyMbPAFZc44cbXJ0fkQ75QqYW9IZdsxSc4ZgZBLe7I
         vK1AHFn1mRabuB3SO+L58d7Zx57qm133iFQ9zYF6w3mK0w4m5fHyDccwA8qU6NuXvnHc
         T+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391657; x=1711996457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea9eOBb1s+yHHAcYxRNr8e9XD1etU46P37uWHKinu3k=;
        b=cbE0nz1mrbMRoG7+EoWiGzcscVZ0yFXnEE2bOOs4SBfRKiHcwtUtbRjhdwK85Yb1uz
         4/gjxgNuz1ylIbeXBrgzQH+3e7ukxmouuG66YXEuoTT86eE8aXSVniMTNfZyOD2BFZKX
         PjZaWs2Zh/YTeHHSgfvr9GDQotvfbCK4MqrHYVuxUrWJ+Kz9lUcnlIi8lbF91jL1kp0U
         EyGm7zhS0HTG5ZmiPECAa/DRhAhYivvlcRvVhbTf2ZSzuxD9FqNJHVoZxAcdc7+ua2/m
         ZlJtF6kYbBLakq0W/iL7m0csedobdR+IhU15Etr4gftIFSB2huSPkxKXBbSyb7zNZ2vF
         jcMw==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ7qKDo/x1P2Ee3kxQwSeUyS5A/LmWEYHUFJh6qQJWVpe8cliBxLJ71J2y5dc95TVJDHJMrRRP1f1HocDEhvS/IM1C7n3
X-Gm-Message-State: AOJu0YyHyuM82X71DrNdPm35QUfLMFuONTeXd/6VAEsqTqL7CPviHCNT
	At6a940/3j8P3LkSZJ9igeOUCGl8ORbLrhpnDFZ3s1LYhMHr7Mz1JfvxKrwAH3XRiSPat1sAKu9
	ucjN1lxwYRVs8tBtheUq5U+KWFhE=
X-Google-Smtp-Source: AGHT+IFH2cLUwpQB0Ur9fkV3U1FYXN+GL+meSfPbLtpV+O+jILouURdHVdotnF8t0NIZTXhWYOQAwJyB/kMwDBw7UAY=
X-Received: by 2002:a5d:5341:0:b0:33e:7a42:68e2 with SMTP id
 t1-20020a5d5341000000b0033e7a4268e2mr4836336wrv.21.1711391656945; Mon, 25 Mar
 2024 11:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324103306.2202954-1-pulehui@huaweicloud.com>
 <CAADnVQLhfN7f6AFxa_19E0g2_YADEkrfPPffi43HeH9VCi8MqQ@mail.gmail.com> <c0890fc2-53ea-401a-a3b4-a9bf6181a867@huaweicloud.com>
In-Reply-To: <c0890fc2-53ea-401a-a3b4-a9bf6181a867@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 11:34:05 -0700
Message-ID: <CAADnVQKnTe-7KhziOnGSesbz1WDkNp4nyCN3qp-y=ab0jMxr3Q@mail.gmail.com>
Subject: Re: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility
 between bpf and riscv abi
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:28=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
>
>
> On 2024/3/25 2:40, Alexei Starovoitov wrote:
> > On Sun, Mar 24, 2024 at 3:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.c=
om> wrote:
> [SNIP]
> >>
> >> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_=
comp64.c
> >> index 869e4282a2c4..e3fc39370f7d 100644
> >> --- a/arch/riscv/net/bpf_jit_comp64.c
> >> +++ b/arch/riscv/net/bpf_jit_comp64.c
> >> @@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *in=
sn, struct rv_jit_context *ctx,
> >>                  if (ret < 0)
> >>                          return ret;
> >>
> >> +               if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> >> +                       const struct btf_func_model *fm;
> >> +                       int idx;
> >> +
> >> +                       fm =3D bpf_jit_find_kfunc_model(ctx->prog, ins=
n);
> >> +                       if (!fm)
> >> +                               return -EINVAL;
> >> +
> >> +                       for (idx =3D 0; idx < fm->nr_args; idx++) {
> >> +                               u8 reg =3D bpf_to_rv_reg(BPF_REG_1 + i=
dx, ctx);
> >> +
> >> +                               if (fm->arg_size[idx] =3D=3D sizeof(in=
t))
> >> +                                       emit_sextw(reg, reg, ctx);
> >> +                       }
> >> +               }
> >> +
> >
> > The btf_func_model usage looks good.
> > Glad that no new flags were necessary, since both int and uint
> > need to be sign extend the existing arg_size was enough.
> >
> > Since we're at it. Do we need to do zero extension of return value ?
> > There is
> > __bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
> > but the selftest with it is too simple:
> >          return bpf_kfunc_call_test2((struct sock *)sk, 1, 2); >
> > Could you extend this selftest with a return of large int/uint
> > with 31th bit set to force sign extension in native
>
> Sorry for late. riscv64 will sign-extend int/uint return values. I
> thought this would be a good test, so I tried the following:
> ```
> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym; <-- here change int to u32
> int kfunc_call_test2(struct __sk_buff *skb)
> {
>         long tmp;
>
>         tmp =3D bpf_kfunc_call_test2(0xfffffff0, 2);
>         return (tmp >> 32) + tmp;
> }
> ```
> As expected, if the return value is sign-extended, the bpf program will
> return 0xfffffff1. If the return value is zero-extended, the bpf program
> will return 0xfffffff2. But in fact, riscv returns 0xfffffff2. Upon
> further discovery, it seems clang will compensate for unsigned return
> values. Curious!
> for example:
> ```
> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
> int kfunc_call_test2(struct __sk_buff *skb)
> {
>         long tmp;
>
>         tmp =3D bpf_kfunc_call_test2(0xfffffff0, 2);
>         bpf_printk("tmp: 0x%lx", tmp);
>         return (tmp >> 32) + tmp;
> }
> ```
> and the bytecode will be:
> ```
>   0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 =3D
> 0xf0000000 ll
>   2:       b7 02 00 00 02 00 00 00 r2 =3D 0x2
>   3:       85 10 00 00 ff ff ff ff call -0x1
>   4:       bf 06 00 00 00 00 00 00 r6 =3D r0
>   5:       bf 63 00 00 00 00 00 00 r3 =3D r6
>   6:       67 03 00 00 20 00 00 00 r3 <<=3D 0x20 <-- zero extension
>   7:       77 03 00 00 20 00 00 00 r3 >>=3D 0x20
>   8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x0 ll
> 10:       b7 02 00 00 0b 00 00 00 r2 =3D 0xb
> 11:       85 00 00 00 06 00 00 00 call 0x6
> 12:       bf 60 00 00 00 00 00 00 r0 =3D r6
> 13:       95 00 00 00 00 00 00 00 exit
> ```
>
> another example:
> ```
> u32 bpf_kfunc_call_test2(u32 a, u32 b) __ksym;
> int kfunc_call_test2(struct __sk_buff *skb)
> {
>         long tmp;
>
>         tmp =3D bpf_kfunc_call_test2(0xfffffff0, 2);
>         return (tmp >> 20) + tmp; <-- change from 32 to 20
> }
> ```
> and the bytecode will be:
> ```
>   0:       18 01 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 r1 =3D
> 0xf0000000 ll
>   2:       b7 02 00 00 02 00 00 00 r2 =3D 0x2
>   3:       85 10 00 00 ff ff ff ff call -0x1
>   4:       18 02 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 r2 =3D
> 0xfff00000 ll <-- 32-bit truncation
>   6:       bf 01 00 00 00 00 00 00 r1 =3D r0
>   7:       5f 21 00 00 00 00 00 00 r1 &=3D r2
>   8:       77 01 00 00 14 00 00 00 r1 >>=3D 0x14
>   9:       0f 01 00 00 00 00 00 00 r1 +=3D r0
> 10:       bf 10 00 00 00 00 00 00 r0 =3D r1
> 11:       95 00 00 00 00 00 00 00 exit
> ```
>
> It is difficult to construct this test case.

Yeah.
I also tried a bunch of experiments with llvm and gcc-bpf.
Both compilers emit zero extension when u32 is being used as u64.

> > kernel risc-v code ?
> > I suspect the bpf side will be confused.
> > Which would mean that risc-v JIT in addition to:
> >          if (insn->src_reg !=3D BPF_PSEUDO_CALL)
> >              emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
> >
> > need to conditionally do:
> >   if (fm->ret_size =3D=3D sizeof(int))
> >     emit_zextw(bpf_to_rv_reg(BPF_REG_0, ctx),
> >                bpf_to_rv_reg(BPF_REG_0, ctx), ctx);
> > ?
>
> Agree on zero-extending int/uint return values when returning from
> kfunc to bpf ctx. I will add it in next version. Thanks.

Looking at existing compilers behavior it's probably unnecessary.
I think this patch is fine as-is.
I'll apply it shortly.

