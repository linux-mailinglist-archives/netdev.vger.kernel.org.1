Return-Path: <netdev+bounces-78081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0382874024
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F31C236BA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198413E7C9;
	Wed,  6 Mar 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="56PRGUHD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014313BAE3
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752200; cv=none; b=cXODCmxws865bTQINMlLbYJBIQ6mdgIQye48/b1Wryh5ywpkqRP32oNDMbKfzB+qUjREsEb0Ca3JnWJGKJRx+uSBucNp8co8Af6OGZk38vSvC4LAZ7t1X1JdmUduQSXUWE/qEo9ZH7gu3bbns+P0UYsdpCEa8u3tJRsLzMTn7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752200; c=relaxed/simple;
	bh=E42rbONBmU7h5u5xWT3wDy6GMnovM2guvuxCtKqtYjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJjOYr/jvVe6nwve6PaUHloWf7pkVgDyKIQcsn//KQhXpXe/Fgje7CWJDX84+IK9P3jeNeiPSpkgOgfjg/zortn81NqXxrP97Ctkpoj5b364yqe5aOAKkw5oFft4b9pzwSb8Jyg8+zkJH9ZLAV843wmBYC7jyjg6LN0xSw4PDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=56PRGUHD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IsN6aZwiTdesYCrFEEwUlZMiij9moljQIGCZIx41cqY=; b=56PRGUHDFCr3ZiEWtRz7lqeHMt
	5dcOnmFOBTnEvVjJbvhiffchB2T81XiSY9q0c8yt9JbPaB5hdKwfO/bMBisqq573aOPPsIPU4YFyy
	BixPjIuVYxjlWrrq34RaZ5r5uvzLiFaLj9viY/oD2K6klY0Md4nTpfOOoTQZ50HMtbwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwel-009WWS-Rc; Wed, 06 Mar 2024 20:10:23 +0100
Date: Wed, 6 Mar 2024 20:10:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Message-ID: <8033ea62-7ecf-4703-9d7b-d18f66751b8c@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-4-antonio@openvpn.net>
 <e0375bdb-8ef8-4a46-a5cf-351d77840874@lunn.ch>
 <f546e063-a69d-4c77-81d2-045acf7e6e4f@openvpn.net>
 <d52c6ff5-dd0d-41d1-be6f-272d58ccf010@lunn.ch>
 <20240305113900.5ed37041@kernel.org>
 <5f7f088c-426a-493b-9840-02f3003a7381@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7f088c-426a-493b-9840-02f3003a7381@openvpn.net>

> > > Right, so this in general makes sense. The only question i have now
> > > is, should you be using rtnl_link_stats64. That is the standard
> > > structure for interface statistics.
> 
> @Andrew: do you see how I could return/send this object per-peer to
> userspace?
> I think the whole interface stats logic is based on the one-stats-per-device
> concept. Hence, I thought it was meaningful to just send my own stats via
> netlink.

Ah, interesting. I never looked at the details for
rtnl_link_stats64. It is buried in the middle of ifinfo. So not very
reusable :-(

Idea #2:

A peer is not that different to an interface queue. Jakub recently
posted some code for that:

https://lwn.net/ml/netdev/20240229010221.2408413-2-kuba@kernel.org/

Maybe there are ideas you can borrow from there.

But lets look at this from another direction. What are the use cases
for these statistics? Does the userspace daemon need them, e.g. to
detect a peer which is idle and should be disconnected? Are they
exported via an SNMP MIB?

	Andrew


