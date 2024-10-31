Return-Path: <netdev+bounces-140812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB19B8548
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB891C2141D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B148191F75;
	Thu, 31 Oct 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XmA9oC92"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5E16A92E;
	Thu, 31 Oct 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410125; cv=none; b=SEVZunkYiDzXxEPGqW9FmighPN62nIJx+aIcNlZRWQ9UZBrJKkYEa1YGcEjQsjQ9MdtR1koYOTrLaZpOIfRjbrd9X7uSBAH/oG1eZW+WYgiQjeyabHoce50FWKW89MsvZkxmJHJvINeNpLVE3j3X5f/eFVXRT4Uwj35jg2MZuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410125; c=relaxed/simple;
	bh=SGR83djc/v2VkXvkg2+OaTGIuGeErWCQ2UGUDAVfgmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwhPATI0kSc6KYOekVAkh4NXr612neXa7FGkGx/P8InsZt/X/fHWMH0/BZFG/QOAIoW2T7SCl/1MO48e9Vf+jxypaan717zj154AiMKcCLklQ2X2P2+G9Sy1oWvEcfSDEDDwgKUN6mK/H/aN8ZjIW3ejkxWAuZIs1rj7Wrg651U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XmA9oC92; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OKM06f42KHs8vmOBjtTC1kovaCxYd14xIsb8xvHlv5k=; b=XmA9oC92+zr/QTiXUtC2sY5wkH
	Iwr4q+kvTqI+Pcch/D99gITHL8n+XkTrXRb+g8c2yxSGuTYONOXJ3UGZU7HiPE0egm/Xcof5WImv7
	20+7MKV5yYGts8Hj5j2e92vw3atdDorpO5bbtxSoeWC0yvGxYCITVza7y4EnzCPGATwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6ciT-00BowT-Tq; Thu, 31 Oct 2024 22:28:29 +0100
Date: Thu, 31 Oct 2024 22:28:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 05/18] net: pse-pd: Add support for PSE
 device index
Message-ID: <46d4b5be-60d3-4949-8eb9-9e8a036cb580@lunn.ch>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-5-9559622ee47a@bootlin.com>
 <ZyMjbzK7SJq5nmYz@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyMjbzK7SJq5nmYz@pengutronix.de>

On Thu, Oct 31, 2024 at 07:27:59AM +0100, Oleksij Rempel wrote:
> On Wed, Oct 30, 2024 at 05:53:07PM +0100, Kory Maincent wrote:
> 
> ...
> >  /**
> >   * struct pse_control - a PSE control
> > @@ -440,18 +441,22 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
> >  
> >  	mutex_init(&pcdev->lock);
> >  	INIT_LIST_HEAD(&pcdev->pse_control_head);
> > +	ret = ida_alloc_max(&pse_ida, INT_MAX, GFP_KERNEL);
> 
> s/INT_MAX/U32_MAX

 * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
 * or %-ENOSPC if there are no free IDs.

static inline int ida_alloc_max(struct ida *ida, unsigned int max, gfp_t gfp)

We need to be careful here, at least theoretically. Assuming a 32 bit
system, and you pass it U32_MAX, how does it return values in the
range S32_MAX..U32_MAX when it also needs to be able to return
negative numbers as errors?

I think the correct value to pass is S32_MAX, because it will always
fit in a u32, and there is space left for negative values for errors.

But this is probably theoretical, no real system should have that many
controllers.

	Andrew

