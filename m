Return-Path: <netdev+bounces-167908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55BA3CCA0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4D1671D5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB092580E1;
	Wed, 19 Feb 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcgLxX7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E241AF0B8
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005326; cv=none; b=KSNyOQpS43PkUGo/0WMJp/nn6i3l+JPAar7y5FphrG5uPyM8+puXcsp3c1lhIT9p/wo4Y1InKpgIMRvDXmJaw+hWsJm9Bl4N/5fnJs3w/EmAjIZxLQV/T1hm0RGw3PFLPvbZmd61m8rt+qp/ueeWjzAW/EtvQ5JnJRgRRRR+1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005326; c=relaxed/simple;
	bh=l8XAw9mzoQ+2egywoDGWQjzJIqYaa0O5ZzYdk7/RfK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNDufLxEaqfboggw8xw79pevC9VfOjnmN7OBEdi73lPfzHHGXk7wPk4yDfqGCQud+WF9wkXDKg/3WPBxn150Cz1RPqgZmaSIqU4EQY4Xp/TAqnK7lFxBv9mFOUYljj1K2+l7wl1fmdAKJKbxae6aTeGRMD3IsicCwNjQn9SnGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcgLxX7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFE5C4CED1;
	Wed, 19 Feb 2025 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005325;
	bh=l8XAw9mzoQ+2egywoDGWQjzJIqYaa0O5ZzYdk7/RfK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcgLxX7NEjrAsZlpToKbL0dCUZhJbHVT27JH6EvpBhREDjqIImH+d+IGC46FmZTjg
	 R7YvpPTPxV2jaLzIva9nKapyBd6ebMNZ65JgdxC52pbKPymgPr272qsgJkkYJhqeO9
	 tyfrbCslmnFHqEyTSmag2S2LawjyFusA601H9UN79u4S3Y94cSlLEI/XSeAgnEPlsT
	 LbT9Bx6dIZ5LoXhjzA3amhp2H5fZuJJFn1oNMZyM3Lqx6zZFsfleYtkg2eDoAIYnVV
	 eYq7UJCfnvUnZ3RlViibI/51VkFZsbemrUKz7ivb5uHQAcSf5yABFRbPF3ZaKKy8HJ
	 yPZw13pB4V2Qg==
Date: Wed, 19 Feb 2025 14:48:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for
 a local process
Message-ID: <20250219144844.1206b1fc@kernel.org>
In-Reply-To: <Z7Yld21sv_Ip3gQx@LQ3V64L9R2>
References: <20250218195048.74692-1-kuba@kernel.org>
	<20250218195048.74692-3-kuba@kernel.org>
	<Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
	<20250218150512.282c94eb@kernel.org>
	<Z7Yld21sv_Ip3gQx@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 13:39:51 -0500 Joe Damato wrote:
> On Tue, Feb 18, 2025 at 03:05:12PM -0800, Jakub Kicinski wrote:
> > On Tue, 18 Feb 2025 16:52:39 -0500 Joe Damato wrote:  
> > Then we can run the helper with no arguments, just to check if af_xdp
> > is supported. If that returns 0 we go on, otherwise we print your nice
> > error.
> > 
> > LMK if that sounds good, assuming a respin is needed I can add that :)  
> 
> That seems to fine; if you do decide to go this route in a re-spin,
> would you mind also adding a "\n" in the fprintf after "ifindex
> queue_id" ? Sorry I missed that on my initial implementation.
> 
> That missing \n was mentioned by Kurt in another thread:

Will do!

> > > Separately: I retested this on a machine with XDP enabled, both with
> > > and without NETIF set and the test seems to hang because the helper
> > > is blocked on:
> > > 
> > > read(STDIN_FILENO, &byte, 1);
> > > 
> > > according to strace:
> > > 
> > > strace: Process 14198 attached
> > > 21:50:02 read(0,
> > > 
> > > So, I think this patch needs to be tweaked to write a byte to the
> > > helper so it exits (I assume before the defer was killing it?) or
> > > the helper needs to be modified in way?  
> > 
> > What Python version do you have?   
> 
> Python 3.12.3 (via Ubuntu 24.04.1 LTS).
> 
> I can re-test with a different version using pyenv if you'd like?
> 
> Are there docs which mention which python version tests should be
> compatible with? If so, could you pass along a link? Sorry if I
> missed that.

You're good, sorry, tests are supposed to run on any non-EOL
version of python.

<snip>
> [pid 448278] 18:27:15 kill(448303, SIGTERM) = 0
> [...]
> [pid 448303] 18:27:15 +++ killed by SIGTERM +++
> 
> But pid 448304 is xdp_helper, which is still running and should be
> the one to get the TERM.

Very interesting. I dug deeper into this, and it turns out its shell
dependent. I'm guessing you're using one of the cool shells, I use
bash. bash does a direct exec for "sh -c X", other shells fork first.

I'll add a warning in bkg() for combining shell=True and terminate=True.

> I have no idea why this would be different on your system vs mine.
> Maybe something changed with Python between Python versions?

More digging still necessary here, as NIPA also runs on bash.
So your problem is different than NIPA's.
NIPA runs:

  make -C tools/testing/selftests TARGETS="drivers/net" \
	  TEST_PROGS=queues.py TEST_GEN_PROGS="" run_tests

which runs thru a layer of perl for output prefixing:

	tools/testing/selftests/kselftest/prefix.pl

which in turn send a SIGTTIN when we call read(), and hangs the helper.

> > We shall find out if NIPA agrees with my local system at 4p.  
> 
> Sorry for the noob question, but is there a NIPA url or something I
> can look at to see if this worked / if future tests I submit work?

https://netdev.bots.linux.dev/status.html

With the disclaimer that we discourage people from looking at it. 
It tests everything on  the list combined, we can't support the
corporate "try until CI is green" development model. Not that 
I'd accuse you of such practices :)

