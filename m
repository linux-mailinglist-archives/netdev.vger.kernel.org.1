Return-Path: <netdev+bounces-127231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465C974B08
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3E81F27C71
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1A137772;
	Wed, 11 Sep 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCPpLy42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29E7DA84
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038828; cv=none; b=J9qS5La6VjU8Tz+WhkdshVisRMcKYkddrkKiTS9XLJlq5lccz/JxmQo3/O3Nrxmr0DeExMr+4AI0/ZkKrfW3H3QsSIyBs1NqBL6ZPGj+LRfW3ztrUZZvCF+70rOMTRpyIhVVhT3sbBqETNCAvTbyy6k3fF1xSYDDB9FralfQjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038828; c=relaxed/simple;
	bh=FG0vhDdE2kEDHdjeLrKC9WT3SCrt0nbsjC9nvDFei6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+GyZ6CV+93HF2SoIXCjhrB6d315r26iPxPfxXeysBdyfqUp3H2t/GH2ftMXY6cLvAMzO33UzZJ1UyFFzKMAZApZHIiiozSjfTUZBqC6n/HIIf19fWVHZ5s5mafH5yKSvdW4izOR8WMj0RuJOZlgSv1/F2PSFEYVM0NKk7MNWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCPpLy42; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1071305a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726038825; x=1726643625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpbnUhyXk9rzBjZhyi8AWJAiR6Z6aDTpJ4wMNR8NhZo=;
        b=fCPpLy42siCKfeTCD+ZibAeVuE2QUEvglChAWO2mDYo2F2YreJlvHH/jsG9+bqD499
         GthxcmhOiTFevg61xzkLDHKoVF5qTBlAyiUp6WQyJ7a8vpVn4VzDsscw1WCswFgSfGxe
         AxVFJxjS3e4KBpc78xTetvBvz6rNQy/5PRXMwH+A/n+vb5DszXB6kUrNxN6EySJLFoS5
         hNbzvT2S+YkTZ6ioqwYancNLutWAdws5SbNbLegZj2JbD8SygagZAhOSzLA7HTG82101
         mPJxvxmh85DxXgRTjmKsi9sgItt82DplI/XlJhJD62f5y4lw3nxTT2R2zUOicUiVubO6
         EZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726038825; x=1726643625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpbnUhyXk9rzBjZhyi8AWJAiR6Z6aDTpJ4wMNR8NhZo=;
        b=uCRI9m6CNTsdRlUiAPVMkrQMyxViIS8Ooo0HSQaHTNXlim4qhFLctO8Tc4E9KMnK0L
         5YKTi/6HL2v0Wh2ZE60tkAPVUtOz6mzAr64K8d4fLtG0AFMmhjpuF6MBLSmR0iajuVby
         7SYBXoFbDAtoRHMOlN5Lx+aVEVeWNN455TTOlkrp42cvq9NZf6dyGHQxrusDZVPOe3ge
         TwAaWlFq8t1cCyeT8n4t8cD7BSoixaoQt6y0/kNWD3c5EETpqsQOnYkYBgAFbN9SRobz
         rr/0HMSQ3YWKqOgk7rlKuanwm30MISfwb9KqbfqLChd0/4Ffct5TWgHz1fzI0McmgHWm
         dFHw==
X-Forwarded-Encrypted: i=1; AJvYcCXE2+cqlUB3oUK1rN2TZ6Yojgp1e8dQ7c6AQHtEOSUeigr6xZaQ9+8g+bcMgCUlQ8L+BWgyOqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcfW6h5y4JHPxbMtmArv2dFjNnGizGsT/aNpPVlFefC5C3HLh
	l/4WPnQ37DmEW0k/sX6/+PhcYs2I72E3f7+qoLaDozDGY2PLPdQmJDKU1LHNzKosjIv/GXwXrmT
	IjNjBAEy5UaXo2vnsz+mzazNb587VOBIVdM0B
X-Google-Smtp-Source: AGHT+IFaH0rWRZUpy30EVnoaZRDUOXbJjy+yfijB+mhWpPSiqLVupU9Qc1p4YigSs7+YJ25x4UOQw78w92QwgHVkODQ=
X-Received: by 2002:a05:6402:2347:b0:5c2:751c:64ef with SMTP id
 4fb4d7f45d1cf-5c4015eefb3mr6489026a12.13.1726038824199; Wed, 11 Sep 2024
 00:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911050435.53156-1-qianqiang.liu@163.com>
In-Reply-To: <20240911050435.53156-1-qianqiang.liu@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:13:31 +0200
Message-ID: <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 7:06=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> We must check the return value of the copy_from_sockptr. Otherwise, it
> may cause some weird issues.

What issues precisely ?

I do not think it matters, because the copy is performed later, with
all the needed checks.

eg :

if (copy_from_sockptr(&len, optlen, sizeof(int)))
    return -EFAULT;
...
len =3D min_t(unsigned int, sizeof(int), len);
if (copy_to_sockptr(optlen, &len, sizeof(int)))
    return -EFAULT;
if (copy_to_sockptr(optval, &val, len))
    return -EFAULT;
return 0;


>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  net/socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 0a2bd22ec105..6b9a414d01d5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool c=
ompat, int level,
>         if (err)
>                 return err;
>
> -       if (!compat)
> -               copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +       if (!compat) {
> +               err =3D copy_from_sockptr(&max_optlen, optlen, sizeof(int=
));
> +               if (err)
> +                       return -EFAULT;
> +       }
>
>         ops =3D READ_ONCE(sock->ops);
>         if (level =3D=3D SOL_SOCKET) {
> --
> 2.39.2
>

