Return-Path: <netdev+bounces-119751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F8956D36
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A684E1C22AF8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B581714D1;
	Mon, 19 Aug 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ST0oRLSH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5717109B;
	Mon, 19 Aug 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077745; cv=none; b=ZfZPRyhpkf+CXlpatodGZhhaETI6gGKFLk7NO2JqI66kALxhVGSfbkQzks5Eu88scKX7IPENkL7XBTEfghVEp6Hr+mFrixLdI7yhESs/kiSZUqwU2sRN4Sv3/r911SjZFm7yrf8BHYuffaABGd3rC7XuD/9Gm/zgzW+4TiOarhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077745; c=relaxed/simple;
	bh=MdlQwQfefZ1L3XXxLQMT4cSITw5lmaaVPHUx7XMCkvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYzcBGOzgWcA/yWyS4s6cIZuXja33kyVF/t8hGphNKS8MJrdP7qiNgZumoKdy5oh9Hxwj5GQmFaAGWoBamc+PyJNRXJ891FrwfPJVGYWurUVHx6tCx5GhHoU/QayqxzCenDWo5b7bpSFTPUUq0QepOQlrk39+ZzmiQvqxxwlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ST0oRLSH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dzw80pACf9PyVIUJFbVzVkCMS0xplokp1d1HIwEGeIg=; b=ST0oRLSHEfDPMth9UZeInVBB1l
	fuUb2vGYqGChci6u302h5RAq3buvcQ/mAYDf5FhycVHPtPpOkTBEgyaSCFebjLiGOJhwJQY2u2LzY
	VaNkuwDgqY71H0o1l9qwTdDMs2XRp98lNwHRcc5U0r2EyY41sL9tNVFlQ4mrifXwx/Is=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg3NM-0057W1-Si; Mon, 19 Aug 2024 16:28:52 +0200
Date: Mon, 19 Aug 2024 16:28:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pieter <vtpieter@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <a45ef0cf-068e-4535-8857-fbea25603f32@lunn.ch>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf>
 <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>

On Mon, Aug 19, 2024 at 04:20:31PM +0200, Pieter wrote:
> Hi Vladimir,
> 
> > On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
> > > Right so I'm managing it but I don't care from which port the packets
> > > originate, so I could disable the tagging in my case.
> > >
> > > My problem is that with tagging enabled, I cannot use the DSA conduit
> > > interface as a regular one to open sockets etc.
> >
> > Open the socket on the bridge interface then?
> 
> Assuming this works, how to tell all user space programs to use br0 instead
> of eth0?

How did you tell userspace to use eth0?

In general, you don't tell userspace anything about interfaces. You
open a client socket to a destination IP address, and the kernel
routing tables are used to determine the egress interface. In general,
it will use a public scope IP address from that interface as the
source address.

The conduit interface should not have an IP address, its just
plumbing, but not otherwise used. Your IP address is on br0, so by
default the kernel will use the IP address from it.

	Andrew


