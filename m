Return-Path: <netdev+bounces-168267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F49A3E4E0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DE117EA84
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5101D5AA9;
	Thu, 20 Feb 2025 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfirfkGT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EF15A858
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079001; cv=none; b=ivVl70J7vauyLm44f2Sxo/MyHO76Z4YY8ecxyGgp9kO5EDZHhBAYNqBxBW0YQqv9ZtvhREo18OixTSVz6vrti9KAeri3gOIt0HXQbKkDkLOAwDLYP2H6mdvHL8tIeNwpyUDUZDpl9rTwheMZ5bOX69q5e8Nv3jACli9WTtESod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079001; c=relaxed/simple;
	bh=/tYeST0CK+YWWru6ffoGxzlh6oPLskyipvlWIgXVvFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiBpPVtKm0tcExTmi0ah8eAUuAIM+xU3vtOQF6EDLtf3ga/hmadi6kqtcEHmEWVaWFua75LEM17jmZ8LggSX6l3Oy8stPiLyHBD+NSdEpZP6BQ2fSLWXOSDzaCxEXssvwRF2ABGF0Hz6EaKmZfQt/2pylWyA7YvMRrqE7Pfv6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OfirfkGT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso1473638e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740078997; x=1740683797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uVENDfwz/Qh+tAgnLxaox3vXaye+Qf2L0Hey6cfx0I=;
        b=OfirfkGTZt2zzxqp9QNSdc3BTezmF03fMrSfVlUlsvh7fJYGI4/WQTLG54YWqTsAw/
         Esjv4d2J8ylwsRvab1O3oufluSa1D1Ul52nGfO2ykovkhDX5Nty2kaVhJSbTGmVyHjbh
         edi+8GHGVyriMao7ykePByCRkbTwWKsYgk1q8JaTvok47AcipScFXg+L8vrtXxEEy1mb
         6oMQCIU7p8HXpsMmrpbY1bd3sO0P93pCMjBZYPgLgXDi7OeBZb4vNi58hKbM5182UAf/
         92JcSeJKiDVdjUvcoevjkkuB6Dco4vdihx6omyVAu4kTm/XE0Z+nfuALGqPAF1UwC0cM
         kmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078997; x=1740683797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uVENDfwz/Qh+tAgnLxaox3vXaye+Qf2L0Hey6cfx0I=;
        b=LcwmhVtJ/PIgMLRX+EakTcB5jOFyEz+UCyboIy8VcyZqbaC3WeZwUuw2eScCiKsIAK
         kv3cc7zpHEspOnfdPP9N6qhPieDuW4c/EjyWWW4srF4cXGgFcua6wlDzYla7b5INstJc
         +BsVR6qvzYU9mFdU3A68nDLGAmtwqGiZeGAIuE1Ib2NjBsWdttJb/SCOKyOkzM3geeQk
         RUVJ/fl224ufM9o4nEs0xQtuI0DFsCzVztnBcjNNaZhBRkg3wO8Ym1F2aokyEOLp8Q6j
         9f2XpaIaxomn/OtQLRWyW7APUlo9KGH+1R185V1Q1RyYKRhkYIp0DmQFON83emekXon0
         CfTg==
X-Forwarded-Encrypted: i=1; AJvYcCXczyB2qiiqbt3pglCP7oYFLUGzXLsm6gW5yswoHeUqW2fWN6kRYqFGXuEZkNTlPvQ7CzA8jZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDipo/chzpQZse2Gg0yQRteK1oxzBHB2qyR8EGJBd3pB/9coH5
	xFp+he+A4odTPNpkL/xMDtMxH4kwQMCmaqYPx/RPl/E/M1884/TX0FMv/PFnPEHAAuEyvLTIeoJ
	m+QXK8nRz76LtkjBwwS5QLgpyegCl6T9GyCi/pQ==
X-Gm-Gg: ASbGncvN9JqlGSwHlcCm2hDSAHjgeHW6a33flbsf6LE3mNaTFG7y1pbvxZIrGhyqyJB
	1pGlWEeukXHVDEQkVvOL4JM4DrIrX5Cyfu4S2XAq/a3A6p3HMWG2FR0OqMQuwH4SxvKkULtkx
X-Google-Smtp-Source: AGHT+IEQPrE6WVTmtrHf2e7UKLfHbb0axLzS9zxt+aCr/fq7bVq3frNZcIJxjbwUWPgTyGw1kwmEFhwQYPnu2JsuWCo=
X-Received: by 2002:a05:6512:6ce:b0:545:d35:6be2 with SMTP id
 2adb3069b0e04-5483926860bmr41761e87.34.1740078997450; Thu, 20 Feb 2025
 11:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-rtl8366rb-leds-compile-issue-v2-1-8f8ef5a3f022@linaro.org>
 <20250220180814.efeavobwf4oy5pvy@skbuf>
In-Reply-To: <20250220180814.efeavobwf4oy5pvy@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Feb 2025 20:16:26 +0100
X-Gm-Features: AWEUYZm1LTOtOhoJpXEtG7TbmY8NdTvGNWfTuz8fyiB8ao4B6WwO44UtRyJ8L6Q
Message-ID: <CACRpkdY4WtDGFxTu+Ke_g+YfzL7vY3BGktzUpUAzJuuDgbBtSw@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: rtl8366rb: Fix compilation problem
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:08=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
> On Thu, Feb 20, 2025 at 05:02:21PM +0100, Linus Walleij wrote:
> > diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek=
/Makefile
> > index 35491dc20d6d6ed54855cbf62a0107b13b2a8fda..2fb362bbbc183584317b4bc=
7792ee638c40fa6a1 100644
> > --- a/drivers/net/dsa/realtek/Makefile
> > +++ b/drivers/net/dsa/realtek/Makefile
> > @@ -12,4 +12,7 @@ endif
> >
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) +=3D rtl8366.o
> >  rtl8366-objs                                 :=3D rtl8366-core.o rtl83=
66rb.o
> > +ifdef CONFIG_LEDS_CLASS
> > +rtl8366-objs                                 +=3D rtl8366rb-leds.o
> > +endif
> >  obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) +=3D rtl8365mb.o
>
> I was expecting to see even more than this. What happens if CONFIG_LEDS_C=
LASS
> is a module but CONFIG_NET_DSA_REALTEK_RTL8366RB is built-in? Built-in
> code can't call symbols exported by modules, but I don't see that
> restriction imposed, that CONFIG_NET_DSA_REALTEK_RTL8366RB should also
> be a module.

Well spotted (as usual).

I sent a v3 using a new Kconfig symbol and some tricks I learned
to get the dependencies right, have a look!

> > +     init_data.devicename =3D kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d=
",
> > +                                      dp->ds->index, dp->index, led_gr=
oup);
> > +     if (!init_data.devicename)
> > +             return -ENOMEM;
> > +
> > +     ret =3D devm_led_classdev_register_ext(priv->dev, &led->cdev, &in=
it_data);
> > +     if (ret) {
> > +             dev_warn(priv->dev, "Failed to init LED %d for port %d",
> > +                      led_group, dp->index);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
>
> I know this is just moving the code around, but I was looking at it anywa=
y.

Let's fix what you see with follow-up patches once the critical compile
bug is fixed, it's always good to fix stuff.

> Doesn't init_data.devicename need to be kfree()d after devm_led_classdev_=
register_ext(),
> regardless of whether it succeeds or fails?

I believe so, I made a patch.

> IMHO, the code could use further simplification if "realtek,disable-leds"=
 were
> honored only with the LED subsystem enabled. I understand the property ex=
ists
> prior to that, but it can be ignored if convenient. It seems reasonable t=
o
> leave LEDs as they are if CONFIG_LEDS_CLASS is disabled. But let me know
> if you disagree, it's not a strong opinion.

I added it to the router for a reason: I found that the LEDs were enabled
on the D-Link DIR-685 (boot on default), despite this device does not
even have any physical LEDs mounted.

So it's there to save some (well, probably not much but not non-existent)
leak current in the silicon and pads from the LED driver stages being
activated despite they are unused. If they are even blinking, it's even
more leak current for blinking the non-LEDs, running timers and what
not.

That's why the binding looks like so:

  realtek,disable-leds:
    type: boolean
    description: |
      if the LED drivers are not used in the hardware design,
      this will disable them so they are not turned on
      and wasting power.

This is maybe a bit perfectionist I know...

> Also, I'm not sure there's any reason to set RTL8366RB_LED_BLINKRATE_56MS=
 from
> within the common code instead of from rtl8366rb-leds.c, since the only
> thing that the common code does is disable the LEDs anyway (so why would
> the blink rate matter). But that's again unrelated to this specific chang=
e,
> and something which can be handled later in net-next.

I made a patch for this as well, will send them out as soon as the
compilation issue is fixed in mainline.

Thanks for your attention to detail!

Yours,
Linus Walleij

