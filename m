Return-Path: <netdev+bounces-36573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B47B09AC
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D5A441C2080C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E049996;
	Wed, 27 Sep 2023 16:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B437151
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 16:10:17 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37A10A;
	Wed, 27 Sep 2023 09:10:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DCCEC0006;
	Wed, 27 Sep 2023 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695831013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkB07NP/6E3mJjWdfwXaQTnbziVycVwnUCTuOaf7y2A=;
	b=H/lYRKXl6sgtpw5vFxwaXYQLKy+Xrqt5SBfQO5mM9wn8pwc8xokwo84Hr25zADC9CJdKIx
	wp5r+Bp7TNqPmmcvmgweP0EuWdQJghhJvjHF+9X9Aio4Nvcc2dznXK4dAW42e/hGO6WIho
	jSLuE6jZdGKFRdIsG6jKEa3gKMD/NPAjo5B2aqck5Q1D71FTbXtO4J7KqfsbLd8MROlHUM
	XVnwxPXsIRgflGHRdqlumtp1/Qhu5j2UOr3LM5+LWgaHqYcWTzB79XmAjg+q8DKKMJ/tyX
	v4qqtBsL7DBafJpTjUU4Qp0QWpjROIwSBgzr6+H4x9wdSz2rz89lf70J/TAzsQ==
Date: Wed, 27 Sep 2023 18:10:05 +0200
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
Subject: Re: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
Message-ID: <20230927175635.2404e28a@xps-13>
In-Reply-To: <CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
References: <20230922155029.592018-1-miquel.raynal@bootlin.com>
	<20230922155029.592018-3-miquel.raynal@bootlin.com>
	<CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
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

> > +
> > +#include <linux/kernel.h>
> > +#include <net/cfg802154.h>
> > +#include <net/af_ieee802154.h>
> > +
> > +/* Checks whether a device address matches one from the PAN list.
> > + * This helper is meant to be used only during PAN management, when we=
 expect
> > + * extended addresses to be used.
> > + */
> > +static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pan_=
dev,
> > +                                   struct ieee802154_addr *ext_dev)
> > +{
> > +       if (!pan_dev || !ext_dev)
> > +               return false;
> > +
> > +       if (ext_dev->mode =3D=3D IEEE802154_ADDR_SHORT)
> > +               return false;
> > +
> > +       switch (ext_dev->mode) {
> > +       case IEEE802154_ADDR_SHORT:
> > +               return pan_dev->short_addr =3D=3D ext_dev->short_addr; =
=20
>=20
> This is dead code now, it will never be reached, it's checked above
> (Or I don't see it)? I want to help you here. What exactly do you try
> to reach here again?

It's a left over. All association/disassociation operation so far which
need these checks are operated using extended addressing (from the
spec). I will simplify further this helper.


> > +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> > +                               struct ieee802154_addr *target)
> > +{
> > +       lockdep_assert_held(&wpan_dev->association_lock);
> > +
> > +       if (cfg802154_device_in_pan(wpan_dev->parent, target))
> > +               return true;
> > +
> > +       return false; =20
>=20
> return cfg802154_device_in_pan(...); Why isn't checkpatch warning about t=
hat?

checkpatch does not care I guess, but I can definitely simplify this
return path as well, you're right.

Thanks,
Miqu=C3=A8l

