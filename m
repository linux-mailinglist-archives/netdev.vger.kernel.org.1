Return-Path: <netdev+bounces-126621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862A97215F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96909B22594
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B966A17CA1A;
	Mon,  9 Sep 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPh/TDiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A717C9E8;
	Mon,  9 Sep 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904368; cv=none; b=U4jtDHxoZuHNkDSi6iSb2A7f0OnXESaf2TZOXXPKnEC/1bKLsphov2AgChAe8QvPD8QUCKmwD7/hUSpArhd4a6uewtXSKDIC8lmf0Auvb4aYZJ+3sDB43KWbd12WvC+UxiahuZW1SmhjkoaaIwDxpjZ6VOGfE/kfFgpJjaZwBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904368; c=relaxed/simple;
	bh=+RW2SkIUZidK5p99LVvbGdZig4SBxuZXrWllcZel2cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hByGWR2uf+KZHQXdqYDlRxePItqoPGOu5A1zZ57J4QFyg8OVz9VgLke4askVO7Pps6QmIuNy+AcbKu4gmqrZU1pyP80UiFCJlaZoUiE1N4tL1+h2EriJCo15nR+ak0jyRQz+sHaqQd1RkH5EAUqpQXD/NG1Q4oAAJuSEGBADBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPh/TDiZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db449f274fso33801567b3.2;
        Mon, 09 Sep 2024 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904366; x=1726509166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA71bBXBDpVp4iX+B/GkFYeCBiCHGltNrWhkdSucHlo=;
        b=iPh/TDiZk7nFlFMNX65lhewTr1uBjfOOatefgKKoIgR9OzIek/omdbJ+d4dQqMPV9F
         2gEURUV/6HzQaHaiW0xzUd7eQ2pTX3VSX4YyCBCQVYVfAwUREj8VzgmZl95eQHGA/BFU
         rAh+gO3gTEPBM3rSXmtCUfet8rXWBmdIF8LQIt48buQ7syl4Ip1uKo14AOHPsHZ/shGq
         uruRsKB1OaXM4HTYm4Z+BugIjhe4wMgmOEFXSZW2pUY0r2G0K5bLVh+dNuS7L/cG0P/m
         iw721/XiGk9JNjeZ7g/mHLjeJgucPJIY4Dy+oXXHcCNIMw2sdIL4i+ojX9pjiH3YtVZw
         QrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904366; x=1726509166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA71bBXBDpVp4iX+B/GkFYeCBiCHGltNrWhkdSucHlo=;
        b=UUKPSn/+V5RjBezHhvw6R6JxkkR/Pna8dCOWG/NjR8VbzutW9KE4mGdh7rhbru7NFk
         JANOJn5ClG3Uj/YsD0lPL3sSLCPWWOw8Ot4UcmJIos2vJL27P7EbUDfH4MDHmdQLrL/c
         e0E+hLthbsN7CSuPhmf30oa94PFF3X0xZuR5Ail0CICeLEIrnaGI+jfgZCCjNiAeCQJR
         OzmBLDfjUnALPPA6Of5ENq83YjINCQd3fp9meBV/jxwE+StibF40TCf0TMVTzwqMyQLE
         PPO/XDWT//1xG+3vAbEzCq6JLcqVz1DpKwYDCeGgilF/eYT+B++4KSO5ZODLrFLVPTgt
         VJmw==
X-Forwarded-Encrypted: i=1; AJvYcCVxNdzg07kxGVYT+qEP5pG/h3hvIG3Zk8Knj5a5P7+qRiWgGwF7oyBkijUvTee3hW6xhhPmlk+w4D1tOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8le363WMmJH/kCbU592tZ1xYsqcmPy4rS9lSZBfEkSThm5Ce9
	HgeDc1MEdR5nEQt00b4L/1pURjQinGwDOWInLYi40aRGGZVkTMtJ3slldCjeINzpfQht3t/tsg/
	aigmt650YH5Xq4FK8jc8aSNIie1U=
X-Google-Smtp-Source: AGHT+IEVDxKObNp0y5D9nKfZUhJ9EHkwW3PbaTxVCVG/oapKLc12IsSu+8jClTwNI1nmFIs42xIpSPS5e903Zbap0Ys=
X-Received: by 2002:a05:690c:2d09:b0:6db:5567:6907 with SMTP id
 00721157ae682-6db55676eb2mr88485857b3.14.1725904366248; Mon, 09 Sep 2024
 10:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908213554.11979-1-rosenp@gmail.com> <CALs4sv1zEtdmdnOaxMUHRHPFL44pN5zdV0K9m1nDfr-up-eFzg@mail.gmail.com>
In-Reply-To: <CALs4sv1zEtdmdnOaxMUHRHPFL44pN5zdV0K9m1nDfr-up-eFzg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Sep 2024 10:52:35 -0700
Message-ID: <CAKxU2N9SwnXwPgrEJN7tFNxexO7GtBBNd50cAtqQxLz3Cm5Cow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: gianfar: fix NVMEM mac address
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com, mail@david-bauer.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 9:22=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadcom.=
com> wrote:
>
> On Mon, Sep 9, 2024 at 3:06=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
> >
> > If nvmem loads after the ethernet driver, mac address assignments will
> > not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> > case so we need to handle that to avoid eth_hw_addr_random.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> What is the issue you are facing with a random MAC address?
> If there is a real problem, this patch should go to the net, with a
> proper description and fixes tag.
Embedded devices usually store the mac address in some fixed offset on
flash. NVMEM deals with this.

I don't think net is appropriate given that there's not really a
commit to point to. nvmem is a fairly recent addition.

Similar commits in this vain are:
42404d8f1c01861b22ccfa1d70f950242720ae57
f7650d82e7dc501dfc5920c698bcc0591791a57c
f4693b81ea3802d2c28c868e1639e580d0da2d1f
be04024a24a93f761a7b2c5f2de46db0f3acdc74

>
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
> >                 priv->device_flags |=3D FSL_GIANFAR_DEV_HAS_BUF_STASHIN=
G;
> >
> >         err =3D of_get_ethdev_address(np, dev);
> > +       if (err =3D=3D -EPROBE_DEFER)
> > +               return err;
> >         if (err) {
> >                 eth_hw_addr_random(dev);
> >                 dev_info(&ofdev->dev, "Using random MAC address: %pM\n"=
, dev->dev_addr);
> > --
> > 2.46.0
> >
> >

