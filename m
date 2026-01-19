Return-Path: <netdev+bounces-251120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7AD3ABB4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 208193009253
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11F3644D0;
	Mon, 19 Jan 2026 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh6dozxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766235C1A0
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832569; cv=none; b=h/kqwootvj3Nu7wR+CE+vEOYaxXqeyK+KOZWnRWYd5QY448jGZuspyNcEufMbfzI3aJfDxMOGRuQTzts3IvRBgn/ICP1NKnncYWJrtKMXSY0GwF837ZrkSPNoQN9Jg4YGGkKEPdmUJ9PgSlrKGSiQB0B+j1aFfwggn710l/A6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832569; c=relaxed/simple;
	bh=SkF1fRiMvz80DrYwLS5zkrf4jjOADfRiN8RZM2e8wWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BRKGLeGTQS8cP0ErEf119pNCphkWvsPp6bdPXjZWO3NsduLAB8nqKdVU+ndFyjIQ+xSgWTQKHajsraU+2WNBFIO61wX++Z7CBgmlcRjVQpbms387p7OUPcZJ6XNiS5YE6L1iSVIizQZKQucleqFbzrgQNZ19eL4iu4YH436V3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh6dozxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB602C116C6;
	Mon, 19 Jan 2026 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832569;
	bh=SkF1fRiMvz80DrYwLS5zkrf4jjOADfRiN8RZM2e8wWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nh6dozxT2RE2Dr1wXAvtWqW/T4XORVZPoHAfV4iagqisvSvrnesQnZFIUMR63tfD0
	 RpngvBjEDo8Cw6dv7Cev5nAiILQ+sGggpAlnIrWuqpzNndSFXD86mGeJutP+10J9w7
	 UtHuP7YiuLlDw3M1DvI+KGWyT1XsEUPAfyK25gHNmdC0VWIHCW8pf1iN3YWhlvfybD
	 s+1HUxevjXaI4O0uweDXVL1EgC05rmgs2MOzCTa2cEMkhG8qlxjqVPWci+B3ROCw+x
	 JQQa/RYJYMwNpY02IgllZxkHiBY0Ned2aSkjPVmXAZTWN/jytfRRxiEw1mQlgPoV9d
	 WLiVTw8bXLOiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A993A55FAF;
	Mon, 19 Jan 2026 14:19:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: cake: avoid separate allocation of
 struct
 cake_sched_config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883235852.1426077.2358286619749506519.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:18 +0000
References: <20260113143157.2581680-1-toke@redhat.com>
In-Reply-To: <20260113143157.2581680-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 15:31:56 +0100 you wrote:
> Paolo pointed out that we can avoid separately allocating struct
> cake_sched_config even in the non-mq case, by embedding it into struct
> cake_sched_data. This reduces the complexity of the logic that swaps the
> pointers and frees the old value, at the cost of adding 56 bytes to the
> latter. Since cake_sched_data is already almost 17k bytes, this seems
> like a reasonable tradeoff.
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: cake: avoid separate allocation of struct cake_sched_config
    https://git.kernel.org/netdev/net-next/c/2a85541d95f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



