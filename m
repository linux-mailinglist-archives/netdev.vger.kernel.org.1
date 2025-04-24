Return-Path: <netdev+bounces-185734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D767A9B946
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2341B60326
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D982192FD;
	Thu, 24 Apr 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c7beM3Dz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8C4414
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526895; cv=none; b=ptIxw/Q5SeZJIJejH9uB2h9bjgEyhCWam31dH0iiruczGlX2C59qABnItEsdCgKyqn1nojWZ+KqlbvIRhgMct1dXUrADQDj3kZCcLydAL8D4oWtUM48AgC3hdBHjYFW8p1YtS79w2qpZqzYNHttqUHaAu2j2+FahdF7lbhBcYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526895; c=relaxed/simple;
	bh=V8URR3g958yg3vP5Z35iK1YO2szV8GmuvvA8Lhelwkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQpv9sFxFOFX3xRvjkC1wod+vECrVMa6uotP5vUR0W7D2NI1xgjup7ah5SqcZsj2LknbpmRcnY5147AEyoOJ0Qmapr5r6GhhsJa2bjN+qeHN9RDR/EpsqiGCRGIQOFRHRZAfGXyoLH/Q8nxS2qwwAXSQPdEe55rH1OfIDbQJPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c7beM3Dz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=std+j5Qaz87SwbkZsVsKpwrzLyZzLrkia9SzU8BDXqc=; b=c7beM3DzrUheImButF4mcXE6vN
	gtE9qGQjIU1v9P/0KIcfONdRWbSQ13kJ0Z/09J3D3D6VMz/lD0aR+Re+xEwzExMjpY8HMDXrRZw8Q
	X9Iw//pTmTQcSWIRrfYb2X1EscKa7hteUJsVKxIJD37Wu+bP5OqI8xYmaYzLnXetNWjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u83HW-00AVme-PA; Thu, 24 Apr 2025 22:34:50 +0200
Date: Thu, 24 Apr 2025 22:34:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
Message-ID: <3e37228e-c0a9-4198-98d3-a35cc77dbd94@lunn.ch>
References: <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch>
 <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org>
 <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org>
 <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
 <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch>
 <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>

Sorry for the delay, busy with $DAY_JOB

> > > > There are not 4 host MACs connected to a 5 port switch. Rather, each
> > > > host gets its own subset of queues, DMA engines etc, for one shared
> > > > MAC. Below the MAC you have all the usual PCS, SFP cage, gpios, I2C
> > > > bus, and blinky LEDs. Plus you have the BMC connected via an RMII like
> > > > interface.
> > >
> > > Yeah, that is the setup so far. Basically we are using one QSFP cable
> > > and slicing it up. So instead of having a 100CR4 connection we might
> > > have 2x50CR2 operating on the same cable, or 4x25CR.
> >
> > But for 2x50CR2 you have two MACs? And for 4x25CR 4 MACs?
> 
> Yes. Some confusion here may be that our hardware always has 4
> MAC/PCS/PMA setups, one for each host. Depending on the NIC
> configuration we may have either 4 hosts or 2 hosts present with 2
> disabled.

So with 2 hosts, each host has two netdevs? If you were to dedicate
the whole card to one host, you would have 4 netdevs? It is upto
whatever is above to perform load balancing over those?

If you always have 4 MAC/PCS, then the PCS is only ever used with a
single lane? The MAC does not support 100000baseKR4 for example, but
250000baseKR1?

> The general idea is that we have to cache the page and bank in the
> driver and pass those as arguments to the firmware when we perform a
> read. Basically it will take a lock on the I2C, set the page and bank,
> perform the read, and then release the lock. With that all 4 hosts can
> read the I2C from the QSFP without causing any side effects.

I assume your hardware team have not actually implemented I2C, they
have licensed it. Hence there is probably already a driver for it in
drivers/i2c/busses, maybe one of the i2c-designware-? However, you are
not going to use it, you are going to reinvent the wheel so you can
parse the transactions going over it, look for reads and writes to
address 127? Humm, i suppose you could have a virtual I2C driver doing
this stacked on top of the real I2C driver. Is this something other
network drivers are going to need? Should it be somewhere in
drivers/net/phy? The hard bit is how you do the mutex in an agnostic
way. But it looks like hardware spinlocks would work:
https://docs.kernel.org/locking/hwspinlock.html

And actually, it is more complex than caching the page.

  This specification defines functions in Pages 00h-02h. Pages 03-7Fh
  are reserved for future use. Writing the value of a non-supported
  Page shall not be accepted by the transceiver. The Page Select byte
  shall revert to 0 and read / write operations shall be to the
  unpaged A2h memory map.

So i expect the SFP driver to do a write followed by a read to know if
it needs to return EOPNOTSUPP to user space because the SFP does not
implement the page.

	Andrew

