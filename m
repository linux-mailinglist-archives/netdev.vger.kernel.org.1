Return-Path: <netdev+bounces-205998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B3B0108E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9805C1936
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3A46447;
	Fri, 11 Jul 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGUNVeLM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B373A1B6;
	Fri, 11 Jul 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195842; cv=none; b=PVHcN7AHgwz7h3mCE77x6SgHATC4v0/0Sf7mUGKcXYZOzAhNxxy3KkutgR9JsnRyQY28ZazwmncUJpRvVJ7bg0tg6BSE2UAlWgBHz5m5J0+2oherDza2lzMWA1oUGicPuUDusDdjyInaVsDzWWEvKeC2yIu3T54eiYN8xr4zw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195842; c=relaxed/simple;
	bh=iMAAkWvqir9PO2U6AoWLhY3TnktwSdRhH6L3AJVP0Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If+vIJKkot/bMl+GzXXLhiIL+eyBG9V1r5HZVPZbQDKUvVo+/4ftIfHVF8w/tvnv2CBwOpQtdVtiMGPPUK/VPHxwwHfPv2VT27PWAPLj7KYl0KSQFoSD7HLGeuB8QKsD1BuFgS64vH2MK+yAj1hDguon5UnFHi5g7GoJYGAkY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGUNVeLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C07C4CEE3;
	Fri, 11 Jul 2025 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195841;
	bh=iMAAkWvqir9PO2U6AoWLhY3TnktwSdRhH6L3AJVP0Og=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WGUNVeLMo2V/NqP+Lh0RR/Fey+SSipVV0LvRRN7nAyZVNoQem+VTJU0THlgbPBcny
	 6h/74641rTHYdTejMap2giXNRC6ep2eb0UqicxH/BKJf7OzqF3rw9L3dxkPB3OOax1
	 buVMq5zGdUX7B3d6cmuuUE2zsabj+PWQg7ddzZdeCJ0cC8zyIKfp9IdrFjeeA6IEeM
	 lzdY4GpV4y3WlxHOUvdHUTzQrFBS8Vs+dN9GznwHA1s6Ad+OIOSFU3k0WMAaWnGvDx
	 glBnShXIH/3T0+X0+MwZJDF1Kn9dkCWmcnHP8d2Y10ILrNU2bjBSL3BfbNsBa4qVdg
	 OLcKtUgEcCz7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6309ACE0A44; Thu, 10 Jul 2025 18:04:01 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:04:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] locking/lockdep: Use shazptr to protect the key
 hashlist
Message-ID: <06bf79cc-bd0d-487c-bcde-44464d17225d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <20250414060055.341516-9-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-9-boqun.feng@gmail.com>

On Sun, Apr 13, 2025 at 11:00:55PM -0700, Boqun Feng wrote:
> Erik Lundgren and Breno Leitao reported [1] a case where
> lockdep_unregister_key() can be called from time critical code pathes
> where rntl_lock() may be held. And the synchronize_rcu() in it can slow
> down operations such as using tc to replace a qdisc in a network device.
> 
> In fact the synchronize_rcu() in lockdep_unregister_key() is to wait for
> all is_dynamic_key() callers to finish so that removing a key from the
> key hashlist, and we can use shazptr to protect the hashlist as well.
> 
> Compared to the proposed solution which replaces synchronize_rcu() with
> synchronize_rcu_expedited(), using shazptr here can achieve the
> same/better synchronization time without the need to send IPI. Hence use
> shazptr here.
> 
> Reported-by: Erik Lundgren <elundgren@meta.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Link: https://lore.kernel.org/lkml/20250321-lockdep-v1-1-78b732d195fb@debian.org/
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

From an RCU and shazptr viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/locking/lockdep.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 58d78a33ac65..c5781d2dc8c6 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -58,6 +58,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/console.h>
>  #include <linux/kasan.h>
> +#include <linux/shazptr.h>
>  
>  #include <asm/sections.h>
>  
> @@ -1265,14 +1266,18 @@ static bool is_dynamic_key(const struct lock_class_key *key)
>  
>  	hash_head = keyhashentry(key);
>  
> -	rcu_read_lock();
> +	/* Need preemption disable for using shazptr. */
> +	guard(preempt)();
> +
> +	/* Protect the list search with shazptr. */
> +	guard(shazptr)(hash_head);
> +
>  	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>  		if (k == key) {
>  			found = true;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
>  
>  	return found;
>  }
> @@ -6614,7 +6619,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  
>  	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> -	synchronize_rcu();
> +	synchronize_shazptr(keyhashentry(key));
>  }
>  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>  
> -- 
> 2.47.1
> 

