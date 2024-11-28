Return-Path: <netdev+bounces-147759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC59DB99D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FB1281DE0
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024861AF0A0;
	Thu, 28 Nov 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fJySpkI3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D281B21A8;
	Thu, 28 Nov 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804171; cv=none; b=b11vzASf/FyhaZldVHhIpeBYip8l+S0UQkipqXMlj4g2ATBLOGlIbHwWiwG25245UPVjmvlmfZw9IceMQlG8DXTbnkvTgmWpgiEn8642Moxd8Nt+jrc9FoTk23XFv/+UPsSWmzUiQa7CQF+UOSeXxaktyZ5A8sOxN9UqaQup/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804171; c=relaxed/simple;
	bh=ZMvMg8+Oa0TyJtTQnHUSVZzinBVvJE2xUaPMaeF+6c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgbRGWJnOvxms5rk3R+iuy0Z8Fg7oZfB+XnrSMV2wccsseY5kjMdsPZx3FfO2pDybOOJYe9ie9vxyMv2wi3PbhjKMqnXPOobLCaI7HZWnKvJum/LbH1XOnjdN8NczbbslbU1FB7bg9LAttgt7i6/wQDXiB7oV+vaLmwnMKPnRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fJySpkI3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q4Mp5RBOVSRX1FefyVEktnbia0u/FdO2PSScCAZRv9k=; b=fJySpkI3EGU7DeYIAn6vdllo6/
	QBBwtoSs8fgdWb97RQYwTuJazBl51jrLSUqqJlm6K5VIMQsVXd5jUEGIKusXzAWGFzZgtWk6SI2a1
	GwvgpTSsAz4Ie97jqknWxAWeSU5Ts8SP4NJOjBh9MT4O5TwQ3G9b2a3/fJ1cPcrKdtnU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGfWC-00EiHp-UJ; Thu, 28 Nov 2024 15:29:20 +0100
Date: Thu, 28 Nov 2024 15:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC net-next v1 2/2] net. phy: dp83tg720: Add randomized
 polling intervals for unstable link detection
Message-ID: <1f2c1169-076d-460f-9635-d6ca6c4d310d@lunn.ch>
References: <20241127131011.92800-1-o.rempel@pengutronix.de>
 <20241127131011.92800-2-o.rempel@pengutronix.de>
 <43cceaf2-6540-4a45-95fa-4382ab2953ef@lunn.ch>
 <Z0gksn9nEKJOY5Ul@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0gksn9nEKJOY5Ul@pengutronix.de>

On Thu, Nov 28, 2024 at 09:07:14AM +0100, Oleksij Rempel wrote:
> Hi Andrew,
> 
> On Wed, Nov 27, 2024 at 04:37:49PM +0100, Andrew Lunn wrote:
> > On Wed, Nov 27, 2024 at 02:10:11PM +0100, Oleksij Rempel wrote:
> > > Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
> > > report a stable link state. To handle this, the PHY must be periodically reset
> > > when the link is down. However, synchronized reset intervals between the PHY
> > > and its link partner can result in a deadlock, preventing the link from
> > > re-establishing.
> > > 
> > > This change introduces a randomized polling interval when the link is down to
> > > desynchronize resets between link partners.
> > 
> > Hi Oleksij
> > 
> > What other solutions did you try? I'm wondering if this is more
> > complex than it needs to be. Could you add a random delay in
> > dp83tg720_read_status() when it decides to do a reset?
> 
> Yes, this would be possible, but there are multiple reasons I decided to
> go this way:
> - in link down case, it is better to increase polling frequency, it
>   allows to reduce link up time.
> - there are PHYs, for example an integrated to LAN9372 which supports
>   only link down interrupt. As long as link is down, it should be
>   polled.
> - i'm working on generic PHY stats support and PHYs need to be polled,
>   even with IRQ support, just less frequently.
> 
> I can add it to the commit message.

Yes, more justification would be good.

In general, we try to hide workarounds for broken devices in the
driver, not expose it to all drivers. Variable rate polling, and
polling even when interrupt are enabled does however sound
useful. Cable testing might also be able to use it.

	Andrew

