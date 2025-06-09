Return-Path: <netdev+bounces-195894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF23AD29A7
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9EB1882C57
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6B1D89E3;
	Mon,  9 Jun 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHjSux5H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568551519BA
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509403; cv=none; b=UDaVBQltMpbqgnLQ4lDGm/gFTEtpFy/spDH6kH6NJcOy7gpsWD7f3PYX/tsARESyzUoYU7fqBxCy7Hy835jRfR5B583LqN6hjwYit1yOipAmzX0DU6aqdvRxWPMifN+78RrWCpgrMYbiMhZ4vZlq+vZAJLCvuBZKGqSmVyzy2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509403; c=relaxed/simple;
	bh=lmgZt7awv6ki0+3MJB+gj+R8pdTSGkFvFwudFg96/04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ynp6ajLJqMqXT63ZUqkwYQYeyk0XKGSWRMQBXNNGpGTIadLJQiWVG4dPBBf6PQm6Levteniq+0MMPFxGVCxQ0RFwSev8xzXm4TcQ5nvKRru8pzjQvI4GlY548RYEHdUNRznz/R9chKcqM4ihYAPZhnsh8nw96wWbp+3x6mrVtkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHjSux5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA6BC4CEEB;
	Mon,  9 Jun 2025 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749509402;
	bh=lmgZt7awv6ki0+3MJB+gj+R8pdTSGkFvFwudFg96/04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oHjSux5HVgjAwVO3LqHt1thnCLa7VqX5cflST0t8TYVjraN2O9uX4kriQkEIc8iMY
	 /u12vW8A1Pxk2P5DWJXFPFrXVr3w6JDyeKFJm2P1L9sDl22V79cZzGZT+NTVASvyNb
	 tAMHrsz3KgElhuCNHWlboBsKIxjj/Xu4ab8FuXOH4MksbPhry/d4rlN4HT9nNa7yrb
	 3ke8K7LbrGqB+/u7JfyqtfYXj9CxTW3xVmeHJ4Q3sSqLLoltA0kMgjp/mr8lxQorwG
	 lLfnMJ3ufKoKmkjUAqmtg7e1JzPSmJtLxM4Vch2aoQ1vF84gbjqFUTTEdrfOO26xYI
	 EXXZnrISbcXPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCA3822D49;
	Mon,  9 Jun 2025 22:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_sfq: fix a potential crash on gso_skb
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174950943350.1577535.9819128012531579233.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 22:50:33 +0000
References: <20250606165127.3629486-1-edumazet@google.com>
In-Reply-To: <20250606165127.3629486-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 toke@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 marcus.wichelmann@hetzner-cloud.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Jun 2025 16:51:27 +0000 you wrote:
> SFQ has an assumption of always being able to queue at least one packet.
> 
> However, after the blamed commit, sch->q.len can be inflated by packets
> in sch->gso_skb, and an enqueue() on an empty SFQ qdisc can be followed
> by an immediate drop.
> 
> Fix sfq_drop() to properly clear q->tail in this situation.
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_sfq: fix a potential crash on gso_skb handling
    https://git.kernel.org/netdev/net/c/82ffbe7776d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



