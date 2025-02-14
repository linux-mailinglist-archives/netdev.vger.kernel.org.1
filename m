Return-Path: <netdev+bounces-166353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E48EA35A1F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF43AB4F4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E72309B3;
	Fri, 14 Feb 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxLoVUKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1C1E502
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524967; cv=none; b=Anvy8e1vSVVMc+X112gzbLNujEZYm+agc4uxKrv4btJMUogffb0huqPNBOiNHB+7pF7kaE+gQdYLCNt/ILOaMd6XjjK0ubodunG62gOrl4zePhGGBOK/r8giwyzqVEtAa2YJSBuBLjMNg9eENOcHUAJ+jRaMIbWickrXyXKpUDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524967; c=relaxed/simple;
	bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxcOawziJ/m75j+B62j6fWQWX+QaqHJ0FOtOS5h0bMTBmefbCAIWFIGIUhRSCXYXbLDNxLUIK+KY03x5D0ujYT5FqzrsL6bBezjH+gK2TpMCIP75D8XGfN0E+WeDWlLYC2WyNY29spxtLvbddk4OttZFPPH+e4k3nAuZXRHJtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxLoVUKX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5450f2959f7so1810439e87.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524964; x=1740129764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
        b=sxLoVUKXY3c9adxLBukNyoU8KOeprTw/VgAZfAUNhRUEovcbN6eRmMWti80c++buGs
         8rJEgUTWjQ0qY7N+qW2ddYzlThcXQ17FCv58hHDtgtjiP7iM/ASj1Y8L8KnHr2x0Sk++
         yx/EvvweXcgD+SP+daaEUIXAvGoymPrcgszaF+qcoaqEspVLtNsrDIEVUe+8f22mqM7Y
         HzP8AInZXEcunT+OX9UTtn40R1jgmlz+RhyXvyT14nGpttrw5ILZ/DieEXYHmbL1ra96
         R0IpGhJMsKgik8AES1m31K8ylU5CNce9Z+Atmc2pZbsfZwDAC9s5xDU2IKtcIJwQGdTX
         iz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524964; x=1740129764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxMUts7eWUQNpSiCjwqXyusGkP80n8S1cBGWOAZkDbI=;
        b=p0Z+62G5+BvRxesE4EqyMAh2RpGt0FRnDREfoxHUexZerFsrxFuEdt1gHruJ+JBHpU
         SuPaQ8qsor0uhUF8aqn3FtvUSYKdAehMIHiHOVrhq8vSdq01PqEGR1HbLS7jtnMPSbPX
         mr5fXdaUBIJpo+aTH+3AA61ubCmMsw4wDxkCDQHuh/VkZNG8hPeemK1e9OA+j1sLIE6E
         tyrE6Pj5rxhgrneyjsExMgv3zAN4Yqo9nAlyshSRo8gFxFGbu5r1Mhprt7qzLiV4oEXL
         n91uZ7dXzoILZTosAQhIUksJhpUS7/qynEZIhJ232qZwD6rK7flPpH2eufkcZ0rPo+ja
         NXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxoT1U5YSUS1kI0H9dXEcCLRZ4iJRoL5q5FqNXtXODENYpyFfrv0LwPjIjrhpd+tVUCRNlVW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKXltX1bLLTAlNbRvrGafwT+W0T+4mVBOtdU1d50EYZ81N+iv
	ibuQgN2I1RO2ptcqMqKaVH3SpiQ2P3+E78yodazu5zIO1vV/RqQ6pN3v7+scRi5yLqmk7zFLXxe
	QaYAkGYltGKUUz7HbedlO0THn6XIFJFP6LcVtSw==
X-Gm-Gg: ASbGncsoceZvBKXQDA7Y+XWjbCS1u/QS9Icg23lWI5SRRm/OMIZ5HuCDhaAjLrZ6gn7
	gmzWPzI2HjGodP8IXw5tCJCGs7p0zHKgEeJvrr8fViMsPdAq9Qj1kmO8fDq1yRuT0h3P7HEC5
X-Google-Smtp-Source: AGHT+IGhgPoczR2D2T/lX4ZwT5MXW34OlqN0/zugo7LmPWwgdRCMXTLpmWVB2HL50zhjB2U06JaZCumERKR34vwpUjQ=
X-Received: by 2002:a05:6512:a90:b0:545:d72:95e5 with SMTP id
 2adb3069b0e04-5451dd8c4aemr2339063e87.7.1739524963708; Fri, 14 Feb 2025
 01:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com> <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
In-Reply-To: <20250210-gpio-set-array-helper-v3-1-d6a673674da8@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:22:32 +0100
X-Gm-Features: AWEUYZlSujurAxnS1uFvnjJLAGMoYJmFWbRh7MCeJl2DAGBRy4U6U-3ZBycEwbU
Message-ID: <CACRpkdY2PtRhmTKJUFmkTViQOLfMBbqR1bD94SzasoGAoHUQcQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] gpiolib: add gpiod_multi_set_value_cansleep()
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

On Mon, Feb 10, 2025 at 11:37=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:

> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
> parameters than gpiod_set_array_value_cansleep().
>
> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> cases, the first arguments all come from the same struct gpio_descs, so
> having a separate function where we can just pass that cuts down on the
> boilerplate.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

