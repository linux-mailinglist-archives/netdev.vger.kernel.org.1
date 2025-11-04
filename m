Return-Path: <netdev+bounces-235637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640EEC3361B
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0793AAB7F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739262DF147;
	Tue,  4 Nov 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAzdb9zA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9E2DF140
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298855; cv=none; b=beHgVzfTitcNTFlI02ek4HXACn8Gc7favwPcl9bcow5HXSnAdmvOD9xAQqRhpmSB7iHia4PySxPqiXLd1qPuP13rr8TjJgR+1XdHOthrnJ7dYRaGS/e9HWe90k3WWWI9acXYkJ9ZnWPkDrsh40D/6l6NfTVFd1MMXvnfFeYnGCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298855; c=relaxed/simple;
	bh=8LXlFjY1RjJzAXdLXa2CrRRvawAfCKe1Vmnvciz5Oss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzFzRmVRHUTU2NhH5e8PDDxtbNRysPEzy5LhpVYIA0rG3R4FnkZZVCaSO93t2F8S87vl656021FKsob5f9sUcswc21fMgEuEMi3m7zaka6z+fVh7XP5yVMMRZ5P8+pQ2j/HHdm3N4LisZnYtbQTrw1c6jbSlM1X1KUoYzxKrHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAzdb9zA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7866aca9ff4so32217957b3.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 15:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298853; x=1762903653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrvhRnzXyBG1pEthFHBQQDcgqmGBC0dYaMltpqQHl8s=;
        b=YAzdb9zAgEbNWQrxtf8eZRawqT2rQ416Gn1E7sMMRq4assfszFrgUjPQKA61xB1OlD
         qnRAFyHmtFKvgaaASFQN4NZo7uQ8jXa1R1sRznUnN+0stmYJhCqzK0rk4Klk81w8t6rl
         FctK3NIR2Srj7hj8Px0UD81C2k2IpMzNi+GJ2q75s3MrJZL6DbX9MBHQdLIPmNl4P76U
         6dLfy0gziTKoMDJAFavr4SIOCYIRwTqUJ7ucsw4lThXXlWJHHVeI77JwSWeApuWSTSPF
         p+IC2dDwq+nuyU/Wtt945VMRnc9x5ZWQzf+1AdXEetdO2c6FkuVGeuC14z1ugvI1I66q
         3RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298853; x=1762903653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrvhRnzXyBG1pEthFHBQQDcgqmGBC0dYaMltpqQHl8s=;
        b=sFCaraSv/3mji+WG1TWdgyibDzXuUuBHbEMCZt/zc7PO12p3E37TGi7GRZ3zxM0JYf
         b5CbfcBBJrDag3BB8jziIoL55wPnGHIY/EHKYo+foRsOBd9tEVr8D6y7zMTyjzSw0reW
         ZyzePAwRyURdh1O8UT9F6049o+APYcBMF0vPTAyUEQgToHCeXV4ZnJNDc4MLZDcdjXhS
         WoZJIESYOpj1aUUqbEwQ/3nxSzYfGJ4jtXkg+37qdL9WLM3u/57t/0OiyqHm1MERamlF
         2TF4xDhoO5Iox036S4LCvXJ3NS8c0aerMNknlq0/sXxkT9GFfE4V2Uw3zhzZm+ViDH0E
         GzoA==
X-Forwarded-Encrypted: i=1; AJvYcCWDRG9PB55kkAGUq8Y5a6ZEegzSK3WohDzjJKgo/DVIeUOk7IwV5yWql4ZRNlaiaQhBjYhLDg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRs9ELGKMwq/6mst5ih9g+ikIsTgts4y5pb87Pv7KeZ7FYwqM
	5vg/zlJM5kqWq9vxu+VsBvJvSr2pmCjMlW7pzI7w6ATrxwmHIRHhhDLWshm+ncnNsMmUYmTNyWr
	gDpD/aJ4rhN7K2mEpcOhA7k7ogyMsozY=
X-Gm-Gg: ASbGnctP86CJqw6tAzwK1DFFsW+89zyYlqycmui3YzBORhplZcZHdMF1xcpY226zTYU
	8bBtMjSlLEyPuca4nzhwrUQoW9kvJDGUlKAAK60X67eKZDzOgcdLLMWJDVYbQ94launp+399PZv
	JfFLljwDT9V5p/m4BoqcKkc4EZVKI/vhmiVDcGvjALtwhxKIAgx+wN6jrsiPK/uh0FWboNN1NNF
	8aW2+FZJlJR2zvS5iCtyPjRabpw8HYKXXPYfUqnHYjUzJ+BC9Yr6EA/kcmwoLn+sFXo5Nc8Kn+A
X-Google-Smtp-Source: AGHT+IHVOGCzMJwJGSzweRhRBKkR7kvuCHMZykUA18koF44suDs3f9CmocdAMcztQNiCwuPDCYAYrAEqJENajKzjJHo=
X-Received: by 2002:a05:690c:6e0f:b0:786:5620:fae8 with SMTP id
 00721157ae682-786a458d8efmr12985027b3.48.1762298852705; Tue, 04 Nov 2025
 15:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-3-ameryhung@gmail.com>
 <CAEf4Bzbz4jY3cKGxPro7yn_2tjKqkK6P+oU8_8ZZhAfewkNEnw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbz4jY3cKGxPro7yn_2tjKqkK6P+oU8_8ZZhAfewkNEnw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 15:27:19 -0800
X-Gm-Features: AWmQ_blwMYpb9cc2eCcqO4JGZ8tkPxoWPxGFFnzcJHLKuhGXTAQjjc5LjxTo3ho
Message-ID: <CAMB2axM8DuaCbO=jHf+XbqM_9YyTqdQpUH738c1=dnYBaXRMvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:47=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
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
> > will be NULL.
> >
> > To make sure the returned pointer to be valid, the command increases th=
e
> > refcount of the map for every associated non-struct_ops programs. For
> > struct_ops programs, the destruction of a struct_ops map already waits =
for
> > its BPF programs to finish running. A later patch will further make sur=
e
> > the map will not be freed when an async callback schedule from struct_o=
ps
> > is running.
> >
> > struct_ops implementers should note that the struct_ops returned may or
> > may not be attached. The struct_ops implementer will be responsible for
> > tracking and checking the state of the associated struct_ops map if the
> > use case requires an attached struct_ops.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h            | 16 ++++++
> >  include/uapi/linux/bpf.h       | 17 +++++++
> >  kernel/bpf/bpf_struct_ops.c    | 90 ++++++++++++++++++++++++++++++++++
> >  kernel/bpf/core.c              |  3 ++
> >  kernel/bpf/syscall.c           | 46 +++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 17 +++++++
> >  6 files changed, 189 insertions(+)
> >
>
> [...]
>
> >  static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *s=
t_map)
> >  {
> >         int i;
> > @@ -801,6 +812,12 @@ static long bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> >                         goto reset_unlock;
> >                 }
> >
> > +               err =3D bpf_prog_assoc_struct_ops(prog, &st_map->map);
> > +               if (err) {
> > +                       bpf_prog_put(prog);
> > +                       goto reset_unlock;
> > +               }
> > +
> >                 link =3D kzalloc(sizeof(*link), GFP_USER);
> >                 if (!link) {
>
> I think we need to call bpf_prog_disassoc_struct_ops() here if
> kzalloc() fails (just like we do bpf_prog_put). After kzalloc link
> will be put into plink list and generic clean up path will handle all
> this, but not here.
>

1 point for catching a bug that was missed by AI. I will move
bpf_prog_assoc_struct_ops() after the link is successfully created.

> >                         bpf_prog_put(prog);
> > @@ -980,6 +997,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> >         if (btf_is_module(st_map->btf))
> >                 module_put(st_map->st_ops_desc->st_ops->owner);
> >
> > +       bpf_struct_ops_map_dissoc_progs(st_map);
> > +
> >         bpf_struct_ops_map_del_ksyms(st_map);
> >
> >         /* The struct_ops's function may switch to another struct_ops.
>
> [...]

