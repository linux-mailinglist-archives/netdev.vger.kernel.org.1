Return-Path: <netdev+bounces-233918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D37C1A3D5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F46F356891
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30535A935;
	Wed, 29 Oct 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdTfVIXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8F35A929
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740584; cv=none; b=JNA+wb7aGHcccR3+HgIAmC6Uv9jfaTy2S+2XsbIU9WX5aSvUJ1qKTLvIVPkacoScny0Ijai9CbOIVUTjDiZt4VfmJIjFRhC/UL7FE7Vu07WTZ7hldtCOmjyFTFE6JRlPlpxCIqdBhP6uip3o8+RfijzSsrphe7sYZS5RzLncRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740584; c=relaxed/simple;
	bh=lMz9fVEHjNsR89opwTxfGLHpbSSbTkwW22XDxfNJNo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqnyS7XBUCJVaVhq+4R4xDrD4kzkg0+OAH0iYluoSchlvaA3ySuzOwvAGx3xtKjC/NPwCxudKfbKzUOZJkk79MqpU4BqAorDgbAUQh1nkkzauEcESD3niR1Ol7xEw7ZgynzTnuD72zxai/IxugjLM3YmqtXQGfMe9tCsZQTfV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdTfVIXh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d83bf1077so489948966b.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740581; x=1762345381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0c/4hWZsozl7YTWr0GTKUdnk9cs1fYSN3DX9TuRcw8=;
        b=QdTfVIXh9/dOsJGVosuYXyu2OI4ULunmyzx9bU4iudMY1LHGpxZH9hzJrIOvg0isvQ
         tks0nuDAITBPssvR+rSCsFu4HSc2JnCjz2zZpDNnylnQwZS9GuRVLT/ifyOsIv0pxxGs
         Vu+1xNdZN1K4cgR5tL+ouhkUMNx+eJyc3s5pX/HkWVkcYuEwp2KrRqUj/3QfuJF3kUvo
         cr/5tb7szhacJAkneL1ckmZKUFNPK1LdDed8RSJo2LhYYYj5dK8vzHqGZR24C3eILIli
         XnUYXGRax6amNgFhkjo0Xnk62aVRIV9T9Fr9og2SfsjvCk7LqZvvSYEmEosSxL8LUiuI
         Q1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740581; x=1762345381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0c/4hWZsozl7YTWr0GTKUdnk9cs1fYSN3DX9TuRcw8=;
        b=e1vO1tEzsW7SpnzyZhJNGmXijwGAcqBteBMLNlkRWko1BI9JkRZguSdwBKv7lXSJvs
         tSAPxhlxItQly+Vm48UjnvocVT5sJ1G2mPp/5s78tVbJOW2IJLfmMyl6Ix4e6U7i6oHe
         S9m7T9Y7iBFqeFlxoSeUqjuIHM9TSavtRMoMnSPH/Z/R4mAfrnMKgCFe3srQDxL1xC8M
         2A+dCwoxWtXj8aN4qGR/l0yF9FgTT5qJhpgZvYKSHep70uKYeBYNhTpW0KyFD/ecVtah
         EYJmByup1tURy9DqH9INMMnm+lCQjyxwPr9PaXJruMF4O1yptKEHe+LmVRmycTTimd+W
         vFhg==
X-Forwarded-Encrypted: i=1; AJvYcCWJhrcuC4NHTMIb9FqOPacZ+kr+3Ho2hdxsCeCo+RXjPO3HOYlNm2ZXjtlTBH9rgmKkdOvt804=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAX93H8NMk5qIdQol5CLeU/oHtkv1MLfs+phWhTR2NV5BC2eh
	LW9etBQzx3p+LYgs1oZGPNHqzivo1SL3e99ZRH0wqXsqwG0WXuINigQGd4f77Bqv3IWLF94DNdD
	9UdFuihBRfzce/+EC04wbCS7hukKwgYc=
X-Gm-Gg: ASbGncsLEqMNOjZDoFuPwburRLhkD5/w0JM0YWMKxr8PlePvkOv16Tql5IpIhLaZtTu
	iet7P0ZOUWI1kbDQ+qAUwA5yCV5NDP38BIodiXKHjBtnE7d2oypItuXuphdxCYKoG6SxGpSUDUf
	LZxgykSo25UfLyOFozTYpyuvATVLkcGQTIXlvqoxfWgeh69wBaem21bNhSkt0gF43LgeldUHou/
	0m+LIA94bZw/w3ulPftRVy3JFUSFUbZ64w4NvsjTKRiXTb/odeOmYC60qbjWwA=
X-Google-Smtp-Source: AGHT+IFHLKb7GuMaTant0mZZh+7DkoNItPLMFom70+IZl/TSaLwjrPzARyq58A9cf3m49Eb6OHGyh8pSiSaoLoPR9ug=
X-Received: by 2002:a17:906:6a0e:b0:b45:1063:fb62 with SMTP id
 a640c23a62f3a-b703d342998mr257605866b.24.1761740580026; Wed, 29 Oct 2025
 05:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
 <20251029110651.25c4936d@kmaincent-XPS-13-7390>
In-Reply-To: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 29 Oct 2025 20:22:23 +0800
X-Gm-Features: AWmQ_bkoWlg1YTPn_cPJZ6nI1pu6U1-lm4Q2dEOkydz0FKu0JfF4g7H6BwfQWow
Message-ID: <CANypQFZhFdSZdEXjEysET58DWYik-8bMVRP4Nqvz=1WB53BrfQ@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in generic_hwtstamp_ioctl_lower
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, sdf@fomichev.me, 
	syzkaller@googlegroups.com, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kory,

Thank you for the suggestions!

I will prepare a patch and submit it shortly :)

Best regards,
Jiaming Zhang

Kory Maincent <kory.maincent@bootlin.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 18:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Jiaming,
>
> +Vlad
>
> On Wed, 29 Oct 2025 16:45:37 +0800
> Jiaming Zhang <r772577952@gmail.com> wrote:
>
> > Dear Linux kernel developers and maintainers,
> >
> > We are writing to report a null pointer dereference bug discovered in
> > the net subsystem. This bug is reproducible on the latest version
> > (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
> >
> > The root cause is in tsconfig_prepare_data(), where a local
> > kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
> > all its members to zero. Consequently, cfg.ifr becomes NULL.
> >
> > cfg is then passed as: tsconfig_prepare_data() ->
> > dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
> > dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
> > generic_hwtstamp_ioctl_lower().
> >
> > The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
> > valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
> > dereferences the NULL pointer, triggering the bug.
>
> Thanks for spotting this issue!
>
> In the ideal world we would have all Ethernet driver supporting the
> hwtstamp_get/set NDOs but that not currently the case.
> Vladimir Oltean was working on this but it is not done yet.
> $ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
> 16
>
> > As a potential fix, we can declare a local struct ifreq variable in
> > tsconfig_prepare_data(), zero-initializing it, and then assigning its
> > address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
> > ensures that functions down the call chain receive a valid pointer.
>
> If we do that we will have legacy IOCTL path inside the Netlink path and =
that's
> not something we want.
> In fact it is possible because the drivers calling
> generic_hwtstamp_get/set_lower functions are already converted to hwtstam=
p NDOs
> therefore the NDO check in tsconfig_prepare_data is not working on these =
case.
>
> IMO the solution is to add a check on the ifr value in the
> generic_hwtstamp_set/get_lower functions like that:
>
> int generic_hwtstamp_set_lower(struct net_device *dev,
>                                struct kernel_hwtstamp_config *kernel_cfg,
>                                struct netlink_ext_ack *extack)
> {
> ...
>
>         /* Netlink path with unconverted lower driver */
>         if (!kernel_cfg->ifr)
>                 return -EOPNOTSUPP;
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cf=
g);
> }
>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

