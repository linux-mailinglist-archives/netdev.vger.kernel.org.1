Return-Path: <netdev+bounces-28823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0840780DCF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F7F1C2162B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC9A18C1B;
	Fri, 18 Aug 2023 14:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BC7ED
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 14:18:08 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D103C3D;
	Fri, 18 Aug 2023 07:17:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BD6A1C0004;
	Fri, 18 Aug 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692368275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8+h2LpE+Bx8EbOcnBEwlOM0f0VIsBmwJpKxKZpYLtQ=;
	b=eeq8HvLU89rVnmXO7saCaDy5iSBM9vQ6qlX2tKcsfoL6JDnFN+53UP/ayejXezn19X9Y8x
	E3qGFBPHUkyM+eibadbxeKH5NwSnbc39mTHWiRRHpjBp9iAjY6U6qwKX7l8Xrq2BLxL59g
	ZV49u/QaPx3nBM2IgLQ9hB1vBJcJh27ZNbks8zW6A4E5xWjzMiUt1eNegHCoM1u4pcgMnB
	SY1EVsdBCJzzs/kEdKP1Me8THVHSzhzXjY4iV1M5uIEO4jpo9I9QLRMXwbGxQawnQ42bhe
	gKCBOgEzqwy+ijgdDXjd2dlIOPYdGPV3domZ8uXVKwVlFSBtnf5ZadIa63jsYQ==
Date: Fri, 18 Aug 2023 16:17:52 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next 04/11] mac802154: Handle associating
Message-ID: <20230818161752.7f6172d0@xps-13>
In-Reply-To: <ZHoQwKiiAhfu74/U@corigine.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
	<20230601154817.754519-5-miquel.raynal@bootlin.com>
	<ZHoQwKiiAhfu74/U@corigine.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

simon.horman@corigine.com wrote on Fri, 2 Jun 2023 17:54:40 +0200:

> On Thu, Jun 01, 2023 at 05:48:10PM +0200, Miquel Raynal wrote:
> > Joining a PAN officially goes by associating with a coordinator. This
> > coordinator may have been discovered thanks to the beacons it sent in
> > the past. Add support to the MAC layer for these associations, which
> > require:
> > - Sending an association request
> > - Receiving an association response
> >=20
> > The association response contains the association status, eventually a
> > reason if the association was unsuccessful, and finally a short address
> > that we should use for intra-PAN communication from now on, if we
> > required one (which is the default, and not yet configurable).
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> ...
>=20
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index cd69bdbfd59f..8bf01bb7e858 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -198,6 +198,18 @@ void wpan_phy_free(struct wpan_phy *phy)
> >  }
> >  EXPORT_SYMBOL(wpan_phy_free);
> > =20
> > +static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> > +{
> > +	mutex_lock(&wpan_dev->association_lock);
> > +
> > +	if (wpan_dev->parent)
> > +		kfree(wpan_dev->parent); =20
>=20
> Hi Miquel,
>=20
> a minor nit from my side: There no need to check for NULL before calling
> kfree, because kfree will do nothing with a NULL argument.

Sorry for the delay, yes of course, I will drop the extra check.

Thanks,
Miqu=C3=A8l

