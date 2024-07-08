Return-Path: <netdev+bounces-109978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998192A8F4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B8B2816E2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85BF149C64;
	Mon,  8 Jul 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmDTT2fM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBED79FD;
	Mon,  8 Jul 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463350; cv=none; b=Vyjgiom4SnXT3Xc3cGtqHTqga0IV5HwPip00zABzyqrP95ILVaaqSt9+zBknXAvywYzViittMLD7aw78tQ32YBoVxYtHWRaeWWl7z1cRjUJwvObJCUiTdyZSsW/Q2R1+PpcVZvxAHR28eR1ksmyqG30xrdEt6BgAV1mzjACCAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463350; c=relaxed/simple;
	bh=ZwRMB9cPlUxIEVj4zjhkUQtCsuzOoJaGdot1RujwOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtHlsBVwRy81C70VIcQ7m1PeDkqA1q8HZgoSJGbE075h5x2KG/ZH6E6e4SFPDuop6XOCsXbLKruQ1eAvDnd1D/4qBUOouxM5ItP3vjKiO/I7Cwh3qs41zrKeHaPGV+f1NBj2Vj8xZlLkHKaYQkNcMaxUvqBWWiznQf1VHlZbvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmDTT2fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3140C116B1;
	Mon,  8 Jul 2024 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720463350;
	bh=ZwRMB9cPlUxIEVj4zjhkUQtCsuzOoJaGdot1RujwOuI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UmDTT2fMOn+URdKlUs5HBiwvRq/pycllqtdK7xOzbuqVEchKPS5DiMpAX2Gw5VoRQ
	 dgRFvJD9uTts4D6i6L6IDRJ183BMr8CN3BLOdZhbSvGLsT6JSZX9OlA501EK8yg+Gt
	 qABHcrbMbT3q3vjdpkzRX12iVXIQrkkyTfVHi3zJdi9sVf5Wp+41A1CtCQDBMfdfX6
	 XF1DHmLJ8v+Lx7gcGNcIReDQqVU+sFQAP7yRZq1QLFu53EsCZGq7EBP25wO+vs670A
	 Mh5iLk1bwteYHJ046955Xb4SP+Nkv4HtZ0fuO3RLMEfghX1LREWXwUtcLn760vlFCb
	 jlyeLq/FaBydw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8CDD2CE09EB; Mon,  8 Jul 2024 11:29:08 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:29:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <5cbc0ea9-8752-423f-a6c6-274e0c4ea3cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> Hi Paul,
> 
> Sorry for the delayed answer, I got a respiratory infection, so was in
> bed last week,
> 
> On Thu, 20 Jun 2024 at 18:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 01:33:36AM +0100, Dmitry Safonov wrote:
> [..]
> > > I'm sorry guys, that was me being inadequate.
> >
> > I know that feeling!
> 
> Thanks :)
> 
> [adding/quoting back the context of the thread that I cut previously]
> 
> > On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> > > On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> > > > > FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> > > > > freed pointers, that where addressed by to this patch:
> > > > >
> > > > > commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> > > > > Author: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Date:   Sat Sep 30 17:46:56 2023 +0000
> > > > >
> > > > >     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> > > > >
> > > > > I'm wondering if this is hitting something similar? Possibly due to
> > > > > lazy RCU callbacks invoked after MSECS_MIN_AGE???
> > >
> > > Dmitry mentioned this commit, too, but we use the same config for MPTCP
> > > tests, and while we repro TCP AO failures quite frequently, mptcp
> > > doesn't seem to have failed once.
> > >
> > > > Fun!  ;-)
> > > >
> > > > This commit handles memory passed to kfree_rcu() and friends, but
> > > > not memory passed to call_rcu() and friends.  Of course, call_rcu()
> > > > does not necessarily know the full extent of the memory passed to it,
> > > > for example, if passed a linked list, call_rcu() will know only about
> > > > the head of that list.
> > > >
> > > > There are similar challenges with synchronize_rcu() and friends.
> > >
> > > To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> > > call_rcu() as something he was expecting to have a similar issue but
> > > it in fact appeared immune.
> 
> On Thu, 20 Jun 2024 at 18:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > That's a real issue, rather than a false-positive:
> > > https://lore.kernel.org/netdev/20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com/
> >
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

You lost me on this one.  If you are waiting only on RCU callbacks,
the rcu_barrier() suffices.  If you are also waiting on objects to be
freed after a synchronize_rcu(), kfree_rcu() or similar, you are waiting
only for the corresponding grace period to end, not necessarily for the
freeing of objects following that synchronize_rcu().

So what exactly needs to be waited upon?

I should hasten to add that the fact that there is currently no way
to wait on kfree_rcu()'s frees is considered to be a bug, but that
bug is currently only known to be a problem in the case of a module
that uses kfree_rcu() on objects obtained from a kmem_cache structure,
and that also passes that kmem_cache structure to kmem_cache_free()
at module-unload time.

In the meantime, the workaround is to use call_rcu() instead of
kfree_rcu() in that case.  Which existing code does.

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
> 
> Some other options/ideas:
> - more RCU-invasive option which would be adding a mapping function to
> segmented lists of callbacks, which would allow kmemleak to request
> from RCU if the pointer is yet referenced by RCU.
> - the third option is for kmemleak to trust RCU and generalize the
> commit above, adding kmemleak_object::flags of OBJECT_RCU, which will
> be set by call_rcu()/kfree_rcu() and unset once the callback is
> invoked for RCU_DONE_TAIL.
> - add kmemleak_object::update_jiffies or just directly touch
> kmemleak_object::jiffies whenever the object has been modified (see
> update_checksum()), that will ignore recently changed objects. As
> rcu_head should be updated, that is going to automagically ignore
> those deferred to RCU objects.

You could also make greater use of the polled RCU API, marking
an object (or, perhaps more space-efficiently, a group of
objects) using get_state_synchronize_rcu_full(), then using
poll_state_synchronize_rcu_full() to see when all readers should be done.
There are additional tricks that can be used if needed.

							Thanx, Paul

> Not sure if I mis-looked anything and it seems there is no hurry in
> fixing anything yet, as this is a theoretical issue at this moment.
> 
> Hopefully, these ideas don't look like a nonsense,
>              Dmitry

