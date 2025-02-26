Return-Path: <netdev+bounces-169754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0AA4594F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5595B7AB7D0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A7024DFF5;
	Wed, 26 Feb 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gawkHVBh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D98226CFB;
	Wed, 26 Feb 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560398; cv=none; b=D47qNy2w7JwRimRxl1EnoUwE2g5mlX7kO7nw/fzKTLe5Q2/JdN4RtZtBc2AIDd1FGjq9usfSbFbIG+38A8FOgjDpQEz0rVst7IXBwUCSqjbarb533s80Aq0axQQoNSoGRDyJ0ztnNZcDqradb30JbY6SRfs64qr4DPAyuBTfd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560398; c=relaxed/simple;
	bh=TxuUgvu/4XoWKnr5OA6wVvPLNlZWmkf32lJHYdesfPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F75304hwgQyrF2wnhSTw4sFO37s61cS86dXnCQ17MkEJIGBK+IxbPLc8wOuVDA03TZ5I8/WD5nkJILNG6vBZUbi05s82Rb5vaW4271AVkA9wf56Rflp5eEXzaWllUE1I0n4WV1dOUjE1jTAGA3aClsLPsVzSVk9yRJ3nb1NP6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gawkHVBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795BC4CEE7;
	Wed, 26 Feb 2025 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740560397;
	bh=TxuUgvu/4XoWKnr5OA6wVvPLNlZWmkf32lJHYdesfPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gawkHVBhBAFGy6vwQbloOlL0ZpcFbmyIQ1VAu+osU5SZnfKQ+0nkQvhpyNrMzk+Po
	 uWB/Z+NNs4dR5xinr3Bwy1nQm6mG5SPTnKFklJjHbimG2K6KyqZ0fUDN3RrRoSi6ja
	 ijrI/LW6rThrfkmut/XLLHT5n4E368WIK87X9L/ilAaj40COybKSAvHhP1y12CffBw
	 SAu8GhYMfjMwvhqR0D1Me2b77yBP52zOZ8NNm4eD82Q2Nqt795NKbSTJK/RdgcPkz0
	 tzhelurlDP5R5beXu/OccNLaJ9lCWiL00sFGFWhs4rANAWnAy0uWK6AaBYhm7Vi53c
	 nCWnIaKseXR1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2B380CFDF;
	Wed, 26 Feb 2025 09:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] tcp: Defer ts_recent changes until req is owned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174056042930.623394.10264696508717158233.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 09:00:29 +0000
References: <20250224090047.50748-1-wanghai38@huawei.com>
In-Reply-To: <20250224090047.50748-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: kerneljasonxing@gmail.com, edumazet@google.com, ncardwell@google.com,
 kuniyu@amazon.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, zhangchangzhong@huawei.com,
 liujian56@huawei.com, yuehaibing@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 24 Feb 2025 17:00:47 +0800 you wrote:
> Recently a bug was discovered where the server had entered TCP_ESTABLISHED
> state, but the upper layers were not notified.
> 
> The same 5-tuple packet may be processed by different CPUSs, so two
> CPUs may receive different ack packets at the same time when the
> state is TCP_NEW_SYN_RECV.
> 
> [...]

Here is the summary with links:
  - [v3,net] tcp: Defer ts_recent changes until req is owned
    https://git.kernel.org/netdev/net/c/8d52da23b6c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



