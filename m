Return-Path: <netdev+bounces-66381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335A83EC0D
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 09:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD02840AF
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5835F1D524;
	Sat, 27 Jan 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l33AMTZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3B17742
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344497; cv=none; b=HiYjE38Sa6vpzQWwucV7RzN2J18bVZuljywRVMoWWBt0h+US99W82Eno6a7dRUIZMqyUZfLyu1E19E8X8dKVWS+2h9L2zxme96aVlgd+Y+F/w3xeCRB5JlJueNadrhbU5wxbXgh8HslmZsx7sAWkbYFafBHQ7kbUEvpqUe3M2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344497; c=relaxed/simple;
	bh=YhYYFMhnowTbbuX5rz69qv/M8AQK9VQhBzVq0JwlygA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPEMzHmIe38tcoHQyXxiobPPvWpRERSBSi+IywarNspYhNutSgaLZOk9oSRpC91Y+GITx3SQ7pKg38PkHmt13Dq2IAXqt1nphGV/w+5DkGjj/wGKbRY/TKlLcn0bU0IsgV0OfkEN20hIhxVl/nf+fHHE9HHTWeKq0yS6afAsqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l33AMTZv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eb95cbe52so13645e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706344494; x=1706949294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax1AbFa1G9ibq+UxnRv4ud0AHrSaEuEaK3VswH1DhqM=;
        b=l33AMTZv2N37ygBQXSZ0qJdKqsLZxu/YsggFiLlNByvBRHCJEcSjT4wnfwY1RW/KZr
         NsNYOCViPQdXGLnbuxRt3V/oOLhYZwv6J5CISy25XEhSawkRs1cqraOQnQM2KOQPsASq
         7re9dCeSa8ynnYIoL1d3wQiSwTr+VJzmbyNG2FGJjVbh8/KqNIJvbPQ1SeZikc16DDLg
         N33kfG4loFDmRuZIGiVj8MmBmPpviZBl1xal8nP1tokZRnnTXhjPc8oJGECZGZSkz1/L
         2Cv2Veo86tix41kCALRRKPKJ9xSqS0Dvyq5yALDuRF7OH3R1u56oDe/9ITT6d47QlJWl
         dd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706344494; x=1706949294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax1AbFa1G9ibq+UxnRv4ud0AHrSaEuEaK3VswH1DhqM=;
        b=V7rWy2DktV6JTj5Vx+XGMCxzRhTfm8KDRZcJJymIT4QBf3lkYV1Sa7SIl+S9LyAoak
         77bLH0U3dOAedKU56aWk8Ve8TfFWfH31ExnZtwj/eNAPOfKLLzS2FRJSuUpMTOSb2TKH
         zO3mQZenXuq6IOmB2d/K5PmMUj0QHoe7DNhI+6c3sHBfhZk0aN0eDMa+JKnCoKtH0YP9
         6+zwdSDZd+FLy3G9PfnU13A6AK/SMTn/TeUCDgsVP5Ra6zHiQWqt8G8hbsyxWLjGbOsR
         xnycziOMG3bBjyWlzFaMzI/iIyOt85vDd0CxOv/JPSlw3AJbBrJPBQSdT/41ktOd+dtR
         qvBg==
X-Gm-Message-State: AOJu0YxoylcUpSC/DuA3e2uWW6KP+jfuAcdhK8bJZgjTvP/UQGPCt9As
	K+iYdCsCqp9kVtd+CgrSrsOp/0Az3of7xM5/BsNKFQjVQJfvKqj1oxDnggPpStWIfye1UrnuIjJ
	gVl0nsuOf7Mq5zr8Xj1VRe/NGTH8xUqeRZJfR
X-Google-Smtp-Source: AGHT+IE75zSW/Rhs1QgAL7VROnqq4Lv+uAOUij8+AACC5vqdr+QQg/pDOeSbn28a5PQjrCE6O05IB0aWWvEn/ZkIdGs=
X-Received: by 2002:a05:600c:510f:b0:40d:87df:92ca with SMTP id
 o15-20020a05600c510f00b0040d87df92camr275914wms.3.1706344493527; Sat, 27 Jan
 2024 00:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126075127.2825068-1-alexious@zju.edu.cn> <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
In-Reply-To: <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 27 Jan 2024 09:34:42 +0100
Message-ID: <CANn89i+3Maf90HUzaGzFQgw9UQDoZLP-Ob+KrE9Ns6jND=6D9w@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Jan 26, 2024 at 8:51=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> =
wrote:
> >
> > When inetdev_valid_mtu fails, cork->opt should be freed if it is
> > allocated in ip_setup_cork. Otherwise there could be a memleak.
> >
> > Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > ---
> >  net/ipv4/ip_output.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index b06f678b03a1..3215ea07d398 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -1282,6 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct =
inet_cork *cork,
> >  {
> >         struct ip_options_rcu *opt;
> >         struct rtable *rt;
> > +       int free_opt =3D 0;
> >
> >         rt =3D *rtp;
> >         if (unlikely(!rt))
> > @@ -1297,6 +1298,7 @@ static int ip_setup_cork(struct sock *sk, struct =
inet_cork *cork,
> >                                             sk->sk_allocation);
> >                         if (unlikely(!cork->opt))
> >                                 return -ENOBUFS;
> > +                       free_opt =3D 1;
> >                 }
> >                 memcpy(cork->opt, &opt->opt, sizeof(struct ip_options) =
+ opt->opt.optlen);
> >                 cork->flags |=3D IPCORK_OPT;
> > @@ -1306,8 +1308,13 @@ static int ip_setup_cork(struct sock *sk, struct=
 inet_cork *cork,
> >         cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> >                          dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu=
);
> >
> > -       if (!inetdev_valid_mtu(cork->fragsize))
> > +       if (!inetdev_valid_mtu(cork->fragsize)) {
> > +               if (opt && free_opt) {
> > +                       kfree(cork->opt);
> > +                       cork->opt =3D NULL;
> > +               }
> >                 return -ENETUNREACH;
> > +       }
> >
> >         cork->gso_size =3D ipc->gso_size;
> >
> > --
> > 2.34.1
> >
>
> What about something simpler like :
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b06f678b03a19b806fd14764a4caad60caf02919..41537d18eecfd6e1163aacc35=
e047c22468e04e6
> 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1287,6 +1287,12 @@ static int ip_setup_cork(struct sock *sk,
> struct inet_cork *cork,
>         if (unlikely(!rt))
>                 return -EFAULT;
>
> +       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> +                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
> +
> +       if (!inetdev_valid_mtu(cork->fragsize))
> +               return -ENETUNREACH;
> +
>         /*
>          * setup for corking.
>          */
> @@ -1303,12 +1309,6 @@ static int ip_setup_cork(struct sock *sk,
> struct inet_cork *cork,
>                 cork->addr =3D ipc->addr;
>         }
>
> -       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> -                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
> -
> -       if (!inetdev_valid_mtu(cork->fragsize))
> -               return -ENETUNREACH;
> -
>         cork->gso_size =3D ipc->gso_size;
>
>         cork->dst =3D &rt->dst;

Hi Zhipeng Lu

Could you send a V2 off your patch ? I will then add a Reviewed-by:
tag, thanks !

