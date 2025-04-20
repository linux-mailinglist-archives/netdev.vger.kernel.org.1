Return-Path: <netdev+bounces-184310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860DFA949BF
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 23:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F0B18910E1
	for <lists+netdev@lfdr.de>; Sun, 20 Apr 2025 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AB1D63F7;
	Sun, 20 Apr 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ufEZMnby"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB803158218
	for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745186345; cv=none; b=j/kAjXR4as6gvyxyulLriNaFPG4ETmqQ2q6UarW85d8Vpuo6v2f2IhucgySv2GEga2hH7kpQw3S1XNOqBdLFoO6b1c0EFvWGuU2dYLiFUaOC6OMomF2fJhXtytWA6OV3DC2tXNRJI37TaWpfGrh6RQtkw4lbkc9s7daSoHR5u7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745186345; c=relaxed/simple;
	bh=STjfPkDqNaygk7BVMlzsw1QXRsvZCYOSlxFQK4AhMWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9mHpQ3TTwOkG/AK/zKPQMph75kjH4ZiT/oz+oR5s+oB91HDAGQGjhjo6f+qsZfGnRonc8CKttM3CT/VTBBkNgW4B7VhLg+1BfEK7luI/9ED4PZKeQGykJkicH7NteC8U9FEni5N+tCc89e90a08XyfwQKEP24hTCbK6jaHYQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ufEZMnby; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZUVDxuZBTKY3+MXAknMv+nDMj74cBb2pRVBBUreMfeA=; b=ufEZMnby9oTgTcYXBzEE8h5IhN
	4aN6Nt/JIHNPU59MYaeHCarxuH5GcXNHac5dIy/RqmHagiJIqOP+TheA3Z6nVlxlXasbNyK84Eqmp
	8Jd4D7OFgrc2rFLb4r6iJ1DhRwmJoPw6u4tYbjo9Ybkm9N5JD8AG4X7gVryANvkOknDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u6cge-00A3BN-Gs; Sun, 20 Apr 2025 23:58:52 +0200
Date: Sun, 20 Apr 2025 23:58:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch>
 <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>

> >   The actual link settings are controlled by the host NC driver when
> >   it is operational. When the host NC driver is operational, link
> >   settings specified by the MC using the Set Link command may be
> >   overwritten by the host NC driver. The link settings are not
> >   restored by the NC if the host NC driver becomes non
> >   operational.
> >
> > There is a very clear indication that the host is in control, or the
> > host is not in control. So one obvious question to me is, should
> > phylink have ops into the MAC driver to say it is taking over control,
> > and relinquishing control? The Linux model is that when the interface
> > is admin down, you can use ethtool to preconfigure things, but they
> > don't take affect until the link is admin up. So with admin down, we
> > have a host NC driver, but it is not operational, hence the Network
> > Controller is in control of the link at the Management Controllers
> > bequest. It is only with admin up that phylink takes control of the
> > Network Controller, and it releases it with admin down. Having these
> > ops would also help with suspend/resume. Suspend does not change the
> > admin up/down status, but the host clearly needs to hand over control
> > of the media to the Network Controller, and take it back again on
> > resume.
> 
> Yes, this more-or-less describes the current setup in fbnic. The only
> piece that is probably missing would be the heartbeat we maintain so
> that the NIC doesn't revoke access due to the OS/driver potentially
> being hung.

That probably goes against the last sentence i quoted above. I do
however understand why you would want it. Can the host driver know if
the Network Controller has taken back control? Or does the heartbeat
also act as a watchdog, the host does not need to care, it is about to
experience a BMC induced reboot?

> The other thing involved in this that you didn't mention
> is that the MC is also managing the Rx filter configuration. So when
> we take ownership it is both the Rx Filters and MAC/PCS/PHY that we
> are taking ownership of.

That does not seem consistent with the standard. The Set Link command
i quoted above makes it clear that when the host driver is active, it
is in control of the media. However the Set VLAN Filter command,
Enable VLAN command, Set MAC Address command, Enable Broadcast Filter
command, say nothing about differences when the Host driver is
operational or not. It just seems to assume the Management Controller
and the host share the resources, and try not to stomp over each
other. Does fbnic not follow the standard in this respect? However,
from a phylink perspective, i don't think this matters, phylink is not
involved with any of this.

> The current pattern in fbnic is for us to do most of this on the tail
> end of __fbnic_open and unwind it near the start of fbnic_stop.
> Essentially the pattern is xmit_ownership, init heartbeat, init PTP,
> start phylink, configure Rx filters. In the case of close it is the
> reverse with us tearing down the filters, disabling phylink, disabling
> PTP, and then releasing ownership.
> 
> > Also, if we have these ops, we know that admin down/suspend does not
> > mean media down. The presence of these ops triggers different state
> > transitions in the phylink state machine so that it simply hands off
> > control of the media, but otherwise leaves it alone.
> >
> > With this in place, i think we can avoid all the unbalanced state?
> 
> As I understand it right now the main issue is that Phylink assumes
> that it has to take the link down in order to perform a major
> configuration in phylink_start/phylink_resume.

Well, as i said, my reading of the standard is that the host can make
disruptive media changes, so you have to be able to live with
disruptive media changes. If you have to live with it, the path of
lease resistance is just to accept it.

> The requirement that the BMC not lose link comes more out of the
> multi-host setups that have been in place in the data center
> environment for the last decade or so where there was only one link
> but multiple systems all sharing that link, including the BMC. So it
> is not strictly a BMC requirement, but more of a multi-host
> requirement.

Is this actually standardised somewhere? I see there is a draft of an
update to NC-SI Specification, but i don't think the section about
controlling the link has changed. Also, the standard talks about how
you connect one Management Controller to multiple Network
Controllers. There is nothing about multiple Management Controllers
connected to one Network Controller. Or i'm i missing something, like
one Management Controller is controlling all the host connected to the
Network Controller?

> > So, can we ignore the weeds for the moment, and think about the big
> > picture?
> 
> So big picture wise we really have 2 issues:
> 1. The BMC handling doesn't currently exist, so we need to extend
> handling/hand-off for link up before we start, and link up after we
> stop.

Agreed, and that fits with DSP0222.

> 2. Expectations for our 25G+ interfaces to behave like multi-host NICs
> that are sharing a link via firmware. Specifically that
> loading/unloading the driver or ifconfig up/down on the host interface
> should not cause the link to bounce and/or drop packets for any other
> connections, which in this case includes the BMC.

For this, it would be nice to point to some standard which describes
this, so we have a generic, vendor agnostic, description of how this
is supposed to work.

	Andrew

