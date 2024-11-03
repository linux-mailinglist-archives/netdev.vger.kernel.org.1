Return-Path: <netdev+bounces-141344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564219BA824
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D41C21029
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071218DF7F;
	Sun,  3 Nov 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgN3M+x3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B8118DF72;
	Sun,  3 Nov 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667629; cv=none; b=mjES93aDHxV/ulbfdUqMdSvP/fe6kcbBSqDGIekW2PyxNdrIi3sReb7oG626cB6wIRELQEnnVxvo49vv/2pAF/bkaaXxbuoMKkk3wuD3a/HR6usLY6f+Q9RiwRwn3U6XQpxxr7WzRxIcKLeZCXAfMdIxQLYUYnk+XP82KzPG8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667629; c=relaxed/simple;
	bh=TYGRS940TrJHpokusUKB5Av+g8UBDKPW/f3O3tSweGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvLnBnlMnW9IME9upk/MTu1ljxa2pqr1dODETWS1LtzNp7iLr6E4Ak1PDt0S9F3FadbblGKUUpNrgwR2BOCiWyh3d756Zr2M2Naj6Fh33u1rYLmiGdxQbICH5XC0pqy9BoMJJWJpvAnJU5+LzDWELo4MiXcBFHQC4fQDMgDI8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgN3M+x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E2C4CED5;
	Sun,  3 Nov 2024 21:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730667629;
	bh=TYGRS940TrJHpokusUKB5Av+g8UBDKPW/f3O3tSweGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgN3M+x33UY4clQ6yPIJ+KJZRJS0hsD0toCL1j6ScCBWbOF6QDFqcdT+GhvCf88Kj
	 pmzOx0tiVntUhfZTe5MlByk6ebRjn0GJOr/Qn5g2FHEMAZFctlcfYzC/dS1cSKBXed
	 zvK06ugiw5fUe7rLBL22ZA+l9pnkSKB3fVmoonHtAAqRQz31yCuIXNJQbxXnVuCuaf
	 TdJByhdqpU7ZuvRBT+YcHi1bTs2SOdSKzZ5QXon1EW3XJSkeDwW5cQxSB/fL4LpnKN
	 i4EoyX8p5+zon9o60TUtWPZXNqz2WpzgJ0EfsxyLd4isb74k1SaQJadA7xZYeuS1La
	 WSBILR2KmHV5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE54238363C3;
	Sun,  3 Nov 2024 21:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tcp: Add missing lockdep annotations for TCP-AO hlist
 traversals
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066763724.3253460.10917413718186070591.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 21:00:37 +0000
References: <20241030-tcp-ao-hlist-lockdep-annotate-v1-1-bf641a64d7c6@gmail.com>
In-Reply-To: <20241030-tcp-ao-hlist-lockdep-annotate-v1-1-bf641a64d7c6@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 04:22:33 +0000 you wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> Under CONFIG_PROVE_RCU_LIST + CONFIG_RCU_EXPERT
> hlist_for_each_entry_rcu() provides very helpful splats, which help
> to find possible issues. I missed CONFIG_RCU_EXPERT=y in my testing
> config the same as described in
> a3e4bf7f9675 ("configs/debug: make sure PROVE_RCU_LIST=y takes effect").
> 
> [...]

Here is the summary with links:
  - net/tcp: Add missing lockdep annotations for TCP-AO hlist traversals
    https://git.kernel.org/netdev/net-next/c/6b2d11e2d8fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



