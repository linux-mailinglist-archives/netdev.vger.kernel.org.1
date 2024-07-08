Return-Path: <netdev+bounces-109829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8BF92A0AC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70ABF1C20FB9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338867A158;
	Mon,  8 Jul 2024 11:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569E1DA4E;
	Mon,  8 Jul 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436721; cv=none; b=EoZ7ctpqJAej18vryyyBB7azy8VNRQse9V+/t+Hl/NFyIFb9UMKn84PWNuM/pRZwZ1dDLpZGCv8+sD38tOQdofd1inl8MaDNHMEePJQdBqni6fshpja28MQa2Y6aIsTBPATwV/cEE5DnKY6Yj4Jpyn2KGKeKqQdDI3V7EnB1sJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436721; c=relaxed/simple;
	bh=4cksyngzOKfg1d3c6HnQF1tc8f/36Wo2YfYt5vqpB74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o950+mzOr12D0Al7/n9h79X0W/AV8jYjEzwvwcKdk7kEMJCbHe7q36/gU1Fgh/DWEwktzyNhMUm4zCqRuKZv3bzS/+R3CdKVNKUHxp3Pqo3O1Cwm5YGBhIBKQp/WdszfSKTdx92zTqVNsfO6EaJn7NQi22lvv6BsIKTej4MTGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3A1C116B1;
	Mon,  8 Jul 2024 11:05:19 +0000 (UTC)
Date: Mon, 8 Jul 2024 12:05:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: paulmck@kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <ZovH7cWlw9SGcWoJ@arm.com>
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
 <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
 <20240618100210.16c028e1@kernel.org>
 <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop>
 <CAJwJo6bnh_2=Bg7jajQ3qJAErMegDjp0F-aQP7yCENf_zBiTaw@mail.gmail.com>
 <37d3ca22-2dac-4088-94f5-54a07403dd27@paulmck-laptop>
 <CAJwJo6Y0hfB5royz0D8QPkgpRMxz9G5s81ktZbtHPBdt8EYdEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6Y0hfB5royz0D8QPkgpRMxz9G5s81ktZbtHPBdt8EYdEQ@mail.gmail.com>

On Tue, Jul 02, 2024 at 03:08:42AM +0100, Dmitry Safonov wrote:
> On Thu, 20 Jun 2024 at 18:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> > So we need call_rcu() to mark memory flowing through it?  If so, we
> > need help from callers of call_rcu() in the case where more than one
> > object is being freed.
> 
> Not sure, I think one way to avoid explicitly marking pointers for
> call_rcu() or even avoiding the patch above would be a hackery like
> this:
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index d5b6fba44fc9..7a5eb55a155c 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1587,6 +1587,7 @@ static void kmemleak_cond_resched(struct
> kmemleak_object *object)
>  static void kmemleak_scan(void)
>  {
>         struct kmemleak_object *object;
> +       unsigned long gp_start_state;
>         struct zone *zone;
>         int __maybe_unused i;
>         int new_leaks = 0;
> @@ -1630,6 +1631,7 @@ static void kmemleak_scan(void)
>                         kmemleak_cond_resched(object);
>         }
>         rcu_read_unlock();
> +       gp_start_state = get_state_synchronize_rcu();
> 
>  #ifdef CONFIG_SMP
>         /* per-cpu sections scanning */
> @@ -1690,6 +1692,13 @@ static void kmemleak_scan(void)
>          */
>         scan_gray_list();
> 
> +       /*
> +        * Wait for the greylist objects potentially migrating from
> +        * RCU callbacks or maybe getting freed.
> +        */
> +       cond_synchronize_rcu(gp_start_state);
> +       rcu_barrier();
> +
>         /*
>          * Check for new or unreferenced objects modified since the previous
>          * scan and color them gray until the next scan.
> 
> 
> -->8--
> 
> Not quite sure if this makes sense, my first time at kmemleak code,
> adding Catalin.
> But then if I didn't mess up, it's going to work only for one RCU
> period, so in case some object calls rcu/kfree_rcu() from the
> callback, it's going to be yet a false-positive.

Yeah, I don't think this fully solves the problem.

> Some other options/ideas:
> - more RCU-invasive option which would be adding a mapping function to
> segmented lists of callbacks, which would allow kmemleak to request
> from RCU if the pointer is yet referenced by RCU.

This looks too invasive to me plus additional scanning cost.

> - the third option is for kmemleak to trust RCU and generalize the
> commit above, adding kmemleak_object::flags of OBJECT_RCU, which will
> be set by call_rcu()/kfree_rcu() and unset once the callback is
> invoked for RCU_DONE_TAIL.

This could work, the downside being a kmemleak object lookup every time
call_rcu() is invoked. Well, we do this now for kfree_rcu() already,
though we just mark the object as ignored once.

> - add kmemleak_object::update_jiffies or just directly touch
> kmemleak_object::jiffies whenever the object has been modified (see
> update_checksum()), that will ignore recently changed objects. As
> rcu_head should be updated, that is going to automagically ignore
> those deferred to RCU objects.

This looks the simplest, reset the jiffies every time it detected the
object being touched. However, I wonder whether we should introduce a
new variable to track this. 'jiffies' currently stores the creation time
(or thereabouts). We can change the 'age' reported in the sysfs as long
as no user script parses that.

I added the min age to kmemleak to avoid the early object being added to
some lists and getting reported as false positive. It looks like we have
a similar scenario when the object is getting freed: it is added to RCU
lists, disappears temporarily from kmemleak's view. So it does make
sense to employ similar delay as for creation.

That said, for the default kmemleak operation with scanning every 10min,
this wouldn't be needed. During one scan it detects the checksum changed
due to the rcu_head update. 10min later it should have been freed
already.

-- 
Catalin

