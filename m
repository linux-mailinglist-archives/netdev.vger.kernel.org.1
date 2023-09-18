Return-Path: <netdev+bounces-34441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7777A42F8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE8B1C210B8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E079FD;
	Mon, 18 Sep 2023 07:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBBD79F4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:40:49 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C230C2;
	Mon, 18 Sep 2023 00:37:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BB8C1C000C;
	Mon, 18 Sep 2023 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695022623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMUXF3i8vZfKK4TTptUJRX/v1cTmR9n/zzTlrk9sT30=;
	b=asePB56APJvEKxXg2/wykZhHucA9qXsW29IS7M3aPZVcYUoS8NiV9wGwSZqFJox37PN5ct
	X6cmoE+pCJ3Csv2IiPARuibGhOiAVsPunAgkkWv4+wI0qpU5FNkGqwQoABj4Wg6lK091C6
	I96m+MaaezZlseSbNfYxbqX3AZjgsv9/+RezEPZMh6lHGlk/4CKwDibrDzE+2XRZqyxpNF
	4vogm0qInZgZTPKtwAr/uG7zLIE/UiMrPLes1Xa3JnESGqEOiOLhrdBA5deXVKHnncTkFG
	wfPUvDs/3sW1uOugSZMKjAtOpMXQ782ZsN2OXcbbggMK9LK40MevTQwQ3Hfq5w==
Date: Mon, 18 Sep 2023 09:36:59 +0200
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
Subject: Re: [PATCH wpan-next v2 07/11] mac802154: Handle association
 requests from peers
Message-ID: <20230918093659.6488891a@xps-13>
In-Reply-To: <7b9b1b97-7c02-06b3-7a84-db1f33784be3@datenfreihafen.org>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
	<20230901170501.1066321-8-miquel.raynal@bootlin.com>
	<7b9b1b97-7c02-06b3-7a84-db1f33784be3@datenfreihafen.org>
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

Hi Stefan,

> > +static int
> > +mac802154_send_association_resp_locked(struct ieee802154_sub_if_data *=
sdata,
> > +				       struct ieee802154_pan_device *target,
> > +				       struct ieee802154_assoc_resp_pl *assoc_resp_pl)
> > +{
> > +	u64 teaddr =3D swab64((__force u64)target->extended_addr);
> > +	struct ieee802154_association_resp_frame frame =3D {};
> > +	struct ieee802154_local *local =3D sdata->local;
> > +	struct wpan_dev *wpan_dev =3D &sdata->wpan_dev;
> > +	struct sk_buff *skb;
> > +	int ret;
> > +
> > +	frame.mhr.fc.type =3D IEEE802154_FC_TYPE_MAC_CMD;
> > +	frame.mhr.fc.security_enabled =3D 0;
> > +	frame.mhr.fc.frame_pending =3D 0;
> > +	frame.mhr.fc.ack_request =3D 1; /* We always expect an ack here */
> > +	frame.mhr.fc.intra_pan =3D 1;
> > +	frame.mhr.fc.dest_addr_mode =3D IEEE802154_EXTENDED_ADDRESSING;
> > +	frame.mhr.fc.version =3D IEEE802154_2003_STD;
> > +	frame.mhr.fc.source_addr_mode =3D IEEE802154_EXTENDED_ADDRESSING;
> > +	frame.mhr.seq =3D 10; =20
>=20
> Where does the 10 come from and what is the meaning?

Good point, that is a leftover from my earlier WIP versions. A few lines
below this is overwritten by:

	frame.mhr.seq =3D atomic_inc_return(&wpan_dev->dsn) & 0xFF;

I'll of course drop the `seq =3D 10` line.

Thanks,
Miqu=C3=A8l

