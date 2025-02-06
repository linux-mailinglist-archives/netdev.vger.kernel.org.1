Return-Path: <netdev+bounces-163396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE8A2A1D4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D247A401B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B42248AD;
	Thu,  6 Feb 2025 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="X//LXDCL"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220B31FF617;
	Thu,  6 Feb 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825890; cv=none; b=Mcf6TmwRN8Zle953ydK02TU7cdj8s9gEKI6I6D9sTgqZ+GRx4iOtUb2jqCfGcdREhvSObsVORyevIwh3XCI72eb1nNhmuttJNfp1lCeakuhW8Uzgka/M7lRZnsOfnZq6P4HMLpizBXgwgSUB3obs9Jl8cX6pRnwnGzUI/JtwgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825890; c=relaxed/simple;
	bh=/o6Y7to+Ri85l2gX0fMVFvpSeIdo2PByk8wsBpeM1eA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpRQbMbsOZ1E/cs1wI9hDhOWArEoLn7La2RTCP3OH/sybwsf7iQ257LF94yMFheg0eg0Tz1f3hkp0RIpIUJzzpN7z+jT5PzRftvXvorU94IKMtKrD0OZn0Td3rUzw9xAV/riQ70jrSQZ2ENu8fLzK6pVhXY/Y1yF2RHN0FiHfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=X//LXDCL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738825887;
	bh=/o6Y7to+Ri85l2gX0fMVFvpSeIdo2PByk8wsBpeM1eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X//LXDCLyJCggILP2T1IPX+8rPYE0QZjS+jrFWJhweFT/w+xLQGd5K6sgYGDavCO7
	 vdKBa1ppqVsKs/uqRuhnI5Xpb/y00k0xuxM5OUcSfoXyi73bIfYRYFIpaoMRkwATWs
	 tzkJah+LbPgIniwVvh2PqX/fFTECaMH4FzZve9fux42CHIcjxPiQXK7Q53h3xRLjNH
	 2c7D7RqlOCGB2r3RKPsSAo3gF3j+L86xc7Pysb40E6txuVx2ZGy2gEsaSgbCYZm2Of
	 0h9CvKLI+C4CpkmVIQgF4EU/H1lkw/MSRIXaV5g/lUdM5Y/+Ey2wQHRZNyEefyy3OF
	 SLsvpM0fG83XQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 28CD874758;
	Thu,  6 Feb 2025 15:11:26 +0800 (AWST)
Message-ID: <a927fbb40ce2f89c57b427d4dabe5f730a523d80.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org,  Santosh Puranik <spuranik@nvidia.com>
Date: Thu, 06 Feb 2025 15:11:25 +0800
In-Reply-To: <2025020633-antiquity-cavity-76e8@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
	 <2025020633-antiquity-cavity-76e8@gregkh>
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

Thanks for the review.

> > --- /dev/null
> > +++ b/include/linux/usb/mctp-usb.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * mctp-usb.h - MCTP USB transport binding: common definitions.
> > + *
> > + * These are protocol-level definitions, that may be shared between ho=
st
> > + * and gadget drivers.
>=20
> Perhaps add a link to the spec?

Can do. I have one in the actual driver, but can replicate that here if
it's helpful.

> > + *
> > + * Copyright (C) 2024 Code Construct Pty Ltd
>=20
> It's 2025 now :)

WHAT?!

:D

(this was started in 2024, and I have some preliminary versions up since
then, but I assume the last date is preferrable)

Unless I hear otherwise, I'll v2 this after a netdev-appropriate
backoff, with the added link and 2025 for both patches.

Cheers,


Jeremy

