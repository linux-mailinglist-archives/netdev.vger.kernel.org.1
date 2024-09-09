Return-Path: <netdev+bounces-126625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16359721A2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96071C21DEA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164417D896;
	Mon,  9 Sep 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5DsbeuG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875F54278;
	Mon,  9 Sep 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905516; cv=none; b=IW3ZlGIBAHea9ZhnecUO+Z5KD1X5mW3wGIvBSq9tcLotWPAMHwhfsDCz1ayCzGiWt8CrOWiAYB/f4IbMCjXcI5FX/HhAlNdJ+A/pQwzlH71B4F+ra5iuRPgtDZB6nADldi1hGqy+vJ9k7F0X6Q9/Dz9Te+F/7SdRFX0LXK5OEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905516; c=relaxed/simple;
	bh=XTJ7/7DFt5+Mk5dMQKZl8QXurv60aPfDStwxSEXxLYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmiXfRgf2BIOVEG8yaGdw/m9Gov7GBN9glkefmpLYIqHx+JG9RrvRQgZlxUt63bxPsPmSrPUh7HN589+1ENdKJCXLwBlVLldlEkuTHYb9eaOwCgYAEQtJErirCc8QdWs36uFTO1s0Al6EIAJ6l3g3g4Gz9ROR+lfynGpPHEfJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5DsbeuG; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db836c6bd7so11543047b3.3;
        Mon, 09 Sep 2024 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725905514; x=1726510314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/C8I8dUF+94f4P0w1E8dmllKN26AblwRL1jOcYO3Yw=;
        b=d5DsbeuGAQS6oIS6+t2rVQioKQF+5L+KmWp2O2Ku0eYci6IVdjN6wO9OIL+3tjuzDR
         l/D3CKb3/9Mis+L8pGQE+nLshszzElyfAH9RVQ8ZyjX8td+XTaagpyKzrExf4coLRG0M
         SL7arcuFnDKywEtfrSh92EJ6tLSSQxMJovrBsz6HN/sElSnUs0kXtL/h8JomNuKiAxpt
         VmrMQYicP8OF1Z96UsaVVc7EQTEZJ9FbsEKaQ4R/Hk+k7Ohx4B9R69LWqBaXuRmzI4Sj
         wscVzSsCg4AV6nMEQmi7hl0tUHdKJxvpHRIqYKlsMWIS9Ppu7i3PvY7ut8vUOxx0ZsgY
         7F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725905514; x=1726510314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/C8I8dUF+94f4P0w1E8dmllKN26AblwRL1jOcYO3Yw=;
        b=VNlU9eVP04jATKLf7IV7j97l7+XXnNkOCyMHbFJf0LjCr7th5WW3XwhTC7a4YUDDgT
         XNCLsPrvjHO4pm45qkD/3Z8hH7rbFkg6MqFOMZVtgOGZGzLo/KlvCWVF7R+yYdQ31reM
         31Mj7YhK25tCwole1YEDYDwHPbVlf1kk3IWkQdKH3Wh/Vg0WzlUvEl4A/P5s9mUVG/Io
         lev5yckmjKrsmJmKDDIwbnfiBhNl6iufY5rFcxI6IBguKk44gYdoC2jY4RXCtSmXvOYs
         tF/Etoual1135y3V2UlAziYJo8nAlkHOZmuTOnCPQJGOzdujxxcsdd1phH6NDikKDp1J
         99Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWRrWmww8qT12VLFLA0+QprQFO+qzLqAa/QkujtsyHHU2hKF52PHilkYyUYfFQA7Snju1NuLkH3/NzWKDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6A6PDON4m4Rqj/p3Fz1jPGQGAbopWFVQ2zEcsVom9z1qJCPD
	IFR7/QZtd3AAh/OnEZI8HKaSSba5MY+iZzUN1wcA4OgM0JHCqTfABkA+hbY35+oZnnJ3Q2BUNgf
	P9Uo9lZ1mItsUbXNcaa12Tpz5q/w=
X-Google-Smtp-Source: AGHT+IGLaPWjhqqUbItQzBt2hCljFRSycXyZEGt/c0YCwg3NybcBtkiRDDn6Gtec7YZcKD45XRXK8shsEO+SR47vS7o=
X-Received: by 2002:a05:690c:b9a:b0:698:b11:6a6b with SMTP id
 00721157ae682-6db44df2a81mr110062687b3.17.1725905514391; Mon, 09 Sep 2024
 11:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908213554.11979-1-rosenp@gmail.com> <20240909085542.GV2097826@kernel.org>
In-Reply-To: <20240909085542.GV2097826@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Sep 2024 11:11:43 -0700
Message-ID: <CAKxU2N_1t5osUc53p=G2tRLRctwbxQr3p3fScR-N1kgoNxc80Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com, mail@david-bauer.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:55=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, Sep 08, 2024 at 02:35:54PM -0700, Rosen Penev wrote:
> > If nvmem loads after the ethernet driver, mac address assignments will
> > not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> > case so we need to handle that to avoid eth_hw_addr_random.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/gianfar.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/eth=
ernet/freescale/gianfar.c
> > index 634049c83ebe..9755ec947029 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -716,6 +716,8 @@ static int gfar_of_init(struct platform_device *ofd=
ev, struct net_device **pdev)
> >               priv->device_flags |=3D FSL_GIANFAR_DEV_HAS_BUF_STASHING;
> >
> >       err =3D of_get_ethdev_address(np, dev);
> > +     if (err =3D=3D -EPROBE_DEFER)
> > +             return err;
>
> To avoid leaking resources, I think this should be:
>
>                 goto err_grp_init;
will do in v2. Unfortunately net-next closes today AFAIK.
>
> Flagged by Smatch.
>
> >       if (err) {
> >               eth_hw_addr_random(dev);
> >               dev_info(&ofdev->dev, "Using random MAC address: %pM\n", =
dev->dev_addr);
>
> --
> pw-bot: cr

