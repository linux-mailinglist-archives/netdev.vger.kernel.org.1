Return-Path: <netdev+bounces-218882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF8B3EF30
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD192C07EB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B05246781;
	Mon,  1 Sep 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWCvUHLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520D2356C6
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757403; cv=none; b=Qb9vs5Z+wdjdPJdtqXWaB5aoUFC1mnoHUn1PE15qEqrVtPZmNlJjNjFa0sXsS5z8YH9YJtmsnLMqWDrYHrXc5FFJUyxcwceA9ZBxOrb8s0lMFeTeXCXkYO8gHDyP9rrEhUMbhYTvxQxdPRbYjSvFwimk+s+J+7rS5CMgHVxlSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757403; c=relaxed/simple;
	bh=sDbewGhJAb9HegpO4oe5rARufmWn91tP3IjUlfMzMyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ePg81VjelFPzzvUttz3vh2ilKooRCnHe6MNPFj5ibkCl0FElMFE454o6h+gkuVjZCPrYz5nKVZ5GJkNy5z7/8hQ9F9BPa22XxSaMzRQX83DnUL5dWCWcL88LlK4Wh5dyUNdhs/JqZNvDSDApj4U1GSv4YusocwBIjyx3KKykl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWCvUHLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78D5C4CEF0;
	Mon,  1 Sep 2025 20:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757402;
	bh=sDbewGhJAb9HegpO4oe5rARufmWn91tP3IjUlfMzMyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lWCvUHLAdeFa69zJrhoiGyc+VZUkzAEyH85seU2B/hzIMaMIQmg68M47uAmh11t3k
	 Uz360oNs1OTu3GztUrPoEdO/QokXNKdomje7by1CrVfP+IeljCWV/w2lmsKncCggQx
	 /BdaSGQJZtXCfAFmY56nPrMMHrGEgUqgX4UXYUmFk/d1/MO9hQZWsaaLHHsRegT60v
	 LX0thx7GEHiGxXJIJgl6v48mCfUiDxgWZm7rkm9GsS14GVoOGHrrYGpzdDgi5HYDqt
	 qj9v4q+nzBZf7Q6SUjf9Qq6QqhzhcE186RXdYnK8cnwcfwZ+aNidb0cdRcc1vG+7CZ
	 K00V94N6VE9Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF04383BF4E;
	Mon,  1 Sep 2025 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] tcp: Remove sk->sk_prot->orphan_count.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675740851.3870710.8102289702059309815.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:10:08 +0000
References: <20250829215641.711664-1-kuniyu@google.com>
In-Reply-To: <20250829215641.711664-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org,
 ayush.sawal@chelsio.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 21:56:38 +0000 you wrote:
> TCP tracks the number of orphaned (SOCK_DEAD but not yet destructed)
> sockets in tcp_orphan_count.
> 
> In some code that was shared with DCCP, tcp_orphan_count is referenced
> via sk->sk_prot->orphan_count.
> 
> Let's reference tcp_orphan_count directly.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] tcp: Remove sk->sk_prot->orphan_count.
    https://git.kernel.org/netdev/net-next/c/7051b54fb5aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



