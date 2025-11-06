Return-Path: <netdev+bounces-236160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6771C38EDA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F13D4F5F66
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2C2264A0;
	Thu,  6 Nov 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jop9EsZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990EF1A256E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397834; cv=none; b=uNOR9hhrDu5/jfSUJgAsNNdZ5YUf8PwbLQWxcmScYafzrJmVnMrnuIuFmcUaTXZtBQuvv/8GntH1IO5Ns5yILwnWxpsseW9nFSV9hHoqHMoolI/003ou1KBVe/86VM8149YG1QRQHMQCQuYVFWx1V5n+Ng60CigfYO9pEbDQdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397834; c=relaxed/simple;
	bh=76Dhne1qKUr6EeNtO2LiEQo70+Ucs0LgdmDAIVUjKZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb1iLYRO7IQ8lPlYF4L2P+dxF1N95y4s2lCk84oY4XGY1YZjjaa55LmlYDL/8ZOrLVTinxvZgNAw+yl9m+/VjDPJduMlLh0xUUFDg4Ci5yCbxPM5BVNNuiobcCgtXNBIwThBVSLvaWIZ5LqBhroVYLMfeiMhW2XyUvT526beLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jop9EsZU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so270901f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 18:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397831; x=1763002631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Kg5IHfenPREYVnmUP5hSsPB0MguV6hLXoWEzWTaBQ=;
        b=Jop9EsZUCl6f89pifItM0BXJimF6UILlLpYObYg/L9SlyZRxEVk//WzOSywQCw/8Vz
         HswLi8PmTSVzeCd19a9ZWh4kCqbAKq2F8InpXWRVpj1xmS4vsDCjB5tLsu5WJo0ZpszK
         O8JuHuPXSHmUDJOye5euHZSsdg5EkD2yKJt7yTGjHJkDSc3FLxowjW6YDGPuLv79kS+D
         zFEleUWVYiWISPX09dOoD1PgJhuwIO3SSHy6OchaNN/K26i4BUhyp0tQHVStPe6rCLLS
         GKFGYbOVwyyUZnEfOeTGLo2XGigmUMOcepl9pcVh0D7WK6LxoTq6ugjqLBLfHUF9YGrg
         Fwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397831; x=1763002631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3Kg5IHfenPREYVnmUP5hSsPB0MguV6hLXoWEzWTaBQ=;
        b=ieM8nJxZ/Rf1uNXTfCGVRpWJuL0cGQouPm0nqBmhzmCeMUDmx9FNbd3HuT9zMG+1RD
         ZyEC5MwxXWw+ZZ3Cf5lW/iOHUcsjNE+0GGsDw7oDf9+sSlCQEi2eIRFlGM23CorLTbk6
         V5jE6xUcNTdiTmUp1IZ6T/SZf6F2HnlMv6jxWdqsYa0CzgX7qvk/BRCkua/YPgfIWL9d
         drt9GnhDf4oU2ahf8JTUjoxfQGLOT0poyqThm5M9HE79sGT2/10IM5XMgpPm2h2WsH7w
         Qx2+T59I+OqcLMfUmYaQ8aEo/duxnfaNU0WjgeLyXApFV5SKEAafzIKmLi1FIMOMEaqm
         m+uw==
X-Forwarded-Encrypted: i=1; AJvYcCWQq3knmRJ0FCS7cWkRPuHN0e4M66HAcABz3eO9m69e0UhNdwMTfky1+2thDP9ab0O9wSXeDc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmpsyohf4R8ECw9ilLO76UsFnnxp8kqrqR4sTnpTmqtwqsoIB
	Tm2/v25WmRuqv92NQxlmOGEapmRpQ+vPNoe+Cpq8V+I42m5NvOnNdY33RPU2aGceubT5/+8aAZB
	jU8uUWXfMYKUO0VSqFC0G9ys9DzZevkg=
X-Gm-Gg: ASbGncsjJ/dcxzvgFYG9/fzuumSS/v3imP83crYowO8bCdYXdPs6HVsfxXxwfv8uC2g
	wvTGFKEFl14d9M2FBoZ7ihKXkZemohs+Kk4E0Gi7w4M91qzOQOeu8SH2DWpvQYgINQ6QJBcaL7q
	10nkj28mr5/TBygnRYI6kz623JvprnVZxJr0h3754Okz44zjJc8tDkjruT3Dx9Df5uqUAfc0Tnk
	aU+q7x9AJoz0EpOtARjy6AmFCAaL5IQdZBHRk8sGBxlpRmuV1bdSg6safWCp930BqGmwje+dtsU
	Zz6zAO1aYO9dm/Br/Bt3KAKd9sN/
X-Google-Smtp-Source: AGHT+IEvOIM07Gf6joTAeYpU8ohcD44xy4giDJXfaPiZ3ZtCqdUuyfyocfFIk+QZlrI2O7a9V76ylsfUJ68us8NPRE0=
X-Received: by 2002:a05:6000:4210:b0:429:cba7:f773 with SMTP id
 ffacd0b85a97d-429e32e4853mr5542720f8f.19.1762397830841; Wed, 05 Nov 2025
 18:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com>
 <5053516.31r3eYUQgx@7950hx> <2388519.ElGaqSPkdT@7950hx>
In-Reply-To: <2388519.ElGaqSPkdT@7950hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:56:59 -0800
X-Gm-Features: AWmQ_blqRL6De9uXW-k1H3TIc8E4i74K_cTkvhs-PiM7t6EE9kCQBuZ9GxUR1e8
Message-ID: <CAADnVQ+tUO_BJV8w1aPLiY50p7F+uk0GCWFgH0k5zLQBqAif1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:49=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2025/11/6 09:40, Menglong Dong wrote:
> > On 2025/11/6 07:31, Alexei Starovoitov wrote:
> > > On Tue, Nov 4, 2025 at 11:47=E2=80=AFPM Menglong Dong <menglong.dong@=
linux.dev> wrote:
> > > >
> > > > On 2025/11/5 15:13, Menglong Dong wrote:
> > > > > On 2025/11/5 10:12, Alexei Starovoitov wrote:
> > > > > > On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.=
dong@linux.dev> wrote:
> > > > > > >
> > > > > > > On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > > > > > > > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <mengl=
ong8.dong@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > In origin call case, we skip the "rip" directly before we=
 return, which
> > > > > > > > > break the RSB, as we have twice "call", but only once "re=
t".
> > > > > > > >
> > > > > > > > RSB meaning return stack buffer?
> > > > > > > >
> > > > > > > > and by "breaks RSB" you mean it makes the cpu less efficien=
t?
> > > > > > >
> > > > > > > Yeah, I mean it makes the cpu less efficient. The RSB is used
> > > > > > > for the branch predicting, and it will push the "rip" to its =
hardware
> > > > > > > stack on "call", and pop it from the stack on "ret". In the o=
rigin
> > > > > > > call case, there are twice "call" but once "ret", will break =
its
> > > > > > > balance.
> > > > > >
> > > > > > Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as w=
ell,
> > > > > > since RSB has to be updated/invalidated by this store.
> > > > > > The behavior depends on the microarchitecture, of course.
> > > > > > I think:
> > > > > > add rsp, 8
> > > > > > ret
> > > > > > will only screw up the return prediction, but won't invalidate =
RSB.
> > > > > >
> > > > > > > Similar things happen in "return_to_handler" in ftrace_64.S,
> > > > > > > which has once "call", but twice "ret". And it pretend a "cal=
l"
> > > > > > > to make it balance.
> > > > > >
> > > > > > This makes more sense to me. Let's try that approach instead
> > > > > > of messing with the return address on stack?
> > > > >
> > > > > The way here is similar to the "return_to_handler". For the ftrac=
e,
> > > > > the origin stack before the "ret" of the traced function is:
> > > > >
> > > > >     POS:
> > > > >     rip   ---> return_to_handler
> > > > >
> > > > > And the exit of the traced function will jump to return_to_handle=
r.
> > > > > In return_to_handler, it will query the real "rip" of the traced =
function
> > > > > and the it call a internal function:
> > > > >
> > > > >     call .Ldo_rop
> > > > >
> > > > > And the stack now is:
> > > > >
> > > > >     POS:
> > > > >     rip   ----> the address after "call .Ldo_rop", which is a "in=
t3"
> > > > >
> > > > > in the .Ldo_rop, it will modify the rip to the real rip to make
> > > > > it like this:
> > > > >
> > > > >     POS:
> > > > >     rip   ---> real rip
> > > > >
> > > > > And it return. Take the target function "foo" for example, the lo=
gic
> > > > > of it is:
> > > > >
> > > > >     call foo -> call ftrace_caller -> return ftrace_caller ->
> > > > >     return return_to_handler -> call Ldo_rop -> return foo
> > > > >
> > > > > As you can see, the call and return address for ".Ldo_rop" is
> > > > > also messed up. So I think it works here too. Compared with
> > > > > a messed "return address", a missed return maybe have
> > > > > better influence?
> > > > >
> > > > > And the whole logic for us is:
> > > > >
> > > > >     call foo -> call trampoline -> call origin ->
> > > > >     return origin -> return POS -> return foo
> > > >
> > > > The "return POS" will miss the RSB, but the later return
> > > > will hit it.
> > > >
> > > > The origin logic is:
> > > >
> > > >      call foo -> call trampoline -> call origin ->
> > > >      return origin -> return foo
> > > >
> > > > The "return foo" and all the later return will miss the RBS.
> > > >
> > > > Hmm......Not sure if I understand it correctly.
> > >
> > > Here another idea...
> > > hack tr->func.ftrace_managed =3D false temporarily
> > > and use BPF_MOD_JUMP in bpf_arch_text_poke()
> > > when installing trampoline with fexit progs.
> > > and also do:
> > > @@ -3437,10 +3437,6 @@ static int __arch_prepare_bpf_trampoline(struc=
t
> > > bpf_tramp_image *im, void *rw_im
> > >
> > >         emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
> > >         EMIT1(0xC9); /* leave */
> > > -       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > > -               /* skip our return address and return to parent */
> > > -               EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
> > > -       }
> > >         emit_return(&prog, image + (prog - (u8 *)rw_image));
> > >
> > > Then RSB is perfectly matched without messing up the stack
> > > and/or extra calls.
> > > If it works and performance is good the next step is to
> > > teach ftrace to emit jmp or call in *_ftrace_direct()
>
> After the modification, the performance of fexit increase from
> 76M/s to 137M/s, awesome!

Nice! much better than double 'ret' :)
_ftrace_direct() next?

