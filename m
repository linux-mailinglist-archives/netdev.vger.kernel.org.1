Return-Path: <netdev+bounces-122548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF0961AAF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294261F23FBC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1E1D45E3;
	Tue, 27 Aug 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gESINRa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE541442E8;
	Tue, 27 Aug 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724801815; cv=none; b=o8k5dmEf5QYanwD7ljw2DdllaA6JDLqvGL85hHhfO+BqF/EOP9FLiIweSuVcI8bX/sCvdt0F7WFVnKDd1z2VUTMUcXHgVouYU5PZT40qQYTJ4InKN+ez4DD0XqZxpqa7GVa5hintstgqUJoM0VdN9B6kpfOmcimdBGx/4r9YwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724801815; c=relaxed/simple;
	bh=wIAMi8gRK2LvVfrOokWwZqbiDGniwpk2AgbFvhIfXM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q365uW7OqkduIp3pB2HR3pZ4I24RXJp0OvKRjGFTNZ36pplo4EFVE5dRPU+kdsx5ETy2NdrF0K7pIsKIMI1grPsgSZTc+D0Nl9TB4GCq9EsXlycS9PwMlK6DZKgF+MMTbeYyM0AKw8mMv2eqYiYlwqlZlupH6b18rr2gYAFOxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gESINRa/; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso6054939276.1;
        Tue, 27 Aug 2024 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724801813; x=1725406613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts9O7xOYd5W83qRleAA3fQN//P95aRGTSy1N+0Pd5/U=;
        b=gESINRa/xHWjhLrulteBglJ5m5qVnvNHzGZHcL8q5YDJRRLSMfDAVoNWTEazOuHr+U
         wN92hKQEsmTTSA1dKUoe/RXEUTUODFJDlbF8kYJ3x7XM1TrL1E/WYEC18D1yJ0v4wkAe
         CxDZSnaemIVY2SFyeNnnFLqkLSHvEZZAuCuZifmgYTA0bVhP0m9TOcJdNzmRGP2nGUiJ
         Dxxa9LWWRCTP10IN++agISiXbc8QuVZW5jtFNWlKADKK+YnGKevcTaMu6jRC5Ic2uVAJ
         wbfmUlPYqxirRlfpObbR4EjIrO2epVqCbCM0xdxoncHEBXvuLfHkNtsYsdv4fcBoqzmW
         EzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724801813; x=1725406613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts9O7xOYd5W83qRleAA3fQN//P95aRGTSy1N+0Pd5/U=;
        b=tsxta+SAF6kaDJqrQM93ppTeGyz472CgyREyiKW9y5L0tq/Hz2KbpWUgGdg6gwa3mI
         JrDGPQSdxJp4sR8RsYSDmZNKaXM1G1oZVP/tCZeuT08gFk0kj4m/PRAlZnm3mDUjm/MS
         FRdN4I5gkWtcZLisxmhD/9QlYOmLXmYvHPOuC3PUijdQGMHgcsC7cr6hLmUBqQd60X71
         Jmm+Jan6y/o58g0BopzEQIlVzhfjIr8YhBNwsP9TZ+gFzED10Efdnvp5X8I49dk8Z0vB
         8xEWCMIVTCmy67G3Q8BMp+Rctuh5deCqCa8/9V7LEIQ/nY/H5sScjmAe6JfBAFiyS8b9
         PYpw==
X-Forwarded-Encrypted: i=1; AJvYcCUJrwwua7eLKsBURr4EMOr2ZX+zRFBrO4hFCVUP5vRLEnH7BEp7JD8dwryly+EkbezisxQUqmWTX+/KtII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8V3qpGrx7uaAPcWlTk9q2fmx6mqf060VOUw0DherAfmGeZhjq
	VW8f2JxTWkH7Q6tUQFQJiBWeAwmxoYByvJw/Yb0Re8TKe9LN3T1Me9Fkl53yFWcRLHFeC3ab+kn
	qc/Z6W75bLUe+dw6f8PuQVmLtzbUigg==
X-Google-Smtp-Source: AGHT+IFnYcmWVXRY+zcuHH2Irc/SxiPI4maAH1Ky2p5KlsbiyuRkLm9zB8QLhwsU7NWCvjxqtCrkxpomx8esRequL1E=
X-Received: by 2002:a05:690c:f01:b0:646:fe8e:f03b with SMTP id
 00721157ae682-6c624228f5emr204845137b3.2.1724801812857; Tue, 27 Aug 2024
 16:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826212205.187073-1-rosenp@gmail.com> <20240827161258.535f8835@kernel.org>
In-Reply-To: <20240827161258.535f8835@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 27 Aug 2024 16:36:41 -0700
Message-ID: <CAKxU2N-SDtFCrXWDc_2fGKSjosjBg=s4PJ2ztETrocTDo75ayQ@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, 
	o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Aug 2024 14:21:57 -0700 Rosen Penev wrote:
> > Currently, the of variant is missing reset_control_put in error paths.
> > The devm variant does not require it.
> >
> > Allows removing mdio_reset from the struct as it is not used outside th=
e
> > function.
>
> > @@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> >       struct device *dev =3D &ag->pdev->dev;
> >       struct net_device *ndev =3D ag->ndev;
> >       static struct mii_bus *mii_bus;
> > +     struct reset_control *mdio_reset;
>
> nit: maintain the longest to shortest ordering of the variables
> (sorted by line length not type length)
>
> >       struct device_node *np, *mnp;
> >       int err;
> >
> > @@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> >       if (!mii_bus)
> >               return -ENOMEM;
> >
> > -     ag->mdio_reset =3D of_reset_control_get_exclusive(np, "mdio");
> > -     if (IS_ERR(ag->mdio_reset)) {
> > +     mdio_reset =3D devm_reset_control_get_exclusive(dev, "mdio");
> > +     if (IS_ERR(mdio_reset)) {
> >               netif_err(ag, probe, ndev, "Failed to get reset mdio.\n")=
;
> > -             return PTR_ERR(ag->mdio_reset);
> > +             return PTR_ERR(mdio_reset);
> >       }
> >
> >       mii_bus->name =3D "ag71xx_mdio";
> > @@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
> >       mii_bus->parent =3D dev;
> >       snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac=
_idx);
> >
> > -     if (!IS_ERR(ag->mdio_reset)) {
> > -             reset_control_assert(ag->mdio_reset);
> > +     if (!IS_ERR(mdio_reset)) {
>
> Are you planning to follow up to remove this check?
> Would be nice to do that as second patch in the same series
I actually have no idea why this is here. I assume it's some mistake.
I don't think it's meant to be optional...
>
> > +             reset_control_assert(mdio_reset);
> >               msleep(100);
> > -             reset_control_deassert(ag->mdio_reset);
> > +             reset_control_deassert(mdio_reset);
> >               msleep(200);
> >       }
> >
>

