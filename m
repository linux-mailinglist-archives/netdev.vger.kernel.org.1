Return-Path: <netdev+bounces-186092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083F0A9D142
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115299A01FC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6C21A45D;
	Fri, 25 Apr 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KfK9K7JM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15321ABB7
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608275; cv=none; b=D4n/Xw//2G/1FaqZK5napBQgJvR4l5gETM7k6Iq3nthUJW4zt6nzDhTyvRGHgXKSOQxewFkiAX5tAYbWBKAn4JvA+zQ1ERauFRHGUAVvsX5F3hG+Gc1F2iSrnYoQ3hl2InL8/jKmNMZQUUxeKeMPfAPE+NzPn5LvRId5EvNigQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608275; c=relaxed/simple;
	bh=rJMvct+0w6CVFJKBGB8+JboKce5qTJstImOSST0DXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2ZoDvKrv3rqrpaHLhoMrXaQ4e7qDJO36bZ6wi0Rrpw/g4T9psDztwfPVrn1F3bQf3o2f/lVj0T2zfIMSGAyI5f+QiIFHLD/yfK4gyakATNS+zwjWBt82C2yeRum+0Gf2rFIPAKicfyur0zp9BHrXgzP8RB3sJ2eKuOJLyrUs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KfK9K7JM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DOaS+F0uPeh+NRWjoWZTc5HAu5bwMeqsUI3jIjNg8N4=; b=Kf
	K9K7JMYw2/gx9dZBZU1PNxDiRRe4SXvH3WgAzsuWmrqLfkCOU4Tn4IkACBp1jE+Tw8lCZDu15D5fE
	lrEJtj8igX8XQLhuF7Pc4yJMtY2tiBci8W6PnGBbbyapwNdJmUeE4ViOAK1f4vPIj1vD48/1bVnB0
	JnmTD4XOHi/sHaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u8ORx-00Ac6M-JK; Fri, 25 Apr 2025 21:11:01 +0200
Date: Fri, 25 Apr 2025 21:11:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>
Subject: Re: [PATCH net] net: dsa: qca8k: forbid management frames access to
 internal PHYs if another device is on the MDIO bus
Message-ID: <116381bd-9a71-4924-83e5-7839bdb7147c@lunn.ch>
References: <20250425151309.30493-1-kabel@kernel.org>
 <e4603452-efe9-4a56-b33d-4872a19a05b5@lunn.ch>
 <eetsgqoq2ztgeo34kvfi732qkpegujwiy5uavpc4jognzy4mrl@owxpxsrvlwhv>
 <fd5dcd78-8eb7-4b60-853b-4f3d318d2e6a@lunn.ch>
 <6zkm5l7wscrba2kkbpp5lhr5qeohj4vvd4rbnwrcvzyx6j7ydh@lw5rb22jheme>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6zkm5l7wscrba2kkbpp5lhr5qeohj4vvd4rbnwrcvzyx6j7ydh@lw5rb22jheme>

On Fri, Apr 25, 2025 at 07:25:04PM +0200, Marek Behún wrote:
> On Fri, Apr 25, 2025 at 06:53:21PM +0200, Andrew Lunn wrote:
> > > >From the ASCII art in commit 526c8ee04bdbd4d8 you can clearly see that
> > > I just assumed there is just one MDIO bus, because I saw activity on
> > > an oscilloscope. I didn't test it the way you now suggested. I also
> > > didn't think of the consequences for the driver design and
> > > device-trees. If we prove that there is just one MDIO bus with two
> > > masters instead of two separate buses that leak some noise in some
> > > situations, the situation will become more complicated...
> > 
> > It is not really that more complex. Some of the mv88e6xxx devices have
> > a similar architecture.
> > 
> > You need to throw away MDIO over Ethernet and stop using the switches
> > master. Because it is async, it cannot be used. The switch MDIO bus
> > driver then just issues bus transactions on the host MDIO bus, using
> > mdiobus_read_nested().
> 
> But this is just in case when there is a separate device on the external
> bus besides the switch, right?
> 
> The access over ethernet frames needs to stay because it speeds up
> DSA operations. The problem is only on Turris 1.x because it breaks
> WAN PHY.

You can keep access to other registers, and statistics etc via
Ethernet frames, but MDIO other Ethernet is going to be an issue.

I suppose you could take the Linux MDIO bus lock, transmit the MDIO
over Ethernet command to the switch, wait for the reply, and then
unlock the MDIO bus. That will prevent Linux accessing the PHY or
switch while there is an outstanding MDIO over Ethernet requests. But
it seems simpler to just do all MDIO over the host MDIO bus. So long
as you are not bit banging, it won't be much slower.

	Andrew

