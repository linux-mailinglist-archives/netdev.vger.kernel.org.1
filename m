Return-Path: <netdev+bounces-221842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B746B520B0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 21:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AB74830A9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601A2D46B5;
	Wed, 10 Sep 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE0jFgvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F7253951;
	Wed, 10 Sep 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531513; cv=none; b=BvLOriiFz5JVM5t7TEogwNaLIYl0uaqRCitS+aYq4Q1gqvFWS+HnI6DZxXv7d9DM6+BM3NPVKc4FH81BVcz0S7OhGRo1pPcu2VxP+PpANKOAmkvh+mS+kDEJbUJV4C8ldT/jjry043ZIfSjwv6Iu4zWZtuCi1Z9IxVEA6koeIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531513; c=relaxed/simple;
	bh=KOANke260Y7N8OFgQD8TZ+R34HpsV2NnLbUCOfILchY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtsEkyoQyqvYRDeChG2mmGd/UFgR28XyRdg/8A7zasOLd4K2s7JXMGPdzpQnI0HwuicNh1rSMmZy/vDdIv/YZbE1N+JkaxCtV0YO7enVmrpN/YpAwIDHAQZQ9d7zB6i/ZqQ/oO2w9ABN0Q1DU1cWPtgcGo4VKup+aZiXbKVSsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE0jFgvA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b04271cfc3eso943966366b.3;
        Wed, 10 Sep 2025 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531509; x=1758136309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNWe951fEznrVHG6mxzWqLu6O942IWo0SOgA3l0YSpM=;
        b=iE0jFgvAPYgr1Dtp2r5lf+wA1ge2xT849TWhhkbWgggGJj94USQqJ8GaSKYs/Aspuf
         L+l7FohEewZrWqDe7JfoJWH20K2Gg9QP6th3ZIBdtE1LzIBfLPJbMHYsK1iNZXJ7wboc
         /wpHfxC2QzSfpxQl5RfGceE5mlEliGlceQfSZVGLh7VPXDG1XBnVoW5U9pOZj+Zleqt2
         0qC6eRDkqBPCEm4jgeyJPyn29YmO2EeDLjmm5YZKnJySrNw9koCqq/aurjba25gDo7fg
         +dXkdzDhmyv1Z0n4mcRTAeU65/OnRVVohuVqd+zBpntkET1sHAxdGvIW2Bi0lAwBQ0Av
         SIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531509; x=1758136309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNWe951fEznrVHG6mxzWqLu6O942IWo0SOgA3l0YSpM=;
        b=mTCXiHdG+Vn2ajEYc+pGe4uCP+AsXYrl5FyWtNT/Ozpwf04pG4M5fOhgaZJCEklDb/
         Fo/hlCKSL0CoLujNsQ78+fboKGqh9a5V7ma2MJxnmVvEYCXX4RMmumEFpYWIWXaw0xl4
         RgV6FYAXZqzpVhy56/2RTSRUkko1HL2OcuiRNQetk5MGDuHeZIuOaWD9Eb+/Sy1SKnMM
         4TFiw+XQJ6n/b49g/VPt/BDwzBXBgjzYvFXe6NxTuONY9ieKYKENwYaHxg5yvCEz7sWA
         //Eu7zc9BtT256DwOw5VO4untcYxNjJbkNHwHuhe9K4ckrMKZ6hs4+tINb6mRWD4Ebhw
         IrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVUQMPFwOWfQAQ6JsrPa7lx6PB98IgESYoNr8KcpvSmBBc2xHuguLDGPVqmBrGbocDqvsBv1T+gDh@vger.kernel.org, AJvYcCVQ7buJNr++GLFYX8/opHTlU6sXWfzHylfW22vLv5zbXukwU3FdYVUodO2P2A9jK72lyuZcWqAQ5o4ZyWk=@vger.kernel.org, AJvYcCVj+xM+4IbmmZ7BOpKhtzBdW0kIe7lcYCIsTHvgkuh4/cB9kCpknycWH7IrJgHeX5kKQSWr796x3REi@vger.kernel.org, AJvYcCVyWBuMa2FbkIqPOnMI5ow4dW1Q+m4F5quiP+gSh+5HfbwnWb6xl4CbAmvSLW2/b5Q13lis9lOQcvWANS8+@vger.kernel.org, AJvYcCWC5tabUBdFAK1R7/zn+pDXglCFb4ZJFn8SOB2wEWh+wEtAWFLYkE05KmycK9t0DKrQ+XziSQYH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxe1+iGlDW4+fWmfjLiZhH4B197cEVEuxPRZioERx2xSAcKPH/
	tdJiBoGnD++IGgKyknHN2NCslDIXy3BX+imFoU+I2lCiE1an9XymW/W8KWHTky9g6rR08IQbNbm
	MVIRoJ5yq5PDAfzsf+ET38hxepJIJxg==
X-Gm-Gg: ASbGncujSS0Ogxgar/BhZzuAi9iLweSXGhW4cwkTHn/mxxM7shnCbmFbFjDRoHG+bv5
	RzQ7bWM+e0Ty6K84WyF8lYaiaTKDxD21uR3i6m+zqwxrtsc4F4Prd6nb7XeTmnL/tLwwrVIgSGy
	Hrg47LdaOqdGlb/+16OD6Twir8YgV9asW68CtlnQaiYtJ9FbA1j3aw2rEEwexUHCxV8VhzQbfJP
	66+/wGxqSxfgAc85CU=
X-Google-Smtp-Source: AGHT+IH5k2YiwT7SeoDVr7cCV501nWg0Xjh6ykKknruZUH8hPd8Ej4pPkLIOwcC4xwCRJE2syaveBnn49jruM399P9Q=
X-Received: by 2002:a17:907:a48:b0:afe:87bd:da59 with SMTP id
 a640c23a62f3a-b04b1687ddamr1564443466b.42.1757531509134; Wed, 10 Sep 2025
 12:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net> <aL5g2JtIpupAeoDz@pengutronix.de>
 <CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com> <9e4db8d7-c99f-46f3-9ddb-00b0a9261d86@roeck-us.net>
In-Reply-To: <9e4db8d7-c99f-46f3-9ddb-00b0a9261d86@roeck-us.net>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Wed, 10 Sep 2025 12:11:10 -0700
X-Gm-Features: Ac12FXyY2k6-zu3gOyPfWLj0St0alE4zNkLzD-PbTPjdHRpByiOWYilwdbtcq-Q
Message-ID: <CAAcybusjm00hv+W-pKaNpPedXuWeTu5mo=i6TKnTJgVurO_ryg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Robert Marko <robert.marko@sartura.hr>, 
	Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:02=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 9/8/25 09:39, Gregory Fuchedgi wrote:
> > On Sun, Sep 7, 2025 at 9:51=E2=80=AFPM Oleksij Rempel <o.rempel@pengutr=
onix.de> wrote:
> >>
> >> On Sun, Sep 07, 2025 at 09:06:25AM -0700, Guenter Roeck wrote:
> >>> +Cc: pse-pd maintainers and netdev mailing list
> >>>
> >>> On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote:
> >>>> This patch series introduces per-port device tree configuration with=
 poe
> >>>> class restrictions. Also adds optional reset/shutdown gpios.
> >>>>
> >>>> Tested with hw poe tester:
> >>>>    - Auto mode tested with no per-port DT settings as well as explic=
it port
> >>>>      DT ti,class=3D4. Tested that no IRQ is required in this case.
> >>>>    - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ requi=
red.
> >>>>    - Tested current cut-offs in Semi-Auto mode.
> >>>>    - On/off by default setting tested for both Auto and Semi-Auto mo=
des.
> >>>>    - Tested fully disabling the ports in DT.
> >>>>    - Tested with both reset and ti,ports-shutdown gpios defined, as =
well as
> >>>>      with reset only, as well as with neither reset nor shutdown.
> >>>>
> >>>> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> >>>
> >>> This entire series makes me more and more unhappy. It is not the resp=
onsibility
> >>> of the hardware monitoring subsystem to control power. The hardware m=
onitoring
> >>> subsystem is for monitoring, not for control.
> >>>
> >>> Please consider adding a driver for this chip to the pse-pd subsystem
> >>> (drivers/net/pse-pd). As it turns out, that subsystem already support=
s
> >>> tps23881. This is a similar chip which even has a similar register se=
t.
> >>>
> >>> This driver could then be modified to be an auxiliary driver of that =
driver.
> >>> Alternatively, we could drop this driver entirely since the pse-pd su=
bsystem
> >>> registers the chips it supports as regulator which has its own means =
to handle
> >>> telemetry.
> >> Yes, Guenter is right. This driver belongs to the pse-pd framework.
> > No disagreement here in principle. However, the current hwmon driver
> > already implements power control and exposes it via in*_enable sysfs
> > files. I found this a bit odd, but I don't write drivers often.
> > My understanding of Guenter's suggestion is that it would require break=
ing
> > this userspace API?
> >
>
> If the enable attributes enable power to the ports, that code and functio=
nality
> is simply wrong. It should only enable (or have enabled) power _monitorin=
g_.
> As such, changing that would from my perspective be a bug fix.

Alright, then. I'll try to find some time in the next few months to port th=
is
over to a separate driver in pse-pd. And then remove the in*_enable from hw=
mon
one. Even if it's there by mistake, probably shouldn't fix it until there's=
 an
alternative in place.

>
> And, yes, that slipped my attention when reviewing the original code.
> Sorry to have to say that, but I am not perfect.
>
> >  From a quick look at the tps23881 datasheet I can see that it is
> > similar, however, it is quite different in the context of this patch.
> > tps23881 (unlike tps23861) has Port Power Allocation register that can
> > limit poe power class. This register can be set prior to
> > detection/classification. So the extra complexity of an interrupt
> > handler that decides whether to enable the power may not be required.
> >
> > Perhaps it still makes sense to merge these drivers, but I don't have
> > time or hardware to do it at the moment.
>
> I didn't suggest to merge the tps23881 and tps23861 drivers; I just point=
ed out
> that they have a similar register set.
>
> The point here is that a hardware monitoring driver should limit itself
> to hardware monitoring. Actual control should, for example, be implemente=
d
> through the regulator or thermal subsystems.

