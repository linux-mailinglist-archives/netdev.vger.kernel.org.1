Return-Path: <netdev+bounces-131347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD498E36E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D260B21EAA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA722141D5;
	Wed,  2 Oct 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7KM/z6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201361D0DCE;
	Wed,  2 Oct 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897357; cv=none; b=HFr76ApHRKYyPny4OdZHY1BLYu3tNArOeDilAy2X+IGj/D49eSa3GJeAg1VXLezpj7jbYF8098FBn0/Ju93v1rl94RcPaK6XGOzB1QZg+jX35bR+smyDOtrsHBOSy2aAUKJE/W18nG1JYu1EZOjZq6oU4e7/Zdkwenf3cwM55z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897357; c=relaxed/simple;
	bh=xMKHn1MWD/3Uh2cf7AVWa0QHhzy5IVdW87nep4HYZZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQ3gLYshArPFckNkoxVwmrP1MVzXt2vsdvSPdpm9nivztdslcgV6WuiTTpW5GtosXuVYBLeqNSks+gfg7Qean2NS7PuCd3OAeEBAss2V2X9iErYzKWDXtG1ERWtwmhrqIKnhxZHVeHLTzJu7z0Z8Ao9w97+rfShbJCIG4ebg22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7KM/z6j; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e129c01b04so1526217b3.1;
        Wed, 02 Oct 2024 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727897355; x=1728502155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx7GEwZsxeNosiPIhge5F3+mcoIXm090XHYOzMLKoiU=;
        b=h7KM/z6jiUivpQ7MlRbpaEaZ7/RkYOAHhlzd4aQBpjjRo1AzFd7JC2xcsLgFUf9RJK
         RNo5YIOwcpPCchQIOpDTbzk8WKDt+Dr501xE3koM3WWM0TX4Zv10VDCmvtIhDqoVnS5X
         yQgr7VdxlrtTVOvpW8vpT7BZ4Guq18xQHETYSZvJwflsTnsKpE0a3Jf0RRBl8rzVPElV
         /+IzSTmoSiQPmqU9fG6BYz8yROHhEVW6aMSi2of4nCHoxnzzZc4ypv67FrxME/cMXJSz
         lQrkqEzC3Q8IG1mFYNqN8E6KyY46m+v06MoCdGqOWBXjepitO/QeWK5P0+TuBqES3qqH
         tYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727897355; x=1728502155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx7GEwZsxeNosiPIhge5F3+mcoIXm090XHYOzMLKoiU=;
        b=urwIoDersRE8OAYZxDQw1YjPwBn1ms9QdBQLKBSs1g856cDI9lc2cf6rkDxVFfkR2D
         UqfisUzWPgVUIGBOaR2tuEBdxxkYwRyMIqiAyF0ldY137LWs8Tlp3incfQR8BhmN6vSQ
         wRLPbF5DTXDIsOAVeTlNIZZpXEdMltBERtwrqZ69QEK+lrixUc8F28VeRlolD2AH+BhB
         TYgca5bg38AToQ1JfRvILb5fFT7t2D+Zi9lxlh60Mxv+CNfF6ExI0hZptThs8kU6b3Vz
         /yB9qKvLso4TOqXKa2QjGOB1IOmo8+p2u/u3x/tXFUYD+itmPMVk/IlCLxmpjlgAcUO4
         +Ttw==
X-Forwarded-Encrypted: i=1; AJvYcCVCtHdKW2VQBvfDjdXdDqsF+MP3cr56YhWjXSmFLncx2qMISetSC2ZpTxN5cc7CHQeJmR93+45UP9DBvlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxfhPmEcPp4N6uArA2m3n5NFhxfc9tZzKOOJ7stpj9E3xs4NTF
	k6LfPw5SDHiJIsVo/7zYn3ZnkhYYpu9ocjmRq2fMP/06pq99eIxhIhSw/g6xBUFhudDbPC39eT7
	CzvuM2hVezgO3xhoC2yyWuPLX60M=
X-Google-Smtp-Source: AGHT+IHexoLEBGvbd2BXB23dldas4E9UKutdwU8ENn6fyBgcg5H8bV7iB0MMcKz58awH8/UZ1vmyUD4wcDbKygtyD9o=
X-Received: by 2002:a05:690c:dd4:b0:6e2:1545:730 with SMTP id
 00721157ae682-6e2a2b81f11mr41810487b3.2.1727897355069; Wed, 02 Oct 2024
 12:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212204.308758-1-rosenp@gmail.com> <20241001212204.308758-6-rosenp@gmail.com>
 <20241002093736.43af4008@fedora.home>
In-Reply-To: <20241002093736.43af4008@fedora.home>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 2 Oct 2024 12:29:04 -0700
Message-ID: <CAKxU2N8QQFP93Y9=S_vavXHkVwc7-h1aOm0ydupa1=4s9w=XYA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: gianfar: use devm for request_irq
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:37=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi Rosen,
>
> On Tue,  1 Oct 2024 14:22:03 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/freescale/gianfar.c | 67 +++++++-----------------
> >  1 file changed, 18 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/eth=
ernet/freescale/gianfar.c
> > index 07936dccc389..78fdab3c6f77 100644
> > --- a/drivers/net/ethernet/freescale/gianfar.c
> > +++ b/drivers/net/ethernet/freescale/gianfar.c
> > @@ -2769,13 +2769,6 @@ static void gfar_netpoll(struct net_device *dev)
> >  }
> >  #endif
> >
> > -static void free_grp_irqs(struct gfar_priv_grp *grp)
> > -{
> > -     free_irq(gfar_irq(grp, TX)->irq, grp);
> > -     free_irq(gfar_irq(grp, RX)->irq, grp);
> > -     free_irq(gfar_irq(grp, ER)->irq, grp);
> > -}
> > -
> >  static int register_grp_irqs(struct gfar_priv_grp *grp)
> >  {
> >       struct gfar_private *priv =3D grp->priv;
> > @@ -2789,80 +2782,58 @@ static int register_grp_irqs(struct gfar_priv_g=
rp *grp)
> >               /* Install our interrupt handlers for Error,
> >                * Transmit, and Receive
> >                */
> > -             err =3D request_irq(gfar_irq(grp, ER)->irq, gfar_error, 0=
,
> > -                               gfar_irq(grp, ER)->name, grp);
> > +             err =3D devm_request_irq(priv->dev, gfar_irq(grp, ER)->ir=
q,
> > +                                    gfar_error, 0, gfar_irq(grp, ER)->=
name,
> > +                                    grp);
>
> This is called during open/close, so the lifetime of the irqs
> isn't tied to the struct device, devm won't apply here. If you
> open/close/re-open the device, you'll request the same irq multiple
> times.
Good point. Would it make sense to move to probe?
> Maxime

