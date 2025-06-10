Return-Path: <netdev+bounces-196218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723ECAD3E43
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA641898462
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705C23BD14;
	Tue, 10 Jun 2025 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eQLzL2y0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960612CDAE
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571570; cv=none; b=jOWHrsSd8tbJOxOHB5GIdD65Ja4veJVjW+qvetZu4NCaaIUohZfDcSpDs2cwBzl/mAHGhPc/sm5FQEoePq+FqsQTQ/PPMmGK6/Lvwtqg+peQdaX26BuTWqJH2y7jGA4CzMAlnMMLyYpCoYp+OQwnbplkv86TabBjJ88jxVnkwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571570; c=relaxed/simple;
	bh=u6cGggZH3SoNATQpjfjKdz2DCIZcJJHBoyp8JLYX+lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwPeRGSC7YsxLPK75RkLnbsFAghE26vEOfMN0sZ7ZDBa3WJ95lio6A/XD338fVZuNuYdUnb9+Y9Lg32CAQq0L6rOoo+A9Vq1JnuEAIr12hhLoU2/8UZynS1tc9Wdhe251YWgUrxooV9YIzEImq0QXYJK/57EB92UTcK0GVadqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eQLzL2y0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d98aa5981so6875467e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749571567; x=1750176367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBeEGoByLmNx0JymY4xT4q6q7D7j914xDLGGfvyG00M=;
        b=eQLzL2y00GZ30dqiHn6Z1b8t15Dk78jqEBxhQOW7DYZJ0tatu3bvWrxkImq7R8+6oH
         Sk8Kk+HmW4erRVPpuqSQuziMhY5h1ClbUuyf/rTCVyxgYXLDylH9a9OGKF3TVDx6lrPq
         fOpbWE6tBhoIQP2vUi5otZpT255Az8Jvmm3wLpN2NnaUTa6/b2R3Wiw7BfuSNUgBjC7A
         VV/DWSmphV21TDzFLEyvzo399gowzCR4YUxHsbkpXFU9yNrjmehqsArk5TBpsXeGWoyj
         kJyEbitcGIs7cWEScx/9kS9/nm7sPOvjoDJr/zTudNI+DuDG1c8KD+TvjhgdXQ3Qg4i7
         fX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571567; x=1750176367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBeEGoByLmNx0JymY4xT4q6q7D7j914xDLGGfvyG00M=;
        b=vluekgm+EnsOy0ogLjOfkdBrii/DptTria35ct78rZFeCB9o+1ePqIGB9rAHgwQVKq
         lmz1ncTqEXQriuKEvHvf9DOU2S6OsnLqHjlYKttLGzp65BKqJWA2vHPOja//eCpdVKyN
         XaY8qNdxy5PDbfr6wOTUpJTCuVAz/KQFzIqlj13egkAOPRMHB506nEMC/bcnE66u0Q6I
         tKqJjEWM1yV77byfcl4uvMpJJXWNXkj2t8YuVhiWgHyWhAC8ELdvhw5ZQUPBlX6HjBPe
         SZWUHAOqAp/OGrumFDeIBmoxEtUz8DqutpYDLwIfj8u7iN05V62BE17bOt8mRn9zQvaR
         etNw==
X-Gm-Message-State: AOJu0YxZKNpUsV6SIXm/k/E6r9QWJrS3N0mRlfGxRlatvjQaBGqe0rq4
	H6c2aI50xiSkLfZLVuoCR+PJy0f0a12F+HdzQpO+cNOVThNqWNImq5EX7+h8CaL3jmYjiFmYxQh
	Uzdz6+wH0Lpg1YrAWWK2VoYOR0JSEm9Zy98j6mDZ6kw==
X-Gm-Gg: ASbGncs2MB6WoYv1bugw+5/lknlTitzCzadwdH8IWyAUxx06M0TUprAc5zGALuDdsHZ
	p+XmB+5Xz3NoA9pBpGe5+cxUKY0JlNUgI1gDhOLGk7iZ0FeHvq0HYoHb/tifRDObZZXGAIdEqqz
	+Z1mpKLyvwGp826m9HBZxodFuoSnFXrjH974rL76qUfCP2bwJPND1RgKtGg01XHK/O1Skdb5dQ
X-Google-Smtp-Source: AGHT+IHd3I1OVEWgMny7h2Baqh5DBJB572YkfzrpOW/nSB1wjoInAYuzH6/ihFE+HkYDZj2j7lo3/mOOSaalg7HeZM0=
X-Received: by 2002:a2e:bc23:0:b0:32a:87ce:1235 with SMTP id
 38308e7fff4ca-32adfc3f54fmr52666951fa.36.1749571567213; Tue, 10 Jun 2025
 09:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org>
 <20250610-gpiochip-set-rv-net-v1-3-35668dd1c76f@linaro.org>
 <b2f87cff-3a81-482b-bfdd-389950b7ec8e@wanadoo.fr> <CAMRc=MfCwz3BV15aATr_5er7wU=AmKV=Z=sHJyrjEvLwx2cMjQ@mail.gmail.com>
 <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
In-Reply-To: <b9ea7e0e-7dd1-460b-950a-083620dd52e9@wanadoo.fr>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Jun 2025 18:05:55 +0200
X-Gm-Features: AX0GCFsFWH4b7yJkolxQLHQKmDUo4N7FgPgYNia8CjJoC_PxTolZxLLShEa2WEo
Message-ID: <CAMRc=Mf4qupdJEm9mWPF3-B3hprn6AvP7Po2=aQYbaSvFf8OeA@mail.gmail.com>
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

On Tue, Jun 10, 2025 at 5:48=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> On 10/06/2025 at 23:05, Bartosz Golaszewski wrote:
> > On Tue, Jun 10, 2025 at 3:55=E2=80=AFPM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> >>
> >> On 10/06/2025 at 21:37, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> struct gpio_chip now has callbacks for setting line values that retur=
n
> >>> an integer, allowing to indicate failures. Convert the driver to usin=
g
> >>> them.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> This does not match the address with which you sent the patch: brgl@bg=
dev.pl
> >>
> >>> ---
> >>>  drivers/net/can/spi/mcp251x.c | 16 ++++++++++------
> >>>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp2=
51x.c
> >>> index ec5c64006a16f703bc816983765584c5f3ac76e8..7545497d14b46c6388f39=
76c2bf7b9a99e959c1e 100644
> >>> --- a/drivers/net/can/spi/mcp251x.c
> >>> +++ b/drivers/net/can/spi/mcp251x.c
> >>> @@ -530,8 +530,8 @@ static int mcp251x_gpio_get_multiple(struct gpio_=
chip *chip,
> >>>       return 0;
> >>>  }
> >>>
> >>> -static void mcp251x_gpio_set(struct gpio_chip *chip, unsigned int of=
fset,
> >>> -                          int value)
> >>> +static int mcp251x_gpio_set(struct gpio_chip *chip, unsigned int off=
set,
> >>> +                         int value)
> >>>  {
> >>>       struct mcp251x_priv *priv =3D gpiochip_get_data(chip);
> >>>       u8 mask, val;
> >>> @@ -545,9 +545,11 @@ static void mcp251x_gpio_set(struct gpio_chip *c=
hip, unsigned int offset,
> >>>
> >>>       priv->reg_bfpctrl &=3D ~mask;
> >>>       priv->reg_bfpctrl |=3D val;
> >>> +
> >>> +     return 0;
> >>
> >> mcp251x_gpio_set() calls mcp251x_write_bits() which calls mcp251x_spi_=
write()
> >> which can fail.
> >>
> >> For this change to really make sense, the return value of mcp251x_spi_=
write()
> >> should be propagated all the way around.
> >>
> >
> > I don't know this code so I followed the example of the rest of the
> > codebase where the result of this function is never checked - even in
> > functions that do return values. I didn't know the reason for this and
> > so didn't want to break anything as I have no means of testing it.
>
> The return value of mcp251x_spi_write() is used in mcp251x_hw_reset(). In=
 other
> locations, mcp251x_spi_write() is only used in functions which return voi=
d, so
> obviously, the return value is not checked.
>

Wait, after a second look GPIO callbacks (including those that return
a value like request()) use mcp251x_write_bits() which has no return
value. It probably should propagate what mcp251x_spi_write() returns
but that's material for a different series. The goal of this one is to
use the new setters treewide and drop the old ones from struct
gpio_chip.

Bart

