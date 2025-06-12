Return-Path: <netdev+bounces-196883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFEEAD6C71
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2CC189F0D6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7522AE76;
	Thu, 12 Jun 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nej5cZce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D81CDA3F;
	Thu, 12 Jun 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721313; cv=none; b=UEVJWm761hqPBwYY/4VxW2VKaj9Ah0Irp1RuxjV0Ltnp1r7aQxKTUqiYppYlKXj6r13JeNyIMffdsuDqBhj3LaYO6UyE4GpdY5hQE0wuFvWxs+GTlOikAJHPvRmzngKVdBieM+Sydx/EU7L/YmsJeRH+/9EmF4ptQmglWzO1FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721313; c=relaxed/simple;
	bh=wIqzhSLqZqmNUrqt6/TJMr+XyjaayHa0yDpcM/EKvHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWowc39qhdnYIqPnPsXDfgiUUgJdxkdVKdDJYM/+ERmmaEGttVZKVHqDE84fnyZdLzXXmlttc8Hrl+NDaP1nN1bpSG2pVkdNHSQcY/zxpc3usyLodXuRq0/ItUe031P/iHqM4vNfz55Ut0THtYOD7FktBKzXVoM5MV0FCnWNp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nej5cZce; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313a001d781so697181a91.3;
        Thu, 12 Jun 2025 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749721311; x=1750326111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFnlATaSnU4bTRG+dvZXuOqxPOP4TFg9Eb3syeOUrz4=;
        b=nej5cZceH6Z1RYuJDnZox4LwuoM047FG80tnEfqMrVaBfhiBMoi2WI+souFU2O8o9v
         bK11LGRYGHvyB9vl1WDOahqq1+85bSV4glgGEuDj4b22jlP+GAlV0slaKS3qFsjNZDwv
         JsmpMpz4m0aGZl4n+vanJUGhgjE6kN8S0Pxu5FnD+dj+Pj7FGgpdvB5O4NLAnCZ5K6XN
         re4DUqvWoTEWrLp6QVR6oCMMe99hR4zEBgJqN7y45TYszO/K7OP+EfEqHbTt03TRDc63
         19WaThlt6Kv9nAyBsj5mLtp7aXQkD8chTnOXY5oCehT6nZ1aj/c67+BFHBT1wCjxRDqH
         JvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721311; x=1750326111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFnlATaSnU4bTRG+dvZXuOqxPOP4TFg9Eb3syeOUrz4=;
        b=VgClFaxbN1jyElAyypbX3X0ECWBbYxVCrlB29oEjPT7OWFAjuy/xYAp+VuLN0fqY8h
         FiJznq4EcAzG4/xm+8Inb6bhMXDzYjSSb3zdJFM37vbsbTgyXEwu/QSVDSx/XW6NwNC8
         Jv66y/S2MjoRqVtvCuCByF6kOiRJQ8s80h+6eU04NHA+M6RLC5/Ak9JqWZI3Ejo0V1IL
         HKAmWrib/uacrzE9d7sGPep+Y8d2s3uzwMwHQuwIKtjBPaaELMXcGBxnnd3oX+khJyuY
         5BF7zzHVO7ngAUqolpbbXyAQrU3Wy91pqoz978/Z/4SmlwiAeKu60GVEQ42iNQw2hYsr
         0C1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbJyo3UjqarcwcZPBLCNcDNsU+wk46Q8N9qodtM45Dqkg7q63gp1NxrFdPee4CX/rBGppa/BkL8bWMHIY=@vger.kernel.org, AJvYcCXV/5DPx2qjoE9Rp82LS1hHw1yA9FgZd/ygLeVfXYTtgYLdIzoGEuuQVli7j7gZ1R7blt/5veVT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1RwlOpVv6oBQFHWKpld/H/1yGBz5IokRM1hP/gBlAlhTNSLZ
	P/tjixfVnzrbxF2ZFKMYJpfZbfHmXuBjy45hcaixztq4J+rDUwsb6tPXehvtlBo6nEZOg/otRvO
	cTFhz4RZxzLSsrDg7noiuabI5m/jSwyk=
X-Gm-Gg: ASbGncst+lkBoUpZG5E+dapFnExd+fgn/6DW8+IECTtUNIhF2sLJlhXf4CCVMGFj/4O
	2w1M6nFYY8gEpsEopqZ4iaJwZdUsC6OUfW70Cyj/NDZLK/ejRTSrZvs1mXQmxVIFwlyMXviR0A5
	cK2YEWEhkibTVFy834fkzXIv/k4YOs70K5URWOsYR/X8Nrv2z/QsboN4DOUEUN8sjdXz9FG0fjc
	5Poeg==
X-Google-Smtp-Source: AGHT+IE+3ZzVw+FDJxwshN0/vGXnhLckf/AU7UBHspfRACjWWG09UyDSyS6J0tTuejiBsaVXPLXyYGEysAF/6F7c3CA=
X-Received: by 2002:a17:90b:2892:b0:312:26d9:d5b6 with SMTP id
 98e67ed59e1d1-313bfba12a1mr3585564a91.3.1749721311459; Thu, 12 Jun 2025
 02:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612083747.26531-1-noltari@gmail.com> <20250612083747.26531-15-noltari@gmail.com>
 <CAOiHx=ne3Bbkeja=F0uPbHjrqp3Y24Zf460uAfK6OxjLBz7MAg@mail.gmail.com>
In-Reply-To: <CAOiHx=ne3Bbkeja=F0uPbHjrqp3Y24Zf460uAfK6OxjLBz7MAg@mail.gmail.com>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Thu, 12 Jun 2025 11:41:18 +0200
X-Gm-Features: AX0GCFssJXWppfkLiagaIosb0fH7TYSNaMTfDRt2F0snKFzFBZiuPl7NucsAkSQ
Message-ID: <CAKR-sGf3kLphXKcmPsB0ZPFY1dQ-TpgDDFHEw9Fv8_vowD8dfg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 14/14] net: dsa: b53: ensure BCM5325 PHYs are enabled
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

El jue, 12 jun 2025 a las 11:19, Jonas Gorski
(<jonas.gorski@gmail.com>) escribi=C3=B3:
>
> On Thu, Jun 12, 2025 at 10:38=E2=80=AFAM =C3=81lvaro Fern=C3=A1ndez Rojas
> <noltari@gmail.com> wrote:
> >
> > According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register t=
o
> > disable clocking to individual PHYs.
> > Only ports 1-4 can be enabled or disabled and the datasheet is explicit
> > about not toggling BIT(0) since it disables the PLL power and the switc=
h.
> >
> > Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> > ---
> >  drivers/net/dsa/b53/b53_common.c | 12 ++++++++++++
> >  drivers/net/dsa/b53/b53_regs.h   |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> >  v3: add changes requested by Florian:
> >   - Use in_range() helper.
> >
> >  v2: add changes requested by Florian:
> >   - Move B53_PD_MODE_CTRL_25 to b53_setup_port().
> >
> > diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53=
_common.c
> > index 3503f363e2419..eac40e95c8c53 100644
> > --- a/drivers/net/dsa/b53/b53_common.c
> > +++ b/drivers/net/dsa/b53/b53_common.c
> > @@ -660,6 +660,18 @@ int b53_setup_port(struct dsa_switch *ds, int port=
)
> >         if (dsa_is_user_port(ds, port))
> >                 b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
> >
> > +       if (is5325(dev) &&
> > +           in_range(port, B53_PD_MODE_PORT_MIN, B53_PD_MODE_PORT_MAX))=
 {
>
> This happen to match, but the third argument of in_range() isn't the
> maximum, but the range (max - start), so semantically this looks
> wrong.

I can change it in order to avoid confusion.
Which one do you prefer?

1. Change defines:
#define B53_PD_MODE_PORT_START 1
#define B53_PD_MODE_PORT_LEN 4
in_range(port, B53_PD_MODE_PORT_START, B53_PD_MODE_PORT_LEN)

2. Just use magic numbers and avoid adding defines:
in_range(port, 1, 4)

>
> > +               u8 reg;
> > +
> > +               b53_read8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, &reg=
);
> > +               if (dsa_is_unused_port(ds, port))
> > +                       reg |=3D BIT(port);
> > +               else
> > +                       reg &=3D ~BIT(port);
> > +               b53_write8(dev, B53_CTRL_PAGE, B53_PD_MODE_CTRL_25, reg=
);
> > +       }
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(b53_setup_port);
> > diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_r=
egs.h
> > index d6849cf6b0a3a..880c67130a9fc 100644
> > --- a/drivers/net/dsa/b53/b53_regs.h
> > +++ b/drivers/net/dsa/b53/b53_regs.h
> > @@ -105,6 +105,8 @@
> >
> >  /* Power-down mode control */
> >  #define B53_PD_MODE_CTRL_25            0x0f
> > +#define  B53_PD_MODE_PORT_MIN          1
> > +#define  B53_PD_MODE_PORT_MAX          4
> >
> >  /* IP Multicast control (8 bit) */
> >  #define B53_IP_MULTICAST_CTRL          0x21
> > --
> > 2.39.5
> >
>
> Regards,
> Jonas

