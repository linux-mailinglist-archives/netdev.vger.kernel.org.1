Return-Path: <netdev+bounces-66557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4083FC0F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 03:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F101C20A27
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD60DF4E;
	Mon, 29 Jan 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXflIre9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06652FBF7
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494360; cv=none; b=dBQehD+IzXeILnP2VJD6WkWw+XWs/+ZVNzIe8hfroOGIlvpYPeAEn1xE88fsXEGyyTFacQii9S19V11LYAyk6VvchCqzlbUak4FzF+Bw1uwJL+l+Y7kKPJSFuath5U6xkNHcUNHnXYzLoOx7xk27TH22KNtwNw3IpQDs/LkLnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494360; c=relaxed/simple;
	bh=xeEhAdCYv/vw910HzL7gUjxl0q53lPHKaiI7FYBHqDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBV0CJOvwTjRFWB9q4w1/r1GvlnPt5q6gAqaAiASwyelM4Yy8CvTOWycxup0LUXS3tqIH4t39hc3Y+eoehdnEYjGf2XtaEog5AIgSTXqpElJwZfS+u2/gYR9ejwz6NuCH/kuebm9GnWZWlxDuy+OKadR1HNATOahn1kiTZ4h3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXflIre9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso3932793e87.2
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706494357; x=1707099157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xVswi8/ny2Nz11wVBYc4yWQmJ1mUczvIUQBsLbXcHX0=;
        b=WXflIre9HDdOMxJlFe7nFSnvaNOfDQps94fJklKT9t/qdUXf6kO74SDT9QmJoHuhjb
         HLVcJmScEeR3tCqQNzdSLy0eTy/W/b7v+7O4+cAGjRzW1L/JMMUD+gRfXoWBR2BQIRWV
         BCOeyxDAQ+McTg8tRwrL2qd//RGi4ndT6xgDJxzVGVTwYYbY1UUN0pW0KnNIYmGTuKbb
         zcpTutE9MnBL+95aQFF9InOiMYcADuIQHjwGv14yq6+CN7nl54tgGr99vsmd+GCgZ3yg
         FjM+VmDwIYOtUtzV+EnoTDMXQ+08/qPXmhbgVga466ghm8AfgePMEA98f6GKoH945U2/
         RNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706494357; x=1707099157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVswi8/ny2Nz11wVBYc4yWQmJ1mUczvIUQBsLbXcHX0=;
        b=DxXZJSnNtfBEpuDNJqqhwj/iP+SYDLdYkuamQLxX3DX30gZzEsntznHIdDeDe71j60
         eHj/mRBJqbSf4GPeoa4MvkqtVZxjaXT9NUf1WNMlikf+KMAUoVCRlO37XKTrs9lG44GB
         zNeTuLmj7xZvWqEqaJbsT8lTQKblsACh2NaFFFlkvPBptvRfOPUVXvQtXv8WJiYJ79pz
         hkk0LZXJTNM2BwKiW+SrTupKlyX5O06a/YEExRrwGgCkewQhBcsbaRwQSRuE0fPfL3j4
         UQWHw8YieQ32CaXcosKdNOSdsnOEKZfs8Cv8RlQ0OfYpLrJwCQReAcREc6a5rv52O6bz
         wH8A==
X-Gm-Message-State: AOJu0Yz03Ze7itAYk+uSsJkXlFroR8eMDcIe3W4wppc7i7gMkVaKO4W5
	p4wKYqdM9zzhgedn4vQwlFbk8agAHHjpcfu4Gsz4RSJ2OaUbTh1rUVEKEN0uf802t5Q42a91shU
	kAlE2YsDVemSIL5UEwWvR+zQnbh0=
X-Google-Smtp-Source: AGHT+IGoLzRZF2dRMmctvwykwRBd4Zxv8roTH+pTyqNgYSh319LQjYqumZsHqW2q9fQL5+yAFPqZFX+1QxLysDw6HTA=
X-Received: by 2002:a05:6512:3e0b:b0:511:1038:dcde with SMTP id
 i11-20020a0565123e0b00b005111038dcdemr794947lfv.52.1706494356767; Sun, 28 Jan
 2024 18:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123215606.26716-1-luizluca@gmail.com> <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
In-Reply-To: <20240125111718.armzsazgcjnicc2h@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 28 Jan 2024 23:12:25 -0300
Message-ID: <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus setup
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jan 23, 2024 at 06:56:00PM -0300, Luiz Angelo Daros de Luca wrote:
> > The line assigning dev.of_node in mdio_bus has been removed since the
> > subsequent of_mdiobus_register will always overwrite it.
>
> Please use present tense and imperative mood. "Remove the line assigning
> dev.of_node, because ...".

OK

> >
> > ds->user_mii_bus is not assigned anymore[1].
>
> "As discussed in [1], allow the DSA core to be simplified, by not
> assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
> is unnecessary."

OK

> > It should work as before as long as the switch ports have a valid
> > phy-handle property.
> >
> > Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> > to mdiobus"), we can put the "mdio" node just after the MDIO bus
> > registration.
>
> > The switch unregistration was moved into realtek_common_remove() as
> > both interfaces now use the same code path.
>
> Hopefully you can sort this part out in a separate patch that's
> unrelated to the user_mii_bus cleanup, ideally in "net: dsa: realtek:
> common rtl83xx module".

Yes. With the introduction of rtl83xx_unregister_switch, this part is gone.

> >
> > [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
> >  drivers/net/dsa/realtek/realtek-smi.c  | 15 ++-------------
> >  drivers/net/dsa/realtek/rtl83xx.c      |  2 ++
> >  3 files changed, 4 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> > index 0171185ec665..c75b4550802c 100644
> > --- a/drivers/net/dsa/realtek/realtek-mdio.c
> > +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> > @@ -158,11 +158,6 @@ void realtek_mdio_remove(struct mdio_device *mdiodev)
> >  {
> >       struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
> >
> > -     if (!priv)
> > -             return;
> > -
>
> The way I would structure these guards is I would keep them here, and
> not in rtl83xx_remove() and rtl83xx_shutdown(). Then I would make sure
> that rtl83xx_remove() is the exact opposite of just rtl83xx_probe(), and
> rtl83xx_unregister_switch() is the exact opposite of just rtl83xx_register_switch().

It looks like it is now, although "remove" mostly leaves the job for devm.

I'm still not sure if we have the correct shutdown/remove code. From
what I could understand, driver shutdown is called during system
shutdown while remove is called when the driver is removed. However,
it looks like that both might be called in sequence. Would it be
shutdown,remove? (it's probably that because there is the
dev_set_drvdata(priv->dev, NULL) in shutdown).
However, if shutdown should prepare the system for another OS, I
believe it should be asserting the hw reset as well or remove should
stop doing it. Are the dsa_switch_shutdown and dsa_switch_unregister
enough to prevent leaking traffic after the driver is gone? It does
disable all ports. Or should we have a fallback "isolate all ports"
when a hw reset is missing? I guess the u-boot driver does something
like that.

I don't think it is mandatory for this series but if we got something
wrong, it would be nice to fix it.

> And I would fix the error handling path of realtek_smi_probe() and
> realtek_mdio_probe() to call rtl83xx_remove() when rtl83xx_register_switch()
> fails.

With the rtl83xx_unregister_switch, it was kept in realtek_smi_probe() and
realtek_mdio_probe.

Regards,

Luiz

