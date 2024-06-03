Return-Path: <netdev+bounces-100181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA78D8114
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EF4B23EDA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA91366;
	Mon,  3 Jun 2024 11:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006E84A41
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413720; cv=none; b=tiv32TvHLIgX8DJnM/8y+gJNokeWheJt5ceXixlxofkHxWCxCmtNruWoPD/CSarSiBWfRxHFIWxVQGpw4IAmE7DAL1hqyMB5GCOb1SEVtFaNvFdyqFWubfFloalLnogGmG9ZOKP+7Q0a4YyeJDQtKDSVJd40oZv1C8nHKHyqi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413720; c=relaxed/simple;
	bh=0sEw3ek2TmIvlVxMqbLFEADOffmcptyKu+edWbFIGEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/bKqiniZexHths18FJ4jmlPoC744AZojUui/AJW46I/LP21nThuI/qCcvR+ck1lRRJ9xt/7yzLkKX5/IZZkpPO6tXjWnpRyeIzX5gySBBfo2ZczRSqCTMgjHQbsm53IwJ7eJWfUL/L806QIb99wNhbSY3yLXJSv1PcYCozaIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sE5lA-0001n1-So; Mon, 03 Jun 2024 13:21:52 +0200
Date: Mon, 3 Jun 2024 13:21:52 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com,
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com,
	dsahern@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer
 un-pinning
Message-ID: <20240603112152.GB8496@breakpoint.cc>
References: <20240603093625.4055-1-fw@strlen.de>
 <20240603093625.4055-2-fw@strlen.de>
 <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> On Mon, Jun 3, 2024 at 11:37 AM Florian Westphal <fw@strlen.de> wrote:
> > +       spin_lock(lock);
> > +       if (timer_shutdown(&tw->tw_timer)) {
> > +               /* releases @lock */
> > +               __inet_twsk_kill(tw, lock);
> > +       } else {
> 
> If we do not have a sync variant here, I think that inet_twsk_purge()
> could return while ongoing timers are alive.

Yes.

We can't use sync variant, it would deadlock on ehash spinlock.

> tcp_sk_exit_batch() would then possibly hit :
> 
> WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> 
> The alive timer are releasing tw->tw_dr->tw_refcount at the end of
> inet_twsk_kill()

Theoretically the tw socket can be unlinked from the tw hash already
(inet_twsk_purge won't encounter it), but timer is still running.

Only solution I see is to schedule() in tcp_sk_exit_batch() until
tw_refcount has dropped to the expected value, i.e. something like

static void tcp_wait_for_tw_timers(struct net *n)
{
	while (refcount_read(&n->ipv4.tcp_death_row.tw_refcount) > 1))
		schedule();
}

Any better idea?

I started to sketch a patch that keeps PINNED as-is but schedules almost
all of the actual work to a work item.

Idea was that it would lower RT latencies to acceptable level but it got
so ugly that I did not follow this path.

I could resurrect this if you think its worth a try.

