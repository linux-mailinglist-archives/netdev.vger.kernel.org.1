Return-Path: <netdev+bounces-178448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91CBA77160
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A31679A3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41606213E8E;
	Mon, 31 Mar 2025 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueSYxfwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC473232
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463783; cv=none; b=BM2EnASLPaI5KWMegplOZ8dW0Qbe533uKVPKJ26YtdflmVcpNQttLZ1JY9CQBuRDS/SL17GFma24Z07tR9ER5XBFJCZJ4DfEeyy4c8PpsIEBxEJn3jamOaqdOMHWb3w02lbjct4Rt5S0R2SjG6099tmJKeUiyCmHVrc3lUzBN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463783; c=relaxed/simple;
	bh=3DfGrlKa2RNnQ1Og6pWmroaPxsI987MWRo/n+AUirew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxqgACOcN0TQQ6+WybsoErXded1KeQ1g8b4gIbdFBrzda28a12Uuw/IcwVt/wkNonmnIzF+n8QjfXM4ugrnwY/gjxWDKC+lkXhcbb9/2/wxjAYgRC4OFT9DnX9MJXLhIbzVXBWB9RHl/BncjkE+AHF6JVZFYgqmcGEqereKrXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueSYxfwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE5AC4CEE3;
	Mon, 31 Mar 2025 23:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743463782;
	bh=3DfGrlKa2RNnQ1Og6pWmroaPxsI987MWRo/n+AUirew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ueSYxfwb9+nbHK2MSRrzTBLVxENKfkpEUsc99IEU2q/Zblx2bEEdzX0yny7mBPr8K
	 feBk7024dZqip5E5/LB8JTauDUA/LHAcczxDJS5APuBTCEv0XVy6AOCOfbzC4c7TsR
	 nO8pEzz/lU+X+LgQRw3BYSDTNPlSGdqR0MB9m3dhyu1QoDcU9cHY7VHkrbS0N7u5u+
	 f6JH2G1++YJW2ogmMdbdO9yFplqXwUZXpcYR4uw9FKQ7x4TiZyIsulBwNEjviuf/fo
	 K0jUU/DqIEe8VVfWsXxmWmavUp4dr1wY7VrjHiDpOjHMcpazXCj64hKDUWqqGgmtwn
	 qpxZbQSa3Tg/A==
Date: Mon, 31 Mar 2025 16:29:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, <willemdebruijn.kernel@gmail.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when
 sk->sk_rcvbuf is close to INT_MAX.
Message-ID: <20250331162941.01e14713@kernel.org>
In-Reply-To: <20250331203303.17835-1-kuniyu@amazon.com>
References: <20250331185515.5053-1-kuniyu@amazon.com>
	<20250331203303.17835-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 13:31:47 -0700 Kuniyuki Iwashima wrote:
> > > Please do test locally if you can.  
> > 
> > Sure, will try the same tests with CI.  
> 
> Is there a way to tell NIPA to run a test in a dedicated VM ?
> 
> I see some tests succeed when executed solely but fail when
> executed with
> 
>   make -C tools/testing/selftests/ TARGETS=net run_tests
> 
> When combined with other tests, assuming that the global UDP usage
> will soon drop to 0 is not always easy... so it's defeating the
> purpose but I'd drop the test in v5 not to make CI unhappy.

Can we account for some level of system noise? Or try to dump all 
the sockets and count the "accounted for" in-use memory?

We can do various things in NIPA, but I'm not sure if it's okay 
for tests inside net/ should require a completely idle system.
If we want a completely idle system maybe user-mode Linux + kunit
is a better direction?

Willem, WDYT?

