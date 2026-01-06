Return-Path: <netdev+bounces-247422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E0CFA3E7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 19:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA953316D69A
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9C352942;
	Tue,  6 Jan 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYkM+Y3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874A350D53
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721623; cv=none; b=AYzGfWP5UF8SPOpfgbtHBxFYidE0p5i9lr6eGXj7CQ5PjL4g52a+ZfPt1W7E6rhKFFYJISqB0KxFxu2hgj8g7j1JVSZobUBnlu8Li2ra9R8TGk5KCJtEb9jsY+9BEdf+H30AvgtIMGcEOPbo5dvtAgnO6fddttpZK+GLnZWaSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721623; c=relaxed/simple;
	bh=LzKfxHjX021Rxx+qaw878w7fZbqLwVrvpIS9AwzUcK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3n1Osb8BizuYzUBPN8Y8INtwXVHq43ENtOSiRYRCDe7q3qt2qLecRXmRe8UCEPXVvXwaYdK9q++uNVj9A9tHXVnxgnVwhR+Z+GOpwkb21XZLYVsRdx9LxQ+i3f2Q0yQrUZST5dw0i2sKfPh852JxqXjM+SBPKWBAl5OXOIAzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYkM+Y3e; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-790992528f6so12685647b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767721621; x=1768326421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv2VrgKte6EWJ3FJ6GQEY33foa+IgMPhHq/ka7xvnq0=;
        b=bYkM+Y3e2J7Gjc8hmeLzdBU7Jb632MqCXWD33vHGFJDETlPMdrO96VDUge34GqqsDU
         qMIVibPLo7qPv4wIHrRdI3aIW7pGLYdDnjvcVyi9H+W3i92SvGnLPLGcn1I54AWu5b6Q
         qA0X9cTYwG+Pb8bgO0NjoUsozmtELEXNn6HVErPsBwzkzmxGSFAsy3iEi+kLrIqMV7m8
         u46A7rLGJe9IEzTE6+JWfmJJRZaF5l1eEFBQ+MG3bqoM2OwKgIbtHPWqH9nroMdyqJ5Q
         f8rbiFXn8MBqP/s3fiBy6C+PDd8P79Hxzo6eN5/MM4GbUWGzXPZhC8mMpQrgClYRzgx0
         FQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721621; x=1768326421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sv2VrgKte6EWJ3FJ6GQEY33foa+IgMPhHq/ka7xvnq0=;
        b=qUh17UzYeQ4DLc70gQ9bKqN8//ScYEDZLeSN1Od0BSGEqKedup3EAToLcEKf1dJw5p
         B+MjlKLBGdeUz8IKC7+rZheUZoodC7sgXBwMmMI93AujT8/La16veOWaKKIBkQ3thHmq
         I7N2D99sW7wmXOwRO8km/d6eaUOLn8lRdEymBEm0Aejfv98tdqfnQoXEJTZg+3BAnKX3
         bvcIcsTGbD2mx9llv/yyPhl1G9Le1Cz3KaOUbM5oXt+OGce9DJjJ/luMSa8KafD3EGoK
         as99X74T7A1o2UE7vmTx6qFg2ufZHhWRB/gD/Rt2STb75QExB9HMslB7zD4Nol5FsGGy
         tcJA==
X-Forwarded-Encrypted: i=1; AJvYcCW+38OBVZemU4012EsNHP3ujca0yxabs1g22MP+OYW1RTiu8GGmv1+eEF311FtkcwsPvcA9wss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbxggoT5GDa8ow+SXGPH+DawQfipVj3bdSCtEj3Ai0bnV2s5p
	mcfgfGuAFXJv+Z/VudF2Rws7y97bWlWTURjEfdYJUAgSIROON7LaHMrcXcg2jUn6nUCJHrNtI4I
	DxqInhzo7ggAGtTObfRLfQv/ez95FwxM=
X-Gm-Gg: AY/fxX5k2uUjkABTtgCf6Wvn3Mw7l9DJq7Odp4XCKZucyAys8MRyDqyW6/I9SsUxVKb
	V8dpWsqJ5lnb18Bu/V39G6FVAWSq5Lu8v1vCXue+0OmghefP6dZjBFebgB8vzsfnAdqKu39+OyG
	eu+4HEkZAfVEZUF1p0i5bn/y9kwANLZnJn9NGRzxRNfZevzLeWPbDgmEqYjBCNikEX6axyEO/5w
	9wqj+7TCng0b7pCyCNb9yxncfpI7sWes1jADxX3D0l2mhx402E8/cMaetyZwws4U2Lb0Mi/
X-Google-Smtp-Source: AGHT+IERToY74CI7cXx/KiVYNfIBtr5nmAjqCE4NqRO3Ki/CRNEGFkp2dh8zFJhv1rlECfgmHAhJSgACaxxTE4dpgoQ=
X-Received: by 2002:a05:690e:b8e:b0:63f:a228:1859 with SMTP id
 956f58d0204a3-6470c86845dmr2505982d50.38.1767721620672; Tue, 06 Jan 2026
 09:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
 <CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
 <CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
 <e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev> <CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
 <d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev> <CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
 <CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com> <877btu8wz2.fsf@cloudflare.com>
In-Reply-To: <877btu8wz2.fsf@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Jan 2026 09:46:49 -0800
X-Gm-Features: AQt7F2pVAO8XtXX10DUe6F66fyGvQEPlQzlAGBMU0yOXV1BoNv6h0nbWs4BgUcQ
Message-ID: <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:36=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Mon, Jan 05, 2026 at 06:04 PM -08, Alexei Starovoitov wrote:
> > On Mon, Jan 5, 2026 at 3:19=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >>
> >> >
> >> > >
> >> > > I guess we can mark such emitted call in insn_aux_data as finalize=
d
> >> > > and get_func_proto() isn't needed.
> >> >
> >> > It is a good idea.
> >> >
> >>
> >> Hmm, insn_aux_data has to be marked in gen_{pro,epi}logue since this
> >> is the only place we know whether the call needs fixup or not. However
> >> insn_aux_data is not available yet in gen_{pro,epi}logue because we
> >> haven't resized insn_aux_data.
> >>
> >> Can we do some hack based on the fact that calls emitted by
> >> BPF_EMIT_CALL() are finalized while calls emitted by BPF_RAW_INSN()
> >> most likely are not?
> >> Let BPF_EMIT_CALL() mark the call insn as finalized temporarily (e.g.,
> >> .off =3D 1). Then, when do_misc_fixups() encounters it just reset off =
to
> >> 0 and don't call get_func_proto().
> >
> > marking inside insn via off=3D1 or whatever is an option,
> > but once we remove BPF_CALL_KFUNC from gen_prologue we can
> > delete add_kfunc_in_insns() altogether and replace it with
> > a similar loop that does
> > if (bpf_helper_call()) mark insn_aux_data.
> >
> > That would be a nice benefit, since add_kfunc_call() from there
> > was always a bit odd, since we're adding kfuncs early before the main
> > verifier pass and after, because of gen_prologue.
>
> Thanks for all the pointers.
>
> I understood we're looking for something like this:
>
> ---8<---
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b32ddf0f0ab3..9ccd56c04a45 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
>         bool non_sleepable; /* helper/kfunc may be called from non-sleepa=
ble context */
>         bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
>         bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with pro=
g percpu alloc */
> +       bool finalized_call; /* call holds function offset relative to __=
bpf_base_call */
>         u8 alu_state; /* used in combination with alu_limit */
>         /* true if STX or LDX instruction is a part of a spill/fill
>          * pattern for a bpf_fastcall call.
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1ca5c5e895ee..cc737d103cdd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21806,6 +21806,14 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>                         env->prog =3D new_prog;
>                         delta +=3D cnt - 1;
>
> +                       /* gen_prologue emits function calls with target =
address
> +                        * relative to __bpf_call_base. Skip patch_call_i=
mm fixup.
> +                        */
> +                       for (i =3D 0; i < cnt - 1; i++) {
> +                               if (bpf_helper_call(&env->prog->insnsi[i]=
))
> +                                       env->insn_aux_data[i].finalized_c=
all =3D true;
> +                       }
> +
>                         ret =3D add_kfunc_in_insns(env, insn_buf, cnt - 1=
);

And then we can get rid of this function as there is no use case for
having a new kfunc in gen_{pro,epi}logue.

>                         if (ret < 0)
>                                 return ret;
> @@ -23412,6 +23420,9 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         goto next_insn;
>                 }
>  patch_call_imm:
> +               if (env->insn_aux_data[i + delta].finalized_call)
> +                       goto next_insn;
> +
>                 fn =3D env->ops->get_func_proto(insn->imm, env->prog);
>                 /* all functions that have prototype and verifier allowed
>                  * programs to call them, must be real in-kernel function=
s
> @@ -23423,6 +23434,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         return -EFAULT;
>                 }
>                 insn->imm =3D fn->func - __bpf_call_base;
> +               env->insn_aux_data[i + delta].finalized_call =3D true;
>  next_insn:
>                 if (subprogs[cur_subprog + 1].start =3D=3D i + delta + 1)=
 {
>                         subprogs[cur_subprog].stack_depth +=3D stack_dept=
h_extra;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f5bc6a505e1..53993c2c492d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *in=
sn_buf, u32 pkt_access_flags,
>         /* ret =3D bpf_skb_pull_data(skb, 0); */
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>         *insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> -       *insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> -                              BPF_FUNC_skb_pull_data);

This is why I was suggesting setting off =3D 1 in BPF_EMIT_CALL to mark
a call as finalized. So that we can continue to support using
BPF_RAW_INSN to emit a helper call in prologue and epilogue.

> +       *insn++ =3D BPF_EMIT_CALL(bpf_skb_pull_data);
>         /* if (!ret)
>          *      goto restore;
>          * return TC_ACT_SHOT;
> @@ -9135,11 +9134,8 @@ static int bpf_gen_ld_abs(const struct bpf_insn *o=
rig,
>         return insn - insn_buf;
>  }
>
> -__bpf_kfunc_start_defs();
> -
> -__bpf_kfunc void bpf_skb_meta_realign(struct __sk_buff *skb_)
> +static void bpf_skb_meta_realign(struct sk_buff *skb)
>  {
> -       struct sk_buff *skb =3D (typeof(skb))skb_;
>         u8 *meta_end =3D skb_metadata_end(skb);
>         u8 meta_len =3D skb_metadata_len(skb);
>         u8 *meta;
> @@ -9161,14 +9157,6 @@ __bpf_kfunc void bpf_skb_meta_realign(struct __sk_=
buff *skb_)
>         bpf_compute_data_pointers(skb);
>  }
>
> -__bpf_kfunc_end_defs();
> -
> -BTF_KFUNCS_START(tc_cls_act_hidden_ids)
> -BTF_ID_FLAGS(func, bpf_skb_meta_realign)
> -BTF_KFUNCS_END(tc_cls_act_hidden_ids)
> -
> -BTF_ID_LIST_SINGLE(bpf_skb_meta_realign_ids, func, bpf_skb_meta_realign)
> -
>  static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access=
_flags,
>                                const struct bpf_prog *prog)
>  {
> @@ -9182,8 +9170,10 @@ static int tc_cls_act_prologue(struct bpf_insn *in=
sn_buf, u32 pkt_access_flags,
>                  * r0 =3D bpf_skb_meta_realign(r1); // r0 is undefined
>                  * r1 =3D r6;
>                  */
> +               BUILD_BUG_ON(!__same_type(&bpf_skb_meta_realign,
> +                                         (void (*)(struct sk_buff *skb))=
NULL));
>                 *insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> -               *insn++ =3D BPF_CALL_KFUNC(0, bpf_skb_meta_realign_ids[0]=
);
> +               *insn++ =3D BPF_EMIT_CALL(bpf_skb_meta_realign);
>                 *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
>         }
>         cnt =3D bpf_unclone_prologue(insn, pkt_access_flags, prog, TC_ACT=
_SHOT);

