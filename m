Return-Path: <netdev+bounces-105501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD84911850
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F27283FB1
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91582891;
	Fri, 21 Jun 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmC2vWes"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655B2904
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935910; cv=none; b=Pzf01BCqbZ5Z49zoM00zrHJRDflrPfHKDByhubCu/5FBcS/r9kwQWzY4wgBtV0S1NMtvOOIKzLXXUuABMgoVRUSWUhXhmtt1T6q61HzTudIymKV4b/H25oKZs/hUjyNoonc+BvuYCLugnVmILFB3TzAcdObGVnn6PGqI2/ycdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935910; c=relaxed/simple;
	bh=/ddf1z+uFkysFZT1lAWh3i8QxvxpBEf1hviYmtzVWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGY7BRgPU8Naji8eo8OWP5ILMzflZLjueky09LyhOgFeLLIcSc2nzH9XgzMFHYpJX5390VXIeXjzlcQr2LgzDEl9DBxWqWTjgXJ9z7MhzHZ6b+33grWkAjaZyvQ6M91dEzZxo0VdAANx3E8JYvvcAYJeTLsTDnlsz67pRvGX/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmC2vWes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BEDC2BD10;
	Fri, 21 Jun 2024 02:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718935909;
	bh=/ddf1z+uFkysFZT1lAWh3i8QxvxpBEf1hviYmtzVWUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmC2vWesk7tQ7Duojw2ELxw3dau5bBzkNWrYEwektg0RGwKRgv3i2DOEC6935fXm0
	 Rh/PN/NXgy8iH9Z4epJ2po/1smG9VIHBQ+2NyEARK02MSpINFPWcPpLo0p0GgG48vy
	 Hu0npPNWayZ/XgrcpgOP7iNsQtXU4llPlpVxbYm4hZtFGTuSFsb5j6cITcNHHtIkML
	 t6nFwDLtOO8YI9LbWfgUHLRPdEoWfjb1oL1k5g4TF4wJdMbAUVfMciJWpkoNYSgfNp
	 lhid8/SKO2B/qWgmoqOwbfZRGEy352/N95sInFxABJ4BoEJsMDf9u/W36W6uEg1GrS
	 2HUambGtGlwbw==
Date: Thu, 20 Jun 2024 19:11:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Ziwei Xiao
 <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn
 <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>, Shailend Chand
 <shailend@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/6] net: ethtool: perform pm duties outside of
 rtnl lock
Message-ID: <20240620191148.26fc09ac@kernel.org>
In-Reply-To: <48ac02dc-001e-48e3-ba87-8c4397bf7430@lunn.ch>
References: <20240620114711.777046-1-edumazet@google.com>
	<20240620114711.777046-4-edumazet@google.com>
	<20240620172235.6e6fd7a5@kernel.org>
	<48ac02dc-001e-48e3-ba87-8c4397bf7430@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 02:59:54 +0200 Andrew Lunn wrote:
> > I also keep wondering whether we shouldn't use this as an opportunity
> > to introduce a "netdev instance lock". I think you mentioned we should
> > move away from rtnl for locking ethtool and ndos since most drivers
> > don't care at all about global state. Doing that is a huge project, 
> > but maybe this is where we start?  
> 
> Is there much benefit to the average system?
> 
> Embedded systems typically have 1 or 2 netdevs. Laptops, desktops and
> the like have one, maybe two netdevs. VMs typically have one netdev.
> So we are talking about high end switches with lots of ports and
> servers hosting lots of VMs. So of the around 500 netdev drivers we
> have, only maybe a dozen drivers would benefit?
> 
> It seems unlikely those 500 drivers will be reviewed and declared safe
> to not take RTNL. So maybe a better way forward is that struct
> ethtool_ops gains a flag indicating its ops can be called without
> first talking RTNL. Somebody can then look at those dozen drivers, and
> we leave the other 490 alone and don't need to worry about
> regressions.

Right, we still need an opt in.

My question is more whether we should offer an opt out from rtnl_lock,
and beyond that driver is on its own (which reviewing the driver code
- I believe will end pretty badly), or to also offer a per-netdev
instance lock. Give the drivers a choice:
 - rtnl
 - netdev_lock(dev)
 - (my least preferred) nothing.

The netdev lock would also be useful for things like napi and queue
stats, RSS contexts, and whatever else we add for drivers in the core.
For NAPI / queue info via netlink we currently require rtnl_lock,
taking a global lock to access a couple of per-netdevs structs feels
quite wasteful :(

