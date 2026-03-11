Return-Path: <netdev+bounces-266497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIE3CyENsWldqAIAu9opvQ
	(envelope-from <netdev+bounces-266497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD3C25CE75
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FD6E3033D44
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA50238D52;
	Wed, 11 Mar 2026 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPnpTE2Y"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E840DFC7
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210908; cv=none; b=JTF1Nf1v39IS2UHXBsBGlRT4J+GT96tV8agcAQjiGjdDsSmli6BueJlCxHDMKpNJY+Dtwgfx07ZrAEPT5Q5TOeQ6919bmygXLCtrTo7AJPSi0TRGF3NKa3mNO6nEuaQIrUFQHBg4p0EKXk7xaSseZXAuFwQbGVkzdNTyrjg5Gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210908; c=relaxed/simple;
	bh=1EcLenB/nf7iMC4+h9jMGvIvmmie5QpV4xtjqV2Xo2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyg5fBpv06SibEs1RCibJ/jmNmUlash99pZaXyJW3xelMpjDKmpamsWiH3LjTLeFE1Ubp1I81zfbliQ9MZmyNKPcG5wZv9N0hf1TQtPLe1q8BoF9F+tBRC1mH83uK7vCCbdJXJujvXGq8i3UtFuFtJJbiplXY+GBzrWktcw0HJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPnpTE2Y; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Mar 2026 14:34:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773210904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfNns3ZE9bP5e8cQvGX1WWFaXLrY8EikgZKzAR4LmuE=;
	b=qPnpTE2Ye6P7Qb9hmpI8G9YJ0qXyZjOyXjlSBMkLFg0pAUIY5ph2MLawvbHRsh0y4EYDGV
	ckR3ki08IuJDFfl/q7T5u7rlYg4tG/GCbKKQgt3WN6mKDHap0ZNStz0Bz8TheIgMqxDeqg
	zoVJMdReIfHDzR0rzf0XI734LHDKfzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Julia.Lawall@inria.fr, linux@treblig.org, nate.karstens@garmin.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <sbbx62xaaudsds6mp4gchkv3f5t5bkybhuwpzecjjdsrd67u6d@m5yekizhbsiz>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
 <aaobmK6d_xd9ZXGj@v4bel>
 <aaqovyrmd5pJtZKq@krikkit>
 <aaq9TgFpsjn9XWAC@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaq9TgFpsjn9XWAC@v4bel>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2FD3C25CE75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-266497-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 08:41:02PM +0800, Hyunwoo Kim wrote:
> On Fri, Mar 06, 2026 at 11:13:19AM +0100, Sabrina Dubroca wrote:
> > 2026-03-06, 09:11:04 +0900, Hyunwoo Kim wrote:
> > > On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> > > > Sorry for the delay, I wanted to think about the race condition a bit
> > > > more.
> > > > 
> > > > 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > > > > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > > > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > > > > 
> > > > > > > It seems that this is not something that should be handled inside strp itself, 
> > > > > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > > > > of individually. Would that be the right direction?
> > > > > > 
> > > > > > Agree.
> > > > > > 
> > > > > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > > > > restoration logic.
> > > > > > 
> > > > > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > > > > didn't get far enough to verify if it's handling this correctly.
> > > > > > 
> > > > > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > > > > 
> > > > > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > > > > 
> > > > > > This is what I was thinking about, yes.
> > > > > 
> > > > > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > > > > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> > > > 
> > > > Sure. But once espintcp is fixed in that way, can the original race
> > > > condition with strparser still occur? release_sock() will wait for any
> > > 
> > > If the espintcp callback restoration patch is applied, the strparser
> > > race should no longer occur in espintcp.
> > > 
> > > > espintcp_data_ready()/strp_data_ready() that's already running, and a
> > > > sk_data_ready that starts after we've changed the callbacks will not
> > > > end up in strp_data_ready() at all so it won't restart the works that
> > > > are being stopped by strp_done()?
> > > > 
> > > > It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> > > > not sure there's a bug other than espintcp not terminating itself
> > > > correctly on the socket.
> > > 
> > > That said, the _cancel APIs in strparser still appear to carry some
> > > structural risk, so it might still make sense to switch to the _disable
> > > APIs for the benefit of other strp users or potential future callers.
> > 
> > Not really. Every user of strp that is open to the strp_recv vs
> > cancel_* race is also open to the strp_recv vs free race, so switching
> > from cancel_* to disable_* is only a partial fix.
> > 
> > But if we took and released the socket lock in strp_done, we would
> > solve the issue for all users even without resetting the callbacks?
> 
> Looks good to me. With this change, it seems the issue can be resolved
> not only for espintcp but for all strp users.
> 
> When strp_stop() runs first:
> ```
>                  cpu0                                cpu1
> 
> espintcp_close()
>   strp_stop()
>     strp->stopped = 1;
>                                          espintcp_data_ready()
>                                            strp_data_ready()
>                                              if (unlikely(strp->stopped)) return;
>   strp_done()
>     lock_sock();
>     release_sock();
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>     kfree_skb(strp->skb_head);
> ```
> 
> When strp_data_ready() runs first:
> ```
>                  cpu0                                cpu1
> 
>                                          espintcp_data_ready()
>                                            strp_data_ready()
>                                              if (unlikely(strp->stopped)) return;
> espintcp_close()
>   strp_stop()
>     strp->stopped = 1;
>   strp_done()
>     lock_sock();
>                                              strp_read_sock()
>                                                tcp_read_sock()
>                                                  __tcp_read_sock()
>                                                    strp_recv()
>                                                      __strp_recv()
>                                                        head = strp->skb_head;
>                                                        strp_start_timer()
>                                                          mod_delayed_work(&strp->msg_timer_work);
>                                                        ...
>     release_sock();
>     cancel_delayed_work_sync(&strp->msg_timer_work);
>     kfree_skb(strp->skb_head);
> ```
> In both cases, the race does not appear to cause any problem.
> 
> > 
> > @@ -503,6 +503,10 @@ void strp_done(struct strparser *strp)
> >  {
> >  	WARN_ON(!strp->stopped);
> >  
> > +	lock_sock(strp->sk);
> > +	/* sync with other code */
> > +	release_sock(strp->sk);
> > +
> >  	cancel_delayed_work_sync(&strp->msg_timer_work);
> >  	cancel_work_sync(&strp->work);
> >  
> > 
> > 
> >  - strp->stopped so any new call into strp_data_ready will not do anything
> > 
> >  - lock/release need to take bh_lock_sock so any existing call to
> >    strp_data_ready will have to complete before we move on to cancel*_work
> > 
> > 
> > 
> > Or maybe the requirement should be that strp_stop has to be called
> 
> >From my perspective, adding lock_sock() inside strp_done(), as in the
> patch above, looks cleaner.
> 
> > under lock_sock() (or even just bh_lock_sock), but again I can't
> > figure out if that's ok for sockmap.
> 
> sockmap/psock has a more complex call stack compared to other strp
> users, so I'm also not entirely certain about that part.


For sockmap, I think it's not affected by this race.

The sockmap path has additional synchronization:

1. sk_psock_strp_data_ready() holds read_lock_bh(&sk->sk_callback_lock) when
calling strp_data_ready(), while sk_psock_drop() holds write_lock_bh(&sk->sk_callback_lock)
when calling strp_stop(). This rwlock serializes the stopped flag check with the stopped
flag set.

2. strp_done() is not called directly from sk_psock_drop(), but deferred via
queue_rcu_work() → sk_psock_destroy() → sk_psock_done_strp().
The RCU grace period guarantees that all in-flight sk_psock_strp_data_ready()
calls (which are within rcu_read_lock() sections) have completed before strp_done()
runs. So cancel_delayed_work_sync() / cancel_work_sync() in
strp_done() won't be defeated by a subsequent re-schedule.

I think it common practice to use strparser just like the doc says:

	void strp_done(struct strparser *strp);

     strp_done is called to release any resources held by the stream
     parser instance. This must be called after the stream processor
     has been stopped.

> 
> > 
> > 
> > > With that in mind, perhaps the direct fix for this race could be handled
> > > in the espintcp callback restoration patch. For the strparser patch, I
> > > could instead adjust the commit message to reflect that it removes a
> > > potential hazard by replacing the _cancel APIs with the _disable
> > > variants, and resubmit it in that form.
> > 
> > I'm not going to nack a patch doing s/cancel_/disable_/ in strp_done,
> > but it doesn't fully solve the race condition if the caller isn't
> > doing the right thing, and it doesn't do anything if the strp user is
> > handling the teardown correctly.
> 
> I agree with your point there. Still, after the core patches addressing
> this race are applied, I plan to resubmit the _disable patch with an
> updated commit message. I think applying that change is still beneficial.
> 
> 
> Best regards,
> Hyunwoo Kim

