Return-Path: <netdev+bounces-235638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD559C33624
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C68188CA1D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5652DF146;
	Tue,  4 Nov 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHTwqMHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319582DEA8F
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298882; cv=none; b=Dw+i7IbxHZFhZdMUQhfn1OVgzPGxKsZWUBYfflCZHHJgtlIVySS+ext/CyPT0hCx/fvtAnXO1w7MhsGlgiVrNznLmfeE9wqsPGEOX3He+XuFoNVq5G8NLDTcqV428aHN12BO5CGUlmBJDGFCiSsSQA2BVPLT1uXIhQo9EaLTFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298882; c=relaxed/simple;
	bh=atPyN88/ajTLGB32nE6pH8axtbT3UHg327vdI0JGABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYWIxDOtViKemAkOJ3FtaUbGfDLnBbueS1YfvxZljMTKfEze5p5hg7oCZ5oLqpXtSgfNH/orlwYztDM0CwHTzyCowuFPxeuWg4sr3Bm497bSnCDCE4e1U4353NgWonEJqvgmYF8MgLM+UAhzEPbtYjkZCCtDlkg/sqKIesEzRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHTwqMHX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso746025a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298880; x=1762903680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QqeHGWs/iUZhYOcRfX9mKywPLuJ4IlUyRhWDheThRs=;
        b=fHTwqMHX+eBcotYM31nSbhl/rWIcEbddLZ/+RsO5bCaj3pU9KB043S9uXm6iLbLzGJ
         9b86i6Wm0aEccZ77WNlUupRxuQDMQ1NQuTIAeWYcUXbue6PmlxCTYdE2FhEO3DEWklUk
         EAmQW8MVe+oyApRVMHIq5oPm4rA712AVMycl319rN0FBMT7lI1AQm8CYU6xcYtwZsNTx
         vlBYBP69sY+u96AlHOMfueknuheG+w/c5OpK4bSu8AkN0qiRPIZKPTwX6oRso3NFZZzP
         9ZG81wRrUfb7YNizn9d+2JEjjq7hmx+hLNVclb6oc+J7uug5UPThezb6Cug5GCyfSVPX
         YnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298880; x=1762903680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QqeHGWs/iUZhYOcRfX9mKywPLuJ4IlUyRhWDheThRs=;
        b=jbEtV1aeEtlyEhI+bxWlRWyHavxYoH0FvyWKfgQ0k+RLuByjdr0NTuZ3NR4kE2gyuX
         q9a1C4142lhJNpWDinXjHJnKSSij/6AK/HxDwQXVdvFnsxhdjbIAG73o2yPp574T2NJq
         wuqNTmG7feES8HKQekPNb06dbX7/rwtiiemIRbLqRRficm4mJWmEhDl3zzqXgGkSUEH3
         k8GRCSrx8JOBInHWgGv0aR9mKvZrdcaT0uXAZNQRo+0iObRXZfFXix43dDR7BvpmrHTK
         g27Bkrylq9T/NIz39O9vwj6K0UhJQiW38hg5Pa6kMi4spqiFIByU8XyAqM6BCPl9+yDh
         evPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkLNUrYAsL1o3HasZTjAIfz9iIsKrCWzUWd4NKH6rvkgTup95cZFCkLLT00O3XKD65+qUSbcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjgzzPIzYOVeJgBB+seKYs+PPZmtWGbGikGCiJwc2pgCt0cvX
	lq8GRXMchJwlUcNXlkHbtcIARY6BI774iqwWlruum9QNWiYMdO6VRVXf774/W4/fHvMOGSkpo4P
	nfAQCWdb9IGpMWTT8njLg9jsamsGu7HU=
X-Gm-Gg: ASbGncsl/mzs4XVtbLR95KuzSIQYSeNBkm9Hz4AvWVvJga8WEjE52mEOWAyKGI7r8eE
	J9xhPl2ajgBKMl/fAyfWH2ov7ZxlYN5X0v5s+jEj0tQOy+ed7sRD/1aDcBUKRYTF3h9U/mmfTgn
	6weez03v4L5COdovCV527fYdE0bPNU/SBWCW5YjUa+NIuzWaYO4GA0MSMVrmOZxqhu/PsGJxpwE
	Q6Yqv6f/9HsENDtHbbZeNah0FjWS/dG64eYbCUCxhMN/PlL8Lzj5qyOgGUg1s54l3P9/HjHUYGK
X-Google-Smtp-Source: AGHT+IGIinC5SPZ8Y05+eawvnOyy91jheBh28gyMVfLcElCVFVOyg5VqQRTKob5dilZqurjSBWNpDREsev6I88b5AhA=
X-Received: by 2002:a17:90a:d406:b0:340:b572:3b7f with SMTP id
 98e67ed59e1d1-341a6dcb832mr1431449a91.20.1762298880467; Tue, 04 Nov 2025
 15:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-5-ameryhung@gmail.com> <b4c70f2af7001ee36b8d3702f280ca11e3ba281ba29cdcb63434ee28e0a8060a@mail.kernel.org>
In-Reply-To: <b4c70f2af7001ee36b8d3702f280ca11e3ba281ba29cdcb63434ee28e0a8060a@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 15:27:46 -0800
X-Gm-Features: AWmQ_bkR1D_jg0XXWVAT_-ZRikcJygUG9HBMwXYeTV7IxYJq78TCWRkF5tvMZrs
Message-ID: <CAEf4Bza6gVd84ANwTyKZq8jnSBvALTppZUaZC802SKr5pO5QbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF
 program with struct_ops
To: bot+bpf-ci@kernel.org
Cc: ameryhung@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fbe74686c..260e1feaa 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_=
program *prog,
> >       return 0;
> >  }
> >
> > +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf=
_map *map,
> > +                               struct bpf_prog_assoc_struct_ops_opts *=
opts)
> > +{
> > +     int prog_fd;
> > +
> > +     prog_fd =3D bpf_program__fd(prog);
> > +     if (prog_fd < 0) {
> > +             pr_warn("prog '%s': can't associate BPF program without F=
D (was it loaded?)\n",
> > +                     prog->name);
>                      ^^^^^^^^^^
>
> Can prog be NULL here? If bpf_program__fd() returns -EINVAL because prog

libbpf APIs generally do not tolerate passing NULL for bpf_program or
bpf_map pointers. This is fine, this shouldn't happen with valid usage
of an API (and we don't guard against this).

> was NULL, this dereferences prog->name without a NULL check. Looking at
> bpf_program__set_attach_target() just above, it checks "if (!prog)"
> before any dereferences.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
>            ^^^^^^^^^^
>
> Same issue - prog->type is dereferenced without verifying prog is not
> NULL.
>
> > +             pr_warn("prog '%s': can't associate struct_ops program\n"=
, prog->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (map->fd < 0) {
>            ^^^^^^
>
> Can map be NULL? There's no NULL check before dereferencing map->fd.
> Other map APIs like bpf_map__fd() and bpf_map__name() check for NULL
> before use.
>
> > +             pr_warn("map '%s': can't associate BPF map without FD (wa=
s it created?)\n", map->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!bpf_map__is_struct_ops(map)) {
> > +             pr_warn("map '%s': can't associate non-struct_ops map\n",=
 map->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> > +}
> > +
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

