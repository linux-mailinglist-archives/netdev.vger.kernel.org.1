Return-Path: <netdev+bounces-78750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD518764CE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55BB283781
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4C1DA5F;
	Fri,  8 Mar 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h2/GV7d4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DD1D52B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903587; cv=none; b=Qn/+hBD48tqF7exSazWpkIk6tdJqXo8vOjPRZdoVGkvysg8mwLfwrBRNcjbKAQNPVdsiRfh/8exHX/nJ9b45nUWlq5yhfwbuG3zCDsKoVHyV6L0mnoCmG8AXVM8MWH86SqN5iZvVLZSLajk9xBm5BItYKpRzKcNCkLj92w6ct6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903587; c=relaxed/simple;
	bh=qrs33oqmCSQB8Oe2aG+nn0I65bLciOTgJGd1xV04Kpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxCXs7iPbLp3YKTYtF6lmBRXH2bITJROSa+QtzKKRJyYhCRwHUeksQNn2Vx237Sx/VTpRRsFJQApQ4Vx4+Rx+06yRVSFehQSCcVaaXDamNps4uhSeWgxKXuKCo0xD6uQvKIYM/QNXvJyEleZGTfg3SnzJwjSjRoeMf9XQ35zJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h2/GV7d4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=77YASuY9NYsQZ8BqJB/v2f09IMEsp1/OMYkkkcGPpiM=; b=h2/GV7d4qzfZfrrVb9zRK9U3GT
	6l3MROx8rcgZk6iQ6mdTjbnM+RYsFhZu5gJojg6Uf0PfMY4RefjnPAwLiSdP7hdxG5APq/4oFME0F
	kH66PlJeqVz8YO3ctTG/KfiXdiCX/W0aqXQb6eG8WUsKt+t1cTtGsAQHEHCLcQXD/2QY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ria2X-009lOS-Cg; Fri, 08 Mar 2024 14:13:33 +0100
Date: Fri, 8 Mar 2024 14:13:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <b1b50cad-30dd-4002-8950-0869d636b6a7@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
 <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
 <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>
 <b3499947-f4b6-4974-9cc4-b2ff98fa20fc@lunn.ch>
 <d896bbd8-2709-4834-a637-f982fc51fc57@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d896bbd8-2709-4834-a637-f982fc51fc57@openvpn.net>

> To be honest we don't have any real concept for the carrier off.
> Especially on a server, I hardly believe it would be any useful.
> 
> However, on a client or on a p2p link, where there is exactly one remote
> host on the other side, it may make sense to turn the carrier off when that
> remote peer is lost.
> 
> There is an extra detail to consider: if the user wants to, the ovpn device
> should remain configured (with all IPs and routes) even if openvpn has fully
> disconnected and it is attempting a reconnection to another server. Reason
> being avoiding data leaks by accidentally removing routes to the tunnel
> (traffic that should go through the tunnel would rather go to the local
> network).
> 
> With all this being said, it may make sense to just keep the carrier on all
> time long.
> 
> Should we come up with something smarter in the future, we can still improve
> this behaviour.

O.K, so..

You already have more patches than recommended for a series, but... I
suggest you make the carrier_on in probe() a patch of its own with a
good commit message based on the above. We then have a clear
explanation in git why the carrier is always on.

	Andrew

