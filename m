Return-Path: <netdev+bounces-74922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDF8675F4
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D9283EBD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70F7F7F9;
	Mon, 26 Feb 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUtB3ULY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185E7F7CA
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952709; cv=none; b=DDZuYHHrisU5Er5/xQw+14dFotzK2dYrdwJ9N2wINkZZ+DZKOm+gbpU4QjmtQjAzdA+ZfV5zms+ja/fCJnUFrPkTHJq/cES/5Imgco2FVibep1ZXuaFoyxyII3l+tQHmjGjcW1yF9on+FR7CFwIvYzTXzcIkHyt3p+eLSmSQaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952709; c=relaxed/simple;
	bh=TSU/7vhopuediqaMB29afnxjrkk5SfO2S1L2CO1wyA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpEdrFC5s0F7tL7fT9HVmKbvF0Vk4ivIuzBJycL9PuOZrVL3Dr4xrl1rIDlPc3a5zkCfjhq/BEEyxGqmFI01RILhoY6X9hpcG7NqvzmMHAdg0mp/zPuZ2jZaE9fh05Ygw7ovg2/YTFOsQLWUaztpipZgy8pb0evUYb+rmfpaLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUtB3ULY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so3097a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 05:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708952706; x=1709557506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy6MKgUPkyetuB1Y1eJL9OxnWLY+8uMAQrEG8a3TiZc=;
        b=cUtB3ULYfuD4wu/3vO/+EMNrEJQFpSEdwicV5GW1JRkokPnatObaalZUE5QO/VgX7Z
         ljhxEnEjkWsRkDt33gI2mGG9EpaO6vHZq7YTkE5/HZZjGp3OFwdshoiRfGw+tMUDihpy
         rl+yUsQAa2tLgk1zrBc1+tN4OOJ5fr8w5R+f8Nyl/b3P4olO9jgFnq8MOIJ7+UoGofcB
         oMIw1NpKYynhEv79H7sEpKcVxLKSuVAOklw7AMtzMLAUnm2vIkf0sgcJ+HYEu/30glsE
         Aqk2KOHLEddIUnvNB0H4HjXP5kDPAjPPMyaMhleZl9wgXZktS4QoM4v56sUbF+C83Bpp
         QHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952706; x=1709557506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy6MKgUPkyetuB1Y1eJL9OxnWLY+8uMAQrEG8a3TiZc=;
        b=GLfBJECIEYRGP6tNZc2A4Hs31PeZulRfFPtOF/WFBa0H6VEliBSvy/srqirvYRVaPm
         H88xcxSUXJq6MJUU0UDaCAPPI0+V9RsEvKdFXHeoaFP8tUHat/slbxXcbzLMxYWUJBfx
         Gsh+xxRcWnqqrSV71VIbJXOgVsbd/dkPA7/gIqhdiA1s7pACB7NGnfu0MTxbsU13SFt8
         9T+qkAUbcsudYm5x+H7yGqDzJ2pr9MbkTNXuuhF4gLCAYcbXwLPjZQ6/u1gCP6laDpsx
         fRwk3s0ZqqCw2iN8aRbevqdxPSG3q8By9p6Wu3JYJKW9DcRhjDVkqbAm+CoDjQJzssio
         2yxw==
X-Gm-Message-State: AOJu0YxQ6fQ4KKNiI2UQyQPBmLKT3BM+jMyHvaZxJhFaXGLmHHlxAWHl
	G5cqLiHNWYf1HwR4NUqgeRnJ3q9CtKisp6ZSNZWufSikl/ZhdNFGCjoPoJrcDTKalrnaoGuK1od
	drdck3LXunBC47lbYAwM4+8qSLm+OBEXwPzbA
X-Google-Smtp-Source: AGHT+IE9kaSYsBbM+tOsGzJDOXFjCoBfN0PchoTRkAb97i97cnXlO1P4tee2BSQu3/6t8WsOawF9VLsrsWuCV8jCdhI=
X-Received: by 2002:a50:9b05:0:b0:560:1a1:eb8d with SMTP id
 o5-20020a509b05000000b0056001a1eb8dmr279013edi.7.1708952706186; Mon, 26 Feb
 2024 05:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225225845.45555-1-pablo@netfilter.org>
In-Reply-To: <20240225225845.45555-1-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Feb 2024 14:04:51 +0100
Message-ID: <CANn89iKjemgfRL-Yy2AS8kQj4iEa3DGT+uq1GabFTTw6Mr5o4w@mail.gmail.com>
Subject: Re: [PATCH net] netlink: validate length of NLA_{BE16,BE32} types
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:58=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter=
.org> wrote:
>
> syzbot reports:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
...

> After this update, kernel displays:
>
>   netlink: 'x': attribute type 2 has an invalid length.
>
> in case that the attribute payload is too small and it reports -ERANGE
> to userspace.
>
> Fixes: ecaf75ffd5f5 ("netlink: introduce bigendian integer types")
> Reported-by: syzbot+3f497b07aa3baf2fb4d0@syzkaller.appspotmail.com
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  lib/nlattr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index ed2ab43e1b22..be9c576b6e2d 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -30,6 +30,8 @@ static const u8 nla_attr_len[NLA_TYPE_MAX+1] =3D {
>         [NLA_S16]       =3D sizeof(s16),
>         [NLA_S32]       =3D sizeof(s32),
>         [NLA_S64]       =3D sizeof(s64),
> +       [NLA_BE16]      =3D sizeof(__be16),
> +       [NLA_BE32]      =3D sizeof(__be32),
>  };
>
>  static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] =3D {
> @@ -43,6 +45,8 @@ static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] =3D {
>         [NLA_S16]       =3D sizeof(s16),
>         [NLA_S32]       =3D sizeof(s32),
>         [NLA_S64]       =3D sizeof(s64),
> +       [NLA_BE16]      =3D sizeof(__be16),
> +       [NLA_BE32]      =3D sizeof(__be32),
>  };
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

