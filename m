Return-Path: <netdev+bounces-36559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B0D7B0720
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7A1A3282923
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E07464;
	Wed, 27 Sep 2023 14:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753233E5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:39:59 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB8FC;
	Wed, 27 Sep 2023 07:39:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EDCB1C000F;
	Wed, 27 Sep 2023 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695825594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkXlD0luF0Ph8Z90prch5he0VcI9hgbZDKRxkPhFKe0=;
	b=coqe1hu/5uluLvq4RPzJXMv+zSEsG/e5D6kawz8xCkqf7nLe01IklTIvQgBCg4vE1jx9TI
	tTLdw/vUf3pddB0lIA3mmj/HClhtDr3PNzTEHKy+XbHVmq/xsKliWFyqpjg29iDYmLHGGO
	5akjdKKwBcemJT3fKOmPraw+P/ZoZkJthmxqjh1XdZO3y5yvmX93wtBNA0y4VZ0issml7M
	4fexOLvb3MMSYy9AclUszF7lQdjur0Wmq7gXfB1UxUjYe04ADlYlb2rrAe8dIR6i3Q7VtF
	AplZJHcUnnLvuCE+foRuVpzcI9R9VotYlcXdDs6gTCsqGXaUueIkmqi/g6E3dQ==
Date: Wed, 27 Sep 2023 16:39:48 +0200
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
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association
 requests from peers
Message-ID: <20230927163948.672a479b@xps-13>
In-Reply-To: <CAK-6q+jFmvXGWOJFvHagC06mnbu6O1=Ndg8auNkGXTaqSf-7rg@mail.gmail.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
	<20230922155029.592018-8-miquel.raynal@bootlin.com>
	<CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
	<20230925094343.598c81d1@xps-13>
	<CAK-6q+jFmvXGWOJFvHagC06mnbu6O1=Ndg8auNkGXTaqSf-7rg@mail.gmail.com>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

aahringo@redhat.com wrote on Tue, 26 Sep 2023 21:31:09 -0400:

> Hi,
>=20
> On Mon, Sep 25, 2023 at 3:43=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sun, 24 Sep 2023 20:13:34 -0400:
> > =20
> > > Hi,
> > >
> > > On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote: =20
> > > >
> > > > Coordinators may have to handle association requests from peers whi=
ch
> > > > want to join the PAN. The logic involves:
> > > > - Acknowledging the request (done by hardware)
> > > > - If requested, a random short address that is free on this PAN sho=
uld
> > > >   be chosen for the device.
> > > > - Sending an association response with the short address allocated =
for
> > > >   the peer and expecting it to be ack'ed.
> > > >
> > > > If anything fails during this procedure, the peer is considered not
> > > > associated.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  include/net/cfg802154.h         |   7 ++
> > > >  include/net/ieee802154_netdev.h |   6 ++
> > > >  net/ieee802154/core.c           |   7 ++
> > > >  net/ieee802154/pan.c            |  30 +++++++
> > > >  net/mac802154/ieee802154_i.h    |   2 +
> > > >  net/mac802154/rx.c              |   8 ++
> > > >  net/mac802154/scan.c            | 142 ++++++++++++++++++++++++++++=
++++
> > > >  7 files changed, 202 insertions(+)
> > > >
> > > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > > index 9b036ab20079..c844ae63bc04 100644
> > > > --- a/include/net/cfg802154.h
> > > > +++ b/include/net/cfg802154.h
> > > > @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
> > > >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > > >                           struct ieee802154_addr *target);
> > > >
> > > > +/**
> > > > + * cfg802154_get_free_short_addr - Get a free address among the kn=
own devices
> > > > + * @wpan_dev: the wpan device
> > > > + * @return: a random short address expectedly unused on our PAN
> > > > + */
> > > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> > > > +
> > > >  #endif /* __NET_CFG802154_H */
> > > > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee8021=
54_netdev.h
> > > > index 16194356cfe7..4de858f9929e 100644
> > > > --- a/include/net/ieee802154_netdev.h
> > > > +++ b/include/net/ieee802154_netdev.h
> > > > @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
> > > >         struct ieee802154_assoc_req_pl assoc_req_pl;
> > > >  };
> > > >
> > > > +struct ieee802154_association_resp_frame {
> > > > +       struct ieee802154_hdr mhr;
> > > > +       struct ieee802154_mac_cmd_pl mac_pl;
> > > > +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> > > > +};
> > > > +
> > > >  struct ieee802154_disassociation_notif_frame {
> > > >         struct ieee802154_hdr mhr;
> > > >         struct ieee802154_mac_cmd_pl mac_pl;
> > > > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > > > index a08d75dd56ad..1670a71327a7 100644
> > > > --- a/net/ieee802154/core.c
> > > > +++ b/net/ieee802154/core.c
> > > > @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
> > > >
> > > >  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_d=
ev)
> > > >  {
> > > > +       struct ieee802154_pan_device *child, *tmp;
> > > > +
> > > >         mutex_lock(&wpan_dev->association_lock);
> > > >
> > > >         kfree(wpan_dev->parent);
> > > >         wpan_dev->parent =3D NULL;
> > > >
> > > > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, n=
ode) {
> > > > +               list_del(&child->node);
> > > > +               kfree(child);
> > > > +       }
> > > > +
> > > >         mutex_unlock(&wpan_dev->association_lock);
> > > >  }
> > > >
> > > > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > > > index 9e1f1973c294..e99c64054dcb 100644
> > > > --- a/net/ieee802154/pan.c
> > > > +++ b/net/ieee802154/pan.c
> > > > @@ -73,3 +73,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_=
dev,
> > > >         return NULL;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > > > +
> > > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > > > +{
> > > > +       struct ieee802154_pan_device *child;
> > > > +       __le16 addr;
> > > > +
> > > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > > +
> > > > +       do {
> > > > +               get_random_bytes(&addr, 2);
> > > > +               if (addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_B=
ROADCAST) ||
> > > > +                   addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_U=
NSPEC))
> > > > +                       continue;
> > > > +
> > > > +               if (wpan_dev->short_addr =3D=3D addr)
> > > > +                       continue;
> > > > +
> > > > +               if (wpan_dev->parent && wpan_dev->parent->short_add=
r =3D=3D addr)
> > > > +                       continue;
> > > > +
> > > > +               list_for_each_entry(child, &wpan_dev->children, nod=
e)
> > > > +                       if (child->short_addr =3D=3D addr)
> > > > +                               continue;
> > > > +
> > > > +               break;
> > > > +       } while (1);
> > > > + =20
> > >
> > > I still believe that this random 2 bytes and check if it's already
> > > being used is wrong here. We need something to use the next free
> > > available number according to the data we are storing here. =20
> >
> > This issue I still have in mind is when you have this typology:
> >
> > device A -------> device B --------> device C <-------- device D
> > (leaf)            (coord)            (PAN coord)            (leaf)
> >
> > B associates with C
> > A associates with B
> > D associates with C
> >
> > If B and C run Linux's stack, they will always have the same short
> > address. Yes this can be handled (realignment procedure). But any time
> > this happens, you'll have a load of predictable realignments when A and
> > D get in range with B or C.
> > =20
>=20
> I see that it can be "more" predictable, but what happens when there
> is the same short address case with the random number generator? It
> sounds to me like there needs to be a kind of duplicate address
> detection going on and then choose another one, if 802.15.4 even
> handles this case...

Yes it may happen, and yes it is handled by the spec (I did not
implement it yet). When such a situation occurs (two devices using the
same short address in a given PAN), the third-party device which
detects the faulty situation must notify its coordinator and the
coordinator (IIRC) must allocate a new short address as part of a
realignment procedure.

> I am also thinking that there is only one number left and the random
> generator runs multiple times to find the last one aka "it's random
> you can never be sure", when it always returns the same address.

I'll try to summarize the two issues and solutions we have:
- incremental short address: if two coordinators distribute
  short addresses in a PAN, at the time we perform a realignment
  procedure, if Coord A has allocated 1 short address (0) and Coord B
  in the same PAN has allocated 10 short addresses (from 0 to 9), you
  know that the device that needs a new address will be given 1, which
  will lead to a realignment, then 2, then 3... and produce a *lot* of
  noise. However despite being long on big network, we can assume the
  time to find the relevant address is bounded.
- random short address: no conflict should happen following a
  realignment procedure (assuming regular-sized networks, probability
  is very low, close to 1/65000) however in case we have a huge
  network, the time taken to find a free slot is unbounded.

At this stage I believe the former issue is more likely to happen than
the second, but the second is a bit critical as it can lead to DoS
situations. One easy way to mitigate this is to limit the number of
devices on the network (as you said in another mail, we can refuse
devices arbitrarily), which is the first denial procedure I've
implemented, knowing that it should be improved as well, as that can be
done later without much additional constraints.

> However, that's only my thoughts about it and hopefully can be
> improved in future.

Yes, I am not convinced this is the perfect choice but at least it's
simple enough and will work like a charm on small networks.

Thanks,
Miqu=C3=A8l

