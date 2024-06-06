Return-Path: <netdev+bounces-101491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5F8FF140
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839DCB28B4B
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63408197522;
	Thu,  6 Jun 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fhC17j66"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58D197538;
	Thu,  6 Jun 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688494; cv=none; b=mm8eIyiESWNHOgfFwYS5vLv/G7AWL8k3xXF9umpXZ3Q0nco17LME8HCDx0SpohvFfMnTv3WeAvn4dERUscicC6/asCKKqF34m31Fbm9nLCBoerJ8DHAVwKgwDSDNEXbJhy+WK254KMK/SV1iso4C/XDneU0SlJxUTsoFuGvTn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688494; c=relaxed/simple;
	bh=U9/fTFa6AFZKFaYVobFDAx2u0wkfJM36d6EMcVyO/Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEHhwziEoOJxT+/QDwrTFyhEFwnwwpTJI+NIU0cUOYVw3Mtdi7gftE/kgeAbQDhFJskooTqL1qHJv7l0WSKwmrIg6GSOGmyYHDkqpTkJPIjB0G7AJIrrMsQuXIfPZFB36c9uvwTkzdLHh0idlU5rWsSou6VmkEGfhFnMSuCE78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fhC17j66; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HtCXOhY+1iqYPYRg3w33pyQ6Llz91ckac8NBDvTBJTs=; b=fhC17j66D6okl9Nhe1UBE3BnQZ
	7bLWt+spJnQsF5zMdnj9XdW9NlWojYvCHJDZK5NIn5xqQwQ5FjtmHoaYpTb7XJRVqU9pxjSlPnrOI
	3aKO6dik/sUTbC5Mlq4MkQshpvCpIvgN++RXAaZr78AVYEGepPQxlFRqv/RhGK9PiZ8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFFEu-00H22T-Eg; Thu, 06 Jun 2024 17:41:20 +0200
Date: Thu, 6 Jun 2024 17:41:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: jackie.jone@alliedtelesis.co.nz, davem@davemloft.net,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH] igb: Add MII write support
Message-ID: <1dbb8291-9004-4ec2-a01b-9dd5b2a8be39@lunn.ch>
References: <20240604031020.2313175-1-jackie.jone@alliedtelesis.co.nz>
 <ad56235d-d267-4477-9c35-210309286ff4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad56235d-d267-4477-9c35-210309286ff4@intel.com>

On Wed, Jun 05, 2024 at 01:51:24PM -0700, Jacob Keller wrote:
> 
> 
> On 6/3/2024 8:10 PM, jackie.jone@alliedtelesis.co.nz wrote:
> > From: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
> > 
> > To facilitate running PHY parametric tests, add support for the SIOCSMIIREG
> > ioctl. This allows a userspace application to write to the PHY registers
> > to enable the test modes.
> > 
> > Signed-off-by: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 03a4da6a1447..7fbfcf01fbf9 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -8977,6 +8977,10 @@ static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> >  			return -EIO;
> >  		break;
> >  	case SIOCSMIIREG:
> > +		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
> > +				     data->val_in))
> > +			return -EIO;
> > +		break;
> 
> A handful of drivers seem to expose this. What are the consequences of
> exposing this ioctl? What can user space do with it?

User space can break the PHY configuration, cause the link to fail,
all behind the MAC drivers back. The generic version of this call
tries to see what registers are being written, and update state:

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy.c#L325

But you can still break it.

> It looks like a few drivers also check something like CAP_NET_ADMIN to
> avoid allowing write access to all users. Is that enforced somewhere else?

Only root is allowed to use it. So it is a classic 'You have the
option to shoot yourself in the foot'.

For the use case being talked about here, there has been a few emails
one the list about implementing the IEEE 802.3 test modes. But nobody
has actually got around to doing it. Not that it would help in this
case, Intel don't use the Linux PHY drivers, which is where i would
expect to see such code implemented first. Maybe if the "Great Intel
Ethernet driver refactoring" makes progress, it could swap to using
the Linux PHY drivers.

      Andrew

