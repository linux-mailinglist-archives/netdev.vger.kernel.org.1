Return-Path: <netdev+bounces-152491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1FF9F4322
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB081188DB7F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB36155CBD;
	Tue, 17 Dec 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgsp9nS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718A15533F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414330; cv=none; b=TLbSE6AvtTmkqNik4x+G7E6Ry13qN9KO/4eMEkjqiRNXTmxxXzjoeXkuf9slo3jYITBZxWmpImAT3OLCnJYjD4TqSa/VG4T9UbKHsfd6/O2P1iCqeQRjNFXbrXRvyj2bpBYm00BeuKSF57EnQPwy625bSi7ytms9Nji1tKNuJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414330; c=relaxed/simple;
	bh=SGPZCoKr5am830eKdRFpvUjhCA5xq2H4RvjbYRt3MIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvKRSfFcObs0cgzFrKjP1ePPDLUCu8NJYlf05roYx1PDlnZSa1QTB6GrUw0auwBoFghHi+jH898ijapKoEwrzSWGry2BySJQPulfmqgBLBDL7smI3aOK3oAPFsw33tpL4gUc6/u1BP4mysn7aOgrzg+PQDTvrCcnHwImACA8cUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgsp9nS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B52C4CED3;
	Tue, 17 Dec 2024 05:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734414329;
	bh=SGPZCoKr5am830eKdRFpvUjhCA5xq2H4RvjbYRt3MIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hgsp9nS7bnsH5jxGcQy95L402fBJLiqYSwKbYthTxkMy6dilEnVhjJf0NgiTqaBXa
	 VOK+9Y+3NnSGP2ksczD7WE/3ZsiQkP8gsmVNGnGVfeT+x0I6N3937/H3hCPaYNvdRW
	 uHwhns9v215TPH6qO5iL7MUXRhEWGx0N10CQ1r7y4XwrYr8MqS8Q8chZumJg7iUaWZ
	 nRsm4qIUWAWMm7ZxZwSVKjgUz81OA5b3rkXep2Iq4T9XtbZ+OzTN5ru24uSpYrR4vL
	 kaYDflDvphtutois92MWvQZMreeiPtX9/QZVhhXm2xFQ2jmQILNZGivzd+ivG8/oqa
	 BmbAJGDRGY7tQ==
Date: Mon, 16 Dec 2024 21:45:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "jiri@resnulli.us" <jiri@resnulli.us>, Leon
 Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Message-ID: <20241216214528.42dc9a1b@kernel.org>
In-Reply-To: <73d7745697a9ab7507c5e4800b0dfc547823d475.camel@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241206181345.3eccfca4@kernel.org>
	<d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
	<20241209134141.508bb5be@kernel.org>
	<1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
	<20241211174949.2daa6046@kernel.org>
	<73d7745697a9ab7507c5e4800b0dfc547823d475.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Dec 2024 13:42:46 +0000 Cosmin Ratiu wrote:
> > > Then, it would need to have the ability to group TC queues into a
> > > node. =20
> >=20
> > =F0=9F=A7=90=EF=B8=8F .. grouping of queues was the main direct use cas=
e for net-
> > shapers,
> > so it's definitely there, perhaps I don't understand what you mean. =20
>=20
> Another side effect of the terminology I used. net-shapers currently
> deals with device queues and grouping them, I was thinking about
> defining another logical view for traffic split according to traffic
> class, grouping of traffic classes and applying limits to the group.
>=20
> Right now TCs are not modeled in net-shapers at all. That's why I'm
> waiting for Paolo to comment, I have no idea what thoughts were put
> into modeling traffic classes in net-shapers.

I'm not sure if Paolo is familiar with details of any device capable of
implementing shaping based on TC. You are, I hope, as you're trying
to add Linux uAPI for it.

> > > Do we want to have two completely different APIs to
> > > manipulate tc bandwidth? =20
> >=20
> > Exactly my point. We have too many disjoint APIs. net-shapers was
> > merged on the premise that it will at least align the internal and
> > driver facing APIs, even if we still need multiple uAPIs. =20
>=20
> The current patchset extends the well-established devlink rate API with
> the minimal set of fields required to model traffic classes and offers
> a full implementation of this new feature in a driver.

"I just need these few extra fields" is not conducive to good
designs which can stand the test of time.

> It was designed and started before net-shapers was merged.=20
> We did consider integrating with net-shapers, but because it wasn't
> yet merged, it couldn't do TCs or multi-device grouping (nor intend
> to do multi-device), it was rejected as the API of choice.

net-shapers took months of meetings and many, many revisions.
Providing an abstraction for all scheduling hierarchies was
an explicit goal. And someone from nVidia was actively reviewing.
Now you say that in another part of nVidia a decision was made
to ignore what the community was working on, sit out discussions=20
and then try to get your own code merged. Did I get that right?

> Can the missing link between TC modeling in net-shapers can be added
> in another series once it is better understood and discussed with
> Paolo?

Certainly Paolo's contributions would be appreciated. But I hope=20
you realize that he is a networking maintainer (like myself)
and may not have the time to solve your problem for you.

I want to be clear that I don't expect you to migrate devlink rate
to net-shaper style API at this point. But we do need at the very
least a clear understanding of how the objects are mapped, and
therefore how TC support would fit into net-shapers.
Ideally, also, less disregard for community efforts.

