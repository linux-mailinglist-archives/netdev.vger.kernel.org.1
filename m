Return-Path: <netdev+bounces-117751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18394F13A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2EB25CA0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E217D8A6;
	Mon, 12 Aug 2024 15:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763E17BB35;
	Mon, 12 Aug 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475031; cv=none; b=lQbi0Wuurl62c6+EZ3Y/TOXuS8Z8L9UKtR940dqaqLVz2yBbt8RUTd6FhuzHPJdA51kJLYidmfam29iaiTQ+Fh8khBvX0L+yTAbyN9RfsRUeRCDV/rHwkCND1wHZV0kSxjAdl304mYSTxLkK9vBH56C2qYq9adUOP5rIakAxxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475031; c=relaxed/simple;
	bh=DIJOK9rrqKHSF2uIzk1Fwb+JCxXRyYFwDFSbyBFYc7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epvcenuIiIy8lpvM5lE5yuXdB9W3mvnyTvXn+GCE8UKjTnlzj3n02Xcg8PfKxdAqaUrbFyVcrrBSZPTUEL/grAzrL4YRuXTrvVrWOw6TuMZXcu0nwZFooxkEoonHEp4DyIFoaYuktsp2uq2Di1YsgbMlPidDxRo8vMW6UyMvvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdWaA-0006p7-VF; Mon, 12 Aug 2024 17:03:38 +0200
Date: Mon, 12 Aug 2024 17:03:38 +0200
From: Florian Westphal <fw@strlen.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Message-ID: <20240812150338.GA25936@breakpoint.cc>
References: <20240811230029.95258-1-kuniyu@amazon.com>
 <20240811230836.95914-1-kuniyu@amazon.com>
 <20240812140104.GA21559@breakpoint.cc>
 <CAL+tcoCyq4Xra97sEhxGQBB8PVtKa5qGj0wW7wM=a9tu-fOumw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoCyq4Xra97sEhxGQBB8PVtKa5qGj0wW7wM=a9tu-fOumw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jason Xing <kerneljasonxing@gmail.com> wrote:
> > I don't see how this helps, we need to wait until 'stolen' twsk
> > has gone through inet_twsk_kill() and decremented tw_refcount.
> > Obviously It would be a bit simpler if we had a reliable reproducer :-)
> 
> Allow me to say something irrelevant to this bug report.
> 
> Do you think that Kuniyuki's patch can solve the race between two
> 'killers' calling inet_twsk_deschedule_put()->inet_twsk_kill()
> concurrently at two cores, say, inet_twsk_purge() and tcp_abort()?

I don't think its possible, tcp_abort() calls inet_twsk_deschedule_put,
which does:

        if (timer_shutdown_sync(&tw->tw_timer))
                inet_twsk_kill(tw);

So I don't see how two concurrent callers, working on same tw address,
would both be able to shut down the timer.

One will shut it down and calls inet_twsk_kill(), other will wait until
the callback has completed, but it doesn't call inet_twsk_kill().

> It at least does help avoid decrementing tw_refcount twice in the
> above case if I understand correctly.

I don't think the refcount is decremented twice.

Problem is one thread is already at the 'final' decrement of
 WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

in tcp_sk_exit_batch(), while other thread has not yet called
refcount_dec() on it (inet_twsk_kill still executing).

So we get two splats, refcount_dec_and_test() returns 1 not expected 0
and refcount_dec() coming right afterwards from other task observes the
transition to 0, while it should have dropped down to 1.

