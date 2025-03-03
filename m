Return-Path: <netdev+bounces-171381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707EA4CC5A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAB189660B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44089230277;
	Mon,  3 Mar 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgesB6zs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478701F0E44
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032054; cv=none; b=n3GwOFD4PKH4NbRN3z/VScVLyBNYCP7cXW8HdbYxuvcVheYWte7SJ1lLS7GciVW0mb+9IyRi1OYMeGWLSILYldEJYUj+e4bEJmYp4eRtmAkjR9wE4GJbAD5IkL++nDZMi8UAANVr1Qp6eDlw3HhcAFMxDTS6+oiFuDTtdqXcniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032054; c=relaxed/simple;
	bh=XbbJ8meiSGyYH6OwHoQ3kYQ9Z6S5UvDDWGLBxmPvAmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idjooaA/7onc3yKyOffIt+09zSabOByv6zeMGWEHXGZ4G3tcHgeLpDicjXHh0qfesog28hqjuNYq8EzHUBOiEVYiB8pLzkR1vev8mLIPAc81rnXZyXlCT1lO6q0tUIshXokGNfPqP3fBeqf9mysn1G3RuQhRxM+eTOhlsHBp2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgesB6zs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30ba563a6d1so24482071fa.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741032050; x=1741636850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIobnHJoMiJmgICmS6BIagkd52MyMq9ZRNlSypEhZx0=;
        b=wgesB6zsl2c/nwp8YgLBRW5EjpfK/i+/RPYBkc+A+ql8EZ5Ey60K3jXEUFjSGRB6Ly
         E3rbk4Ge7WK+ZPWogj2I1uaZMQyLPMhY5rukyPNsq/k3Cq7skj9fuBSCok2sxNLTpBg/
         gqPN7FvyK6oB74ac/Ve/iyerB69btpnLFgaLE0DwXMC45DlmuazcljMwukgd/Ungqd5O
         gTms5km3lurkHibIQjsEaVIyIN5QCxGJgfEHpzB2NiqJfUElYXoDH0ctpytY8Vm4UYqj
         iWbsZhdhuuW2LSvkuftVKTKtrWL4arKr1eVIt8Jy+ueeCnfPDLv6D4/NzHSMtAbs2ii6
         hPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032050; x=1741636850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIobnHJoMiJmgICmS6BIagkd52MyMq9ZRNlSypEhZx0=;
        b=DSYrAJiRhqy65FDJ78UrMBzKS+kWlVOjC36fD4iA08wz0mEZKgHI/K5jz46X2S8vkp
         fx/qfHrTAbA0JUF8T7xpgs6zJ0xVYYzY1ee6N0bHMxScMsnRK6X3VkJGPgdiCRJml6Cn
         uKFtP77HGJy69W856GPMIRGnMsiDoK5AA9EuCscFzzzXwqSS44zVg0LF9eRnqM25XYLr
         fEVz5KHsQ6ZwXPOp6g0STkE3Wp8FvFZe+GsgQJROs5f+tzvEZEWQDGfgXL9RSpVQS+4g
         45rwChepOwOctR0d/CFP68JvF9EVcl6pART86nGrSrSX82ImPo3Iyj29GDSbwaBfUCHr
         bQHg==
X-Forwarded-Encrypted: i=1; AJvYcCXyb5W56DaeweGTkXKAlYpklUaU0T9L3SG6dI6wWhDeApbjbWlSsH2bfSacHZ/BJRnuX+yNdqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3wPoR14NibVh+rb2awSnIvOT9uBGvuDgfgN5KVZE4McWE625
	bbx+I2kCiTjLLzMEXJbtHqjREzTJNyUlPz7gmMmBGwfzwFb+S1yTb28/a3F+KW5sB2V2/+pIT/s
	WTpY6oZDEQUffE/nM5l/wOaj4KPXtyhUMWdnovw==
X-Gm-Gg: ASbGncughSRB2/W0aP2wrWgz5UpnHx+YjDM1OlNNOSg+F5ChexWh2GGYaG2wZoGshKr
	cnEwwAuSMD8rgQ7/sbD0P1BJMFRa5IKPyIcH+Xy5cHUX0wt5XyLY+M5kcAMXY0IHPn3gTTJ2g9K
	NbYV5tPqN0tYfWnazfk/WnYiGYlw==
X-Google-Smtp-Source: AGHT+IEHC8551GBjOPpUxphatF0L4EWvTZV1kdNfG9x3/0VKhOjGpHpEdRbBRyV3NGrevE8NCqhrlfkAk7EBNemkkKU=
X-Received: by 2002:a05:6512:31c6:b0:549:39d8:51e1 with SMTP id
 2adb3069b0e04-549756e259cmr181874e87.16.1741032050322; Mon, 03 Mar 2025
 12:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303164928.1466246-1-andriy.shevchenko@linux.intel.com> <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303164928.1466246-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Mar 2025 21:00:39 +0100
X-Gm-Features: AQ5f1JqhI495QPwjnNSA_U0-FZLtnDrmj_TbAAs84iyjJp_ZDYFgar6ptgKX_Fk
Message-ID: <CACRpkdbCfhqRGOGrCgP-e3AnK_tmHX+eUpZKjitbfemzAXCcWg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] ieee802154: ca8210: Switch to using gpiod API
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This updates the driver to gpiod API, and removes yet another use of
> of_get_named_gpio().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

But note:

> @@ -632,10 +630,10 @@ static void ca8210_reset_send(struct spi_device *sp=
i, unsigned int ms)
>         struct ca8210_priv *priv =3D spi_get_drvdata(spi);
>         long status;
>
> -       gpio_set_value(pdata->gpio_reset, 0);
> +       gpiod_set_value(pdata->reset_gpio, 0);
>         reinit_completion(&priv->ca8210_is_awake);
>         msleep(ms);
> -       gpio_set_value(pdata->gpio_reset, 1);
> +       gpiod_set_value(pdata->reset_gpio, 1);

This drives the GPIO low to assert reset, meaning it is something
that should have GPIO_ACTIVE_LOW set in the device tree,
and it might even have, so let's check what we can check:

git grep cascoda,ca8210
Documentation/devicetree/bindings/net/ieee802154/ca8210.txt:    -
compatible:           Should be "cascoda,ca8210"
Documentation/devicetree/bindings/net/ieee802154/ca8210.txt:
 compatible =3D "cascoda,ca8210";
drivers/net/ieee802154/ca8210.c:        {.compatible =3D "cascoda,ca8210", =
},

well ain't that typical, all users are out of tree. The example
in the bindings file is wrong, setting ACTIVE_HIGH. Sigh, let's
assume all those DTS files somewhere are wrong and they
didn't set GPIO_ACTIVE_LOW in them...

Maybe add a comment in the code that this is wrong and the
driver and DTS files should be fixed.

Alternatively patch Documentation/devicetree/bindings/net/ieee802154/ca8210=
.txt
to set GPIO_ACTIVE_LOW and fix the code to invert it both
here and when getting the GPIO, but it could cause problems
for outoftree users.

Either way, this is good progress:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

