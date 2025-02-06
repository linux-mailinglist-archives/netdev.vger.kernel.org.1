Return-Path: <netdev+bounces-163400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79531A2A25D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BFF1617A7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3481A1FF61A;
	Thu,  6 Feb 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ITRI5F8B"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350A13AD18;
	Thu,  6 Feb 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827370; cv=none; b=V+CV8XGjnQHmGo034rsY8X47FegRQh5oLX+DbMRT0/bYIMQY8DlFg6Y3JDv80h9GOF5BaN62VS/hgUvH1F7yzb4Q5q8DNuPCU6mVqbghBDP2GRIrX7DJdoBoLaUzkbD7HkWuzoJBB4us2p7wmt/e29vfIAYfWkx1lAdnXYgq1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827370; c=relaxed/simple;
	bh=Do1P0nmcgeEUbDy/fq8KJysN/ob71k6jea/wl2KyyuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojtschEYcdAw/Egg+akMij6J5Ff5vj51fM5KZ8uLI+84lzawDxDKf8gKI+CNuSx6KU7WfO6G2iN7reaLzxWpqmflqfTDhqQo648mY6+cyOt1IIEm/0q5eZq2k670J8+D8Z21EQjDg1W2Eqq6QzWHef5fmtRrxm6BWJuQcFljhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ITRI5F8B; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738827365;
	bh=DoC2wDlKbXoOESvrEevknBBxtIZYb6+xglXUh+TGauc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ITRI5F8B1RHvsorqu/JFPjXvcgbQ31ZTGSuPJat0P5BhtlA6UaXYyJs7sVfNGIYNI
	 LICvo47zQNmICyv5vqbMZHrhOG2+KDgz+ObegxLtCT2TgRxEkerDXj2i/GALZXwtXh
	 TaLg8fNIYIfzTRb/AQq2wHcvzuJjGMWY+KXDEMa7ah+gHdlFQsVnfwshYKp6O0dZel
	 oT8Pvd8OPApmCMvB6il7wJ+kxBOtHz/U9b5sNsZTm4ZRvswpbkYxXz9+aXVxpADwcI
	 FmaeOjY7yZ6ewXeW0yt4lqomdEe5DJ2FRq3sCEmm5zJ79Oot8P0+//0881hafpsNRk
	 zTy9YPuHJNYKg==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A5197392E;
	Thu,  6 Feb 2025 15:36:05 +0800 (AWST)
Message-ID: <829b7f7688e701fd246fdac717fd3fd7efc81d65.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org,  Santosh Puranik <spuranik@nvidia.com>
Date: Thu, 06 Feb 2025 15:36:05 +0800
In-Reply-To: <2025020634-statute-ribbon-90a8@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
	 <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
	 <2025020633-antiquity-cavity-76e8@gregkh>
	 <a927fbb40ce2f89c57b427d4dabe5f730a523d80.camel@codeconstruct.com.au>
	 <2025020634-statute-ribbon-90a8@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
Hi Greg,

> > Can do. I have one in the actual driver, but can replicate that
> > here if it's helpful.
>=20
> Isn't this a usb.org spec and not a vendor-specific one?

Nope, all defined by the DMTF - so not really a vendor, but external to
the USB-IF at least. The only mention of this under USB-IF is the class
code allocation, along with the note:

   [0x14] This base class is defined for devices that conform to the
   =E2=80=9CMCTP over USB=E2=80=9D found at the DMTF website as DSP0283. Th=
is
   specification defines the usable set of SubClass and Protocol
   values. Values outside of this defined spec are reserved. These
   class codes can only be used in Interface Descriptors.

> As per copyright norms, list the real dates, so that would be:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Copyright (C) 2024-2025 .=
..

ack, will do.

Cheers,


Jeremy

