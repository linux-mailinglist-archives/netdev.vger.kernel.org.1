Return-Path: <netdev+bounces-71620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F08543BE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AA62845E0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F411CA9;
	Wed, 14 Feb 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN1yfqrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3131173A
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897858; cv=none; b=WLxMhja9Fr1IRMfZxjeI0K64W72INaYkfq7CoZZMPQxgfxZphqdz5yvKqQcOiEI+AN+VM877dv/ZCnihfPnWkuWKpdqjFnKCaLzA671qhBLK2QAvBbtqbym4Vnme/LJ5BL8kdkNiRzyed7zQatRV0HfFgpY3NudGCjakghGs7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897858; c=relaxed/simple;
	bh=oGgic3vnUOjdVhRrwzAue5deTTVv+g8YkD46l440lI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJT00kdwuzswV67STvmDj2VLtp7E4PTSqzj9hmNWKwauJ5t1/EwsDz1y/56YkFEm6W9yhTy/T1uHqRXzSmzrOQTPF2GrcIYjt0yDIiizHlA9iuTlpyCRKRBmDko3VMP3pNxl6U/pn6a7BoUfrp6ALuHrFcvysnif0+7pymMcw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eN1yfqrB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5369755276.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707897856; x=1708502656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCIHkt/RO66tMjTR/JKRcfY+u5vjPPcFqKDnWCtMpJI=;
        b=eN1yfqrBGkE4eybV6rdhh/QZGxaulnTO8S+ZrGaNKFqJpku5EOsmsDG+CMWhQt2DrT
         09vaPeWqFHl6PZcA2yG+QqOafhDFuaza5pV16Pushf0qDvmwvugyDgPfdSwvHY64bpbm
         20AeQL1bmt7G7VtHYoynYn6CYx9XhTUU5XzYUsB2BnLWohr/2mCs2GeRrUjVolXdZlv2
         MNgF9nCFmLyidfuRQXzscYkwgPWlYT5HXNCCuxXWnFrWNzFy3wAlySTZRglIp6Q0avw1
         GlfDxePCtbFcqGFGgXTcC8bazJCZtFC7xC466uJlz2dZlJH3r9onRnXDIw2xCkQ7OSHA
         2rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707897856; x=1708502656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCIHkt/RO66tMjTR/JKRcfY+u5vjPPcFqKDnWCtMpJI=;
        b=ND7nSVY5hZ7jMmkrO9JoCg79LYtKj8tL0cv9rQPikfgkuNGzBN4F0WII+mmOI6+76h
         /2U9kzM2iooAneM/Fkb06aXRN3Ql1zLeAa5OX8IYicyLvvUYp2F9B1h92t64shJT45XD
         kSbg5COFSbGNF1qGIboDLOZ8gTs4yz26Z8YFaUsLEmmc0Sun9BzyLWkL447bs3OoBb2T
         90mHJCj4aelSB9NBcpR9/QrEgTSQdMz3CDFBom89qxyCLQ09w1mHKubgGsUogEmhN5n+
         I9GE97OfDOHkXMizgVgxR/9dXmEJopkOjACjGL7y+es+7YkpfY+7LNrZ3I6uIgLgGc1z
         G+7g==
X-Forwarded-Encrypted: i=1; AJvYcCWj6EVt5G4PW4mSozOFpwD4cIESCXFw7dYl8Vd5MQ4iQSgJmbY/eBxvGXqIo2GrK6NAseBFl7nRF/fNNs59AJdhQx51MOpJ
X-Gm-Message-State: AOJu0YwafPqT5Kb8NECCEt6G9z2RJUiZmzUMS3GI7ZRMzy5G/kE4UwAG
	rXrmu/SdolVFlN7Za5CNZ2rIeAfyqgUzugPOF+3Ul/cZ4MBjiwf3jpR6zisZ9nZubAED/lld3+q
	vfm9DcZ4ze5HA5+Rq2P8/NkjgKZ+S0wRsg4A9Ig==
X-Google-Smtp-Source: AGHT+IGzNRpLA81W0hjnC7KJeTUQCzfe+celuZG951rB1y0PAGLvDF844F01g8batoU5C7Yy62cr58AJowvdFleB/Lk=
X-Received: by 2002:a25:c786:0:b0:dcd:3663:b5e5 with SMTP id
 w128-20020a25c786000000b00dcd3663b5e5mr1852459ybe.25.1707897855760; Wed, 14
 Feb 2024 00:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com> <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
In-Reply-To: <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 09:04:03 +0100
Message-ID: <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: support reset controller
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

thanks for your patch!

On Wed, Feb 14, 2024 at 1:54=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The 'reset-gpios' will not work when the switch reset is controlled by a
> reset controller.
>
> Although the reset is optional and the driver performs a soft reset
> during setup, if the initial reset state was asserted, the driver will
> not detect it.
>
> The reset controller will take precedence over the reset GPIO.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
(...)
> +void rtl83xx_reset_assert(struct realtek_priv *priv)
> +{
> +       int ret;
> +
> +       if (priv->reset_ctl) {
> +               ret =3D reset_control_assert(priv->reset_ctl);

Actually, reset_control_assert() is NULL-tolerand (as well as the
stubs) so you can just issue this unconditionally. If priv->reset_ctl
is NULL it will just return 0.

> +               if (!ret)
> +                       return;
> +
> +               dev_warn(priv->dev,
> +                        "Failed to assert the switch reset control: %pe\=
n",
> +                        ERR_PTR(ret));
> +       }
> +
> +       if (priv->reset)
> +               gpiod_set_value(priv->reset, true);

Same here! Also NULL-tolerant. You do not need to check priv->reset.
Just issue it.

> +void rtl83xx_reset_deassert(struct realtek_priv *priv)

Same comments for deassert.

With this fixed (the rest looks just fine):
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

