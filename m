Return-Path: <netdev+bounces-191878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD0CABD8C1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751E27A200D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8639322CBD8;
	Tue, 20 May 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a87PczHp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E521C9F5;
	Tue, 20 May 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746270; cv=none; b=ZOfSK08XKZK4LnRwoDIr8ach8HGwXpm8aMhU5Sardlq+D39Vf+y92Nmf2aS8dzqGqZxopRU2OxMIA+UdMeWOl4COhVLEKZAf3d0C3DSO8TEnXw7sEcH9p6drOWCrR14ORdsjqOxlcX/aL282QZm7tNtwORRkRigO2knedOOkWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746270; c=relaxed/simple;
	bh=carVAhumIBG2XCpl+hWPctcxIzy4Q55YiGWX9bTJQfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWgI1RhulJI9EbDmwhkrHmBEW/47pE3DJCT3qkWamiyIYW9QGgV0vW7MDZYwIfjbAS3xKvNXLpoJrcAdU6bYG4VuaLgQVJl2RYUila5+HEcE2j80t13G+lDHr2gOG4BLFIP6AlbrmvTf661Y2wS5ND2LHwHJA5fN9rQvJDIEKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a87PczHp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gNSBAq32hdbFYRJbB0m60tJ7sQQnB7sJQkTEYNeP4ZA=; b=a8
	7PczHph3oG3H9MgQswqUZHb8PQ88CXvloqzqtPS84IJRHWgkTlJSiFUp3yqQZOnkfWrSYSnN2od4F
	x6qL1aJm0M7RSVr0wCISBT3N9nwnYatEU/nF0oix+UESyoA/25X/gYa9iOivEiYTVAHc/B1/VaeUk
	NmuaptLxDItuRlk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHMdk-00D7jz-DO; Tue, 20 May 2025 15:04:16 +0200
Date: Tue, 20 May 2025 15:04:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <5bc03f50-498e-42c8-9a14-ca15243213bd@lunn.ch>
References: <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
 <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
 <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
 <DA0LEHFCVRDC.2NXIZKLBP7QCJ@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA0LEHFCVRDC.2NXIZKLBP7QCJ@silabs.com>

On Mon, May 19, 2025 at 09:21:52PM -0400, Damien Riégel wrote:
> On Sun May 18, 2025 at 11:23 AM EDT, Andrew Lunn wrote:
> > This also comes back to my point of there being at least four vendors
> > of devices like yours. Linux does not want four or more
> > implementations of this, each 90% the same, just a different way of
> > converting this structure of operations into messages over a transport
> > bus.
> >
> > You have to define the protocol. Mainline needs that so when the next
> > vendor comes along, we can point at your protocol and say that is how
> > it has to be implemented in Mainline. Make your firmware on the SoC
> > understand it.  You have the advantage that you are here first, you
> > get to define that protocol, but you do need to clearly define it.
> 
> I understand that this is the preferred way and I'll push internally for
> going that direction. That being said, Greybus seems to offer the
> capability to have a custom driver for a given PID/VID, if a module
> doesn't implement a Greybus-standardized protocol. Would a custom
> Greybus driver for, just as an example, our Wifi stack be an acceptable
> option?

It is not clear to me why a custom driver would be needed. You need to
implement a Linux WiFi driver. That API is well defined, although you
might only need a subset. What do you need in addition to that?

> > So long as you are doing your memory management correctly, i don't see
> > why you cannot implement double buffering in the transport driver.
> >
> > I also don't see why you cannot extend the Greybus upper API and add a
> > true gb_operation_unidirectional_async() call.
> 
> Just because touching a well established subsystem is scary, but I
> understand that we're allowed to make changes that make sense.

There are developers here to help review such changes. And extending
existing Linux subsystems is how Linux has become the dominant OS. You
are getting it for free, building on the work of others, so it is not
too unreasonable to contribute a little bit back by making it even
better.

> 
> > You also said that lots of small transfers are inefficient, and you
> > wanted to combine small high level messages into one big transport
> > layer message. This is something you frequently see with USB Ethernet
> > dongles. The Ethernet driver puts a number of small Ethernet packets
> > into one USB URB. The USB layer itself has no idea this is going on. I
> > don't see why the same cannot be done here, greybus itself does not
> > need to be aware of the packet consolidation.
> 
> Yeah, so in this design, CPC would really be limited to the transport
> bus (SPI for now), to do packet consolidation and managing RCP available
> buffers. I think at this point, the next step is to come up with a proof
> of concept of Greybus over CPC and see if that works or not.

You need to keep the lower level generic. I would not expect anything
Silabs specific in how you transport Greybus over SPI or SDIO. As part
of gb_operation_unidirectional_async() you need to think about flow
control, you need some generic mechanism to indicate receive buffer
availability in the device, and when to pause a while to let the
device catch up, but there is no reason TI, Microchip, Nordic, etc
should not be able to use the same encapsulation scheme.

	Andrew

