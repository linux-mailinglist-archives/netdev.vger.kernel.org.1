Return-Path: <netdev+bounces-227646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C509BB4A09
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114563BF018
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3173C26CE26;
	Thu,  2 Oct 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDxYN0Zg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09026CE36
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425151; cv=none; b=XmCBelcbPVRxONd0r+DPep4qagH1AGHNVy6Hb3/uZhINw6OZIZdI+noYwkiMkgqI1s8XeB3/eX+7i/29pslho0mdix5a6DeJXU+rRVOiVYg1VqnOxxyawAbgLW0vfnS/YpOxIvWL2rGjO/5a5ZKDAgGRtllcBwdQ6NPdButVdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425151; c=relaxed/simple;
	bh=Vs3Od78lsWY3eVAuifJD7IXnTuiSOYqocBICozC/gbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roNqA3j756m2mcQKrOG1ZFMS+i+JT8kxZfx1jWWTTa/+LogsQf+81ut3bmfao4c+VLZwhPVGWf3qwECA/EQNwodAVsxUVMmgOYh4/aRgi+9rlgrplgMYvbMg/VGKoqC+5ZhvixCJidf4XAo7DsLAY4zDPPv3nIsio4NrTjHqbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDxYN0Zg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so10390145e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425147; x=1760029947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjVO/8J6cwZWczHY1sJ+Xbg1pNEa0jeZoI5ktypxapw=;
        b=UDxYN0ZgVT+RNK0VZhYbwqpaM1e9lo7G2UOhYbat+0T8zVxVnN/6fdIcZ0etHRsqbg
         lT4NxLa1ffqCawVN8+xvVVNuIjXGW+rSFc30Uk6EGYSgjQDtG0oGwRC8GZj1gzYVK1zx
         YkMQeWE47wYMGChUUW52X6X/TP8coD+O9tqYxhowjybgfo+3PW+qykggIoeeuAW4f/40
         248jvKdPH4Nkkz8aXiPn4AoG95gETJqm7tXOLRKby1pXz+Qviw6kSn4lzpOTazc+RHW2
         FYJ0t+iUHvrQaSt5It27I/1budNADjlB6qYGRFxTUQRw66zCHwgAfpoorxF2/racsHEH
         SHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425147; x=1760029947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjVO/8J6cwZWczHY1sJ+Xbg1pNEa0jeZoI5ktypxapw=;
        b=OPP8nwMJPYfLBQoAb6H0Za/Ib9hute36AUQb+mLVMTnoVOVbBjnZrClUVn2eu0rgDj
         mqDJjXtJcOA7nv/QqcEdClIeRzFlm4mESFiWaM+j1+2l+ekJP2yy5QSu0AO9Az55EZE8
         BDEQq25gy8ERk6boJ3lDPy05Cr7o3FblKHqsxkvBM2ZO4H8C7jcWAR00FFSXzpSVa/Pi
         ylc5C0drRO886V0Y0ehVamLg2nijaW0YjEv7GFLgD1uqbudt/u3s7uXSCNZ/XiIbhrZi
         N4Uaqgx6ZR9McwCP/B8Nc7n6Ora85SqqfHaQKXynAnLUixQnWSO4NNlxcsUsnBgjeUok
         VEHQ==
X-Gm-Message-State: AOJu0YzGrdI23vlngNzYCBO3qkOucjPiQ2IBEw7a7RjL2I1PUsX16/Sy
	oer90lm3HRbMJqp/9h1MqcQJQ8F5SgqaaMvxBJEtLHRVqBb4x9nNNb4zxjyHackRZ3tmaC2sEab
	aW3LFbEycJNpzLyaYqGsAESmacgx19Q0=
X-Gm-Gg: ASbGncugwLbJXPkCSAdbxl34z+KBPPcDUjncbOgVKjUP11acCYGMzxb2mwTfBtWg5Rt
	9yeu4raAgTqR86yv+5fjoJiQZv0kkzjlKXJ2NdZFRTL8KG47URwEus28zvN8D4rmVyLvTd3YRNn
	4EMD8X7nfERsVTIADWGvKHFuNjMqA/fPoK7qG6AH/L3sQm8X2W/WYhLtHUyxkqLljyIxJ2dIw6A
	Gis1lgxkHh3yh5y3sCnSRVfVXa/QIaa3VXOqOGqkbzh9BrMMSoVicZ8Zg==
X-Google-Smtp-Source: AGHT+IFFlAPEENjXsjwK7bYP+KO48yG0A6g+1HtPLd84tk/Vz6QU9fm/nAqB6Q/bimjlcjZtqjdjdWNinzemU/d2SzI=
X-Received: by 2002:a05:600c:8b01:b0:46e:59f8:8546 with SMTP id
 5b1f17b1804b1-46e71140bf4mr224205e9.17.1759425147356; Thu, 02 Oct 2025
 10:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org> <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
 <20251001233304.GB2760@quark>
In-Reply-To: <20251001233304.GB2760@quark>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 10:12:12 -0700
X-Gm-Features: AS18NWDHorhHHJaEuzPLLApApsbU6t0qJWlskRVAJzEXEEmEQhmHrh4_H7WjqmE
Message-ID: <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 4:33=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> > On Mon, Sep 29, 2025 at 12:48=E2=80=AFPM Eric Biggers <ebiggers@kernel.=
org> wrote:
> > >
> > > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c u=
se
> > > it to calculate SHA-1 digests instead of the previous AF_ALG-based co=
de.
> > >
> > > This eliminates the dependency on AF_ALG, specifically the kernel con=
fig
> > > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> > >
> > > Over the years AF_ALG has been very problematic, and it is also not
> > > supported on all kernels.  Escalating to the kernel's privileged
> > > execution context merely to calculate software algorithms, which can =
be
> > > done in userspace instead, is not something that should have ever bee=
n
> > > supported.  Even on kernels that support it, the syscall overhead of
> > > AF_ALG means that it is often slower than userspace code.
> >
> > Help me understand the crusade against AF_ALG.
> > Do you want to deprecate AF_ALG altogether or when it's used for
> > sha-s like sha1 and sha256 ?
>
> Altogether, when possible.  AF_ALG has been (and continues to be)
> incredibly problematic, for both security and maintainability.

Could you provide an example of a security issue with AF_ALG ?
Not challenging the statement. Mainly curious what is going
to understand it better and pass the message.

> > I thought the main advantage of going through the kernel is that
> > the kernel might have an optimized implementation for a specific
> > architecture, while the open coded C version is generic.
> > The cost of syscall and copies in/out is small compared
> > to actual math, especially since compilers might not be smart enough
> > to use single asm insn for rol32() C function.
>
> Not for small amounts of data, since syscalls are expensive these days.
>
> (Aren't BPF programs usually fairly small?)

Depends on the definition of small :)
The largest we have in production is 620kbytes of ELF.
Couple dozens between 100k to 400k.
And a hundred between 5k to 50k.

>
> BTW, both gcc and clang reliably lower rol32() to a single instruction.
>
> > sha1/256 are simple enough in plain C, but other crypto/hash
> > could be complex and the kernel may have HW acceleration for them.
> > CONFIG_CRYPTO_USER_API_HASH has been there forever and plenty
> > of projects have code to use that. Like qemu, stress-ng, ruby.
> > python and rust have standard binding for af_alg too.
> > If the kernel has optimized and/or hw accelerated crypto, I see an appe=
al
> > to alway use AF_ALG when it's available.
>
> Well, userspace programs that want accelerated crypto routines without
> incorporating them themselves should just use a userspace library that
> has them.  It's not hard.
>
> But iproute2 should be fine with just the generic C code.
>
> As for why AF_ALG support keeps showing up in different programs, it's
> mainly just a misunderstanding.  But I think you're also overestimating
> how often it's used.  Your 5 examples were 4 bindings (not users), and 1
> user where it's disabled by default.
>
> There are Linux systems where it's only iproute2 that's blocking
> CONFIG_CRYPTO_USER_API_HASH from being disabled.  This patch is really
> valuable on such systems.

Fair enough.

