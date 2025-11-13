Return-Path: <netdev+bounces-238489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0BC5998B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 853A04EAECC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3131814A;
	Thu, 13 Nov 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+QQjDeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DE2E0406
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060347; cv=none; b=eGfRgvvwHmAH0djRo8U13bl41aCA0N2PFWLJHuODvj8JtuBcS4oepWfUztjRBheuMoPyg6LFm0CgEmq/8AWZGli+SJxR0zUuVp9FBf3KtAhS460jYn+Dfcwjpt2SE6ZckFHo13Ln9q7Wuz6o730hgQxdLVZf0F0HTSJIdaHF7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060347; c=relaxed/simple;
	bh=d1u1H2ZRU0IOG/4fnAH17I7UPen6WkIeSIzyTu38lHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5TiCjUjcmfqhYAiSIFsBSfdzTXB/Y6ArZhr1enY39qhWRU17DvKImi6pfDsnJLmg8cGqAC5ybZcPtJA09kmvpI3ZW8FlPxj9P+gO0d/yoilzUUj/x8+8tUFnJWsqERxxgYAk6+QntwHkRshgbL7XL1KOKwpnmUwNpp4mRq9XVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+QQjDeD; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-640c857ce02so1115346d50.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763060343; x=1763665143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+PqzGsvaBbEVuwQLOu7NOnLSs/K4dFo0izdUCpkZ8U=;
        b=E+QQjDeD8K5nZ7hEN7IVbUUb/m8LzmyyxbfVj0DYPio1OmCpq0mGqS0yO4+o5tfUn9
         hoj+/kmy0Zm4csMf7r17B8KfZRH6ZhVx+GuQ3X049Lzs2ehV+aSQ1i42tbaWJ78FBsZy
         kWmWz35Zd0fEwSRGpFuFwhIB+TRlRK4S9h2XJMNB2Wi7uB3Qs8oe4yYvxlKjw84d51H0
         pmiXRdRSMMLYVKeKNZ8vgL/7cOuPFU3WS2DurL+lZqjAmEEK7jY8lrriRLTF8fdmOPE+
         qy2eGM+PB5lQjnKesO3WMF+tAazs+ILV/KCxDL4pyR0vdhgM9q9TEuAQxY1yD2fhCsHg
         580A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060343; x=1763665143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b+PqzGsvaBbEVuwQLOu7NOnLSs/K4dFo0izdUCpkZ8U=;
        b=ID4dUnaqccXOfr//CJY3gBlz6vYN9DbFzzV6uxHEEXunMZsT9C+bjKXGDhpJ9NNW5z
         3FlG3jLly5VMc3lhfIc5tVqMHqU07Ya1o2FAtNWBuK98DEiB69egWp+ZwW88kkupi5Av
         bjuhqqTIRItYYGwcpCOB+UdIHtD2fk9zmQBJZq9bcT6+bhQL8hehKJ+kXE0zvOjI74Lc
         YWcIPl1Kk8PsE9fIYFliQf7hliywHuRo5OpYByhCUL5mIlLJ2YmJHvwsyKUwwVyRR5Dx
         TU0L47U7cqJY7a8RLDkyTES13bm5OhNKiGve+mXZAqIzCMIGq0y/yLQ+pf/o63NJHYSk
         qrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0XL4Q6IE7Lh68XEaxBStIinysSbzyJGfrGtlHY+0qVWk1D52rNrHBwcl4aRMUYp6ZH0poo/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjfHZTshbHSiUX3xYE++lY3EUpvzoI8kbdruJokkA7OGCjhEgK
	5XLVjztfEzm/6nRWqEZrpvT/qsNR5FD0DN1UHvLRN7TfA89qb3hmWFTfvLO6cSs1eJjPEHcRjMI
	dMdICRrotv2W1O3ipjAIP4mIPOLOu3O8=
X-Gm-Gg: ASbGncufaIRO1BhjZhnq0RCGH/mfiitD6xohw/pFM0qkXRO7Exk57qjOW0ma8vmm4jv
	Us8rxJ9lfoP3Erp7KsB4aVgv1ikh8aI/dpSBMa0rP7GEVda6LsR+fel4+raREONZ13PxWaX/5Kq
	gwbMPlLqTXiYhH7lRMFFn3/4K1X2GinkzyCcKk2cUu9L9m/J1kAEugWjruJXNb9fKr2sLQRUWjV
	Q9O3IxYRPxkcI9cBgAC/K/Ars7p3fX/efk5PLMiLsVmOasQ1tZUqrI+5PO0peB2oWHaCKF85RHo
X-Google-Smtp-Source: AGHT+IEXQzo33dyZnCkOfn9zRECc/mLPfHXcqe0IhYY8U0QN71UCSdhRKuo0/0MxZjGnYXGTqvTfpdqZUZ3YWilGlYI=
X-Received: by 2002:a05:690e:c45:b0:63c:f5a6:f30f with SMTP id
 956f58d0204a3-641e76b2bb9mr364296d50.57.1763060342994; Thu, 13 Nov 2025
 10:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112175939.2365295-1-ameryhung@gmail.com> <20251112175939.2365295-3-ameryhung@gmail.com>
 <CAADnVQ+2OXNo99B2krjwOb5XeFhi6GUagotcyf36xvLDoHqmjw@mail.gmail.com>
 <CAMB2axM0-NF5F=O6Lq1WPbb8PJtdZrQaOTFKWApWEhfT7MD4hw@mail.gmail.com>
 <CAADnVQKWKC3oh6ycxE+tstYupwVsdbhYHOncnfTOFWLL2DmJjw@mail.gmail.com>
 <CAMB2axOEauSyi13-acjDJUB--8+V7ZUG+r2V=fATwZHDQjFH4w@mail.gmail.com> <CAADnVQL1aocxXXsrdy1RAPf+LGX_jVKe8sVXmC9cWCktUzS+aQ@mail.gmail.com>
In-Reply-To: <CAADnVQL1aocxXXsrdy1RAPf+LGX_jVKe8sVXmC9cWCktUzS+aQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 13 Nov 2025 10:58:49 -0800
X-Gm-Features: AWmQ_bmd4hCjP_bcUU1UoKkHhwWqMzT6jyzjpRLFnN19VFBV5QWwj94-F5jQ3kw
Message-ID: <CAMB2axN8AajFkQUKpUwT6PrdHEa+CKUECBWC1dUQ=_67VBb4Eg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local
 storage unconditionally
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 12, 2025 at 1:15=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Nov 12, 2025 at 12:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 12, 2025 at 11:51=E2=80=AFAM Amery Hung <ameryhung@gmail.=
com> wrote:
> > > >
> > > > On Wed, Nov 12, 2025 at 11:35=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Nov 12, 2025 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gma=
il.com> wrote:
> > > > > >
> > > > > > @@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_ma=
p *smap, void *owner,
> > > > > >         if (mem_charge(smap, owner, smap->elem_size))
> > > > > >                 return NULL;
> > > > > >
> > > > > > -       if (smap->bpf_ma) {
> > > > > > -               selem =3D bpf_mem_cache_alloc_flags(&smap->sele=
m_ma, gfp_flags);
> > > > > > -               if (selem)
> > > > > > -                       /* Keep the original bpf_map_kzalloc be=
havior
> > > > > > -                        * before started using the bpf_mem_cac=
he_alloc.
> > > > > > -                        *
> > > > > > -                        * No need to use zero_map_value. The b=
pf_selem_free()
> > > > > > -                        * only does bpf_mem_cache_free when th=
ere is
> > > > > > -                        * no other bpf prog is using the selem=
.
> > > > > > -                        */
> > > > > > -                       memset(SDATA(selem)->data, 0, smap->map=
.value_size);
> > > > > > -       } else {
> > > > > > -               selem =3D bpf_map_kzalloc(&smap->map, smap->ele=
m_size,
> > > > > > -                                       gfp_flags | __GFP_NOWAR=
N);
> > > > > > -       }
> > > > > > +       selem =3D bpf_map_kmalloc_nolock(&smap->map, smap->elem=
_size, gfp_flags, NUMA_NO_NODE);
> > > > >
> > > > >
> > > > > Pls enable CONFIG_DEBUG_VM=3Dy then you'll see that the above tri=
ggers:
> > > > > void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int nod=
e)
> > > > > {
> > > > >         gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp=
_flags;
> > > > > ...
> > > > >         VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO =
|
> > > > >                                       __GFP_NO_OBJ_EXT));
> > > > >
> > > > > and benchmarking numbers have to be redone, since with
> > > > > unsupported gfp flags kmalloc_nolock() is likely doing something =
wrong.
> > > >
> > > > I see. Thanks for pointing it out. Currently the verifier determine=
s
> > > > the flag and rewrites the program based on if the caller of
> > > > storage_get helpers is sleepable. I will remove it and redo the
> > > > benchmark.
> > >
> > > yes. that part of the verifier can be removed too.
> > > First I would redo the benchmark numbers with s/gfp_flags/0 in the ab=
ove line.
> >
> > Here are the new numbers after setting gfp_flags =3D __GFP_ZERO and
> > removing memset(0). BTW, the test is done on a physical machine. The
> > numbers for sk local storage can change =C2=B11-2. I will try to increa=
se
> > the test iteration or kill other unnecessary things running on the
> > machine to see if the number fluctuates less.
>
> fyi gfp_zero is pretty much the same memset().
> Shouldn't be any difference between __GFP_ZERO vs manual memset() after a=
lloc.
>
> > Socket local storage
> > memory alloc     batch  creation speed              creation speed diff
> > ---------------  ----   ------------------                         ----
> > kzalloc           16    104.217 =C2=B1 0.974k/s  4.15 kmallocs/create
> > (before)          32    104.355 =C2=B1 0.606k/s  4.13 kmallocs/create
> >                   64    103.611 =C2=B1 0.707k/s  4.15 kmallocs/create
> >
> > kmalloc_nolock    16    100.402 =C2=B1 1.282k/s  1.11 kmallocs/create  =
-3.7%
> > (after)           32    101.592 =C2=B1 0.861k/s  1.07 kmallocs/create  =
-2.6%
> >                   64     98.995 =C2=B1 0.868k/s  1.07 kmallocs/create  =
-4.6%
>
> could you perf record/report both to see where the difference comes from?
> The only reason I could explain the difference is that kfree_nolock()
> is hitting defer_free() case, but that shouldn't happen
> in this microbenchmark. But if you see free_deferred_objects()
> in perf report that would explain it.

Updated numbers and next step:

A new perf result shows ~10% creation speed decrease (130k/s vs
142k/s) for socket local storage after stopping a service that is also
creating it for every connection.

The performance hit did come from defer_free() and the loss of
batching with kfree_rcu().

Hence, kmalloc_nolock() is not ready in this case to replace
kzalloc(). The next respin will only replace BPF memory allocator in
local storage with kmalloc_nolock().

