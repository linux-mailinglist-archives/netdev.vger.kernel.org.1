Return-Path: <netdev+bounces-59438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226CD81ADA0
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3149285D9F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270AA4A19;
	Thu, 21 Dec 2023 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwlt7Jrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6B8F5C
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc6863d43aso2814111fa.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703130354; x=1703735154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQVYZL4Dsbf0MQSv3pwi1RUf9aPT02deP3SAq3RTeGw=;
        b=Iwlt7JrpK6A8iZdeblvT6Z6v966PgNoox+FJSrZrW3MlgN4AjW/ejobecmHMpQfNkp
         Vr6R7sTFuhXah7ynaqp3nDR8OqJyK6Amj+UWH73ASDr/phGnP3UZ9H4wu3SSHiYDpCzB
         xmmN3VwH4RCznwlPEkLZrX7QF/ZtDMn0mUjNbZG49BI49fyEd+Eft/1ttgcHrwBBFYrb
         q6MhXSNeM41Ll3DAW3srJlCCBYga3jOoZc4ifSWIKQLY3g5Xt5eCHjfz/2qH0EopNPR+
         2W+cwhh6uQfmPCRwMo93O6gQWKQ2pYv/mmUUnN8dU8RjH5g/3r+gwuYFSsmqcXgsj+W4
         6KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703130354; x=1703735154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQVYZL4Dsbf0MQSv3pwi1RUf9aPT02deP3SAq3RTeGw=;
        b=ncAYpLd+oRBMHYS0X4JTGbcwtWdkFtfJy57Ha9C6qm0x1djVtKvDBw0/uaN2Uht9WX
         qu4kwhymC9ED+EYFNyNNVq+FPfB6fMudJUqblqgMTXwgEIqAbIR8KQSNcTzpzSG0B4xu
         AW3a/u76a/oBOvBw3NmnI3NJV5pSLcnLBXMRoBrAel6vi5PRBq9QeCRqpShC+erzjubY
         5d2xUeBKasmZa+3qejkAEysIYIVyo2g36Yz53JrudNiDcJuB8wV+sStsO88CxhDfjqJB
         FP9tVtAIHIAyt3NBEQHvIKLFjMhV2/mEOU2mGrYcXplQ6M6WoWG/7eDJ/HYfsF/lOmMq
         UkFQ==
X-Gm-Message-State: AOJu0Yzt5lTLgcAFOm77gIq7p7qDH5N1Ad3qqbxzn6dx+j/EQytVQZ2T
	2+34y78do8piZ9/G8DLMqMqiaTqCUsr4G8ZRsps=
X-Google-Smtp-Source: AGHT+IHP0aqumhzVxvdJaAqVmSCYNtvPJPIealYmlARBWrc+qTcMQoM2puGqPaghTWx/jvwTiWcfWwmZKiUGkw9YGNE=
X-Received: by 2002:a2e:9f45:0:b0:2cc:8c52:df90 with SMTP id
 v5-20020a2e9f45000000b002cc8c52df90mr1123145ljk.28.1703130354357; Wed, 20 Dec
 2023 19:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220042632.26825-1-luizluca@gmail.com> <20231220042632.26825-8-luizluca@gmail.com>
 <w4qjjjt3wy5jwjxsfmg3mjqje5liocsbbnao34zbniijghx45a@3fxkroph6miz>
In-Reply-To: <w4qjjjt3wy5jwjxsfmg3mjqje5liocsbbnao34zbniijghx45a@3fxkroph6miz>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Dec 2023 00:45:43 -0300
Message-ID: <CAJq09z7QBMq9sV9pU7OuGEynndso_n6m2-uQ1WaeKskwBQizAg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] Revert "net: dsa: OF-ware slave_mii_bus"
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > This reverts commit fe7324b932222574a0721b80e72c6c5fe57960d1.
> >
> > The use of user_mii_bus is inappropriate when the hardware is described
> > with a device-tree [1].
> >
> > Since all drivers currently implementing ds_switch_ops.phy_{read,write}
> > were not updated to utilize the MDIO information from OF with the
> > generic "dsa user mii", they might not be affected by this change.
>
> /might/ not? I think this paragraph could be more precisely worded.

Yes, it should be "should". That's what I get from working instead of
sleeping. I checked all changes that have happened since that commit
touching drivers with the ds_switch_ops.phy_{read,write}. How about:

  The generic "dsa user mii" driver will only be utilized by drivers
implementing ds_switch_ops.phy_{read,write} and leaving
ds.user_mii_bus unallocated. For these drivers, no commits have been
made since the one being reverted that altered the usage of
ds.user_mii_bus. Consequently, these drivers should not be affected by
this change.

> > [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/T/#u
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  net/dsa/dsa.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> > index ac7be864e80d..cea364c81b70 100644
> > --- a/net/dsa/dsa.c
> > +++ b/net/dsa/dsa.c
> > @@ -15,7 +15,6 @@
> >  #include <linux/slab.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/of.h>
> > -#include <linux/of_mdio.h>
> >  #include <linux/of_net.h>
> >  #include <net/dsa_stubs.h>
> >  #include <net/sch_generic.h>
> > @@ -626,7 +625,6 @@ static void dsa_switch_teardown_tag_protocol(struct dsa_switch *ds)
> >
> >  static int dsa_switch_setup(struct dsa_switch *ds)
> >  {
> > -     struct device_node *dn;
> >       int err;
> >
> >       if (ds->setup)
> > @@ -666,10 +664,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
> >
> >               dsa_user_mii_bus_init(ds);
> >
> > -             dn = of_get_child_by_name(ds->dev->of_node, "mdio");
> > -
> > -             err = of_mdiobus_register(ds->user_mii_bus, dn);
> > -             of_node_put(dn);
> > +             err = mdiobus_register(ds->user_mii_bus, dn);

This patch also has an obvious compile error that I didn't catch
during my builds. I might have built just a subtree and during each
step in a rebase, missing the last one. Sorry. It should be

            err = mdiobus_register(ds->user_mii_bus);

> >               if (err < 0)
> >                       goto free_user_mii_bus;
> >       }
> > --
> > 2.43.0
> >

