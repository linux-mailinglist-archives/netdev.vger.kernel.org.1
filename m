Return-Path: <netdev+bounces-155605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0462A03280
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F00164848
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB95145A11;
	Mon,  6 Jan 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFPItG5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D74A04
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201883; cv=none; b=fdbRK58HOL7ysOA5aid4eYStWWLqIOJHDaACBWiaOC5WHpE0aPK8C1w0yOSwOQKqEwJCoe62uaLB6mpR4kjdvEhJDZlMKJwiDvsYb2a/ezRvV3oXlLE1QUbJ2uqEnCUOfwxFQBt+KBX1LiOML6Bv7SdtrjsenkYMjIcE66ELDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201883; c=relaxed/simple;
	bh=gJE1od7XIRbhji9v6DeiF0Ef9teXeHffiWstwclel+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hyu35AD6MOCJK/gmdXeQlPwwd2iM/jjQlK345p0/dxpX4th/vl1ZMo67f6qH1Roca/he3GHvUQ1mZJ7s0aS1YEXGQKdHBBeA0kY9Web9ZtpYr7hvwC29fE8cXHTogpJc07pYri+lAAPn3eektWHHsGBKgrgmfu6HwvyaKIxGSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFPItG5M; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4679b5c66d0so26351cf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736201881; x=1736806681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJE1od7XIRbhji9v6DeiF0Ef9teXeHffiWstwclel+I=;
        b=ZFPItG5MpUK0AoWOyid7imAK6LTGpudLQp7vB5KSkqpct0mRbKJI5hYslhXmxvOqoL
         qug09W1CTdcSNmHTivjnz1hLzlQQGIQ1jZpe6RaYMyn2qwQ5F5EEY9bMkguP4ou7pLOj
         K/XpC7xWJ5STMhWln6EapEGJ2V3ijMW3GEGUHUunlxMemlHTBMx3Vkxd13tYK8wwY0mt
         Pv7XyhA2eF5bTP/x0d8HUHHlI01XKYqtwO3+4yJoe4Q1ixH4zelLgbCE4NmPnoZY+nW2
         acg9O/i82lyFBvmfRXzGqZeprvdP033pwQRpKyEUZLHUg7VOrjlTFfY7LHmS5IBVhC3S
         4HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736201881; x=1736806681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJE1od7XIRbhji9v6DeiF0Ef9teXeHffiWstwclel+I=;
        b=AxsJZX4QLGFNqyO9p1cG3bSd0EPylb/K43sDS4gb1fPFUH91DC3UplG3x++syfBMGU
         vuJhwfsX7qF0GJyUGP6sbkfyt3XL4vXJb4zs3I44Qs1qihCo1upeTcTRsw6qRuPCX2BH
         ncYoggGOzyKJpFfP36HdFSA4ImCe+Y2qAj9PxQpjQtYJgp9VxspKaTo/jh1JpVIhb3W7
         zGkVeZr1uZFz2y+mx+yHXxj90AJXy+nDRGplT9RWQAvuk21IxREkLrGXxWqPR+kPllOd
         wKyL4epj+hS1GwvtekwHB1zO3CTtKuZ87jDgRiOC08BWyHsyVqje0PRA+JIQCbHb7bAK
         4SOg==
X-Forwarded-Encrypted: i=1; AJvYcCVRXZ1fxX/y6XZDMR9844HLKbul2lP3aFgvRqkpVEK+KQmwehlbTH6R5h7TYzjSU2Lk/nprAxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrpRZdGBTN0eYjfW8pvgfwlWJiCL5YDV0hhIJ4R3UQ2I2cYGFY
	yycr/oxLuOalB9LOuQd31N46nzArZZ2x9TC2ACS50QWpV8E4iXzJBfVchb0MhCegpV/eyjZ6X2n
	xj3TQdvq5uungjgMfjwFFpKx4sJzulFaztDaq
X-Gm-Gg: ASbGncsf/RnijsGU4nleMLB49dT840d6J+nEc3CJ6qXZnI4r6LxGxFsBAYqYiQA2/nr
	Orae8yQOBZRVADh8xim/og5iyAqwtyAoMl1U7GZk4CQet87eZbdcxYju5iDaAywuE+Fbc
X-Google-Smtp-Source: AGHT+IEnRTy+2atHXl0iAzQt76MhzrYXtK3i4aJK/5JKKY6TwKwKtZqN9PHJ91UWqJEZuwln1K2bthHVvGEGqGBYLmo=
X-Received: by 2002:a05:622a:50d:b0:467:5fea:d4c4 with SMTP id
 d75a77b69052e-46b3c827e44mr179971cf.27.1736201881143; Mon, 06 Jan 2025
 14:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218003748.796939-1-dw@davidwei.uk> <20241218003748.796939-9-dw@davidwei.uk>
 <20241220143158.11585b2d@kernel.org> <99969285-e3f9-4ec8-8caf-f29ae75eb814@gmail.com>
 <20241220182304.59753594@kernel.org> <bcf5a9e8-5014-44cc-85a0-2974e3039cb6@gmail.com>
In-Reply-To: <bcf5a9e8-5014-44cc-85a0-2974e3039cb6@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Jan 2025 14:17:49 -0800
Message-ID: <CAHS8izOb59+Z4phe=nJNVOTjOy2HByuh4N-RBgJd5dvhLC9F0A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 08/20] net: expose page_pool_{set,clear}_pp_info
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 8:20=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 12/21/24 02:23, Jakub Kicinski wrote:
> > On Sat, 21 Dec 2024 01:07:44 +0000 Pavel Begunkov wrote:
> >>>> Memory providers need to set page pool to its net_iovs on allocation=
, so
> >>>> expose page_pool_{set,clear}_pp_info to providers outside net/.
> >>>
> >>> I'd really rather not expose such low level functions in a header
> >>> included by every single user of the page pool API.
> >>
> >> Are you fine if it's exposed in a new header file?
> >
> > I guess.
> >
> > I'm uncomfortable with the "outside net/" phrasing of the commit
> > message. Nothing outside net should used this stuff. Next we'll have
> > a four letter subsystem abusing it and claiming that it's in a header
> > so it's a public.
>
> By net/ I purely meant the folder, even though it also dictates
> the available API. io_uring is outside, having some glue API
> between them is the only way I can think of, even if it looks
> different from the current series.
>
> Since there are strong opinions would make sense to shove it into
> a new file and name helpers more appropriately, like net_mp_*.
>

I guess I'm a bit sorry here because I think I suggested this
approach. I think the root of the issue is that the io_uring memory
provider (and future mps) need to set_pp_info/clear_pp_info the
netmems. dmabuf mp has no issue because it's defined under net/core so
it can easily include net/core/page_pool_priv.h.

I guess more options I see here are:

1. move the io_uring mp to somewhere under net/core. Moving only the
mp should be sufficient here I think.

2. Do some mp refactor such that the mp gives the page_pool the
netmems but the page_pool is responsible for
set_pp_info/clear_pp_info.

3. Revert back to earlier versions of the code where page_pool.c
exposed a helper that did all the memory processing. I had pushed back
against that version of the code because the helper seemed like
io_uring mp specific code masquerading as a generic helper that wasn't
very reusable :shrug:

For what little it's worth I'm having trouble imagining how
set_pp_info/clear_pp_info can be abused if exposed, so this approach
is fine by me, but I'm probably missing something if there is huge
concern about this.

--=20
Thanks,
Mina

