Return-Path: <netdev+bounces-133796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5F997125
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6108286CB2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4526A1E32CB;
	Wed,  9 Oct 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRtTpEhy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836E1E32CE;
	Wed,  9 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490185; cv=none; b=cxXhUNdgw1WQdEcfyn29iEH88WbUe9SIq8TqebAajvlGzWwYrD8A7+0kx4h7ImvgfB9M5Lil7g9kG+9dZyHqoiPQm+gRvXs8uUpM6RMmpY2GRTWHFwtLP2vkzVsL2m1x8rnHar4MaXYGTgxg4KbwFQ4lYgAxO+miNmpmUWEoWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490185; c=relaxed/simple;
	bh=zHFZh0+NMiMWYYJ4ABAZdyr64m8aYnHfZn/F21PIQ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbMbHW4ir5e7j9kOgQBXdTghSq/UzrsKeiuHTuxAvlgitIDTFZrcgVnfqQqXdYFidNaLjJM2VQIn/yKyakovM6H9e002O3S6Pzm5UpYIj4N7A5oQ4p3Mu6qPAaqQnvoulNAceHLP+cz0maZ9WuB/HwGUjRxBspiLE5Qg7YmzoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kRtTpEhy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ACLnXv8vy+mXWC64mZBSTow4VmehlxdQjUKWeB/19WQ=; b=kR
	tTpEhyogUX5xwRBQHGmMMvaheMFjOaB8YYklRjpplD3+QS1hf62S7tkAnmYb/tKkH79N8aYgs0ZG3
	qnYCzF3K8sJwTGOLm8wiu91sK8P0LxnzrY/qi34FAnPFtU2sFEwx5S6ojj9W4PXe2vyCirIGz+80f
	37i/nE/HNFHG55U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syZFk-009W8n-9w; Wed, 09 Oct 2024 18:09:32 +0200
Date: Wed, 9 Oct 2024 18:09:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for PSE
 PI priority feature
Message-ID: <9e58bfec-c915-4c30-9d75-979a309e3f69@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
 <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
 <ZwU6QuGSbWF36hhF@pengutronix.de>
 <9c77d97e-6494-4f86-9510-498d93156788@lunn.ch>
 <ZwYt0WT-tdOM0Abj@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwYt0WT-tdOM0Abj@pengutronix.de>

On Wed, Oct 09, 2024 at 09:16:33AM +0200, Oleksij Rempel wrote:
> Hi Andrew,
> 
> On Tue, Oct 08, 2024 at 06:50:25PM +0200, Andrew Lunn wrote:
> > On Tue, Oct 08, 2024 at 03:57:22PM +0200, Oleksij Rempel wrote:
> > > On Thu, Oct 03, 2024 at 01:41:02AM +0200, Andrew Lunn wrote:
> > > > > +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > > > > +	msg.sub[2] = id;
> > > > > +	/* Controller priority from 1 to 3 */
> > > > > +	msg.data[4] = prio + 1;
> > > > 
> > > > Does 0 have a meaning? It just seems an odd design if it does not.
> > > 
> > > 0 is not documented. But there are sub-priority which are not directly
> > > configured by user, but affect the system behavior.
> > > 
> > > Priority#: Critical – 1; high – 2; low – 3
> > >  For ports with the same priority, the PoE Controller sets the
> > >  sub-priority according to the logic port number. (Lower number gets
> > >  higher priority).
> > 
> > With less priorities than ports, there is always going to be something
> > like this.
> > 
> > > 
> > > Port priority affects:
> > > 1. Power-up order: After a reset, the ports are powered up according to
> > >  their priority, highest to lowest, highest priority will power up first.
> > > 2. Shutdown order: When exceeding the power budget, lowest priority
> > >  ports will turn off first.
> > > 
> > > Should we return sub priorities on the prio get request?
> > 
> > I should be optional, since we might not actually know what a
> > particular device is doing. It could pick at random, it could pick a
> > port which is consuming just enough to cover the shortfall if it was
> > turned off, it could pick the highest consumer of the lowest priority
> > etc. Some of these conditions are not going to be easy to describe
> > even if we do know it.
> 
> After reviewing the manuals for LTC4266 and TPS2388x, I realized that these
> controllers expose interfaces, but they don't implement prioritization concepts
> themselves.
> 
> The LTC4266 and TPS2388x controllers provide only interfaces that allow the
> kernel to manage shutdown and prioritization policies. For TPS2388x, fast
> shutdown is implemented as a port bitmask with only two priorities, handled via
> the OSS pin. Fast shutdown is triggered by the kernel on request by toggling
> the corresponding pin, and the policy - when and why this pin is toggled - is
> defined by the kernel or user space. Slow shutdown, on the other hand, is
> managed via the I2C bus and allows for more refined control, enabling a wider
> range of priorities and more granular policies.
> 
> I'll tend to hope we can reuse the proposed ETHTOOL_A_C33_PSE_PRIO interface
> across different PSE controllers. However, it is already being mapped to
> different shutdown concepts: PD692x0 firmware seems to rely on a slow shutdown
> backed by internal policies, while TPS2388x maps it to fast shutdown with
> driver specific policy. This inconsistency could force us to either break the
> UAPI or introduce a new, inconsistent one once we realize TPS2388x fast
> shutdown isn't what we actually need.

We should try to avoid fragmentation of the API, but given there is no
standardisation here, vendors are free to do whatever they want, this
may be difficult. Still, we should try to avoid it.

Maybe we want to consider a generic simple prioritization in the
kernel, plus export a generic model of PSE to user space to allow a
user space manager? This is really policy, and ideally we don't want
policy in the kernel. The in kernel implementation can use the
hardware prioritisation if it supports it, otherwise provide a library
of code which a driver can use to implement simple software
prioritisation?

For a user space manager, we already talked about an event to signal
that we are entering overload. I guess we additionally need an API to
get the current runtime state, what each consumer is actually
consuming, and a management API to shutdown or enable a port due to
overload, which is separate to the administrative state of a port.

The hardware/firmware might provide lots of options and capabilities,
but sometimes it is better it ignore them. Export a basic set which we
expect most PSE controllers can offer, and do the rest in our software
which we have full insight into, and debug and share, unlike firmware
which is a broken black box.

If we decide this is the way we want to go, we should not need to
extend the API for LTC4266 and TPS2388x, you just implement a basic
prioritisation in the driver. If it turns out to be not ideal, it does
not matter so much, so long as we have the understanding that
eventually we can have something better in userspace.

We can maybe do a rough sketch of what the kAPI looks like for a user
space manager, but we can kick the implementation down the road while
the in kernel prioritization is good enough.

	Andrew



