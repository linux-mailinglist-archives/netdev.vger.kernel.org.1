Return-Path: <netdev+bounces-107398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2991AD27
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DC8B23A93
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CAD1991A9;
	Thu, 27 Jun 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="icXFnF0X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E375E56A
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506947; cv=none; b=msNeH6erd/6/iujB4vAiUeRVS0NpWksClBMwQzr1pD+JJW3JeqfqQQOadi+bRz37PJQ8hzShPH95ywrv6iKBMjBJ7f1cKy1IvNFL092eCwb5BT5wK1XRS2dcMWqhJNFp4dqOp2o6l9FgY5GcGNpxU7b5GLQi/DK4O7w+mtbRRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506947; c=relaxed/simple;
	bh=c/4fRIUAemDzS10rHlCgLgOeocikZUevNTeZx2WBQIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDc5aH9gJvq0byHlc1Nc9zV3biomiHHmp9xW+ruZweRGjiJHjNlDESlKW7LcS869ANCV/Xc1NO71q6lkDYOkE+Be1CzOH7p+s9gVeSzvny3PqUefiwCJRP7i0HwYcYdmwTuB91llmTJWo+LIn+pUS5Korilsp9OvtO0Ol57fcno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=icXFnF0X; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7041053c0fdso4966160b3a.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719506945; x=1720111745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxcFEOlgMZdT3jwSPBKvbM2Hel/+xTILb1M8DFKl18Y=;
        b=icXFnF0XlfKUfiIZ/77bLs1A3mXy6ePVUmXg12nm7iyhegg3eaUYMQrRzMeNFYSCiV
         cBFQT39vLeCEZ87AkDiE5osHoixilxUyya7iFfh0fRE+trmHKp3ZG5YpG/sOG7BGZxSS
         K8FYkC3F+cPwOqYVvHyCTQ80NSK47YsND442ERHkNxEsNYdBxrE40o+cT5wZFGSxw/xo
         KLUY6eEa1EJl3gJ4WmfgbsWoyt3F3AmocCwLdsQ3VISzaxZ76fSwYRWTObHmrnXhxkuW
         3pu8yEm516lxU5V1HE7Z7b3nYO4k66kQMLICbuUdNxn7SSQZUQ0H8SnlzagkhhwQnbbL
         Vrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506945; x=1720111745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxcFEOlgMZdT3jwSPBKvbM2Hel/+xTILb1M8DFKl18Y=;
        b=bC4O2vimnBG5ekYwHE6u8pTrHKojRxYymr7mDHbJKrj5m+1idsGWUQfXliFk+1xSXW
         atGyD/PtOnuQZ1TzRQz4zeLaJ9p235MHq6UMaf5/uAp2TIcWdC+sp3U7aBkrdIEmX/LZ
         po43nElVgVgLK8+Mou/hA/8WHhoj2/9vNjYfdZaZoEnK96v913VeyzVSKz+TYeNw7tkV
         Z0nERvLsxXTCIIKK/T6D0iDTPz0/krZpDZFnw/Qh/n+YK4ZKKWyjPp8lktQ7FS0ZajcB
         9JTOW0c6WthIao3OAcRF3M5Vw9AVzD6GszujoSKHlAsI0hQJCqatswaF1pqBut18DbYn
         jUNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPK1NJNPqfNZnuzGf3U9NF5W1wGtmSlJf1E3VXXQYaOueYFSZbARKL3ogCC7UAPUoVhqwSnt34Ww9xwDy9bcFZNxdHQh1u
X-Gm-Message-State: AOJu0Yx0NudGNWkMwEFnRHTBCHPAJBlGR3gxzG0pbYrq3+HgJjGnZDMK
	oyb2GijCU7xW/GSNRqRWxhV8aWW5vjb6Sv1jMDhs5y7FxHy/ZaRilNFSF7Hh/c1IVFZNJgZyjgo
	1zudVRAi+ms5t/zSVw0T+KOyFIv8xg5wyAI+xkQ==
X-Google-Smtp-Source: AGHT+IGuCIcGgabVY++a4Em4rrMpQkk20usuUoDxNeZRMIEMY4XnKjgZq6XSJV5vH34NogeLq+vOfcgAhpt92ibkLbw=
X-Received: by 2002:a05:6a20:3d8b:b0:1be:c4e6:ed40 with SMTP id
 adf61e73a8af0-1bec4e6ee22mr5759856637.51.1719506945413; Thu, 27 Jun 2024
 09:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113018.25083-1-brgl@bgdev.pl> <20240627113018.25083-4-brgl@bgdev.pl>
 <ea452581-c903-4106-b912-d307f74f773d@lunn.ch>
In-Reply-To: <ea452581-c903-4106-b912-d307f74f773d@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 18:48:51 +0200
Message-ID: <CAMRc=Memf-fwY2iRXNDz7M4337PcH7quAZ7GHgjauj+Og8PwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for aqr115c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:22=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add support for a new model to the Aquantia driver. This PHY supports
> > Overlocked SGMII mode with 2.5G speeds.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/net/phy/aquantia/aquantia_main.c | 39 +++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index 974795bd0860..98ccefd355d5 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > @@ -29,6 +29,7 @@
> >  #define PHY_ID_AQR113        0x31c31c40
> >  #define PHY_ID_AQR113C       0x31c31c12
> >  #define PHY_ID_AQR114C       0x31c31c22
> > +#define PHY_ID_AQR115C       0x31c31c33
> >  #define PHY_ID_AQR813        0x31c31cb2
> >
> >  #define MDIO_PHYXS_VEND_IF_STATUS            0xe812
> > @@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phyde=
v, int index)
> >       int len_h =3D stat->size - len_l;
> >       u64 ret;
> >       int val;
> > -
> >       val =3D phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
> >       if (val < 0)
> >               return U64_MAX;
>
> White space change. And that blank line is actually wanted to separate
> the variables from the code.
>

Ah, this is accidental, thanks for catching it.

Bart

>     Andrew
>
> ---
> pw-bot: cr

