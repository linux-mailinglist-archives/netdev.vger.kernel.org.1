Return-Path: <netdev+bounces-187872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9CAAA086
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11497189FB32
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F23276051;
	Mon,  5 May 2025 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DR74P9QT"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B82741CF;
	Mon,  5 May 2025 22:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483487; cv=none; b=dmxFkpuFWTq+Zl2mw201S0WzexpFudpn36hYSGr4F0r48wKnZJmnHiT/7Qv2wu98k+ER4E+z1kS4Tjaqv04o50TApiW0LWFVR7R/MU3m/wbUI2ufR8EoWvEssLWWg0ekQ6WXMFlOx+oj8kgS7TKQlQQrB0u7dXf01/H4As6B3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483487; c=relaxed/simple;
	bh=ICQOgm/oxvbMn3j3DrNQVqEImZIBabjshKw7nTcOCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KO4fkGdgz5CZiHS8oTQ0Uf3gqji0NPb/LZrfe9NHolmX/ocm8ZN6fNZYCUB5zuG8AFhGtbsomjwFgxpZoIvc2BcbPhsmPaoWbzdJV5m0BImeVNXoLsjZe3uLqEH7gZDtopRKvMLm82Slua6CzA803mAzLspOUMrnB9tlZUGraMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DR74P9QT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B824B41E0D;
	Mon,  5 May 2025 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746483482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKS/cb+SXa/UAIJAbrppHX30ENDfVc1mR64QNynsoJ0=;
	b=DR74P9QTZJGbK9Z79HPwvtbYGMuId/FJAYXc0xvaA64UZWDmBAagBMoKtWL2xXdl/x079W
	m63W6CroOIhAM4xgrppK6BouWErcNqQsYWRPi7ampHQbHjX4T9G24pP32Tz6+Mg7q7nWYw
	X2w6npZ4QLKGezj3R/RWR2SIeH+B16WUP9/sg4EtFE0v1FfYptRGJCoYEKDjOwoCPS/org
	XXeHAqendbaizLhLpPBFGYhOLBi6lwGoEHwrL9AYWBwD+aLurH175au+kI8pWVoBv+vPGN
	ohkgBa8r9wMKsiK/C/uth99HI9KGFT18U/5gYwk6xLYiAIBGamkMIb89ZvhUig==
Date: Tue, 6 May 2025 00:17:58 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250506001758.297449f1@kmaincent-XPS-13-7390>
In-Reply-To: <20250429150657.1f32a10c@kernel.org>
References: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
 <20250429150657.1f32a10c@kernel.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmedutgelrgemfegusghfmeehrgegugemvgefvggsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemudgtlegrmeefuggsfhemhegrgegumegvfegvsgdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtv
 ghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Thanks for the review!

On Tue, 29 Apr 2025 15:06:57 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 25 Apr 2025 19:42:43 +0200 Kory Maincent wrote:
> > Multi-PTP source support within a network topology has been merged,
> > but the hardware timestamp source is not yet exposed to users.
> > Currently, users only see the PTP index, which does not indicate
> > whether the timestamp comes from a PHY or a MAC.
> >=20
> > Add support for reporting the hwtstamp source using a
> > hwtstamp-source field, alongside hwtstamp-phyindex, to describe
> > the origin of the hardware timestamp.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > Not sure moving the hwtstamp_source enum to uapi/linux/net_tstamp.h and
> > adding this header to ynl/Makefile.deps is the best choice. Maybe it is
> > better to move the enum directly to ethtool.h header. =20
>=20
> Weak preference for the YAML and therefore ethtool.h from my side.
> That way the doc strings will propagate to more places, like the HTML
> docs.

Ack.

> > diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> > index
> > ff0758e88ea1008efe533cde003b12719bf4fcd3..1414aed0b6adeae15b56e7a99a7d9=
eeb43ba0b6c
> > 100644 --- a/include/linux/net_tstamp.h +++ b/include/linux/net_tstamp.h
> > @@ -13,12 +13,6 @@
> >  					 SOF_TIMESTAMPING_TX_HARDWARE | \
> >  					 SOF_TIMESTAMPING_RAW_HARDWARE)
> > =20
> > -enum hwtstamp_source {
> > -	HWTSTAMP_SOURCE_UNSPEC, =20
>=20
> when is unspec used in practice? Only path I could spot that may not
> set it is if we fetch the data by PHC index?

Indeed it is not used. I think it get merged in one of the several version
tackling the "make PTP selectable support" work. As it is finally not used =
we
could drop it.
=20
> > -	HWTSTAMP_SOURCE_NETDEV,
> > -	HWTSTAMP_SOURCE_PHYLIB,
> > -};
> > -
> >  /**
> >   * struct hwtstamp_provider_desc - hwtstamp provider description
> >   * =20
>=20
> > diff --git a/include/uapi/linux/net_tstamp.h
> > b/include/uapi/linux/net_tstamp.h index
> > a93e6ea37fb3a69f331b1c90851d4e68cb659a83..bf5fb9f7acf5c03aaa121e0cda3c0=
b1d83e49f71
> > 100644 --- a/include/uapi/linux/net_tstamp.h +++
> > b/include/uapi/linux/net_tstamp.h @@ -13,6 +13,19 @@
> >  #include <linux/types.h>
> >  #include <linux/socket.h>   /* for SO_TIMESTAMPING */
> > =20
> > +/**
> > + * enum hwtstamp_source - Source of the hardware timestamp
> > + * @HWTSTAMP_SOURCE_UNSPEC: Source not specified or unknown
> > + * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from the net devi=
ce =20
>=20
> We should probably document that netdev here means that the timestamp
> comes from a MAC or device which has MAC and PHY integrated together?

Yes, I will.

>=20
> > + * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one of the P=
HY
> > + *			    devices of the network topology
> > + */
> > +enum hwtstamp_source {
> > +	HWTSTAMP_SOURCE_UNSPEC,
> > +	HWTSTAMP_SOURCE_NETDEV,
> > +	HWTSTAMP_SOURCE_PHYLIB,
> > +}; =20
>=20
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -920,12 +920,20 @@ int ethtool_get_ts_info_by_phc(struct net_device =
*dev,
> >  		struct phy_device *phy;
> > =20
> >  		phy =3D ethtool_phy_get_ts_info_by_phc(dev, info,
> > hwprov_desc);
> > -		if (IS_ERR(phy))
> > +		if (IS_ERR(phy)) {
> >  			err =3D PTR_ERR(phy);
> > -		else
> > -			err =3D 0;
> > +			goto out;
> > +		}
> > +
> > +		info->phc_source =3D HWTSTAMP_SOURCE_PHYLIB;
> > +		info->phc_phyindex =3D phy->phyindex;
> > +		err =3D 0;
> > +		goto out; =20
>=20
> The goto before the else looks a bit odd now.
> Can we return directly in the error cases?
> There is no cleanup to be done.

Yes indeed.

> > +	} else {
> > +		info->phc_source =3D HWTSTAMP_SOURCE_NETDEV;
> >  	}
> > =20
> > +out:
> >  	info->so_timestamping |=3D SOF_TIMESTAMPING_RX_SOFTWARE |
> >  				 SOF_TIMESTAMPING_SOFTWARE;
> > =20
> > @@ -947,10 +955,14 @@ int __ethtool_get_ts_info(struct net_device *dev,
> > =20
> >  		ethtool_init_tsinfo(info);
> >  		if (phy_is_default_hwtstamp(phydev) &&
> > -		    phy_has_tsinfo(phydev))
> > +		    phy_has_tsinfo(phydev)) {
> >  			err =3D phy_ts_info(phydev, info);
> > -		else if (ops->get_ts_info)
> > +			info->phc_source =3D HWTSTAMP_SOURCE_PHYLIB;
> > +			info->phc_phyindex =3D phydev->phyindex;
> > +		} else if (ops->get_ts_info) {
> >  			err =3D ops->get_ts_info(dev, info);
> > +			info->phc_source =3D HWTSTAMP_SOURCE_NETDEV; =20
>=20
> Let's move the assignment before the calls if we can?
> Otherwise someone adding code below may miss the fact that err may
> already be carrying an unhandled error.

Ack.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

