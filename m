Return-Path: <netdev+bounces-213860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EE1B272B9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A5C1CC353A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53B2853FA;
	Thu, 14 Aug 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nbB0IjiO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA292750F9;
	Thu, 14 Aug 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212381; cv=none; b=oFX86/y15GUMm8nrYEcz4pxwXfKTkL8jf+/mXkTR99nbqlSPXNXy50LV83/Q2I9kjyJWZo+i8GIMVe8D3WcZnumopeHfMrH7S+Onb8UMSDNpyp5tkUy8ulMyxLXRIr+PzT5Ew19KCHwcmP1yeP16fgDDT6vSxFBpkZDfNNm++kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212381; c=relaxed/simple;
	bh=wRmDNIfn0SfSwme/IUQhw758Yz/1APoVv6n8UlZ5c4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ2bWN2o3iXZPrhLKD8J12liVxImcFFa/1rMFmj3RfQjXng6j9bHktpYkxNYAnOooQvmE/dGmXbnTIKnuGKWZOq3xmg3pXtO59YbEkjrkvZ2lfrsU53/4/7fT0dEZbWxJCjvDEAHjHP/B0zGdJo93lNX9SWnWiJB08Y4A8fGAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nbB0IjiO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FVeqKZFSQAwTQ3X+OQ356lDO2rMn750JHLVwuLVdXuY=; b=nbB0IjiOCZdnPWniC0NBCmaSWG
	VUswlUZpP9b2hcKUXjyw+4lNp5AQmRqjhDphqc6ljlGagKOZPy1cvc4g7J4XWdxR3t+awNs8Kz5YS
	5VH/EbCWkaxCYIjuC3the6YEM5UApFrEuNWEr0XtBFHsImabcBj/ASe3mmBd3J67o8SI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umgux-004kxy-TD; Fri, 15 Aug 2025 00:59:31 +0200
Date: Fri, 15 Aug 2025 00:59:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frieder Schrempf <frieder@fris.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jesse Van Gavere <jesseevg@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
Message-ID: <d7b430cf-7b28-49af-91f9-6b0da0f81c6a@lunn.ch>
References: <20250813152615.856532-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813152615.856532-1-frieder@fris.de>

On Wed, Aug 13, 2025 at 05:26:12PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
> HSR ports. This is set up when creating the HSR interface via
> ksz9477_hsr_join() and ksz9477_cfg_port_member().
> 
> At the same time ksz_update_port_member() is called on every
> state change of a port and reconfiguring the forwarding to the
> default state which means packets get only forwarded to the CPU
> port.
> 
> If the ports are brought up before setting up the HSR interface
> and then the port state is not changed afterwards, everything works
> as intended:
> 
>   ip link set lan1 up
>   ip link set lan2 up
>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>   ip addr add dev hsr 10.0.0.10/24
>   ip link set hsr up
> 
> If the port state is changed after creating the HSR interface, this results
> in a non-working HSR setup:
> 
>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>   ip addr add dev hsr 10.0.0.10/24
>   ip link set lan1 up
>   ip link set lan2 up
>   ip link set hsr up

So, restating what i said in a different thread, what happens if only
software was used? No hardware offload.

	Andrew

