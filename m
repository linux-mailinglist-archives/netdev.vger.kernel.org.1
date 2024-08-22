Return-Path: <netdev+bounces-121185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6B95C128
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948EBB23A51
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2761D175F;
	Thu, 22 Aug 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHCp4Bss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718A1D0DF0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367371; cv=none; b=sYFfy213q+Wnc5yvISq5B7Y71s7cMfmsvUVG3UKDAJ7Z9Zly2smJhj0Ewx2pM6qW+BoGuyJGBLW5jv+KcOw36rqrzhPd5RAuK/XJOo4MZrITFyh7m2ytWP9daPjqCuDqo2CEdK2KbdkYSJBNv15JmNUgHLIXdvWgaeoiSS7VyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367371; c=relaxed/simple;
	bh=GD444nESfh5+IniZaLEN0vb5YTdaJgwBwn/TC2aSrh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDXnQLNIEGwTdLGJ22vk7L1Lw7FdXT86+eWFbC2PsqXMOlkeSyl9DeqJIfMw/GX/sXSwpTwk2blkHgEAIxX+ITQeJWpkbKuxPGL2KfkqLqsFJUUSKuTzmYUBWY39prqNBLIkP+XVhZdYo3Eb4kISPipxA8l+rkRlmfVyyYwFKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHCp4Bss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA55C32782;
	Thu, 22 Aug 2024 22:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724367369;
	bh=GD444nESfh5+IniZaLEN0vb5YTdaJgwBwn/TC2aSrh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OHCp4BssRP6vCyGa+IOtXssaX6G6q1mKnHzoHfmRRgVJwV22xb1VsGNnJKNUARLmM
	 w4D5LBIIcuKCVEBXTAUFQUc4bZgrMv6y8Wuc9mzsfBwRxUkohcDR3XXsKiD+1br8aL
	 ybJVefMs34pHRHhsoA8Pu0LWYw8E72E9PhgXMKXZxWAMwpgoQdikYzQTJhRv7S/U93
	 YbUVD8Uxw3rzhxGyk7ZZGfGQ0QWRiQ/0EAzWpDu3hXm0R6fgLV567/MCu/B0soBynS
	 fwKK+R8A3y0D+9/yzLetS0WN8l50dyl0NIcnxsHmmoN1J3XM0/CUFqx1H05eNw7J/E
	 6iCTy28lYWZ/g==
Date: Thu, 22 Aug 2024 15:56:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240822155608.3034af6c@kernel.org>
In-Reply-To: <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
	<ZquQyd6OTh8Hytql@nanopsycho.orion>
	<b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
	<ZrxsvRzijiSv0Ji8@nanopsycho.orion>
	<f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
	<Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
	<4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
	<ZsMyI0UOn4o7OfBj@nanopsycho.orion>
	<47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
	<Zsco7hs_XWTb3htS@nanopsycho.orion>
	<20240822074112.709f769e@kernel.org>
	<cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 22:30:35 +0200 Paolo Abeni wrote:
> >> I'm not saying this is deal breaker for me. I just think that if the api
> >> is designed to be independent of the object shaper is bound to
> >> (netdev/devlink_port/etc), it would be much much easier to extend in the
> >> future. If you do everything netdev-centric from start, I'm sure no
> >> shaper consolidation will ever happen. And that I thought was one of the
> >> goals.
> >>
> >> Perhaps Jakub has opinion.  
> > 
> > I think you and I are on the same page :) Other than the "reference
> > object" (netdev / devlink port) the driver facing API should be
> > identical. Making it possible for the same driver code to handle
> > translating the parameters into HW config / FW requests, whether
> > they shape at the device (devlink) or port (netdev) level.
> > 
> > Shaper NL for netdevs is separate from internal representation and
> > driver API in my mind. My initial ask was to create the internal
> > representation first, make sure it can express devlink and handful of
> > exiting netdev APIs, and only once that's merged worry about exposing
> > it via a new NL.
> > 
> > I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
> > but talking about it now strikes me as cart before the horse.  
> 
> FTR, I don't see both of you on the same page ?!?
> 
> I read the above as Jiri's preference is a single ndo set to control
> both devlink and device shapers, while I read Jakub's preference as for
> different sets of operations that will use the same arguments to specify
> the shaper informations.

Jiri replied:

  > which kind of object should implement the ndo_shaper_ops callbacks?

  Whoever implements the shaper in driver. If that is net_device tight
  shaper, driver should work with net_device. If that is devlink port
  related shaper, driver should work on top of devlink port based api.

I interpret this as having two almost identical versions of shaper ops,
the only difference is that one takes netdev and the other devlink port.
We could simplify it slightly, and call the ndo for getting devlink
port from netdev, and always pass devlink port in?

I _think_ (but I'm not 100% sure) that Jiri does _not_ mean that we
would be able to render the internal shaper tree as ops for the
existing devlink rate API. Because that may cause scope creep,
inconsistencies and duplication.

> Or to phrase the above differently, Jiri is focusing on the shaper
> "binding" (how to locate/access it) while Jakub is focusing on the 
> shaper "info" (content/definition/attributes). Please correct me If I 
> misread something.
> 
> Still for the record, I interpret the current proposal as not clashing
> with Jakub's preference, and being tolerated from Jiri, again please 
> correct me if I read too far.

One more thing, Jiri said:

  If you do everything netdev-centric from start, I'm sure no shaper
  consolidation will ever happen. And that I thought was one of the goals.

Consolidation was indeed one of the goals, and I share Jiri's concern :(

