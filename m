Return-Path: <netdev+bounces-170907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD5A4A828
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36E43B34C5
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5C8615A;
	Sat,  1 Mar 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd/kK81A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BEA179BC
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796798; cv=none; b=Ugda9TCD4SRLaDdQX+HEXBycHTJrU+JiVxNJCuBKdRCg/f/diQeq8uDrUHgB3eI0WGErEzgkLVcUDxyjEKyLbu/74cyPEjoIeHM5jdVW6kRFTvVRVBUJe6E0IL62Hiv8CAnN07uV0djHO+nzmjTAvuDiLHslpMXDlZWzRGtpIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796798; c=relaxed/simple;
	bh=8szNnGeizuKKLxW9elJ88zK0SoN1RjBgC7zk6JwQ9EE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IaPgBQ9YWH2smZSLTyHhgu/omSHT/mkIwaoH0HdFd7OPgM9JmEywyAoRSTFjWeGNHcilyVmwzdl9KM/JGGtJZEdmMkeCAfL/9NkVDgynPdHVzrWvWQupGcYTNzb+x6fgZvMLsFaaOtCAUE2D7rd9GbBTVHehAUaTCsrfnNlsbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd/kK81A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EE1C4CED6;
	Sat,  1 Mar 2025 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740796797;
	bh=8szNnGeizuKKLxW9elJ88zK0SoN1RjBgC7zk6JwQ9EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pd/kK81AEfufh8fYb6D0j2Xp/33qf0uhXjALLDQlzGfA4f2KGPsaFXDzpAnFpIaHi
	 XFKD6orE0wQlJjssjqP8hunGHAUWe1Y9UB4kc56UpBIABtPpOY3wkTcY8doCCYcgNd
	 BJuouBcfMFC5CNKwC1PLKZCdBDljdz/XfBDOUgHq1bMIzYdwP5KLyCQhvy0neO1TsJ
	 RJjpejpgtJ5BanzhEt5KS3oOmdQ3TZwUJMUnc2kVMLCX7hC8oTz5boVSIR2XBgDhgM
	 xQmi+O2bTrPjAwQDyF7nE0DIUW0a8baFg208n7l9HVJzoUgs4yuFcZqUE0ZwEUm7Z9
	 KMcKIFzNozESw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD50380CFF1;
	Sat,  1 Mar 2025 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: gso: fix ownership in __udp_gso_segment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174079682976.2344768.9019830127984502086.git-patchwork-notify@kernel.org>
Date: Sat, 01 Mar 2025 02:40:29 +0000
References: <20250226171352.258045-1-atenart@kernel.org>
In-Reply-To: <20250226171352.258045-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 pshelar@ovn.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 18:13:42 +0100 you wrote:
> In __udp_gso_segment the skb destructor is removed before segmenting the
> skb but the socket reference is kept as-is. This is an issue if the
> original skb is later orphaned as we can hit the following bug:
> 
>   kernel BUG at ./include/linux/skbuff.h:3312!  (skb_orphan)
>   RIP: 0010:ip_rcv_core+0x8b2/0xca0
>   Call Trace:
>    ip_rcv+0xab/0x6e0
>    __netif_receive_skb_one_core+0x168/0x1b0
>    process_backlog+0x384/0x1100
>    __napi_poll.constprop.0+0xa1/0x370
>    net_rx_action+0x925/0xe50
> 
> [...]

Here is the summary with links:
  - [net] net: gso: fix ownership in __udp_gso_segment
    https://git.kernel.org/netdev/net/c/ee01b2f2d7d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



