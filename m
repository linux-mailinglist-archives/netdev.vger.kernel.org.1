Return-Path: <netdev+bounces-181597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DAA85A17
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1D1BA38B2
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBB17D2;
	Fri, 11 Apr 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9oC6gpn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B855278E51
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367649; cv=none; b=FnF60zlZWRQ3wjliJC9U050hyYA4IIYTzT9kPdoMcIInjnP6jV4wRdrvBcMQyek4RhZ5KmYfKHJv2xoVRr+QuC4pRNaF12QmOVRemlpxwEK/D8bnFptg2zovm7Ho/8+YNeZSWlzevwdZ+vlcRPDiOZpYz2YhfY2+dNavwaFnvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367649; c=relaxed/simple;
	bh=6o92jC9swnpSd0EXL3URyIIGVULDuxwQJCe4pRKoIbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyljywterZpOE067/15Wh3aJ4zmj4WWsgsTqtipr1YmkDJmfltJh0vVgcQhIlU2DzTR/aCtLn89anfaolVd3opM56+JX6TbDxVrMWjIS4C4BLeFV1OfvklK3VRGAxBvM9KrexI4HGnQiLTAZTS0UKmyhW8vh5YeDsAm5Jd79hGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9oC6gpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F4C4CEE2;
	Fri, 11 Apr 2025 10:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367648;
	bh=6o92jC9swnpSd0EXL3URyIIGVULDuxwQJCe4pRKoIbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9oC6gpnRCJZKPgPJ0UWl16wBVVNfMEe9+i+UsM6yesv4nAZpjxib6isBO9tKyy6z
	 qlgIzafNdIuLH7J2pYBLy2q5QCth0+Q7gOxMGDp/QR5IHcVj+bzUnmjQOTt0zsUbm1
	 09ZyTOpdmeju1t6xW0UYbqOqZ+as+7dAJCFYd8oQyaNRqoxO33Q4522ujV8EPpR4hF
	 KIW/Qeu+xWbCi3pmq3B7/YrCuZJVjO+cgI3NGC5LOd5HVVHm0DVgIjvZtGf2x7STGg
	 BqRwQO8edfdBSY/e5kNj0pkWf6lFL7kWGhCjhfkE1LgqebZcyOcpobBM/PpPvG5DWG
	 oTWIIZEqnDDsQ==
Date: Fri, 11 Apr 2025 11:34:04 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 10/14] ipv6: Factorise
 ip6_route_multipath_add().
Message-ID: <20250411103404.GY395307@horms.kernel.org>
References: <20250409011243.26195-1-kuniyu@amazon.com>
 <20250409011243.26195-11-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409011243.26195-11-kuniyu@amazon.com>

On Tue, Apr 08, 2025 at 06:12:18PM -0700, Kuniyuki Iwashima wrote:
> We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT and rely
> on RCU to guarantee dev and nexthop lifetime.
> 
> Then, the RCU section will start before ip6_route_info_create_nh()
> in ip6_route_multipath_add(), but ip6_route_info_create() is called
> in the same loop and will sleep.
> 
> Let's split the loop into ip6_route_mpath_info_create() and
> ip6_route_mpath_info_create_nh().
> 
> Note that ip6_route_info_append() is now integrated into
> ip6_route_mpath_info_create_nh() because we need to call different
> free functions for nexthops that passed ip6_route_info_create_nh().
> 
> In case of failure, the remaining nexthops that ip6_route_info_create_nh()
> has not been called for will be freed by ip6_route_mpath_info_cleanup().
> 
> OTOH, if a nexthop passes ip6_route_info_create_nh(), it will be linked
> to a local temporary list, which will be spliced back to rt6_nh_list.
> In case of failure, these nexthops will be released by fib6_info_release()
> in ip6_route_multipath_add().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/route.c | 205 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 130 insertions(+), 75 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c

...

> +static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct rt6_nh *nh, *nh_next, *nh_tmp;
> +	LIST_HEAD(tmp);
> +	int err;
> +
> +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> +		struct fib6_info *rt = nh->fib6_info;
> +
> +		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
> +		if (err) {
> +			nh->fib6_info = NULL;
> +			goto err;
> +		}
> +
> +		rt->fib6_nh->fib_nh_weight = nh->weight;
> +
> +		list_move_tail(&nh->next, &tmp);
> +
> +		list_for_each_entry(nh_tmp, rt6_nh_list, next) {
> +			/* check if fib6_info already exists */
> +			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
> +				err = -EEXIST;
> +				goto err;
> +			}
> +		}
> +	}
> +out:
> +	list_splice(&tmp, rt6_nh_list);
> +	return err;

Hi Kuniyuki-san,

Perhaps it can't happen in practice, but if the loop above iterates zero
times then err will be used uninitialised. As it's expected that err is 0
here, perhaps it would be simplest to just:

	return 0;

> +err:
> +	ip6_route_mpath_info_cleanup(rt6_nh_list);
> +	goto out;
>  }

...

