Return-Path: <netdev+bounces-152418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC89F9F3E30
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954D1188A7F8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81511DB372;
	Mon, 16 Dec 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YMStkTti"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8E1DAC81
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391460; cv=none; b=nzUdnDGhdz+fDojtk61YFDDelJTaSyLauO3gYfwPABnP7AXMC5gHWJhs1PvWw2nuxJX4vYNOLUlusBI1aWUIyusUCqouCOjHujZY03D5iQsIJya+uhLynJa9+B5c67LqrZNcE9/V7wJwc0Nr29rbBCYQO1zaXNj2i1VMXrqPFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391460; c=relaxed/simple;
	bh=lL+bvYS4EJdrpZrecoOEAyifyCPdCWBqMAW61yJbHoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxD1sxJc8pNcSqdNQHgWccqucfHz1ztt9m/hMAsWTLLcjoACwliDG58IfSx4T7wv9AzE+PBgd63H9FTJQQ1zeTnsjqxe1AKqv5eW/zrYlLrXwHf6AfZGy6Klw2xf4RqrDykL3aopvii9wq+CNwY1fQKHs7QR0JhoYKG7nPdd3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YMStkTti; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zSj8+RWK2SiNAe6PGGhp2cTLK4JwUMnFo7weD/XBBNk=; b=YMStkTtitTtsICTISJA36ndR66
	xXkiLwpydJ+D1bCkdcThUmeB1UoHrEv0Kw9ecOiUMaKSEmxwOrbUrle7IuwWl15IG8YE6xA/87X2g
	59bu6wX1VrS5BZglnxqC36SNXg0TNuGihDVbwiktK19WE5ueCsKJCkVNPX5xbKpacMl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNKRh-000lve-4t; Tue, 17 Dec 2024 00:24:13 +0100
Date: Tue, 17 Dec 2024 00:24:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2B5DW70Wq1tOIhM@lore-desk>

> Considering patch [0], we are still offloading the Qdisc on the provided
> DSA switch port (e.g. LANx) via the port_setup_tc() callback available in
> dsa_user_setup_qdisc(), but we are introducing even the ndo_setup_tc_conduit()
> callback in order to use the hw Qdisc capabilities available on the mac chip
> (e.g. EN7581) for the routed traffic from WAN to LANx. We will still apply
> the Qdisc defined on LANx for L2 traffic from LANy to LANx. Agree?

I've not read all the details, so i could be getting something
wrong. But let me point out the basics. Offloading is used to
accelerate what Linux already supports in software. So forget about
your hardware. How would i configure a bunch of e1000e cards connected
to a software bridge to do what you want?

There is no conduit interface in this, so i would not expect to
explicitly configure a conduit interface. Maybe the offloading needs
to implicitly configure the conduit, but that should be all hidden
away from the user. But given the software bridge has no concept of a
conduit, i doubt it.

It could well be our model does not map to the hardware too well,
leaving some bits unusable, but there is not much you can do about
that, that is the Linux model, accelerate what Linux supports in
software.

	Andrew

