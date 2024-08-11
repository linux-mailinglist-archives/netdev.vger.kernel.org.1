Return-Path: <netdev+bounces-117488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055694E1B7
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E568CB20E30
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8981798C;
	Sun, 11 Aug 2024 14:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51851DA22;
	Sun, 11 Aug 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388095; cv=none; b=g3wvR5n3y7T1wnzet3kzg4dPSyI+o0v4TImYrJg+CYsAo+Dfi63j1dX0Wc7dgqKgitq02Xg/IRHCt9HaOj3fn/thfzCcsh4G/qSElMQOpmP3muHUws2Eboi/sTwLZi3GKSirC/vzcX8J230HUf5avNrNZP51Ws05OlqifU3M4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388095; c=relaxed/simple;
	bh=zpNMteEMTs0lxqMYFV36vnyd4fQM3LiBFf4xu8Vtp4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDBfA0jANkDL0+8PVMHU5nwIhrebTRrB0f/a0/9SQMYTvT6zMIy593soqJ1tNYrulBH5hbdBsCgE7oUpJjrmBQps0NhBt+mZ73QCGnr9AWbb3aZsE7Jv4bwcr/mYT5yVz6qqJQ1eVx/Sy94cDmOHrVBLJ1tnci14P2stjVP7vBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sd9xz-0005Ri-4Z; Sun, 11 Aug 2024 16:54:43 +0200
Date: Sun, 11 Aug 2024 16:54:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Message-ID: <20240811145443.GD13736@breakpoint.cc>
References: <0000000000003a5292061f5e4e19@google.com>
 <20240811022903.49188-1-kuniyu@amazon.com>
 <20240811132411.GB13736@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811132411.GB13736@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> > I came up with the diff below but was suspecting a bug in another place,
> > possibly QEMU, so I haven't posted the diff officially.
> > 
> > refcount_inc() was actually deferred, but it's still under an ehash lock,
> 
> but different struct inet_hashinfo, so the locks don't help :/

No, fallback is fine: pernet tw_refcount, init_net ehash lock array. so
they same buckets should serialize on same ehash lock.

https://syzkaller.appspot.com/x/log.txt?x=117f3182980000

... shows at two cores racing:

[ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
and
[ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not tainted 6.9.0-syzkalle (netns cleanup net).


first splat backtrace shows invocation of tcp_sk_exit_batch() from
netns error unwinding code.

Second one lacks backtrace, but its also in tcp_sk_exit_batch(),
likely walking init_net tcp_hashinfo.

The warn of second core is:
WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

Looks like somehow netns cleanup work queue skipped at least one tw sk,
hitting above splat.

Then, first core did refcount_dec() on tw_refcount, which produces
dec-to-0 warn (which makes sense if "supposedly final" decrement was
already done.

