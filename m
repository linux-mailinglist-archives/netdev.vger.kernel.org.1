Return-Path: <netdev+bounces-161872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA7A24557
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 23:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737E918849FC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB41ADFFE;
	Fri, 31 Jan 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZD5N+cS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38211684B4
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363568; cv=none; b=kFluSAuxXe5V7tBTgBw86nisJNcJ9uj57wrrc/8YtpZpAwpq7g6fXCZuf3EWEYGt4Jm22/AnRLXR/JOU2rjPLuCnZHpM5l4/Tx3QfbBYM8y0R8sOZZOR5pLBRMybAr6ywOtkTmAFDDI6jaAumcsA2xakFDUpIA2ZtB4xUgTLfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363568; c=relaxed/simple;
	bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh+W3dpn+3D9Yy2JsKnR39E+oUSyISNsmhGT16jV2zt5SbYlbbKp0zhsuaBRbYgp1DDEmFofQ53t61kM3lq7q3zapHqO8CUL1Dy/mMcjPPCXjlb8PXDSiLAAH1xTZr7iZTUpBGgu/9NyDNGozGpmpEgVoWrQtCRND6DV2dHdrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZD5N+cS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307325f2436so25381531fa.0
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 14:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738363565; x=1738968365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
        b=NZD5N+cSwgVpbp4uBKSqg9Ag0t7Oh4RA/lD0W3UwbFHWlduW2tIowWiv6HwJBhUViu
         xSuh4Kje+bigOiOnBVSWZDT9VJXlhLagMHAUEt3NEfB0hwA9nNvX8kSTyeMTKHxw9yfj
         2rGKONg+p1SpUW6udf14oHRIPfnrGXTD8eYwEzaZaiDCgXJZzTH743+hl0zqAVEXITbx
         R/56S+Sv2LB9ARZKAfSI+pU+Zz2QkHjOEGj1XrtamsQO7VLQbPmaZ27VBJFl/uBnoSWA
         u5IMRUwQcuazoVgnlNRV3UBcRy6Z1bB71Y+sxxmOty/Foo4vtnmr2VEsq5IGcAyjRxJ4
         hw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738363565; x=1738968365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV9hhrVRP+qzrleYSIWXpKoYEuxlmibMFIbjPlpYr2A=;
        b=hBJKm2Yv4yMYjau2gbIMmyOBXbyUhItuuhdPGJa+z1KRXJKz3qZheGtXnK4V7xezXt
         DMPSXi8xym2HqJSjapxIkJ0EQKW3OjthhmWl89I3UcOAyM4Bldo24py1Q9tUSLMfFetg
         AA3UDlKJHcqNYwFL8/Oicx+MxOmBNT51mO8r8N3QXbhrIUsCmprLahuyqYDXHaYNwEQg
         iA20ssPo2/dm0xhhe/MvT01pxBImLS2p7JYg76OKmSve/iufZ4/96rN+4axyMQJvW292
         m4kpERsdS3G0aFipcKbLesDkKNi9fodGq7mJ2LRnsjYbMeCJM5aW0yktrS99SvKlkGjh
         RPRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWV+HAKXMmBSX2e39vEE9ONSFz19BIbMvVHh9Ere2azZ4rN7pWCafLblNbuTMeDCOf6vBJzuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMOUAM4I5e+ZJUsqQjFmWEXsCI9zUIWBxY8A7L+LL23Zy4OYv
	qUXrKrcyXuDQXeKpS0Xm8nv30CHhBumJN+q97W/lrfKcGTk7fOMx4y6JnMkRiSFgNXjYleWJvS7
	RcF1c5uCrym7sJcHG12FFfYp648nPNp/fDS4z1w==
X-Gm-Gg: ASbGnctEL6CHWao+17AqfHCTfE08Es9uKCRm8pmsBpImviAYu0YX7RKdSEOGLDAl+7/
	q7TCJUUVQY4Y0VOVhYMn6eq5j5YN+w1EdJonX34hoLseTJi+9LTgOIwHTUWex2y2qn4/LnWI=
X-Google-Smtp-Source: AGHT+IHHYjxVhba4NRZORQamjtU7NeuHHIHelxxj9O/XIYBIqNCjtNKWK69c7J1JA7YkTDGQPCWMRncUBp/ITQdEaIo=
X-Received: by 2002:a05:651c:897:b0:300:1c9a:80ce with SMTP id
 38308e7fff4ca-307968e0098mr51916141fa.33.1738363564658; Fri, 31 Jan 2025
 14:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
In-Reply-To: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 31 Jan 2025 23:45:53 +0100
X-Gm-Features: AWEUYZk_dyG4cveXgq-R2QdDjI5W5xxfEw1ByFh9vnHwzlCQYvkaIUdRlN711z4
Message-ID: <CACRpkdads3+XQqvZDJXmYHDLGfRK0H_S==72uqkuht2nEX1+rQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
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

Hi David,

On Fri, Jan 31, 2025 at 9:24=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:

> This series was inspired by some minor annoyance I have experienced a
> few times in recent reviews.
>
> Calling gpiod_set_array_value_cansleep() can be quite verbose due to
> having so many parameters. In most cases, we already have a struct
> gpio_descs that contains the first 3 parameters so we end up with 3 (or
> often even 6) pointer indirections at each call site. Also, people have
> a tendency to want to hard-code the first argument instead of using
> struct gpio_descs.ndescs, often without checking that ndescs >=3D the
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

I like it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

for the series.

Yours,
Linus Walleij

