Return-Path: <netdev+bounces-82829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F388FE01
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3299F1C263FC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2A7C081;
	Thu, 28 Mar 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhjEb8aR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C37CF2B
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625092; cv=none; b=SJb5MasKP4JnXjdzxPiQIOnSQcq1F6UTKTYN7c4Xl07MSo7ByfNndEVgXnX2wcFpGdDaKGqSlCyEK/c0eHzd51KCwIGrV9+rdWZSHQp9XWdVqSSjelT7qQbBZByW+u24vvSW0aFwbvD/WDnfFLaS1Jo5juDVr3wrxo2boo7U79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625092; c=relaxed/simple;
	bh=tnzgZnHGvjzpembO12IlnXETWmQ0mUemcKZVW+j5wlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJlT2qe4bL1C47aaeVNoq974ahPJs0bRtP85G1nHqapzdTY34Ig18oTpvMYXDz0c4C+IXiZJo7CwpWllzZviuqeQRNIfSDIPV7izp3WUAKxgMkXz8Y5YPqJpy/H2XD7RJNvn+wvaab/bXvEV6KnuSe/rKatFmTB7LwTXTFslDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VhjEb8aR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c3689ad32so8825a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711625089; x=1712229889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9RtXKqdM0NEP/jvkJsqXFl6YxZLFKVDhdfzMmY7IMQ=;
        b=VhjEb8aRTNlIbnEgXQcu3z30GZVXJtasPhPVg6MWkQVGRGvZTRMWIDEggmUul+SDwd
         RKQXaZjzOgk5MJqpQD7mnt2K6tbAG3lQYczwEhYjbcfnSWeyWr9AehDqfHsNmfWftpJy
         j99d+nWETTQ1buELgENBZmgoSg4NxmZgzWbUyliN7s/oK2gAzoX0NuwmDa+4fcn+yH+Y
         9RyG4ms97JGPg6P1bvmk53WlMwUoFz2zvU9bR8tapG3KOZKT+Hs8vurKXgpFuUJFKyvJ
         7nLtiaYSVv1/wyGQRQAsa6pvdW4OGgsV/Sj4WjpVsIGGrUllfvBSJzPkt5YeckHRE4bz
         h3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625089; x=1712229889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9RtXKqdM0NEP/jvkJsqXFl6YxZLFKVDhdfzMmY7IMQ=;
        b=hGVVVpqRlT3rQ6G9031klJMP3mx7+4FwKuxt7+m9ZZ2pYRN17DNeKzTDzd6WrOPnv0
         b0zFNS45KuxRKtQ2WoGUj4DF7WQ1yoSy3eFaFEHjD5s4k+njqyk/JzP2rrrFjUpzUquS
         MCtVRk9n7/r64AyYUoB6ffAwTHuuadbbKyqIf8/QZKlPsuM8JkYCCsEH3Jmq/5JLtbN/
         A7Wn8RrH5WIFtzBzavQzhbyFL6uLjzk7ytrKzExJkEIq2dJr2rHfdbeRpBiTQubx1v9u
         IarRaQ00oadz7dnUqIj5nJFodYC8v92iG+RjS51SD4lrj49Sy05trkTSY7GCZMVRgdg/
         BkSQ==
X-Gm-Message-State: AOJu0YxgsVtWXGgMpavBEnt8zXfWatJYEC/s/kyzTxvtnJhT4o0+XQFt
	hZdD5jTgqo4MTo73eiqxsZSiKdVJN9AfSt+ua7sOuYV36E4rCjRF2unHOCM5JfHTkd98YomSLoa
	ph5vs3JfWOlaM6F6AqBCm5occq+VcYx0LxQpHj9ucESRR3MkaeA==
X-Google-Smtp-Source: AGHT+IEMh74duR2IlrsmiKcck6q9uCWboeFcPUkdiXWBLsE3anZZ0eqpGXe1Re6BF4ltbquI2jJf33g10yYhazk5Q4c=
X-Received: by 2002:aa7:cf95:0:b0:56c:5dc:ed7 with SMTP id z21-20020aa7cf95000000b0056c05dc0ed7mr161205edx.4.1711625088733;
 Thu, 28 Mar 2024 04:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328112218.16482-1-dkirjanov@suse.de>
In-Reply-To: <20240328112218.16482-1-dkirjanov@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 12:24:37 +0100
Message-ID: <CANn89iJ9=aWiYWYceXFTUj7dPnTt8t12mDfx7PRMg5+6k6BO=A@mail.gmail.com>
Subject: Re: [PATCH net] RDMA/core: fix UAF in ib_get_eth_speed
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	Denis Kirjanov <dkirjanov@suse.de>, syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:23=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com=
> wrote:
>
> call to ib_device_get_netdev from ib_get_eth_speed
> may lead to a race condition while accessing a netdevice
> instance since we don't hold the rtnl lock while checking
> the registration state:
>         if (res && res->reg_state !=3D NETREG_REGISTERED) {
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed =
from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index 94a7f3b0c71c..aa4f642e7de9 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,11 @@ int ib_get_eth_speed(struct ib_device *dev, u32 p=
ort_num, u16 *speed, u8 *width)
>         if (rdma_port_get_link_layer(dev, port_num) !=3D IB_LINK_LAYER_ET=
HERNET)
>                 return -EINVAL;
>
> +       rtnl_lock();
>         netdev =3D ib_device_get_netdev(dev, port_num);
>         if (!netdev)

This can not be right, we could return -ENODEV whild rtnl is kept locked.

>                 return -ENODEV;
>
> -       rtnl_lock();
>         rc =3D __ethtool_get_link_ksettings(netdev, &lksettings);
>         rtnl_unlock();
>
> --
> 2.30.2
>

