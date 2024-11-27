Return-Path: <netdev+bounces-147616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA89DAAE4
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA9E281C08
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454C1FF7C4;
	Wed, 27 Nov 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hWC9ckQ2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2206328B6;
	Wed, 27 Nov 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721890; cv=none; b=DP00qBj3E3QuadVa7qWaVR3bzJlJreLYUur73kKJjLHDDI2P5QnHAVrCBonTcwCgtlTglb5DO8qz9dOQE017QjW5Gl0rnfQoS975i3qly06pSUsq4nBPhPKx0eTqA+LNa/RfsCgMCrW3K1vYrFE9DhrKkWiL9JdutHjzK1CZvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721890; c=relaxed/simple;
	bh=Qsh7lyv6B7rh6QnAyT1L/qq/xUEJEtQwxby5Odi2Skw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvKYpgwNnaeuOnmic37fQM9xiPkkXG4wJhzjg9smBlPlTvwmw46wFS3l1nb2SwcA1PrK91i6krzyd1csQrG45L1gGIO+nesZ4D5Clf5RGtpf9Fy4eWNFtULteaDKPwI+NHn4wRYlrsumxHiveMYLLvg/08kOdj750fRSU7QzhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hWC9ckQ2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1zGoFEOXxGRwMEfyJ/IQx4PP6NpvQSzerDrWNbMAxxA=; b=hWC9ckQ23kE6G6lxaDgBUYp6Z2
	Hyd7ItU9S2dETCiSSMjK87+1wHLos//nWJi/L5fmJZZCd32vRwaQUixz/5+YBuPj6Nmne6HsZwDS3
	ne0SFB/wjaGQI7aVkort8P1Nm7p6aE+H9xwCz8zqTX5sEa0Ojt4BAU7L+gXYB2i2xU+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGK6v-00Ed4c-W1; Wed, 27 Nov 2024 16:37:49 +0100
Date: Wed, 27 Nov 2024 16:37:49 +0100
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
Message-ID: <43cceaf2-6540-4a45-95fa-4382ab2953ef@lunn.ch>
References: <20241127131011.92800-1-o.rempel@pengutronix.de>
 <20241127131011.92800-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127131011.92800-2-o.rempel@pengutronix.de>

On Wed, Nov 27, 2024 at 02:10:11PM +0100, Oleksij Rempel wrote:
> Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
> report a stable link state. To handle this, the PHY must be periodically reset
> when the link is down. However, synchronized reset intervals between the PHY
> and its link partner can result in a deadlock, preventing the link from
> re-establishing.
> 
> This change introduces a randomized polling interval when the link is down to
> desynchronize resets between link partners.

Hi Oleksij

What other solutions did you try? I'm wondering if this is more
complex than it needs to be. Could you add a random delay in
dp83tg720_read_status() when it decides to do a reset?

	Andrew

