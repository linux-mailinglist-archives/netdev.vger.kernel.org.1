Return-Path: <netdev+bounces-166915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A0A37D9A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8902A163A25
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACA1A2C11;
	Mon, 17 Feb 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LSLTan43"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83751A2658;
	Mon, 17 Feb 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782567; cv=none; b=QEAWrP9o0k6Pw5/ZQ7QifPr4JktX9QO9Rn1god0VJZzdFtjLJ1yjQ3UQ2YUhoXoDVfyUQGAVsDFga4uWnjm8yVpAzR98oSGYrHeRHZIpFaudnxGsbc5r1eU/qunOnxrXu5cpMcC45pHM4zLnqSo66p1WmYnNVzvi5X7YMVcj4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782567; c=relaxed/simple;
	bh=cvxMnQojj6Jfi1YGr/vs8VaMRw/zFCObRICSLnHIrf4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6PVtRUSlV7uDI9DXR2IY4pLS464FzZC7IVSpQlQ/9MDHV39GYAVv873Wlvdv6B9jXq4gQfcarjHWABdTJ/fm3Ffhd5+tyvOz+kl1dapxzE0ipRwV2htwNzMCpKcUMIPDYTB1VYfmvr3aGgJS1KQN8so921j2xNTHq+iw1mlWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LSLTan43; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739782559;
	bh=cvxMnQojj6Jfi1YGr/vs8VaMRw/zFCObRICSLnHIrf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LSLTan43Udn9dhevx5NweXApXiMm9e9bomE123c9iWUJnEo0+XeMYvOuaGTAsBu0Z
	 907hiKHK34OwOfkj2PSA8FBIphtkpf/bWV4RfekjE49SMfJECq8BlsmQ2KcoFk12cc
	 SukAKcWghZZtXgZivCcVPZEJn4WPaSLnvDRyYp+Kk1wP2o4bWPtV79hgDBoa2RHT1K
	 b86W39AVqEhTdr9C8RfllbDjCVEYq9u8v9kBtES/S17WHJDPA6z9ujqYv0WMmZiEXB
	 tWf4/bze7WdvvPqCRHyjuLde3NArN1sCWsNBfRFtmvY+MZmCdg5YuxmMFGYBoezvkC
	 BYkINGyHox40w==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3A7AA761CB;
	Mon, 17 Feb 2025 16:55:59 +0800 (AWST)
Message-ID: <20d5843de6629036ce67420be9d2d2b5907c3261.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 1/2] usb: Add base USB MCTP definitions
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org,  Santosh Puranik <spuranik@nvidia.com>
Date: Mon, 17 Feb 2025 16:55:59 +0800
In-Reply-To: <2025021240-perplexed-hurt-2adb@gregkh>
References: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
	 <20250212-dev-mctp-usb-v2-1-76e67025d764@codeconstruct.com.au>
	 <2025021240-perplexed-hurt-2adb@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

> > --- /dev/null
> > +++ b/include/linux/usb/mctp-usb.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
>=20
> I missed this the last time, sorry, but I have to ask, do you really
> mean v2 or later?=C2=A0 If so, that's fine, just want to make sure.

I'm fine with 2.0+, but I figure the preference is consistency here. So,
since I'm doing a v3, I will send that out with GPL-2.0.

> Whichever you pick is fine with me, so:
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks! v3 will have the __u8s changed to u8, as Jakub has requested.
Would you like me to keep the Ack on that?

Cheers,


Jeremy

