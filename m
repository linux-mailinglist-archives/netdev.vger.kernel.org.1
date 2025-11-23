Return-Path: <netdev+bounces-241074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B15C7EA5A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F830344F5C
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CA23ABA9;
	Sun, 23 Nov 2025 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w4Agy9Cg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452E269D06
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763942132; cv=none; b=KLkWaxBg12uYWryOh82sN6WVHSlGpO/usuNMJQ66F92HNsSpnU8YUonqr//chx3OTNynVsgx/ZAxYyMTuDzc/f9Fk9xv5uf5DO5YYTKqIS0Bxrb1PP4nkb8Q6Ph3iAegobchq/q460GtE9rmcpNB1eoxkBWr12a3P+DqvydhgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763942132; c=relaxed/simple;
	bh=2LcXVoBWN4iReZErPeiWqGe4aDrsQsT7tvw+Ui7NRK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVhOfKYM+6zrBm9frB6hEnVHVFvbezJUUF5AMtqrgnF668bS9rNvptkJJJMJG/M/Tv/3jYIH1VkV8CKZdaW8gD8v+Mt1XJDyCgdcTO6c9X3qLHr3o+3fmG04JlPQ2XU51AzLXuCKt8A9IRdFdTnApPIKGcF/27GDOHp5gCcW8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w4Agy9Cg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jGhMNq6y1x1RnH24uYf/KBHEbsahDPhK2hw5Lqdfr4I=; b=w4Agy9CgFOp1uEa/zxdy4ctdbB
	IDWg3FAW2WRCy92UwEvE/R3y/VCmf7jb7J4WECDtPSIqJXBuYwbcEKzyzokp0MFqOxtOaURGYPRYe
	zkaEC8yEVB2kg3j16RFvIa2ltyg3pIBygyIF88fVp1Suh0k5XHvbSWTxKcr3YBRb0J2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNJvU-00Erns-AQ; Mon, 24 Nov 2025 00:55:28 +0100
Date: Mon, 24 Nov 2025 00:55:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] net: dsa: append ethtool counters of all
 hidden ports to conduit
Message-ID: <7ccde53b-7c9f-407a-8f30-34d8932a51f4@lunn.ch>
References: <20251122112311.138784-1-vladimir.oltean@nxp.com>
 <20251122112311.138784-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122112311.138784-4-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 01:23:11PM +0200, Vladimir Oltean wrote:
> Currently there is no way to see packet counters on cascade ports, and
> no clarity on how the API for that would look like.
> 
> Because it's something that is currently needed, just extend the hack
> where ethtool -S on the conduit interface dumps CPU port counters, and
> also use it to dump counters of cascade ports.
> 
> Note that the "pXX_" naming convention changes to "sXX_pYY", to
> distinguish between ports having the same index but belonging to
> different switches. This has a slight chance of causing regressions to
> existing tooling:
> 
> - grepping for "p04_counter_name" still works, but might return more
>   than one string now
> - grepping for "    p04_counter_name" no longer works
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

