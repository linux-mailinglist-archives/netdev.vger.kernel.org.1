Return-Path: <netdev+bounces-235640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0016C33687
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0CA54EC6F0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE2347FFF;
	Tue,  4 Nov 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrH8gtMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7929347FFC
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299603; cv=none; b=c5Y7yItro1n4JSoTHcWf9frAdFoouLktGVzUcWh4GAHmV50/pJcm7scm52Me/mA44AT7cZPBZ827U84R+EA9bTBBKlkrURz294PkaRWeOj4PanfrOvKmnEeKpCfrDX8xRlbKAfNQ7gag5LWJWvhwZKe784rBoYKFLaoU8k2zjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299603; c=relaxed/simple;
	bh=tjQXnZZyLLt51hj7tPir70XOl+Ex2Ui9Pv9WGUHMj/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nx+4rbyZecVLtpMoMIlnaZAKDXWJsNoixPrYtMw+k6YAGhk8GFZmZ1GXAaJiuPhA1YgUQJcVvo5WhYlY4IoO2jrA726XWink19zM6qhB/PomFpqcrB4ZFKh6ccR0ASmcFaFEwfePYVTDHKVqyen7Fz/bnCl0DO7a3LES7dreUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrH8gtMn; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso5824967d50.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 15:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762299599; x=1762904399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8iFlyp5kWRCbLD+Ju9OP8zPc8dcgT7lVrrRfNWbPuc=;
        b=QrH8gtMn7dl0Wvw1XnbKl1kFgoanaajVWuQXi8KVLc2qWtAssGhCosekocNUOZ+Djf
         A/9/jMYmqc95nGDPlJjyxzQV3fuiZbsxNqGrFekQ0PCkI6FXYbWTdqDal2aWX/Iuih1n
         mpXxeRgaVBO3t9+OFh2IN1Ju7EKc+dLiwHw1GUknjJq4oJlmqMWItIL71JHTw8t8Cf/L
         UyUG2KNDY9M7pd4DsaLDWD7xctp9m0+u7DM5fxhKbx/nO+ZVBEqZKBgKessgI7Qvmvk3
         ufARvmjvQBIzuEZtUGIEq2WKmd+UUzvT1sEtVHDARsTWEWxTE91Txp9Vqrj+mwL1EkGp
         XcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299599; x=1762904399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8iFlyp5kWRCbLD+Ju9OP8zPc8dcgT7lVrrRfNWbPuc=;
        b=p27W5OCYlsa0JnHNh88G5a8O5Devc5d1nfMITfGVId9Ay3TUSB1JCiGL73XWPxZo44
         5iauM28G0p+mXV8gZ+f1MB+XfpZ8NDmu9lYMaMNCvLXN/zXs5yLhZtup7qwPOhDYTrUW
         IpRWtklv24yZFzVr0348/KRVCgUKyPXgBY4+N4W4q2YXvSAPpFErWzgM9epJ280DfF5y
         8XhGRlRUvAOz0a8yoii9HaY+hobbnZmfMIMUGhrQ56sI26XIYo7IkyAx84CKHfZ3DzIq
         ho3BOe44LGFJZdC1jU0R9hlXclqskyp9iummR7daUd3sVE5qi8tdTLpWP3Ta0qrhKEtn
         ZG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4EtAxCYjE7msu886UlqBsPqYg1kimdhpew+NZVPq91CRC6ItobzH+3GGSA5jteAXoX8oj43M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFyCqIcQfd5nNJ7QumESANnvLlurpqiaMRNHezMO+76Hm2fkX
	NN4y+KKnO11Pmns+8foyY3uNxdqYXD0mR90K/9WFMEcMMDhIqx8Dm40deA+9Moffe1WxutSPlDg
	BTVa48kM/4P9qTlshAUA4ilNgrpewswg=
X-Gm-Gg: ASbGnctc6NRgrC3e2N1xWk9ETldUYZCHsoj2FFwHN6UaEt71dbrpFtjvgUUvrja/29Z
	xh9cgqDcnFwXrqKhlCOhPrHGoAUhNDRpKvxAqQL8TAzlbGNp7AlXK/6bEN659eiS6/8WOweXkgA
	ZXh1SUl3uQvNBM2VPokC9B7qzI6qWKziPr0hEIV86fqxeToLnrgX8kxre9fv0WVlj/OBitSDy7C
	HOZ7eraby6IqWPkTavDgYimu481mr4bVfAsNUlI4yZogkKZp9hA+44KOZgOdPbxBgKwM0i39x9S
X-Google-Smtp-Source: AGHT+IERdrmAXsM1vCb2GfO+Gg5CSH1XIWbLyk1bfKdic+MpPR9V6JpeoPd+FvpKuGVhzwXKJgLtp4yGAwLH+naz4bk=
X-Received: by 2002:a05:690e:2596:b0:63f:2bc7:7074 with SMTP id
 956f58d0204a3-63fd35b90a3mr838935d50.60.1762299598865; Tue, 04 Nov 2025
 15:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-5-ameryhung@gmail.com>
 <CAEf4BzbqEsZbO4AjKn7iRQCzKVSD0db9WdG7uKXMCA_4ueFYig@mail.gmail.com>
In-Reply-To: <CAEf4BzbqEsZbO4AjKn7iRQCzKVSD0db9WdG7uKXMCA_4ueFYig@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 15:39:45 -0800
X-Gm-Features: AWmQ_bkEWtH8YUxr3pXS9lAmGhmtQquYoFjCbVl9sa1BSEdb-PfMadkk_YqW90s
Message-ID: <CAMB2axNi1SRT5=SuRZJayt+az6GM63w++T6stwHEHXHfdMce_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF
 program with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> > command in the bpf() syscall.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
> >  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
> >  tools/lib/bpf/libbpf.map |  2 ++
> >  5 files changed, 88 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index b66f5fbfbbb2..21b57a629916 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stre=
am_id, void *buf, __u32 buf_len,
> >         err =3D sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
> >         return libbpf_err_errno(err);
> >  }
> > +
> > +int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> > +                             struct bpf_prog_assoc_struct_ops_opts *op=
ts)
> > +{
> > +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_assoc=
_struct_ops);
> > +       union bpf_attr attr;
> > +       int err;
> > +
> > +       if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
> > +               return libbpf_err(-EINVAL);
> > +
> > +       memset(&attr, 0, attr_sz);
> > +       attr.prog_assoc_struct_ops.map_fd =3D map_fd;
> > +       attr.prog_assoc_struct_ops.prog_fd =3D prog_fd;
> > +       attr.prog_assoc_struct_ops.flags =3D OPTS_GET(opts, flags, 0);
> > +
> > +       err =3D sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
> > +       return libbpf_err_errno(err);
> > +}
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index e983a3e40d61..1f9c28d27795 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
> >  LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void=
 *buf, __u32 buf_len,
> >                                     struct bpf_prog_stream_read_opts *o=
pts);
> >
> > +struct bpf_prog_assoc_struct_ops_opts {
> > +       size_t sz;
> > +       __u32 flags;
> > +       size_t :0;
> > +};
> > +#define bpf_prog_assoc_struct_ops_opts__last_field flags
> > +
> > +/**
> > + * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with =
a
> > + * struct_ops map.
> > + *
> > + * @param prog_fd FD for the BPF program
> > + * @param map_fd FD for the struct_ops map to be associated with the B=
PF program
> > + * @param opts optional options, can be NULL
> > + *
> > + * @return 0 on success; negative error code, otherwise (errno is also=
 set to
> > + * the error code)
> > + */
> > +LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> > +                                        struct bpf_prog_assoc_struct_o=
ps_opts *opts);
> > +
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> >  #endif
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fbe74686c97d..260e1feaa665 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_=
program *prog,
> >         return 0;
> >  }
> >
> > +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf=
_map *map,
> > +                                 struct bpf_prog_assoc_struct_ops_opts=
 *opts)
> > +{
> > +       int prog_fd;
> > +
> > +       prog_fd =3D bpf_program__fd(prog);
> > +       if (prog_fd < 0) {
> > +               pr_warn("prog '%s': can't associate BPF program without=
 FD (was it loaded?)\n",
> > +                       prog->name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> > +               pr_warn("prog '%s': can't associate struct_ops program\=
n", prog->name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (map->fd < 0) {
>
> heh, this is a bug. we use create_placeholder_fd() to create fixed FDs
> associated with maps, and later we replace them with the real
> underlying BPF map kernel objects. It's all details, but the point is
> that this won't detect map that wasn't created. Use bpf_map__fd()
> instead, it handles that correctly.

I saw quite a few libbpf API doing this check (e.g., bpf_map__pin(),
bpf_link__update_map(), bpf_map__attach_struct_ops()). Should we also
fix them?

>
> > +               pr_warn("map '%s': can't associate BPF map without FD (=
was it created?)\n", map->name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!bpf_map__is_struct_ops(map)) {
> > +               pr_warn("map '%s': can't associate non-struct_ops map\n=
", map->name);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> > +}
> > +
> >  int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
> >  {
> >         int err =3D 0, n, len, start, end =3D -1;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 5118d0a90e24..45720b7c2aaa 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1003,6 +1003,22 @@ LIBBPF_API int
> >  bpf_program__set_attach_target(struct bpf_program *prog, int attach_pr=
og_fd,
> >                                const char *attach_func_name);
> >
> > +struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
> > +
> > +/**
> > + * @brief **bpf_program__assoc_struct_ops()** associates a BPF program=
 with a
> > + * struct_ops map.
> > + *
> > + * @param prog BPF program
> > + * @param map struct_ops map to be associated with the BPF program
> > + * @param opts optional options, can be NULL
> > + *
> > + * @return error code; or 0 if no error occurred.
>
> we normally specify returns like so:
>
> @return 0, on success; negative error code, otherwise
>
> keep it consistent?

Okay. Will change.

BTW. The return comment is copied from bpf_program__set_attach_target().

>
> > + */
> > +LIBBPF_API int
> > +bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map=
 *map,
> > +                             struct bpf_prog_assoc_struct_ops_opts *op=
ts);
> > +
> >  /**
> >   * @brief **bpf_object__find_map_by_name()** returns BPF map of
> >   * the given name, if it exists within the passed BPF object
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 8ed8749907d4..84fb90a016c9 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
> >         global:
> >                 bpf_map__set_exclusive_program;
> >                 bpf_map__exclusive_program;
> > +               bpf_prog_assoc_struct_ops;
> > +               bpf_program__assoc_struct_ops;
> >  } LIBBPF_1.6.0;
> > --
> > 2.47.3
> >

