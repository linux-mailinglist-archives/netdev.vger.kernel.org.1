Return-Path: <netdev+bounces-69101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2A849A3C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AEBB24E0F
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92731BF3D;
	Mon,  5 Feb 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqNl0Y/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D267C1B976
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136176; cv=none; b=QeyDuK0pb/WZsak9RlWpq8dA6i52FoZRFWc4Q9Q/OfgpNLocrynCkSFWmfyVkzRfwoZhhl2kwS6ZvgWIq1JkebqggddNqRZfUpiTOO5bT5ZV9GvStl8x6iwRbag7/dpOlRh8/TXq9WV+LbK3AJE0DtqrdFf7Qebq9BllOxNPkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136176; c=relaxed/simple;
	bh=p8w5ORQN85keSs4iHtLF0hAGuD3vblI//NXG+Z81rLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIZCugDLUxcP7MtVDpSqrFy2ruzr2H7C2BThCp7AcS/pfYVeFL6TQ2vX4u86N6qLih4trSGIcMYkaOzNEOCq/2eXsENhmoPjNNQshTo6HLh7g7vtUgDe0pT/Jw2Sg8MmsrkpkD9LNMmD+0IaLvSaZ0Hw7XRS05fwIli+VH1jh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqNl0Y/I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so10538a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707136172; x=1707740972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k24Uyhl1+vZMArgijwhf2EF1yCtOJQ6dhObCgbS2exo=;
        b=wqNl0Y/IleO1SJfGRzcCA4KjzTEUKCF+akmHWdzBDl+JWg/c4xNfpN9/wvRLPB1R6x
         /Raq89Df4qqPf8x87MfUMHMlgODHO608vMumBFD7iPW7IHA6n7LNfxF/pA8tjCFre5wR
         7dUrlBStos62GxDEj4e7VGnqy0Mv+pOy6c8476QIXCd4bkRAu0cShOieIabSb6V/ttts
         CePiPKEybBU3zGVgDiVQSS7EelULFo8Hx65Te1wPwxZmsaPZTmNl/w9SI2RPAKBr4pOT
         75TtLioSMOm/BGVN9hKue3+hlyuBenFFKUTZbcnhUUFT7gpSB3QGfdCxdyg8L12e3bkl
         A2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136172; x=1707740972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k24Uyhl1+vZMArgijwhf2EF1yCtOJQ6dhObCgbS2exo=;
        b=cZxJN5H5xzLA/stu2DCx+XmQQ0weQZMyCk2uYZpQ/LnLxGF0NU2tX+b/L/79t6ugU9
         qQsVL132xehtplZUhh/JLx6HR2KROshAPn7gz/zm+xg2ZiiiJ3d8trOHQgPZxFD8xsKs
         HJSgoTT1o3snSvozwenQuIsU2/29Elu3fuAI4Q5wRCot0fjqyQpWFTyWiiUHym7kzUfi
         G/Pkp5r9Yc2aqGLy4mdqu0NH3vAj5uBVtS6NW6aaDWnjeLUsnNAGTmhZjFmDPjkBe8V/
         bj7/Vwy7NiPUM5ANLGX2FJtIDiCsS4SQPmgvW6ljkaucnh+4TzSjSk3GN0kL1XcWFvd7
         q6vQ==
X-Gm-Message-State: AOJu0YwxLNYPPa4jphtXczcWX2orR6rjhrXaUqG3GNGdv6qRfXoirXXy
	6gny0TE2jSq6vBSVtA5OetR0fqQJ6t4tkLED+zcfEiD0clCP/FsfBFCv6p9gcsNCFE/2+bcJVKZ
	5DlY3aLF/UvmxW4SgDxjOBBDhKNPqE0JM+ABr
X-Google-Smtp-Source: AGHT+IFzdiEyEpD5bJtfFnXpWSSyxQQjI7i+MYv5KUUWd8tWIXJwZPoB4d2ch4wJ9Fg7pBr/KbrQhvHNNzaGSNgkJfg=
X-Received: by 2002:a50:8750:0:b0:55f:88de:bb03 with SMTP id
 16-20020a508750000000b0055f88debb03mr249754edv.4.1707136171790; Mon, 05 Feb
 2024 04:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205072013.427639-1-chentao@kylinos.cn> <20240205072013.427639-6-chentao@kylinos.cn>
In-Reply-To: <20240205072013.427639-6-chentao@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Feb 2024 13:29:18 +0100
Message-ID: <CANn89iLkWvum6wSqSya_K+1eqnFvp=L2WLW=kAYrZTF8Ei4b7g@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] tcp: Simplify the allocation of slab caches
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:23=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wrot=
e:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> And change cache name from 'tcp_bind_bucket' to 'inet_bind_bucket',
> 'tcp_bind2_bucket' to 'inet_bind2_bucket'.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/ipv4/tcp.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a1c6de385cce..2dc3dd4323c2 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4697,17 +4697,11 @@ void __init tcp_init(void)
>                             thash_entries, 21,  /* one slot per 2 MB*/
>                             0, 64 * 1024);
>         tcp_hashinfo.bind_bucket_cachep =3D
> -               kmem_cache_create("tcp_bind_bucket",
> -                                 sizeof(struct inet_bind_bucket), 0,
> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> -                                 SLAB_ACCOUNT,
> -                                 NULL);
> +               KMEM_CACHE(inet_bind_bucket,
> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT=
);

I would prefer we do not do this.

dccp is also using a kmem_cache_create() of "struct inet_bind_bucket"

We want different caches for TCP and DCCP.


>         tcp_hashinfo.bind2_bucket_cachep =3D
> -               kmem_cache_create("tcp_bind2_bucket",
> -                                 sizeof(struct inet_bind2_bucket), 0,
> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> -                                 SLAB_ACCOUNT,
> -                                 NULL);
> +               KMEM_CACHE(inet_bind2_bucket,
> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT=
);

Same here.

>
>         /* Size and allocate the main established and bind bucket
>          * hash tables.
> --
> 2.39.2
>

