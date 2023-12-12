Return-Path: <netdev+bounces-56609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9B80F9D2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEC3B20E61
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD164CD0;
	Tue, 12 Dec 2023 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5YB8JO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E7B7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:58:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33635163fe6so765241f8f.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702418284; x=1703023084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J1irfOIdDfRUtbhTevlTRDLDx7FojFxldGLahywxd4=;
        b=E5YB8JO2mj3Colyh0xWO+e+1jlpOtD0MVsbUK4MOKhlTDpaRZDIjhds5IB++M1Edbc
         blzGpFcrKWW0kKoqVXEgav/tqZ8aRkt2ObgEqPBmDK58W9NYv57V1AnQQmS8UNjdbLHC
         xZTxXafOdtThTCL+OmUPsre3Uzy8wiOhh9fgMw6e33+zAN2Wfvi1w2YxyrEZDhXEVchY
         HGqKQxoQjsH0ydBQXholA6HUCv5m7qqpgE2/kMzhX7uhVp4Fa05T/eqH+HaXP/C+g/n8
         ITFJnBP9+3gHl+kNc/dqidP458Bx0XxjZ1YOkCHFCRLH/vZhpJWznfRlMOuR7nZyp440
         loOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418284; x=1703023084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J1irfOIdDfRUtbhTevlTRDLDx7FojFxldGLahywxd4=;
        b=qrV8LuM7+Y5hp3NuZmpAZ3V4qs4XXrMzDwMMVkBHrwwfH2NXkZGRAXLq+/nHk5mS6K
         xbFn9eTbwXldPCPEEZefwgJYwr5H5WEDv2ZIrIfcDbFd1sEVyyJsfDTRmvslsVlXe8GO
         2fH1jm7WWCmjapBifU9Tj4/wW8Y95BulX04I1mFi5TVH5uJn/ZJH36dL+vSgjt6ITbws
         QAEh4Ju1QqRHm0HU/Kf0vB2AHUhCKUI2nNrmsljbk9VPnGeYLTwFxOXZKX8Dt+7SJ49p
         7820/7KyNwclVyIlCtNQyGOSFi7sZ8UYoNFpK5khJlQiIwCAPEidDXF59axR/x+yxRZJ
         S/bA==
X-Gm-Message-State: AOJu0YxKGwlFTYwE/yGxPPTKmugkaGlhepUKh3oZ48M7B/s/FPWAVK2a
	2Se9vJfg7wxBP0XkGbtBZPc=
X-Google-Smtp-Source: AGHT+IHhyYNYyulI6zijXP8vU7fxslVD0hWubLqRgAgnSx1e45/2XJQqsrDfWEgsbOkmbEU9Cr3u4w==
X-Received: by 2002:adf:fc49:0:b0:333:3fc7:f2b3 with SMTP id e9-20020adffc49000000b003333fc7f2b3mr3295889wrs.35.1702418284131;
        Tue, 12 Dec 2023 13:58:04 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id cx14-20020a05640222ae00b0054cb07a17ebsm5061295edb.31.2023.12.12.13.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:58:03 -0800 (PST)
Date: Tue, 12 Dec 2023 23:58:01 +0200
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
Message-ID: <20231212215801.ey74tgywufywa3ip@skbuf>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
 <20231211171143.yrvtw7l6wihkbeur@skbuf>
 <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>

On Tue, Dec 12, 2023 at 12:47:57AM -0300, Luiz Angelo Daros de Luca wrote:
> The unregistration happens only in mdiobus_unregister(), where, I
> guess, it should avoid OF-specific code. Even if we put OF code there,
> we would need to know during mdiobus_unregister() if the
> bus->dev.of_node was gotten by of_mdio or someone else.
> 
> I believe it is not nice to externally assign dev.of_node directly to
> mdiobus but realtek switch driver is doing just that and others might
> be doing the same thing.

Well, make up your mind: earlier you said the user_mii_bus->dev.of_node
assignment from the Realtek DSA driver is redundant, because
devm_of_mdiobus_register() -> ... -> __of_mdiobus_register() does it
anyway. So if it's redundant, you can remove it and nothing changes.
What's so "not nice" about it that's worth complaining?

Are you trying to say that you're concerned that some drivers might be
populating the mii_bus->dev.of_node manually, and then proceeding to
call the _non-OF_ mdiobus_register() variant?

Some drivers like bcm_sf2.c? :)

That will be a problem, yes. If a clean result is the goal, I guess some
consolidation needs to be done before any new rule could be added.
Otherwise, yeah, we can just snap on one more lazy layer of complexity,
no problem. My 2 cents.

> The delegation of of_node_get/put to the caller seems to be just an
> easy workaround the fact that there is no good place to put a node
> that of_mdio would get. For devm functions, we could include the
> get/put call creating a new devm_of_mdiobus_unregister() but I believe
> devm and non-devm needs to be equivalent (except for the resource
> deallocation).

How did we get here, who suggested to get and put the references to the
OF node outside of the OF MDIO API?

> > If you want, you could make the OF MDIO API get() and put() the reference,
> > instead of using something it doesn't fully own. But currently the code
> > doesn't do that. Try to acknowledge what exists, first.
> 
> What I saw in other drivers outside drivers/net is that one that
> allocates the dev will get the node before assigning dev.of_node and
> put it before freeing the device. The mdiobus case seems to be
> different. I believe it would make the code more robust if we could
> fix that inside OF MDIO API and not just document its behavior. It
> will also not break existing uses as extra get/put's are OK.
> 
> I believe we could add an unregister callback to mii_bus. It wouldn't
> be too complex:
> 
> From b5b059ea4491e9f745872220fb94d8105e2d7d43 Mon Sep 17 00:00:00 2001
> From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Date: Tue, 12 Dec 2023 00:26:06 -0300
> Subject: [PATCH] net: mdio: get/put device node during (un)registration
> 
> __of_mdiobus_register() was storing the device node in dev.of_node
> without increasing its refcount. It was implicitly delegating to the
> caller to maintain the node allocated until mdiobus was unregistered.
> 
> Now, the __of_mdiobus_register() will get the node before assigning it,
> and of_mdiobus_unregister_callback() will be called at the end of
> mdio_unregister().
> 
> Drivers can now put the node just after the MDIO registration.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> drivers/net/mdio/of_mdio.c | 12 +++++++++++-
> drivers/net/phy/mdio_bus.c |  3 +++
> include/linux/phy.h        |  3 +++
> 3 files changed, 17 insertions(+), 1 deletion(-)

I don't mean to be rude, but I don't have the time to dig into this any
further, sorry. If you are truly committed to better the phylib API,
please bring it up with the phylib people instead. I literally only
care about the thing that Alvin pointed out, which is that you made
unjustified changes to a DSA driver.

> If we don't fix that in OF MDIO API, we would need to fix
> fe7324b932222 as well, moving the put to the dsa_switch_teardown().

Oh, couldn't we straight-up revert that instead? :) The user_mii_bus
is created by DSA for compatibility with non-OF. I cannot understand
why you insist to attach an OF node to it.

But otherwise, yes, it is the same situation: of_node_put(), called
before unregistering an MDIO bus registered with of_mdiobus_register(),
means that the full OF API on this MDIO bus may not work correctly.
I don't know the exact conditions though. It might be marginal or even
a bug that's impossible to trigger. I haven't tested anything.

In any case, while I encourage you to make OF node refcounting work in
the way that you think is intuitive, I want to be clear about one thing,
and that is that I'm not onboard with modifying phylib to make a non
use-case in DSA work, aka OF-aware user_mii_bus (an oxymoron).

I understand why a driver may want a ds->user_mii_bus. And I understand
why a driver may want an MDIO bus with an of_node. What I don't understand
is who might want both at the same time, and why.

