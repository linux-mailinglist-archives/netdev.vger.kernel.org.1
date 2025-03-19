Return-Path: <netdev+bounces-176253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89466A69835
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE84C16F977
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1DB20B20D;
	Wed, 19 Mar 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQSldM6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D3187FEC;
	Wed, 19 Mar 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409641; cv=none; b=kSUnrXT5KvCfJcLAOFlxFwtfbKwoe+zaWNNE2dWULh6JLZ8bf0jPG3MS6nwgsyRbeabvi/I6M0D7bUQgyLmBpMJ+6+Ot4Knu5p2/vNWlxOxCbkM84MCmQjtDAWdpmRaACdvKQ2Rwjjuv6XzwmPllDOM8ceWB2BYfwf5tVFnOmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409641; c=relaxed/simple;
	bh=IzvYLDuELCefJ2B7lNaBpMR9doX1m2Gj2AFRHtiePdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE2tAOJ6t/TYOyG4+Q9L5oqDN6+BWsl1b7smi6DnKf1bskMhVb3yBYZwfAVDTzxLc+xz1nQ7r9rNzfA7aJZXEj5EfOfR5XaOrbfjFyScup52x4C3ZDaUw/GvOXb4JG7eQqhMsQK5X/2c3fAtwOyDsFUqs5ldRwWhLZgg/nHL7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQSldM6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB7C4CEE4;
	Wed, 19 Mar 2025 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742409641;
	bh=IzvYLDuELCefJ2B7lNaBpMR9doX1m2Gj2AFRHtiePdE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QQSldM6pUDme1JmNzyAlY0rKhp9lT6ciHg4SiafAEwsOf1iA3gFlS65CC5lLYqKtl
	 5z1MEIz/onTLuKDymDAbkpd+LgX3+tBlnu7UwAVhkpmLknKxZHZHCyFHjuUtL/AGHL
	 CQRsq/l80aYOtP0CFZ08KhbC/EJbSMSsKj3I6JueuC1wmHN3Qb3CrIPKtAFzrcsGpD
	 ONz60EWaMPDG7xg33RA4arE8EEM41O5a0TdoAuwKvlNxkI6MwpkMNM+89eM9eASxsh
	 2ehqKXs2sPclsyDCEtwzMHUAkwgbh76KijAHFHaJ0rzpDecK6u4pF/QqUbo55UUt8I
	 mIcteq/g978Lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC687CE0BC5; Wed, 19 Mar 2025 11:40:40 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:40:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: longman@redhat.com, bvanassche@acm.org,
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	kuniyu@amazon.com, rcu@vger.kernel.org, kasan-dev@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
Message-ID: <89ca1978-de9e-4502-8a3b-970ad8fd9fcf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao>
 <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
 <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop>
 <20250319-truthful-whispering-moth-d308b4@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-truthful-whispering-moth-d308b4@leitao>

On Wed, Mar 19, 2025 at 11:12:24AM -0700, Breno Leitao wrote:
> On Wed, Mar 19, 2025 at 09:05:07AM -0700, Paul E. McKenney wrote:
> 
> > > I think we should redesign lockdep_unregister_key() to work on a separately
> > > allocated piece of memory,
> > > then use kfree_rcu() in it.
> > > 
> > > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> > > 
> > > struct ... {
> > >      struct lock_class_key;
> > >      struct rcu_head  rcu;
> > > }
> > 
> > Works for me!
> 
> I've tested a different approach, using synchronize_rcu_expedited()
> instead of synchronize_rcu(), given how critical this function is
> called, and the command performance improves dramatically.
> 
> This approach has some IPI penalties, but, it might be quicker to review
> and get merged, mitigating the network issue.
> 
> Does it sound a bad approach?
> 
> Date:   Wed Mar 19 10:23:56 2025 -0700
> 
>     lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization
>     
>     lockdep_unregister_key() is called from critical code paths, including
>     sections where rtnl_lock() is held. When replacing a qdisc in a network
>     device, network egress traffic is disabled while __qdisc_destroy() is
>     called for every queue. This function calls lockdep_unregister_key(),
>     which was blocked waiting for synchronize_rcu() to complete.
>     
>     For example, a simple tc command to replace a qdisc could take 13
>     seconds:
>     
>       # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
>         real    0m13.195s
>         user    0m0.001s
>         sys     0m2.746s
>     
>     During this time, network egress is completely frozen while waiting for
>     RCU synchronization.
>     
>     Use synchronize_rcu_expedite() instead to minimize the impact on
>     critical operations like network connectivity changes.
>     
>     Signed-off-by: Breno Leitao <leitao@debian.org>

The IPIs are not fun, but in the interest of getting *some* solution
moving forward...  ;-)

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 4470680f02269..96b87f1853f4f 100644
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
> +	synchronize_rcu_expedite();
>  }
>  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>  
> 

