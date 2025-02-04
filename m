Return-Path: <netdev+bounces-162747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF0A27D20
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CC163868
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171521A42D;
	Tue,  4 Feb 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4vhqHy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F512045B8;
	Tue,  4 Feb 2025 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738703830; cv=none; b=hTGRfH7DuO8WuNg26IHeVb+MCw3bAhuDVZhQHpwRnzm29WlclXBvwo+C5y2/S9joiYl5gGgDiOtNbC9rJw9pNdiPc3ZwR73aIfyAhSyqK1w5MZuvh+oaNnY1SWS4KHqqPnFaFRpBPvLWPjsrWE7j0c0VB+Pq7gYcRZFfPMVpQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738703830; c=relaxed/simple;
	bh=dgYESBvyVKPW+BIlSZ9dkzgajbmqooXTYtHOfdP/Trw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZKABHfQVv58MYPZrveHPdga5Ow0dyaMwDlwOdVQnmwocYMMomrj2f8jzEMKQ8TTn3PxRpyQjmoNEWZ2kB5nmRdCMhdpFCeb9givelbD7vJel/kBDVQQPorRNsiN7KbwsaMfR7b2wkkBycIcJVQ/eQjikgIMuupu9wXbpneqm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4vhqHy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D23C4CEDF;
	Tue,  4 Feb 2025 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738703829;
	bh=dgYESBvyVKPW+BIlSZ9dkzgajbmqooXTYtHOfdP/Trw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=l4vhqHy9P40wFiSSikBzW55T2yX8KL9TmlLaaFjnOIOZPIkCHwCFL4gyfSJPrR8xA
	 N+eVxB04bZSZFBABZzbavKwFF5TrJKDj5goWRZLcTlwBn+r1Wabp7IoLQUL8UXjx+o
	 ck6yS5cb4XI1C7edcCfTS/yQe3XjfaQKk5isQ6p5dERaux6CRk8w8s+wOVG1WA7dAq
	 RhZTDK6isQJ/SXUTrB7mOW8KM8ieUDyRrJaeYAUHm3lCoXOFP78Y6NuA5yQuZJS1ss
	 xTQMJzVWPRBe6uLsYgAPdK8vd3DjE0396crCMrttpaWjoxEprSOFTN3aESJJAdCV5l
	 RuSJcSaO4wwtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD2F7CE028A; Tue,  4 Feb 2025 13:17:08 -0800 (PST)
Date: Tue, 4 Feb 2025 13:17:08 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	rcu@vger.kernel.org
Subject: Re: [PATCH v3 net 11/16] ipv6: input: convert to dev_net_rcu()
Message-ID: <39a1fde2-63f7-4092-870f-ae20156fbb9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250204132357.102354-1-edumazet@google.com>
 <20250204132357.102354-12-edumazet@google.com>
 <20250204120903.6c616fc8@kernel.org>
 <CANn89i+2TrrYYXr7RFX2ZwtYfUwWQS6Qg9GNL6FGt8cdWR1dhQ@mail.gmail.com>
 <20250204130025.33682a8d@kernel.org>
 <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJf0K39xMpzmdWd4r_u+3xFA3B6Ep3raTBms6Z8S76Zyg@mail.gmail.com>

On Tue, Feb 04, 2025 at 10:06:15PM +0100, Eric Dumazet wrote:
> On Tue, Feb 4, 2025 at 10:00 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 4 Feb 2025 21:10:59 +0100 Eric Dumazet wrote:
> > > > Test output:
> > > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/61-l2tp-sh/
> > > > Decoded:
> > > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/978202/vm-crash-thr2-0
> > >
> > > Oh well. So many bugs.
> >
> > TBH I'm slightly confused by this, and the previous warnings.
> >
> > The previous one was from a timer callback.
> >
> > This one is with BH disabled.
> >
> > I thought BH implies RCU protection. We certainly depend on that
> > in NAPI for XDP. And threaded NAPI does the exact same thing as
> > xfrm_trans_reinject(), a bare local_bh_disable().
> >
> > RCU folks, did something change or is just holes in my brain again?
> 
> Nope, BH does not imply rcu_read_lock()

You are both right?  ;-)

The synchronize_rcu() function will wait for all types of RCU readers,
including BH-disabled regions of code.  However, lockdep can distinguish
between the various sorts of readers.  So for example

	lockdep_assert_in_rcu_read_lock_bh();

will complain unless you did rcu_read_lock_bh(), even if you did something
like disable_bh().  If you don't want to distinguish and are happy with
any type of RCU reader, you can use

	lockdep_assert_in_rcu_reader();

I have been expecting that CONFIG_PREEMPT_RT=y kernels will break this
any day now, but so far so good.  ;-)

							Thanx, Paul

