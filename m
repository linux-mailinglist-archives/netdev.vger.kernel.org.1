Return-Path: <netdev+bounces-224183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6AB81E31
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159AE7B39EF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF02D662D;
	Wed, 17 Sep 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afyD9Sgn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C622BE647;
	Wed, 17 Sep 2025 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143177; cv=none; b=HS+s77Fx4TY2pjyG61/SwrnQ0BZLhBgO0iMkzGvm+1LBhbwCZUaFK0Utd/lLMvOrHNcoFuDtJY+XvXdy7X7Z2Yla2rOTbxzdVxGrnRQ4NBCK8aljg+cnPDIEL9mQG/FmntRUC1y7o15u2fyYM6jf1sdABa7pHdx7rJyBhxS4EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143177; c=relaxed/simple;
	bh=35UybGgKhNcWAZVrr7NvF0Abs/dTBIH2JOc5W2o5PDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc95S79h1u47mVnsE3V9GcoyaQ41V+Y8S+q6ESuQdBwdQWaJmYLSApEiERgchWX4wk/95lSuqvATuSzEBv4Tax26Fpr9TFV076OZ6skdZ+pC4UoDNQcjL+6kOezSM/wVYR9WEgKDDkTGOWewneTmeGpBlfU3GC2JbdAW+rBDDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afyD9Sgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4924C4CEE7;
	Wed, 17 Sep 2025 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143174;
	bh=35UybGgKhNcWAZVrr7NvF0Abs/dTBIH2JOc5W2o5PDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=afyD9SgnCCGPnG8KYUiRMaUNI1pKt4c+ZfAgVV2KVZoGY/Nu0ywarEttUykx8k7GA
	 ttM6XYHqiq8WGRLNabrBd+E15GdG5L4VSXBDsqQf+ofE8cU1qz1BRUNx6cX7MtSGF+
	 jRePHNmvKXGvwqYi8wv2vqAqt7XFx9MmL8W2WPlWf0VGJr8qkbI5D/P2pzL08y8x/U
	 WDQI5iI48F4HOfce+pMEvyrBPVzzorispPpljeqKJcqEwnno4phlSSh/TW47yzd1Zi
	 CK7jxZ+wDvhf1ionbRQJuuFIh00v4ljrvE6Z2JzbEt19Ut8VWWCbydXwif/8dgkgn0
	 5Rj/WRviljHEA==
Date: Wed, 17 Sep 2025 14:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 John Fastabend <john.fastabend@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Divya.Koppera@microchip.com, Kory Maincent <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v4 0/3] Documentation and ynl: add flow control
Message-ID: <20250917140612.0cd98bac@kernel.org>
In-Reply-To: <aMqJhl2swbkiYx_p@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
	<20250909143256.24178247@kernel.org>
	<aMqJhl2swbkiYx_p@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 12:12:22 +0200 Oleksij Rempel wrote:
> On Tue, Sep 09, 2025 at 02:32:56PM -0700, Jakub Kicinski wrote:
> > On Tue,  9 Sep 2025 09:22:09 +0200 Oleksij Rempel wrote: =20
> > > This series improves kernel documentation around Ethernet flow control
> > > and enhances the ynl tooling to generate kernel-doc comments for
> > > attribute enums.
> > >=20
> > > Patch 1 extends the ynl generator to emit kdoc for enums based on YAML
> > > attribute documentation.
> > > Patch 2 regenerates all affected UAPI headers (dpll, ethtool, team,
> > > net_shaper, netdev, ovpn) so that attribute enums now carry kernel-do=
c.
> > > Patch 3 adds a new flow_control.rst document and annotates the ethtool
> > > pause/pause-stat YAML definitions, relying on the kdoc generation
> > > support from the earlier patches. =20
> >=20
> > The reason we don't render the kdoc today is that I thought it's far
> > more useful to focus on the direct ReST generation. I think some of=20
> > the docs are not rendered, and other may be garbled, but the main
> > structure of the documentation works quite well:
> >=20
> >   https://docs.kernel.org/next/netlink/specs/dpll.html
> >=20
> > Could you spell out the motivation for this change a little more? =20
>=20
> The reason I went down the kdoc-in-UAPI route is mostly historical.
> When I first started writing the flow control documentation, reviewers
> pointed out that the UAPI parts should be documented in the header
> files.  Since these headers are generated from YAML, the natural way was
> to move  the docstrings into the YAML and let the generator emit them.
> One step led  to another, and we ended up with this change.
>=20
> I don=E2=80=99t have a strong preference for where the documentation live=
s, my
> primary goal was to avoid duplicating text and make sure the UAPI enums
> for pause / pause-stat are self-describing. If the consensus is that we
> should concentrate on ReST output only, I=E2=80=99m happy to reduce the s=
cope of
> this series and drop the kernel-doc emission. The actual motivation of
> my  series is to add flow_control.rst and document the ethtool API
> there.
>=20
> So if you prefer, I can respin with just the flow_control.rst and YAML =20
> annotations, and skip the generator changes.

We can adapt our approach to the needs as we go. But yes, my
recollection of the series was that there wasn't actually many
touchpoints here between the generated kdoc and your newly written
docs at this stage. So let's defer rendering into the uAPI headers.

