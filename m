Return-Path: <netdev+bounces-109905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE3E92A3BF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C031F21FF0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1F7F7C7;
	Mon,  8 Jul 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sss0aAk7"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416841AACC;
	Mon,  8 Jul 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445858; cv=none; b=lqWc2yQejk1z9GswgcjfsyLThqOTRnVGdRcHXIALfKWLnHn6V2JqKeEky8w5ZVfD8lJzzd+UnmneUHyKOpiVYGe09mGVhS+MBqWAZ7fp/bz2uhOghjP49Oz9Rjjcqjl0Ne75men2CIEVBGL622z0HIWozg8WE/KKGcoD2CuynNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445858; c=relaxed/simple;
	bh=MNDlcVUEc+CZ+sZStwyCB1gmpka3YRbeXXUl7VcaNk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgYD7twkKlfto7K6PXL8rDXy1NxTVPeUYmjsVfdJEfshb8h12tBu9DhFjDyY4wbhy8rigS1L97+l2j2JN1rnQUaD5Kd65SctDttwJKmPHDeGNUBQZt22BsCb/aYf4RDxG05xPjVpGwp2Vf1b1W8iuNj4pYVhE4eXHMcgr+POUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sss0aAk7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD1CC1C000E;
	Mon,  8 Jul 2024 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720445854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSm0DVMNMKvBf/5qYND5WUTDjW2NLKuDtgQ+AqbYE4w=;
	b=Sss0aAk7SMhXr1lkuZpJZ7B8yvCv3eXPyfue7H0+EhEV+k42BKfcYxKrcJkQBSIEQBPOtU
	CB7b/N5aDSs9Wr3NReFaFEgRNT7JJwlt22MQe6KplQShz6hWbA19uQYIDlWB0qda50HTgR
	5OQ2lZRn2bdbXF2q8EIJ61WjmdqJITvZmcy7LwLV4XAzwmbijYs6qyY+FBmewl6fGmIsJm
	LkYOzzlTR80EFILFTXgzFma4vuCh1K7q4nV0y1OSQUhkJgIXhz6B59EQ06jMgalAFEfOxJ
	blgcnnieY0HplQdaK/m9FLSAuFk6Y/vwJwYJlIJ/dpdeqVOJN8fCYBqGmmMD7w==
Date: Mon, 8 Jul 2024 15:37:29 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v16 00/14] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240708153729.3129e604@fedora-2.home>
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri,  5 Jul 2024 15:26:51 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Hello everyone,
>=20
> This is V16 of the phy_link_topology series, aiming at improving support
> for multiple PHYs being attached to the same MAC.

[...]

>=20
> Maxime Chevallier (14):
>   net: phy: Introduce ethernet link topology representation
>   net: sfp: pass the phy_device when disconnecting an sfp module's PHY
>   net: phy: add helpers to handle sfp phy connect/disconnect
>   net: sfp: Add helper to return the SFP bus name
>   net: ethtool: Allow passing a phy index for some commands
>   netlink: specs: add phy-index as a header parameter
>   net: ethtool: Introduce a command to list PHYs on an interface
>   netlink: specs: add ethnl PHY_GET command set

I'll resend this series, as with the very recent merge of K=C3=B6ry's PSE
work [1], the ethtool specs will conflict upon applying the
phy_link_topology work :)

https://lore.kernel.org/netdev/172023063113.28145.15061182082357066469.git-=
patchwork-notify@kernel.org/

Thanks,

Maxime

