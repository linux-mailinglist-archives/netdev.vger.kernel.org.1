Return-Path: <netdev+bounces-190729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E909AB8844
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF59B3AF608
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F968127E18;
	Thu, 15 May 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5pghWdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A672627;
	Thu, 15 May 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316415; cv=none; b=svqhlDMv1kMPq1wCSGajLXsFKS7oWCpcpKQ7jrVTcZhE9x0QAotgyeIZ/eHMFzOYi6cKK0cBFcWISUbqiGlTks/xNMYkKoowGkYwQ/Dr/xefovsxTE3GdP5e5Ow+bkAwjZHicH1HKUSWY7JZXnnrRTcNEsql9izG1yWkkZ3xhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316415; c=relaxed/simple;
	bh=sfdZjbewTMVNDoBJL5YoyIK2t0DemT88eUZ1JLMuztc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FKmYggi+BtxVE9gPG8MuZCGDwYWDeXnLT22wM97ZMm0mzvHacmiIz1mdsWk87WRk3RirNes8AXS5ZJfIlFoQTrX7+ZPY3Cdb9IruMhuHNuNRCDQDsNZDXQnpm16YpJsyPNj0Aefq5+ukjE0gyMl4NXkZFVi1qJ1wo1BmJ2U6GI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5pghWdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80F5C4CEE7;
	Thu, 15 May 2025 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747316413;
	bh=sfdZjbewTMVNDoBJL5YoyIK2t0DemT88eUZ1JLMuztc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K5pghWdTQar9e1XkR2CkizFk1jmHNrijTwo6Wl5L5G/BsqhqqZpNva3zaZp07S0lg
	 76hazJQweNSnlPGGMkrsAwjQFgFWEtOmfvFKK4+U0Ps0TzyIAAVVtc3slMwfLT7UpQ
	 i/xvama2nVcsZSKc7mc9mFmq+NbghyBWu72shGaGxcpmxhJgNVivTffAd9MwrCTAmL
	 QkqKjXEKnlGiFw01di0rJaWdFcyTn0VkQZHxkEI0KGY3pqHlmpwvC3I9dWrY7Q0Twz
	 DkV2WIaRfdzJuaX4X8+XX9a9rJqkK5ceCn6bHcj6aQBYr5Uzo32cdV90hoMuITxbWU
	 bApFlXwBzxccA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3425E3806659;
	Thu, 15 May 2025 13:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/15] net: Cover more per-CPU storage with local
 nested BH locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174731645065.3113565.10520070956038071992.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 13:40:50 +0000
References: <20250512092736.229935-1-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, tglx@linutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 May 2025 11:27:21 +0200 you wrote:
> I was looking at the build-time defined per-CPU variables in net/ and
> added the needed local-BH-locks in order to be able to remove the
> current per-CPU lock in local_bh_disable() on PREMPT_RT.
> 
> The work is not yet complete, I just wanted to post what I have so far
> instead of sitting on it.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/15] net: page_pool: Don't recycle into cache on PREEMPT_RT
    https://git.kernel.org/netdev/net-next/c/32471b2f481d
  - [net-next,v4,02/15] net: dst_cache: Use nested-BH locking for dst_cache::cache
    https://git.kernel.org/netdev/net-next/c/c99dac52ffad
  - [net-next,v4,03/15] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
    https://git.kernel.org/netdev/net-next/c/1c0829788a6e
  - [net-next,v4,04/15] ipv6: sr: Use nested-BH locking for hmac_storage
    https://git.kernel.org/netdev/net-next/c/bc57eda646ce
  - [net-next,v4,05/15] xdp: Use nested-BH locking for system_page_pool
    https://git.kernel.org/netdev/net-next/c/b9eef3391de0
  - [net-next,v4,06/15] xfrm: Use nested-BH locking for nat_keepalive_sk_ipv[46]
    https://git.kernel.org/netdev/net-next/c/9c607d4b6589
  - [net-next,v4,07/15] openvswitch: Merge three per-CPU structures into one
    https://git.kernel.org/netdev/net-next/c/035fcdc4d240
  - [net-next,v4,08/15] openvswitch: Use nested-BH locking for ovs_pcpu_storage
    https://git.kernel.org/netdev/net-next/c/672318331b44
  - [net-next,v4,09/15] openvswitch: Move ovs_frag_data_storage into the struct ovs_pcpu_storage
    https://git.kernel.org/netdev/net-next/c/3af4cdd67f32
  - [net-next,v4,10/15] net/sched: act_mirred: Move the recursion counter struct netdev_xmit
    https://git.kernel.org/netdev/net-next/c/7fe70c06a182
  - [net-next,v4,11/15] net/sched: Use nested-BH locking for sch_frag_data_storage
    https://git.kernel.org/netdev/net-next/c/20d677d389e7
  - [net-next,v4,12/15] mptcp: Use nested-BH locking for hmac_storage
    https://git.kernel.org/netdev/net-next/c/82d9e6b9a0a1
  - [net-next,v4,13/15] rds: Disable only bottom halves in rds_page_remainder_alloc()
    https://git.kernel.org/netdev/net-next/c/aaaaa6639cf5
  - [net-next,v4,14/15] rds: Acquire per-CPU pointer within BH disabled section
    https://git.kernel.org/netdev/net-next/c/0af5928f358c
  - [net-next,v4,15/15] rds: Use nested-BH locking for rds_page_remainder
    https://git.kernel.org/netdev/net-next/c/c50d295c37f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



