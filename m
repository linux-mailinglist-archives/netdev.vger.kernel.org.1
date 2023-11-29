Return-Path: <netdev+bounces-52314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1E7FE45C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58DC1C20A6B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F179747A67;
	Wed, 29 Nov 2023 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFXAyTX8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA504CB5D;
	Wed, 29 Nov 2023 23:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14715C433C7;
	Wed, 29 Nov 2023 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701302175;
	bh=FK/XJ8k7CN61Y+SQ5dJKbLrahAUivCDGaeaXNYqZt2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AFXAyTX8Shnb4CIfE2Q9iYTgz1rK2nby7PMOiNBV/45sKOjLIx5NneSuAvTv6EkaL
	 JOh/PJ8LwvfYrUf5Mj8Ec9+YNi9MK95wCaAGSuqurmuQGxxlRnuAInXET197tMJ0uk
	 ZqrHS/KYCVXvBPx+czULvcNeJCQ97V3TmZq6Bc3OJLbGR0deix0gKlCXmkzYdrjZM+
	 se383zhQwlecOmBxmULwQIUtVYRjWnmyRWhnEZ52T1ISWl9D1bjIE/aPHM5pI+yDdp
	 McUSwJa6s1GuMB/px6+xtgoGV/NkZ97VpOsClujI26bdxBH0AvZCBibYeNYy1Vp3fm
	 vF4+wHzwG3PTw==
Date: Wed, 29 Nov 2023 15:56:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, rrameshbabu@nvidia.com
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231129155613.58c4b93b@kernel.org>
In-Reply-To: <20231129230034.7301d8b2@kmaincent-XPS-13-7390>
References: <20231120121440.3274d44c@kmaincent-XPS-13-7390>
	<20231120120601.ondrhbkqpnaozl2q@skbuf>
	<20231120144929.3375317e@kmaincent-XPS-13-7390>
	<20231120142316.d2emoaqeej2pg4s3@skbuf>
	<20231120093723.4d88fb2a@kernel.org>
	<157c68b0-687e-4333-9d59-fad3f5032345@lunn.ch>
	<20231120105148.064dc4bd@kernel.org>
	<20231120195858.wpaymolv6ws4hntp@skbuf>
	<20231120134551.30d0306c@kernel.org>
	<20231129210959.19e1e2b7@kmaincent-XPS-13-7390>
	<20231129203700.ckpkc4r5bwwudwpf@skbuf>
	<20231129230034.7301d8b2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Nov 2023 23:00:34 +0100 K=C3=B6ry Maincent wrote:
> > Not sure why you say "not used", though. Are you not planning to expose
> > the qualifier as an attribute to the listing of hwtstamp providers
> > offered to user space by ETHTOOL_MSG_TSINFO_GET? =20
>=20
> Yes I will, I was just saying that all the PHC would be set as precise fo=
r now.
> Approximate timestamp quality won't be used because IIUC there are no NIC=
 driver
> supporting it yet.

Agreed that we should add the attr from the start.

Maybe we can ask/work with Rahul <rrameshbabu@nvidia.com>
to implement the right thing in mlx5?

Failing that we can mark mlx5 as imprecise, until its sorted out.
So that we have both types in the tree.

