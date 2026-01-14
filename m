Return-Path: <netdev+bounces-249885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CD7D20366
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F2D302BAAB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F593A4AA3;
	Wed, 14 Jan 2026 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cyJ8GstR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02B3A35A0;
	Wed, 14 Jan 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408166; cv=none; b=EkZbzuOoPcA4fsLqpmkHQeMDfWuiff3QhL5C8J2ZiP8alfT9rywLHfoDj+ZomoMB3RGWS4JQEsWlmeEj+UW6TZco/jT4PM9k+3NoWdNe/2d54Ud5zaBQILB8cmgV6VSZxt2kzq7oAVVfRjm+MZhGtou1ZK4EDQErmA7UbnN7c+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408166; c=relaxed/simple;
	bh=JCZmmulVj1i6gAtQWpSVOkvrEvtb79UYsoXUOnDfxLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOb0omXXmo8Ng56Fx9xbpRIXSO9dV5+qe0cXGMiLBbDe9BO2O06WXqsw8suFBGJwSls4KLh3U1mB/3OT00+Zs4gZoYoDzAfRHjQ0UhVfSrrScKE22dPx/Dz/dSTQoIXQaMXmaP53eyGFysEIM0GgHfRe3F91SMywV5SZDjYJ6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cyJ8GstR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y61uYm3JH/KtNk15jytJHmmEwvziKjnfVE0sSCeGVIs=; b=cyJ8GstRn0EIheiYdc73zL9HtH
	64Su9Ij7Qv7IV/7aNTOGq2uxl2AoucyFgh9I4BWWbTQtWrEU0jLF9cU4CS69+9fPxkYt6mxUAR6eq
	FypwiYnvKw/c835Zv6vB/+2V5vuB9C7ZvW9GpmCRA+mUiIh1t/3r6/A0jVkDAJxjE5qnV/8iCYwoC
	d3pCDrGGWXstTu//2XilB/TD6cWCZaJrjx9lwZdlz/+j4jj4gkI4m0kOc9nl+ouQBbIEBDXMDTwZe
	h9RXCGmNY0h0p01wGoPlkZCQwyEn4suSfM+giJwaqnS+eikXzerGCIGAR9W6MfKdySKZwgknZn05Y
	j2MIhhNQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55620)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vg3kH-000000000N3-00Z0;
	Wed, 14 Jan 2026 16:29:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vg3kE-000000001mn-0F8r;
	Wed, 14 Jan 2026 16:29:18 +0000
Date: Wed, 14 Jan 2026 16:29:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed
 interface
Message-ID: <aWfEXX1iMHy3V5sK@shell.armlinux.org.uk>
References: <20260114081809.12758-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114081809.12758-1-marex@nabladev.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 14, 2026 at 09:17:54AM +0100, Marek Vasut wrote:
> If an interface is down, the ETHnSTP clock are not running. Suspending
> such an interface will attempt to stop already stopped ETHnSTP clock,
> and produce a warning in the kernel log about this.
> 
> STM32MP25xx that is booted from NFS root via its first ethernet MAC
> (also the consumer of ck_ker_eth1stp) and with its second ethernet
> MAC downed produces the following warnings during suspend resume
> cycle. This can be provoked even using pm_test:
> 
> "
> $ echo devices > /sys/power/pm_test
> $ echo mem > /sys/power/state
> ...
> ck_ker_eth2stp already disabled
> ...
> ck_ker_eth2stp already unprepared
> ...
> "
> 
> Fix this by not manipulating with the clock during suspend resume
> of interfaces which are downed.

I don't think this is the correct fix. Looking back at my commits:
b51f34bc85e3 net: stmmac: platform: legacy hooks for suspend()/resume() methods
07bbbfe7addf net: stmmac: add suspend()/resume() platform ops

I think I changed the behaviour of the suspend/resume callbacks
unintentionally. Sorry, I don't have time to complete this email
(meeting.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

