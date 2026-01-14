Return-Path: <netdev+bounces-249930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA46D20F27
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0B1308E9BF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6AE33B947;
	Wed, 14 Jan 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGoQRUBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545F337BBA
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416994; cv=none; b=UVRbJOaMsR2eauYxs7DgINf6JLPRZX+lo3aIkAHlKyCthy/715gJWp1HH5aAay+D82CCTmwfGWJnbDskKCitQnvElh6W4DRW80tEi2Iw/5LPv4LhxB9BzONa8VWXH/2O8Qo35AfDfsqhu0dZnJGeGAi0m1JLNRY/7SiZClfFJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416994; c=relaxed/simple;
	bh=4azGP8VcRIjSALxG8aZAYNFnLhGyrhB2MnSKXZKdT/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUq1QkABLxa6aVhOCP4ep987hMk4ygTDGEEN1AU3VbDFWixywTvKO7OrP6eNuF8TJOH3aoI88VrviUS4AoZQK15VmfH7+HLpukvTjcV4xCh5g116QA4hlUZIVbKtLc9iyIpzpi4ZtJ3EVw99KmCMJZnRW0rCAep8LQkciBJ2cNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGoQRUBS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c2f335681so27786a91.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768416991; x=1769021791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jyqCRUml6RQX1yM05nYgct3qQ9LHRmYpUM/HjuPv5M=;
        b=LGoQRUBSupmRP6iB2j4QftDczDMNWE+pyRKa06trxzgV0cLdLa5eIXnCR7nhATE7fa
         RxYYEKja26tOoLntochQ/st6nADBTEJFL7mJX7aDGM2toRPoemjUvdGQVOqVXl/JKSOz
         s6S1dDgKMBm0YmeMtgr5VsLHhdjqsbDCsAqFKmwMd9iUWT2mLPRr02VgifGIq62ud+a5
         ekmG3FO3yMufRuUNfzULh+/SjUgsxn+HjVxfDo+Xz1zXg0+SImcb4xi7cNa4T/awKMOs
         zkN/PknwSrvDMiRdzMvcntAE0yDPkEYKboHNso8hN8JYOnwlvU+ILXb37I0v3zBUcCxn
         OUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768416991; x=1769021791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jyqCRUml6RQX1yM05nYgct3qQ9LHRmYpUM/HjuPv5M=;
        b=IQtk461nY2wHzO05LNXA7Db3fi3FMiOlf8HPBolkounxlxfsPnXTq/tIRZxbnguP/C
         vWwqYpzbws8aU4rKkmI2AAucXyuLuCUtzcjNalHI3cEnlzxD2DbKWA1WDD5gmRWwOLiN
         WblZfSppMxTRKa+NH/Pvs9TeC4yKyqNVLYb42k+cyAxUXeOo2mByqbACwO+PjquHFOG6
         mgpFzyi/HIN5poUk3pY5wBsRPF7WCgxis2SjD4vu3M7Zw7eHuQ8+VJmT0GzuvfC2RR0W
         jpbaPFmLuRu7SnM7zHf0wXyNBrCtblIDJ/BWnWPCfA2ukqEqZJijw+J20OACx7X2Rh0l
         V7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUjrrkVLMA//BnpSoVb3YV1se3LPkpiqk5nRU3KHm5Kox4IqKpo+75hpLbua83kEV+lqEAWyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnsh/XYOzu0xUCvc0XjlIT0YbzM1j9XOM1wzwuUbwUUtgcVzvo
	Waw2shugIcBnbvRB75eqOoSVZ21JzSLHLiD+iJdz40zP4LMHsJyxUlXMUm+d4Yj2UM2I1GSunSi
	80Zv9R5Xfa/pv65G3hx0P1uSu0bDMzII=
X-Gm-Gg: AY/fxX5TdFn196seVKpFi2+xGCAApAxwdH94g789yFAKfMT+mPq+WnDww3ToATqQsYb
	JKaVaY2f6dhGgihKcfv0eMX4yir65qDSC+f8vQuTHKqMWfAhVuLlZbXXkGt4Zanqd9mZmQjwr7V
	nJrJZ24WI/okXHAMxfIU2mzPY9QJX22khtWOJJALxsitB7/shZKpqsnK6JCMXqv/HpQLkypv75d
	VWKuiy0yg+pjyJUgfLlUjlOniwREMYF67mapQ4lL/NHwCrFLVMO6/Fmk3CceIbS12/N7idJdW2p
	ji70oNtCoyeayNq6mO9F
X-Received: by 2002:a17:90b:3d8f:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-3510915bb29mr3671344a91.22.1768416991354; Wed, 14 Jan 2026
 10:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-2-dongml2@chinatelecom.cn> <CAEf4Bzb+p4fXkCL01MVrvCwPvboeMWXgu4uTSMhweO_MYL+tqg@mail.gmail.com>
 <3026834.e9J7NaK4W3@7940hx>
In-Reply-To: <3026834.e9J7NaK4W3@7940hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 14 Jan 2026 10:56:16 -0800
X-Gm-Features: AZwV_QhhhMbgeUBMJrChYDEp9_IVNQzntrSbFWIrvtYGIewMkOM9tYD4U31ZKF0
Message-ID: <CAEf4Bza84H=FL-KxJEFAn6pFpVBQVnvrpif6_gtf_SWHH4pRJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 01/11] bpf: add fsession support
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

On Tue, Jan 13, 2026 at 6:11=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > The fsession is something that similar to kprobe session. It allow to
> > > attach a single BPF program to both the entry and the exit of the tar=
get
> > > functions.
> > >
> [...]
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bp=
f_verifier_log *log, const struct
> > >                 case BPF_TRACE_FENTRY:
> > >                 case BPF_TRACE_FEXIT:
> > >                 case BPF_MODIFY_RETURN:
> > > +               case BPF_TRACE_FSESSION:
> > >                         /* allow u64* as ctx */
> > >                         if (btf_is_int(t) && t->size =3D=3D 8)
> > >                                 return 0;
> > > @@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf=
_access_type type,
> > >                         fallthrough;
> > >                 case BPF_LSM_CGROUP:
> > >                 case BPF_TRACE_FEXIT:
> > > +               case BPF_TRACE_FSESSION:
> >
> > According to the comment below we make this exception due to LSM.
> > FSESSION won't be using FSESSION programs, no? So this is not
> > necessary?
>
> The comment describe the LSM case here, but the code
> here is not only for LSM. It is also for FEXIT, which makes
> sure that we can get the return value with "ctx[nr_args]".
> So I think we still need it here, as we need to access the
> return value with "ctx[nr_args]" too.

please update the comment then as well

>
> >
> > >                         /* When LSM programs are attached to void LSM=
 hooks
> > >                          * they use FEXIT trampolines and when attach=
ed to
> > >                          * int LSM hooks, they use MODIFY_RETURN tram=
polines.
> >
> > [...]
> >
> > > @@ -4350,6 +4365,7 @@ attach_type_to_prog_type(enum bpf_attach_type a=
ttach_type)
> > >         case BPF_TRACE_RAW_TP:
> > >         case BPF_TRACE_FENTRY:
> > >         case BPF_TRACE_FEXIT:
> > > +       case BPF_TRACE_FSESSION:
> > >         case BPF_MODIFY_RETURN:
> > >                 return BPF_PROG_TYPE_TRACING;
> > >         case BPF_LSM_MAC:
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 2a125d063e62..11e043049d68 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_pro=
g *prog)
> > >
> > >         return (ptype =3D=3D BPF_PROG_TYPE_TRACING &&
> > >                 (eatype =3D=3D BPF_TRACE_FENTRY || eatype =3D=3D BPF_=
TRACE_FEXIT ||
> > > -                eatype =3D=3D BPF_MODIFY_RETURN)) ||
> > > +                eatype =3D=3D BPF_MODIFY_RETURN || eatype =3D=3D BPF=
_TRACE_FSESSION)) ||
> > >                 (ptype =3D=3D BPF_PROG_TYPE_LSM && eatype =3D=3D BPF_=
LSM_MAC);
> >
> > this is getting crazy, switch to the switch (lol) maybe?
>
> ACK
>
> >
> > >  }
> > >
> > > @@ -559,6 +559,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_t=
o_tramp(struct bpf_prog *prog)
> > >                 return BPF_TRAMP_MODIFY_RETURN;
> > >         case BPF_TRACE_FEXIT:
> > >                 return BPF_TRAMP_FEXIT;
> > > +       case BPF_TRACE_FSESSION:
> > > +               return BPF_TRAMP_FSESSION;
> > >         case BPF_LSM_MAC:
> > >                 if (!prog->aux->attach_func_proto->type)
> > >                         /* The function returns void, we cannot modif=
y its
> > > @@ -596,6 +598,8 @@ static int __bpf_trampoline_link_prog(struct bpf_=
tramp_link *link,
> > >  {
> > >         enum bpf_tramp_prog_type kind;
> > >         struct bpf_tramp_link *link_exiting;
> > > +       struct bpf_fsession_link *fslink;
> >
> > initialize to NULL to avoid compiler (falsely, but still) complaining
> > about potentially using uninitialized value
>
> ACK
>
> >
> > > +       struct hlist_head *prog_list;
> > >         int err =3D 0;
> > >         int cnt =3D 0, i;
> > >
> >
> > [...]
> >
> > > -       hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
> > > -       tr->progs_cnt[kind]++;
> > > +       hlist_add_head(&link->tramp_hlist, prog_list);
> > > +       if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > > +               tr->progs_cnt[BPF_TRAMP_FENTRY]++;
> > > +               fslink =3D container_of(link, struct bpf_fsession_lin=
k, link.link);
> > > +               hlist_add_head(&fslink->fexit.tramp_hlist,
> > > +                              &tr->progs_hlist[BPF_TRAMP_FEXIT]);
> >
> > fits under 100 characters? keep on a single line then
>
> ACK
>
> >
> > > +               tr->progs_cnt[BPF_TRAMP_FEXIT]++;
> > > +       } else {
> > > +               tr->progs_cnt[kind]++;
> > > +       }
> > >         err =3D bpf_trampoline_update(tr, true /* lock_direct_mutex *=
/);
> > >         if (err) {
> > >                 hlist_del_init(&link->tramp_hlist);
> > > -               tr->progs_cnt[kind]--;
> > > +               if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > > +                       tr->progs_cnt[BPF_TRAMP_FENTRY]--;
> > > +                       hlist_del_init(&fslink->fexit.tramp_hlist);
> > > +                       tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> > > +               } else {
> > > +                       tr->progs_cnt[kind]--;
> > > +               }
> > >         }
> > >         return err;
> > >  }
> > > @@ -659,6 +683,7 @@ static int __bpf_trampoline_unlink_prog(struct bp=
f_tramp_link *link,
> > >                                         struct bpf_trampoline *tr,
> > >                                         struct bpf_prog *tgt_prog)
> > >  {
> > > +       struct bpf_fsession_link *fslink;
> >
> > used in only one branch, move declaration there?
>
> ACK
>
> Thanks!
> Menglong Dong
>
> >
> > >         enum bpf_tramp_prog_type kind;
> > >         int err;
> > >
> > > @@ -672,6 +697,11 @@ static int __bpf_trampoline_unlink_prog(struct b=
pf_tramp_link *link,
> > >                 guard(mutex)(&tgt_prog->aux->ext_mutex);
> > >                 tgt_prog->aux->is_extended =3D false;
> > >                 return err;
> > > +       } else if (kind =3D=3D BPF_TRAMP_FSESSION) {
> > > +               fslink =3D container_of(link, struct bpf_fsession_lin=
k, link.link);
> > > +               hlist_del_init(&fslink->fexit.tramp_hlist);
> > > +               tr->progs_cnt[BPF_TRAMP_FEXIT]--;
> > > +               kind =3D BPF_TRAMP_FENTRY;
> > >         }
> > >         hlist_del_init(&link->tramp_hlist);
> > >         tr->progs_cnt[kind]--;
> >
> > [...]
> >
>
>
>
>

