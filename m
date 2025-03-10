Return-Path: <netdev+bounces-173419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF094A58BDC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32913188A194
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB45188596;
	Mon, 10 Mar 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsKJ2ex7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61914F70
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587468; cv=none; b=m77OzWQnzLHon4FwXoB20RxEZO9D1zcjCmv4ykOFpaJdHZNoxezwvABrnv3Yx96Sz2Blbv9b08K8R4UDjSYEVynScCg1f2lwHlVsmW7peF46fOJGZYKNETWBJnyVtlLlo2UXUqlvDY/sm2Pq1xe6DjfFytNNpvTNlPjk3+HlHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587468; c=relaxed/simple;
	bh=0SMNgqi3AdhAj2HFS0uNPFtaaKuHbp6KlgqwUfkemGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDvG70RQXaIlSD9jnJa+97pbSkfdnA6Z/CS43QoFKXeVhG2fdrraBX8E/l8iRqKysvx31a1VMf8vCAn8z3aJzHCrVbtnRu0Lad1/sWxjaEaMDfJIEYIqkIlv+iWgkqebaQcMc6UvVJ00J+yVmOoVFd7LiGqwzDcnNa7EN1i3Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsKJ2ex7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24026C4CEE5;
	Mon, 10 Mar 2025 06:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587468;
	bh=0SMNgqi3AdhAj2HFS0uNPFtaaKuHbp6KlgqwUfkemGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsKJ2ex7fpaSWjiqIK3UV6fTI+XSSDxySO3gxCZq6VjsiOPaGSDx4OeUmGCxzvYEv
	 fcbNWEjRLSom1rrs3I2XDB4QZ+AlsJuG6nn8lUNz5drec6WTb/tWCG8olO2kdNAPD5
	 LQMEC/L/773MhNWLWnLCz85bQ8sxIhX0yVytiLQoS0OyWWHGSp314PxVwRPOkYVuAm
	 k1ukS5lnMHcLVTJ4GKZJ451oB07dSWMacMzVATxjtXMuKzcSfu3M3ikxvuAK7aV+As
	 B4wecIdFqqlMy+q4I5+a8zMgXKFbKwdSSHTIO7Ja7w87NTXyI8zLK/loSHsKPowtoo
	 4JIUf/YhY1BpA==
Date: Mon, 10 Mar 2025 06:17:37 +0000
From: Simon Horman <horms@kernel.org>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
	jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	olteanv@gmail.com, tobias@waldekranz.com
Subject: Re: [PATCH net] net: switchdev: Convert blocking notification chain
 to a raw one
Message-ID: <20250310061737.GA4159220@kernel.org>
References: <20250305121509.631207-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305121509.631207-1-amcohen@nvidia.com>

On Wed, Mar 05, 2025 at 02:15:09PM +0200, Amit Cohen wrote:
> A blocking notification chain uses a read-write semaphore to protect the
> integrity of the chain. The semaphore is acquired for writing when
> adding / removing notifiers to / from the chain and acquired for reading
> when traversing the chain and informing notifiers about an event.
> 
> In case of the blocking switchdev notification chain, recursive
> notifications are possible which leads to the semaphore being acquired
> twice for reading and to lockdep warnings being generated [1].
> 
> Specifically, this can happen when the bridge driver processes a
> SWITCHDEV_BRPORT_UNOFFLOADED event which causes it to emit notifications
> about deferred events when calling switchdev_deferred_process().
> 
> Fix this by converting the notification chain to a raw notification
> chain in a similar fashion to the netdev notification chain. Protect
> the chain using the RTNL mutex by acquiring it when modifying the chain.
> Events are always informed under the RTNL mutex, but add an assertion in
> call_switchdev_blocking_notifiers() to make sure this is not violated in
> the future.

Hi Amit,

As you may be aware there is quite some activity to reduce the reliance on
RTNL. However, as the events in question are already protected by RTNL
I think the approach you have taken here is entirely reasonable.

> 
> Maintain the "blocking" prefix as events are always emitted from process
> context and listeners are allowed to block.
> 
> [1]:
> WARNING: possible recursive locking detected
> 6.14.0-rc4-custom-g079270089484 #1 Not tainted
> --------------------------------------------
> ip/52731 is trying to acquire lock:
> ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> but task is already holding lock:
> ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> CPU0
> ----
> lock((switchdev_blocking_notif_chain).rwsem);
> lock((switchdev_blocking_notif_chain).rwsem);
> 
> *** DEADLOCK ***
> May be due to missing lock nesting notation
> 3 locks held by ip/52731:
>  #0: ffffffff84f795b0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x727/0x1dc0
>  #1: ffffffff8731f628 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x790/0x1dc0
>  #2: ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0
> 
> stack backtrace:
> ...
> ? __pfx_down_read+0x10/0x10
> ? __pfx_mark_lock+0x10/0x10
> ? __pfx_switchdev_port_attr_set_deferred+0x10/0x10
> blocking_notifier_call_chain+0x58/0xa0
> switchdev_port_attr_notify.constprop.0+0xb3/0x1b0
> ? __pfx_switchdev_port_attr_notify.constprop.0+0x10/0x10
> ? mark_held_locks+0x94/0xe0
> ? switchdev_deferred_process+0x11a/0x340
> switchdev_port_attr_set_deferred+0x27/0xd0
> switchdev_deferred_process+0x164/0x340
> br_switchdev_port_unoffload+0xc8/0x100 [bridge]
> br_switchdev_blocking_event+0x29f/0x580 [bridge]
> notifier_call_chain+0xa2/0x440
> blocking_notifier_call_chain+0x6e/0xa0
> switchdev_bridge_port_unoffload+0xde/0x1a0
> ...
> 
> Fixes: f7a70d650b0b6 ("net: bridge: switchdev: Ensure deferred event delivery on unoffload")
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

