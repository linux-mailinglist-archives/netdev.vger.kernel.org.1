Return-Path: <netdev+bounces-97588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FB8CC323
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E76E283545
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DF14039D;
	Wed, 22 May 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNFOnYu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DA13DBA4;
	Wed, 22 May 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387734; cv=none; b=uXasys1KXPcd/fJUVgWdnF9fASOO5i54/HDuUM5Hrsoe2MIPUCVmdJ7uvy/7Ty8BE8k5bOQnCZDgZ+m3lNUoHHUbY6QHZke6Jhn2UhuQvhWcFIi5Jac5JAZa0Jdff0fpyTlx9G7dNcbckNz4wJvtJq6btroeiMhdP8ZDC8bWs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387734; c=relaxed/simple;
	bh=LJl1i0W4EXotAHG6nsa5glp9lSWgRODR5PILl5J3OSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXINBOWXb/Bz04vcRiK3lzMy+JVcg1WG+8bzFjwS89e1mhubKohpejkHTPOI4mCaWf4O7CEN1SogqKwGdFkw5WtQHMwW1qCPYXEuTs5Cmxn9+btoja6wB2scUT0JO8XLGk6CZdaeQfg3MGIeh0IJwK4qcFkvyYQ2zRSLKwCdC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNFOnYu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F5AC32782;
	Wed, 22 May 2024 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387734;
	bh=LJl1i0W4EXotAHG6nsa5glp9lSWgRODR5PILl5J3OSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNFOnYu0LvkD8jM3Vk8qKMcoXnpxPkVdqgLyLfw+dILH0Kdt5fZXmclevA15f04kT
	 07NipmFqpRIHZB9riYNK+1jSpi+Imnt4kMQv7dx2z6XkhiKKJ7KEf3RkdS3XXUUQCi
	 et2ECh+Tr9FAnlKvtqx1UCkt/G/qvhK9msrujcDRcBFFs/quWOXkkdt8OiXoeSPfwF
	 1l4pJjFbha7C5H4wnOwDL6dhHyxbjuTZ7XK9Z7VJfsh6p/JVxfI3xGIoEGVdqV1lng
	 R2KBjPWJ8vh2ThlCZbf7ukqmkIUbBZsPxRztxFFpAnMTsgtljNhl4fp4Aik/88KiM+
	 9Vbo26v2RIhUA==
Date: Wed, 22 May 2024 07:22:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240522072212.7a21c84b@kernel.org>
In-Reply-To: <DM6PR12MB451677DBA41EA8A622D3D446D8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>
	<ZjH1DCu0rJTL_RYz@shredder>
	<20240501073758.3da76601@kernel.org>
	<DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240522064519.3e980390@kernel.org>
	<DM6PR12MB451677DBA41EA8A622D3D446D8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 May 2024 13:56:11 +0000 Danielle Ratson wrote:
> > > 4. Add a new netlink notifier that when the relevant event takes plac=
e, =20
> > deletes the node from the list, wait until the end of the work item, wi=
th
> > cancel_work_sync() and free allocations.
> >=20
> > What's the "relevant event" in this case? Closing of the socket that us=
er had
> > issued the command on? =20
>=20
> The event should match the below:
> event =3D=3D NETLINK_URELEASE && notify->protocol =3D=3D NETLINK_GENERIC
>=20
> Then iterate over the list to look for work that matches the dev and port=
id.
> The socket doesn=E2=80=99t close until the work is done in that case.=20

Okay, good, yes. I think you can use one of the callbacks I mentioned
below to achieve the same thing with less complexity than the notifier.

> > Easiest way to "notice" the socket got closed would probably be to add =
some
> > info to genl_sk_priv_*(). ->sock_priv_destroy() will get called. But yo=
u can also
> > get a close notification in the family =20
> > ->unbind callback. =20
> >=20
> > I'm on the fence whether we should cancel the work. We could just mark =
the
> > command as 'no socket present' and stop sending notifications.
> > Not sure which is better.. =20
>=20
> Is there a scenario that we hit this event and won't intend to cancel the=
 work?=20

I think it's up to us. I don't see any legit reason for user space to
intentionally cancel the flashing. So the only option is that user space
is either buggy or has crashed, and the socket got closed before
flashing finished. Right?

