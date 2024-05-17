Return-Path: <netdev+bounces-96991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DB8C893D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6890C1C22452
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45812CDBB;
	Fri, 17 May 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LwnM3V7e"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E212D77C;
	Fri, 17 May 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959282; cv=none; b=PMwhTVG/W2UYCRrxUSoW6gC/K4ggkayemIzOmVvVUU5M/KNgMC2hiIoCpk++b4fuBF5lLAjCrwIq1RhrjpHOclEzwoMxfh0CgD+9TCuWORskmISZPlXGnpDxG00THFu5bFIR+MJUTGmv3JPdOZ8irY/10bNhWBNCWarw9WCgysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959282; c=relaxed/simple;
	bh=wOMTQcCv4RXt7oOImw1VgaZvQGn5ykZzqAP4bE+CoMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBcXrKDLEb0ejP2Qq9GmlCClZLuGesiwuhvmoobFJ1iguqRGZp2dbEk1WghVjkhMYE3Vst8q8uQOsa2lZQh1UWdXtHt531KjAfD27K/4ouMRgCrwOaFAmQ+XboK2aUJ950OAcWvcytTyyjOphpvHRy9dFgCBHz/8DGQv2IjTCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LwnM3V7e; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay4-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::224])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 35ED8C3359;
	Fri, 17 May 2024 15:13:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B596E0006;
	Fri, 17 May 2024 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715958778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeTxGtF/EgpBohuFwBuKpus55RrUZBrBwjxJhjj16pM=;
	b=LwnM3V7eJkdBSvC60vIBB/gpmPTBTg45+MHoX5J3y8e6MIDgjtuDAaAZJ8PO2C/IkLxcT7
	dgYAigX8S8JnySY+TiK9KFRyJ6asu9Vr9N/2FCiaz+xr0LPFBi76HAX4kqY50rxRcjf97D
	A8kKU94tWLDMIy6Ey/QDQfO93fYSp5Hq7pqCKrKJtymojYj/tuG6J7U3mhyLW8JBzWDXux
	bCtkutz/3IvYXnPvFFAIygoP3SvO5+iupK52xZyOdetxcgIw7p2g33CRPx59cdGfUOspqN
	SZnpVfQ+i8F1qBDKJIKM9OJN6ho4rPhKDmk/fnQC6OIJ5LRkaY9o/f7ry0mhtg==
Date: Fri, 17 May 2024 17:12:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
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
 UNGLinuxDriver@microchip.com, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v12 12/13] net: ethtool: tsinfo: Add support
 for hwtstamp provider and get/set hwtstamp config
Message-ID: <20240517171254.1e316e69@kmaincent-XPS-13-7390>
In-Reply-To: <20240504103305.GD3167983@kernel.org>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
	<20240430-feature_ptp_netnext-v12-12-2c5f24b6a914@bootlin.com>
	<20240504103305.GD3167983@kernel.org>
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

On Sat, 4 May 2024 11:33:05 +0100
Simon Horman <horms@kernel.org> wrote:

> Hi Kory,
>=20
> A few lines beyond this hunk, within the "if (hwtstamp)" block,
> is the following:
>=20
> 		cfg->qualifier =3D dev->hwtstamp->qualifier;
>=20
> Now that dev->hwtstamp is managed using RCU, I don't think it is correct
> to dereference it directly like this. Rather, the hwtstamp local variable,
> which has rcu_dereference'd this pointer should be used:
>=20
> 		 cfg->qualifier =3D hwtstamp->qualifier;
>=20
> Flagged by Sparse.

Yes indeed, thanks for the report.

>=20
> ...
>=20
> > diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c =20
>=20
> ...
>=20
> > +static int ethnl_tsinfo_dump_one_dev(struct sk_buff *skb, struct
> > net_device *dev,
> > +				     struct netlink_callback *cb)
> > +{
> > +	struct ethnl_tsinfo_dump_ctx *ctx =3D (void *)cb->ctx;
> > +	struct ptp_clock *ptp;
> > +	int ret;
> > +
> > +	netdev_for_each_ptp_clock_start(dev, ctx->pos_phcindex, ptp,
> > +					ctx->pos_phcindex) {
> > +		ret =3D ethnl_tsinfo_dump_one_ptp(skb, dev, cb, ptp);
> > +		if (ret < 0 && ret !=3D -EOPNOTSUPP)
> > +			break;
> > +		ctx->pos_phcqualifier =3D
> > HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
> > +	}
> > +
> > +	return ret; =20
>=20
> Perhaps it is not possible, but if the loop iterates zero times then
> ret will be used uninitialised here.

Yes thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

