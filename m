Return-Path: <netdev+bounces-163905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A26A2BFDA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12B2188C66B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63781DDC20;
	Fri,  7 Feb 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDS6RUdi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD021CDFCC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921687; cv=none; b=XksEKAoXcxEXULcwYSRg2AQJLJiglQzNiAKNbL+AHvXLd7fEjTaw8g5a2Ncq2+J5JXnaL9YlnStRrcpfVR8lVvR3EKXURH/ih7oeYGSI/ln+8RzKYeeSf6ZnrtYFx/DwwcCs1LVPzfvK9vrp5jSyx/s6elL8AznSNnLTsXtrb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921687; c=relaxed/simple;
	bh=ZJAYWDeAfSNuuTW5xNrl9dA60NGzl85UUJgwVt7HSzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNSJ71Ynyq0Dfir7/43DDSJ4Au0bOeWz6k5O/noqf8IlvcJlrTIqDcKSWmKEwGxlgxfI68o6rwHbp793ClnoTs8M7On7HuVL1wFPvmxB1rcwPtmzR2nNITc16wzPPc01FLzTWQBtut9OTAIAsmdL7hHRBI8ubFYMdStTVrEfzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDS6RUdi; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5b41ee3065so1100696276.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738921685; x=1739526485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEK7srIgXJXdQr67Fg7HQYgRLAiGEeTLhNAT3vGh0e4=;
        b=dDS6RUdiZkhCUqYAb567tHe2IW/8MVvCp5yAg0oxx6pnukToYgIij69AsaZVulTRD0
         JxTTi8f3RG4lfK8Xir1jIZNXL4SQOTUhsvxb3Qr/VLk26CXxCiibiyglBKdTgDOJ5pU/
         k/2jL6b4nYtTkEknQqbnJwTgJ4HVLObIjGyY0y2raJY7IZfJJfKkv1brRx9FuGcJqHjT
         fZoeHlxe1AEoBPX1Kf85fyAo7cUlrK9Vqp2MN3DGj0rXIU/kX/xHczbdjkcs41NafjZS
         T27wqhu6CwtDrB3cjR76rPen62FO6HJgEvOSjpNhjvzPpS7JTJfM24DsuNvnYIHKj+5b
         vHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738921685; x=1739526485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEK7srIgXJXdQr67Fg7HQYgRLAiGEeTLhNAT3vGh0e4=;
        b=ovsx2MMrgpmvdi5CrqpcB+KFNmOIosq1j73EDgd6lgDaETlrQlt2VRtHi2ao56uk0A
         kdoIcy4rRY2Wok5CJAOg5wWD1BAXSfawOaC8JcSxjtdGKgDTMtCOw07ktRzrPIjIGI7p
         7uaX0HtV4T9+hJVdZ/MKSbzrZ5JFUBRpQbFX7rFjhmg7HKS+8fCqjRRAOKZz0aDYvxUN
         rIPOJnAxMezfa8dPIv8vS4G1TkOgGG/1SLVB2SrNl10rFXc3BmEvXhCKwOFhYXA38Thu
         wmW7rmuRHbanPDMLuP78PrKqwr7nOB3qund6Z/qnv8IvfTCiVZJzNHjqxgBGj04gGWdk
         49kw==
X-Forwarded-Encrypted: i=1; AJvYcCWz5vZP0Sth/q8gtjhBMAHRHakM0sGHGiKZwnT8ZfO8xgwAghfnyRx5nEvd2DW/mNjPIKriYZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+HkUZ/ilMKuLr+N40jgBHHzq1xqI8hHke1e1wyUz+9PTX5gj
	FnXuO0MV9mXmWNJTKNFhNuLKZ+dyIbPjPQ1Stl3BAQDZtyk/1Kr5qJpUzIw9cB/Khs3aayJWVDo
	mZS34RhYqaRpT4ypTMHspoa0EX9vYbBxJzakw4Q==
X-Gm-Gg: ASbGnctcFKM4z+EDh9LKNq1CWa1duYoUox22Ryo+Pz1fO+1TZG0d7qxXwup7TdNbUpq
	QibuHozoUTFL8ZIhaN1ZgY9uXdbQUFgmVVTp30gLgOH28f+cCflj+PbrzfA20OdpK3cF6H8YREg
	==
X-Google-Smtp-Source: AGHT+IGaJbQYks+y9NqxM+qNlDYUH78x9F5VX2tG1O9YPe70PH5B1lWBp0wyp4yxEx4N6batSHVUPkLgj4MGDriydyE=
X-Received: by 2002:a05:690c:6810:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6f9b2a07006mr20703297b3.33.1738921684631; Fri, 07 Feb 2025
 01:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf9WQjVXvea7tHx0MJG2H8Yqxw=zGqvjp7dfD7+=huDKw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Feb 2025 10:47:28 +0100
X-Gm-Features: AWEUYZnfTmLhFuLgJjE2ppjqoqNxz5h92L1nmRlGKxGgOfCbaSg6_8WxaR2gtUA
Message-ID: <CAPDyKFoNuXpTEm1rLPvAgib+ugqr7XyETZhfrNr6ypOOKRwjXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] gpiolib: add gpiod_multi_set_value_cansleep
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Feb 2025 at 08:49, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Feb 6, 2025 at 11:48=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > This series was inspired by some minor annoyance I have experienced a
> > few times in recent reviews.
> >
> > Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> > having so many parameters. In most cases, we already have a struct
> > gpio_descs that contains the first 3 parameters so we end up with 3 (or
> > often even 6) pointer indirections at each call site. Also, people have
> > a tendency to want to hard-code the first argument instead of using
> > struct gpio_descs.ndescs, often without checking that ndescs >=3D the
> > hard-coded value.
> >
> > So I'm proposing that we add a gpiod_multi_set_value_cansleep()
> > function that is a wrapper around gpiod_set_array_value_cansleep()
> > that has struct gpio_descs as the first parameter to make it a bit
> > easier to read the code and avoid the hard-coding temptation.
> >
> > I've just done gpiod_multi_set_value_cansleep() for now since there
> > were over 10 callers of this one. There aren't as many callers of
> > the get and atomic variants, but we can add those too if this seems
> > like a useful thing to do.
> >
> > Maintainers, if you prefer to have this go through the gpio tree, pleas=
e
> > give your Acked-by:, otherwise I will resend what is left after the nex=
t
> > kernel release.
> >
> > ---
> > Changes in v2:
> > - Renamed new function from gpiods_multi_set_value_cansleep() to
> >   gpiod_multi_set_value_cansleep()
> > - Fixed typo in name of replaced function in all commit messages.
> > - Picked up trailers.
> > - Link to v1: https://lore.kernel.org/r/20250131-gpio-set-array-helper-=
v1-0-991c8ccb4d6e@baylibre.com
> >
> > ---
> > David Lechner (13):
> >       gpiolib: add gpiod_multi_set_value_cansleep()
> >       auxdisplay: seg-led-gpio: use gpiod_multi_set_value_cansleep
> >       bus: ts-nbus: validate ts,data-gpios array size
> >       bus: ts-nbus: use gpiod_multi_set_value_cansleep
> >       gpio: max3191x: use gpiod_multi_set_value_cansleep
> >       iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> >       iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
> >       iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> >       mmc: pwrseq_simple: use gpiod_multi_set_value_cansleep
> >       mux: gpio: use gpiod_multi_set_value_cansleep
> >       net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep
> >       phy: mapphone-mdm6600: use gpiod_multi_set_value_cansleep
> >       ASoC: adau1701: use gpiod_multi_set_value_cansleep
> >
> >  drivers/auxdisplay/seg-led-gpio.c           |  3 +--
> >  drivers/bus/ts-nbus.c                       | 10 ++++++----
> >  drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
> >  drivers/iio/adc/ad7606.c                    |  3 +--
> >  drivers/iio/adc/ad7606_spi.c                |  3 +--
> >  drivers/iio/amplifiers/hmc425a.c            |  3 +--
> >  drivers/iio/resolver/ad2s1210.c             |  8 ++------
> >  drivers/mmc/core/pwrseq_simple.c            |  3 +--
> >  drivers/mux/gpio.c                          |  4 +---
> >  drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
> >  drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
> >  include/linux/gpio/consumer.h               |  7 +++++++
> >  sound/soc/codecs/adau1701.c                 |  4 +---
> >  13 files changed, 31 insertions(+), 42 deletions(-)
> > ---
> > base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> > change-id: 20250131-gpio-set-array-helper-bd4a328370d3
> >
> > Best regards,
> > --
> > David Lechner <dlechner@baylibre.com>
> >
>
> I can provide an immutable branch for the entire series for everyone
> to pull or I can apply patch one, provide an immutable branch and
> every subsystem can take their respective patches. What do you prefer?

The changes look small and trivial to me. I wouldn't mind if you take
them all (at least for mmc). An immutable branch would be good, if it
turns out that we need to pull them.

Kind regards
Uffe

