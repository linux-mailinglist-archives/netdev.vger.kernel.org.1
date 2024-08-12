Return-Path: <netdev+bounces-117826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B694F7C7
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3E8B20B90
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7D190079;
	Mon, 12 Aug 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dKHt/QE1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8CD61FFC;
	Mon, 12 Aug 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492856; cv=none; b=K6jFL1BkiAuGWinF2qR9VfZnp/aUQAV/ajca2EcVvq2vs44rjxTX322teeRO51X0Q1ed6mPB+ZzxPgnV6lEr3Yfeg876hW1z/qQyMEbSW/BdOZrCaJr9QUNGyTV9//nPqJJare6Q1JGq8NMUrTTT6b6ELaU9mJkMMhAzdw7ab/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492856; c=relaxed/simple;
	bh=HglIoQhe+XpG/KJ5F8PuFrCQ6g2oMgSCUjVKEPlAF8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2HsBrtjNGvd3ogXuLXKl8QZrpwG7vbSZA5mQu9YN+K8M1FN4BNXvwnaw/AkO46RDTuxgDOHT6TE9E2sLt4jRys1SeuBRFcEhuKITu8G03MNwfYZIXpuifNz/RJ+eXjShRBMs3D73bKnK9qsmbb1gQwjTABAcZFInXGpCTdKWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dKHt/QE1; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723492855; x=1755028855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sick6Z+hcuAogqUUmX5tgcZtd2zA2LaabGPkkEXglAY=;
  b=dKHt/QE1GVCmVRrbcop2UcUn1sNfgtEW5N7zHZBUTX15pB5ZfGSsSVpz
   zXvMgoF1gbxlBjxsVHclRYhsA5qCjAc+vW0D8feu6zsP31IeQCFFmte6e
   G1kLuXLFz7NsQTgE97ZJQuNAADXp3yaUL/98teNnuIwkggNvrW4ayN0pv
   k=;
X-IronPort-AV: E=Sophos;i="6.09,284,1716249600"; 
   d="scan'208";a="224905513"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:00:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:54928]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.236:2525] with esmtp (Farcaster)
 id 0bc0257b-36c9-47dd-88f4-a00c1e5bae97; Mon, 12 Aug 2024 20:00:50 +0000 (UTC)
X-Farcaster-Flow-ID: 0bc0257b-36c9-47dd-88f4-a00c1e5bae97
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 20:00:50 +0000
Received: from 88665a182662.ant.amazon.com (10.142.139.164) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 12 Aug 2024 20:00:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <fw@strlen.de>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Date: Mon, 12 Aug 2024 13:00:39 -0700
Message-ID: <20240812200039.69366-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812140104.GA21559@breakpoint.cc>
References: <20240812140104.GA21559@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Florian Westphal <fw@strlen.de>
Date: Mon, 12 Aug 2024 16:01:04 +0200
> Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Sun, 11 Aug 2024 16:00:29 -0700
> > > From: Florian Westphal <fw@strlen.de>
> > > Date: Sun, 11 Aug 2024 18:28:50 +0200
> > > > Florian Westphal <fw@strlen.de> wrote:
> > > > > https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
> > > > > 
> > > > > ... shows at two cores racing:
> > > > > 
> > > > > [ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
> > > > > and
> > > > > [ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not tainted 6.9.0-syzkalle (netns cleanup net).
> > > > > 
> > > > > 
> > > > > first splat backtrace shows invocation of tcp_sk_exit_batch() from
> > > > > netns error unwinding code.
> > > > > 
> > > > > Second one lacks backtrace, but its also in tcp_sk_exit_batch(),
> > > > 
> > > > ... which doesn't work.  Does this look like a plausible
> > > > theory/exlanation?
> > > 
> > > Yes!  The problem here is that inet_twsk_purge() operates on twsk
> > > not in net_exit_list, but I think such a check is overkill and we
> > > can work around it in another way.
> 
> I'm not so sure.  Once 'other' inet_twsk_purge() found the twsk and
> called inet_twsk_kill(), 'our' task has to wait for that to complete.
> 
> We need to force proper ordering so that all twsk found
> 
> static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
> {
>         struct net *net;
> 
> /*HERE*/tcp_twsk_purge(net_exit_list);
> 
>         list_for_each_entry(net, net_exit_list, exit_list) {
>                 inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
> 
> .... have gone through inet_twsk_kill() so tw_refcount managed to
> drop back to 1 before doing
>                 WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> .
> 
> > > We need to sync two inet_twsk_kill(), so maybe give up one
> > > if twsk is not hashed ?
> 
> Not sure, afaiu only one thread enters inet_twsk_kill()
> (the one that manages to deactivate the timer).

Ah, you're right.

> 
> > > ---8<---
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > > index 337390ba85b4..51889567274b 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -52,7 +52,10 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
> > >  	struct inet_bind_hashbucket *bhead, *bhead2;
> > >  
> > >  	spin_lock(lock);
> > > -	sk_nulls_del_node_init_rcu((struct sock *)tw);
> > > +	if (!sk_nulls_del_node_init_rcu((struct sock *)tw)) {
> > > +		spin_unlock(lock);
> > > +		return false;
> > 
> > forgot to remove false, just return :)
> 
> I don't see how this helps, we need to wait until 'stolen' twsk
> has gone through inet_twsk_kill() and decremented tw_refcount.
> Obviously It would be a bit simpler if we had a reliable reproducer :-)
> 
> Possible solutions I came up with so far:
> 
> 1) revert b099ce2602d8 ("net: Batch inet_twsk_purge").
> 
> This commit replaced a net_eq(twsk_net(tw) ... with a check for
> dead netns (ns.count == 0),
> 
> Downside: We need to remove the purged_once trick that calls
> inet_twsk_purge(&tcp_hashinfo) only once per exiting batch in
> tcp_twsk_purge() as well.
> 
> As per b099ce2602d8 changelog, likely increases netns dismantle times.

Yes, so I think we should avoid this way although user could mitigate
it with per-net ehash.


> 
> Upside: simpler code, so this is my preferred solution.
> 
> No concurrent runoff anymore, by time tcp_twsk_purge() returns it has
> called refcount_dec(->tw_refcount) for every twsk in the exiting netns
> list, without other task stealing twsks owned by exiting netns.
> 
> Solution 2: change tcp_sk_exit_batch like this:
> 
>    tcp_twsk_purge(net_exit_list);
> 
> +  list_for_each_entry(net, net_exit_list, exit_list) {
> +      while (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) > 1)
> +         schedule();
> +
> +  }
> 
>     list_for_each_entry(net, net_exit_list, exit_list) {
>        inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
>        WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
> 
> This synchronizes two concurrent tcp_sk_exit_batch() calls via
> existing refcount; if netns setup error unwinding ran off with one of
> 'our' twsk, it will wait until other task has completed the refcount decrement.
> 
> I don't expect it to increase netns dismantle times, else we'd have seen
> the WARN_ON_ONCE splat frequently.
> 
> Solution 3:

I prefer this because in all of my local reports I see two splats from
exit_batch calls.

If the same issue still happens with solution 3, we'll see the same
splats with mostly no risk.  But solution 2 will give us hung task,
possibly in cleanup_net, which is worse.

Then, we can consider other possibilities explained in solution 4
or like that kernel twsk is put into ehash of dying netns.

Another option would be add reftracker for tcp_death_row.tw_refcount
to detect the root cause ?


> 
> Similar to 2), but via mutex_lock/unlock pair:
> 
> static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
> {
>         struct net *net;
> 
> 	mutex_lock(&tcp_exit_batch_mutex);
> 
>         tcp_twsk_purge(net_exit_list);
> 
>         list_for_each_entry(net, net_exit_list, exit_list) {
>                 inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
>                 WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
>                 tcp_fastopen_ctx_destroy(net);
>         }
> 	mutex_unlock(&tcp_exit_batch_mutex);
> }
> 
> Solution 4:
> 
> I have doubts wrt. tcp_twsk_purge() interaction with tw timer firing at
> the 'wrong' time.  This is independent "problem", I might be
> imagining things here.
> 
> Consider:
> 313 void inet_twsk_purge(struct inet_hashinfo *hashinfo)
> 314 {
> [..]
> 321         for (slot = 0; slot <= ehash_mask; slot++, head++) {
> 
> tw sk timer fires on other cpu, inet_twsk_kill() does:
> 
> 56         spin_lock(lock);
> 57         sk_nulls_del_node_init_rcu((struct sock *)tw);
> 58         spin_unlock(lock);
> 
> ... then other cpu gets preempted.
> inet_twsk_purge() resumes and hits empty chain head:
> 
> 322                 if (hlist_nulls_empty(&head->chain))
> 323                         continue;
> 
> so we don't(can't) wait for the timer to run to completion.
> 
> If this sounds plausible to you, this gives us solution 4:
> 
> Restart inet_twsk_purge() loop until tw_dr->tw_refcount) has
> dropped down to 1.
> 
> Alternatively (still assuming the above race is real), sk_nulls_del_node_init_rcu
> needs to be moved down:
> 
>  48 static void inet_twsk_kill(struct inet_timewait_sock *tw)
> ...
>  58     /* Disassociate with bind bucket. */
> ...
>  68     spin_unlock(&bhead->lock);
> 
>  70     refcount_dec(&tw->tw_dr->tw_refcount);
> 
>  +      spin_lock(lock);
>  +      sk_nulls_del_node_init_rcu((struct sock *)tw);
>  +      spin_unlock(lock);
> 71      inet_twsk_put(tw);
> 72 }
> 
> ... so concurrent purge() call will find us
> the node list (and then wait on timer_shutdown_sync())
> until other cpu executing the timer is done.
> 
> If twsk was unlinked from table already before
> inet_twsk_purge() had chance to find it sk, then in worst
> case call to tcp_twsk_destructor() is missing, but I don't
> see any ordering requirements that need us to wait for this.

