Return-Path: <netdev+bounces-206190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A1B01F56
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12091C203D5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657F2E975D;
	Fri, 11 Jul 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g86BiwWC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231852E9745
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244801; cv=none; b=OQ2haUM2NUC74RSj7I7XNh9zIEQ+AHKjf2z3cKEKHYt4DO0EmF3EkNkvec1STFOmlMLRmK7fB0cruyw6q+0x+OdNWmmva0onKtEyTwLe1NKVdUcq/DCpZGMOERuucoipsbhuhrz/kS+P+md97l/BGQpxtAiKXfZl5qwdnGb2JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244801; c=relaxed/simple;
	bh=n/ztxWWH8YX4BQNpqgSMZwiVTtS9ggIx2KJ5A9xAD5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fB7StDDikjozNHbeWXG4pLHe/3CnAqUA9AtXldXic3aQG7xGawLl8UHUO/KrnHbnvYmDUcVWEVYj80RIPoDISUYh3QNeEKlgQ2rNgSfwKzK2RYgtYMgyh1CLdc9vyHFbjqQGTZhhOHkHdV5OafA9Sjl64snYYVfXmEVtcKNJJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g86BiwWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B78C4CEED;
	Fri, 11 Jul 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244800;
	bh=n/ztxWWH8YX4BQNpqgSMZwiVTtS9ggIx2KJ5A9xAD5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g86BiwWCz14UkT6ZR/iTFTiAm03GIzCUkiLF5yf7NkRbo0jbQM4b1hHrbsHwNG4pl
	 4yxAIoC/HWKZ7fRoeyV0Ca/JOm+q2WTJz1maY7bF0Nj4jCbW1wmbqBy97Zkgalhbpw
	 tZd01wnotGQJzYKaU/TGakHeX59M+0RJKCRivqmK0MPmVkQ/cgDU8BDHMjwW4VyFYP
	 bt9uOtWngfhPoLRDHZPtuIohtMILmrKvjOaz9Kn7ASFFnqPMyyM854vgGO7tIKUnXv
	 t1R3i0Gj1smdMnldAW/UcLXYDB5QShB9lmcDFWG/k4F2NQM2nt1TKhKI2lcbyN3cha
	 /69TURXCjnepQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAB65383B275;
	Fri, 11 Jul 2025 14:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: make sure we allow at least one dump skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175224482250.2294782.17461362923703859683.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 14:40:22 +0000
References: <20250711001121.3649033-1-kuba@kernel.org>
In-Reply-To: <20250711001121.3649033-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 m.szyprowski@samsung.com, kuniyu@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 17:11:21 -0700 you wrote:
> Commit under Fixes tightened up the memory accounting for Netlink
> sockets. Looks like the accounting is too strict for some existing
> use cases, Marek reported issues with nl80211 / WiFi iw CLI.
> 
> To reduce number of iterations Netlink dumps try to allocate
> messages based on the size of the buffer passed to previous
> recvmsg() calls. If user space uses a larger buffer in recvmsg()
> than sk_rcvbuf we will allocate an skb we won't be able to queue.
> 
> [...]

Here is the summary with links:
  - [net] netlink: make sure we allow at least one dump skb
    https://git.kernel.org/netdev/net/c/a215b5723922

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



