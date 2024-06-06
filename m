Return-Path: <netdev+bounces-101243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B48FDD18
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4861C21B39
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A8134B0;
	Thu,  6 Jun 2024 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PPdvN2fy"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4B3D71
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642868; cv=none; b=lUcpBhhTHH4LUNYO4Zun20QbtOsGK/5ZV3G0cGMqrFzDdsJQzBZLK0OBJhloCIPxcU0nKSw2Al4+X75JdE8b/jy/OClQEedEUpXIpViOV5KBX1NwLtJwyke07P8zBD2IqR7LC5nl8s3Z6UtnGDUgoToWUKB0ytIhRu3NWdy2vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642868; c=relaxed/simple;
	bh=HdJ41HGpdoj7n5aT+4odLX6+KsIUsEQo8g2xK0DRhfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPEU/fJsOsFpqowBnfYL0pYQtGFHt9mSFvvWrkjVaw18OzEapnwwtgfJOEvR7Ha54lRfSW73QK/Mf0jm/Xx4zCQYZ7FiZBvxtXqvzZuodV7tUh89quHfQ+5MMdipLSGEQFzNC7LcuqfkM4d5MqJzmTrdFQtbWvofT10HpmxDb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PPdvN2fy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 72F9720154;
	Thu,  6 Jun 2024 11:01:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717642861;
	bh=HdJ41HGpdoj7n5aT+4odLX6+KsIUsEQo8g2xK0DRhfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PPdvN2fy2k/KnSGUOOfYUXHP75olXi9pa0yRIPz1LXrWbbKVQA3F5sMhWzj6oy8FT
	 +cefdGDCB8BO5qoMUWVW5pVAnkk0C2+GdPdqnmDlOMpI+VkHe+K77Fgfxyau8hsuwl
	 XkPWKNQl6Flnlj2fsQfY5sp2j0f11P6gobumrAlkU7Z3hJ3u+6so9i0AHK/qdbBE2Y
	 oJQAG8o0VvN/CPSRFfkY7vuo5XFPilRl0GphqG7nvWDfHXQjBJwo0ip2P2SDTLOGJy
	 WFPFYv3gNzuXWXUcS5dwuzq+uxJRddDsP3bQg1f4ZysM/pe8u7872MgxGb0wgDPL2I
	 IIgmoxEyUj+gQ==
Message-ID: <fec284041a4a4ccc450fdfd504aae4f24458b79c.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Thu, 06 Jun 2024 11:01:01 +0800
In-Reply-To: <20240605191800.2b12df8d@kernel.org>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
	 <20240605190212.7360a27a@kernel.org>
	 <ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
	 <20240605191800.2b12df8d@kernel.org>
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

> > If we're not exporting the helpers, that means that drivers that
> > use
> > dstats wouldn't have a facility to customise the stats collection
> > through a ndo_get_stats64() callback though (as can be done with
> > tstats). Are you ok with that?
> >=20
> > [the set of drivers that need that is currently zero, so more of a
> > hypothetical future problem...]
>=20
> Right, but I think "no exports unless there is an in-tree user"
> is still a rule. A bit of a risk that someone will roll their own
> per-cpu stats pointlessly if we lack this export. But let's try
> to catch that in review..

OK, sounds good! I'll send a v3 shortly.

Cheers,


Jeremy

