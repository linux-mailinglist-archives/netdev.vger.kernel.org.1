Return-Path: <netdev+bounces-94958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E698C1198
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9782B1C20C4A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5112F378;
	Thu,  9 May 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tcv5Fbxw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B21A291
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266813; cv=none; b=p//MiF8nUuo7p5L6Qk1QEU8V0Q/dk3uRP2Z0N6NaF1U2FN3IVN2e7EGaYzWGh5gQIh/a4Ho+zN2boEJqPpuq+BrO7mf06w9jWL/0fwl49c9V/OBbBvVMfWmSj3yhmuHyKtVLjf9K4LOZraSp11r/8IbkptAc+xo2pOU6Y8t0e2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266813; c=relaxed/simple;
	bh=6ftSrctv10FAz7RiUAJIYF9Y5gOvMGGbEzuMyX98mP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE0dKS+70pZiqUUHKXFWE6sHbYgUUmknAM8szJBFJ0MYNBMPj7rBkRAnMTvP69sSpBiUo88nFmSaTgqa3lLGGCpt4bcsOXJjJdDTrsbTKZt6BiXSGj/Wq48UujCWKTyydm59r1/zMGvojbtz76w+0K/zI2xup+noVIIxW0FTE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tcv5Fbxw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TWipcFUEzYNEyfZ8kW1nhBJwFJZ6hYEl2hw3+ii14T8=; b=Tcv5FbxwQwZWb+SVzoM1QThrK9
	3I3KiQmk3Zlm/RynHd1qydq6/VNfB7zvYCDuv6GRKgH9sRjvRQHxM1nxz25xWS/8Lr4aCiE5jSwQ0
	T9S2WZg8snm6fx9o3+Zpd4C9/GWRfAjfXr21xgRZaKA0RpYAH88ohGBkekQst69LxoIM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s55Fb-00F3Lj-TK; Thu, 09 May 2024 17:00:03 +0200
Date: Thu, 9 May 2024 17:00:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>

On Thu, May 09, 2024 at 04:19:52PM +0200, Paolo Abeni wrote:
> On Wed, 2024-05-08 at 23:47 +0200, Andrew Lunn wrote:
> > > + * struct net_shaper_info - represents a shaping node on the NIC H/W
> > > + * @metric: Specify if the bw limits refers to PPS or BPS
> > > + * @bw_min: Minimum guaranteed rate for this shaper
> > > + * @bw_max: Maximum peak bw allowed for this shaper
> > > + * @burst: Maximum burst for the peek rate of this shaper
> > > + * @priority: Scheduling priority for this shaper
> > > + * @weight: Scheduling weight for this shaper
> > > + */
> > > +struct net_shaper_info {
> > > +	enum net_shaper_metric metric;
> > > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
> > > +	u64 bw_max;	/* maximum allowed bandwidth */
> > > +	u32 burst;	/* maximum burst in bytes for bw_max */
> > > +	u32 priority;	/* scheduling strict priority */
> > 
> > Above it say priority. Here is strict priority? Is there a difference?
> 
> the 'priority' field is the strict priority for scheduling. We will
> clarify the first comment.
> 
> > 
> > > +	u32 weight;	/* scheduling WRR weight*/
> > > +};
> > 
> > Are there any special semantics for weight? Looking at the hardware i
> > have, which has 8 queues for a switch port, i can either set it to
> > strict priority, meaning queue 7 needs to be empty before it look at
> > queue 6, and it will only look at queue 5 when 6 is empty etc. Or i
> > can set weights per queue. How would i expect strict priority?
> 
> The expected behaviour is that schedulers at the same level with the
> same priority will be served according to their weight.
> 
> I'm unsure if I read your question correctly. My understanding is that
> the your H/W don't allow strict priority and WRR simultaneously.

Correct. There is one bit to select between the two. If WRR is
enabled, it then becomes possible for some generations of the hardware
to configure the weights, for others the weights are fixed in silicon.

> In
> such case, the set/create operations should reject calls setting both
> non zero weight and priority values.

So in order to set strict priority, i need to set the priority field
to 7, 6, 5, 4, 3, 2, 1, 0, for my 8 queues, and weight to 0. For WRR,
i need to set the priority fields to 0, and the weight values, either
to what is hard coded in the silicon, or valid weights when it is
configurable.

Now the question is, how do i get between these two states? It is not
possible to mix WRR and strict priority. Any kAPI which only modifies
one queue at once will go straight into an invalid state, and the
driver will need to return -EOPNOTSUPP. So it seems like there needs
to be an atomic set N queue configuration at once, so i can cleanly go
from strict priority across 8 queues to WRR across 8 queues. Is that
foreseen?

> It sounds correct. You can avoid creating the queue group and set the
> rate at the NETDEV scope, or possibly not even set/create such shaper:
> the transmission is expected to be limited by the line rate.

Well, the hardware exists, i probably should just create the shapers
to match the hardware. However, if i set the hardware equivalent of
bw_max to 0, it then uses line rate. Is this something we want to
document? You can disable a shaper from shaping by setting the
bandwidth to 0? Or do we want a separate enable/disable bit in the
structure?

> 
> > > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> > 
> > Are they also available on plain boring devices which don't have PFs
> > or VFs?
> 
> Yes, a driver is free to implement/support an arbitrary subset of the
> available feature. Operations attempting to set an unsupported state
> should fail with a relevant extended ack.

Great. Please update the comment.

> > In my case, only one field appears to be relevant in
> > each shaper, and maybe we want to give a hint about that to userspace?
> 
> Any suggestion on how to expose that in reasonable way more then
> welcome!

We might first want to gather knowledge on what these shapers actually
look like in different hardwares. There are going to be some which are
very limited fixed functions as in the hardware i have, probably most
SOHO switches are like this. And then we have TOR and smart NICs which
might be able to create and destroy shapers on the fly, and are a lot
less restrictive.

     Andrew

