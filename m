Return-Path: <netdev+bounces-131350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F298E3A1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E5028259B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D8215F63;
	Wed,  2 Oct 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2R9YiRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6212CD88;
	Wed,  2 Oct 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898062; cv=none; b=C71ef4nI1Ultan777gr6T6xncBkMS1Pb5oj3uKxVlgREim/vwuejO1mNDQowiNlPkSQbxbkwkt94STb0X7mS6/9XkMAXIcczaLuCG544LTfo+dwMUj1KNSxniGeiFTr+kqfseBzh+m68CCdXtjlZq0mj7PxfePKfNH+d6br9uV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898062; c=relaxed/simple;
	bh=5b7Q7juvcEC8k3ag237tuIBCrwOT0CGs8G6BlYzYbqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fddSYT6POn0Mt6gCOkA0krTFuKKVM78ZK/HuRL7znlRkIyPoPvkWFkJ3Mk5J9rm0hQZHCcDt5Bgi/VRYJ1tDDC1EAL3FYlG9vhUH7irtmYl4WKvipyZVqVk1xdaF2QG409loUJxnXlHqIDLKp0sBMFuSmNOdIdk1sWcdU7TMNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2R9YiRp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbc9a60480so1733227b3.0;
        Wed, 02 Oct 2024 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727898060; x=1728502860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcpOQqdOJ9ajI++q/SRdMyLHgoMEmleJDEkpBz0PTDM=;
        b=U2R9YiRp4MAVI2Jg+vBt+5FDQLArOl1D1kibJIvz8e8vFkAzMh3ALV2P4sDnJRrF3Q
         44xesnVgfZa620QTm5g2qJxaOKEGSdJFLD3gtYFTuw8ei5QwY3MKb4PeEgPTONsBpqr1
         zNZkPnaQ3/QW0+LTYdi+n6i51ArSwvYaPC6I/x6phuaAj5OvESJyeaLuvyGdOhIsMgzU
         +mc1xwugqlG66g0oCA56KAz5qH73JTnDLO9/WTwjLQSF3TpnzOFC6E7rc9tWORtBsJzP
         HSy7jzYzhTm5ldhGI312RWR6nWFeva58Gjgal/jLEqryT7lIRC+5p2lq4vWLH+6HxVj7
         kvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898060; x=1728502860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcpOQqdOJ9ajI++q/SRdMyLHgoMEmleJDEkpBz0PTDM=;
        b=G5VT5/nd4eQupUo8KwlvJJwZHtfBVLpaRqdapocjJ72182N59D3pX8FrtFmIYhW7db
         T2oHk7teA60cC5VEo/9U7T5IfGSWB9kJt396O2hxDDOqyKdTSaUpjx1TSpd8gh/pydJs
         uLgeZxT5Piw+9NVu2F3REqwl34AT7foH5Z+hq5MNwWVMCKbzVF26rvGXMBxyAB9VZgYO
         o7UJByWDHsRhGsiCSa/SD8EwmVJh5iBOeg2PsoDfJDdPSMzeWsFriWUCZOzNQx/iXWcT
         25Lp5cS7tLV/g6nzTdl6tyuo8XS5sIya2HZy1u0JiiVDz8BAYEpDaLsg7CxGfRyVQUqs
         qryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZ7zG6UStGYgLrUedurByDSts2j+YwgjdGFF4sDVHbmYeffpD3FEFn80sN6oy1pJuaHT1uSG+ITsHX7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNmy4XeZwHO/snncQuP9Xnn0kC2A6P9WG3jdptWOms/LbEzTP
	ta2irGaij69aaV0WR0+toqxvm1pP42VaqFwjYuvqUpXdVsRVx8tDGx2/NWQKoum8QUwu263NZcr
	Kzn/3cRxtp2mArG274rGVrxfYQeM=
X-Google-Smtp-Source: AGHT+IGp5lrcBcraOdcYylO4OzA/eElIMZnBuVIffAoO6Xgi8GWswul9jhOw17zU+QEAC7uxH3PJUmJv/ufW2OYJlAo=
X-Received: by 2002:a05:690c:10c:b0:6e2:4c7b:e379 with SMTP id
 00721157ae682-6e2a9e41705mr25100387b3.19.1727898059812; Wed, 02 Oct 2024
 12:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212204.308758-1-rosenp@gmail.com> <20241001212204.308758-5-rosenp@gmail.com>
 <20241002092946.63236b11@fedora.home>
In-Reply-To: <20241002092946.63236b11@fedora.home>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 2 Oct 2024 12:40:48 -0700
Message-ID: <CAKxU2N8jOTyKAGeUm7JGwrsDbQviwtSkGuuonYxj2ZV3ni82Ag@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] net: gianfar: use devm for register_netdev
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:29=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On Tue,  1 Oct 2024 14:22:02 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
> > Avoids manual unregister netdev.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/gianfar.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/eth=
ernet/freescale/gianfar.c
> > index 66818d63cced..07936dccc389 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -3272,7 +3272,7 @@ static int gfar_probe(struct platform_device *ofd=
ev)
> >       /* Carrier starts down, phylib will bring it up */
> >       netif_carrier_off(dev);
> >
> > -     err =3D register_netdev(dev);
> > +     err =3D devm_register_netdev(&ofdev->dev, dev);
>
> I wonder if this is not a good opportunity to also move the
> registration at the end of this function. Here, the netdev is
> registered but some configuration is still being done afterwards, such
> as WoL init and internal filter configuration.
>
> There's the ever so slightly chance that traffic can start flowing
> before these filters are configured, which could lead to unexpected
> side effects. We usually register the netdev as a very last step, once
> all initial configuration is done and the device is ready to be used.
>
> As you're doing some cleanup on the registration code itself, it seems
> like a good opportunity to change that.
There seem to be a bunch of netdev_info calls. I assume those need a
registered netdev.

Additionally, the irqs are allocated in _open instead of _probe. I
assume those would need to be moved.
>
> Thanks,
>
> Maxime
>
>

