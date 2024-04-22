Return-Path: <netdev+bounces-90241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3BA8AD41B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F0281C3A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE9153837;
	Mon, 22 Apr 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEaSWtlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8BC1474D3;
	Mon, 22 Apr 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811185; cv=none; b=blot/KQZtwhpY7H+G5AdWBR5egtInQoHpGrn9IvK7wqYCVfXzxp8lnCjC2muCXM7CDEhYIM6539dmviQoVSBxXuc/qMsEY8C1/bXb8ZAWDAOc5GmZ4Yt+J2AEv50T4f5wC1srGlIIhk3xcNRM8nN3QkQSPgCu3EPR2o0AcW0NLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811185; c=relaxed/simple;
	bh=IFiRNpxgUNoHitTE7w4Z1nq+NF3oVpObrju4/HCt3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smOXzUEknorsIgTXm+x33p19bfdqq3k+rajNkyd1fVPthl7dO9AbymPvmgyzzNIedwsKFNB+r8ErmhHk8Oqx/5mVHXFpEKW/eg17S0IeEmQcsu60pDG3OcqUZT/9ZWISxjhtvQDCm6yF6IBv6/WoSccBe+lCV7ATDoPE2lnnCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEaSWtlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37580C113CC;
	Mon, 22 Apr 2024 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811185;
	bh=IFiRNpxgUNoHitTE7w4Z1nq+NF3oVpObrju4/HCt3x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEaSWtlM8zy/X2vpq45kKgoeKYOBiAdp8FND7HHns99ixyqEsNNhCDNd3IpWbpQjx
	 2gGPGunyYQNum/S49J8fPkho2T27scEDb58DIe2fdz+ZW9O1Ger2ZPgA+UPfragorK
	 pbE3xUlwCBGLaMY+K6qenFmKPDyBezPLZdd8jLQ4AQKs2OtGN6sdyDoLs9FNPfjuHS
	 f2FL/uPhVZHgZN4l3+M8aYv1WKqsHcgwFRhWNztEWPeGq4MmOn4JPtsVhKKlJ73gIE
	 zQEV4l7cylX1BozmpRoPFRsQaYYIkhJsEGAfHIIbqCydyQ910VvNJAcZRDLKKxkhUs
	 FMYxVlYr2eD8A==
Date: Mon, 22 Apr 2024 11:39:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 "justinstitt@google.com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240422113943.736861fc@kernel.org>
In-Reply-To: <96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
	<20240417155546.25691-3-hengqi@linux.alibaba.com>
	<20240418174843.492078d5@kernel.org>
	<96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 17:00:25 +0800 Heng Qi wrote:
> =E5=9C=A8 2024/4/19 =E4=B8=8A=E5=8D=888:48, Jakub Kicinski =E5=86=99=E9=
=81=93:
> > On Wed, 17 Apr 2024 23:55:44 +0800 Heng Qi wrote: =20
> >> $ ethtool -c ethx
> >> ...
> >> rx-eqe-profile:
> >> {.usec =3D   1, .pkts =3D 256, .comps =3D   0,},
> >> {.usec =3D   8, .pkts =3D 256, .comps =3D   0,},
> >> {.usec =3D  64, .pkts =3D 256, .comps =3D   0,},
> >> {.usec =3D 128, .pkts =3D 256, .comps =3D   0,},
> >> {.usec =3D 256, .pkts =3D 256, .comps =3D   0,}
> >> rx-cqe-profile:   n/a
> >> tx-eqe-profile:   n/a
> >> tx-cqe-profile:   n/a =20
> > I don't think that exposing CQE vs EQE mode makes much sense here.
> > We enable the right mode via:
> >
> > struct kernel_ethtool_coalesce {
> > 	u8 use_cqe_mode_tx;
> > 	u8 use_cqe_mode_rx; =20
>=20
> I think it is reasonable to use 4 types:
>=20
> dim lib itself is designed with 4 independent arrays, which are queried=20
> by dim->mode and
> dim->profile_ix. This way allows users to manually modify the cqe mode=20
> of tx or rx, and the
> dim interface can automatically match the profile of the corresponding=20
> mode when obtaining
> the results.

I'm guessing that DIM has 4 profiles because it was easier to implement
for profiles hardcoded by DIM itself(!) Even for driver-declared
profiles the distinction is a hack.

> Merely exposing rx_profile and tx_profile does not seem to make the=20
> interface and code clearer.
>=20
> > the user needs to set the packets and usecs in an educated way
> > (matching the mode). =20
>=20
> I think this is acceptable. In addition to the above reasons, users can=20
> already set the cqe
> mode of tx and rx in user mode, which means that they have been educated.
>=20
> > The kernel never changes the mode. =20
>=20
> Sorry, I don't seem to understand what this means.

Kernel never changes the mode for its own reasons.
Only user can change the mode.
So we don't have to always have both CQE and EQE mode tables ready.
If the kernel changed the mode for some reason we'd have to get both
from the user, in case kernel wanted to switch.

> >>   /**
> >>    * register_netdevice() - register a network device
> >>    * @dev: device to register
> >> @@ -10258,6 +10310,10 @@ int register_netdevice(struct net_device *dev)
> >>   	if (ret)
> >>   		return ret;
> >>  =20
> >> +	ret =3D dev_dim_profile_init(dev);
> >> +	if (ret)
> >> +		return ret; =20
> > This is fine but the driver still has to manually do bunch of init:
> >
> > 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
> > 		vi->rq[i].dim.mode =3D DIM_CQ_PERIOD_MODE_START_FROM_EQE;
> >
> > It'd be better to collect all this static info (flags, mode, work func)
> > in one place / struct, attached to netdev or netdev_ops. Then the
> > driver can call a helper like which only needs to take netdev and dim
> > as arguments. =20
>=20
> If mode is put into netdev, then use_cqe_mode_rx and use_cqe_mode_tx=20
> need to be moved into netdev too.
> Then dim->mode is no longer required when dim obtain its results.
> We need to transform the way all drivers with dim currently behave.

Hopefully that won't be too hard.

> But why should work be put into netdev?
> The driver still requires a for loop to initialize dim work for a=20
> driver-specific queues.

It's easier to refactor and extend the API when there's an explicit
call done to the core by the driver, rather than driver poking values
into random fields of the core structure.

> >> + * coalesce_put_profile - fill reply with a nla nest with four child =
nla nests.
> >> + * @skb: socket buffer the message is stored in
> >> + * @attr_type: nest attr type ETHTOOL_A_COALESCE_*X_*QE_PROFILE
> >> + * @profile: data passed to userspace
> >> + * @supported_params: modifiable parameters supported by the driver
> >> + *
> >> + * Put a dim profile nest attribute. Refer to ETHTOOL_A_MODERATIONS_M=
ODERATION.
> >> + *
> >> + * Return: false to indicate successful placement or no placement, and
> >> + * true to pass the -EMSGSIZE error to the wrapper. =20
> > Why the bool? Doesn't most of the similar code return the error? =20
>=20
> Its wrapper function ethnl_default_doit only recognizes the EMSGSIZE code.

Not sure what you mean.

> >> @@ -227,7 +315,19 @@ const struct nla_policy ethnl_coalesce_set_policy=
[] =3D {
> >>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] =3D { .type =3D NLA_U32 },
> >>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] =3D { .type =3D NLA_U32 },
> >>   	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] =3D { .type =3D NLA_U32 },
> >> +	[ETHTOOL_A_COALESCE_RX_EQE_PROFILE]     =3D { .type =3D NLA_NESTED },
> >> +	[ETHTOOL_A_COALESCE_RX_CQE_PROFILE]     =3D { .type =3D NLA_NESTED },
> >> +	[ETHTOOL_A_COALESCE_TX_EQE_PROFILE]     =3D { .type =3D NLA_NESTED },
> >> +	[ETHTOOL_A_COALESCE_TX_CQE_PROFILE]     =3D { .type =3D NLA_NESTED }=
, =20
> > NLA_POLICY_NESTED(coalesce_set_profile_policy) =20
>=20
> This doesn't work because the first level of sub-nesting of
> ETHTOOL_A_COALESCE_RX_CQE_PROFILE is ETHTOOL_A_PROFILE_IRQ_MODERATION.

So declare a policy for IRQ_MODERATION which has one entry -> nested
profile policy?

