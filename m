Return-Path: <netdev+bounces-249934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBFD20F90
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB669303090F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC043033ED;
	Wed, 14 Jan 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmVR/fc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272D1E0DCB
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417572; cv=none; b=o8b+YZYk88x+uh7+qlsCDJeYgjfjIVkrxGCwBjQWA9jpoQ9R7NjGYudWSTvcZrJdCJ91e3YjJnTkDf6QViuA5ejoga3qGr1HHEzwOf8e+ych+kBMczz/gJU58tOEdFlxplfha+Iw6JF1lKHtfPQn7/GyF+lqltiM9IhVgZw5cUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417572; c=relaxed/simple;
	bh=rgbaQaXJPKl2UJf1a/PVmuHeLaG6thRyoEnpaaWZy8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJY30H5e8qYAeGgNhnid2L0jlm8MAbsHT3M8HbPYpkUB/aWMKSueHgZFAxlsc0C+ThGIoax6vSltX4YOANzb8abqu5ZWaX10TXmiI4S9ghNO3sjDXRE9cuhn42n4GIH0pflZWT2EGZpTIqsCQgYLhuewiikGAQxowTMEhfpR0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmVR/fc0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a137692691so1227565ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768417570; x=1769022370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udRxWZ9gu4Q93pQSMSG3gSPyr3026aY/HCSQBYrnGTE=;
        b=WmVR/fc0xZ8I8qEdYsfJ1mktaPV16iypWdGpnPJLZyw3nAizaJN5HpU6EIBQiISMtS
         RewRhJxY5d6iFyrjPD6zM4GgXa99HP3R8Gv0daF//QgbraOlkZlojmFNIw82L9BFxCjL
         S7tp+IK7B0+nw6wpYQaYVNHnwYIjrdPW1goZPL0ahpFMcur7tBSaHsP92GoH1PGXjOFy
         ZtEUFvGF+BQRFnujlqJD7dC0ViGijZ+HXHZaXmmaiBWhpLqgoM+HM8Gt+TXt8YuG7NNo
         /it0SikkitZ3U+eYhdHJaMjZD/DfNkSVFFtWeYl9JFTZ0zs+d9P3NtzBHcHSwZGu8Vac
         6mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768417570; x=1769022370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udRxWZ9gu4Q93pQSMSG3gSPyr3026aY/HCSQBYrnGTE=;
        b=bc+vS5pYNHh/Gfd0Hu0Il2+yZfBIHSNKw6Fhl0QHypt1qERZWO4OiLZho3IbwQ6wz0
         yG5PwyKpGoCs6+AqBfEAPTiL3gcd/92sMls6ZeucozUcCrV9qpyxd+RQ94dBwzdwwv75
         24AFOMMc1Qa3Z2JZs4Vttrpk3D1mudpkKVvgrKM0CmKV64HOUM37UELbS3emCWBZzqy+
         uvhtzcHyrTZZVoZ4qJvivHY//NW0koQ0u6HK4bFKwwbtB7usDWXVi2DHMGtqYNnW06s6
         U4B6xVTrRDnQTHOj9PiXYxaiXeS+yIb6TiV8SnCvBriIQI9qpayX3veKzKs+XrPZlOBS
         THXg==
X-Forwarded-Encrypted: i=1; AJvYcCUNaZK9VQKyphs9hTSL4MCipL2pkB/7EFgOwLB/oJ99HcauiJJs7CvmV/uV+jZSnuIO9+yjTFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjadBDykDdggIXzGISi8ZDIYhZLOlFyM/0idfYLyjRn7Q800c
	ruz9qAGpUKS5idCNiEgizUFN2h09oxuEeY9pf0KcKXdSJ2WrCLHbMP/dfUA2DVxCj8Ovt/G3H8G
	DZxByFDmfzCNStsqF8FtCnbhFi/sler4=
X-Gm-Gg: AY/fxX6GiYfbOxynFQz/Gjm1zAW1Gkta3wBmR7OPSkQVuU2lcCRxbMykfy42eVLn0hr
	kJeeOnNhANuMvMXzsoSYzmWDlcwiVvWzGUyo2N4NrdQYDZiiAatVrKwtfDfCxIlX9LkngWTyK2V
	EG/zmaPzffP5+fMATmZzjytRRk+qQR3Myni5ps9oxIYmynUaSCWrZaW+n5uuNWy4dH7FgcF5ODh
	FkWwIU9AkMVgzu46TQquklVquD5n73GrICoiXBaEZGY+Q1fEwNCJEQyW689MXys8Y8zugpph/NP
	bTcxSI22iw==
X-Received: by 2002:a17:903:1b4e:b0:297:c71d:851c with SMTP id
 d9443c01a7336-2a59bbf1b2fmr31346295ad.36.1768417570008; Wed, 14 Jan 2026
 11:06:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-8-dongml2@chinatelecom.cn> <CAEf4BzYE0ZTrCaruJSr8MXAbZSsKz8H_BqHoZX5kS63yRBa-2g@mail.gmail.com>
 <2187165.bB369e8A3T@7940hx>
In-Reply-To: <2187165.bB369e8A3T@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Jan 2026 11:05:56 -0800
X-Gm-Features: AZwV_QimwagFN3yiR1pVjCVSJi-U55L205nju_mJfwvoJlf8_njPZL2Nabpui6s
Message-ID: <CAEf4BzZZSUkMbv=7DcBubGjnABHNnAZjT3-A5XKB-UW58a=6jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:27=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/14 09:25 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sat, Jan 10, 2026 at 6:12 AM Menglong Dong <menglong8.dong@gmail.com=
> wrote:
> > >
> > > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> [...]
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index d94f7038c441..0671a434c00d 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, vo=
id *func, void *ip, u8 jmp_cond)
> > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > >                       struct bpf_tramp_links *tl, int stack_size,
> > >                       int run_ctx_off, bool save_ret,
> > > -                     void *image, void *rw_image)
> > > +                     void *image, void *rw_image, u64 func_meta)
> > >  {
> > >         int i;
> > >         u8 *prog =3D *pprog;
> > >
> > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > > +                       /* 'stack_size + 8' is the offset of func_md =
in stack */
> >
> > not func_md, don't invent new names, "func_meta" (but it's also so
>
>
> Ah, it should be func_meta here, it's a typo.
>
>
> > backwards that you have stack offsets as positive... and it's not even
> > in verifier's stack slots, just bytes... very confusing to me)
>
>
> Do you mean the offset to emit_store_stack_imm64()? I'll convert it
> to negative after modify the emit_store_stack_imm64() as you suggested.
>

yes

>
> >
> > > +                       emit_store_stack_imm64(&prog, stack_size + 8,=
 func_meta);
> > > +                       func_meta -=3D (1 << BPF_TRAMP_M_COOKIE);
> >
> > was this supposed to be BPF_TRAMP_M_IS_RETURN?... and why didn't AI cat=
ch this?
>
>
> It should be BPF_TRAMP_M_COOKIE here. I'm decreasing and
> compute the offset of the session cookie for the next bpf
> program.
>
>
> This part correspond to the 5th patch. It will be more clear if you
> combine it to the 5th patch. Seems that it's a little confusing
> here :/
>

It is confusing. And invoke_bpf is partly provided with opaque
func_meta, but also partly knows its structure and does extra
adjustments, I don't like it. I think it would be simpler to just pass
nr_args and cookies_offset and let invoke_bpf construct func_meta for
each program invocation, IMO.

>
> Maybe some comment is needed here.
>
>
> >
> > > +               }
> > >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_siz=
e,
> > >                                     run_ctx_off, save_ret, image, rw_=
image))
> > >                         return -EINVAL;
> > > @@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im, void *rw_im
> > >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> > >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY=
_RETURN];
> > >         void *orig_call =3D func_addr;
> > > +       int cookie_off, cookie_cnt;
> > >         u8 **branches =3D NULL;
> > > +       u64 func_meta;
> > >         u8 *prog;
> > >         bool save_ret;
> > >
> > > @@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struc=
t bpf_tramp_image *im, void *rw_im
> > >
> > >         ip_off =3D stack_size;
> > >
> > > +       cookie_cnt =3D bpf_fsession_cookie_cnt(tlinks);
> > > +       /* room for session cookies */
> > > +       stack_size +=3D cookie_cnt * 8;
> > > +       cookie_off =3D stack_size;
> > > +
> > >         stack_size +=3D 8;
> > >         rbx_off =3D stack_size;
> > >
> > > @@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struc=
t bpf_tramp_image *im, void *rw_im
> > >                 }
> > >         }
> > >
> > > +       if (bpf_fsession_cnt(tlinks)) {
> > > +               /* clear all the session cookies' value */
> > > +               for (int i =3D 0; i < cookie_cnt; i++)
> > > +                       emit_store_stack_imm64(&prog, cookie_off - 8 =
* i, 0);
> > > +               /* clear the return value to make sure fentry always =
get 0 */
> > > +               emit_store_stack_imm64(&prog, 8, 0);
> > > +       }
> > > +       func_meta =3D nr_regs + (((cookie_off - regs_off) / 8) << BPF=
_TRAMP_M_COOKIE);
> >
> > func_meta conceptually is a collection of bit fields, so using +/-
> > feels weird, use | and &, more in line with working with bits?
>
>
> It's not only for bit fields. For nr_args and cookie offset, they are
> byte fields. Especially for cookie offset, arithmetic operation is perfor=
med
> too. So I think it make sense here, right?
>
>
> >
> > (also you defined that BPF_TRAMP_M_NR_ARGS but you are not using it
> > consistently...)
>
>
> I'm not sure if we should define it. As we use the least significant byte=
 for
> the nr_args, the shift for it is always 0. If we use it in the inline, un=
necessary
> instruction will be generated, which is the bit shift instruction.
>
>
> I defined it here for better code reading. Maybe we can do some comment
> in the inline of bpf_get_func_arg(), instead of defining such a unused
> macro?

I think I just wouldn't define NR_ARGS macro at all then, given inline
implementation implicitly encodes that knowledge anyways.

>
>
> Thanks!
> Menglong Dong
>
>
> >
> >
> >
> >
> > > +
> > >         if (fentry->nr_links) {
> > >                 if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_of=
f,
> > > -                              flags & BPF_TRAMP_F_RET_FENTRY_RET, im=
age, rw_image))
> > > +                              flags & BPF_TRAMP_F_RET_FENTRY_RET, im=
age, rw_image,
> > > +                              func_meta))
> > >                         return -EINVAL;
> > >         }
> > >
> > > @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struc=
t bpf_tramp_image *im, void *rw_im
> > >                 }
> > >         }
> > >
> > > +       /* set the "is_return" flag for fsession */
> > > +       func_meta +=3D (1 << BPF_TRAMP_M_IS_RETURN);
> > > +       if (bpf_fsession_cnt(tlinks))
> > > +               emit_store_stack_imm64(&prog, nregs_off, func_meta);
> > > +
> > >         if (fexit->nr_links) {
> > >                 if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off=
,
> > > -                              false, image, rw_image)) {
> > > +                              false, image, rw_image, func_meta)) {
> > >                         ret =3D -EINVAL;
> > >                         goto cleanup;
> > >                 }
> > > --
> > > 2.52.0
> > >
> >
>
>
>
>
>

