Return-Path: <netdev+bounces-98530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE138D1AEB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0EF1F23EB0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1050E16D324;
	Tue, 28 May 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+Gr6dzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A079F5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898666; cv=none; b=rWewepo3crqBHIQjiBiJ7ZP5jAajQsqxeVeGJy2ZN6K/lYKlVewZImIJhmi77FB3qk7Ow94wlGZ6BRjuMU8PayNWyVYdpQAyihdt6mMpV886vfo6+zW4DhqJHhnB5/sZ7k1g8uJKm2BFXxlyvqobjOS+UpcYxIVvnf9sggHY/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898666; c=relaxed/simple;
	bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNdxxEcq05+u8o5+hv2HrvlJ8NRE62o6SnSmlQXx9+9fh+oJWFLkDA8NYMlaiKQNpPx3l4bxf9hZ/be6RIEs55Ke18+0Bd+VyDWISLDOLMa8O643RlxFdypHiP0mxiW/TcU98iMMhVlVfGeSkP2jucEqyUgwtstO8V9fIeAsVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+Gr6dzq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df7c1a7d745so595876276.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716898663; x=1717503463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
        b=l+Gr6dzq/bhxV/uSJAjMJihPC4VabgY9kkj6okgApPO7VzWqctC1UEatWd71WkADy6
         djmWNOG0jKx80T280ePL4kQlazXZSiq5M7hxfVPbQna5SsVqpXM0ZVcWe9gm7P/5wnMC
         4v92C1Manb5o/a3G5EGJ1orQWin6np0anfo8BPHzim/a9KmrYLsRkJaqg+3MPsIvVY5+
         f77nlQodTqqdL17VZ+4V2dMakE+IW8dmXZeYM3BcUre5Rf/aTs1EVTXapGtnJX9qPori
         FlZ15hUPStDv5V1MesXTL9xVYjHT3R5ZzI2OX/xYw0XJ6xHwTEv87G9dB5t1fAc7EE38
         alRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898663; x=1717503463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI3B8JAnrwoddvWTVgBZJ1muYwpegH+idzo35ur6rg8=;
        b=BxsS3GZOTlfHvB5UAtmRmvQX5+RCbM6V1IGSfy7WT21EkhPhoQEP19cP/kREVGmw2E
         jsA1dH4Yt9cXavdnpx26RgZ2v6ZXj+4o/nQelp/wh8jPFq0CmSJ21wHro30ZC1DGexZg
         Um0w2NvqXLY+SDVq2XqveHMbomiUkWYHU/kr5ZuWge1yXgelm4MXzXjtaq+631WpCkZV
         8lIZBY2Bgzhs1h5vM754aauV1aVPXrWsJ4SBVpoFlWDeTwvshBM7QwquarZ39BUpMNl8
         PFBYrshAxFmt+2qQAX2bZ9lFqxW7lxurHJ7Ssnd7gO0Q+SKmZez2gWQqqOlgue+eAT4J
         +WOA==
X-Forwarded-Encrypted: i=1; AJvYcCUkur1PFnifLRzJq1t8Que2XjMUag9qSsx7JrHC02Tgo6krjkvRdI8oEW/EecvIBTIk/fKnmsJblGXEXVIJ57WMIZiF67S5
X-Gm-Message-State: AOJu0YwaLo379P0o63puwDjHvIU0DRlUTERSHVidQS3N4O0mCSeBIwvz
	zt0t4UOy5kaf89inikTFVNMTiEmk61skyRmtel96OUleKWYbzsTCh9KXcjo8yp3YMH4JiiBUYvx
	QoRnY5hkT6JF2E+EeB3R1Y4CwezNi4sQitf/22g==
X-Google-Smtp-Source: AGHT+IGvsFoMYbnYzlrb/IviX0m6kKqlmur3ghtnR8h0iN8Ytd3BwhIi9utxvp0TVkhi0U0AYD2Xq7u0TY+PDcGFpRA=
X-Received: by 2002:a25:8446:0:b0:df1:cdf5:d2c1 with SMTP id
 3f1490d57ef6-df770815db9mr8598857276.0.1716898662695; Tue, 28 May 2024
 05:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 14:17:31 +0200
Message-ID: <CACRpkdYsFBw907rH4pmgmA6R=0FsOac7-_2xzqP8vu=aVS5JJQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

The QCA driver in drivers/net/dsa/qca/* instead makes the feature
optional on LED class, so it is in a separate file with stubs if the
LED class is not selected.

Luiz do you wanna try this or should I make a patch like that?

Yours,
Linus Walleij

