Return-Path: <netdev+bounces-100229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE48D8401
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA27A1F23B58
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B812DD8E;
	Mon,  3 Jun 2024 13:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3F12D75C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421525; cv=none; b=P05VrQtHH+aISx3kXfcQkx/2YC2Dmz8FLROg6/EMP/C7yRuyxz22XdjcN3hrLSxISscffmYfN6bCoGmlclYIe8XL467iu+iqie7cR+p0AN+OF10RlXm3w4N5Bcx3v2pswYeBc5dHx4Oxr3xQnvVvRu/dA/8S9OQzNwZm6/qJG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421525; c=relaxed/simple;
	bh=xqsubzw6RF/3q23ZeAk99Ptlavs+dHfB9cH46W8yYq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBt3S8Y+0HCHlp+f9OWIWxTr4zeQ+fCzyikahdJ2ZMDNdjOqdXVtXIFeY8WHmpG5f7cNprky+urgSbs6So3pBCQsu8+nSnMdz1abDGi7J4AX9d2sSaKRWp3/hJnDz1wIJUo5Lg2iSdLVEPSn3KrcKQR9lanXpkj9ejSGgYoT4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sE7n4-0002jD-Jw; Mon, 03 Jun 2024 15:31:58 +0200
Date: Mon, 3 Jun 2024 15:31:58 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com,
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com,
	dsahern@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer
 un-pinning
Message-ID: <20240603133158.GC8496@breakpoint.cc>
References: <20240603093625.4055-1-fw@strlen.de>
 <20240603093625.4055-2-fw@strlen.de>
 <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
 <20240603112152.GB8496@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603112152.GB8496@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> Eric Dumazet <edumazet@google.com> wrote:
> > On Mon, Jun 3, 2024 at 11:37 AM Florian Westphal <fw@strlen.de> wrote:
> > > +       spin_lock(lock);
> > > +       if (timer_shutdown(&tw->tw_timer)) {
> > > +               /* releases @lock */
> > > +               __inet_twsk_kill(tw, lock);
> > > +       } else {
> > 
> > If we do not have a sync variant here, I think that inet_twsk_purge()
> > could return while ongoing timers are alive.
> 
> Yes.
> 
> We can't use sync variant, it would deadlock on ehash spinlock.
> 
> > tcp_sk_exit_batch() would then possibly hit :
> > 
> > WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> > 
> > The alive timer are releasing tw->tw_dr->tw_refcount at the end of
> > inet_twsk_kill()
> 
> Theoretically the tw socket can be unlinked from the tw hash already
> (inet_twsk_purge won't encounter it), but timer is still running.
> 
> Only solution I see is to schedule() in tcp_sk_exit_batch() until
> tw_refcount has dropped to the expected value, i.e. something like
> 
> static void tcp_wait_for_tw_timers(struct net *n)
> {
> 	while (refcount_read(&n->ipv4.tcp_death_row.tw_refcount) > 1))
> 		schedule();
> }
> 
> Any better idea?

Actually, I think we can solve this in a much simpler way.

Instead of replacing:

void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
{
 if (del_timer_sync(&tw->tw_timer))
    inet_twsk_kill(tw);
 inet_twsk_put(tw);
}

With:
 spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
 spin_lock(lock);
 if (timer_shutdown(&tw->tw_timer)) {

(Which gets us into the tcp_sk_exit_batch trouble Eric points out),
we can simply add "empty" ehash lock unlock pair before calling
del_timer_sync():

void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
{
+	spinlock_t *lock = inet_ehash_lockp(hashinfo, tw->tw_hash);
+	spin_lock(lock)
+	spin_unlock(lock)

        if (del_timer_sync(&tw->tw_timer))
                inet_twsk_kill(tw);
        inet_twsk_put(tw);
}

Rationale:
inet_twsk_deschedule_put() cannot be called before hashdance_schedule
calls refcount_set(&tw->tw_refcnt, 3).

Before this any refcount_inc_not_zero fails so we never get into
deschedule_put.

Hashdance_schedule holds the ehash lock when it sets the tw refcount.
The lock is released only after the timer is up and running.

When inet_twsk_deschedule_put() is called, and hashdance_schedule
is not yet done, the spinlock/unlock pair will guarantee that
the timer is up after the spin_unlock.

I think this is much better than the schedule loop waiting for tw_dr
refcount to drop, it mainly needs a comment to explain what this is
doing.

Thoughts?

