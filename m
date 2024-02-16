Return-Path: <netdev+bounces-72345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD299857A2A
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01D51C218A9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822B241E4;
	Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF0Twjad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE082377D
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078826; cv=none; b=qyrwHPBHJuVq3v3rah8oK0PVvq1gG0BqnbIL8OyFUSN6cgCGX2NyTLBsYqNrM/5HUChASpLkp08UYRuBu+MDjn3bjcLwOmBlKbGmLwndffS8Oq+l+CKfSLGtm9VXj+i22p3wWJFiSJAL3cKqRvQ0jOZu6QLb9XyYof00OO6Q9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078826; c=relaxed/simple;
	bh=dsVz3a66cGXNXH3HKive+U53NRChX+1FLzoY6hly7F4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WkjwNo/hNYkKTuGurP+lj9WeF9I+sWIBya+y02uKv4N6dlE/2MHPCgxJR1CwMlKrSxh9xBz9mMfugIs5UsGUTeXIDYzLebcRZwWjcn01hcg+Ttg8EXfvhy+mtk5AzSa+KeCgrTjFYiEflpmMAW2Kx+FRBwA3PiwKDRdJjH9KX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF0Twjad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E673C43390;
	Fri, 16 Feb 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708078826;
	bh=dsVz3a66cGXNXH3HKive+U53NRChX+1FLzoY6hly7F4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EF0Twjadbz0IhwF0XN+HReWLoMvqJGyTcq18SldjqD2y2TEemylusj+SEwXa3t60U
	 u8SADo6+IOSkp1ciC79wET4O3t2CukpA3ZzWX0Qp4lkY2+l5cWJ2SA359XTSk15WdJ
	 3zNPbXVbQKlNuiywoaNGohwSw/+LK4fvv7t0idJNijd+peu9ztpAMRGN8LFRw4V9JC
	 0QXSwHTbMgravtzO4jyy+b9/gFJl57H/uKR83Sgmw6c1cFkwxJb+Xae4FpB8gReI+k
	 0oQNJcBqMC4aEO+1PDrO7jUlaRyklu018o5mpsFBgs4hx4jr2ZQopEJBSEZTCSPsUn
	 bO5rqU/AHBCRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFA0AD84BCD;
	Fri, 16 Feb 2024 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net/sched: act_mirred: use the backlog for mirred
 ingress
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807882591.14678.14888297610557827138.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 10:20:25 +0000
References: <20240215143346.1715054-1-kuba@kernel.org>
In-Reply-To: <20240215143346.1715054-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, marcelo.leitner@gmail.com, dcaratti@redhat.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 shmulik.ladkani@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 06:33:45 -0800 you wrote:
> The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
> for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> lockdep.
> 
> The problem as previously described by Davide (see Link) is that
> if we reverse flow of traffic with the redirect (egress -> ingress)
> we may reach the same socket which generated the packet. And we may
> still be holding its socket lock. The common solution to such deadlocks
> is to put the packet in the Rx backlog, rather than run the Rx path
> inline. Do that for all egress -> ingress reversals, not just once
> we started to nest mirred calls.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net/sched: act_mirred: use the backlog for mirred ingress
    https://git.kernel.org/netdev/net/c/52f671db1882
  - [net,v3,2/2] net/sched: act_mirred: don't override retval if we already lost the skb
    https://git.kernel.org/netdev/net/c/166c2c8a6a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



