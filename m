Return-Path: <netdev+bounces-186827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC8EAA1B0E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0417BD0E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D58253948;
	Tue, 29 Apr 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yCjeIAQG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98131DB366;
	Tue, 29 Apr 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953220; cv=none; b=k7IfFU8P+xK5xjYVdmN3UoIU1BU41dd5kuREnogsGb+lfOZnJn58QLnf8VdPUkgjvHh9gmBUdnei+Cbxpy2Aawmul+XRTKsRm2c7cc5I5yNC/9vZnOF+xD4Ba9EEM5KAEPO8Q2miTJ6ouYBca+b4/I1vRiR/XYh6zaPs5ZCwPt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953220; c=relaxed/simple;
	bh=Z1qh8OBGmXNvwpBBCX1H8kIisGUVStApXgDJ+jChMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg3NJesaymMokkMN2SKrbNyFBP/Enynu5H5UZsY01wROMGWDpBN9H7/O+b6wGqMTR5lYukA164/J7JXv9CtsSHAqdVSKFwgR0WLHd9QZPsmYtv//ryPJ7jDLPKUNtYDJBBOCNj90xQK9tRp++G4aq7oahtI6+Jmx9QxPcxTbLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yCjeIAQG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4D4yC/lzo71KEI1Abi+DFBdXVlGZkBuOIOydyjBJlM4=; b=yCjeIAQGCcGsSMT+mR4wrPoSCC
	PtFNohXv1cfKGpIOJmp36yM1zAamxaLZxE1T/ahR1alPp3pTZhY6zeedsLVAMwQK/kreZ8V0AuPiT
	vQQhD/QZGbufd1hEMbfoncdeTbisvG34IjR9xqjOw8Jxo3GkFyVi6+1Cfa+WCiffCJRk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9qBZ-00AyT4-Pt; Tue, 29 Apr 2025 21:00:05 +0200
Date: Tue, 29 Apr 2025 21:00:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>,
	george.moussalem@outlook.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH] net: dsa: qca8k: fix led devicename when using external
 mdio bus
Message-ID: <6940ad35-1840-4b3b-ae71-27d91f648702@lunn.ch>
References: <20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com>
 <20250429114128.5b7790ad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429114128.5b7790ad@kernel.org>

On Tue, Apr 29, 2025 at 11:41:28AM -0700, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 10:49:55 +0400 George Moussalem via B4 Relay wrote:
> > From: George Moussalem <george.moussalem@outlook.com>
> > 
> > The qca8k dsa switch can use either an external or internal mdio bus.
> > This depends on whether the mdio node is defined under the switch node
> > itself and, as such, the internal_mdio_mask is populated with its
> > internal phys. Upon registering the internal mdio bus, the slave_mii_bus
> > of the dsa switch is assigned to this bus. When an external mdio bus is
> > used, it is left unassigned, though its id is used to create the device
> > names of the leds.
> > This leads to the leds being named '(efault):00:green:lan' and so on as
> > the slave_mii_bus is null. So let's fix this by adding a null check and
> > use the devicename of the external bus instead when an external bus is
> > configured.
> 
> Hi Andrew, would you mind taking a quick look?

There is a somewhat ongoing discussion which could affect this:

https://patchwork.kernel.org/project/netdevbpf/patch/20250425151309.30493-1-kabel@kernel.org/

It could well be there is no internal and external MDIO bus, its just
one bus with two bus masters. LED names are somewhere ABI, so i think
we need to resolve the other thread first.

	Andrew

