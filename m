Return-Path: <netdev+bounces-84659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B1897CB2
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7215A289072
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9079156C73;
	Wed,  3 Apr 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MWgcayl5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72F692FC
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187830; cv=none; b=QlqmtOruDSVIZb54CHE5v94T7Shyx7QQ6oOZG4ofpQXxbA9GlsCgtf/PMnP2QrnC7YChw3JuakPfVHDFER2wMCpVCpg0quoFWYpLVKmytswMjXKoOZikTMmxPQrpbbK6l9JWF0wNqdaj42Bfz1ZLPT2NrYi7wu+i2AlTC993a+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187830; c=relaxed/simple;
	bh=042L/4RyDGExrQ9PMvptTaPJtgzJwYNsGHfdAV+FjDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCpex0h8hAYCm2JZ1pkVQoJ80lBcDR1gGNAhT2X7gpfyQdsCiZxe5iw5NZIS07qD1cGeQwvbQIeXq2S5iXV+Zmvx1NN+/IYhogj++A6miHsfFd3YLrDyvCcnJMAs/9+25UkXSTb7VK8o2evhVspidrhmI1YbEcnadwdAb9R9hDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MWgcayl5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GUYAmFkA1M33rwwXCAQv1+F2OHINa2A63tcBhMytI2g=; b=MWgcayl5+YAu+6Ab9n5UUcafVh
	uUkfm5WwG2H2GHplExmJrtpd4KRQC1O9fofi8dN8SG1BneCZOQ3cER9RwNr4vwi5NDwUTOz6mwbcC
	BZXJLWjnhXIxUnGW3GZbdRRocgIjb8HNg8bK2d5FlsO1VuwEfB1teUgGEiJ5fM8BAAZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsAGX-00C7sA-N6; Thu, 04 Apr 2024 01:43:37 +0200
Date: Thu, 4 Apr 2024 01:43:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] net: Add helpers for netdev LEDs
Message-ID: <a68a52d9-86e7-4c1c-970d-a8fd6a02fc8e@lunn.ch>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-2-221b3fa55f78@lunn.ch>
 <20240402095340.fnfjq3gtvjd4hakv@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402095340.fnfjq3gtvjd4hakv@skbuf>

> Should we be even more opaque in the API, aka instead of requiring the
> user to explicitly hold a struct list_head, just give it an opaque
> struct netdev_led_group * which holds that (as a hidden implementation
> detail)?
> 
> The API structure could be simply styled as
> "struct netdev_led_group *netdev_led_group_create()" and
> "void netdev_led_group_destroy(const struct netdev_led_group *group)",
> and it would allow for future editing of the actual implementation.
> 
> Just an idea.

Hi Vladimir

I'm not sure making it opaque brings much for this case. It is so
simple. Things like phylink should be opaque, there is a lot of
internal state which if used in a MAC driver is going to cause all
sorts of problem, and is likely to be used wrong. But here?

So i will probably leave this transparent.

Thanks for the other comments. I'm slowly working on them as time
permits.

       Andrew



