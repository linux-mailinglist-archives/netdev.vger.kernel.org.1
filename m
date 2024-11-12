Return-Path: <netdev+bounces-144039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962039C530F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B08B2839AA
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36759213124;
	Tue, 12 Nov 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l+BejFZe"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FC20A5FE;
	Tue, 12 Nov 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406606; cv=none; b=A8dp/A2X7Y2Tt9IIkFWxXRUqhvhbN6zwxXpHWllP/yt6TrrQMCvbD0un4sr68yZuzezTPyEBOpKQCa+DNIp2mpUPezaMuZfUcCCk8FqdxdLZgodPyEALccou7JNHsNOxfuDjZVEug5l/P35zKvBFMq8TYtFmjaHmjC41m/q0+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406606; c=relaxed/simple;
	bh=C/BP9FVcPJ1uezwVLOwwlYDX1qvfG5XzghUAvz0KXaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZC1ULCLCFNg1y8CsGsmNZM2FHZxyaIvJYPaL77pncYLnt7y1jfXAJ4wzyOdAqFfi4KxVA7tjDBVwGFlgetVPNtIQEwtzVVnd9mZnP7iUZ2HWp7mnjwlka9kydu/S8A2h4w2Z0W/+m5QGIO4iBEX7ihcgpzNi/skKp+iQXGJ+YGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l+BejFZe; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F15A3E0005;
	Tue, 12 Nov 2024 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731406601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWhd/u5s3s71+O5VjXaZ+pcPf116rHmE/Ep6H484160=;
	b=l+BejFZeIVc+7HYLOrj+Xc2sUzOC4LJBDtFiRfKihLiEmtGfjJ76JuT/rcBynIU3hOTOKM
	Qvo5UuWQHIxgFMukSzazjyuv+kXC81xRTN8r+kbvY8hyIB3Jls/AWgmyt3KP1bVOMCKv7O
	3tYkS+RRckNrhGSIXi7xBxv2za58F3LsJYNXuOO2q8VU4vR6E7V6ejWHJXafbJ8EjBXmIQ
	wAWHltNP6B/umXy4uzlGmIdlQ3RuNUDwfK9P64sANy0E4xk9ZBotIB6S0a+vPcQujYmyAD
	JncZbpa7CGss0Jic41O+Wo2E0Y9tJoZBk+JHnqDbFHrnudi6FL5e+GzXWldj6w==
Date: Tue, 12 Nov 2024 11:16:39 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v19 09/10] net: ethtool: Add support for
 tsconfig command to get/set hwtstamp config
Message-ID: <20241112111639.5261b3cf@kmaincent-XPS-13-7390>
In-Reply-To: <955dde4b-b4ba-439f-b7d4-f64d90c58d55@linux.dev>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-9-94f8aadc9d5c@bootlin.com>
	<955dde4b-b4ba-439f-b7d4-f64d90c58d55@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 9 Nov 2024 01:43:30 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> > +	ret =3D net_hwtstamp_validate(&hwtst_config);
> > +	if (ret)
> > +		goto err_clock_put;
> > +
> > +	if (mod) {
> > +		struct kernel_hwtstamp_config zero_config =3D {0};
> > +		struct hwtstamp_provider *__hwtstamp;
> > +
> > +		/* Disable current time stamping if we try to enable
> > +		 * another one
> > +		 */
> > +		ret =3D dev_set_hwtstamp_phylib(dev, &zero_config,
> > info->extack); =20
> 	=09
> _hwtst_config is still inited to 0 here, maybe it can be used to avoid
> another stack allocation?

You are right, thanks!

>=20
> > +		if (ret < 0)
> > +			goto err_clock_put;
> > +
> > +		/* Change the selected hwtstamp source */
> > +		__hwtstamp =3D rcu_replace_pointer_rtnl(dev->hwtstamp,
> > hwtstamp);
> > +		if (__hwtstamp)
> > +			call_rcu(&__hwtstamp->rcu_head,
> > +				 remove_hwtstamp_provider);
> > +	} else {
> > +		/* Get current hwtstamp config if we are not changing the
> > +		 * hwtstamp source
> > +		 */
> > +		ret =3D dev_get_hwtstamp_phylib(dev, &_hwtst_config); =20
>=20
> This may be tricky whithout ifr set properly. But it should force
> drivers to be converted.

It is the point, it even return not supported error if ndo_hwtstamp_set/get=
 are
not defined.
=20
> > +		if (ret < 0 && ret !=3D -EOPNOTSUPP)
> > +			goto err_clock_put;
> > +	}
> > +
> > +	if (memcmp(&hwtst_config, &_hwtst_config, sizeof(hwtst_config))) {
> > =20
>=20
> better to use kernel_hwtstamp_config_changed() helper here

Oh yes, thanks for pointing it out.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

