Return-Path: <netdev+bounces-49156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3817F0F4C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A862B20FE5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4E11C94;
	Mon, 20 Nov 2023 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CgzvaRl9"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800394;
	Mon, 20 Nov 2023 01:44:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DD06C0007;
	Mon, 20 Nov 2023 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700473482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRwo00+jtt7LDV8N20Ju5aZbZkWbKyYh1LA49h3QOv0=;
	b=CgzvaRl9Tf8DVnPQ5vTuF4NUswYQSOr+/LRzIO4OVH9761SFi8DqK3q6umgXbPC7PvsrOf
	R6i9fUhyZkmwdJzMZj0vu95uyitf2mdnmE49UjpRV2O3zWvqfm7Q5nOriP61qTNWvnqnG6
	95x9PRYTkhGS9t7PvN8ILkpSrmJARR0vHeGGjGI6VwF7kwzk38jmnDPceqdYMB0sQ2IAMj
	S5wpowHzmDyHW4SW8Dj1zIiBi2Ac9BVGBMX0sIgDqhcnaQbnIaYPzgwLZ5ctXZDS2x97nl
	fNNgtYVIj0+K4aQE5bTOxrELFrAr/yp9iES50Bl8CBh+nsH7F17rYwf0hgHnZQ==
Date: Mon, 20 Nov 2023 10:44:39 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
In-Reply-To: <20231118183433.30ca1d1a@kernel.org>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
	<20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
	<20231118183433.30ca1d1a@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 18 Nov 2023 18:34:33 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 14 Nov 2023 12:28:43 +0100 Kory Maincent wrote:
> > +	if (!tb[ETHTOOL_A_TS_LAYER])
> > +		return 0; =20
>=20
> GENL_REQ_ATTR_CHECK(), not sure why anyone would issue this command
> without any useful attr.
>=20
> > +	/* Disable time stamping in the current layer. */
> > +	if (netif_device_present(dev) &&
> > +	    (dev->ts_layer =3D=3D PHY_TIMESTAMPING ||
> > +	    dev->ts_layer =3D=3D MAC_TIMESTAMPING)) {
> > +		ret =3D dev_set_hwtstamp_phylib(dev, &config, info->extack);
> > +		if (ret < 0)
> > +			return ret; =20
>=20
> So you only support PHYLIB?
>=20
> The semantics need to be better documented :(

Yes as we don't really know how each MAC deal with the timestamping
before ndo_hwstamp_get/set. Using phylib only allows us to be sure these ND=
O are
implemented and the management of timestamping is coherent in the MAC. Also=
 It
will push people to move on to these NDOs.

Ok I will add documentation.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

