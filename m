Return-Path: <netdev+bounces-31762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A2E79001F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AFA1C20873
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C0C132;
	Fri,  1 Sep 2023 15:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86423BC
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 15:45:52 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37710E4;
	Fri,  1 Sep 2023 08:45:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DABE3FF803;
	Fri,  1 Sep 2023 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693583147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eE3qgu3x6/GrX88lBaW9YyXsn7DQIvGzCmJgZvdFqtM=;
	b=A0JLxx43TCRvsxIAObhhC/C6t2VTHPvPR6NMc9HnGh/IKcnz/2xWByoDA5GoVHkqc7xdfO
	3oxeyy0fvEb6WExEcQVVdqxouG6gXhmRJrJLF9i80NgTNjMT6nsZpO8os277ginja7lGq5
	NAKXUi1lexjm6p9TWSm6V7bmuI6Vuh8xolJQkveTYjSt+Mqk9w8btsiW9mOSlGgZTx0pt4
	uZqqvOCxF5mC/Aoxdc3AZZ1PQIbfYgOvkhxkDZ7h1Zo/8fDDYuQot5A4pTtFV5ZV/7vqUA
	YmoODyLgOoPDWJjLMOM8/wgUxDkU6yoUNEKNQQoDkOJhqSjykkxRF9NblvXNPA==
Date: Fri, 1 Sep 2023 17:45:37 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next 07/11] mac802154: Handle association requests
 from peers
Message-ID: <20230901174537.50f88d60@xps-13>
In-Reply-To: <20230821105259.4659dd74@xps-13>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
	<20230601154817.754519-8-miquel.raynal@bootlin.com>
	<CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
	<20230821105259.4659dd74@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

> > > --- a/net/ieee802154/pan.c
> > > +++ b/net/ieee802154/pan.c
> > > @@ -66,3 +66,30 @@ cfg802154_device_is_child(struct wpan_dev *wpan_de=
v,
> > >         return NULL;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > > +
> > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > > +{
> > > +       struct ieee802154_pan_device *child;
> > > +       __le16 addr;
> > > +
> > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > +
> > > +       do {
> > > +               get_random_bytes(&addr, 2);   =20
> >=20
> > This is combined with the max associations setting? I am not sure if
> > this is the best way to get free values from a u16 value where we have
> > some data structure of "given" addresses to a node. I recently was
> > looking into idr/xarray data structure... maybe we can use something
> > from there. =20
>=20
> I actually thought about using an increasing index, but the pseudo
> random generator seemed appropriate because of its "unpredictability",
> but there is not real use for that (besides maybe testing purposes). I
> can definitely switch to another solution.

I looked into this deeper. I didn't felt like idr would be so much
useful, but I started converting the code to use ida instead (so the
simplest approach, with no associated pointer). There are actually two
use cases which clearly match better the random address mechanism.

a/ One can freely decide the short address of the coordinator (it is
freely selectable by the user) but ida has no mechanism to handle this
with an API which would prevent such "number to be used".

In practice, this could be workarounded "easily", even though the
implementation would be dirty IMHO: getting an IDA, if it matches ours,
just try again without freeing it. TBH I don't like much this idea.

b/ In case we ever want to support master handover, the ida solution
does not work well...

For now I've kept the current approach (actually adding a missing
check), but if you know how to solve that I can either update the
implementation or make a followup patch, especially since the current
approach is not bounded (in the theoretical case where we have 65k
devices in the same PAN).

I believe the allocation strategies are not set in stone anyway and can
easily evolve.

Thanks,
Miqu=C3=A8l

