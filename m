Return-Path: <netdev+bounces-101249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2A78FDD6D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE451F23978
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4E241E7;
	Thu,  6 Jun 2024 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="iNpOkRcf"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39D1EB35
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644290; cv=none; b=pWIPI3I9dQM3smqn62xIE0RbNV1uLp8A6GsZRBkdFdRuxRL/CGKDQiNQWpweB3JkI9UviAAw0hoyBIXyCpDGPyHWiTLM74Y1+wVdl7gAiUY6D1BvUN1RCSJ4WkkGjesC7qucaffFIwItZFs6jHOBs/LGVzv4jVZwEnCeT2/rSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644290; c=relaxed/simple;
	bh=vMi52FBFgiR77j21DNfYEGwAeaho6WnjiGnfa4Mdrb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDYdrQ7C9iG+lrJXMUyR9i3mHDyIfGck/DasTHmct5TcVWdVq2Mj4K54xknCtIor60UX4lVDGghJVDZh1bhoTZUNAOo7pkmyi9OQYt3MdZIaFsjCU8KAV8B3GrbAYK6cnlSEsMxMkr56EHirzPTy/UFs57zNdan6+U4NVmIyV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=iNpOkRcf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8F31B20154;
	Thu,  6 Jun 2024 11:24:46 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717644287;
	bh=vMi52FBFgiR77j21DNfYEGwAeaho6WnjiGnfa4Mdrb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iNpOkRcf1g5fXcZfrEV5JxgJtFDCrWs0inj/MMVv/Q5SIPKNOkjFnC0LkIcUkKpEH
	 G5rhiQSQZQ6TA8VHvmBllyrWXupVht/B3Hx6P1DfPFDs5k+ko+kKO3xKY+uC+m8uGN
	 T7Woo8C5iT9/97oknAq8PYUeZSYUrXUoGGupKG33a0uAnXew9FHH2oAgivXA6fiEfI
	 OvzWHOOwH+oSZe1EwcJHGvMLOq7+SsXzCGDkGfNspJRLIksUOyPBCtems2bQ0gR1f5
	 wqhRyvt1W+Lv3exhG0Vgu2OgDzaZjlFytaLHQ7lTy8qVAiIsz79lOL0ZlAshEg2mcv
	 1YVilkwqZJhiw==
Message-ID: <6be3ae893d81480c675e055435eeaf48c1d85937.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Thu, 06 Jun 2024 11:24:46 +0800
In-Reply-To: <20240605200839.5127eb8a@kernel.org>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
	 <20240605190212.7360a27a@kernel.org>
	 <ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
	 <20240605191800.2b12df8d@kernel.org>
	 <fec284041a4a4ccc450fdfd504aae4f24458b79c.camel@codeconstruct.com.au>
	 <20240605200839.5127eb8a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > > Right, but I think "no exports unless there is an in-tree user"
> > > is still a rule. A bit of a risk that someone will roll their own
> > > per-cpu stats pointlessly if we lack this export. But let's try
> > > to catch that in review..=C2=A0=20
> >=20
> > OK, sounds good! I'll send a v3 shortly.
>=20
> About that.. :) We do advise to wait 24 hours before sending next
> versions in case there is more feedback / someone disagrees:

OK, for large values of "shortly" then :D

(sorry, I got a bit enthusiastic about v2, given the brown-paper-bag
bug in v1)

Cheers,


Jeremy

