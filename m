Return-Path: <netdev+bounces-230189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B3BE5159
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E37819A5F72
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1570235BEE;
	Thu, 16 Oct 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeRpnaKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02B262A6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640084; cv=none; b=P/2CYUF5Vhlu/BKWG1n2MQJJIrzEyiHH47BV12up2HAxKZeu7PfORIwxS+cNWTaAFiZ0A3Io/dZqNJdaE4Xe530bVYuJGJxJQj7rgC2hHS9xOucvsDk+80BKrF5TeNnxyXrxe7GupjwQ8VKydPOI2I7ntJhSwaSVQOA16j8inLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640084; c=relaxed/simple;
	bh=HcRduAOkMhRguvZPmMplj2R2qBLQSNFSj+MyA7gT3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGpNFJvcdkHkXEVq9629mZ/fv1ufVDJg1wiu/RnkvsRaNdXVp6Zp32wRILfN8NxgmmgTVJLXg2dvrFciPQT4YJbC9URhOtoY53zZySOum/5SH2uUmpWOV4bfKY3aQ4nfqdh6MLT7X/blVI5dG/2LxXthQ4upDo9pOYUMQ8UL+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeRpnaKF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso1053720a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640083; x=1761244883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kvLJ/laGzw9IIGcz9cWJT22pNRifQD5Ko61iDZYwmw=;
        b=SeRpnaKFBFy/hvxM44bZ5OrGp8PuMe6pDy1sAzOiXjNiawMNGN5Ue2N21I0nP7v09b
         EndMBCNyOjOWehgTA2nKgslAheaY+/gkmr5/QM01B9UQ5MiWSQ3K86WKFsxQ/0g4IEKq
         npB8LRMsnmBNbSbagwTnA0DY+8ISO02s4YKRXJZZJyIVcFavf02CojSjPc6T9eE6MkiY
         GWjnzbbTI7nYdpPuqbRXwCkf2wyGGe0aBbK7gTD8igjqN8SUaIjmUhOpOyH7bGFaZ2Sh
         favlDE46yz4Km+EmVOTjoVMUl0pIrVIEzS8Iw2D+vIaV84cUFMl7LG87cPyEhAZ1ZW4A
         pwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640083; x=1761244883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kvLJ/laGzw9IIGcz9cWJT22pNRifQD5Ko61iDZYwmw=;
        b=v3JQGh7AvpCiO3NU3K+Wwf4QKrNF8v4yvcGYjwYgyNi17/WgjG83ZxjOm0LL4bc1RM
         6zNONw8kBZtCzDnMQL+6tsrAKyRFR7d3//b8sCuSwNIT75Ie/KGJqFrhDeJHOVLIO4uQ
         H97XIfhBlcOS8fQE040b1CZMpPacZdP6JuSyfjC0Jh+/oCLmHTpDHoC6/b8PNBaqglJE
         3sJLDk0cmTSWoNbG9lqdsOS89GIRDEVnpdGmY03krPyH/VOw6klkwODHhw63Wf42oLqh
         LtxrOpPlfaBktGvJSWB8ZYex4cXBaICQwvBNZzn2qQXj0UmaWq7RVzHKK0h+MExOA+/w
         0UZw==
X-Forwarded-Encrypted: i=1; AJvYcCUuqEChTrhFHGVlWdTL4mW7ZLh4m5epPPh9pCDi+qqi3MwgTxovKZq0ZRh3Wlpaz5Z4nvzTmyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqLnfccchX/HMxo7Yd8MF328AdkQwkP5lFp2UecLMRQJkY9KO
	s+t8dwcIT2J62xtZrD0+WluDqZJtpJgpJSt2mzlPB1ouoQFrhAKC13SK1NPFGwqx+/g6r58kyoz
	bYuo+DgDxTV5Mt4959VwKgmu5C1VBKkw=
X-Gm-Gg: ASbGncvfcYOgp0z1IR1PibMMIi0B7B89Q7g4WhrOe+tAEDQl6x6GvKF7z7vt27UMznC
	UQ7TaxuqveJ6+ab1I+ySCY6QfR2+1IjQ3ZJX4L+eS9qpDAr6DgM7aOzOtE9rMFRO4zj6zfYU02A
	2UvpnQ0igeDYT6D3B71gDACz4sgdiKjouOsPeRNF9nzss6bhQENjs/UwQP0b8+AkPg+r8J6Ts2Q
	Qce8RM6ishVhIElvOmbaIvQybDMcruVqufvgj4M6hBoRNrwH3tTCl41gm6TFi/TwYSjXTkJdG3W
	NCWDqhINh6f+WHp5dm9FUw==
X-Google-Smtp-Source: AGHT+IHksK6zHHXEZhidpSOSopL3XuBqhuvPbN22SNJzp0gXRHPPANZsyP6f346zd6pa38fd5HflEjyAhnaQPUuIpKE=
X-Received: by 2002:a17:90b:3f10:b0:330:84dc:d11b with SMTP id
 98e67ed59e1d1-33bcf8e4e19mr793789a91.18.1760640082491; Thu, 16 Oct 2025
 11:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-3-ameryhung@gmail.com>
 <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com> <CAMB2axN7o0pHca_u2HnbMb+pEOJubRR8Y8JewExzwxaRWtKUmQ@mail.gmail.com>
In-Reply-To: <CAMB2axN7o0pHca_u2HnbMb+pEOJubRR8Y8JewExzwxaRWtKUmQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:41:06 -0700
X-Gm-Features: AS18NWC0gh3ZBEPZK-ETwn3WfKdzJxK0qtkoA7PM5Lyf6t9FbQMn16MrmkDLYUU
Message-ID: <CAEf4BzbpVkpCyQX4C0gn13t63LETAfGpbf27rSJKyMcp=ELKDw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:35=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 5:10=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > > Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associat=
ing
> > > a BPF program with a struct_ops. This command takes a file descriptor=
 of
> > > a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
> > > the kdata of the struct_ops map.
> > >
> > > The command does not accept a struct_ops program or a non-struct_ops
> > > map. Programs of a struct_ops map is automatically associated with th=
e
> > > map during map update. If a program is shared between two struct_ops
> > > maps, the first one will be the map associated with the program. The
> > > associated struct_ops map, once set cannot be changed later. This
> > > restriction may be lifted in the future if there is a use case.
> > >
> > > Each associated programs except struct_ops programs of the map will t=
ake
> > > a refcount on the map to pin it so that prog->aux->st_ops_assoc, if s=
et,
> > > is always valid. However, it is not guaranteed whether the map member=
s
> > > are fully updated nor is it attached or not. For example, a BPF progr=
am
> > > can be associated with a struct_ops map before map_update. The
> > > struct_ops implementer will be responsible for maintaining and checki=
ng
> > > the state of the associated struct_ops map before accessing it.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  include/linux/bpf.h            | 11 ++++++++++
> > >  include/uapi/linux/bpf.h       | 16 ++++++++++++++
> > >  kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
> > >  kernel/bpf/core.c              |  6 ++++++
> > >  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
> > >  6 files changed, 119 insertions(+)
> > >

[...]

> > > +       } struct_ops_assoc_prog;
> > > +
> > >  } __attribute__((aligned(8)));
> > >
> > >  /* The description below is an attempt at providing documentation to=
 eBPF
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index a41e6730edcf..e57428e1653b 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct b=
pf_struct_ops_map *st_map)
> > >         for (i =3D 0; i < st_map->funcs_cnt; i++) {
> > >                 if (!st_map->links[i])
> > >                         break;
> > > +               bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
> > >                 bpf_link_put(st_map->links[i]);
> > >                 st_map->links[i] =3D NULL;
> > >         }
> > > @@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struc=
t bpf_map *map, void *key,
> > >                         goto reset_unlock;
> > >                 }
> > >
> > > +               /* Don't stop a program from being reused. prog->aux-=
>st_ops_assoc
> >
> > nit: comment style, we are converging onto /* on separate line
>
> Got it, so I assume it applies to kerne/bpf/* even existing comments
> in the file are netdev style. Is it also the case for
> net/core/filter.c?

yeah

>
>
> >
> > > +                * will point to the first struct_ops kdata.
> > > +                */
> > > +               bpf_struct_ops_assoc_prog(&st_map->map, prog);
> >
> > ignoring error? we should do something better here... poisoning this
> > association altogether if program is used in multiple struct_ops seems
> > like the only thing we can reasonable do, no?
> >
> > > +
> > >                 link =3D kzalloc(sizeof(*link), GFP_USER);
> > >                 if (!link) {
> > >                         bpf_prog_put(prog);
> >
> > [...]
> >
> > >
> > > +#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_pr=
og.prog_fd
> > > +
> >
> > looking at libbpf side, it's quite a mouthful to write out
> > bpf_struct_ops_associate_prog()... maybe let's shorten this to
> > BPF_STRUCT_OPS_ASSOC or BPF_ASSOC_STRUCT_OPS (with the idea that we
> > associate struct_ops with a program). The latter is actually a bit
> > more preferable, because then we can have a meaningful high-level
> > bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map
> > *map), where map has to be struct_ops. Having bpf_map__assoc_prog() is
> > a bit too generic, as this works only for struct_ops maps.
> >
> > It's all not major, but I think that lends for a bit better naming and
> > more logical usage throughout.
>
> Will change the naming.

thanks

>
> >
> > > +static int struct_ops_assoc_prog(union bpf_attr *attr)
> > > +{
> > > +       struct bpf_prog *prog;
> > > +       struct bpf_map *map;
> > > +       int ret;
> > > +
> > > +       if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
> > > +               return -EINVAL;
> > > +
> > > +       prog =3D bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
> > > +       if (IS_ERR(prog))
> > > +               return PTR_ERR(prog);
> > > +
> > > +       map =3D bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
> > > +       if (IS_ERR(map)) {
> > > +               ret =3D PTR_ERR(map);
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> > > +           prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> >
> > you can check prog->type earlier, before getting map itself
>
> Got it. I will make it a separate check right after getting prog.
>
> >
> > > +               ret =3D -EINVAL;
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret =3D bpf_struct_ops_assoc_prog(map, prog);
> > > +out:
> > > +       if (ret && !IS_ERR(map))
> >
> > nit: purely stylistic preference, but I'd rather have a clear
> > error-only clean up path, and success with explicit return 0, instead
> > of checking ret or IS_ERR(map)
> >
> >     ...
> >
> >     /* goto to put_{map,prog}, depending on how far we've got */
> >
> >     err =3D bpf_struct_ops_assoc_prog(map, prog);
> >     if (err)
> >         goto put_map;
> >
> >     return 0;
> >
> > put_map:
> >     bpf_map_put(map);
> > put_prog:
> >     bpf_prog_put(prog);
> >     return err;
>
> I will separate error path out.

great, thanks

>
> >
> >
> > > +               bpf_map_put(map);
> > > +       bpf_prog_put(prog);
> > > +       return ret;
> > > +}
> > > +
> >
> > [...]

