Return-Path: <netdev+bounces-177063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F8A6D9E2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AC51886A9C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813C25E45F;
	Mon, 24 Mar 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGBpsrMk"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945628E7;
	Mon, 24 Mar 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818332; cv=none; b=P6bmVMRU28SYmh+bkRL6ecV7hrw9EHb+6A64jlBklpc+cC8mnBcbIacltthFdsr765qY383vjeLD7TkwdfCuXZ9GKXCYXKMzcerFXNrJexWbDC7QE1sPYH6+ZJhfe3BZ3PgOzyHrMN5SSFR495OQym/VKp6AK0c9+WKyGmQtiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818332; c=relaxed/simple;
	bh=UI2ZqGobTOQQcmlPXfv/j/V6+Jui2JmPVw6pI4IDKAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad8vBA49t0IIozvbiaBuLVRpPGgJ0luWLMBko4SMzj3MBalsejmcx/LkDAy0ELgyLXucG5Tx3rwvjs3Xq+1wdmLxY59xt/LJ7+biTRxY3r4/Zno8lCCriaaZhQ3lYLBarD1FRmqhznee0oum16W57wxWMTqlXQzURxB8WOZe2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bGBpsrMk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mdJHtP4ilMbrAeZJVmtGiVVH8/DQTyN0Bo0db565OjU=; b=bGBpsrMkzgF4U1mNygLEFJXi0j
	yV6P1aA4yanOkwSJP6cdXHsTmXYFhhIE8C7cfd7OBxGzlVpBpo2vR0Oa57r84fvvK/FLL8L5raARr
	26FuawkhHW274Ka0EsRT6rYOB3LdN4l5nos6hP0jUd7iwYjzJhYiVtIHaqvc384vOUEfuDGSWsJGr
	igY7aIGoI82ZZLGw3tDDJYyKuDerQSCh+1biTMWzQF3AR09bG1SdnidWrUXvIDs839RcBF8Px1Xh2
	DOH6B3+76kTjyt2Xwg5DPhl1LO3VgG9rktLoKlndZbzvnBXBKeIs5CMTRanOSt4bpqroMq0uZsCBw
	37Tl5QjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twgex-00000000c5h-27ZS;
	Mon, 24 Mar 2025 12:12:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E32F3004AF; Mon, 24 Mar 2025 13:12:03 +0100 (CET)
Date: Mon, 24 Mar 2025 13:12:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <20250324121202.GG14944@noisy.programming.kicks-ass.net>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-lockdep-v1-1-78b732d195fb@debian.org>

On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> lockdep_unregister_key() is called from critical code paths, including
> sections where rtnl_lock() is held. For example, when replacing a qdisc
> in a network device, network egress traffic is disabled while
> __qdisc_destroy() is called for every network queue.
> 
> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> which gets blocked waiting for synchronize_rcu() to complete.
> 
> For example, a simple tc command to replace a qdisc could take 13
> seconds:
> 
>   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>     real    0m13.195s
>     user    0m0.001s
>     sys     0m2.746s
> 
> During this time, network egress is completely frozen while waiting for
> RCU synchronization.
> 
> Use synchronize_rcu_expedited() instead to minimize the impact on
> critical operations like network connectivity changes.
> 
> This improves 10x the function call to tc, when replacing the qdisc for
> a network card.
> 
>    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>      real     0m1.789s
>      user     0m0.000s
>      sys      0m1.613s
> 
> Reported-by: Erik Lundgren <elundgren@meta.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> ---
>  kernel/locking/lockdep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 4470680f02269..a79030ac36dd4 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	if (need_callback)
>  		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  
> -	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> -	synchronize_rcu();
> +	/* Wait until is_dynamic_key() has finished accessing k->hash_entry.
> +	 * This needs to be quick, since it is called in critical sections
> +	 */
> +	synchronize_rcu_expedited();
>  }
>  EXPORT_SYMBOL_GPL(lockdep_unregister_key);

So I fundamentally despise synchronize_rcu_expedited(), also your
comment style is broken.

Why can't qdisc call this outside of the lock?

