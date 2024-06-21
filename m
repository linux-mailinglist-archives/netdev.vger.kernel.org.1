Return-Path: <netdev+bounces-105755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2407912AB8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9351F2117B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB9615F303;
	Fri, 21 Jun 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVIkg+be"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CA757F8;
	Fri, 21 Jun 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718985362; cv=none; b=FAqQsQNsKJTDI93q5COV0Mt9WMvSRzbfOxO5r1TOToHBaodLCRDS2avoYT+LgVgB9turtVJyp5EPlvo3ZG7o+f4XNB+2uiegDn4KCNe9lWEvzUawDvMg1hsW5L9i6sU8radLWvIW9ycTreAT60fgFz2OhWi7yH1U3v/SM4BTkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718985362; c=relaxed/simple;
	bh=Snn796INTt72RBeUt8uePOrvUHDAmT55jeQwCK7Wtbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9ufky7YyEfw0BesYVri6KPXVHGD5ykCr2ODRZkNxpZUAeaIbSMAXX8dNU75o2jWlSa/xrvQimzZftvi587awbHOdeUe8vVk6qBl/XUV+KSl4uGmV6WXJLQ+9qV4hkIuVniICwJf+H5uYRqc+zSbyP8l6Q0P+m/tJ5heTQGv7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVIkg+be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABA8C2BBFC;
	Fri, 21 Jun 2024 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718985362;
	bh=Snn796INTt72RBeUt8uePOrvUHDAmT55jeQwCK7Wtbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FVIkg+beoVZ1j0a93xJTvx+onPSSLeZEJERLyZ9DOoqlk32OpmfeW/gm7diyrZopA
	 92vj+9+pI5wxWo8yCWRC6DKG8A3reo2QhmWXwfnsucocLe5ZdiKB+kkkyL6wRzR7SR
	 x7GT99IWD9FiOFRGhl1/3hj1gRKlevyuN530nP6dOw+pOzoFl7Sk1IoYA6hKUG982o
	 ic02KtfJCsSpFaqZm8zf50ARYOi6+AD79+/1DINfpfaqG5Vw2QtVwqjitr4DQtaA2j
	 H2ArHYitZ6+X9Zp9iRWm1PrpPMnMBvNifzgyaBTfSGw6njONpi/9uhrQ8qLvnISRzY
	 daSQCYVFVlrbg==
Date: Fri, 21 Jun 2024 08:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
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
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v15 13/14] net: ethtool: tsinfo: Add support
 for hwtstamp provider and get/set hwtstamp config
Message-ID: <20240621085600.5b7aa934@kernel.org>
In-Reply-To: <20240621105408.6dda7a0e@kmaincent-XPS-13-7390>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-13-b2a086257b63@bootlin.com>
	<20240617184331.0ddfd08e@kernel.org>
	<20240621105408.6dda7a0e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 10:54:08 +0200 Kory Maincent wrote:
> > > +const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_MAX=
 + 1]
> > > =3D { [ETHTOOL_A_TSINFO_HEADER]		=3D
> > >  		NLA_POLICY_NESTED(ethnl_header_policy_stats),
> > > +	[ETHTOOL_A_TSINFO_GHWTSTAMP] =3D
> > > +		NLA_POLICY_MAX(NLA_U8, 1),   =20
> >=20
> > I think this can be an NLA_FLAG, but TBH I'm also confused about=20
> > the semantics. Can you explain what it does from user perspective? =20
>=20
> As I described it in the documentation it replaces SIOCGHWTSTAMP:
> "Any process can read the actual configuration by requesting tsinfo netli=
nk
> socket ETHTOOL_MSG_TSINFO_GET with ETHTOOL_MSG_TSINFO_GHWTSTAMP netlink
> attribute set.
>=20
> The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in the=
      =20
> same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been impleme=
nted  =20
> in all drivers."

I did see the words, just didn't get the meaning :> Couple of years
from now hopefully newcomers won't even know ioctls exited, and
therefore what they did. From the user perspective the gist AFAIU is
that instead of *supported* we'll return what's currently *configured*.

This feels a little bit too much like a muxed operation for me :(
Can we create a separate commands for TSCONFIG_GET / _SET ?
Granted it will be higher LOC, but hopefully cleaner ?
Or we can add the configured as completely new attrs, but changing
meaning of existing attrs based on a request flag.. =F0=9F=99=82=E2=80=8D=
=E2=86=94=EF=B8=8F=EF=B8=8F

> > > +	[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER] =3D
> > > +		NLA_POLICY_NESTED(ethnl_tsinfo_hwtstamp_provider_policy),
> > >  };
> > > =20
> > > +static int tsinfo_parse_hwtstamp_provider(const struct nlattr *nest,
> > > +					  struct hwtst_provider *hwtst,
> > > +					  struct netlink_ext_ack *extack,
> > > +					  bool *mod)
> > > +{
> > > +	struct nlattr
> > > *tb[ARRAY_SIZE(ethnl_tsinfo_hwtstamp_provider_policy)];   =20
> >=20
> > Could you find a more sensible name for this policy? =20
>=20
> I am not a naming expert but "hwtstamp_provider" is the struct name I hav=
e used
> to describe hwtstamp index + qualifier and the prefix of the netlink nest=
ed
> attribute, so IMHO it fits well.
> Have you another proposition to clarify what you would expect?

Oh, I just meant that it's way to long. I know y'all youngsters use
IDEs but I have it on good authority that there's still people in
this community who use text editors they wrote themselves, and those
lack auto-completion.. It's good to be more concise.

