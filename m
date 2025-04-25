Return-Path: <netdev+bounces-185945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC3A9C3F3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01554C0A58
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58023816A;
	Fri, 25 Apr 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ohb2vKZW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23A234963
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573972; cv=none; b=OQWIPgesg8fCZ8+5XvfuncV4mXBmE+yw1zv8ygTdTtGTvUTB7BfOCCeOjioV1Fj9I8xiDGeIz52vn7Qoxs/INZrc+j6dKjNlIMDYnFvMunWeTipT8xMy9NksVtfH+rq5Qq51yWA+CmpQov+yPbhFjYJuwlvfWTN/Rc6UrKvtQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573972; c=relaxed/simple;
	bh=x00ZgavTUTd8JDWTuQ3OYrQ8FYmxZ/6+MWDuRtYc4Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUgv3wv9c9gWKnr19zEfrOYJiXszQudfe3+kfemHhFquEse6GDx/qJGZeoOEfukMi8vFe8ehCMOjedU8CgMe0bWnf1CyMgXaZqgN/F7u5Wm/wYBVbMShWjIsytselEGOiMXZDxOJGh6M9sUdyGQ5Ku2beVOdiCwtSoynnsUxDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ohb2vKZW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cMLaFvXcWXuTBR4NwXGmCaGGLldk3zZ3VujAXnG9fJg=; b=ohb2vKZW8aTeYrgqVQClwJoS3U
	8gzNnA5Kfv5mbW7f5HCeOycPQr2POY/tRp6K2en4wAnDUI8JbSAckOKrpI1bQfZzctP2zPE61a+YF
	CrC5McPe0mADrfQ3ll2pVb9IsuGRSx7ixGw658TTEQBdUSJV4ash5kegRRZm2G1w+r+6khjtrNI9Y
	6qXE9B/od96t/iTDVVYV+MYqvQJKeGLcCzu4OejVyf6rOPe0pPcbPker0q1tWSElyRbrHhIPws7Un
	IW38zhlWpvZeYBbNmj4fd5l00N6Yo7/iNxPc2R7kLCTFepbKZ+1GI1x/Wj1OFO7f+b6xVN7ni1FpF
	+nRV0sdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50656)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8FWo-000076-2s;
	Fri, 25 Apr 2025 10:39:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8FWm-00022D-2Y;
	Fri, 25 Apr 2025 10:39:24 +0100
Date: Fri, 25 Apr 2025 10:39:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: libwx: fix to set pause param
Message-ID: <aAtYTPuCI6Ur-9ye@shell.armlinux.org.uk>
References: <6A2C0EF528DE9E00+20250425070942.4505-1-jiawenwu@trustnetic.com>
 <aAs79UDnd0sAyVAp@shell.armlinux.org.uk>
 <046701dbb5c3$58335190$0899f4b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046701dbb5c3$58335190$0899f4b0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 05:20:53PM +0800, Jiawen Wu wrote:
> On Fri, Apr 25, 2025 3:38 PM, Russell King (Oracle) wrote:
> > On Fri, Apr 25, 2025 at 03:09:42PM +0800, Jiawen Wu wrote:
> > > @@ -266,11 +266,20 @@ int wx_set_pauseparam(struct net_device *netdev,
> > >  		      struct ethtool_pauseparam *pause)
> > >  {
> > >  	struct wx *wx = netdev_priv(netdev);
> > > +	int err;
> > >
> > >  	if (wx->mac.type == wx_mac_aml)
> > >  		return -EOPNOTSUPP;
> > >
> > > -	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
> > > +	err = phylink_ethtool_set_pauseparam(wx->phylink, pause);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (wx->fc.rx_pause != pause->rx_pause ||
> > > +	    wx->fc.tx_pause != pause->tx_pause)
> > > +		return wx_fc_enable(wx, pause->tx_pause, pause->rx_pause);
> > 
> > Why? phylink_ethtool_set_pauseparam() will cause mac_link_down() +
> > mac_link_up() to be called with the new parameters.
> > 
> > One of the points of phylink is to stop drivers implementing stuff
> > buggily - which is exactly what the above is.
> > 
> > ->rx_pause and ->tx_pause do not set the pause enables unconditionally.
> > Please read the documentation in include/uapi/linux/ethtool.h which
> > states how these two flags are interpreted, specifically the last
> > paragraph of the struct's documentation.
> > 
> > I'm guessing your change comes from a misunderstanding how the
> > interface is supposed to work and you believe that phylink isn't
> > implementing it correctly.
> 
> You are right.
> I should set autoneg off first, although there has no autoneg bit in this link mode.

Yes, "autoneg" in the pause API selects between using the result of
autonegotiation if enabled, or using the values from tx/rx in the
pause API.

If autonegotiation (as in the control in SLINKSETTINGS) is disabled
or autonegotiation is unsupported, then "autoneg" set in the pause
parameters results in no pause. The same is incidentally true of EEE
settings as well.

So, "autoneg" in SLINKSETTINGS is like the big switch allowing or
preventing all autonegotiation over the link. The other "autoneg"s
control whether the result of autonegotiation is used.

There is one thing in the ethtool_pauseparam documentation that should
be removed:

 * Drivers should reject a non-zero setting of @autoneg when
 * autoneogotiation is disabled (or not supported) for the link.

Let's think about what that means.

- I have a 100baseT/FD link for example, and it used autoneg, and has
  pause enabled.
- I decide to disable autoneg, instead selecting fixed-link mode
  through SLINKSETTINGS.
- Reading the pause parameter settings returns the original state of
  "autoneg" which is set.
- Writing that back results in "rejection" if the above statement is
  followed - which is non-sensical. Let's say it's forced to zero.
- I later re-enable autoneg via SLINKSETTINGS
- I now have to remember to modify the pause mode parameters to
  re-enable pause autoneg.

Things get worse if instead of the above, disabling SLINKSETTINGS
autoneg results in the pause param autoneg being immediately disabled
without API changes - we then end up with one API making magic changes
to settings in another API, and I don't think that is what anyone
would reasonably expect to happen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

