Return-Path: <netdev+bounces-228993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEBCBD6D62
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F082A42168B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E61224FA;
	Tue, 14 Oct 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMsClh19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E0335971
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400644; cv=none; b=H9kPOvPVRctQ8uvJ4OCXU8RDz+iFPerroxAou97nchR2wjYiA2uLPFnHVVOc2gdWCoHN+HS/syVjxSZqPWTnsx1P5fm3GgvOIOFpy8pAo3VprAiel1Rg/FCFWoem03yAVWRtIDM0AnRccIBzzmJn5IoKAznDU/Q3D6M0dAHKI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400644; c=relaxed/simple;
	bh=zKQXpWSM/9juP+o/FRcoKuWdqiWCx/NaLVc0YDlhAdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMpdy8aUqX+TXNLMfs1Ugjff28zhMxk/+HNWdUPqlTEKmtUmbbe7eNoafFtamW1zlQM7sjO+S9a/4+AW/GIRe9d3D/s6y73RGa+BvzohX8TPtL1CYRopeEn6kE78i9ty7L/zaw8EN3GiRv+Zq00jB1fw6/R9irqvyCTFUNQX0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMsClh19; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3821363a91.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 17:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400642; x=1761005442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbI7VdlcoLK5j++SIdQul9mBT5JZEkngCuUhU52TEAs=;
        b=EMsClh19yeVviBLY2hyO0+c10KbxHxM+5NUv2rW0D8q37jXf/X0EYX+4BkndiktSv2
         1vrSggpwsQ4FOkOTPWeba3kMPew+oX9fzCgcVseXU8WAljZzgf9Joj/OzclZacT5zn3T
         nzVuHbkccr0BgKtETJxRX+7RVby9AEwQDh4F9NoqNGdU5DoVwIRX3Qa3+IB6Xgul6F0N
         Ht0mfIBNnhNmEgAQx48h5c3zemFDsd0LKyLmO61ROLkPqtFF5PM/bbwQ0LPbUThNYj01
         HwGJLGw+p3muzb7e6Op5kV9rcLS39RYP1kMb38FntatJU/wR62cUJHKTgE7sTfB0Ru8F
         hDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400642; x=1761005442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbI7VdlcoLK5j++SIdQul9mBT5JZEkngCuUhU52TEAs=;
        b=XHzDMH5jsMdBKRUEu0w0cmWg7tJ7p/Z9A54y9jZnGzWaPXtZY5wc+Tg4NXdlBChbT/
         YF49GKvgQJGAVFeWLRkVxuMDHFQvUciX7apcj/j6mzD65LXaqLEsQCpGfMbSk/EFLpa/
         sOPLxDRn7RZcRZbwgxUa2auHddYJ0JE0BD1lkQnXpB8JDUuuBxtkw9H9Qclmc/jsR8EG
         dtXnJPqOUrFp/K4cBsfIaEmvLzAKZRvXI9oXdTWF/+xEFAKA4tSiOGgL+7CPslMfn3us
         QCnmdIaV+3hodioaiyuyyRJErYPo+wAkl89ax7QbAJdOP/B7yLKz53KitcoNDuj/qFRg
         6Nmw==
X-Forwarded-Encrypted: i=1; AJvYcCUejkJnOcgS3h20OwkRKX3KjZpn4LfL8tvJYKNlnrv/+GlJLMy+PTJjOg+/lKildFvzZ8YYIoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25BN3NP9lwhirjfw+PAawaCapQH2SXKT6pN5JgJ6Jii4RvJVW
	fd4ePNjis6AewQwIXRbZd4AiMJxiNw+JwYaVkGzG/0r7hjuVKkMy1nd090ZKd/QXzBLUTflh9Ic
	npJ5BQKx87QrvegGFa6kW845Bwd388jI=
X-Gm-Gg: ASbGncuk4rZTvsbIYcpcWqfUHOrWPn2mS8wiRCWtkYr5LxtErbZaJCafp2zjrLHsVTb
	UuF+2m/wDi0ymbOZcwBKIoqVXNjOu0hqV5VUthNMs1JcltxQIZT2+SGG5DMw2UuSCaBiOiAz3tD
	ZiFGhmc55i63LLugZ36hWNx77uEkZlzB0L1uzcMamgCksm9issJ3GwKyhnC++Kg4GQaes6ivAdy
	ZIdvZIiBjMOYcAMeqfeABqfexymfhc4wcuFCu0hENo4ozsAf2Jt
X-Google-Smtp-Source: AGHT+IHbu1GM2aDcBiqmQoDs8+SoFkL8t2HF1enBCIjOCS29d6T2ouFBevmexYyoaIdhDi6zdfit7i+cqR5nm8vF60g=
X-Received: by 2002:a17:90b:4984:b0:32b:94a2:b0c4 with SMTP id
 98e67ed59e1d1-339edac69f1mr36300886a91.16.1760400642466; Mon, 13 Oct 2025
 17:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-3-ameryhung@gmail.com>
In-Reply-To: <20251010174953.2884682-3-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 17:10:26 -0700
X-Gm-Features: AS18NWAseG-_S7Q3MH24JafLagyXqAj7vn3v4db_S9XBFH0PhSieYJiEz4HGwPI
Message-ID: <CAEf4BzZgc3tqzDER5HN1Jz7JL7nN3K6MiFGTrouE69Pm-Vo+8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 2/4] bpf: Support associating BPF program
 with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> Add a new BPF command BPF_STRUCT_OPS_ASSOCIATE_PROG to allow associating
> a BPF program with a struct_ops. This command takes a file descriptor of
> a struct_ops map and a BPF program and set prog->aux->st_ops_assoc to
> the kdata of the struct_ops map.
>
> The command does not accept a struct_ops program or a non-struct_ops
> map. Programs of a struct_ops map is automatically associated with the
> map during map update. If a program is shared between two struct_ops
> maps, the first one will be the map associated with the program. The
> associated struct_ops map, once set cannot be changed later. This
> restriction may be lifted in the future if there is a use case.
>
> Each associated programs except struct_ops programs of the map will take
> a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
> is always valid. However, it is not guaranteed whether the map members
> are fully updated nor is it attached or not. For example, a BPF program
> can be associated with a struct_ops map before map_update. The
> struct_ops implementer will be responsible for maintaining and checking
> the state of the associated struct_ops map before accessing it.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  include/linux/bpf.h            | 11 ++++++++++
>  include/uapi/linux/bpf.h       | 16 ++++++++++++++
>  kernel/bpf/bpf_struct_ops.c    | 32 ++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  6 ++++++
>  kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 16 ++++++++++++++
>  6 files changed, 119 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a98c83346134..d5052745ffc6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
>                 struct rcu_head rcu;
>         };
>         struct bpf_stream stream[2];
> +       struct mutex st_ops_assoc_mutex;

do we need a mutex at all? cmpxchg() should work just fine. We'll also
potentially need to access st_ops_assoc from kprobes/fentry anyways,
and we can't just take mutex there

> +       void *st_ops_assoc;
>  };
>
>  struct bpf_prog {

[...]

>
> @@ -1890,6 +1901,11 @@ union bpf_attr {
>                 __u32           prog_fd;
>         } prog_stream_read;
>
> +       struct {
> +               __u32           map_fd;
> +               __u32           prog_fd;

let's add flags, we normally have some sort of flags for commands for
extensibility

> +       } struct_ops_assoc_prog;
> +
>  } __attribute__((aligned(8)));
>
>  /* The description below is an attempt at providing documentation to eBP=
F
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index a41e6730edcf..e57428e1653b 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_s=
truct_ops_map *st_map)
>         for (i =3D 0; i < st_map->funcs_cnt; i++) {
>                 if (!st_map->links[i])
>                         break;
> +               bpf_struct_ops_disassoc_prog(st_map->links[i]->prog);
>                 bpf_link_put(st_map->links[i]);
>                 st_map->links[i] =3D NULL;
>         }
> @@ -801,6 +802,11 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>                         goto reset_unlock;
>                 }
>
> +               /* Don't stop a program from being reused. prog->aux->st_=
ops_assoc

nit: comment style, we are converging onto /* on separate line

> +                * will point to the first struct_ops kdata.
> +                */
> +               bpf_struct_ops_assoc_prog(&st_map->map, prog);

ignoring error? we should do something better here... poisoning this
association altogether if program is used in multiple struct_ops seems
like the only thing we can reasonable do, no?

> +
>                 link =3D kzalloc(sizeof(*link), GFP_USER);
>                 if (!link) {
>                         bpf_prog_put(prog);

[...]

>
> +#define BPF_STRUCT_OPS_ASSOCIATE_PROG_LAST_FIELD struct_ops_assoc_prog.p=
rog_fd
> +

looking at libbpf side, it's quite a mouthful to write out
bpf_struct_ops_associate_prog()... maybe let's shorten this to
BPF_STRUCT_OPS_ASSOC or BPF_ASSOC_STRUCT_OPS (with the idea that we
associate struct_ops with a program). The latter is actually a bit
more preferable, because then we can have a meaningful high-level
bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map
*map), where map has to be struct_ops. Having bpf_map__assoc_prog() is
a bit too generic, as this works only for struct_ops maps.

It's all not major, but I think that lends for a bit better naming and
more logical usage throughout.

> +static int struct_ops_assoc_prog(union bpf_attr *attr)
> +{
> +       struct bpf_prog *prog;
> +       struct bpf_map *map;
> +       int ret;
> +
> +       if (CHECK_ATTR(BPF_STRUCT_OPS_ASSOCIATE_PROG))
> +               return -EINVAL;
> +
> +       prog =3D bpf_prog_get(attr->struct_ops_assoc_prog.prog_fd);
> +       if (IS_ERR(prog))
> +               return PTR_ERR(prog);
> +
> +       map =3D bpf_map_get(attr->struct_ops_assoc_prog.map_fd);
> +       if (IS_ERR(map)) {
> +               ret =3D PTR_ERR(map);
> +               goto out;
> +       }
> +
> +       if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS ||
> +           prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {

you can check prog->type earlier, before getting map itself

> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D bpf_struct_ops_assoc_prog(map, prog);
> +out:
> +       if (ret && !IS_ERR(map))

nit: purely stylistic preference, but I'd rather have a clear
error-only clean up path, and success with explicit return 0, instead
of checking ret or IS_ERR(map)

    ...

    /* goto to put_{map,prog}, depending on how far we've got */

    err =3D bpf_struct_ops_assoc_prog(map, prog);
    if (err)
        goto put_map;

    return 0;

put_map:
    bpf_map_put(map);
put_prog:
    bpf_prog_put(prog);
    return err;


> +               bpf_map_put(map);
> +       bpf_prog_put(prog);
> +       return ret;
> +}
> +

[...]

