Return-Path: <netdev+bounces-66539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8783FB03
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 00:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C69B28604C
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C426E33CD3;
	Sun, 28 Jan 2024 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK3sid+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A845BE2
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484885; cv=none; b=ZUg9Gv77p2VBjE0Kf6KfY2NSW4513DgKEBQzYhoTv46ijd8WJmddgGSvd79dt6pBW4o8jlks74gaUjZWTdgsSkwk139FqrNvkewAUuXgPyPuAkYKwvpqdaN4MerQpsURBKt+vi3qZ1n7gn3gVljFQNc+LLSsk1a1PHUix7brHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484885; c=relaxed/simple;
	bh=BOtMPPGW4LZAsLGaJKxi5+pj2MxZY0D1pKaGz93eytI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/VxGTaxWSmIeRcZEyw0q433vC8VwRnZzFfooNrCfp42Dut8W9P61dNOvSUUlvS9ikVsd5l0f2DrcYhT/+bKwQJVCI38Dvo0+MRoqV33LrmLPGQhXDJ64ijJsZjoL4iTg4tU5d9W18UL0FYkXnxrO5ZBfDx44hTLrt7pwWrMZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK3sid+D; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51028acdcf0so2474154e87.0
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 15:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706484882; x=1707089682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=br9Cq/1Hj8fLaDEyW7hXDwspiGoWYcfpUDfNL5AiopQ=;
        b=OK3sid+DpJTGu1+uMy1tR5FIDCsK+1gMroCTXQL5D/bQHSrAwQVHra+p56lvUK4OY7
         jGNL8aNoQQiFVtlY0tWh1X2n39gkSLFwgw2p+4rfD3qCnmlpJyEG0VevXiHrV5WoUU+C
         1MqWqNE01bZSWPGAy1DSp66FJ9qazZrsZDrW/b+ahyoIl2mKQ5+C53G+E9Oe8ZDBzGvN
         shjQdJghT/RDljSTwFA6LLvWAh999NYhe9SJaIKxKE3M6pLhxnYarzMR5qYDzmMP+F6B
         QZjCcKN9xGwb3OdNLpPyjBtmvkZZDs7RBiQ43lXIGRyi9mL6BzxRos86e+2Glo0OWZUu
         m+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484882; x=1707089682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=br9Cq/1Hj8fLaDEyW7hXDwspiGoWYcfpUDfNL5AiopQ=;
        b=UnZepHbhVCJvAfpRRhmaBmBzLvfC8zqTCSQYX5owQOcM3XIDfDq5leWnVc5QarMPhW
         oS8/xAzudjgf5cEjBSlBGBpV09Yc2EleHNBg/lxDDUfZ0vjoM8QXtYM1e5z8EUd8iZzd
         GIGm8cMCCKztmYT8rC0iwwekl+KoeMaAbcAXpZmbIKknMsiBFpYFK8yGzoQvbzHEce6r
         UukHYwhzzPuJeA3WUtv0ZlhBLm2ZOUxbuIdzNtHoja79hTfoZ2NIyKJltk+NkJv2rxaa
         rTVpy0XavGEydDCj7DkoFSn2JYXQBbtKXlaW4RTAVJ8VH03LQGaiXeE8m5SyoOK1uDB3
         YmFw==
X-Gm-Message-State: AOJu0Yzm/ZA/+oUDiqdx3ZmfVadqyV0Ozp6mkdKcrRuaXJhN9qxIuAVx
	O8W4KpyFqz+SiKAVSP8a/rgSG4YnlFErxYG/J8yXtenkIPElXzpfCbeakfocG0cLBb50bVue6gy
	zKDubpTOF0/t1LzCLJ08Y7exHQ/d7yIXiHmg=
X-Google-Smtp-Source: AGHT+IEu4w4CnnEBaXstVmkptLKP/kDEuHoVvHFnqD7Ogkl0izZH0M0GV6DiUodnPcqtfvnawQl46d10/z/OiE2OkCs=
X-Received: by 2002:a19:ca0a:0:b0:510:d29:cf57 with SMTP id
 a10-20020a19ca0a000000b005100d29cf57mr2371720lfg.33.1706484881550; Sun, 28
 Jan 2024 15:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-4-luizluca@gmail.com>
 <20240125102525.5kowvatb6rvb72m5@skbuf>
In-Reply-To: <20240125102525.5kowvatb6rvb72m5@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 28 Jan 2024 20:34:29 -0300
Message-ID: <CAJq09z4dOF4_XzKFRSP_ABoqN8y8ZXD1kOgxuL7TvC=8_M9Ojw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/11] net: dsa: realtek: convert variants
 into real drivers
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jan 23, 2024 at 06:55:55PM -0300, Luiz Angelo Daros de Luca wrote:
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index df214b2f60d1..22a63f41e3f2 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -249,8 +276,20 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
> >       if (priv->reset)
> >               gpiod_set_value(priv->reset, 1);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
> >
> > -static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> > +/**
> > + * realtek_mdio_shutdown() - Shutdown the driver of a MDIO-connected switch
> > + * @pdev: platform_device to probe on.
> > + *
> > + * This function should be used as the .shutdown in an mdio_driver. It shuts
> > + * down the DSA switch and cleans the platform driver data.
>
> , to prevent realtek_mdio_remove() from running afterwards, which is
> possible if the parent bus implements its own .shutdown() as .remove().

I didn't think that both could be called in sequence. I learned
something today. Thanks.

>
> > + *
> > + * Context: Any context.
> > + * Return: Nothing.
> > + *
> > + */
> > +void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
> >
> > @@ -521,8 +548,20 @@ static void realtek_smi_remove(struct platform_device *pdev)
> >       if (priv->reset)
> >               gpiod_set_value(priv->reset, 1);
> >  }
> > +EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
> >
> > -static void realtek_smi_shutdown(struct platform_device *pdev)
> > +/**
> > + * realtek_smi_shutdown() - Shutdown the driver of a SMI-connected switch
> > + * @pdev: platform_device to probe on.
> > + *
> > + * This function should be used as the .shutdown in a platform_driver. It shuts
> > + * down the DSA switch and cleans the platform driver data.
>
> Likewise.
>
> > + *
> > + * Context: Any context.
> > + * Return: Nothing.
> > + *
>
> I'm not sure if the blank line at the end of the comment is necessary.

I'll remove them.

Regards,

Luiz

