Return-Path: <netdev+bounces-219285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666D1B40E6D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6C316226F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DB2E3387;
	Tue,  2 Sep 2025 20:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143E35957;
	Tue,  2 Sep 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844179; cv=none; b=Ye/vUtDE6T+5aFvjJqLErqKNulVw5PgnZm96nKFNlEjPWi6TfoiPinRsg/K+tCVKiXKRQ3S0Boeqd/2n9VdG0NOgFmMquZfmIG61fLhZjoU9sJeCet8t7uklnoA/oWikDtzVFCVmZCczz7aTGxJ7BaqvLbqp7wmocsb3tbjmA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844179; c=relaxed/simple;
	bh=o89oG7ZhRnGTqXhrXHiO+7DL5PIT6Ag7B6Qh9ksOHnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIL1EipTbJrz3/is/xijyT/rDHMLquuqtAkkTpyhZ68YYMopP5DYxGxKLrQL61ZDJkiy1mpRm4EIEEFc1tB72OutHy3tIngEdDt68A9OsVRfqOkUvtk+eBn51RG70ixx8YDEyJqhrG+Yj7L+HnS9Qu+HTPgcJNSQFZMSZm1rJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1132254DBC3;
	Tue,  2 Sep 2025 22:16:05 +0200 (CEST)
Date: Tue, 2 Sep 2025 22:16:04 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
Message-ID: <aLdQhJoViBzxcWYE@sellars>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
X-Last-TLS-Session-Version: TLSv1.3

Hi Nik, thanks for the suggestions and review again!


On Fri, Aug 29, 2025 at 07:23:24PM +0300, Nikolay Aleksandrov wrote:
> 
> a few notes for v2:
> - please use READ/WRTE_ONCE() for variables that are used without locking

Just to understand the issue, otherwise the data path would assume
an old inactive or active state for a prolonged time after toggling?
Or what would happen?


> - please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
>   __br_multicast_stop() takes it itself

I think that's what I tried before submitting. Initially wanted
to have the locking inside, but then it would deadlock on
br_multicast_toggle()->br_multicast_open()->... as this is the one
place where br_multicast_open() is called with the multicast spinlock
already held.

On the other hand, moving the spinlock out of / around
__br_multicast_stop() would lead to a sleeping-while-atomic bug
when calling timer_delete_sync() in there. And if I were to change
these to a timer_delete() I guess there is no way to do the sync
part after unlocking? There is no equivalent to something like the
flush_workqueue() / drain_workqueue() for workqueues, but for
simple timers instead, right?

I would also love to go for the first approach, taking the
spinlock inside of __br_multicast_open(). But not quite sure how
to best and safely change br_multicast_toggle() then.


> - is the mcast lock really necessary, would atomic ops do for this tracking?

Hm, not sure. We'd be checking multiple variables before toggling
the new brmctx->ip{4,6}_active. As the checked variables can
change from multiple contexts couldn't the following happen then?


Start: ip*_active = false, snooping_enabled = false,
       vlan_snooping_enabled = true, vlan{id:42}->snooping_enabled = false

Thread A)                     Thread B)
--------------------------------------------------------------------------
                              br_multicast_toggle(br, 1, ...)
			      -> loads vlan{id:42}->snooping_enabled: false
--------------------------------------------------------------------------
br_multicast_toggle_one_vlan(vlan{id:42}, true)
-> vlan->priv_flags: set per-vlan-mc-snooping to true
-> br_multicast_update_active()
   checks snooping_enabled: false
   -> keeping vlan's ip*_active at false
--------------------------------------------------------------------------
                              -> sets snooping_enabled: true
                              -> br_multicast_update_active()
			         -> checks vlan{id:42}->snooping_enabled:
				    false (from earlier load above)
                                 -> keeping vlan's ip*_active at false

Result: vlan's ip*_active is still false even though it should be
true now?

.o(Or were netlink and sysfs handlers somehow ensured to never run in
parallel?)


I'm not that versed with atomic's and explicit memory barriers,
could that prevent something like that even if multiple variables
are involved? Only used lockless atomic_t's for atomic_inc()/_dec() so far.
And otherwise used explicit locking.



> - can you provide the full view somewhere, how would this tracking be used? I fear
>   there might still be races.

My original switchdev integration plan so far was roughly still the same
as in the previous pull-request:

https://patchwork.kernel.org/project/netdevbpf/patch/20250522195952.29265-5-linus.luessing@c0d3.blue/

And using it in rtl83xx in OpenWrt like this:
https://github.com/openwrt/openwrt/pull/18780/commits/708bbc4b73bc90cd13839c613e6634aa5faeeace#diff-b5c9a9cc66e207d77fea5d063dca2cce20cf4ae3a28fc0a5d5eebd47a024d5c3

But haven't updated these yet onto this PR, will do that later.

