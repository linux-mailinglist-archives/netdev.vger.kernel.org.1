Return-Path: <netdev+bounces-68510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B08470E1
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143261C245FD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17271755A;
	Fri,  2 Feb 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q1e9qHZ1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8D4C6A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879580; cv=none; b=E8TLh+FCXNj7EUpa0yIaxUC0UGw+BxgFn5fVfUZ95SxYl/oZAOzoGSoDKVSZb7/TVfocpcdyEgCc+vkBmD/1ClBKfOA/sKPfIlMA6kyWpCtWDGymx9t+4ITYVX31chETqphj3jr4aNjDcNAoTU/9UvhK/ZlEMvxlLAnZIX8akTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879580; c=relaxed/simple;
	bh=io0NICBVfwnZnXbztPakR2EeUsIODAVoIUHlXCkSjCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moY7mFpMZTlTZez8iKR5I7b+2it2neODjSdw7VVXb8XLtQ8+Je/Zp6yPZfI0+rJFPPdZJLNR+pXnAaI4TScHmMkZ5ZuGOKxd1dHdOlHCJT67NBWTg/MPfEdJZOGGB3mEXDvH89+M5QYPU1gz2H3rSk97im4EfJhKKVQXgO0BIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q1e9qHZ1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s3zsPgcNqiCwE5EkeatYq7+XQt9oayC0AQ4nOZKOK00=; b=Q1e9qHZ1KpjjOn9Pjqa+r0Uc7H
	NNmKHk2cZgswflZDRbGazZl70B2kCAqU16W/rtyqTELhAIOBIgb9wj7IGjaHzuPDwlx4C6/d0Yx99
	BwNgxJF7MuojqNpWumtgZNx09pXRAxm+lX5VU52mflbGsIgap1Fm1vo6NoHGNr1xS5iE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtLR-006mey-Fg; Fri, 02 Feb 2024 14:12:37 +0100
Date: Fri, 2 Feb 2024 14:12:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
Message-ID: <219c3309-e676-48e0-9a24-e03332b7b7b4@lunn.ch>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
 <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
 <be436811-af21-4c8e-9298-69706e6895df@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be436811-af21-4c8e-9298-69706e6895df@gmail.com>

On Fri, Feb 02, 2024 at 07:55:38AM +0100, Heiner Kallweit wrote:
> On 02.02.2024 01:16, Andrew Lunn wrote:
> >> @@ -5058,7 +5033,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
> >>  	}
> >>  
> >>  	tp->phydev->mac_managed_pm = true;
> >> -
> >> +	if (rtl_supports_eee(tp))
> >> +		linkmode_copy(tp->phydev->advertising_eee,
> >> +			      tp->phydev->supported_eee);
> > 
> > This looks odd. Does it mean something is missing on phylib?
> > 
> Reason is that we treat "normal" advertising and EEE advertising differently
> in phylib. See this code snippet from phy_probe().
> 
>         phy_advertise_supported(phydev);
>         /* Get PHY default EEE advertising modes and handle them as potentially
>          * safe initial configuration.
>          */
>         err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
> 
> For EEE we don't change the initial advertising to what's supported,
> but preserve the EEE advertising at the time of phy probing.
> So if I want to mimic the behavior of phy_advertise_supported() for EEE,
> I have to populate advertising_eee in the driver.

So the device you are using is advertising less than what it supports?

> Alternative would be to change phy_advertise_supported(), but this may
> impact systems with PHY's with EEE flaws.

If i remember correctly, there was some worry enabling EEE by default
could upset some low latency use cases, PTP accuracy etc. So lets
leave it as it is. Maybe a helper would be useful
phy_advertise_eee_all() with a comment about why it could be used.

	Andrew

