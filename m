Return-Path: <netdev+bounces-236485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4BC3CF93
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CA934E155A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEF34D4CD;
	Thu,  6 Nov 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEyFYQQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5D347BBE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451867; cv=none; b=bklJZRGTWK8coI31AEG7FlQwQPHRO5Dq+WQxv2u1DeR1zBNnT9PO/KJbPi5xYn1D/k5tFNWNebbghNhnfMZzrwtM6zdBb9ebKRMCegpHOuGt6n/SpfcVSl9q24k+L/ZNxEAuAj1yHue5sy/Q4w+4usCuUS92TdKsYQs6+24wjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451867; c=relaxed/simple;
	bh=270dd+ce0HM/mnehwKbtl2KQehJ1X4zco4/uV6CxTd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeKdTK6noxjqfTIJ2l3LRi5tth/Hs5S+GgypvL/mNf7QNScyDyAeA90QOeDG1OjV9Y9JEWcBQsUEm/VDCun9M+gRwKBrBpIYZ6Oo2+ND29S9YAfoCFW86bcRKh3GFbVNaQzp+uvY3QHslp9nuGVo+XV5sTfIxsWKTLBaZ1Y5Xco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEyFYQQB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7866aca9e25so11567177b3.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762451865; x=1763056665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oIlWmrebBL+pksnC7en0DKHM2NlJESnFW4gbQhLyfg=;
        b=IEyFYQQBH2hWWlDVa8iM53VOT5otm1fXmyQ8X7Jqd37Dx/42bARPuJoi8StJRmSPz+
         6zLKoh+/HDAIu1zetsf0Xh44JSMpqaR3UMt5T3xSp+vceYYwTUsCL7OcPIdBpoxX/Uv/
         aRAKTvUyGvN1H/ptb47/zHoHowofJQi/mcAX5Wu+tlIOX3B+JBMAxKbFxRbXBZ5xCF9D
         Fk8kTpoT70g3BO7mnqfv9tKsnGhSZWj9+rOd1XiZKS01igM0yKfO4u7qx99q3Su7kAtw
         970u8vihIHyXa/P8M87S/P477Y+MotAXnOSJLp0j9hAmj04U/IuZUNg8zDPljnALmi2o
         DUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762451865; x=1763056665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8oIlWmrebBL+pksnC7en0DKHM2NlJESnFW4gbQhLyfg=;
        b=cvu3RnxrlErJpZwhC+7HJXPmXMgjMe70b9kurijFH2fTL1Qd3gH0w6WOSAAKaCX8as
         RFtxlIJ2r9oMbFwLobSlZIRAEeCEJRcKv9mz80NY0ue614uglFD0pEIgIc78lYXIftT0
         X1C4gLUf+suonmu743H1WGb1RKQYGwwm7plgv/MPBflY6ORmHTGBkDj+JSSsu86+E6aR
         dEgs6NvrElnzlxoHCWIsPac/tGfBRjYv/MDvQwvIYsDE/9V1zVhhSwYYynvBSgHIj6Hs
         EudHRrsEd7DJFgpa4gXtGK9mCCiOQKprEP+4glz05zW0cfFf7GDock9Mvvfe0ojGfdla
         ix5w==
X-Gm-Message-State: AOJu0Yyor0k3hBwNxOmFVZeHQR/kKlfgDUZpqIRXgdz52AiuoWg6IFoe
	xw+nr709Skee+fOPdB7TKQlmlfc0KHz/D4yRkqu83i5QsQmpOZI1GlASUFSGx2jqVdrJw+wcvgV
	zMYjKsbkhuqCb1puQzt4TqLjvvyhzrUw2n1Ea
X-Gm-Gg: ASbGncs+PzY6oqq6foGE4XKvgb5zVg4IN+ofs756MupqEdjQ4IprUIJ/wK0yaCluvIV
	Pv8omxqX4pKYHkyBELzNYe9//8i2YsAILesxks1sOl9CZYv9FsIuLbpENAs666pkfD7M5STimih
	+Y+PfbvktsNKQG/N97bInXq3jsCp1k2A/11+48b2xkMNZ9wTH+vY92MhilmR9SyI2fjNMc+064c
	95YWo5t1OyuT7Dioo+7mVs9JDi8VOAHr/+04GqFD+i1A7LwnK5G8atzoq5KbWJMb598tyYW7Uy9
	mH0KAUQGLu8=
X-Google-Smtp-Source: AGHT+IFGFppB+s7NJSj/RpzHJh6UYLUGVcKwMtlRmtppO9WoglW4SeUFJ9mnPzBjMb7tWwzW7pIHTFqslJvyjPa7yoA=
X-Received: by 2002:a05:690c:4444:b0:786:896d:8825 with SMTP id
 00721157ae682-787c53fcc84mr984317b3.49.1762451864692; Thu, 06 Nov 2025
 09:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-4-ameryhung@gmail.com>
 <0a3c4937-e4fd-49b6-a48c-88a4aa83e8a1@linux.dev>
In-Reply-To: <0a3c4937-e4fd-49b6-a48c-88a4aa83e8a1@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Nov 2025 09:57:31 -0800
X-Gm-Features: AWmQ_bn9NUocY0TqNGMbHeVxMFmp_heKpPewj94SjLJ0qX0L02FSoEQ0yh2aW38
Message-ID: <CAMB2axPayfZOZnGK83eWxYTg9k0uno_y87_0ePE_FD6V+4tnfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:13=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 11/4/25 9:26 AM, Amery Hung wrote:
> > Take a refcount of the associated struct_ops map to prevent the map fro=
m
> > being freed when an async callback scheduled from a struct_ops program
> > runs.
> >
> > Since struct_ops programs do not take refcounts on the struct_ops map,
> > it is possible for a struct_ops map to be freed when an async callback
> > scheduled from it runs. To prevent this, take a refcount on prog->aux->
> > st_ops_assoc and save it in a newly created struct bpf_async_res for
> > every async mechanism. The reference needs to be preserved in
> > bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
> > and reference leak could happen.
> >
> > bpf_async_res will contain a async callback's BPF program and resources
> > related to the BPF program. The resources will be acquired when
> > registering a callback and released when cancelled or when the map
> > associated with the callback is freed.
> >
> > Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
> > what it now does.
> >
>
> [ ... ]
>
> > +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_pro=
g *prog)
> > +{
> > +     struct bpf_map *st_ops_assoc =3D NULL;
> > +     int err;
> > +
> > +     prog =3D bpf_prog_inc_not_zero(prog);
> > +     if (IS_ERR(prog))
> > +             return PTR_ERR(prog);
> > +
> > +     st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> > +             st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
>
> The READ_ONCE and inc_not_zero is an unusual combo. Should it be
> rcu_dereference and prog->aux->st_ops_assoc should be "__rcu" tagged?
>

Understood the underlying struct_ops map is protected by RCU, but
prog->aux->st_ops_assoc is not protected by RCU and can change
anytime.

> If prog->aux->st_ops_assoc is protected by rcu, can the user (kfunc?)
> uses the prog->aux->st_ops_assoc depending on the rcu grace period alone
> without bpf_map_inc_not_zero? Does it matter if prog->aux->st_ops_assoc
> is changed? but this patch does not seem to consider the changing case al=
so.
>

I think bumping refcount makes bpf_prog_get_assoc_struct_ops() easier
to use: Users do not need to worry about the lifetime of the return
kdata, RCU, and the execution context.

The main problem is that async callbacks are not running in RCU
read-side critical section, so it will require callers of
bpf_prog_get_assoc_struct_ops() to do rcu_read_lock{_trace}().

The change of st_ops_assoc indeed is missed here. st_ops_assoc can
change from NULL to a valid kdata. Will fix this in the next respin.

