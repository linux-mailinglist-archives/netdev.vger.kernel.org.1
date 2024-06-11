Return-Path: <netdev+bounces-102575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60D4903C8A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E72F1F23F17
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99517C7C1;
	Tue, 11 Jun 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RNrk4ENy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034B17C7A6;
	Tue, 11 Jun 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110664; cv=none; b=gxnD28mAWB6XZSURuRkHAWN2ZCWwTtHxYw0OtsYGYxutNhJwwylqeLQUIMmZxHrz2c/jVxM5gDc0h3ivqMn/OFDuqzcmCYv9BRaFkO8Iw07DRYOmV4CyeGfO36vLwiqWqP9x4/PplfiZ0sWzqhm0M72CVylUzJMCWL182fk4lGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110664; c=relaxed/simple;
	bh=2CHV3JqDCTzemfzBFGBrj/c0ALmTXYa8bakw+BsFzDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJd5YOVrqQP0YteYYLvU4lXASXs6QKUu9X8LT6qYSIFlAnmkymNsts9A2HQc57XgBwJ08RIC0M1iF/TIFrGXNQn6Caa8Nkzq3Kk9nXqEUB2/7B3CG1SuSy46Txjt38L26f/kHlRkBQgcwSQM8TYGzKQighWCq+nSU2Ke7mS+QIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RNrk4ENy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=43M/sVt50RU4a9KtHKnWJdS5bCQ8XkR5rl3Sgok+z+Y=; b=RNrk4ENyXK9TwbH6pjcRUATroF
	oIKSsEXmnKu0n1NjLvnG0dgEgtThhhGXxKut1BQNZNWfsMuLhUYm51woR2aF/iAeOaliuZtvlI0X+
	ZDFx+88r3tzTtrMC70b6yTmkrHusdpj25JnW8sBShX1JwvrAghXoODdm2g2iVNjAsEJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH13t-00HO4O-T0; Tue, 11 Jun 2024 14:57:17 +0200
Date: Tue, 11 Jun 2024 14:57:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v4 3/4] net: macb: Add ARP support to WOL
Message-ID: <a95e3b77-bdda-428e-9d25-f9be017fd40a@lunn.ch>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
 <20240610053936.622237-4-vineeth.karumanchi@amd.com>
 <b46427d8-2b8c-4b26-b53a-6dcc3d0ea27f@lunn.ch>
 <6c01bed7-580e-4f1a-9986-39c20f063e67@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c01bed7-580e-4f1a-9986-39c20f063e67@amd.com>

> > > +	/* Don't manage WoL on MAC if there's a failure in talking to the PHY */
> > > +	if (!!ret && ret != -EOPNOTSUPP)
> > >   		return ret;
> > 
> > The comment is wrong. You could be happily talking to the PHY, it just
> > does not support what you asked it to do.
> > 
> 
> 
> These are the 3 possible return scenarios
> 
> 1. -EOPNOTSUPP. : When there is no PHY or no set_wol() in PHY driver.
> 2. 0 : Success
> 3. any error (-EINVAL, ... ) from set_wol()
> 
> we are returning in case 3.
> 
> The comment can be "Don't manage WoL on MAC, if PHY set_wol() fails"

O.K.

You don't need the !! on ret.

	Andrew

