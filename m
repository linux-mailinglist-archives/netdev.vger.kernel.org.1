Return-Path: <netdev+bounces-235574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3FC32826
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F09914E1D41
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098B324B32;
	Tue,  4 Nov 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqn3YCgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067433DECC
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279442; cv=none; b=AWUatBNLkuA9hnTRTgXewpcYmnLT/PRo/aiUkdKd2gozF2TXrta1e1LvH30R98g6Xv6nflfvFl8l1Z//rTNcRP+QREC0Yr51U0BuxYuAQ25yr/hGW4h1/Eafq1jzh0viCjn8tNq82tHVbRtwfhSBeMbSpflxfCgyLCpCohZlYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279442; c=relaxed/simple;
	bh=yXSHAkAaFCC5x73vwswZ6CTo4/EiFFGD8vR2kR0hm0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdMdpcSvD5gu2ZenWR4fspVlRzWCq3PthYLALiwnPaBkB/ZTILfDR/HlzGpFPBpAr5CJOI74pjLi7xeoy9X025gnSieLRhCi3FURjQzg0HenoLHadL3vNghsRiI1zQYmkgsM5lVztLLTDDV1q2u2yau6MzxJzN0xZR4mBtnsV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqn3YCgQ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e393c49f1so5351579d50.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279439; x=1762884239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AFNPU/1wrMTKp4c1lZwT9/Mc95138ORXuWemPSnGfA=;
        b=iqn3YCgQiUWlcwa/8uwl4/wT41HYRiNPasYlEtWVD5qLsWFTfDGfEqjrDpo7vtYm4v
         Lb5ll/FLZVaWAeLwxe5okqG9K4K4/Ft8KYv4ZXptm7UybicQ8YvFSAhcEr69ceCeEOQk
         BUvRrcC4F07p6BPcLWj9NJMKooHyDC9l04ZWPq1QrVi6NblLXaVPSPfbRSzWWDylkJ2m
         XzrpkAWI6ufDXpmVp5kokNtLMpjB/Z9a4f2z777J3LQBNCgFwPAuuG2mzwl2SE7vf8cO
         KWXP4iAI07CLlYMwSjxyujnYbCDiI3/QX4F8ZJh9docWgX45nbiIZ9BdpxWEYcuKwJWB
         Ytkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279439; x=1762884239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AFNPU/1wrMTKp4c1lZwT9/Mc95138ORXuWemPSnGfA=;
        b=PJDlAE7NMbTP44CILlNrubCyT+XVvnz8y02cBlKOoAuglEPLesHLBftfmqJyn2X+hZ
         o71iVg/cW0PLwfB7eXxsJZ8fv63onYBlhc/Tmk+n0EWVNVjgZo8FDHxdSm2UoDKd0TSB
         eZEX9pZalOV2i9pSnI4Il5H160JQo24zuM/iFXAhkE9TI3jQVURZ+cmWE6eLDmUjDh7n
         5vZxDuMbjqmfW+fohG/kSfPEPCuk1fiJSuAzfY+5JqLHNp3cl30Gmijc+FZNrfP04vk5
         7V1SqSg+h6VQldnqFiyFUeY24hiIozfu5g0EW9aSojXVRzk+TBz7H7jDkPKUnHcW9Sxl
         gL2w==
X-Forwarded-Encrypted: i=1; AJvYcCVRhZL3TNegFP94SdAFllL8OayQAii9duGwjmv74I398t6+m9qtszryKQU01g1TpxnJX0qHEVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qbe83xH3Zn5RQy85ilCwlOmhpMzRV4wjT35YHufGrrpUaVfD
	ABrBULystcXdcM4tM6KWnNPTMoRV72w09L+9a2YzmAuipWekUrkjHOgawIhbv1HOSwnzXjB7LCB
	UOLBFOySvnsrZEn6vuPsHeHZd7RZ6jcs=
X-Gm-Gg: ASbGnctG3HaEnrhsiYZ8rgfFfNfIHIzhVXGT08UsBfwX0Ch5DhdPsNZZnIPnCWyfU2l
	ADGlNYEWbxfnOAqUCKmKT6pI4dgEw8envRYe1tHkdHElu7AB/GtW0hjuniAgoYDFZJzl1+EWFbe
	likQkJgu/tMgo5cD7BO8FRyJcEBKM9DVVPCcG8Z3y6NvnfL6tzWXFMDWmuKbg/cRq1JtFCkqivy
	tXxJGZsPOUsERStvo+UZT2YlFuCecqos7uWzVt6ewa05MFz0Cea/EkoSwXWv9d87P6TbnTBfmhs
	npXn8hRMJ+Y=
X-Google-Smtp-Source: AGHT+IGjQhEYKGOLIYHhbHakhgp7lUlW8J8MOz2grZPju7AN1NvbSSB2geQgdZskJiAb6oBB/Lu6ljbSlrZCZPw0KG4=
X-Received: by 2002:a05:690e:429a:10b0:63f:c359:10dc with SMTP id
 956f58d0204a3-63fd358205amr326604d50.56.1762279438881; Tue, 04 Nov 2025
 10:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-3-ameryhung@gmail.com> <e9468bb9f2cc62c69d9364a4ce2ab5ee08fafa6576d6be6a121b04a80a379094@mail.kernel.org>
In-Reply-To: <e9468bb9f2cc62c69d9364a4ce2ab5ee08fafa6576d6be6a121b04a80a379094@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 10:03:47 -0800
X-Gm-Features: AWmQ_bl7M8pnh_tkmQsKcI0afbDQVTes5Qw-Q4x4SOwQ8tW808Oei-2iXvstjTY
Message-ID: <CAMB2axMsX6g2ByUtM31yqVvsTO9gGgDUKsMstpZtJLcv_90qVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a47d67db3..0f71030c0 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
>
> [ ... ]
>
> > @@ -2026,6 +2028,9 @@ static inline void bpf_module_put(const void *dat=
a, struct module *owner)
> >               module_put(owner);
> >  }
> >  int bpf_struct_ops_link_create(union bpf_attr *attr);
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap);
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
> > +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
> >  u32 bpf_struct_ops_id(const void *kdata);
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index a41e6730e..0a19842da 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
>
> [ ... ]
>
> > @@ -1394,6 +1413,77 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >       return err;
> >  }
> >
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap)
> > +{
> > +     struct bpf_map *st_ops_assoc;
> > +
> > +     guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +     st_ops_assoc =3D prog->aux->st_ops_assoc;
> > +
> > +     if (st_ops_assoc && st_ops_assoc =3D=3D map)
> > +             return 0;
> > +
> > +     if (st_ops_assoc) {
> > +             if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     return -EBUSY;
> > +
> > +             WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
> > +     } else {
> > +             if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     bpf_map_inc(map);
> > +
> > +             WRITE_ONCE(prog->aux->st_ops_assoc, map);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> > +{
> > +     struct bpf_map *st_ops_assoc;
> > +
> > +     guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +     st_ops_assoc =3D prog->aux->st_ops_assoc;
> > +
> > +     if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +             return;
> > +
> > +     if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +             bpf_map_put(st_ops_assoc);
> > +
> > +     WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
> > +}
> > +
> > +/*
> > + * Get a reference to the struct_ops struct (i.e., kdata) associated w=
ith a
> > + * program.
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
> > +     struct bpf_map *st_ops_assoc =3D READ_ONCE(aux->st_ops_assoc);
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +             return NULL;
> > +
> > +     st_map =3D (struct bpf_struct_ops_map *)st_ops_assoc;
> > +
> > +     if (smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF_STR=
UCT_OPS_STATE_INIT) {
> > +             bpf_map_put(st_ops_assoc);
>                 ^^^^
>
> Does bpf_prog_get_assoc_struct_ops() need to call bpf_map_put() here?
>

Right. bpf_map_put() is not needed here. It was some artifact in v4.
Will respin and fix it.

> The function comment says "Get a reference to the struct_ops struct"
> but the function never calls bpf_map_get/inc() to acquire a reference.
> It only reads aux->st_ops_assoc via READ_ONCE().
>
> When the state check fails (INIT state), the function calls bpf_map_put()
> which drops the reference that was acquired in bpf_prog_assoc_struct_ops(=
).
> But on the success path below, it returns kdata without any refcount
> operation.
>
> This creates an imbalance:
> - INIT state path: drops a reference, returns NULL
> - Non-INIT path: no refcount change, returns kdata
>
> The caller has no way to know whether the reference count was modified.
> Also, the function is EXPORTED but doesn't document the reference countin=
g
> semantics clearly.
>
> > +             return NULL;
> > +     }
> > +
> > +     return &st_map->kvalue.data;
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
>
> Can this function race with bpf_prog_disassoc_struct_ops()?
>
> Since bpf_prog_get_assoc_struct_ops() reads aux->st_ops_assoc via
> READ_ONCE() without holding the mutex or acquiring a reference, there's
> a window where:
>
> Thread A: reads st_ops_assoc pointer
> Thread B: calls bpf_prog_disassoc_struct_ops()->bpf_map_put() (drops last=
 ref)
> Thread A: dereferences st_map->kvalue.common.state (use-after-free)
>
> For non-struct_ops programs, bpf_prog_assoc_struct_ops() holds a
> reference via bpf_map_inc(). This reference is dropped in
> bpf_prog_disassoc_struct_ops() when the program is freed. Without
> acquiring a new reference in bpf_prog_get_assoc_struct_ops(), the map
> can be freed during the race window above.

This is fine. bpf_prog_get_assoc_struct_ops() should only be called by
kfunc (i.e., when a BPF program is still alive). Refcount has been
bumped during the BPF_PROG_ASSOC_STRUCT_OPS command or during async
callback registration.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/190776=
79684

