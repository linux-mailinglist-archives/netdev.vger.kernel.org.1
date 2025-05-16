Return-Path: <netdev+bounces-191210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45413ABA65B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929837BB590
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0B27FD47;
	Fri, 16 May 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZY4g5rr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195F22DA15;
	Fri, 16 May 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436997; cv=none; b=leNvK0uNyH2xbyApiCZr8Cnv/mLUV33mCj2aOx2cmz5Ngnn8MPHwrFxriCLEyvOsJY0tgFkACQaSSt80PltynPFI1d00Mcc0n2akBNoaHn+1RqoufUUXvO8SWgZvplInbTAs7a3lHXdwQrVKuToJ52JTxkOaGU3dqMYol7bLmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436997; c=relaxed/simple;
	bh=MAym5avxV8paF9bk/hEqVYXCyDjiG8R4beX3gEUJ21w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zs02DypUdpCEvR/hwcQiQm1Wq6XdgzkQzgcxHzYzuAzgw49JfdRhCm4EZf4MDHoMCS7EGZ5zcArdquuwPm10qLrGra5W5DaNlqp7+nyMeAOBp0V+7Zx/GNY0c5JtUrPRLDbAtB5OyUDN+VlhLU7dqSCw+PcDb4LFYmDbGKaCiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZY4g5rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD6BC4CEE4;
	Fri, 16 May 2025 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747436996;
	bh=MAym5avxV8paF9bk/hEqVYXCyDjiG8R4beX3gEUJ21w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DZY4g5rrAQbnv+aWJ8If1G95x8OT8oG4bpbMRiJ8YjQU52m/JHKQNmRlT9DciKaSc
	 yBu3ZBq7jLjF0d08wh+IGdZR1lZcLzutmEztiatwHbaqh4emXG9kK+rQTgznzY3fuV
	 AbA3b9h7ndX0S5pfyPzbealqbwghmP+cnfMn3FZjcGoeqYpAJLPYDOU9XZ/VHPkIIy
	 AmnSmrUzJgSN5wdiWLPzGkSvMFWpObd13195zFzMor32SXH8tghNTfPn785FmB07dN
	 1r86lkfaLZ1m/9voOEi/8t3ecUlcQo/fBjK2lK5iEInKLNlvhI1//ZqcW9yurI2uRq
	 +DOZ5DU8rWnNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D253806659;
	Fri, 16 May 2025 23:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743703325.4089123.10626983491077048777.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:10:33 +0000
References: <20250515084848.727706-1-idosch@nvidia.com>
In-Reply-To: <20250515084848.727706-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 venkat.x.venkatsubra@oracle.com, horms@kernel.org, pablo@netfilter.org,
 fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 11:48:48 +0300 you wrote:
> When netfilter defrag hooks are loaded (due to the presence of conntrack
> rules, for example), fragmented packets entering the bridge will be
> defragged by the bridge's pre-routing hook (br_nf_pre_routing() ->
> ipv4_conntrack_defrag()).
> 
> Later on, in the bridge's post-routing hook, the defragged packet will
> be fragmented again. If the size of the largest fragment is larger than
> what the kernel has determined as the destination MTU (using
> ip_skb_dst_mtu()), the defragged packet will be dropped.
> 
> [...]

Here is the summary with links:
  - [net] bridge: netfilter: Fix forwarding of fragmented packets
    https://git.kernel.org/netdev/net/c/91b6dbced0ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



