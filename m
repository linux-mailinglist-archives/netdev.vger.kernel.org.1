Return-Path: <netdev+bounces-121188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E695C17B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F841C21286
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161391D2795;
	Thu, 22 Aug 2024 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPv90F+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59764687
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368640; cv=none; b=q+EAeLAmfz4Axfjl0f1MK014tswief/+6eBs9tYoJ8B0UFd7zx7ZkHWAH7Lke4u6LehvQVOgpdbh3O+di/4fQUBQYvN+4LzWHb2T/45u2u9SHVOLIOXyW3lpjzMgjHe1yVXl1LQkNvjNJ5y+YhCkmP2y675Acsmp465rH3gcSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368640; c=relaxed/simple;
	bh=jbuBLGhiMztE9EKHUh3XQjJagAkHqXX1eY5Ofc9fQUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr3Ox+BxmkzsYEoDFmW2EX5MHeWStx53v5iISfuLCKEGhEwlXFR3eb2Lyu9XyUf7PrQFbSqCs+wSi/e4AuRX1I4DSktKcon6MQ5AXF8u906TussHfXrK+W6xbCiOb+UzJEYmtGI/Je5uzdSOvP8DFZF1xo9CXC1s8lnOGpdmcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPv90F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01253C32782;
	Thu, 22 Aug 2024 23:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724368639;
	bh=jbuBLGhiMztE9EKHUh3XQjJagAkHqXX1eY5Ofc9fQUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KhPv90F+haXO6cVEl/MTOcYvBZfokzLVs4x7bNFAT6Qiu2F0sjFXvphB32jjOKWMF
	 0e35btB1CDDLxg4EAyv/9Xr0n3zKj+DpGxqqIgVYJTr8urb/TqooehW2nTSWBmp6kD
	 ZtBR50u6mqdA6Zq99+oNMEs0/BXajogp7v94TUPqob0JG/hhF3eAdrMwriTVzYlFLh
	 mie/Y2/+fOgTRtG7XJFmPwQM7badJkXsjaXv8oH/dJvuZi+da5rTNlTm8/CgXOXZwt
	 imQnlpV9QPHFurqrAjD456IFMydb8tC+MWz9hVMiFDcEl0arq87QnubHQP4vAXD49Q
	 L99S4Pu2ekkkw==
Date: Thu, 22 Aug 2024 16:17:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next v2 2/9] libeth: add common queue stats
Message-ID: <20240822161718.22a1840e@kernel.org>
In-Reply-To: <613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-3-anthony.l.nguyen@intel.com>
	<20240820181757.02d83f15@kernel.org>
	<613fb55f-b754-433a-9f27-7c66391116d9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 17:13:57 +0200 Alexander Lobakin wrote:
> > BTW for Intel? Or you want this to be part of the core?
> > I thought Intel, but you should tell us if you have broader plans. =20
>=20
> For now it's done as a lib inside Intel folder, BUT if any other vendor
> would like to use this, that would be great and then we could move it
> level up or some of these APIs can go into the core.
> IOW depends on users.
>=20
> libie in contrary contains HW-specific code and will always be
> Intel-specific.

Seems like an odd middle ground. If you believe it's generic finding
another driver shouldn't be hard.

> >> +	const struct libeth_netdev_priv *priv =3D netdev_priv(dev);	      \
> >> +									      \
> >> +	memset(stats, 0, sizeof(*stats));				      \
> >> +	u64_stats_init(&stats->syncp);					      \
> >> +									      \
> >> +	mutex_init(&priv->base_##pfx##s[qid].lock);			      \ =20
> >=20
> > the mutex is only for writes or for reads of base too?
> > mutex is a bad idea for rtnl stats =20
>=20
> Base stats are written only on ifdown, read anytime, mutex is used
> everywhere.
> Hmm maybe a bad idea, what would be better, spinlock or just use
> u64_sync as well?

Depends quite a bit on whether driver uses per queues stats to get=20
rtnl stats. And whether reading of the stats needs to sleep.

> >> +#define LIBETH_STATS_DEFINE_EXPORT(pfx, gpfx)				      \
> >> +static void								      \
> >> +libeth_get_queue_stats_##gpfx(struct net_device *dev, int idx,		     =
 \
> >> +			      struct netdev_queue_stats_##gpfx *stats)	      \
> >> +{									      \
> >> +	const struct libeth_netdev_priv *priv =3D netdev_priv(dev);	      \
> >> +	const struct libeth_##pfx##_stats *qs;				      \
> >> +	u64 *raw =3D (u64 *)stats;					      \
> >> +	u32 start;							      \
> >> +									      \
> >> +	qs =3D READ_ONCE(priv->live_##pfx##s[idx]);			      \
> >> +	if (!qs)							      \
> >> +		return;							      \
> >> +									      \
> >> +	do {								      \
> >> +		start =3D u64_stats_fetch_begin(&qs->syncp);		      \
> >> +									      \
> >> +		libeth_stats_foreach_export(pfx, exp)			      \
> >> +			raw[exp->gi] =3D u64_stats_read(&qs->raw[exp->li]);     \
> >> +	} while (u64_stats_fetch_retry(&qs->syncp, start));		      \
> >> +}									      \ =20
> >=20
> > ugh. Please no =20
>=20
> So you mean just open-code reads/writes per each field than to compress
> it that way?

Yes. <rant> I don't understand why people try to be clever and
complicate stats reading for minor LoC saving (almost everyone,
including those working on fbnic). Just type the code in -- it=20
makes maintaining it, grepping and adding a new stat without
remembering all the details soo much easier. </rant>

> Sure, that would be no problem. Object code doesn't even
> change (my first approach was per-field).
>=20
> >> +									      \
> >> +static void								      \
> >> +libeth_get_##pfx##_base_stats(const struct net_device *dev,		      \
> >> +			      struct netdev_queue_stats_##gpfx *stats)	      \
> >> +{									      \
> >> +	const struct libeth_netdev_priv *priv =3D netdev_priv(dev);	      \
> >> +	u64 *raw =3D (u64 *)stats;					      \
> >> +									      \
> >> +	memset(stats, 0, sizeof(*(stats)));				      \ =20
> >=20
> > Have you read the docs for any of the recent stats APIs? =20
>=20
> You mean to leave 0xffs for unsupported fields?

Kinda of. But also I do mean to call out that you haven't read the doc
for the interface over which you're building an abstraction =F0=9F=98=B5=E2=
=80=8D=F0=9F=92=AB=EF=B8=8F

> > Nack. Just implement the APIs in the driver, this does not seem like=20
> > a sane starting point _at all_. You're going to waste more time coming
> > up with such abstraction than you'd save implementing it for 10 drivers=
. =20
>=20
> I believe this nack is for generic Netlink stats, not the whole, right?
> In general, I wasn't sure about whether it would be better to leave
> Netlink stats per driver or write it in libeth, so I wanted to see
> opinions of others. I'm fine with either way.

We (I?) keep pushing more and more stats into the generic definitions,
mostly as I find clear need for them in Meta's monitoring system.
My main concern is that if you hide the stats collecting in a library
it will make ensuring the consistency of the definition much harder,
and it will propagate the use of old APIs (dreaded ethtool -S) into new
drivers.

If you have useful helpers that can be broadly applicable that's great.
This library as it stands will need a lot of work and a lot of
convincing to go in.

