Return-Path: <netdev+bounces-76320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2786D401
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D89D1C21E76
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E957CF05;
	Thu, 29 Feb 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utUpHBFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D621160644
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237695; cv=none; b=EK+WWDOViAIaFkgvQm42WOcbN5mKx8LjdoiPIGJxzJkT4ZpIutrAIY+rJ7WZrXmc1vnKZ54VqHa81a5GIwKLfjL5zCnFnbBkRPHyMfg7GgZ1NBMtIGvuUEGzMjZ9KtCSkRPDLZZyghlH+SP2CJew3HSsvmgz0js5Fi82GHDO4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237695; c=relaxed/simple;
	bh=Wa3fEmcT8iASzXg5BDAQNlzrnTPnu1fep6ASZ72R8Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWis3z4OYgJc0QXgbV5FO/SXLBqlj/UPtrgxxXFkQWELQ1Oj2/1VYxvUmTrPidpfGOX61pcdLpdsq+IIYyU9W5Ne6kwhtLc5f36jnfQl/fdu5ZrHdtvkkdI8U48VPajMlArLOBV1GLyxd0+aw85N5VRAaBSH5baIjWkM/uZdmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utUpHBFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4EAC433C7;
	Thu, 29 Feb 2024 20:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237694;
	bh=Wa3fEmcT8iASzXg5BDAQNlzrnTPnu1fep6ASZ72R8Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=utUpHBFE4kXqFnhtJzD/RYBaUlQycyz2+E2jxZmTFR9iyEitcXVbIep2B23c2wQJw
	 ePReVvq6rk0xUv+qj0aGL0UUVsbAjAesknD/atsMuB1rcmZF5Z8+kWo98eSwSCT0mL
	 /VmhnNxtati7gWptNjU3kFYGDvQJaA6lQKHn6kmGcYOhCF+p7yleWWDFYVQL3HMhqE
	 YZfNhvZfTX22bR/KRi1WLH7CFj4Hr3lWBxjh8Vk9W7mg68U6/Tp05BQgms8m8MaiTG
	 D9F0cMy0q7Pwv6Xmd69t1UCN+gxzcpvU78/7Tm3odtKlMfURskYcOmxcmtiLn7uasN
	 5c57jtRB2JzkQ==
Date: Thu, 29 Feb 2024 12:14:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "nathan.sullivan@ni.com"
 <nathan.sullivan@ni.com>, "Pucha, HimasekharX Reddy"
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
Message-ID: <20240229121452.2272d01c@kernel.org>
In-Reply-To: <CO1PR11MB508939BB0C87493121CBE3B2D65F2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
	<Zd7-9BJM_6B44nTI@nanopsycho>
	<Zd8m6wpondUopnFm@pengutronix.de>
	<PH0PR11MB5095A06D5B78F7544E88E614D6582@PH0PR11MB5095.namprd11.prod.outlook.com>
	<20240228202055.447485cb@kernel.org>
	<CO1PR11MB508939BB0C87493121CBE3B2D65F2@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 20:09:03 +0000 Keller, Jacob E wrote:
> > On Wed, 28 Feb 2024 17:43:03 +0000 Keller, Jacob E wrote: =20
> > > Without this, the i211 doesn't apply the Tx/Rx latency adjustments,
> > > so the timestamps would be less accurate than if the corrections are
> > > applied. On the one hand I guess this is a "feature" and the lack of
> > > a feature isn't a bug, so maybe its not viewed as a bug fix then. =20
> >=20
> > I tossed a coin and it said.... "whatever, man". Such sass, tsk tsk. =20
>=20
> I might have not had enough caffiene when writing that email... =F0=9F=98=
=8A

Sorry, my bad, I was barely awake. What I meant to convey is that
it's borderline, so discussing how people feel is not a good use of
anyone's time.

It's a 3 LoC change to include one chip in what's done for another chip,
it has been well tested, and has user impact. It's fine.

