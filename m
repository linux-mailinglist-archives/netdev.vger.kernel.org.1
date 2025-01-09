Return-Path: <netdev+bounces-156794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BFCA07D82
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95719188C33B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19091221DA8;
	Thu,  9 Jan 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsY5yZ+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714622256B
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440208; cv=none; b=sTDaRCombl2b6/ByawZYqSQ26N1iWSXVJLdSUwIlio+WBl+DovetMAQ4QtkErQ0FHIiCtUfZnJdu6zTllBTEOFGaTyUFjFuqkxD5Jjvf1Vg44Yfl3oKK0uXdL+lGSoE/bhEaijgBO7n4GsDHmr/AdMtbuyBVXw9olJQ4RUi5c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440208; c=relaxed/simple;
	bh=gYF/unUCBqQTAlkI6WDQpkZg0bioihJSmIQeUyPyIGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TbfLuW6tnKFTJ27RJ2J4uRJbM7D9fr1hlYtc3ixZ56fQpOuuI5/AO3jBtMV0Fs5z4a6w3aVLbxCrNmH/HTx3skhcbB2qOQHr1W0JV8lM/HvbvBd+Zq853G9YZiUXZyaGq7tsRepu9taRG3fZwo39KgOR1kZOiMRsXjH5kzdJ8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsY5yZ+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130D6C4CED2;
	Thu,  9 Jan 2025 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440208;
	bh=gYF/unUCBqQTAlkI6WDQpkZg0bioihJSmIQeUyPyIGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QsY5yZ+tAnwIxt93PZ22YbqvTkHYzW3cPoygIHS7ZQnBmWAvI1AuCPaswIDHLzKdq
	 C/B/ygRRXbARukY3CPS0qteP0k1l7Wu44+pVTvaHhPSAqEQXBqzlQYAzcV9s1Ez5YE
	 ccxzGm8guieFBaraTY70HXucEmlJFmlOA6fR/1qRItdFw360Z6p+/GgKAA4myGVJr/
	 bpEcUARqqOHT4EhoJABlzxOVHi8z+KL6mzqAVYDTwkq1dg1ptcJxvpAPlfE0nSZjZZ
	 yxroaUI9kRp7t5PF8x0bx/BEuhSKmafRU/TICFzznfiNmEIISIkkM2/09NyX7QLKI2
	 N1uL+h0P2EO3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2CF3805DB2;
	Thu,  9 Jan 2025 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] sched: sch_cake: add bounds checks to host bulk flow
 fairness counts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644022981.1439025.10283041006205138071.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:30:29 +0000
References: <20250107120105.70685-1-toke@redhat.com>
In-Reply-To: <20250107120105.70685-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, pabeni@redhat.com,
 syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jan 2025 13:01:05 +0100 you wrote:
> Even though we fixed a logic error in the commit cited below, syzbot
> still managed to trigger an underflow of the per-host bulk flow
> counters, leading to an out of bounds memory access.
> 
> To avoid any such logic errors causing out of bounds memory accesses,
> this commit factors out all accesses to the per-host bulk flow counters
> to a series of helpers that perform bounds-checking before any
> increments and decrements. This also has the benefit of improving
> readability by moving the conditional checks for the flow mode into
> these helpers, instead of having them spread out throughout the
> code (which was the cause of the original logic error).
> 
> [...]

Here is the summary with links:
  - [net,v2] sched: sch_cake: add bounds checks to host bulk flow fairness counts
    https://git.kernel.org/netdev/net/c/737d4d91d35b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



