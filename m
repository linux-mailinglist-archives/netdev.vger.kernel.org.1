Return-Path: <netdev+bounces-96508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A678C643D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B461C211F0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5859B4A;
	Wed, 15 May 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZz+nbjC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A359148
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766712; cv=none; b=YJJBiH3U84lNtf8KpMO/ROqn3uZLx7TlCYe5EzvwEC/idWrEbSH+PQoaLvUYQKf42CxSD3TQAdwXkJG6DfZtUYW7wOyXkUGMsXk9lTBQqfSpFaGZ+qyFocjViePu0pjG1+nUz0a+VVtPBoxZhDpDNxX7tQrwfmtdATRwmJc2mio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766712; c=relaxed/simple;
	bh=BkyFfaGVIKCZ1ZyJ0xTQOY4oniQInKidgfDLsMQakvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC5JV/l8vy24RJMEfDWj6QQhkVb+cz/LaEVNQXCMGGFUP5LuHrNUEqcuELtgL/AmzQDQYyGkOEr0tRmWSni3pwWOgQjqxT5hiUc1hXo5GO/66w9awt5IW8BCenBOdQ5ASrLqq0X030Rjz4Z3pZscDK+7VGMkSufibEyPMtRWupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZz+nbjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F92DC32781;
	Wed, 15 May 2024 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715766712;
	bh=BkyFfaGVIKCZ1ZyJ0xTQOY4oniQInKidgfDLsMQakvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZz+nbjCTnu1mZMx4e/yM6+ide2jo02D48ZD4U9yR9dlly+GRJbaCrujfDtaf9iBX
	 q8Ax9liFq8p7p0dGBdcEed/sS7ZhkiYxF8AomF6J+2u/UnoeKuOLqvgr9i5k1A1gkh
	 DRkUDFixnqWem5gFwrQd0HHczZ3g0ec0jHNxQ0UFsnRBolQG4qGbsrKCsv5Ly1Aifs
	 nMPUSVtUdYWl9etD1kiP8W05p9ExjSQmnGmZ1tj6sKHNNmpnkeeA08sOLVzoqoyjD5
	 uLvX6QzFH10VdEBAe3MrNWEg35LjXukAHHD8OoadICxpIkopAxq2JIo8pFnVSklyir
	 HEvcxaNaCIchg==
Date: Wed, 15 May 2024 10:51:47 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240515095147.GB154012@kernel.org>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
 <e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
 <9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
 <f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
 <a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
 <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>

On Fri, May 10, 2024 at 01:05:41PM +0200, Paolo Abeni wrote:
> On Thu, 2024-05-09 at 18:17 +0200, Andrew Lunn wrote:
> > > > Now the question is, how do i get between these two states? It is not
> > > > possible to mix WRR and strict priority. Any kAPI which only modifies
> > > > one queue at once will go straight into an invalid state, and the
> > > > driver will need to return -EOPNOTSUPP. So it seems like there needs
> > > > to be an atomic set N queue configuration at once, so i can cleanly go
> > > > from strict priority across 8 queues to WRR across 8 queues. Is that
> > > > foreseen?
> > > 
> > > You could delete all the WRR shapers and then create/add SP based ones.
> > 
> > But that does not match the hardware. I cannot delete the hardware. It
> > will either do strict priority or WRR. If i delete the software
> > representation of the shaper, the hardware shaper will keep on doing
> > what it was doing. So i don't see this as a good model. I think the
> > driver will create shapers to represent the hardware, and you are not
> > allowed to delete them or add more of them, because that is what the
> > hardware is. All you can do is configure the shapers that exist.
> > 
> > > The 'create' op is just an abstraction to tell the NIC to switch from
> > > the default configuration to the specified one.
> > 
> > Well, the hardware default is i think WRR for the queues, and line
> > rate. That will be what the software representation of the shapers
> > will be set to when the driver probes and creates the shapers
> > representors.
> 
> If I read correctly, allowing each NIC to expose it's own different
> starting configuration still will not solve the problem for this H/W to
> switch from WRR to SP (and vice versa).
> 
> AFAICS, what would be needed there is an atomic set of operations:
> 'set_many' (and e.v. 'delete_many', 'create_many') that will allow
> changing all the shapers at once. 
> 
> With such operations, that H/W could still fit the expected 'no-op'
> default, as WRR on the queue shapers is what we expect. I agree with
> Jakub, handling the complexity of arbitrary starting configuration
> would pose a lot of trouble to the user/admin.
> 
> If all the above stands together, I think we have a few options (in
> random order):
> 
> - add both set of operations: the ones operating on a single shaper and
> the ones operating on multiple shapers
> - use only the multiple shapers ops.
> 
> And the latter looks IMHO the simple/better. At that point I would
> probably drop the 'add' op and would rename 'delete' as
> 'reset':
> 
> int (*set)(struct net_device *dev, int how_many, const u32 *handles,
> 	   const struct net_shaper_info *shapers,
>            struct netlink_ext_ack *extack);
> int (*reset)(struct net_device *dev, int how_many, const u32 *handles,
>              struct netlink_ext_ack *extack);
> int (*move)(struct net_device *dev, int how_many, const u32 *handles,
>             const u32 *new_parent_handles,
> 	    struct netlink_ext_ack *extack);
> 
> An NIC with 'static' shapers can implement a dummy move always
> returning EOPNOTSUPP and eventually filling a detailed extack.
> 
> NIC without any constraints on mixing and matching different kind of
> shapers could implement the above as a loop over whatever they will do
> for the corresponding 'single shaper op'
> 
> NIC with constrains alike the one you pointed out could validate the
> final state before atomically applying the specified operation.
> 
> After a successful  'reset' operation, the kernel could drop any data
> it retains/caches for the relevant shapers - the current idea is to
> keep a copy of all successfully configured shaper_info in a xarray,
> using the 'handle' as the index.
> 
> Side note: the move() operation could look like a complex artifact, but
> it's the simplest instrument I could think of to support scenarios
> where the user creates/configures/sets a queue group and 'move' some
> queue under the newly created group
> 
> WDYT?

Hi Andrew,

Picking up this discussion, I'm wondering if Paolo's proposal
addresses your concerns.

