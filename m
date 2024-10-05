Return-Path: <netdev+bounces-132399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252599185A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA502817BF
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF4155742;
	Sat,  5 Oct 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VGRe4NKI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE1288B1;
	Sat,  5 Oct 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146176; cv=none; b=q3M6yU3y6uN/oA5js/tb3qDAqs/zK12ZtbS69VtlEqtI1wOZPdpvaCGdw+dp78VcLkIP7r0m4vIzC0vp+zOB+kvDg7LR2DOa5FwwG0DiCSFdFgqxdiMJuXxb/2JxGPWs7Dp8UYc92O2MZ5gkPQdYYvaTYlF6rBEzaJh8mRnXyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146176; c=relaxed/simple;
	bh=ru7GLiJUmCCmoknrs+EwrenWy9SEzZ/qZ7neAppcpc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6nJAOE6KVgH9/dJV7+972515u+2s8qzhWCrg8yPaWIXvOtMeNQWCL0JDfyd/k7YbI0poo5x5US6UeGiGXafigw5gv4roef/oRb/2vKzarSFoVOfRYer5+kbKa0mtSHj1rNLXswWxWE8ZFQGZM+l2uB87qQf+mWnJYbEmSy0aEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VGRe4NKI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y9VgHJAaPKZQxnIFUQ21M2uzqO2mV5plof64xb/Nx5E=; b=VGRe4NKIL/hSbCg10s/BFL8DYC
	mqxhxMlA3DF4dS4G5llfBMM/Uvx4BNF/tmSJA5T4ucP0btkgSK/LqzGboKPm4sATaXjuQtiRjx6fy
	ePaCPWizCoYrtmTZWXnGx40H9Sut0A9DnzzdYt2/HOGymDLrQ6Nc67xsU5w1I57b4GbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx7l8-0098rS-4L; Sat, 05 Oct 2024 18:35:58 +0200
Date: Sat, 5 Oct 2024 18:35:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: phy: always set polarity_modes if op
 is supported
Message-ID: <2b6f2938-12de-4ebb-9750-084de5d2af0b@lunn.ch>
References: <473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org>
 <5c821b2d-17eb-4078-942f-3c1317b025ff@lunn.ch>
 <ZwBn-GJq3BovSJd4@makrotopia.org>
 <e288f85c-2e5e-457f-b0d7-665c6410ccb4@lunn.ch>
 <ZwFggnUO-vAXr2v_@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwFggnUO-vAXr2v_@makrotopia.org>

On Sat, Oct 05, 2024 at 04:51:30PM +0100, Daniel Golle wrote:
> On Sat, Oct 05, 2024 at 04:17:56PM +0200, Andrew Lunn wrote:
> > > I'll add "active-high" as an additional property then, as I found out
> > > that both, Aquantia and Intel/MaxLinear are technically speaking
> > > active-low by default (ie. after reset) and what we need to set is a
> > > property setting the LED to be driven active-high (ie. driving VDD
> > > rather than GND) instead. I hope it's not too late to make this change
> > > also for the Aquantia driver.
> > 
> > Adding a new property should not affect backwards compatibility, so it
> > should be safe to merge at any time.
> 
> Ok, I will proceed in that direction then and post a patch shortly.
> My intial assumption that absence of 'active-low' would always imply
> the LED being driven active-high was due to the commit description of
> the introduction of the active-low property:
> 
> commit c94d1783136eb66f2a464a6891a32eeb55eaeacc
> Author: Christian Marangi <ansuelsmth@gmail.com>
> Date:   Thu Jan 25 21:36:57 2024 +0100
> 
>     dt-bindings: net: phy: Make LED active-low property common
> 
>     Move LED active-low property to common.yaml. This property is currently
>     defined multiple times by bcm LEDs. This property will now be supported
>     in a generic way for PHY LEDs with the use of a generic function.
> 
>     With active-low bool property not defined, active-high is always
>     assumed.

So we have a difference between the commit message and what the
binding actually says. I would go by what the binding says.

However, what about the actual implementations? Do any do what the
commit message says?

	Andrew

