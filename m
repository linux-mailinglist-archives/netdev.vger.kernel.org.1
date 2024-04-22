Return-Path: <netdev+bounces-90278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81658AD68C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E5A283CA6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41D1CD02;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2hN+pev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611E1CAB7
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821429; cv=none; b=Biur7hlUjijCwUwSzWiNwo1bmfuHMtrjVxl/FRL0rcJ6ppa+JqhCqHAHkmbd240bjY8+6Ow7w03i9635C5PM0RUlVL/umEfbcINDfSpjzMXvCRC8WpBkDtQySlVZ4v8OJBeqHU31k65UHKxx+O34KHfpw7QBo9DAVAcyQsV++0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821429; c=relaxed/simple;
	bh=N/d0sIq3usjTgzhwvfpGjkazxKQtPQ5XDicL31jfL+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qqIE7lB74cwql2brTIBus6Rk0AB3i0KN/FFxl3oeSB6UREExIydUUY5zKEBugN+aZ0IXzeJmJNaEP0uBWnaiyl83m27hGhUUY3mu8AP0Axx//b5PYKLufcM13szdUZ5avNBlO3RJCScjYsM+TJX1R5dkivkelpU/db+jL7VS5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2hN+pev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36FCFC32782;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713821429;
	bh=N/d0sIq3usjTgzhwvfpGjkazxKQtPQ5XDicL31jfL+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y2hN+pev0qCfYYjRQw1Nk2wEf4CLvYyagy5R7urLIZWa7QRhKqyHLxSqDNDykbQsX
	 eCoVpQdH7lmyQlhizvQMGFgmsecEsKYUcAskDNg+kAOCPnBv2rukVI4FlxnmB+p+qW
	 0C11fh1E88IzoH2EtlUa0Bv/5eLko1ow+ViRO+epTOcLhOvq55CfiSNFjlgGJLQ4Jr
	 SGydmDb5kM5PLYDNuvNl/Q1X0YTxyR5BfSrgJ+ShFD/DIdXaEUCizQNKZoQXa/vyvj
	 t6TmjxaWS77ks70BYw3pZVB7+0wG79T0d//STzUVKfgsRVmMakke0KqAAN6ATtMZUv
	 MF8eZDH2OGxMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19AD4C43440;
	Mon, 22 Apr 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: avoid sending too small packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171382142910.1995.3581375406057427614.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 21:30:29 +0000
References: <20240418214600.1291486-1-edumazet@google.com>
In-Reply-To: <20240418214600.1291486-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ncardwell@google.com, yyd@google.com,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 21:45:57 +0000 you wrote:
> tcp_sendmsg() cooks 'large' skbs, that are later split
> if needed from tcp_write_xmit().
> 
> After a split, the leftover skb size is smaller than the optimal
> size, and this causes a performance drop.
> 
> In this series, tcp_grow_skb() helper is added to shift
> payload from the second skb in the write queue to the first
> skb to always send optimal sized skbs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: remove dubious FIN exception from tcp_cwnd_test()
    https://git.kernel.org/netdev/net-next/c/22555032c513
  - [net-next,2/3] tcp: call tcp_set_skb_tso_segs() from tcp_write_xmit()
    https://git.kernel.org/netdev/net-next/c/d5b38a71d333
  - [net-next,3/3] tcp: try to send bigger TSO packets
    https://git.kernel.org/netdev/net-next/c/8ee602c63520

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



