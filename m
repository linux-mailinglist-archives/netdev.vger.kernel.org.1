Return-Path: <netdev+bounces-144038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2529C5387
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B988AB2699D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618292101A4;
	Tue, 12 Nov 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HjlcHIwc"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95EF1A256C;
	Tue, 12 Nov 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406360; cv=none; b=mPqrdB5FTpwuPf00iNM5ydtA9gFmWnaJuLBNMk+hNziA+awoE0ZZke8uVLXIvbXDkmFj+SFvgUqur9vUBRcHJ2ACS39+AfCxoXgo/S6Ur5OTU2WvDWvxcrGoH5kwpv0rowDiV5AM/eAktGFaXKV7j5rP1jmzS3yyhrhwpazK3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406360; c=relaxed/simple;
	bh=10Vohnv0zoyoiQfJYw14Zr7DLSul2HBIMs87Qfknm0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOW11d+oPUzcpnabDtyZrS4OVVUDj4bPWjjlIOK1GHaOjKdJpKhdBUkPGcvsitS5kqW0QJM0Oi+PCRC90I8BlSnwaGdiIApmNvc98Pw3e7YOKyVb9YHX0xax/PzG34Nh8O5jkcQEVhB7TmzLQ9dIyCe7+a0iel9UG6R5er49zWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HjlcHIwc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BB89E0008;
	Tue, 12 Nov 2024 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731406356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfZKRXZxR++lyRy1azbMldOQBrgpbj6acG83Qn22+g4=;
	b=HjlcHIwcSXIt5eP+c7DKoz7xXiQIL5UUSMNhPCw2ksAJBF/yqWMqI9Q97zAQl1cZz/HD+V
	lOcqojQQdH7J4OL+eBF7XCZcUPt5VZzX0gp9XAV11+8drcphQo2rM4/hF4M3Yl69VrJaTw
	RFGNjndrOA4a0CxBcVnQxvDAa/w2gryISher10lChmLvuu/qDkCvR2uaq0TzKDOPv++YbQ
	0zyj1Cp/TweI5jCJlvc3D6QQYFrWHkoAyLibTJujri2mJ/0Fm31jHCynHN8WnSUrDDhO6w
	dfuwGkjQg+mLAr3+I5NQiukXWPgDkI8a0YJPWT1SbBNIoPbJ9V7ZitprBIQ/dQ==
Date: Tue, 12 Nov 2024 11:12:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
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
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241112111232.1637f814@kmaincent-XPS-13-7390>
In-Reply-To: <20241111150609.2b0425f6@kernel.org>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
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

On Mon, 11 Nov 2024 15:06:09 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 30 Oct 2024 14:54:45 +0100 Kory Maincent wrote:
> > @@ -41,6 +43,11 @@ struct ptp_clock {
> >  	struct ptp_clock_info *info;
> >  	dev_t devid;
> >  	int index; /* index into clocks.map */
> > +	enum hwtstamp_source phc_source;
> > +	union { /* Pointer of the phc_source device */
> > +		struct net_device *netdev;
> > +		struct phy_device *phydev;
> > +	}; =20
>=20
> Storing the info about the "user" (netdev, phydev) in the "provider"
> (PHC) feels too much like a layering violation. Why do you need this?

The things is that, the way to manage the phc depends on the "user".
ndo_hwtstamp_set for netdev and phy_hwtstamp_set for phydev.
https://elixir.bootlin.com/linux/v6.11.6/source/net/core/dev_ioctl.c#L323

Before PHC was managed by the driver "user" so there was no need for this
information as the core only gives the task to the single "user". This didn=
't
really works when there is more than one user possible on the net topology.

> In general I can't shake the feeling that we're trying to configure=20
> the "default" PHC for a narrow use case, while the goal should be=20
> to let the user pick the PHC per socket.

Indeed PHC per socket would be neat but it would need a lot more work and I=
 am
even not sure how it should be done. Maybe with a new cmsg structure contai=
ning
the information of the PHC provider?
In any case the new ETHTOOL UAPI is ready to support multiple PHC at the sa=
me
time when it will be supported.
This patch series is something in the middle, being able to enable all the =
PHC
on a net topology but only one at a time.

> > +/**
> > + * netdev_ptp_clock_register() - Register a PTP hardware clock driver =
for
> > + *				 a net device
> > + *
> > + * @info: Structure describing the new clock.
> > + * @dev:  Pointer of the net device. =20
>=20
> > +/**
> > + * ptp_clock_from_netdev() - Does the PTP clock comes from netdev
> > + *
> > + * @ptp:  The clock obtained from net/phy_ptp_clock_register().
> > + *
> > + * Return: True if the PTP clock comes from netdev, false otherwise. =
=20
>=20
> > +/**
> > + * ptp_clock_netdev() - Obtain the net_device reference of PTP clock =
=20
>=20
> nit: pick one way to spell netdev ?

Yup indeed.
=20
> > +	ret =3D ptp_clock_get(dev, ptp);
> > +	if (ret)
> > +		return ERR_PTR(ret); =20
>=20
> why do you take references on the ptp device?

Because we only select one PHC at a time on the net topology.
We need to avoid the selected PTP pointer being freed.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

