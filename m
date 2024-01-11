Return-Path: <netdev+bounces-62978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C982A77A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5B11C22899
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862A23C3;
	Thu, 11 Jan 2024 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSAQWfU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE79211A
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd0db24e03so56454051fa.3
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 22:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704954022; x=1705558822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8LXJjKC2VOF4Of2hJK9W50pFRjuIrNhRWsqlOTUUNk=;
        b=hSAQWfU0/XXCjZqWhF9v4r6D9KAlRvofXFEsE+WDvXKhGe9mQmHxIkuR04qCT/0+nC
         sqGRsOSFiw7smFCbK6VfvPAW+47k8L1I4HHSdUIY8e/O5SQqqVuz2zH4ntyt8yYEHMxg
         /AGfIIcOUPKtrxbz1td27NrauQhxjSR0kNZP9A0+KfSsG76TcZzMJlsWRVOk+qRT+KFc
         cBbJ+P3EZAX1xDPj0Kg1woFN+Axbxlp3dpGPWtOo+QrjFXug/c96Jcjk5qpCvIYYx6MI
         OlpRPxxvn+VGjc41dShoh67n2LVg+toFcSVAjhlO0b0G1GQLdLaeW2D4HOYdkhL6G+Si
         Rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704954022; x=1705558822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8LXJjKC2VOF4Of2hJK9W50pFRjuIrNhRWsqlOTUUNk=;
        b=Q7PT7TF4mYWPwH4AHnz36/2VYfzLX11IHsgRuNUP/9mDt50p8KXJesfugrl+vbXuuf
         cczS7fo6apIRQmWZ76UHmP/DDccUrLO3sOdzTv0EbjMDkyiwoTYU6rGymFPSeCLSwT/u
         3q8OByfgRe4KH01U+dVKKjiwaaK5WrL7Mz/ci0Emw+gioZH1cqY7B2+biwQEzCKv3Rxu
         qj/33vPSBNXPMEVMTROPSd35YWS2ICLJ/N+wtT1jwWNAoVG1Th0KH7G43h4fcevDq2ex
         i2gsEK6hKK8R9x1N/aVHXYSXcREopmDL5I71wLf5TAwTsrRoQhh21CzH2lXOagJ7qfw9
         I4qw==
X-Gm-Message-State: AOJu0YwM1NlQH3Nb5fEkxcu1ktE0sFgPcrAsruhABGDUCQI4KUzN+o1f
	Zo7LfS6ENpT5wQPoXkS7PUxCn3UUWiBbxCbFgNE=
X-Google-Smtp-Source: AGHT+IHJ+2Z9XONOcw3MmpoOayBlv/mL1J63WWvr8wTuYFFGU4xvk3HZRF7GGVegtH7mDbq9N5imD7wzw7ogdY0ZMM8=
X-Received: by 2002:a2e:9848:0:b0:2cc:3e6d:8dcb with SMTP id
 e8-20020a2e9848000000b002cc3e6d8dcbmr42775ljj.104.1704954021688; Wed, 10 Jan
 2024 22:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf> <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
 <20240109123658.vqftnqsxyd64ik52@skbuf>
In-Reply-To: <20240109123658.vqftnqsxyd64ik52@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 11 Jan 2024 03:20:10 -0300
Message-ID: <CAJq09z6JF0K==fO53RcimoRgujHjEkvmDKWGK3pYQAig58j__g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jan 09, 2024 at 02:05:29AM -0300, Luiz Angelo Daros de Luca wrote:
> > > > +struct realtek_priv *
> > > > +realtek_common_probe(struct device *dev, struct regmap_config rc,
> > > > +                  struct regmap_config rc_nolock)
> > >
> > > Could you use "const struct regmap_config *" as the data types here, to
> > > avoid two on-stack variable copies? Regmap will copy the config structures
> > > anyway.
> >
> > I could do that for rc_nolock but not for rc as we need to modify it
> > before passing to regmap. I would still need to duplicate rc, either
> > using the stack or heap. What would be the best option?
> >
> > 1) pass two pointers and copy one to stack
> > 2) pass two pointers and copy one to heap
> > 3) pass two structs (as it is today)
> > 4) pass one pointer and one struct
> >
> > The old code was using 1) and I'm inclined to adopt it and save a
> > hundred and so bytes from the stack, although 2) would save even more.
>
> I didn't notice the "rc.lock_arg = priv" assignment...
>
> I'm not sure what you mean by "copy to heap". Perform a dynamic memory
> allocation?

Yes. However, I guess the stack can handle that structure in this context.

> Also, the old code was not using exactly 1). It copied both the normal
> and the nolock regmap config to an on-stack local variable, even though
> only the normal regmap config had to be copied (to be fixed up).
>
> I went back to study the 4 regmap configs, and only the reg_read() and
> reg_write() methods differ between SMI and MDIO. The rest seems boilerplate
> that can be dynamically constructed by realtek_common_probe(). Sure,
> spelling out 4 regmap_config structures is more flexible, but do we need
> that flexibility? What if realtek_common_probe() takes just the
> reg_read() and reg_write() function prototypes as arguments, rather than
> pointers to regmap_config structures it then has to fix up?

IMHO, the constant regmap_config looks cleaner than a sequence of
assignments. However, we don't actually need 4 of them.
As we already have a writable regmap_config in stack (to assign
lock_arg), we can reuse the same struct and simply set
disable_locking.
It makes the regmap ignore all locking fields and we don't even need
to unset them for map_nolock. Something like this:

realtek_common_probe(struct device *dev, const struct regmap_config *rc_base)
{

       (...)

       rc = *rc_base;
       rc.lock_arg = priv;
       priv->map = devm_regmap_init(dev, NULL, priv, &rc);
       if (IS_ERR(priv->map)) {
               ret = PTR_ERR(priv->map);
               dev_err(dev, "regmap init failed: %d\n", ret);
               return ERR_PTR(ret);
       }

       rc.disable_locking = true;
       priv->map_nolock = devm_regmap_init(dev, NULL, priv, &rc);
       if (IS_ERR(priv->map_nolock)) {
               ret = PTR_ERR(priv->map_nolock);
               dev_err(dev, "regmap init failed: %d\n", ret);
               return ERR_PTR(ret);
       }

It has a cleaner function signature and we can remove the _nolock
constants as well.

The regmap configs still have some room for improvement, like moving
from interfaces to variants, but this series is already too big. We
can leave that as it is.

> > > > +EXPORT_SYMBOL(realtek_common_probe);
> > > > diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> > > > index e9ee778665b2..fbd0616c1df3 100644
> > > > --- a/drivers/net/dsa/realtek/realtek.h
> > > > +++ b/drivers/net/dsa/realtek/realtek.h
> > > > @@ -58,11 +58,9 @@ struct realtek_priv {
> > > >       struct mii_bus          *bus;
> > > >       int                     mdio_addr;
> > > >
> > > > -     unsigned int            clk_delay;
> > > > -     u8                      cmd_read;
> > > > -     u8                      cmd_write;
> > > >       spinlock_t              lock; /* Locks around command writes */
> > > >       struct dsa_switch       *ds;
> > > > +     const struct dsa_switch_ops *ds_ops;
> > > >       struct irq_domain       *irqdomain;
> > > >       bool                    leds_disabled;
> > > >
> > > > @@ -79,6 +77,8 @@ struct realtek_priv {
> > > >       int                     vlan_enabled;
> > > >       int                     vlan4k_enabled;
> > > >
> > > > +     const struct realtek_variant *variant;
> > > > +
> > > >       char                    buf[4096];
> > > >       void                    *chip_data; /* Per-chip extra variant data */
> > > >  };
> > >
> > > Can the changes to struct realtek_priv be a separate patch, to
> > > clarify what is being changed, and to leave the noisy code movement
> > > more isolated?
> >
> > Sure, although it will not be a patch that makes sense by itself. If
> > it helps with the review, I'll split it. We can fold it back if
> > needed.
>
> Well, I don't mean only the changes to the private structure, but also
> the code changes that accompany them.
>
> As Andrew usually says, what you want is lots of small patches that are
> each obviously correct, where there is only one thing being changed.
> Code movement with small renames is trivial to review. Consolidation of
> two identical code paths in a single function is also possible to follow.
> The insertion of a new variable and its usage is also easy to review.
> The removal of a variable, the same. But superimposing them all into a
> single patch makes everything much more difficult to follow.

This case in particular might be hard to justify in the commit message
other than "preliminary work". I'll split it as it makes review much
easier. this series will grow from 7 to 10 patches, even after
dropping the revert patch.

Regards,

Luiz

