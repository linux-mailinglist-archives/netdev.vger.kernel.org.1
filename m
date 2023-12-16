Return-Path: <netdev+bounces-58180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025681575E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47011C213A9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 04:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7D10A02;
	Sat, 16 Dec 2023 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ6JAPB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649A1E48C
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e24e92432so596730e87.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 20:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702700792; x=1703305592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7q4Xho1JgxYuKyx+Xu1chggngV+XfzSjx94N4xNVz0=;
        b=hQ6JAPB42XDpyP78mw2AxWH4EIaG41aVNQU076JDYGk1AfSWMNGuijEixT/4GvpkEE
         /nLgnmNEQoNYIfv3LqyLrBfy4S8pNdAt3vcJORhrX6eJgyVsXKCx+sszEMwRgDwl5aGP
         RtNx8z0SeG4mmQ2KLcwHbFxFlvh8jEezniXJBDljOAzJxUG7qZmunGVXInbRv4Oyjj1r
         0rcU8ePZd/sNmCe3peAgeV8SCTqPl/TUGk0m8cofl4fqpe/Pf6EhidkWk2NNq7gtfq1O
         U0GZdE+0+5wMJod/i9xwJJpPiJBWo+iACnsY9EeuaBNeR041KZNlWkdu25DGdleO0/1+
         aXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702700792; x=1703305592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7q4Xho1JgxYuKyx+Xu1chggngV+XfzSjx94N4xNVz0=;
        b=HoNo0QzYqzYwu9e1jKE1DbWP/NErqLdqzztRVoBqPg2qrrHiCyaoDq8yD3T/EoagxD
         chrpy3MdD0Fs5Mb9V9ppkQ51CvByEDYL9EruxxM+PKAWd771yvsPhQGRgY9bYX/zh/NM
         2wb0AwXWnEmpnuaxJq2O+LsfdwgK32eyHDR3PnG/vtqTZLKspx7suAPs+JsHufwFImjL
         R7shTs6PDafujMryuNWR3GFxVzuHqBpxhD2tgre30EJcagQKZ6qCc+tFUJpZdvv7ZsP1
         bMk7++y3s0tMDQnW6T9zCiWOi7cRMIwU70EgGi4q0dcfiCWEIVHTghJzCgl3F5RRxYTu
         NwgQ==
X-Gm-Message-State: AOJu0YwAy0jyeEX88cr7yfoXgsfE4TN94YdSyDUPxF7Sxgy5aOwotmsv
	0qL9Nl1My4yPzTlD44fF0XPtRBgrGDDurv5jwcA=
X-Google-Smtp-Source: AGHT+IGIeM3KWYbviffGzKkApGoyVVZYlsbI0UBKIxMR4MHs/2LUR2kY+DKfn67bpdi99s5p4LlVkQhJf9Wmkx5r1qM=
X-Received: by 2002:a05:6512:744:b0:50b:fa2e:4bce with SMTP id
 c4-20020a056512074400b0050bfa2e4bcemr2680009lfs.9.1702700791869; Fri, 15 Dec
 2023 20:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
 <20231211171143.yrvtw7l6wihkbeur@skbuf> <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>
 <20231212215801.ey74tgywufywa3ip@skbuf> <CAJq09z6veGUNymR6hxabBPercR6+7gFC-FhwiVM+wScm5xDREA@mail.gmail.com>
 <20231213130419.flgob4mhi6hrxgn2@skbuf>
In-Reply-To: <20231213130419.flgob4mhi6hrxgn2@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 Dec 2023 01:26:20 -0300
Message-ID: <CAJq09z7bDckmEfMqX8dtSAi6SW+7bmns9C1kocpJOndWkh5UoA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> On Wed, Dec 13, 2023 at 01:37:27AM -0300, Luiz Angelo Daros de Luca wrote:
> > The answer "just read (all the multiple level and different) code
> > (paths)" is fated to fail. The put after registration in DSA core code
> > is just an example of how it did not work.
>
> If you try to think critically about the changes you make, you'll get
> better at it with time. Reading code is what we all do, really, and
> making educated guesses about what we saw. It's error prone for everyone
> involved, which is why we use review to confront what we all understand.

I'm not trying to blame anyone. We all make mistakes. However, when we
have the same mistake happening in different situations, maybe we are
only dealing with the consequences and not the cause.

> This is not only an encouragement, but also a subtle hint that you will
> endlessly frustrate those who have to read more than you did, in order
> to review your proposals, only for you to complain that you have to read
> too much when making changes.

Sorry if that's what my words said. It really wasn't my intention. I'm
not complaining about reading the code. It is actually a pleasure. But
I'll bother the MDIO guys on that matter :)

> Anyway.
>
> > > I don't mean to be rude, but I don't have the time to dig into this any
> > > further, sorry. If you are truly committed to better the phylib API,
> > > please bring it up with the phylib people instead. I literally only
> > > care about the thing that Alvin pointed out, which is that you made
> > > unjustified changes to a DSA driver.
> >
> > Sure, phylib is still for netdev, right?
>
> ETHERNET PHY LIBRARY
> M:      Andrew Lunn <andrew@lunn.ch>
> M:      Heiner Kallweit <hkallweit1@gmail.com>
> R:      Russell King <linux@armlinux.org.uk>
> L:      netdev@vger.kernel.org
> S:      Maintained
> F:      Documentation/ABI/testing/sysfs-class-net-phydev
> F:      Documentation/devicetree/bindings/net/ethernet-phy.yaml
> F:      Documentation/devicetree/bindings/net/mdio*
> F:      Documentation/devicetree/bindings/net/qca,ar803x.yaml
> F:      Documentation/networking/phy.rst
> F:      drivers/net/mdio/
> F:      drivers/net/mdio/acpi_mdio.c
> F:      drivers/net/mdio/fwnode_mdio.c
> F:      drivers/net/mdio/of_mdio.c
> F:      drivers/net/pcs/
> F:      drivers/net/phy/
> F:      include/dt-bindings/net/qca-ar803x.h
> F:      include/linux/*mdio*.h
> F:      include/linux/linkmode.h
> F:      include/linux/mdio/*.h
> F:      include/linux/mii.h
> F:      include/linux/of_net.h
> F:      include/linux/phy.h
> F:      include/linux/phy_fixed.h
> F:      include/linux/phylib_stubs.h
> F:      include/linux/platform_data/mdio-bcm-unimac.h
> F:      include/linux/platform_data/mdio-gpio.h
> F:      include/trace/events/mdio.h
> F:      include/uapi/linux/mdio.h
> F:      include/uapi/linux/mii.h
> F:      net/core/of_net.c
>
> > > Oh, couldn't we straight-up revert that instead? :) The user_mii_bus
> > > is created by DSA for compatibility with non-OF. I cannot understand
> > > why you insist to attach an OF node to it.
> >
> > Please, not before this patch series gets merged or you'll break
> > MDIO-connected Realtek DSA switches, at least the IRQ handling.
> > I'll send the revert myself afterwards.
> >
> > > But otherwise, yes, it is the same situation: of_node_put(), called
> > > before unregistering an MDIO bus registered with of_mdiobus_register(),
> > > means that the full OF API on this MDIO bus may not work correctly.
> > > I don't know the exact conditions though. It might be marginal or even
> > > a bug that's impossible to trigger. I haven't tested anything.
> >
> > OK. I'll not try to fix that but revert it as soon as possible without
> > breaking existing code.
>
> Ok, I'm not saying "revert it NOW". But it would be good if you could
> revert it as part of the realtek-common series, as a last patch
> (provided that you've done your homework and nobody else relies on it).
> Or at least not forget about it.

I'll add the revert patch. I believe I just need to pay attention to
those cases where phy_read/phy_write are included in ds_ops.

> > > I understand why a driver may want a ds->user_mii_bus. And I understand
> > > why a driver may want an MDIO bus with an of_node. What I don't understand
> > > is who might want both at the same time, and why.
> >
> > That one I might be novice enough to answer :).
> >
> > When you start to write a new driver, you read the docs to get a
> > general idea. However, as code moves faster than docs, you mainly rely
> > on code. So, you just choose a driver (or a couple of them) to inspire
> > you. You normally prefer a small driver because it is less code to
> > read and it might be just enough to get started. As long as it is
> > mainline, nothing indicates it should not be used as a reference.
>
> And when you consider that DSA has better documentation than most
> subsystems out there....
>
> Would it blow your mind away if I told you that the documentation is
> written based on the code? The same code from which you draw a lazy
> conclusion.
>
> You have perfectly laid out why the code is not the problem, and why the
> documentation is not the solution. The problem is the unwillingness to
> spend time to understand, but to want to push your changes nonetheless.
> The problem is on your end. I'm sorry, it has to be said.

Oh, I did spend a lot of time on it, hundreds from my free and sleep
time :). Sometimes you just cannot understand by yourself. And yes, I
do believe in most cases I'm wrong.

> > I wasn't the one that wrote most of the Realtek DSA driver but I see
> > the same OF + user_mii_bus pattern in more than one driver. If you
> > want to stop spreading, as rewriting all affected drivers might not be
> > an option, a nice /* TODO: convert to user YXZ */ comment might do the
> > trick. An updated doc suggesting a driver to be used as an example
> > would also be nice.
>
> I don't have time, Luiz. I spent 1 and a half hours today replying
> to just your emails, and one and a half hours yesterday. I have a job.

Vladimir, I cannot thank you enough. I probably wouldn't get it (and
maybe I still didn't) without your help.

> You've made me see that I'm wasting my time writing documentation for
> people who want instant gratification instead. I don't know how to get
> to them. I'll think about it some more.

I wouldn't say submitting patches to the kernel brings some kind of
gratification (except if you are a type of masochist). I'm just trying
to help.

Probably you are spending more time answering my emails than you
should. ML are great but their knowledge tends to fade away with time.
The answer to some topics I brought should be there, not here. Save
your time for reviewing the code.

I normally work a lot more than I should just to avoid the chance of
reworking on it. A comment in code like /* This behavior is
deprecated. Please see https://kernel.org/doc/xxx */ would both avoid
the code to be spread and alert maintainers that there is some work to
be done. We all have nicer things to do instead but it could save some
future headaches. My 2 cents.

Regards,

Luiz

