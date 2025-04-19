Return-Path: <netdev+bounces-184294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C7A944FE
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 20:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F36B189CEFF
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A11DE8AB;
	Sat, 19 Apr 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XxsuHSDu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728B13C3F2
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745086293; cv=none; b=prUURCEQT7i3yirmCzxxeP54vKBc56b6+f0/wd4gla971TThO9R+gpuq9Sq+uiMxDNq8cidpk6lYoSR5PLdE52e2A6QMQjVnbzJ+qNEWhO0/lj+oIeGWjJYENj2GHDzFF0f/Q6HbaEp2Zo29/+YY/iksJFUvVScNOCYn+/WW2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745086293; c=relaxed/simple;
	bh=dlNRYfwVe/9NoyKITEUeul4WzsBB8O5w8tbI50YXG0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjWM3NUlt7UdZZZJs0r8d2/r+mnOk/s8yPjIF/bSoXeqz7LmKodGnm4eWbGm8R1PVG+OCzvkdfPawUpYQavSeUwHp+use7CPq6sw13OeAWDR594PK/dZYqF/lwesipEEx6edInhN0ioYGpY1kkDdi3F0hjObkWtmn7BlJ+lk0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XxsuHSDu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqmVIZNz/MlKdXdpiJ94ijA/Vsi2PneqW9zsialsl4c=; b=XxsuHSDuNZ513SNoEvPOgjtJd1
	dGhXwAakYMElPO/wvX18RVWTL4A+jWwBzINa9PXrvODckwMZuF/DvGIxsS7OS/3+XbAOMuK24wn2J
	a5hIc4oSMZ5KlA+sQEcV1uUB0i6oPZRWZi3qthQ+OzyWr4snWsmm8K/5U7yV7UZ2uXeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u6Cet-009zjt-Si; Sat, 19 Apr 2025 20:11:19 +0200
Date: Sat, 19 Apr 2025 20:11:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>

On Wed, Apr 16, 2025 at 08:28:46AM -0700, Alexander Duyck wrote:
> Address two issues found in the phylink code.
> 
> The first issue is the fact that there were unused defines that were
> referencing deprecated macros themselves. Since they aren't used we might
> as well drop them.
> 
> The second issue which is more the main reason for this submission is the
> fact that the BMC was losing link when we would call phylink_resume. This
> is fixed by adding a new boolean value link_balanced which will allow us
> to avoid doing an immediate force of the link up/down and instead defer it
> until after we have checked the actual link state.

I'm wondering if we have jumped straight into the weeds without having
a good overall big picture of what we are trying to achieve. But maybe
it is just me, and this is just for my edification...

As i've said a few times we don't have a good story around networking
and BMCs. Traditionally, all the details have been hidden away in the
NIC firmware, and linux is pretty much unaware it is going on, at
least from the Host side. fbnic is changing that, and we need
Linux/phylink to understand this.

Since this is all pretty new to me, i went and quickly read:

https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.1.0.pdf

Hopefully i now have a better big picture.

Figure 2 answers a few questions for me. One was, do we actually have
a three port switch in here? And i would say no. We have something
similar, but not a switch. There is no back to back MAC on the host
PCI interface. We do have back to back MAC on the NC-SI port, but it
appears Linux has no knowledge of the NIC NC-SI MAC, and the BMC is
controlling BMC NC-SI MAC.

Not having a switch means when we are talking about the MAC, PCS, PHY
etc, we are talking about the media side MAC, PCS, PHY. Given that
phylink is just as often used with switches with a conduit interface
and switch ports, that is an important point.

Figure 2 also hints at there being three different life cycles all
interacting with each other. Our normal model in phylink is that the
Network Controller is passive, it is told what to do by
Linux/phylink. However, in this setup, that is not true. The Network
Controller is active, it has firmware running on it. The Network
Controller and the Management Controller life cycle probably starts at
about the same time, when the PSU starts generating standby power. The
host life cycle starts later, when the BMC decides to power up the
host.

The NC-SI protocol defines messages between the Management Controller
and the Network Controller. One of these messages is how to configure
the media side. See section 8.4.21. It lists different networks speeds
which can be negotiated, duplex, and pause, and if to use
auto-neg. There is not enough details to fully specific link modes
above 1000BaseT, all you can request for example is 40G, but you
cannot say CR4, KR4, SR4, or LR4. There also does not appear to be a
way to ask the network controller what it actually supports. So i
guess you normally just ask for everything up to 100G, and you are
happy when Get Link Status response command says the link it 10BaseT
Half.

The Network Controller needs to be smart enough to get the link up and
running. So it basically has a phylink implementation, with a PCS
driver, 0 or more PHY drivers, SFP cage driver, SFP driver etc.

Some text from the document, which is pretty relevant to the
discussion.

  The Set Link command may be used by the Management Controller to
  configure the external network interface associated with the channel
  by using the provided settings. Upon receiving this command, while
  the host NC driver is not operational, the channel shall attempt to
  set the link to the configuration specified by the parameters. Upon
  successful completion of this command, link settings specified in
  the command should be used by the network controller as long as the
  host NC driver does not overwrite the link settings.

  In the absence of an operational host NC driver, the NC should
  attempt to make the requested link state change even if it requires
  the NC to drop the current link. The channel shall send a response
  packet to the Management Controller within the required response
  time. However, the requested link state changes may take an
  unspecified amount of time to complete.

  The actual link settings are controlled by the host NC driver when
  it is operational. When the host NC driver is operational, link
  settings specified by the MC using the Set Link command may be
  overwritten by the host NC driver. The link settings are not
  restored by the NC if the host NC driver becomes non
  operational.

There is a very clear indication that the host is in control, or the
host is not in control. So one obvious question to me is, should
phylink have ops into the MAC driver to say it is taking over control,
and relinquishing control? The Linux model is that when the interface
is admin down, you can use ethtool to preconfigure things, but they
don't take affect until the link is admin up. So with admin down, we
have a host NC driver, but it is not operational, hence the Network
Controller is in control of the link at the Management Controllers
bequest. It is only with admin up that phylink takes control of the
Network Controller, and it releases it with admin down. Having these
ops would also help with suspend/resume. Suspend does not change the
admin up/down status, but the host clearly needs to hand over control
of the media to the Network Controller, and take it back again on
resume.

Also, if we have these ops, we know that admin down/suspend does not
mean media down. The presence of these ops triggers different state
transitions in the phylink state machine so that it simply hands off
control of the media, but otherwise leaves it alone.

With this in place, i think we can avoid all the unbalanced state?

What is potentially more interesting is when phylink takes control. Do
we have enough information about the system to say its current
configuration is the wanted configuration? Or are we forced to do a
ground up reconfiguration, which will include a media down/up? I had a
quick scan of the document and i did not find anything which says the
host is not allowed/is allowed to do disruptive things, but the text
quoted above says 'The actual link settings are controlled by the host
NC driver when it is operational'. Controlling the link settings is a
disruptive operation, so the management controller needs to be
tolerant to such changes.

So, can we ignore the weeds for the moment, and think about the big
picture?

	Andrew

