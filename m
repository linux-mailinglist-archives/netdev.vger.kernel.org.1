Return-Path: <netdev+bounces-96301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8928C4E36
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA13281E49
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A433208CE;
	Tue, 14 May 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJYAamfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89512B83
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676932; cv=none; b=S/pEz0/jMw3dniUaN90Rgthe6kkEuldnpXfLE9Kko8zZgvT/h3jezSfjOpkl73Sj+s2xMG4sM1vzOYgGphrYM+wM86gFGd7uOjW/Ilzt+V9mbuF5zauSJirkWFLR9F76Ddesb2UiHFCOycg7wr8wWIN3ZCMRfPZ46g8K54I4Ork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676932; c=relaxed/simple;
	bh=fjJyzm6+dyqVH9wAbVGx40/Q+HUlK5vKPHdKTeeENXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJJ0pbYXEhF1SC9s17wC1dhV9FszOJPIROrRRSKwnHaghuCQjnrjQKj2fGSYMVEhl+z8tteRWyhAeJlLB2e87g+K2sHXSJoDPfH+2ptIB/FmSThPx6NL04lHylhQrM6tgHVO8gjegWFAEE/JuXqRZfWrHJIHcEkH1/5SxFLet70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJYAamfy; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de45dba15feso5191057276.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715676930; x=1716281730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsYKg0cCi4USfKul0xj/s8dA/9ddKeLaOG+OL/kvVHk=;
        b=mJYAamfy0AVQKjPwJDK8ZFF1ytpf47+vWs5zPT671uSnYqYiiCv7KNHwt7z1WpGuK+
         /IUIHuInbnC/VYaWFw0HERTMkMfc2i1lZEophKMeVItqOx9+NZooGuq8YAunxlxIfuoJ
         LGZHsFysXui0MCEXTStONhZADR7R2HfuNMzTyAnS1wK63hOKIEO/BXypy+3h82dyvYR/
         2pUygkprRWnQBSor33+2BnwEVJ8f4cKY4Q0Yxi7DN18ajjjZVr0R+arpJx6RbXRWugAR
         7dDQV39Z5FjmMU9L9B9IwzrzMl0Z/TJlmvNSfSSZhR1I2ldBBLc8kFZ7AUGT62E3iU6g
         QBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676930; x=1716281730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsYKg0cCi4USfKul0xj/s8dA/9ddKeLaOG+OL/kvVHk=;
        b=Id8ZV7ruycmh2YR/SXRFmbE/wiOhbXhZCJIZA7my2HP5Px79iU5y3BqZY59v7PVnWv
         1Ho44EVmceJzWEP0PRn33H76iLKL8aBj5FO4JAg3LU2mm3676kQ30DWYsrd1hUS0gQGu
         6BgMOmRsal4yz76CBWjhiHaywiOV6QqRO/EjMBCta7IhigJeRZ9i3Eje+bzePjW8qWJc
         shaK8a7JCVJm+MBYbIASxzF+YSx9Bm7adF3dDVHJe4z5VJ28AQcPQRm2zdvJQeQ194i3
         jDKVFJDHQQCZAvkFMmvw1UUfFWog7gqW5HFkVeSXnXnJY2HGQpB6AmyjtCzgWa2yWgjF
         ZHmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZsMZ7E3Q55dG6YZ9EKIRaF8dRmyYYR+0bzYglj4syHXv6Xx+qmeIq5bunN5rAAx/f06qVbuc5sBaDbYnvi3uIs43UTnw8
X-Gm-Message-State: AOJu0YzJxP+w8ywLNY4yO+P1CsEGlhF1HgOCNSKavjmcW4SRAES2nGJ5
	dKKbw/hUxOMJL97lgGxVpmFhPxazpHFEZxjDex8klj+l17rXYMHb9L9l6BS5MCy68xWW4oRARND
	z5AwgY8BXk1rETzdidCEl3ZvvGCzCjWd17xktcgP1KPY8uFn963w=
X-Google-Smtp-Source: AGHT+IEgVMbpP3yKnp2iAhHmmm4RZzsx8CGBdguEtzPB/nACD1tmU8xel3FfDkJQJL3D3WhECVUWPPzP7rR6t2bbtsc=
X-Received: by 2002:a5b:f12:0:b0:de6:b4e:c143 with SMTP id 3f1490d57ef6-dee4f1829b3mr9823005276.13.1715676929820;
 Tue, 14 May 2024 01:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
 <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org> <9d7d7e8b-8838-410b-a694-2f2da21602c1@lunn.ch>
In-Reply-To: <9d7d7e8b-8838-410b-a694-2f2da21602c1@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 May 2024 10:55:18 +0200
Message-ID: <CACRpkdZnhH=OvivSK0=e_NUEB3M--v+MawjuZZOPNoRCWn1NhA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/5] net: ethernet: cortina: Implement .set_pauseparam()
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, May 13, 2024 at 03:38:52PM +0200, Linus Walleij wrote:
> > The Cortina Gemini ethernet can very well set up TX or RX
> > pausing, so add this functionality to the driver in a
> > .set_pauseparam() callback.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/net/ethernet/cortina/gemini.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethern=
et/cortina/gemini.c
> > index 85a9777083ba..4ae25a064407 100644
> > --- a/drivers/net/ethernet/cortina/gemini.c
> > +++ b/drivers/net/ethernet/cortina/gemini.c
> > @@ -2146,6 +2146,20 @@ static void gmac_get_pauseparam(struct net_devic=
e *netdev,
> >       pparam->autoneg =3D true;
> >  }
> >
> > +static int gmac_set_pauseparam(struct net_device *netdev,
> > +                            struct ethtool_pauseparam *pparam)
> > +{
> > +     struct phy_device *phydev =3D netdev->phydev;
> > +
> > +     if (!pparam->autoneg)
> > +             return -EOPNOTSUPP;
> > +
> > +     gmac_set_flow_control(netdev, pparam->tx_pause, pparam->rx_pause)=
;
>
> It is not obvious to my why you need this call here?

I don't know if I don't understand the flow of code here...

The Datasheet says that these registers shall be programmed to
match what is set up in the PHY.

Yours,
Linus Walleij

