Return-Path: <netdev+bounces-206348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5AB02B94
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB41890AFF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F051E5729;
	Sat, 12 Jul 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkJlSfEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFB199938
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332523; cv=none; b=iVlNqA6KHFNAPvHOAAwVcb2UWhmGDK0H7KBgTaFC2fYwhyKOOoXjqg/zGC9Xz3VhBi3xk/SriNUwp4IcTEq2A+mcud8PwQYSNCs1UmJqM9gCBKxZHCVNwbHstLOtAIPtcg4UL6J3GZ/Ue+zhy8EUTb6BSNg47hg20gNcwNZn7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332523; c=relaxed/simple;
	bh=tUiDokgQ19BxaHCRAN63nONGsIGhjYXRPqYVX4P57dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fyym1AqSv8PtdOrxPUKJ0k/cmMrv4Zh4sMZN1ksBoROgCJNYBoE/yFWXqj+k6TsjpxiNkWCCKghjbTqe6sQ6pW9ghjGc3G+xr1T52N1lV6vmcGt3dY1AdIjx0kfrUaEEb43o1wFJQ2nix/2U7KhB/BTFFSwQPpqB0zI5FtLT/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkJlSfEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE4CC4CEEF;
	Sat, 12 Jul 2025 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752332522;
	bh=tUiDokgQ19BxaHCRAN63nONGsIGhjYXRPqYVX4P57dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkJlSfEUK/dVqJXXRrT39VLWoPSqCiwHlkgR7HPnY2wok6OIM+VTuvSHkvUTVHWOV
	 9gR5vEnl+qIU0QHw5dOM17jw17A+Ws4jA1Os+kHTzPZlp3ISE3lJFPSJtRItFyZjiZ
	 ZbKTWftglxoXGYXN7utWKnfxZqAidZ2lsk3JMFbRx7S8JEMFOvPvT0Jti0tkQrNtyB
	 ToFW8Twz368rQNPOK1ifiSxYOPQIdW0h7PrJ8Ws1XMeaehilnC6Yw9+CMviHAi1Fq9
	 tlGa2mprmN3kfPyaCUpt8x0eysaxTIKBxgvz0hICnL/KfDGViCopQWoppHLNd2E+wQ
	 NYhtoCs66IX9g==
Date: Sat, 12 Jul 2025 16:01:59 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU
 grace period.
Message-ID: <20250712150159.GD721198@horms.kernel.org>
References: <20250711191007.3591938-1-kuniyu@google.com>
 <20250711191007.3591938-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711191007.3591938-7-kuniyu@google.com>

On Fri, Jul 11, 2025 at 07:06:11PM +0000, Kuniyuki Iwashima wrote:
> We will convert RTM_GETNEIGH to RCU.
> 
> neigh_get() looks up pneigh_entry by pneigh_lookup() and passes
> it to pneigh_fill_info().
> 
> Then, we must ensure that the entry is alive till pneigh_fill_info()
> completes, but read_lock_bh(&tbl->lock) in pneigh_lookup() does not
> guarantee that.
> 
> Also, we will convert all readers of tbl->phash_buckets[] to RCU.
> 
> Let's use call_rcu() to free pneigh_entry and update phash_buckets[]
> and ->next by rcu_assign_pointer().
> 
> pneigh_ifdown_and_unlock() uses list_head to avoid overwriting
> ->next and moving RCU iterators to another list.
> 
> pndisc_destructor() (only IPv6 ndisc uses this) uses a mutex, so it
> is not delayed to call_rcu(), where we cannot sleep.  This is fine
> because the mcast code works with RCU and ipv6_dev_mc_dec() frees
> mcast objects after RCU grace period.
> 
> While at it, we change the return type of pneigh_ifdown_and_unlock()
> to void.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/neighbour.h |  4 ++++
>  net/core/neighbour.c    | 51 +++++++++++++++++++++++++----------------
>  2 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 7f3d57da5689a..a877e56210b22 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -180,6 +180,10 @@ struct pneigh_entry {
>  	possible_net_t		net;
>  	struct net_device	*dev;
>  	netdevice_tracker	dev_tracker;
> +	union {
> +		struct list_head	free_node;
> +		struct rcu_head		rcu;
> +	};
>  	u32			flags;
>  	u8			protocol;
>  	bool			permanent;
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 814a45fb1962e..6725a40b2db3a 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -54,9 +54,9 @@ static void neigh_timer_handler(struct timer_list *t);
>  static void __neigh_notify(struct neighbour *n, int type, int flags,
>  			   u32 pid);
>  static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
> -static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> -				    struct net_device *dev,
> -				    bool skip_perm);
> +static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> +				     struct net_device *dev,
> +				     bool skip_perm);
>  
>  #ifdef CONFIG_PROC_FS
>  static const struct seq_operations neigh_stat_seq_ops;
> @@ -803,12 +803,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
>  
>  	write_lock_bh(&tbl->lock);
>  	n->next = tbl->phash_buckets[hash_val];
> -	tbl->phash_buckets[hash_val] = n;
> +	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);

Hi Iwashima-san,

A heads-up that unfortunately Sparse is unhappy about the __rcu annotations
here, and elsewhere in this patch (set).

For this patch I see:

  .../neighbour.c:860:33: error: incompatible types in comparison expression (different address spaces):
  .../neighbour.c:860:33:    struct pneigh_entry [noderef] __rcu *
  .../neighbour.c:860:33:    struct pneigh_entry *
  .../neighbour.c:806:9: error: incompatible types in comparison expression (different address spaces):
  .../neighbour.c:806:9:    struct pneigh_entry [noderef] __rcu *
  .../neighbour.c:806:9:    struct pneigh_entry *
  .../neighbour.c:832:25: error: incompatible types in comparison expression (different address spaces):
  .../neighbour.c:832:25:    struct pneigh_entry [noderef] __rcu *
  .../neighbour.c:832:25:    struct pneigh_entry *

...

-- 
pw-bot: changes-requested

