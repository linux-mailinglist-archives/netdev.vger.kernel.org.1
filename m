Return-Path: <netdev+bounces-204766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A7AFC042
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577BD189CC41
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1581FFC48;
	Tue,  8 Jul 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDl6t4+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06839FF3
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939985; cv=none; b=biD4SGjxK7H66oVB/QhE+flLzQHe0pwoqGoaigsYOlE2yo72nan/pcQ1bLFSlXFZl7ln8nFCSCb9zfL0m9Fvn1p1wrPaizyWw+aMo16z69h3EWZIyzrAGXpMl8OADlm1D9xHFareZ2sUwjYZVenXw3rP0VyvPLYYcFuYRwBpEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939985; c=relaxed/simple;
	bh=To6aoi1Ngz9I6P4wMUvhMpv/xVYnmycS7GmBGlHcLDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TB5ygRiIIHJc8CogIMDxz8druHUM60HiiqWDgYXqekNniDGp+WZ+6FxrD8GoqXBJuj7CqCvE1OlY/2GAZwdjV0ZY1EqicCg8v2XKo1GwbRWM/cZNsz8lOr8rZf0cjBWX86l5QQDsdd1g+XcOOqZ45AyA6mNK0mQykEDiLpbVA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDl6t4+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E08C4CEE3;
	Tue,  8 Jul 2025 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751939983;
	bh=To6aoi1Ngz9I6P4wMUvhMpv/xVYnmycS7GmBGlHcLDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDl6t4+cSrt5yrPB7neNPVUI6ZVTBy4jzRrWUjrReh1UvVy9TiU1l5GU8gOWdMk3x
	 h4xQIwVlUfzcvpnTh4V1UIch91/5HLobAt/vseIDM/kO1GWAE0pyG2IE/dqXm9Wx4d
	 14fwtY9645Zzog+ADJlV8wzNB6SMzkYLVADD7VagHmlethzvHCN0CWxiskOCz+1vzx
	 foBf5Com/OBaXrNySG1tfrucpid6xay7+iWRcYO9IJOk3+O0+HknuQprszlAJCx+Ad
	 NACjPXIH+NtWXFncyOtBrA3UeVdg79TqITOMkxrf2hSphUgJD8mh7NJPLxxnrSYKmx
	 B6mn1KiHt3QCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1438111DD;
	Tue,  8 Jul 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tipc: Fix use-after-free in tipc_conn_close().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194000651.3541197.6022800124724678298.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:00:06 +0000
References: <20250702014350.692213-1-kuniyu@google.com>
In-Reply-To: <20250702014350.692213-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ying.xue@windriver.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+d333febcf8f4bc5f6110@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 01:43:40 +0000 you wrote:
> syzbot reported a null-ptr-deref in tipc_conn_close() during netns
> dismantle. [0]
> 
> tipc_topsrv_stop() iterates tipc_net(net)->topsrv->conn_idr and calls
> tipc_conn_close() for each tipc_conn.
> 
> The problem is that tipc_conn_close() is called after releasing the
> IDR lock.
> 
> [...]

Here is the summary with links:
  - [v1,net] tipc: Fix use-after-free in tipc_conn_close().
    https://git.kernel.org/netdev/net/c/667eeab4999e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



