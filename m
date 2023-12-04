Return-Path: <netdev+bounces-53524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951978038C8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F7C1C20A6B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD962C849;
	Mon,  4 Dec 2023 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WIp3PXXi"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8F2B0;
	Mon,  4 Dec 2023 07:28:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D4EE240009;
	Mon,  4 Dec 2023 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701703708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0JOcf6jkxhgsas+jU7HoD00NuB8enDjPLTaHOqduD0=;
	b=WIp3PXXigOKUmqQlWs81eU0ETi9SOluh1iT/y7P8wqndtOZRUNjGwUuN5PUIFmqWUasfE0
	wDXOHIiQ8oms3C9dcNLzivgpnhKlkUkYsYks/IvHI5/ozbvzV39ncvpIDP1pNrBlSjGkto
	vRzqRUZmXUuQOqx/01B3/fMqOUnPv6gmYdFhQsRm9YxBITcnFc5De9BYSoGxBIrqy5mump
	YPa+/IF0L7aagdbcXfmCpk9EnY3qdlfgC3nhU6uXt2VOiYKk4nMJz9Mo8MLClM9TcXuMRS
	1fDoLiCxEB5vNg21VJFNY1oSDaDpgPDHVguVyrfNDBHIXvtt3RzDh2Qahl0pbQ==
Date: Mon, 4 Dec 2023 16:28:25 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <20231204162825.40e566fe@kmaincent-XPS-13-7390>
In-Reply-To: <e0b143dc-ca7e-4762-bd0b-3acffad0932b@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
	<20231201-feature_poe-v2-4-56d8cac607fa@bootlin.com>
	<e0b143dc-ca7e-4762-bd0b-3acffad0932b@lunn.ch>
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

On Sun, 3 Dec 2023 19:45:18 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > @@ -143,6 +150,43 @@ ethnl_set_pse(struct ethnl_req_info *req_info, str=
uct
> > genl_info *info) return -EOPNOTSUPP;
> >  	}
> > =20
> > +	if (!tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
> > +	    !tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
> > +		return 0; =20
>=20
> -EINVAL? Is there a real use case for not passing either of them?

No indeed.

> > +
> > +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL] &&
> > +	    !(pse_get_types(phydev->psec) & PSE_PODL)) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
> > +				    "setting PSE PoDL admin control not
> > supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
> > +	    !(pse_get_types(phydev->psec) & PSE_C33)) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL],
> > +				    "setting PSE PoE admin control not
> > supported"); =20
>=20
> This probably should be C33, not PoE?
>=20
> I guess it depends on what the user space tools are using.=20

Yes, I have hesitated on replacing that one.
If you prefer c33 in the log, I will change it in next version

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

