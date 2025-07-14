Return-Path: <netdev+bounces-206626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CEAB03CB8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286A04A642C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB723B63C;
	Mon, 14 Jul 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6d6YQNF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B745009
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490577; cv=none; b=rXAuRlGtZMhDgq3DvTo5rftDbuKTW4stPd1XFh3tYOk9t5hn4zm/gCLT9fnwkBLX+Neg3KWrPL5cabH3+Lr0aRO+eTuROWKUaElcp050XlDONgSqfdVDl/Gv/sB3YrXD8HRe89wRagU6KgzJBtp0Hnd1TbbC8UOUHEOeZyjWEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490577; c=relaxed/simple;
	bh=bbsqVpZCExhifOmFIlMluL8X2A1wq02Pvz4bGggDqzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmhsj9XUH7YsKLbv+RXtL1uNkz1klN/5NmQ9pApoi86SXbAPCi5GxbzTG6PkkDUqVp/pfWaqvQrjpbzakBPrDXgCnpyKEuIMtT/r97bEM6+bcsFIoxE2mrEwLLsfoWfuO9mgfwbpk43TIS0LXWMfope9S7sCmLfXaxAJl/79Jg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6d6YQNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133E9C4CEED;
	Mon, 14 Jul 2025 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752490575;
	bh=bbsqVpZCExhifOmFIlMluL8X2A1wq02Pvz4bGggDqzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6d6YQNFHDtOxdynNngrkwfZc89jNsET+ByYVSXDcn8EoDLXsCDhjMrLkM4JGyMte
	 ZGuYU4T/A+VSX0iMjV+p/mHhAZHG+U26DEVnsv/L29+2b/Bbw639T3+Efd41Qd9cZ0
	 uSucwWT0nCEGCWZsu1X34HKcplUBp0VING6+tvmGasjiZPjD/uK1gA0YRayH0SsAc2
	 0BmmoGgyzgJMNx9tKYHLPfOeMx7GEDfzzAFtzDtgIsCHViyFtdbM9Jhgm5iSlbglnt
	 Gkw1uDFrTV4M5qwfBMCsuMGYpZ/SY7gPM3K3tyWsnq+uY6I8zGaRZNdMUOG8/bBMqR
	 ydS+VEkwm+t3A==
Date: Mon, 14 Jul 2025 11:56:11 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU
 grace period.
Message-ID: <20250714105611.GH721198@horms.kernel.org>
References: <20250712150159.GD721198@horms.kernel.org>
 <20250712180816.3987876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712180816.3987876-1-kuniyu@google.com>

On Sat, Jul 12, 2025 at 06:07:51PM +0000, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Sat, 12 Jul 2025 16:01:59 +0100
> > On Fri, Jul 11, 2025 at 07:06:11PM +0000, Kuniyuki Iwashima wrote:
> > > We will convert RTM_GETNEIGH to RCU.
> > > 
> > > neigh_get() looks up pneigh_entry by pneigh_lookup() and passes
> > > it to pneigh_fill_info().
> > > 
> > > Then, we must ensure that the entry is alive till pneigh_fill_info()
> > > completes, but read_lock_bh(&tbl->lock) in pneigh_lookup() does not
> > > guarantee that.
> > > 
> > > Also, we will convert all readers of tbl->phash_buckets[] to RCU.
> > > 
> > > Let's use call_rcu() to free pneigh_entry and update phash_buckets[]
> > > and ->next by rcu_assign_pointer().
> > > 
> > > pneigh_ifdown_and_unlock() uses list_head to avoid overwriting
> > > ->next and moving RCU iterators to another list.
> > > 
> > > pndisc_destructor() (only IPv6 ndisc uses this) uses a mutex, so it
> > > is not delayed to call_rcu(), where we cannot sleep.  This is fine
> > > because the mcast code works with RCU and ipv6_dev_mc_dec() frees
> > > mcast objects after RCU grace period.
> > > 
> > > While at it, we change the return type of pneigh_ifdown_and_unlock()
> > > to void.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > >  include/net/neighbour.h |  4 ++++
> > >  net/core/neighbour.c    | 51 +++++++++++++++++++++++++----------------
> > >  2 files changed, 35 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> > > index 7f3d57da5689a..a877e56210b22 100644
> > > --- a/include/net/neighbour.h
> > > +++ b/include/net/neighbour.h
> > > @@ -180,6 +180,10 @@ struct pneigh_entry {
> > >  	possible_net_t		net;
> > >  	struct net_device	*dev;
> > >  	netdevice_tracker	dev_tracker;
> > > +	union {
> > > +		struct list_head	free_node;
> > > +		struct rcu_head		rcu;
> > > +	};
> > >  	u32			flags;
> > >  	u8			protocol;
> > >  	bool			permanent;
> > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > index 814a45fb1962e..6725a40b2db3a 100644
> > > --- a/net/core/neighbour.c
> > > +++ b/net/core/neighbour.c
> > > @@ -54,9 +54,9 @@ static void neigh_timer_handler(struct timer_list *t);
> > >  static void __neigh_notify(struct neighbour *n, int type, int flags,
> > >  			   u32 pid);
> > >  static void neigh_update_notify(struct neighbour *neigh, u32 nlmsg_pid);
> > > -static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> > > -				    struct net_device *dev,
> > > -				    bool skip_perm);
> > > +static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
> > > +				     struct net_device *dev,
> > > +				     bool skip_perm);
> > >  
> > >  #ifdef CONFIG_PROC_FS
> > >  static const struct seq_operations neigh_stat_seq_ops;
> > > @@ -803,12 +803,20 @@ struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
> > >  
> > >  	write_lock_bh(&tbl->lock);
> > >  	n->next = tbl->phash_buckets[hash_val];
> > > -	tbl->phash_buckets[hash_val] = n;
> > > +	rcu_assign_pointer(tbl->phash_buckets[hash_val], n);
> > 
> > Hi Iwashima-san,
> > 
> > A heads-up that unfortunately Sparse is unhappy about the __rcu annotations
> > here, and elsewhere in this patch (set).
> > 
> > For this patch I see:
> > 
> >   .../neighbour.c:860:33: error: incompatible types in comparison expression (different address spaces):
> >   .../neighbour.c:860:33:    struct pneigh_entry [noderef] __rcu *
> >   .../neighbour.c:860:33:    struct pneigh_entry *
> >   .../neighbour.c:806:9: error: incompatible types in comparison expression (different address spaces):
> >   .../neighbour.c:806:9:    struct pneigh_entry [noderef] __rcu *
> >   .../neighbour.c:806:9:    struct pneigh_entry *
> >   .../neighbour.c:832:25: error: incompatible types in comparison expression (different address spaces):
> >   .../neighbour.c:832:25:    struct pneigh_entry [noderef] __rcu *
> >   .../neighbour.c:832:25:    struct pneigh_entry *
> 
> Thanks for heads-up, Simon!
> 
> This diff below was needed on top of the series, but as I gradually added
> rcu_derefernece_check(), probably I need to churn this patch 6 more.
> 
> Anyway, I'll fix every annotation warning in v2.

Thanks Iwashima-san,

This approach looks good to me.
And, likewise, v2 looks good wrt annotation warnings.

