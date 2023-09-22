Return-Path: <netdev+bounces-35832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9657AB49A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id CD7F21F22B31
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954A405C3;
	Fri, 22 Sep 2023 15:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35895171AA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:19:00 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB26A3;
	Fri, 22 Sep 2023 08:18:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0092AFF806;
	Fri, 22 Sep 2023 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695395937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A5fKltW6/gSKHcpM0/Tdg4N/kNuuqKCAurZbz737N4=;
	b=fNWcjX6bpDCL+i7ZNsYaMgr078EH++x3NTJnX7WXabc2ULL5pemH/FyDUFTH4DmjHbOxsZ
	9WAUiqfUUFMbev+PF2e5l5Nppzob6bLihQZ3bQfcYoi8sm46PhhFv+4GJvZnSZURxJdKaz
	msdaAP7HoyWTSTcXAdbd8VagWQOMJZ7l0oisCNEDC8CUgc4SpN+czUyB0i5ZEuLnAersmc
	CvtuHdqRkh7A6MMN71EAL006DXqAEo1MeDUH0Wevxoy8PhKtFxzhE7tsUfpbiS3h0EILZG
	egq0LcSpAHOzfDGb0yOgqk4g7dxCbdDKZcL6hgjXyVgSsHmQYnmjQIsL2raiuQ==
Date: Fri, 22 Sep 2023 17:18:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v3 02/11] ieee802154: Internal PAN management
Message-ID: <20230922171854.52d44c77@xps-13>
In-Reply-To: <d6ac4dbc-a5c1-fbd0-41d5-d8d87ce8e2f9@datenfreihafen.org>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
	<20230918150809.275058-3-miquel.raynal@bootlin.com>
	<d6ac4dbc-a5c1-fbd0-41d5-d8d87ce8e2f9@datenfreihafen.org>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Stefan,

stefan@datenfreihafen.org wrote on Wed, 20 Sep 2023 20:08:56 +0200:

> Hello.
>=20
> On 18.09.23 17:08, Miquel Raynal wrote:
> > Introduce structures to describe peer devices in a PAN as well as a few
> > related helpers. We basically care about:
> > - Our unique parent after associating with a coordinator.
> > - Peer devices, children, which successfully associated with us.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   include/net/cfg802154.h | 46 +++++++++++++++++++++++++
> >   net/ieee802154/Makefile |  2 +-
> >   net/ieee802154/core.c   |  2 ++
> >   net/ieee802154/pan.c    | 75 +++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 124 insertions(+), 1 deletion(-)
> >   create mode 100644 net/ieee802154/pan.c
> >=20
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index f79ce133e51a..6c7193b4873c 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h

[...]

> > @@ -478,6 +494,11 @@ struct wpan_dev { =20
> >   >   	/* fallback for acknowledgment bit setting */ =20
> >   	bool ackreq;
> > +
> > +	/* Associations */
> > +	struct mutex association_lock;
> > +	struct ieee802154_pan_device *parent;
> > +	struct list_head children;
> >   }; =20
> >   >   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev) =20
> > @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpa=
n_phy *phy)
> >   void ieee802154_configure_durations(struct wpan_phy *phy,
> >   				    unsigned int page, unsigned int channel); =20
> >   > +/** =20
> > + * cfg802154_device_is_associated - Checks whether we are associated t=
o any device
> > + * @wpan_dev: the wpan device
> > + */
> > +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev); =20
>=20
> The return value still missing in kdoc. Seems you missed this from my las=
t review. :-)

Oops, I marked it done on my side by mistake. Sorry for that mistake.

[...]

> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > new file mode 100644
> > index 000000000000..012b5e821d54
> > --- /dev/null
> > +++ b/net/ieee802154/pan.c
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IEEE 802.15.4 PAN management
> > + *
> > + * Copyright (C) 2021 Qorvo US, Inc =20
>=20
> Feel free to extend the copyright years to 2023 as well.

Right, set to 2023.

Thanks,
Miqu=C3=A8l

