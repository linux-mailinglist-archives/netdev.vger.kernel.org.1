Return-Path: <netdev+bounces-125484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7E796D51E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCF81F2A30B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C81474CF;
	Thu,  5 Sep 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNIyWuV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773B83CDB
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530429; cv=none; b=uDdYxQiRmqyf/Xkhege8b+1JWrX0eaF4T31DMRIa379W79+dX5CJkwBggsvlNKORI9dvKEWng2vnqvZ4ByiT4P1Lhj+sj9XVcuSwRHmZ1/YpAGoNpaVA/IwvBtNELl7qzHqzDmUbDGx6KBtIoJTeWJn7Wa3gbVtTzT6NTBJERbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530429; c=relaxed/simple;
	bh=9gCioDgSjBVjN3SziroHvotCnSdJ/pfwWQnuSLnFG14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hOTW/ovRY0ydd8P9H5P59ZuJrKWZl0dyatISmIRqf2vU6nBW76wGLFFF1x4qQPq1wbBQiJZaICC3IztWnLAdPqQNXNpNWMELXwPl30RXVAqDIEeXTLFwY7xGbYv7XazJr548K6eN+H1Ja/SD3YBJi8cQfw+2rnMPDwwngOR/o5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNIyWuV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59AC4CEC3;
	Thu,  5 Sep 2024 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725530429;
	bh=9gCioDgSjBVjN3SziroHvotCnSdJ/pfwWQnuSLnFG14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNIyWuV9EbRZUq3aI25gIRfbNu84ZeoPygOKdQ65mtTmczb/MUvniinIeW6mtu1yn
	 5IgR5C7KyRNPkF6dhvDUV1ZIAa/dGyqUI1vMaFZ7aJh9fBw1K0Z/29T0khJUk0VoxQ
	 WxLUZsJF8I0Cw+FQE72EpUIqnarO1zapEMkXhQWPK0EXeCyW+Ft2kJO2SQbRfaIY+K
	 R5hICbloQd8r0VsP3QdAXL7zupdhN4W+kPv2+oTAn4jKQXth/3L3HLVmk1aHQPinJz
	 rZdER4ZpodCMNawVaMHXVR2pOEn//6Zd3eA5P4X10MX+zRp6lLSGYMbW7cKWVaX4/+
	 Q4rnmQJQOLFdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECEB93806644;
	Thu,  5 Sep 2024 10:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sched: sch_cake: fix bulk flow accounting logic for host
 fairness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172553042950.1338142.999328518611522439.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 10:00:29 +0000
References: <20240903160846.20909-1-toke@redhat.com>
In-Reply-To: <20240903160846.20909-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, gamanakis@gmail.com, davem@davemloft.net,
 syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Sep 2024 18:08:45 +0200 you wrote:
> In sch_cake, we keep track of the count of active bulk flows per host,
> when running in dst/src host fairness mode, which is used as the
> round-robin weight when iterating through flows. The count of active
> bulk flows is updated whenever a flow changes state.
> 
> This has a peculiar interaction with the hash collision handling: when a
> hash collision occurs (after the set-associative hashing), the state of
> the hash bucket is simply updated to match the new packet that collided,
> and if host fairness is enabled, that also means assigning new per-host
> state to the flow. For this reason, the bulk flow counters of the
> host(s) assigned to the flow are decremented, before new state is
> assigned (and the counters, which may not belong to the same host
> anymore, are incremented again).
> 
> [...]

Here is the summary with links:
  - [net] sched: sch_cake: fix bulk flow accounting logic for host fairness
    https://git.kernel.org/netdev/net/c/546ea84d07e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



