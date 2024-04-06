Return-Path: <netdev+bounces-85455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5F89ACC6
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2256F1C20B7F
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90C4D9EA;
	Sat,  6 Apr 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdsYtg3J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F424D5A3
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712433087; cv=none; b=HPWW1C6kZxikSX5Ll+ADH1Gf4ZClqDbVSC3ReV8C7dleAEpVEEKQPAugITnTr/ZYUu9/3KHHXqjwqW1aeCYxvRwBuHyXkJeqKJsOTJPrz78ZxHlNnl4GHVYxzpVg7HjjNcsvGIOPFOzPO9ICCYluVS2qZaKecM/tSUcnU/GS/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712433087; c=relaxed/simple;
	bh=SD4Q0FzjXjVuu43U/yA+RYcyGNxFNToHauBQjptqTMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmL47kBHaYnFPCBMkV57Ot19WQbleL2j57uO2aE3IklVCebR8yS29u6G5KejyKVkoyhkWpL/g/cI6KQtBca06Z5Sf/w3mPpZ3wWk/l2yexmorGc6bqYCrhLIiw5GY9GvsNjpiFBAhPLLbELw/WpwgKTZnXrWt7slrKpNPSEWWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdsYtg3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C56C433C7;
	Sat,  6 Apr 2024 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712433087;
	bh=SD4Q0FzjXjVuu43U/yA+RYcyGNxFNToHauBQjptqTMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdsYtg3J/CqTDfc9HoImK6pH+f8QTQ33gXFlmxAR/gN0FK3bPfuTFNBSB/8gTp+x1
	 g/E1dSl1APpDtbd0NADEgKHszjNg+8VXx1Xn0CfVKoDhsYy4ltiVg052ZGSJaoZYdv
	 KTOLxkqG8D8w4wzZOB3l3w2rUbU69hsUvH59Z+YCI9IpOWVCEnt0priLOkZ55dFBzS
	 XYL936SCtyP1sIhzfJn0FU5CBvy7+BnWtH3ci523pMsCJCrTEfWmNHSEiAWIgEJtvy
	 X2rpL2t4ltvHoCbDgCaUsquDYpYPXN1QcYtZcjSi4qL9AYbobw0jSpB1lCHSLTEGPL
	 ko4G5y8qrt/BA==
Message-ID: <de514556-a86b-4bb4-b317-a3b29188e6e3@kernel.org>
Date: Sat, 6 Apr 2024 13:51:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix race condition between ipv6_get_ifaddr and
 ipv6_del_addr
Content-Language: en-US
To: Jiri Benc <jbenc@redhat.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 4:54 AM, Jiri Benc wrote:
> Although ipv6_get_ifaddr walks inet6_addr_lst under the RCU lock, it
> still means hlist_for_each_entry_rcu can return an item that got removed
> from the list. The memory itself of such item is not freed thanks to RCU
> but nothing guarantees the actual content of the memory is sane.
> 
> In particular, the reference count can be zero. This can happen if
> ipv6_del_addr is called in parallel. ipv6_del_addr removes the entry
> from inet6_addr_lst (hlist_del_init_rcu(&ifp->addr_lst)) and drops all
> references (__in6_ifa_put(ifp) + in6_ifa_put(ifp)). With bad enough
> timing, this can happen:
> 
> 1. In ipv6_get_ifaddr, hlist_for_each_entry_rcu returns an entry.
> 
> 2. Then, the whole ipv6_del_addr is executed for the given entry. The
>    reference count drops to zero and kfree_rcu is scheduled.
> 
> 3. ipv6_get_ifaddr continues and increments the reference count
>    (in6_ifa_hold).
> 
> 4. The rcu is unlocked and the entry is freed.
> 
> 5. Later, the reference count is dropped to zero (again) and kfree_rcu
>    is scheduled (again).
> 
> Prevent increasing of the reference count in such case. The name
> in6_ifa_hold_safe is chosen to mimic the existing fib6_info_hold_safe.
> 
> Fixes: 5c578aedcb21d ("IPv6: convert addrconf hash list to RCU")
> Signed-off-by: Jiri Benc <jbenc@redhat.com>
> ---
> 
> Side note: While this fixes one bug, there may be more locking bugs
> lurking aroung inet6_ifaddr. The semantics of locking of inet6_ifaddr is
> wild and fragile. Some of the fields are freed in ipv6_del_addr and
> guarded by ifa->state == INET6_IFADDR_STATE_DEAD and RTNL. Some of the
> fields are freed in inet6_ifa_finish_destroy and guarded by ifa->refcnt
> and RCU. Needless to say, this semantics is undocumented. Worse,
> ifa->state guard may not be enough. For example, ipv6_get_ifaddr can
> still return an entry that proceeded through ipv6_del_addr, which means
> ifa->state is INET6_IFADDR_STATE_DEAD. However, at least some callers
> (e.g. ndisc_recv_ns) seem to change ifa->state to something else. As
> another example, ipv6_del_addr relies on ifa->flags, which are changed
> throughout the code without RTNL. All of this may be okay but it's far
> from clear.
> ---
>  include/net/addrconf.h | 4 ++++
>  net/ipv6/addrconf.c    | 7 ++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>


