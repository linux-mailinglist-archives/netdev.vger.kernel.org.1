Return-Path: <netdev+bounces-234771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC72C271AA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BB41B27B13
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18E329E64;
	Fri, 31 Oct 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHCIzAWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF126C3BE
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948580; cv=none; b=dtQ2To5m7ZUSDiqhaxfBbvjbeesgbeQFEBvmQ/sjUkSCB760yEFJtYwaRAn/LSEmuThPgVVW7tTaHdtF6M7eLLWEwK5jvqR97Fl7sRY/ZsWKkER6W3rSPde9BvF83UAaEkdqDgvsdVjge9wMr401Vnq8U8VeYGUKP4lSpjXhW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948580; c=relaxed/simple;
	bh=NI24yJu8a/oIEMpzBd8OjPM56b0OSOJNISs2lLYq2/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3n/JYAI/XOx97qBGWTnPYpAsk4x1njCqCH8KfSAm2BCumFKvz6VCmj3v6HyYlx5pVAurU+5gLqv20Ba2YUUyDI/Hb99WwGM0Tao0oxJcauQKHBZ6Sx+1bBPBxVdOIa4o6oJTSe/4iyj+z9qk44RCqqQNHYGdc3Th0ogK1bHCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHCIzAWY; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcab6fso28703537b3.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761948578; x=1762553378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8/vetDDr1N9+AK1mZbstJAe26E/PoEWOtPFLT6m+AY=;
        b=kHCIzAWYT+BinkAGCb2/hToi1e1xblFSl8IYel6hUITEv/BEOnQPpE+ECUznofzpi2
         BYy0Rm3bN9fXFjO6emv1TiQG14he3MjaUZ8xZPTEFmlmVml4JbdkiNJ6vccT54vPY2DL
         n5lslYqthanHltxs/Y3+M6lk/dHyh9sLrP8N0eN/EFDzTtD0YV94kpOmL1LKyU8lhrP7
         Fd6QGnowoQCJhZ2A9sjWTN9fpqTQ72wpd/h6Ym+mygVLgWTjPYRO2e63BxJlLJL0Cn2E
         ip1vhbpRWQG10/yztZxmRltCrxHbTRDuEaTXze/NOChqi3I8G4aR88wwgGUkqhc/4gsx
         2cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761948578; x=1762553378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8/vetDDr1N9+AK1mZbstJAe26E/PoEWOtPFLT6m+AY=;
        b=gCw26WsWvSGs4vcUNiTJzZ2yT4GNRXdX8XF7CvHMR2Q9hMRRVI7JHG7BJDzBN+6td7
         D6q6ETuBfV3kCmq+JPfobdSoctzqO0DytnlBB5dgcsalTZa7a/3Dd/tx2imjDIR2B2wX
         eTBuunVV5AcQuns+N+/e5JoAaWh/JydmNwXzUX/QW8UEkd0xhfCrorDdBcuFZK5rDqKM
         VRP586SqujEXB1ia7HImlS+oHhIV7Au33NqXdTKbfj9olQgotLUdMKXc/Uhl5C96og++
         c6sQRkC8VyTjxEjhOGvUd4OtRH6VlXEhVKNnTGsFsE8DnrJDn63V/GYeEV2ao61T5Y5o
         atUg==
X-Forwarded-Encrypted: i=1; AJvYcCXiYUBYozLuXfTiiqA4LsP3NQYDG46eC50xOnlTF8aIuX6mTnc7+deQfKQBLQPQyzWc87euSBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqWoTej7TGS2KCuz7eq/tjrwQshSQnTt9pHGhPkv6F96BzKZ6
	yXod7osv8FkWBRfCxxqp6J94fGErijWON2JtOofdUEu5tkPiuxYN/17y3DB3GmHK53Yxzb/br7j
	4RiI+gU0RCkELHGgf8yDxNQYVXfK0Xcg=
X-Gm-Gg: ASbGncvz2wiLNioeNyzmhq+K+DPMZdhLadJREVysr6QSY86Ail4FpSjB6RxTG+wRJ4d
	GHXCVAn30f7xGyNDZCpyoieS+QpDYiMAo4Qyuu29j5MscY5NCAcpX90NnO2jQwV5i0ZK5uzHpWF
	5rdbpu8lnaqmQ4z+am5NxRszsRouIHaOkI0wcVdkE+v7W5usk5+7ij5u2zfDvG7J2/A/2WFnYyF
	mG95NycxC+e9wjZLUcohStGBU4aT9eC4DJq+o2YOoqeWneyII//MlWC/18RtbVxijQ42hQ=
X-Google-Smtp-Source: AGHT+IFf4AYPhm4Mg9icKGfIH/ctcphuf+l/cgHKXrjRe4LFjjWZUY04+LLvfv0w79qoORycpeTXjCx+dKReOvNBIko=
X-Received: by 2002:a05:690c:4b0d:b0:786:373f:c82b with SMTP id
 00721157ae682-786485b03b3mr41586757b3.70.1761948577840; Fri, 31 Oct 2025
 15:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024212914.1474337-1-ameryhung@gmail.com> <20251024212914.1474337-3-ameryhung@gmail.com>
 <CAEf4BzYnB74djXyb08m7tJE9MGxT-iVOOBsNQO3PFGFDW=vRLA@mail.gmail.com>
In-Reply-To: <CAEf4BzYnB74djXyb08m7tJE9MGxT-iVOOBsNQO3PFGFDW=vRLA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 31 Oct 2025 15:09:26 -0700
X-Gm-Features: AWmQ_blrHrmWDni1qhAAS5MSAMMCLXyBt2N8cz9GjLyEjMjtAjjIx98vJsXeppA
Message-ID: <CAMB2axMQnn-vp2yjnkta7VFU2vwaNcH=PwpL7LCS+u7aFdYvmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Support associating BPF program with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:53=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 24, 2025 at 2:29=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> > a BPF program with a struct_ops map. This command takes a file
> > descriptor of a struct_ops map and a BPF program and set
> > prog->aux->st_ops_assoc to the kdata of the struct_ops map.
> >
> > The command does not accept a struct_ops program nor a non-struct_ops
> > map. Programs of a struct_ops map is automatically associated with the
> > map during map update. If a program is shared between two struct_ops
> > maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> > associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> > be reset since we have lost track of associated struct_ops. For other
> > program types, the associated struct_ops map, once set, cannot be
> > changed later. This restriction may be lifted in the future if there is
> > a use case.
> >
> > A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> > the associated struct_ops pointer. The returned pointer, if not NULL, i=
s
> > guaranteed to be valid and point to a fully updated struct_ops struct.
> > For struct_ops program reused in multiple struct_ops map, the return
> > will be NULL. The call must be paired with bpf_struct_ops_put() once th=
e
> > caller is done with the struct_ops.
> >
> > To make sure the returned pointer to be valid, the command increases th=
e
> > refcount of the map for every associated non-struct_ops programs. For
> > struct_ops programs, since they do not increase the refcount of
> > struct_ops map, bpf_prog_get_assoc_struct_ops() has to bump the refcoun=
t
> > of the map to prevent a map from being freed while the program runs.
> > This can happen if a struct_ops program schedules a time callback that
> > runs after the struct_ops map is freed.
> >
> > struct_ops implementers should note that the struct_ops returned may or
> > may not be attached. The struct_ops implementer will be responsible for
> > tracking and checking the state of the associated struct_ops map if the
> > use case requires an attached struct_ops.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h            | 16 ++++++
> >  include/uapi/linux/bpf.h       | 17 ++++++
> >  kernel/bpf/bpf_struct_ops.c    | 98 ++++++++++++++++++++++++++++++++++
> >  kernel/bpf/core.c              |  3 ++
> >  kernel/bpf/syscall.c           | 46 ++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 17 ++++++
> >  6 files changed, 197 insertions(+)
> >
>
> [...]
>
> > @@ -1394,6 +1414,84 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >         return err;
> >  }
> >
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap)
> > +{
> > +       struct bpf_map *st_ops_assoc;
> > +
> > +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +       st_ops_assoc =3D rcu_access_pointer(prog->aux->st_ops_assoc);
>
> we don't have RCU lock here, can this trigger lockdep warnings due to
> rcu_access_pointer() use?
>
> > +
> > +       if (st_ops_assoc && st_ops_assoc =3D=3D map)
> > +               return 0;
> > +
> > +       if (st_ops_assoc) {
> > +               if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                       return -EBUSY;
> > +
>
> put st_ops_assoc map (if it's not BPF_PTR_POISON already, of course),
> otherwise we are leaking refcount

struct_ops programs do not take refcount on struct_ops map, so we
shouldn't need to drop refcount here.

>
> pw-bot: cr
>
> > +               rcu_assign_pointer(prog->aux->st_ops_assoc, BPF_PTR_POI=
SON);
> > +       } else {
> > +               if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                       bpf_map_inc(map);
> > +
> > +               rcu_assign_pointer(prog->aux->st_ops_assoc, map);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> > +{
> > +       struct bpf_map *st_ops_assoc;
> > +
> > +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +       st_ops_assoc =3D rcu_access_pointer(prog->aux->st_ops_assoc);
> > +
> > +       if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +               return;
> > +
> > +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +               bpf_map_put(st_ops_assoc);
> > +
> > +       RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
> > +}
> > +
> > +/*
> > + * Get a reference to the struct_ops struct (i.e., kdata) associated w=
ith a
> > + * program. Must be paired with bpf_struct_ops_put().
> > + *
> > + * If the returned pointer is not NULL, it must points to a valid and
> > + * initialized struct_ops. The struct_ops may or may not be attached.
> > + * Kernel struct_ops implementers are responsible for tracking and che=
cking
> > + * the state of the struct_ops if the use case requires an attached st=
ruct_ops.
> > + */
> > +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> > +{
> > +       struct bpf_struct_ops_map *st_map;
> > +       struct bpf_map *map;
> > +
> > +       scoped_guard(rcu) {
> > +               map =3D rcu_dereference(aux->st_ops_assoc);
> > +               if (!map || map =3D=3D BPF_PTR_POISON)
> > +                       return NULL;
> > +
> > +               map =3D bpf_map_inc_not_zero(map);
>
> I think this is buggy. When timer callback happens, the map can be
> long gone, and its underlying memory reused for something else. So
> this bpf_map_inc_not_zero() can crash or just corrupt some memory. RCU
> inside this function doesn't do much for us, it happens way too late.
>
> It's also suboptimal that we now require callers of
> bpf_prog_get_assoc_struct_ops() to do manual ref put.
>
> Have you considered getting prog->aux->st_ops_assoc ref incremented
> when scheduling async callback instead? Then we won't need all this
> hackery and caller will just be working with borrowed map reference?
>

Will change kfunc facing APIs to not expose struct_map lifecycle management=
.

> > +               if (IS_ERR(map))
> > +                       return NULL;
> > +       }
> > +
> > +       st_map =3D (struct bpf_struct_ops_map *)map;
> > +
> > +       if (smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF_S=
TRUCT_OPS_STATE_INIT) {
> > +               bpf_map_put(map);
> > +               return NULL;
> > +       }
> > +
> > +       return &st_map->kvalue.data;
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
> > +
> >  void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bp=
f_map *map)
> >  {
>
> [...]

