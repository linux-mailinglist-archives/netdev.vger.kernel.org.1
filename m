Return-Path: <netdev+bounces-152136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B69F2D5A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE76F168531
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414420101F;
	Mon, 16 Dec 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XF2GKj6k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39F1FFC60;
	Mon, 16 Dec 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342657; cv=none; b=fosu7kn7grmOax/7fUo0BH7ynsOkIi5cLNUdSGK91zVGu4k8ZiqJVcDFlBtiZnYCj7kW/jqaCBjijNNlGR/uR7WadGGVID7m+PVC3SeU6YApvJJ4rAnHO8GWZkQddtNgfj7aNcyOTuCy6SJaWo7S6mnhFdZnKU0kuro7JaSn7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342657; c=relaxed/simple;
	bh=OXH3vzFbTKiksm17WzE85cZSQvrh0pzJ0BYKopvv0Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvRW5PLixehAqqMfbFXP74CbhVBm/xCPg+C8otMsw2nac/dZMZTDUBqXGxaf+0E8jyT5qSrxMkow4TB+SLkmqp4RsW7ZqfFKW8oQlTpQn3CMBqEJcfX440TXV50oHuFQekTK9wGna8qFdkvfuVBQ6eQohV41p17LeSoV2sV/M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XF2GKj6k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iD1FEhJZlGeiVYsnMDwAlowtkHpoTLbshiukFYl2KaM=; b=XF2GKj6kJU5FS/X7QTlAiTDM3w
	HegibULLdFbidcbNg5A5MXK/3sOhmGXp1XP55C5to6NonW7yLtrVwZYYe5kTbvsRvijURfDITzRzy
	zH/5g4Pq9oH2K59QGmikgaqokEUQUibDPFgoggiKo/ttkp+Ka+fOpQal4IBdxyHYh+tE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tN7kV-000ZuS-3W; Mon, 16 Dec 2024 10:50:47 +0100
Date: Mon, 16 Dec 2024 10:50:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Forsblad <mattias.forsblad@gmail.com>
Subject: Re: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Message-ID: <289fa600-c722-48d7-bfb9-80ff31256cb5@lunn.ch>
References: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
 <20241215225910.sbiav4umxiymafj2@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215225910.sbiav4umxiymafj2@skbuf>

On Mon, Dec 16, 2024 at 12:59:10AM +0200, Vladimir Oltean wrote:
> Hi Andrew,
> 
> On Sun, Dec 15, 2024 at 05:30:02PM +0000, Andrew Lunn wrote:
> > Add internal APIs for enabling the Remote Management Unit, and
> > extending the existing implementation to other families. Actually
> > making use of the RMU is not included here, that will be part of a
> > later big patch set, which without this preliminary patchset would be
> > too big.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> 
> How big is the later patch set? Too big to accept even one more patch?

The patchset is 21 patches, if i only support one switch family.

I can remove a couple of patches, getting statistics via RMU, and
timing the RMU vs MDIO and disabling RMU if it is slower.

The other way i can slice it is split it into two patchsets:

1) incremental modifications to qca8k to centralise code
2) implement the mv88e6xxx changes to add RMU to it.

I did not really want to slice it like this, because the central API
is designed around what both QCA8K and Marvell needs, and hopefully is
generic enough for other devices. But there might be questions asked
when you can only see the qca8k refactor without the Marvell parts.

I can maybe squash some of the QCA patches together. Previously i was
doing lots of simple changes because i did not have hardware to test
on. I do have a QCA8K test system now.

> There is a risk that the RMU effort gets abandoned before it becomes
> functional. And in that case, we will have a newly introduced rmu_enable()
> operation which does nothing.

True, but i'm more motivated this time, i'm getting paid for the work :-)

And there is one other interested party as well that i know of.

This patch series is fully self contained, so it easy to revert, if
this ends up going nowhere.

	Andrew

