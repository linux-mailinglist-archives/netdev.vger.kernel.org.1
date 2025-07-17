Return-Path: <netdev+bounces-207945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E23B0919B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B1A1643E2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E12FC3DA;
	Thu, 17 Jul 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVy7uHZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A382FC3AE;
	Thu, 17 Jul 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769322; cv=none; b=t+WCqkNFuCRd8CIro3ZYu8roSwWcz7CkGUl4sMyxPmwlLLXcIBi3Szz9SZnYwsOIvoF8B6XGyP2Pu3buLodxiRwSQp5D41VxIQVUoMgE6EHMRoa8O+zrb8+/3I4FRWl0nVlRs2QHzRcKpIyL9A9IUOtc5xpLAnWXMc3sDCo119o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769322; c=relaxed/simple;
	bh=mdENDvIIGpzFKmMKjGR3YOrxLip3diwkL5qZ2b2U3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHgamuRTIIrWQgZP81P0zAk7jJt9ph9Z0LBNnpklzy8ZRYoLsf/Zar51smvJQRBLHwhTOVM04/wIvUseRyA4wkJrb3mLcty02uUtLK+yIBoKXU9IK4QOaGKuRDSNYtuFz0ovD5JkJDJf6xUffD0NXhTmetEs/qk/tS5c1SoWS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVy7uHZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC639C4CEE3;
	Thu, 17 Jul 2025 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769321;
	bh=mdENDvIIGpzFKmMKjGR3YOrxLip3diwkL5qZ2b2U3+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVy7uHZTR6yb9U4wQpRg+geTzky+/6LySc/HdgbLDYeFGOaBEUgA7oEDO51U5Ea7R
	 ZTYiP/tkiJ5HCJD0Ymakrt5JyYRk4Tfl4u2dLP6bXpH/yMzeQa4Ltq5Msh+JSYtsuv
	 QT55dSGm4ZZ1r4x5yWxJ5vPUVDfElLWtKZQiYyeg=
Date: Thu, 17 Jul 2025 18:21:58 +0200
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
Message-ID: <2025071736-viscous-entertain-ff6c@gregkh>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
 <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>

On Thu, Jul 17, 2025 at 12:04:15PM -0400, Sean Anderson wrote:
> On 7/17/25 11:59, Greg Kroah-Hartman wrote:
> > On Thu, Jul 17, 2025 at 11:49:37AM -0400, Sean Anderson wrote:
> >> On 7/16/25 01:09, Greg Kroah-Hartman wrote:
> >> > On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
> >> >> Support creating auxiliary devices with the id included as part of the
> >> >> name. This allows for hexadecimal ids, which may be more appropriate for
> >> >> auxiliary devices created as children of memory-mapped devices. If an
> >> >> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
> >> >> be of the form "name.id".
> >> >> 
> >> >> With this patch, dmesg logs from an auxiliary device might look something
> >> >> like
> >> >> 
> >> >> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
> >> >> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
> >> >> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
> >> >> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
> >> >> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
> >> >> 
> >> >> this is especially useful when compared to what might happen if there is
> >> >> an error before userspace has the chance to assign a name to the netdev:
> >> >> 
> >> >> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
> >> >> 
> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >> >> ---
> >> >> 
> >> >> Changes in v2:
> >> >> - Add example log output to commit message
> >> > 
> >> > I rejected v1, why is this being sent again?
> >> 
> >> You asked for explanation, I provided it. I specifically pointed out why
> >> I wanted to do things this way. But I got no response. So here in v2.
> > 
> > Again, I said, "do not do that, this is not how ids work in the driver
> > model", and you tried to show lots of reasons why you wanted to do it
> > this way despite me saying so.
> > 
> > So again, no, sorry, this isn't ok.  Don't attempt to encode information
> > in a device id like you are trying to do here, that's not what a device
> > id is for at all.  I need to go dig up my old patch that made all device
> > ids random numbers just to see what foolish assumptions busses and
> > userspace tools are making....
> 
> But it *is* how ids work in platform devices.

No one should ever use platform devices/bus as an excuse to do anything,
it's "wrong" in so many ways, but needs to be because of special
reasons.  No other bus should work like that, sorry.

> And because my auxiliary
> devices are created by a platform device, it is guaranteed that the
> platform device id is unique and that it will also be unique for
> auxiliary devices. So there is no assumption here about the uniqueness
> of any given id.

Then perhaps use the faux device api instead?

thanks,

greg k-h

