Return-Path: <netdev+bounces-85203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11EC899BE2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108C81C20A55
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411D16C457;
	Fri,  5 Apr 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9UjcH8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FE2032D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316718; cv=none; b=EJQUJx8R3ouaXABKH+zUlaQGKJCmWJhLjoqWMbtnyDsgVmEcQ+4oQJ0QY2J/LFUwrVObcplU1Lv8ZUy4MALEUyMlPYGWZrwgAhRCjzfG2A8N41/6WdL5mB5QEQa2Oxt+W0UMbEgoi9lCZ4rbjCLRQ7pugPgbZ6Vd3jFP89VvEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316718; c=relaxed/simple;
	bh=auQbLtVSNRBJEra15dpInE1MVd6NBYbQP6JOLISq33c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+TOmuJ4ddY/ikrAAbai3XRkefd0ri3/QIo5/iv4/aT5TiqmnTxmZc6Vj9H67cf5kVoD+uiZCvUkG9jwfo4D12WBCXRnf0NclFRoEf5+1MYmw2ixLisv0UXzcg1bUfvjF+32PFBCyMk4vYAsW0n820M2fU0UIr2tqbVDt/RoRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9UjcH8Z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d84a5f4a20so4549921fa.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712316714; x=1712921514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yw5RKrZdUi4tuw82iBlrxT24MUPm/UOqHz9cTZxXgtw=;
        b=k9UjcH8ZlVjXkYd7M3tnJSk/fD+aRS0JZJG88SwLtPqt8HeaCS77tBZFQAJLpnkMPd
         zRY90IZfuFjLhAE9a1tN066qSZEuAuN4JgKIDL3n53KjpzW/AfeJVof2ZoCGeF3fHlyI
         2bb/5dFVkGBjbAdGlu/aaBCavEJ+0tFvNOffEqdhKyBlydFYJKHDUE+dhHt+CW9MhJQx
         7bd7smpo7zuZN58+/HmxkzwL5JQOcYLbYvaUmKjhD9uhjH/MM/wKddg6p8JfqDqZT2be
         H2Nx0hkggOQAOZMDdMiTdXn8TjPAdXIFR1t1zCPe67UkFVSLMKV1nPEDqk9IHIf9oEJW
         263Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712316714; x=1712921514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yw5RKrZdUi4tuw82iBlrxT24MUPm/UOqHz9cTZxXgtw=;
        b=sbt7/B/5b9KlgKJ5ayHvsjYzP2zYgxwCODmMiOCIEI8cPszJOtOrTKiKwkQ9FDde6H
         MSp5T74N1pbre/nwqY4C/v5FSLekgQ8wy7Y0l6x2ZiO5f6NZ68UxV4jZKTic3hYbmR/W
         ggVv0TQVla1vhepFDv9dWY3BccIqKttpnMJi9z+yOcuLP+9jBcb+xkRPg++Y7s6nfI8d
         LcIBO/zwOq4kIKvJKech8Sie1/Ia0xUk1/mS202E+vZ4q89OaXdAzSZXo0EM3SykLMFu
         8fQgG01A+DkKHsua4m5O3mIq5hOk/QsfKvh26T8V+2jyAXq4t2DJsVnXhDjKXFsmK1h9
         5NRg==
X-Forwarded-Encrypted: i=1; AJvYcCVFX4wjdm/QyV1Vi9NxPmjFNjOf8e50uVxcI/6OpWxXa3QiU0hSNp/Ona5FyBBFikrQH9trvVHOGEBVwuKwL65RidfbwuPS
X-Gm-Message-State: AOJu0YwbWkyzL8n1vDMXxgsyKrremti1RlAz94Qc7twrl9f7LxtyqxzF
	Yak69fCYFlijlrFqzp6gYe1nh+bml0nmKu7TtkJQVIqT0az/mWrs
X-Google-Smtp-Source: AGHT+IGzjUcr9qgHN/EVSlAUf2F4F4wqNnbUJu7LshCbWcWNdRSVbXD98iNecVhGHoIEuYTHJU/QsA==
X-Received: by 2002:a2e:b00a:0:b0:2d8:5af8:84c0 with SMTP id y10-20020a2eb00a000000b002d85af884c0mr875875ljk.5.1712316714217;
        Fri, 05 Apr 2024 04:31:54 -0700 (PDT)
Received: from [10.0.0.4] ([37.174.58.205])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00343e5f3a3e2sm1405673wrj.19.2024.04.05.04.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:31:53 -0700 (PDT)
Message-ID: <3e90336c-6859-474c-aa1e-01ccc665ad49@gmail.com>
Date: Fri, 5 Apr 2024 13:31:52 +0200
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
To: Jiri Benc <jbenc@redhat.com>, netdev@vger.kernel.org, edumazet@google.com
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@kernel.org>
References: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <8bbe1218656e66552ff28cbee8c7d1f0ffd8e9fd.1712314149.git.jbenc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/5/24 12:54, Jiri Benc wrote:
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
>     reference count drops to zero and kfree_rcu is scheduled.
>
> 3. ipv6_get_ifaddr continues and increments the reference count
>     (in6_ifa_hold).
>
> 4. The rcu is unlocked and the entry is freed.
>
> 5. Later, the reference count is dropped to zero (again) and kfree_rcu
>     is scheduled (again).

refcount_t semantic should prevent this double transition to 0  ?

Can you include a stack trace in the changelog ?

Otherwise patch looks good to me, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>


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
>   include/net/addrconf.h | 4 ++++
>   net/ipv6/addrconf.c    | 7 ++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 9d06eb945509..62a407db1bf5 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -438,6 +438,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
>   	refcount_inc(&ifp->refcnt);
>   }
>   
> +static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
> +{
> +	return refcount_inc_not_zero(&ifp->refcnt);
> +}
>   
>   /*
>    *	compute link-local solicited-node multicast address
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 92db9b474f2b..779aa6ecdd49 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2091,9 +2091,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
>   		if (ipv6_addr_equal(&ifp->addr, addr)) {
>   			if (!dev || ifp->idev->dev == dev ||
>   			    !(ifp->scope&(IFA_LINK|IFA_HOST) || strict)) {
> -				result = ifp;
> -				in6_ifa_hold(ifp);
> -				break;
> +				if (in6_ifa_hold_safe(ifp)) {
> +					result = ifp;
> +					break;
> +				}
>   			}
>   		}
>   	}

