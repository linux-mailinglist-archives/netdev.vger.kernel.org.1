Return-Path: <netdev+bounces-56882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1088981126E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2021281462
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B22C845;
	Wed, 13 Dec 2023 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSLXg6g+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6705AF2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:04:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so917497866b.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702472663; x=1703077463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fi0Pv8OBwBSKa4VbO77xNSYbdM01eCCTvzKo/l6XyY=;
        b=OSLXg6g+oweP74a+OYcFfoZW2qzcH1vUC02S5TInb8hsOK8l+r84Bjrdz1Tupcmge+
         s80NWUuaMphM7OKd9uUbvqNEIp4TmhgHtLXKwb7Aqw3G1dmOPI0Z+GmPda0kREXbbvl3
         AFJr1PDXrjtGPm89/dh+aSUD+NM9B29WOJa0C1eDxA8xnHGGMidIcFt8tYhCl2jLMGoc
         CrhcBkVKaZ7YuZqYq+dX0GbIu6VmpRCpadujBH56L9Jo4diDhC7V/ca0U0tuwPWxpG8T
         zHa+oM7NkTQgdKx4ozHyHHNt1ZUeoZw5iIeAmuAYN1tHhACslV+8AoOUhEuNrjVG9FcX
         Tjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472663; x=1703077463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fi0Pv8OBwBSKa4VbO77xNSYbdM01eCCTvzKo/l6XyY=;
        b=RS6luJxeyndqSE/953kerOPyJ1hP/o0DsqL6P93MXxHIWbgAy78L2fhthTuUgMATZ5
         gnxqC5em1/miDDmTl2RiYtVC4EpSVgRI5P1rFhBsCHT3050/1mZr9H6C/gTpGyerZEQG
         3CzjKwwxycGp8bMyaIrEwDgRebqMydPrNmBJYuyuRNafVGkHL6d6ROKWl7OcqetyiU3J
         4Db3LCc1puSvY5ExhBVZL89B3Wr3TRLlnASV3d7LQoKE3s9qOAyE4vVCgZFIniuBwWO7
         237sALDff128dcykJh9idL2Gh8y24vmpmRi/3K5aOSXL+Nn3V5IYWcivcoGDR/1pKviE
         6ZMw==
X-Gm-Message-State: AOJu0YxU2GLpVD73alHWG2kRGxd5ph/d6aMv+4zPLhLiZbhpzeHiTbl+
	vaYapjIQx68X8Y051mnJG0c=
X-Google-Smtp-Source: AGHT+IF5KdbjcUR+Che/jiu0dzhLwwWqlK09EwEMVmw5pg4iCdkcbsn7cyBPtvElLx64gX1oQVWAnQ==
X-Received: by 2002:a17:907:1c91:b0:a1d:310f:13f0 with SMTP id nb17-20020a1709071c9100b00a1d310f13f0mr5104919ejc.127.1702472662508;
        Wed, 13 Dec 2023 05:04:22 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id vx4-20020a170907a78400b00a0a2553ec99sm7741833ejc.65.2023.12.13.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:04:22 -0800 (PST)
Date: Wed, 13 Dec 2023 15:04:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO
 registration
Message-ID: <20231213130419.flgob4mhi6hrxgn2@skbuf>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
 <20231211171143.yrvtw7l6wihkbeur@skbuf>
 <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>
 <20231212215801.ey74tgywufywa3ip@skbuf>
 <CAJq09z6veGUNymR6hxabBPercR6+7gFC-FhwiVM+wScm5xDREA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6veGUNymR6hxabBPercR6+7gFC-FhwiVM+wScm5xDREA@mail.gmail.com>

On Wed, Dec 13, 2023 at 01:37:27AM -0300, Luiz Angelo Daros de Luca wrote:
> The answer "just read (all the multiple level and different) code
> (paths)" is fated to fail. The put after registration in DSA core code
> is just an example of how it did not work.

If you try to think critically about the changes you make, you'll get
better at it with time. Reading code is what we all do, really, and
making educated guesses about what we saw. It's error prone for everyone
involved, which is why we use review to confront what we all understand.

This is not only an encouragement, but also a subtle hint that you will
endlessly frustrate those who have to read more than you did, in order
to review your proposals, only for you to complain that you have to read
too much when making changes.

Anyway.

> > I don't mean to be rude, but I don't have the time to dig into this any
> > further, sorry. If you are truly committed to better the phylib API,
> > please bring it up with the phylib people instead. I literally only
> > care about the thing that Alvin pointed out, which is that you made
> > unjustified changes to a DSA driver.
> 
> Sure, phylib is still for netdev, right?

ETHERNET PHY LIBRARY
M:	Andrew Lunn <andrew@lunn.ch>
M:	Heiner Kallweit <hkallweit1@gmail.com>
R:	Russell King <linux@armlinux.org.uk>
L:	netdev@vger.kernel.org
S:	Maintained
F:	Documentation/ABI/testing/sysfs-class-net-phydev
F:	Documentation/devicetree/bindings/net/ethernet-phy.yaml
F:	Documentation/devicetree/bindings/net/mdio*
F:	Documentation/devicetree/bindings/net/qca,ar803x.yaml
F:	Documentation/networking/phy.rst
F:	drivers/net/mdio/
F:	drivers/net/mdio/acpi_mdio.c
F:	drivers/net/mdio/fwnode_mdio.c
F:	drivers/net/mdio/of_mdio.c
F:	drivers/net/pcs/
F:	drivers/net/phy/
F:	include/dt-bindings/net/qca-ar803x.h
F:	include/linux/*mdio*.h
F:	include/linux/linkmode.h
F:	include/linux/mdio/*.h
F:	include/linux/mii.h
F:	include/linux/of_net.h
F:	include/linux/phy.h
F:	include/linux/phy_fixed.h
F:	include/linux/phylib_stubs.h
F:	include/linux/platform_data/mdio-bcm-unimac.h
F:	include/linux/platform_data/mdio-gpio.h
F:	include/trace/events/mdio.h
F:	include/uapi/linux/mdio.h
F:	include/uapi/linux/mii.h
F:	net/core/of_net.c

> > Oh, couldn't we straight-up revert that instead? :) The user_mii_bus
> > is created by DSA for compatibility with non-OF. I cannot understand
> > why you insist to attach an OF node to it.
> 
> Please, not before this patch series gets merged or you'll break
> MDIO-connected Realtek DSA switches, at least the IRQ handling.
> I'll send the revert myself afterwards.
> 
> > But otherwise, yes, it is the same situation: of_node_put(), called
> > before unregistering an MDIO bus registered with of_mdiobus_register(),
> > means that the full OF API on this MDIO bus may not work correctly.
> > I don't know the exact conditions though. It might be marginal or even
> > a bug that's impossible to trigger. I haven't tested anything.
> 
> OK. I'll not try to fix that but revert it as soon as possible without
> breaking existing code.

Ok, I'm not saying "revert it NOW". But it would be good if you could
revert it as part of the realtek-common series, as a last patch
(provided that you've done your homework and nobody else relies on it).
Or at least not forget about it.

> > I understand why a driver may want a ds->user_mii_bus. And I understand
> > why a driver may want an MDIO bus with an of_node. What I don't understand
> > is who might want both at the same time, and why.
> 
> That one I might be novice enough to answer :).
> 
> When you start to write a new driver, you read the docs to get a
> general idea. However, as code moves faster than docs, you mainly rely
> on code. So, you just choose a driver (or a couple of them) to inspire
> you. You normally prefer a small driver because it is less code to
> read and it might be just enough to get started. As long as it is
> mainline, nothing indicates it should not be used as a reference.

And when you consider that DSA has better documentation than most
subsystems out there....

Would it blow your mind away if I told you that the documentation is
written based on the code? The same code from which you draw a lazy
conclusion.

You have perfectly laid out why the code is not the problem, and why the
documentation is not the solution. The problem is the unwillingness to
spend time to understand, but to want to push your changes nonetheless.
The problem is on your end. I'm sorry, it has to be said.

> I wasn't the one that wrote most of the Realtek DSA driver but I see
> the same OF + user_mii_bus pattern in more than one driver. If you
> want to stop spreading, as rewriting all affected drivers might not be
> an option, a nice /* TODO: convert to user YXZ */ comment might do the
> trick. An updated doc suggesting a driver to be used as an example
> would also be nice.

I don't have time, Luiz. I spent 1 and a half hours today replying
to just your emails, and one and a half hours yesterday. I have a job.

You've made me see that I'm wasting my time writing documentation for
people who want instant gratification instead. I don't know how to get
to them. I'll think about it some more.

