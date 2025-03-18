Return-Path: <netdev+bounces-175715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C3A67381
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4873B242B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAD20B7FD;
	Tue, 18 Mar 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf0+86qP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0920B7F7
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299799; cv=none; b=KLywQyAPCwHNMr+8vnhWuHyp+n/D4C5914++HM79wfVjF5Va5SZtoIkU5DgYYAvK0U1gVz1SD0DKuFgTf7upR5woxEt4YRrGrcFfCzAfRRCIKj0L6zYJrYCvEh71/7wO0KycDwfwO9H/U8TuZIXUe0R+ffqbYVfLcvj32IKQ9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299799; c=relaxed/simple;
	bh=xhingSe6PoSnhm/ispz5VJMhXoJwraUnnt9f7RR25rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FBfpmslHU410hNDWuoY9w/k8G79Csay7OmKUYV01KotrkIpLiN1lKyuuv6y2smi6TjlVeescY3YKAyx/NkPjjkLyg4s26TLZm1IEcvO4TZc5ZL37V+r3azO919k3wmvOSK5Cuk17gBnS3xEKRdoe1k2e10aRln25qLwsNUupKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf0+86qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4EC4CEDD;
	Tue, 18 Mar 2025 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299799;
	bh=xhingSe6PoSnhm/ispz5VJMhXoJwraUnnt9f7RR25rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vf0+86qPvnZKtpjL5A56Z73Vho4SzAjX/I3yRKSgKvMhajHEDTAJzNAxZZ7IgmPyG
	 EDX5mnURVqYxfBJb5+uwhj+sLBjkwSDprpKNeaRRPxsrlAFCuCqc5FpYjfGuiJ8MMC
	 SY1uyvvp2/oNmE6bHE+op6iAUkIQrA0BX2ujMJ6g28bUziUnL/Aeq9b3soMma+4jlU
	 3vfTegd0Liyt+8dgYRcfZCKH3+oLKkHyaqEvH1RrgdKRj9k/PIAyomdFlKiKwLQcFT
	 1xdIEDITuqzx1sXIlczIPdZLjHJjcwpRym79sarGvDgEQpFH2VbHTssgGfK5OPYkb7
	 H/vwxE7CKhwKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24A380DBE8;
	Tue, 18 Mar 2025 12:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Fix memleak of nhc_pcpu_rth_output in
 fib_check_nh_v6_gw().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229983474.286709.15812774478421240563.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:10:34 +0000
References: <20250312010333.56001-1-kuniyu@amazon.com>
In-Reply-To: <20250312010333.56001-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 18:03:25 -0700 you wrote:
> fib_check_nh_v6_gw() expects that fib6_nh_init() cleans up everything
> when it fails.
> 
> Commit 7dd73168e273 ("ipv6: Always allocate pcpu memory in a fib6_nh")
> moved fib_nh_common_init() before alloc_percpu_gfp() within fib6_nh_init()
> but forgot to add cleanup for fib6_nh->nh_common.nhc_pcpu_rth_output in
> case it fails to allocate fib6_nh->rt6i_pcpu, resulting in memleak.
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
    https://git.kernel.org/netdev/net/c/9740890ee20e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



