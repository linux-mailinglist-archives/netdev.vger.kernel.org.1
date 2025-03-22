Return-Path: <netdev+bounces-176926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0C8A6CB3D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D3B188C0FF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEB22A81F;
	Sat, 22 Mar 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KuxLY5IH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA341DAC95;
	Sat, 22 Mar 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658192; cv=none; b=BhOzV04YLoUdo86IyN4NHWSMIe9ZkSdsuLpG+OKh2yztqRnUtYlWy3D+d04viLbXFfDgFxPyyIQDxSrD3s+Yo4NXMxWqQ1nenH1oG3Poh2e4U1DLcoC7yGahWMcH+PRhWMlPN6v9ufBPLsjYBILuTtkQ5nPFMexzdxMYIvEhgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658192; c=relaxed/simple;
	bh=CWWe4PstEF4d9tne4DiFX6uP4PFTSFPxDhi2YS6OAUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCnLOISdvIzmGvyYmCzHqsR0i6+QedLcXmbsakMUU83HvWspUoSjS8tMEBLqL0AKsK1YaG78pohdneBF6V/vMxkoldAIY/b1GMcTmStGBMQCQH4N+0Ku58e9eMcKSZL8mSGodx7b2XxornuriOyCL0IEm6N8qz9UKXA4Ih5RooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KuxLY5IH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N0HV37I62AuU/oXEFaKF0jaHXmJrWxfQnCxCHmR/Kuk=; b=KuxLY5IHQmDc6wRqAcP1v9Qo4F
	h0DnzaNAlR9s53B3tKz19V0AOKFis8h+VkomO91CRj5qJZILgKteRpibtf9u1HVmkpVcvkPUaGTGO
	SB5UNQwst4KzKVR++5SEU4eVTjwm25TQe6rdEwRRfNiLf6N5kTKfdGF1lWbwkRiM3pCo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw104-006jac-DL; Sat, 22 Mar 2025 16:43:04 +0100
Date: Sat, 22 Mar 2025 16:43:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v4 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
Message-ID: <78b99da9-1e0e-4024-a4cb-b649caf0a5d2@lunn.ch>
References: <20250322075745.120831-1-maxime.chevallier@bootlin.com>
 <20250322075745.120831-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322075745.120831-3-maxime.chevallier@bootlin.com>

On Sat, Mar 22, 2025 at 08:57:45AM +0100, Maxime Chevallier wrote:
> PHYs that are within copper SFP modules have their MDIO bus accessible
> through address 0x56 (usually) on the i2c bus. The MDIO-I2C bridge is
> desgned for 16 bits accesses, but we can also perform 8bits accesses by
> reading/writing the high and low bytes sequentially.
> 
> This commit adds support for this type of accesses, thus supporting
> smbus controllers such as the one in the VSC8552.
> 
> This was only tested on Copper SFP modules that embed a Marvell 88e1111
> PHY.
> 
> Tested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

