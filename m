Return-Path: <netdev+bounces-196139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BBAD3A3C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B0916CF90
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2B29ACD3;
	Tue, 10 Jun 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Th7YNSs0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E660292933
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564360; cv=none; b=tWAwYRPiYVeDQCnV8S+gWmGtl/EXsfjp84PIib1ag6TZ5DyiG/L7OVHkFZ0/gzE3xM0UEhN8CcNLqn07bCJYAybiGoXJT/FxtDKn8xjCbNUF3fDiTChXu/BbqddCZc66mbfBwfkFWjrulCW3pzJWnIfcSqVlfOsQoAv4gr2iYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564360; c=relaxed/simple;
	bh=kxrLkvelHxMTEXuljgeHJCpG7xgrvRPn1OOIhqwjvTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Siq26AYUrrLfEkyBJ5/QYMTPxRxzmLuiTYPChT7mu3JzZ+/9qRfD50hrB0/esiLT7XQXxemc71hkWZLUzwPlzgSLhb6Q5FFTU1JRF/8xNe7wuGjnrHaBFQ6CQgrDIYUsny5rvU32eNdD6Xm5IS3VpWKx/148oOOqp5KiZYZb4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Th7YNSs0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so41791851fa.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749564356; x=1750169156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48R6rmcYMdLE2oI43bVdlx+c/dGz3JTf+F6/kFw0QQY=;
        b=Th7YNSs09c7kUwi4emlhqLKvHcr62j0zX5UUoPY0EQrq153yncFUtGA6mTuR4Oc59Q
         MqA9N24wYVgfhFsnZiovjssUAyP5YvE6Yh3jRDOSM0pJQO0kn2+Bw1o6w3kybx+srR4N
         xX8EyjM0MO8L4vIXNZOZnydBeMOK5FWbdO7B4ZnGbbIacTKjWI7RO+0PDGmS/axYUGcD
         C1cZ0cbg5akXQcrVAwcXh1uMck4QKDn69TFIJ4EfJByf4/yUnHdcXrJ5x7Bv90bLc3yh
         UXpMS3DA6bOe4DgcnzEGZokRUuxcAUHl+EBUZMae9yt4H6Fcm0DyRzmSeZovnTiMK9fG
         SNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564356; x=1750169156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48R6rmcYMdLE2oI43bVdlx+c/dGz3JTf+F6/kFw0QQY=;
        b=lB39/iOKtbKoGPh6Mm9CV5yFn+uTZkgJbxKsPcsy5Qt+KG24DSLGCMtopTgWCtkcNy
         OYQknkDmKT3dOlMx1ZTvumvxMpIeyPmHAnDO6NeUbN5u0fncEQCHABhBjC3nz0ohkmmm
         wfWkb64FQZuoAtR+mMNagJiSfyrehR08AKDWoxNoSvfxKmxcmyxRt7uFmkY6bvgdL3cD
         vNvxhFf+uio5IgZyTXUw4CrNnTcqzYQM8hnrYpeJcmiMjRA9BGg8bbNV+Lm2ypMbFxp6
         +41UckNfXAtJ36qsTZpKQOyvFFsgKXhNJHqFSV7Uopb7XiPz064KQ67mD6cO4gRxSzkS
         /9NQ==
X-Gm-Message-State: AOJu0YyVEKp12FzLB6Jl9qFZA8QXDMebGguoqv7ze+jXH3AUqRhpCKZc
	ICJeNmwOQoJpBa+bgOpzpsBB5oaBYaolMKbnRGxPOCLKSXxgV4M7Yb6Qa8AzQsuum+vAsPFFTEp
	He70WkgAqF8IZkxcEymGynodeJW/bAg9HatmFYEyU+Q==
X-Gm-Gg: ASbGncseYEaPawcOlGitXxtFXxhzjm+MEJ8RaRM87DBQg/EBd2wbzgubc5nFthkHPIM
	WWYqwshswMy6P1z4lKc906p5v35HJThbSq8kGnBOwKZwBgzm6G+5ow1M83ZpqxY1LTvUkZVzAJH
	uxYkrLP49aFZRDB7CgGjTjZbMEQoOp9Y6A0AzJlHB24THFUhTck1Kkd3VAyLKB2REduc7qvDj9
X-Google-Smtp-Source: AGHT+IGMo5nFepHm6Jb8myrJnf1+8r8NeSUFkOpNLmlYqlQxjgnpXV7nPyOaCRaS1k1ZDZMWIDYqubJ68xfi3XL0kUk=
X-Received: by 2002:a2e:a585:0:b0:32a:85ad:2148 with SMTP id
 38308e7fff4ca-32adfc55558mr48698001fa.8.1749564356227; Tue, 10 Jun 2025
 07:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org> <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr>
In-Reply-To: <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 16:05:45 +0200
X-Gm-Features: AX0GCFvZApBk6UP-dxTG2kWDbOfc7qUQfTVpw2yDagExp_rgnAnOYdtyDfv1kN4
Message-ID: <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: can: mcp251x: use new GPIO line value setter callbacks
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-can@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:55=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > struct gpio_chip now has callbacks for setting line values that return
> > an integer, allowing to indicate failures. Convert the driver to using
> > them.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> This does not match the address with which you sent the patch: brgl@bgdev=
.pl
>
> > ---
> >  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> > index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f3976=
c2bf7b9a99e959c1e 100644
> > --- a/drivers/net/can/spi/mcp251x.c
> > +++ b/drivers/net/can/spi/mcp251x.c
> > @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_ch=
ip *chip,
> >       return 0;
> >  }
> >
> > -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offs=
et,
> > -                          int value)
> > +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int offse=
t,
> > +                         int value)
> >  {
> >       struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> >       u8 mask, val;
> > @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *chi=
p, unsigned int offset,
> >
> >       priv->reg_bfpctrl &=3D ~mask;
> >       priv->reg_bfpctrl |=3D val;
> > +
> > +     return 0;
>
> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_wri=
te()
> which can fail.
>
> For this change to really make sense, the return value of mcp251x_spi_wri=
te()
> should be propagated all the way around.
>

I don't know this code so I followed the example of the rest of the
codebase where the result of this function is never checked - even in
functions that do return values. I didn't know the reason for this and
so didn't want to break anything as I have no means of testing it.

Can you confirm that you really want the result to be checked here?

Bart

