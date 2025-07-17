Return-Path: <netdev+bounces-207947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF47B091EC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B897D4A32A6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F02BE039;
	Thu, 17 Jul 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j+tSECtT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A641DA62E;
	Thu, 17 Jul 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769988; cv=none; b=TtfxhfX02pRdyRhEA/B+yUTnjSwsHw4SY5FCWzZvNEaz/tK1Jy06Ljm+IlhAppduWPHN4+CEMJ+Cl2HcjzPsYhd3Ej/zx/PVVfNMT05AsYd6OjHdhTxJFyEbt44Xn8Dl4K11zwXGFd7ObjdvoxMx03Ks5Agu2vFLZUPHFSYuppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769988; c=relaxed/simple;
	bh=eQMhoaVeh9uL/LQThbKAyyzQTwwiWXQJw5qztLmSJSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAVJkhJiPG2prbPaWEfwmFVwGpyfd659gJqraJ1590ObUHd0JjwV/gOPK08XVlJ7y/4mgSN2jj+yRvXNs7CJ/rD3kiDSbzOD7mtULwIfwNOEirKtCSVtfp2f8NK8JpyVw6a5oykqhCx5y56gzzQnGNE/qF/oacJXdnhmBVe3hZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j+tSECtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9222FC4CEE3;
	Thu, 17 Jul 2025 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769988;
	bh=eQMhoaVeh9uL/LQThbKAyyzQTwwiWXQJw5qztLmSJSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+tSECtTPZKlPChTcyEBIOo36vO4qPc2DiJVglGxnRk+nMGfCKdY746T73G0/E5Zc
	 COlnqXsuowmFMOkB/Z1ReHIzifEwHWWUgxeRqHk78klRgaYkkOK5SxEezL6eZd9S5s
	 45tN0uR7TCmpHUjwIsAijMprDxVCRfXt8liZsHbY=
Date: Thu, 17 Jul 2025 18:33:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <2025071726-ramp-friend-a3e5@gregkh>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
 <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>

On Thu, Jul 17, 2025 at 12:27:44PM -0400, Sean Anderson wrote:
> On 7/17/25 12:21, Greg Kroah-Hartman wrote:
> > On Thu, Jul 17, 2025 at 12:04:15PM -0400, Sean Anderson wrote:
> >> On 7/17/25 11:59, Greg Kroah-Hartman wrote:
> >> > On Thu, Jul 17, 2025 at 11:49:37AM -0400, Sean Anderson wrote:
> >> >> On 7/16/25 01:09, Greg Kroah-Hartman wrote:
> >> >> > On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
> >> >> >> Support creating auxiliary devices with the id included as part of the
> >> >> >> name. This allows for hexadecimal ids, which may be more appropriate for
> >> >> >> auxiliary devices created as children of memory-mapped devices. If an
> >> >> >> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
> >> >> >> be of the form "name.id".
> >> >> >> 
> >> >> >> With this patch, dmesg logs from an auxiliary device might look something
> >> >> >> like
> >> >> >> 
> >> >> >> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
> >> >> >> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
> >> >> >> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
> >> >> >> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
> >> >> >> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
> >> >> >> 
> >> >> >> this is especially useful when compared to what might happen if there is
> >> >> >> an error before userspace has the chance to assign a name to the netdev:
> >> >> >> 
> >> >> >> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
> >> >> >> 
> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> >> >> ---
> >> >> >> 
> >> >> >> Changes in v2:
> >> >> >> - Add example log output to commit message
> >> >> > 
> >> >> > I rejected v1, why is this being sent again?
> >> >> 
> >> >> You asked for explanation, I provided it. I specifically pointed out why
> >> >> I wanted to do things this way. But I got no response. So here in v2.
> >> > 
> >> > Again, I said, "do not do that, this is not how ids work in the driver
> >> > model", and you tried to show lots of reasons why you wanted to do it
> >> > this way despite me saying so.
> >> > 
> >> > So again, no, sorry, this isn't ok.  Don't attempt to encode information
> >> > in a device id like you are trying to do here, that's not what a device
> >> > id is for at all.  I need to go dig up my old patch that made all device
> >> > ids random numbers just to see what foolish assumptions busses and
> >> > userspace tools are making....
> >> 
> >> But it *is* how ids work in platform devices.
> > 
> > No one should ever use platform devices/bus as an excuse to do anything,
> > it's "wrong" in so many ways, but needs to be because of special
> > reasons.  No other bus should work like that, sorry.
> > 
> >> And because my auxiliary
> >> devices are created by a platform device, it is guaranteed that the
> >> platform device id is unique and that it will also be unique for
> >> auxiliary devices. So there is no assumption here about the uniqueness
> >> of any given id.
> > 
> > Then perhaps use the faux device api instead?
> 
> There's *another* pseudo bus? OK the reason why is that faux was added
> four months ago and there is nothing under Documentation for it. So I
> had no idea it existed. I will have a look, but perhaps you should write
> up some documentation about why someone might want to use a "faux" bus
> over the auxiliary bus or MFD.

"faux" is for when platform devices were being abused because someone
just wanted a device in the device tree, and did not use any of the
platform device resources.

Yes, more documentation is always a good idea, someday...

thanks,

greg k-h

