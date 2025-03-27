Return-Path: <netdev+bounces-178021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77DA7405F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B777A69E1
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBD21885B4;
	Thu, 27 Mar 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaWBmrP/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FE8462
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111463; cv=none; b=e+TmHXMWOS5GWflivl8If+VEB2+SGTjLcJtlsCPlM/f7RzwY1xn+1RH8FtwmsJ/MmwWnzx7fvGOxq7OgzX723Eiqxuq7WDU/K+7QAxcw6Pwm/KRXU4rPp0dCMIH3M75bVZeV00o5teF3tWSdqKljrJwFegutdpYEYitVxC5uqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111463; c=relaxed/simple;
	bh=iEwhktkHZBi1YbymI8M7FB6QNzd6eY/5571KE08mvjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+qsKk/qTiFLD7ZfHRx0hnNHMcD7/yfw/D+6sJPP+fDLcHr4qeHxBeOGj+O3nPeJgI16wpicoZdy6n8rhD4zDwP0Wx1gbjK/U/jz5nNb/zsgPncQySE0EyUFLV8CXA6KTca9Bw9tqc3HHz2UehH6Bu6MfuNk2Iocf0lxPx0Qofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaWBmrP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F83C4CEDD;
	Thu, 27 Mar 2025 21:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111462;
	bh=iEwhktkHZBi1YbymI8M7FB6QNzd6eY/5571KE08mvjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OaWBmrP/N0WzopPe+zETzDVWsUX2zfdfRXO7+2n7gozNhAvrHajByGk+n2gZ/vjCH
	 lIAhVNVe/04KcD1jaOluxelI2YxUwBpwZc8qTdPopI/JhpwCbCoaLYZvBNjFJ8Jek+
	 pGMhlypdHzO7efFXlcmac/v3QbVDtzTsG86KqjqHNX1wH2cE0JaLdQZbvPou/2zVHT
	 BN9QclpswsgbeJzlLoUjx0uCEVvS6IdOxNzAxpB4fkvtXgubr8qAcnrUsmqfBzb0sl
	 Yc0jPpdlemLa85sncQ9dnOaSAFOj5FgnqN03/Iosdg4ccZV/az22+xjjUHerehe2UB
	 zY6VClC8xl1nQ==
Date: Thu, 27 Mar 2025 14:37:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 03/11] net: use netif_disable_lro in ipv6_add_dev
Message-ID: <20250327143741.3851f943@kernel.org>
In-Reply-To: <Z-W945lsWMmZtisy@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-4-sdf@fomichev.me>
	<20250327120225.7efd7c42@kernel.org>
	<Z-W945lsWMmZtisy@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 14:06:43 -0700 Stanislav Fomichev wrote:
> On 03/27, Jakub Kicinski wrote:
> > On Thu, 27 Mar 2025 06:56:51 -0700 Stanislav Fomichev wrote:  
> > > @@ -3151,11 +3153,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
> > >  	cfg.plen = ireq.ifr6_prefixlen;
> > >  
> > >  	rtnl_net_lock(net);
> > > -	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
> > > +	dev = netdev_get_by_index_lock(net, ireq.ifr6_ifindex);  
> > 
> > I think you want ops locking here, no?
> > netdev_get_by_index_lock() will also lock devs which didn't opt in.  
> 
> New netdev_get_by_index_lock_ops? I felt like we already have too many
> xxxdev_get_by, but agreed that it should be safer, will do!

I think we're holding rtnl_lock here, so we don't need an 
"atomic get and lock", we can stick to __dev_get_by_index()
and then lock it separately?

