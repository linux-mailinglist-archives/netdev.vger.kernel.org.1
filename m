Return-Path: <netdev+bounces-117509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA294E240
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697051C20927
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4741514E2;
	Sun, 11 Aug 2024 16:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D909C8E9;
	Sun, 11 Aug 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723393742; cv=none; b=U4aIh1AIq7dp+JXp2pEBX7cOhELeVriMeHEAf8435lYEb0coMB56Yum79NLZ76N96fWiL+Dg0+q1aYoVgoZGZxh9Xf4nIJb3hpMQhlk22XoG4QT6aOn/6KZ4gxuZuGo5MFWCo8ZLLJ6CGgxLy/AzFBYQx6vMGIpZ2PN/im9lwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723393742; c=relaxed/simple;
	bh=KNUu75mJOq6wqZt3/F2bH3NqQbOYJZhS6W32Vz204vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spOW0v116CvJIqFGoZaSxnPPiM8klvz/ha/SmN/qKI8Z/sErWmda056aZw7kiypuVdlAf/gGSkvxsmbZneLDOBSdDvB5/KKweI5LD2ligLL75u0A1AkVg5nTu6K8slBhXok9ombVit65fT03sg3gRIjsuaI7OMGdscPLbKNyW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdBR4-00063D-Ll; Sun, 11 Aug 2024 18:28:50 +0200
Date: Sun, 11 Aug 2024 18:28:50 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Message-ID: <20240811162850.GE13736@breakpoint.cc>
References: <0000000000003a5292061f5e4e19@google.com>
 <20240811022903.49188-1-kuniyu@amazon.com>
 <20240811132411.GB13736@breakpoint.cc>
 <20240811145443.GD13736@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811145443.GD13736@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
> 
> ... shows at two cores racing:
> 
> [ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
> and
> [ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not tainted 6.9.0-syzkalle (netns cleanup net).
> 
> 
> first splat backtrace shows invocation of tcp_sk_exit_batch() from
> netns error unwinding code.
> 
> Second one lacks backtrace, but its also in tcp_sk_exit_batch(),

... which doesn't work.  Does this look like a plausible
theory/exlanation?

Given:
1 exiting netns, has >= 1 tw sk.
1 (unrelated) netns that failed in setup_net

... we run into following race:

exiting netns, from cleanup wq, calls tcp_sk_exit_batch(), which calls
inet_twsk_purge(&tcp_hashinfo).

At same time, from error unwinding code, we also call tcp_sk_exit_batch().

Both threads walk tcp_hashinfo ehash buckets.

From work queue (normal netns exit path), we hit

303                         if (state == TCP_TIME_WAIT) {
304                                 inet_twsk_deschedule_put(inet_twsk(sk));

Because both threads operate on tcp_hashinfo, the unrelated
struct net (exiting net) is also visible to error-unwinding thread.

So, error unwinding code will call

303                         if (state == TCP_TIME_WAIT) {
304                                 inet_twsk_deschedule_put(inet_twsk(sk));

for the same tw sk and both threads do

218 void inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
219 {
220         if (del_timer_sync(&tw->tw_timer))
221                 inet_twsk_kill(tw);

Error unwind path cancel timer, calls inet_twsk_kill, while
work queue sees timer as already shut-down so it ends up
returning to tcp_sk_exit_batch(), where it will WARN here:

  WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

... because the supposedly-last tw_refcount decrement did not drop
it down to 0.

Meanwhile, error unwiding thread calls refcount_dec() on
tw_refcount, which now drops down to 0 instead of 1, which
provides another warn splat.

I'll ponder on ways to fix this tomorrow unless someone
else already has better theory/solution.

