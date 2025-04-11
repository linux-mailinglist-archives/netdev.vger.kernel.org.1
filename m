Return-Path: <netdev+bounces-181461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B3A85116
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F01A7A7622
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B326FA6B;
	Fri, 11 Apr 2025 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2q3YK/HS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDAA94F;
	Fri, 11 Apr 2025 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333937; cv=none; b=NXUwKstEyIRPQwcN0gqMNRi3XH2iFi5CakUqnwKUVPy/MUIoGwWu/8JIMDyBzvqTHfCEIX8Pz+lIYeEKTqbpByrDXyKNiEY52g/2fqk3XxwhVABsw8zAYIDKeIj8JO1QetleRMfzDsYwYo/ntXn7IAD3Om8V10YuEZgHUjEURKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333937; c=relaxed/simple;
	bh=GRyBUhrKRcofK7ITnvUObLLOwxkLUhDidiUBg6IVg2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oywmpELCvcWB4chKUEOCJNXcbZxb1aU6ru172UeREd8eOsrw5wD5oqo3Q6lyoP8DbBZVpEv4/iXWPlCpJFwMyOYLb0iayiTsPpF5q6OnId8HYS4svGw1H9wGo9YL7U5DIPiHybFBRp8/Kg82Tq7ncr0ARiNEIZ7Hsm+gVzLAW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2q3YK/HS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S/RCIdYiJVSUeowwqvrPZG00uB4tMfPhPiUYiVE6DQM=; b=2q3YK/HSW09L/ltBBLaXef5g/A
	8f+re2CQice/OmTOLKa4exyVmH3UC8+PwrE72Ksfue6fPUmXpdfiG6XGKw4oyUfK8sDa1B1E6HXvU
	lm/9E9rsEJNHQNrufBbjgCh4Tdq+cOlyNOU2xDS0Rlml5bZ4CzhZ4p7JyOAl8YnI4D4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u32wA-008kk9-B7; Fri, 11 Apr 2025 03:12:06 +0200
Date: Fri, 11 Apr 2025 03:12:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <c8ebd8a1-cfdd-4a27-8cb6-114ea60ba294@lunn.ch>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-2-qasdev00@gmail.com>
 <20250325063307.15336182@kernel.org>
 <Z_hC-9C7Bc2lPrig@qasdev.system>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_hC-9C7Bc2lPrig@qasdev.system>

On Thu, Apr 10, 2025 at 11:15:23PM +0100, Qasim Ijaz wrote:
> On Tue, Mar 25, 2025 at 06:33:07AM -0700, Jakub Kicinski wrote:
> > On Wed, 19 Mar 2025 11:21:53 +0000 Qasim Ijaz wrote:
> > > --- a/drivers/net/mii.c
> > > +++ b/drivers/net/mii.c
> > > @@ -464,6 +464,8 @@ int mii_nway_restart (struct mii_if_info *mii)
> > >  
> > >  	/* if autoneg is off, it's an error */
> > >  	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > > +	if (bmcr < 0)
> > > +		return bmcr;
> > >  
> > >  	if (bmcr & BMCR_ANENABLE) {
> > >  		bmcr |= BMCR_ANRESTART;
> > 
> > We error check just one mdio_read() but there's a whole bunch of them
> > in this file. What's the expected behavior then? Are all of them buggy?
> >
>  
> Hi Jakub
>     
> Apologies for my delayed response, I had another look at this and I
> think my patch may be off a bit. You are correct that there are multiple
> mdio_read() calls and looking at the mii.c file we can see that calls to
> functions like mdio_read (and a lot of others) dont check return values.
>   
> So in light of this I think a better patch would be to not edit the 
> mii.c file at all and just make ch9200_mdio_read return 0 on     
> error.

Do you actually have one of these devices? If you do have, an even
better change would be to throwaway the mii code and swap to phylib
and an MDIO bus. You can probably follow smsc95xx.c.

	Andrew

