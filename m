Return-Path: <netdev+bounces-250543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AFAD3264C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05340309F756
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF41286405;
	Fri, 16 Jan 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dd+Svwtd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2A283FFB;
	Fri, 16 Jan 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572461; cv=none; b=kdv5f35FvLRcKzzeFJDo1VgM+RZrpXqz7jy7496IRnXlRIrHQH1KqilWyvdVB4TbBRh2V1zYvse+yADNTDzTEg0Ao+YxqoTbK2D/lZa9+kXqKzb5lOGbTQYBH3ig+ga4ohaajldgx8kvHiuqzHZpvYt3Hce/3XgSDpVALh2pdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572461; c=relaxed/simple;
	bh=jhdkZR0eopJBZEPWW0TbsmgdBMGprhcE5jSNiwMJREw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctnJSXO1C+8M8o4BtHyUWctqaoEGEtTpvvk3lnIrSmuGuCK386Bxzb0BZaNvNAG4cJybPp24mAWDyALHZrY/qHozDG9u67dPG/811sb4gwIzZ6K+w/x908vSi7lpI4KhHQPF91oF19atmieVlg7zxdHz5RLW4BQ3Q50BtnZ37us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dd+Svwtd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RdrOKlnLCiw7JaxkBGUfg1y26f7MNgQzak3k96a5FDc=; b=Dd+SvwtdGzkSecgdb9I5/Ry0SW
	Ncr0Lm0oay9SAgCRiO097QdLAOM0+CoiwFAVNz7Zq+85r53LfrS2PT/O4iGeFF5/lHZdLOUvvjYJA
	h98YBAGkAH7yMZCS5l5kZUWX3nVp+RLkS0IutQZr4VeUx69dfdvDICbl96hTjtRBF50U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgkU7-00354Z-Nv; Fri, 16 Jan 2026 15:07:31 +0100
Date: Fri, 16 Jan 2026 15:07:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Message-ID: <5e7c71f6-80dd-408b-a346-888e6febf07a@lunn.ch>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
 <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>

On Fri, Jan 16, 2026 at 02:43:47PM +0100, Jonas Jelonek wrote:
> Hi,
> 
> On 16.01.26 14:23, Maxime Chevallier wrote:
> > I think Russell pointed it out, but I was also wondering the same.
> > How do we deal with controllers that cannot do neither block nor
> > single-byte, i.e. that can only do word access ?
> >
> > We can't do transfers that have an odd length. And there are some,
> > see sfp_cotsworks_fixup_check() for example.
> >
> > Maybe these smbus controller don't even exist, but I think we should
> > anyway have some log saying that this doesn't work, either at SFP
> > access time, or at init time.
> 
> I tried to guard that in the sfp_i2c_configure() right now. The whole path
> to allow SMBus transfers is only allowed if there's at least byte access. For
> exactly the reason that we need byte access in case of odd lengths.

Is there a use case for odd lengths? Apart from 1.

> This of course rules out any controllers which just can do word access.

There are some PHYs embedded within SFPs which kill the bus if you do
anything but 1 byte access. There is a quirk for it. We should refuse
to drive the SFP if we have such an SFP and an I2C bus that can only
do words.

	Andrew

