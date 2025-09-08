Return-Path: <netdev+bounces-220879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FEB495C4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F4B4C3288
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F6310764;
	Mon,  8 Sep 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdPiDPHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216730FF13;
	Mon,  8 Sep 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349638; cv=none; b=eDZjtDJHMTX1qrACrCYbB0ZagjTqzj0mBvvEgqndpklsl5Myehwj8TA9PTFhIeuFQIQTzdDPxZTrqUGRZJPe1VY+vxYlocnawadbszMnrL+xInt8PKzAZlhL61mg3Bk6NrCGFb3swFEKEHCAnmafeSy+QcZTWGRTipXJbQBWwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349638; c=relaxed/simple;
	bh=FHaRlWw47bi/2s/lzA94Hii/QnYjO29WOngiZT7+5t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9/5aMViX6RVYHdArDFuFt156n0icH0jPVLoXs/4Z7Pd8qh79qsL61UV8r44sKu36QbM0wjT8TrNs7gzYHYs14FGvW2ekOgGENG27Ptdeo0UC4oY9tvrU/to/R0pd5UPXwQtbn9E9RFZjIfx0CftsdNG5+11VeCGFL3hNHDl1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdPiDPHy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so6683855a12.0;
        Mon, 08 Sep 2025 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757349634; x=1757954434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tli/DLcsxmXCGIe+l+WvG/LlQXb+bYfU9YziR7TveI=;
        b=TdPiDPHy5nfs1oe6k1a6YoEFU7cT/hElG9jKQrhSSrbq+40RES9hk6OYVB1DziXPF9
         1Ml4Uj9cbNb8+SArQfYew0tJvbmr4UcY72804rfSLrS3Of2KtAhcA62ErssYdbdxvIGM
         JMtyMzFvc0VznMyc4SxVTPzGKJKWnV1QE2AgYyQteFY9iu+qMUoMfcbRDbXXUwrC+XCT
         LrWF0+NYpCl3MIT0k4J+C92xwZYJ8DvLQEZAFoDS/36pMdYKmD3jUtRpt64jQlSX1O4Y
         v3oxhaEbzcKE7o7CkCNkmPD2s24sltWf/stSNcQRvOKoES3R7Az7D8Q/gGjwgpAQOtlf
         14dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349634; x=1757954434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tli/DLcsxmXCGIe+l+WvG/LlQXb+bYfU9YziR7TveI=;
        b=RYzCWwc6O0Bz78JVOi2E9bjGzNeo2aAh1lDV2u6VC1pP1H1OMyox8g6OXR4lhKfh+X
         PP2gXJOjaXggozEdQLnEMDaxHt4qOzQ41vWQSa5aNalN3wne8vD7IzXqibZ/B5tpWDpc
         z0BmPI1FF/DtunO+8hI0HrZ//dtXpJXtgi87gMqsLJ9mao6kgqDdDKAdU6zSeCpndCYr
         twWqisGP+0pZyCDrgDCX1lRtDpGVbBw1J1u/9RqbfxO9Dyz5y4kOmV3yjgEPwHi+R9ww
         o8sZqEun5PNqVhmc4uwvE1mi3rMnOqzug/Teinb2ztQjxhOZYpGcHJOzOJvFtsXWVdF2
         b2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUORLibodpzbmHH3BkGd8w+ck5TOnvq877Nebayl2601hnBiW1ANLnqMRNZUsSpGZ0cGufzMQIvqC+S@vger.kernel.org, AJvYcCVGa+DEfT7UC5ueA5ZsIJqVUHZcr6MZvBJ0VugzXOxZN0YeBjM1M+lPF3sPkD2xmpXUKZgdIj+wjDovM5w=@vger.kernel.org, AJvYcCWHIzc3V3SDqf9anvEDrsKR7o+MCn6xYjTqFPvQGtsRJ2ifD+MC8Zuv51zYvnwfXi0weBNCg/3j8/mOlqtt@vger.kernel.org, AJvYcCWV/r5YjutDuNn6FzsW7DHmd0xIB9XNlcQaBB8vj5JpAEmKm54Kd8B04Uvg6bYLTvAEPcxQwvol@vger.kernel.org, AJvYcCX6BsuwQoPuxWU3V//L6tkK2jCUjUeDeCLoHONmp0aHnYy76vNnSe07AtQAIda40zEDbKspduEegcZL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyul3cjK52t3Lkse9XqJx7hHHEWet1MF1/ZsAPMd/FvzG1LHS47
	rTFNxrtOsVgEv55ZFVbLc4qw41ugKtDHEs0Dpbjv0DHg4iL8ylnbjhv70UZiCkIAJx+16n6rEb2
	/bl5Tl/fjVNzfIERRM1ZL9dgEmUmQx3g2kEQ=
X-Gm-Gg: ASbGnctdCFeTz7B/1tOfWRFl79oJulEJxjUE015KE36/zAREaBcKyq8nwq+mFdZ4yr7
	4mgd+NfKFU/xkxDpiazYIe/GPxGXB/GeYJz1JNg47drlJWh2X2LJGsmiCFLFnysmWWqWavnzlCG
	x2nCvE4+JTjFjndHNEmkmdI87t9Kj4aXurSvCjQ7cCqT/+6lKK5kIfUfISniGOKlpfGiiplbgji
	DIgoIUJ5LmGTUEJ6Wg=
X-Google-Smtp-Source: AGHT+IHFdGPvfRdd8A7S2XtWHU05xR82G1l7BaYCFy8bHqp8Uf1KYaTERVRuNwAEl59fhaC3MV2TP8RBsQ7Nq1vspKw=
X-Received: by 2002:a17:907:3c83:b0:b04:9b10:1977 with SMTP id
 a640c23a62f3a-b04b16efcd1mr921636366b.57.1757349634326; Mon, 08 Sep 2025
 09:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net> <aL5g2JtIpupAeoDz@pengutronix.de>
In-Reply-To: <aL5g2JtIpupAeoDz@pengutronix.de>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Mon, 8 Sep 2025 09:39:58 -0700
X-Gm-Features: Ac12FXzqcbEM0aRhhauxD_6sJMdm_3EFve3NAKfXAQc2Nd47Jib9jboYmOXjeMw
Message-ID: <CAAcybuvqqKBniV+OtgfCLHJdmZ836FJ3p7ujp3is2B8bxQh4Kw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
To: Oleksij Rempel <o.rempel@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:51=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:
>
> On Sun, Sep 07, 2025 at 09:06:25AM -0700, Guenter Roeck wrote:
> > +Cc: pse-pd maintainers and netdev mailing list
> >
> > On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote:
> > > This patch series introduces per-port device tree configuration with =
poe
> > > class restrictions. Also adds optional reset/shutdown gpios.
> > >
> > > Tested with hw poe tester:
> > >   - Auto mode tested with no per-port DT settings as well as explicit=
 port
> > >     DT ti,class=3D4. Tested that no IRQ is required in this case.
> > >   - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ require=
d.
> > >   - Tested current cut-offs in Semi-Auto mode.
> > >   - On/off by default setting tested for both Auto and Semi-Auto mode=
s.
> > >   - Tested fully disabling the ports in DT.
> > >   - Tested with both reset and ti,ports-shutdown gpios defined, as we=
ll as
> > >     with reset only, as well as with neither reset nor shutdown.
> > >
> > > Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> >
> > This entire series makes me more and more unhappy. It is not the respon=
sibility
> > of the hardware monitoring subsystem to control power. The hardware mon=
itoring
> > subsystem is for monitoring, not for control.
> >
> > Please consider adding a driver for this chip to the pse-pd subsystem
> > (drivers/net/pse-pd). As it turns out, that subsystem already supports
> > tps23881. This is a similar chip which even has a similar register set.
> >
> > This driver could then be modified to be an auxiliary driver of that dr=
iver.
> > Alternatively, we could drop this driver entirely since the pse-pd subs=
ystem
> > registers the chips it supports as regulator which has its own means to=
 handle
> > telemetry.
> Yes, Guenter is right. This driver belongs to the pse-pd framework.
No disagreement here in principle. However, the current hwmon driver
already implements power control and exposes it via in*_enable sysfs
files. I found this a bit odd, but I don't write drivers often.
My understanding of Guenter's suggestion is that it would require breaking
this userspace API?

From a quick look at the tps23881 datasheet I can see that it is
similar, however, it is quite different in the context of this patch.
tps23881 (unlike tps23861) has Port Power Allocation register that can
limit poe power class. This register can be set prior to
detection/classification. So the extra complexity of an interrupt
handler that decides whether to enable the power may not be required.

Perhaps it still makes sense to merge these drivers, but I don't have
time or hardware to do it at the moment.

