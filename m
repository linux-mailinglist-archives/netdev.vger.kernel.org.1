Return-Path: <netdev+bounces-36081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A57AD20A
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DDFFB2813B9
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0310A06;
	Mon, 25 Sep 2023 07:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37310956
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 07:43:52 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF33DA;
	Mon, 25 Sep 2023 00:43:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B98211C000C;
	Mon, 25 Sep 2023 07:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695627827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKNj9kNHFfsI/RXkUhlbbB7tG3ubg40x+iFbZJBYhrc=;
	b=CWBKDXKsL6WMEJ9tsk2/bOgzx7KIAA3ASydY/o/cCn4kI0XxWPuBh4ncRC+tfrcvpV9qnf
	UHx727TU/3UsDrQUTXaiHrmZtwJ+qwHqI6d0Pze5iB73dH5jvaAGZcl47CCDIIVDd69Z3U
	4JtC4HRH+OeW4ggATmdpBAFDPcywI46FxK6jNv7+g88narn3t1QM8MSBikpPBi4am18l/j
	8cntvBCKGxqJjqdssTWiX6X7k5DJcFvtEjVgIwp9kiJbKHp6GVCpEnht2cBlbfpw7Zd9LK
	q7v0LEfWVwG7q4VL1rJyWMaa7yqS2Rmy9cmhVa0z6BTISTaLupY2Bowqnu9nrw==
Date: Mon, 25 Sep 2023 09:43:43 +0200
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
Message-ID: <20230925094343.598c81d1@xps-13>
In-Reply-To: <CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
	<20230922155029.592018-8-miquel.raynal@bootlin.com>
	<CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexander,

aahringo@redhat.com wrote on Sun, 24 Sep 2023 20:13:34 -0400:

> Hi,
>=20
> On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Coordinators may have to handle association requests from peers which
> > want to join the PAN. The logic involves:
> > - Acknowledging the request (done by hardware)
> > - If requested, a random short address that is free on this PAN should
> >   be chosen for the device.
> > - Sending an association response with the short address allocated for
> >   the peer and expecting it to be ack'ed.
> >
> > If anything fails during this procedure, the peer is considered not
> > associated.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/net/cfg802154.h         |   7 ++
> >  include/net/ieee802154_netdev.h |   6 ++
> >  net/ieee802154/core.c           |   7 ++
> >  net/ieee802154/pan.c            |  30 +++++++
> >  net/mac802154/ieee802154_i.h    |   2 +
> >  net/mac802154/rx.c              |   8 ++
> >  net/mac802154/scan.c            | 142 ++++++++++++++++++++++++++++++++
> >  7 files changed, 202 insertions(+)
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index 9b036ab20079..c844ae63bc04 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
> >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> >                           struct ieee802154_addr *target);
> >
> > +/**
> > + * cfg802154_get_free_short_addr - Get a free address among the known =
devices
> > + * @wpan_dev: the wpan device
> > + * @return: a random short address expectedly unused on our PAN
> > + */
> > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> > +
> >  #endif /* __NET_CFG802154_H */
> > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_n=
etdev.h
> > index 16194356cfe7..4de858f9929e 100644
> > --- a/include/net/ieee802154_netdev.h
> > +++ b/include/net/ieee802154_netdev.h
> > @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
> >         struct ieee802154_assoc_req_pl assoc_req_pl;
> >  };
> >
> > +struct ieee802154_association_resp_frame {
> > +       struct ieee802154_hdr mhr;
> > +       struct ieee802154_mac_cmd_pl mac_pl;
> > +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> > +};
> > +
> >  struct ieee802154_disassociation_notif_frame {
> >         struct ieee802154_hdr mhr;
> >         struct ieee802154_mac_cmd_pl mac_pl;
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index a08d75dd56ad..1670a71327a7 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
> >
> >  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> >  {
> > +       struct ieee802154_pan_device *child, *tmp;
> > +
> >         mutex_lock(&wpan_dev->association_lock);
> >
> >         kfree(wpan_dev->parent);
> >         wpan_dev->parent =3D NULL;
> >
> > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node)=
 {
> > +               list_del(&child->node);
> > +               kfree(child);
> > +       }
> > +
> >         mutex_unlock(&wpan_dev->association_lock);
> >  }
> >
> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > index 9e1f1973c294..e99c64054dcb 100644
> > --- a/net/ieee802154/pan.c
> > +++ b/net/ieee802154/pan.c
> > @@ -73,3 +73,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> >         return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > +
> > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > +{
> > +       struct ieee802154_pan_device *child;
> > +       __le16 addr;
> > +
> > +       lockdep_assert_held(&wpan_dev->association_lock);
> > +
> > +       do {
> > +               get_random_bytes(&addr, 2);
> > +               if (addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_BROAD=
CAST) ||
> > +                   addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPE=
C))
> > +                       continue;
> > +
> > +               if (wpan_dev->short_addr =3D=3D addr)
> > +                       continue;
> > +
> > +               if (wpan_dev->parent && wpan_dev->parent->short_addr =
=3D=3D addr)
> > +                       continue;
> > +
> > +               list_for_each_entry(child, &wpan_dev->children, node)
> > +                       if (child->short_addr =3D=3D addr)
> > +                               continue;
> > +
> > +               break;
> > +       } while (1);
> > + =20
>=20
> I still believe that this random 2 bytes and check if it's already
> being used is wrong here. We need something to use the next free
> available number according to the data we are storing here.

This issue I still have in mind is when you have this typology:

device A -------> device B --------> device C <-------- device D
(leaf)            (coord)            (PAN coord)            (leaf)

B associates with C
A associates with B
D associates with C

If B and C run Linux's stack, they will always have the same short
address. Yes this can be handled (realignment procedure). But any time
this happens, you'll have a load of predictable realignments when A and
D get in range with B or C.

> However it is acceptable and can be changed later...

Ok.

Thanks,
Miqu=C3=A8l

