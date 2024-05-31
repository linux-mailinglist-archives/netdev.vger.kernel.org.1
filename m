Return-Path: <netdev+bounces-99781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB68D6631
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F70B25FD5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66779950;
	Fri, 31 May 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L46iF7zo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F11CFB9
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171258; cv=none; b=r1N6nSzahipV2yrlXMeh2c2i8Tt9DQgemKiTDvmtTFQo/W+vYZcSzl8WAASiEJpzigHZPRJ3L8FNVSXVWLWvjQbIgtp5gvzZ0btJ5G+EjpHuhsbDXp0Y946jmKIqqqXE3ZMbPwX+HuM6tYjnqup13pUI5noCph2I427k3Gv1V5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171258; c=relaxed/simple;
	bh=TV02sWb1rtx0nWwZkRpN0Jorl0N3AhObSpgLL9VfzFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOw1LSQoFiDOxUijzoxCe6Bnm6Q6KGyrkxv73Kndsc5zEnWbwIdsXr0MbUsJs/6Iw8ka0NYnqh7/gPtldZW1gr92gbK0Fr7jIkNPB+ZlARY8evMtmln/5OhDinlyOg1CgfSkaZOftMYH/K7zfIvwstXeoFH66RgtJLwPlkqW5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L46iF7zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA987C116B1;
	Fri, 31 May 2024 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171258;
	bh=TV02sWb1rtx0nWwZkRpN0Jorl0N3AhObSpgLL9VfzFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L46iF7zoMvZKHATaKXXvDOP9eDPtvLqjX4RuMc50eyqVd/QM31jwHkQfaPMln958x
	 DTNw1ogSB3SqXKDqrTNvNmpftEeANJHWZJ2db790Ct+tlJ8ze7Nc0JRmHTwvxNTkPP
	 4ejqvkuG0pZ1unn3WbAf4Qt3tJyBM3itDU3xUM90Fcu+usmRStVYpHjhAnFvUp7Jkt
	 EOe2UXTDpOUzxEiBTWHLE9HzuqmAPkXdwUnRMqjq8ChminsjLb6S7I+bXZsqgFi4Rt
	 bJ1FJuCOqQ4whaNEwk6mjSdwLOs6ACh7DVmE/nX8tlYOWUj6I+mLDsjwZaoSNpZu1K
	 1NAHLO+W/0Zpw==
Date: Fri, 31 May 2024 09:00:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240531090057.02fb8616@kernel.org>
In-Reply-To: <16d7b761c3c1b4c4bd327d4486d958682a5f33dd.camel@redhat.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	<20240528101845.414cff22@kernel.org>
	<16d7b761c3c1b4c4bd327d4486d958682a5f33dd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 11:22:46 +0200 Paolo Abeni wrote:
> On Tue, 2024-05-28 at 10:18 -0700, Jakub Kicinski wrote:
> > > +	u32 priority;	/* scheduling strict priority */
> > > +	u32 weight;	/* scheduling WRR weight*/  
> > 
> > I wonder if we should somehow more clearly specify what a node can do.
> > Like Andrew pointed out, if we have a WRR node, presumably the weights
> > go on the children, since there's only one weigh param. But then the
> > WRR node itself is either empty (no params) or has rate params... which
> > is odd.
> > 
> > Maybe shaping nodes and RR nodes should be separate node classes,
> > somehow?  
> 
> Possibly clarifying the meaning of 'weight' field would help?  
> It means: this node is scheduled WRR according to the specified weight
> among the sibling shapers with the same priority.
> 
> I think it's quite simpler than introducing different node classes with
> separate handling. My understanding is that the latter would help only
> to workaround some H/W limitation and will make the implementation more
> difficult for more capable H/W.
> 
> What kind of problems do you foresee with the above definition?

The problem Andrew mentioned, basically. There may not be a path to
transition one fully offloaded hierarchy to another (e.g. switching
strict prio to WRR). TBH I haven't really grasped your proposal in:
https://lore.kernel.org/all/db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com/

> > > + * enum net_shaper_scope - the different scopes where a shaper could be attached
> > > + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
> > > + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
> > > + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtual
> > > + * function.
> > > + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues under the
> > > + * same device.
> > > + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given device queue.  
> > 
> > I wonder if we need traffic class? Some devices may have two schedulers,
> > one from the host interfaces (PCIe) into the device buffer. And then
> > from the device buffer independently into the wire.  
> 
> I feel like I'm really missing your point here. How would you use
> traffic class? And how the 2 schedulers come into play here? Each of
> them will be tied to one or more of the scopes above, why exposing H/W
> details that will not expand user visible features?

I was just thinking aloud, I'm not sure anyone would ever use a single
host queue to service (ingress) traffic from multiple TCs.
Or if any HW actually supports that. 

We can add it later.

> > > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
> > > + * PF devices, usually inside the host/hypervisor.
> > > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
> > > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
> > > + */
> > > +enum net_shaper_scope {
> > > +	NET_SHAPER_SCOPE_PORT,
> > > +	NET_SHAPER_SCOPE_NETDEV,
> > > +	NET_SHAPER_SCOPE_VF,  
> > 
> > I realized now that we do indeed need this VF node (if we want to
> > internally express the legacy SRIOV NDOs in this API), as much 
> > as I hate it. Could you annotate somehow my nack on ever exposing
> > the ability to hook on the VF to user space?  
> 
> This work sparked from the need to allow configuring a shaper on
> specific queues of some VF from the host. I hope this is not what you
> are nacking here? Could you please elaborate a bit what concern you
> with 'hook on the VF to user space'? Would the ability of attaching a
> shaper to the VF from the host hit your nack?

Queue configuration, for the VF, from the hypervisor?
I thought it was from the VF.
In any case, hypervisor has the representors. 
Use the representor's NETDEV scope?

> > > +	NET_SHAPER_SCOPE_QUEUE_GROUP,  
> > 
> > We may need a definition for a queue group. Did I suggest this?  
> 
> I think this was mentioned separately by you, John Fastabend and Intel.

Oh ugh, I can't type. I think I meant to say "Why do we need..."

> > Isn't queue group just a bunch of queues feeding a trivial RR node?
> > Why does it need to be a "scope"?  
> 
> The goal is allowing arbitrary manipulation at the queue group level.
> e.g. you can have different queue groups with different priority, or
> weigh or shaping, and below them arbitrary shaping at the queue level.
> 
> Note that a similar concept could be introduced for device (or VFs)
> groups.
> 
> Why would you like to constraint the features avail at the queue
> groups?

Wait! You don't have a way to create pure RR nodes other than queue
group now? Perhaps that's what I'm missing...

> > > +	NET_SHAPER_SCOPE_QUEUE,
> > > +};
> > > +
> > > +/**
> > > + * struct net_shaper_ops - Operations on device H/W shapers
> > > + * @add: Creates a new shaper in the specified scope.  
> > 
> > "in a scope"? Isn't the scope just defining the ingress and egress
> > points of the scheduling hierarchy?  
> 
> This is purely lexical matter, right? The scope, and more specifically
> the full 'handle' comprising more scoped-related information, specifies
> 'where' the shaper is located. Do you have a suggested alternative
> wording?

... and also what confused me here.

How are you going to do 2 layers of grouping with arbitrary shaping?
We need arbitrary inner nodes. Unless I'm missing a trick.

> > Also your example moves schedulers from queue scope to queue group
> > scope.  
> 
> In the example, this part creates/enables a shaper at the queue level:
> 
> 	u32 ghandle = shaper_make_handle(NET_SHAPER_SCOPE_QUEUE_GROUP, 0, 0);
> 	dev->shaper_ops->add(dev, ghandle, &ginfo);
> 
> and this:
> 	
> 	u32 handle = shaper_make_handle(NET_SHAPER_SCOPE_QUEUE, 0, queue_id);
> 	//...
> 	dev->netshaper_ops->move(dev, qhandle, ghandle, NULL);
> 
> changes the _parent_ of qhandle setting it to the previously creates
> queue group shaper. qhandle initial/implicit/default parent was the
> device scope shaper.
> 
> The scope of the queue shaper remains unchanged. An I misunderstanding
> your point?
> 

> > Why "if it exists" ? Core should make sure it exists, no?
> > 
> > In addition to ops and state, the device will likely need to express
> > capabilities of some sort. So that the core can do some work for the
> > drivers and in due course we can expose them to user space for
> > discoverability.  
> 
> What kind of capabilities are you thinking about? supported scopes?
> supported metrics? What else? I feel like there is a lot of
> mixed/partial kind of support which is hard to express in a formal way
> but would fit nicely an extended ack for a failing op - as the SP/WRR
> constrains Andrew reported.
> 
> Do we need to introduce this introspection support from the start? I
> think that having a few H/W implementations around would help (at least
> me) understanding which properties could relevant here.

Try to write good tests which can run on HW for more than one
vendor. The introspection and capabilities will become apparent.

