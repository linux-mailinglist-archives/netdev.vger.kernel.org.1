Return-Path: <netdev+bounces-161902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00BA24848
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 11:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6283A15E7
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 10:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482F1547C6;
	Sat,  1 Feb 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B3TxkcdW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC041537A8
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738406185; cv=none; b=dcpNDLMLwo1RSxKZ1CYbFYdtwC3so4X0akvzC55PnIIn9snzNMUyLiUXK9Zk130hOwVHgqT0jzAElvQwOYlcIelUyYcKVHBtj3fXw8S60P5H2gYqAf/SW0N2AmDArP+aJ+4DVHxOE0xV4Feq+xUS0Txo4QIG0f7aEJDiytj/Er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738406185; c=relaxed/simple;
	bh=iqw5RHSV8S70QoypLHZQ6Q5vg7hJQNF5r+oQH6qoIxU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVAXbdWgOcM0lKLUDXptZCcs69FdRWpBYdsxpbQqFTNfTsPjCoTGiwHHUyQ2O7+IgN2NUTy1HoA8wvDKotPxWxqGh68kTwjsWGmnzK23RQyuZYDKs/d06/HlAdSur2HA0y5xYvUHgMKeAaJJ/p0blcxYXchejFprAgpA3ZBAqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B3TxkcdW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30761be8fa8so26523671fa.2
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 02:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738406182; x=1739010982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDdRJ+I4mzWc8IF8+OQqo1T57d81vrjPzSqlTDqBnks=;
        b=B3TxkcdWKwGPBOebL9pA5bUQHLxQuAutZ9kfu1oWUILNs1QWrlQXhOyuzxUr0gh/eJ
         SJ63Wv/UJwk1Ps/NEArGZHSuscrrZS4vKqLe1fCpUrqsnfWrXZOTxh/Dh+hxUOl86YyK
         7ZgXgGo0ACYpgHJwUeKltsykq5LC0yK0DSO+z4y26SgYhQzgKYU8MBxVekRvZ0NImO5v
         CghEyVL8L+nUWr9eq8FaxlbOfp9FQLnoN4hNgeVRnJC6EG/Wixrbxe37hOPAgyCMjxaH
         TrI0p8Wgd8C0VN6xGZY+b1Ou2WNfyyS6UAhbR5narGWCYbrCFHblg0vcpe87QjXaXVHL
         mXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738406182; x=1739010982;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDdRJ+I4mzWc8IF8+OQqo1T57d81vrjPzSqlTDqBnks=;
        b=gDCy/7aL4wN+kBAhYGzP+3cvVGwMVastNKjYH56xFew1IcfRBkAII9km6wtrpsyPSn
         L62gBJedmlsOGs8iukiamlZWqS8labh/Wr39eGCZuuBwJRhFUzsRyIbnR8dikmZl3c8b
         mCUvh1rur7jyk7tjwzZ7oAXy5aGgI2ica19ei4SGdiW+tNuxVkNxbsIbShXjcz47dEbW
         0jGG3xnQ+KfQFx1eFQoeRV48XLUGhCcRe4JDosEQLrQ7uCJ20aD5SjppVPziGQ30T/jB
         6LNBWC8vcLIURsHVNCJJxxDs4u2fiHC2ItncZ+0M3Vn3iuVJYVpegPM1sk+QZqI7W9pJ
         oHSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMss8e/jRM8UkkkTEqui8CpDdloNxmk/MbNZHX7w3NETN8DzEU7DYrttozxBzDLZCCY/xx2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6ccgGs12JZqwByKTvO5HGua0TcdFumidjfOUbJh848/N5aRL
	j8sNg9WHC00hFwJoiBUiqkRiUKMA9fuYbrO9Vv8Yc1F8C0fJzKQntPOjload7G3lpGJZK5VRcxX
	+XIAoUaUlVCVK22Q9ycMPSdVOiCk5DKdHa9kKew==
X-Gm-Gg: ASbGnctJmpmoast315U+35JGK+2hjbRLsXXXistWkntoG8yrIjVJXVASpfr2OV16G8L
	feEyj3Y2zxSSLoPRiPtPzSt/yfBSx3JiQpOA5/rs7Luk2Q6coJG1Ts3Lh8Udot7Hl94vtL8Ic
X-Google-Smtp-Source: AGHT+IG/TVS8htf084OR17kIjfzG2VfKKdd+Zm7iyJX53veJ+z8OFO/m1mmCuR205oUFZ0hgVzWPIgYd5gwR9N1dJcc=
X-Received: by 2002:a05:651c:2116:b0:2ff:d044:61fc with SMTP id
 38308e7fff4ca-3079690e02amr50683871fa.33.1738406181352; Sat, 01 Feb 2025
 02:36:21 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 1 Feb 2025 02:36:20 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 1 Feb 2025 02:36:20 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
Date: Sat, 1 Feb 2025 02:36:20 -0800
X-Gm-Features: AWEUYZlUDyMyvD5QqatzuRcJ92GC2-lApzNfXLMZZCZq3wVbhWt8z_DF3wi7h90
Message-ID: <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 21:24:40 +0100, David Lechner <dlechner@baylibre.com> said:
> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
>
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >= the
> hard-coded value.
>
> So I'm proposing that we add a gpiods_set_array_value_cansleep()
> function that is a wrapper around gpiod_set_array_value_cansleep()
> that has struct gpio_descs as the first parameter to make it a bit
> easier to read the code and avoid the hard-coding temptation.
>
> I've just done gpiods_set_array_value_cansleep() for now since there
> were over 10 callers of this one. There aren't as many callers of
> the get and atomic variants, but we can add those too if this seems
> like a useful thing to do.
>
> ---
> David Lechner (13):
>       gpiolib: add gpiods_set_array_value_cansleep()
>       auxdisplay: seg-led-gpio: use gpiods_set_array_value_cansleep
>       bus: ts-nbus: validate ts,data-gpios array size
>       bus: ts-nbus: use gpiods_set_array_value_cansleep
>       gpio: max3191x: use gpiods_set_array_value_cansleep
>       iio: adc: ad7606: use gpiods_set_array_value_cansleep
>       iio: amplifiers: hmc425a: use gpiods_set_array_value_cansleep
>       iio: resolver: ad2s1210: use gpiods_set_array_value_cansleep
>       mmc: pwrseq_simple: use gpiods_set_array_value_cansleep
>       mux: gpio: use gpiods_set_array_value_cansleep
>       net: mdio: mux-gpio: use gpiods_set_array_value_cansleep
>       phy: mapphone-mdm6600: use gpiods_set_array_value_cansleep
>       ASoC: adau1701: use gpiods_set_array_value_cansleep
>
>  drivers/auxdisplay/seg-led-gpio.c           |  3 +--
>  drivers/bus/ts-nbus.c                       | 10 ++++++----
>  drivers/gpio/gpio-max3191x.c                | 18 +++++++-----------
>  drivers/iio/adc/ad7606.c                    |  3 +--
>  drivers/iio/adc/ad7606_spi.c                |  3 +--
>  drivers/iio/amplifiers/hmc425a.c            |  3 +--
>  drivers/iio/resolver/ad2s1210.c             |  8 ++------
>  drivers/mmc/core/pwrseq_simple.c            |  3 +--
>  drivers/mux/gpio.c                          |  4 +---
>  drivers/net/mdio/mdio-mux-gpio.c            |  3 +--
>  drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +---
>  include/linux/gpio/consumer.h               |  7 +++++++
>  sound/soc/codecs/adau1701.c                 |  4 +---
>  13 files changed, 31 insertions(+), 42 deletions(-)
> ---
> base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
> change-id: 20250131-gpio-set-array-helper-bd4a328370d3
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>
>

This looks good to me except for one thing: the function prefix. I would
really appreciate it if we could stay within the existing gpiod_ namespace and
not add a new one in the form of gpiods_.

Maybe: gpiod_multiple_set_ or gpiod_collected_set...?

Bartosz

