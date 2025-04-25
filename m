Return-Path: <netdev+bounces-185801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A73A9BC46
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE6C9A07A0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC676026;
	Fri, 25 Apr 2025 01:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H930ulVy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C924B34;
	Fri, 25 Apr 2025 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543991; cv=none; b=gNTJGJ02GmiNLeYSj1EYUMVef3GFtrpLccE1MmKjX3PqEqd9fTEHLdBiWBwAt80Yym9BYo2h2b3e0bL25zBWnRP52Bp1/AWq03MLqd3/r0lU+xw1eL4kGYwsZSrcJByparBnWap4DtfNRvJBREwuStLKTa2t4HaMuDoZ94Ua/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543991; c=relaxed/simple;
	bh=3aXn4GFQtveDfRQb7+Y9KE/jfbSHuF3iKkcJCpCNQbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGQni+KKo3+dfL7h7lBUYEzR/iQSv6PEVCPCM29MH6bOwkUeLd7S/kcmK+OLtlwBjXzWKTaBV+WY7qFZX5kmi93rGm2E3Tkc9ibgN0qx7Rp/zUR3nL3QFQFhJzZ+ZkbjlctlT/XZ1rBVyh1aJhVqO7Rk7u/2xdJPkDHH0YiKNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H930ulVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E3C4CEE3;
	Fri, 25 Apr 2025 01:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543990;
	bh=3aXn4GFQtveDfRQb7+Y9KE/jfbSHuF3iKkcJCpCNQbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H930ulVy+jDD75E+FubbfpxcwchKwmxBr+wsVG+Peys+PLX9I1BFYRfrsUNP/g1p6
	 Gyb/9GmJUKabK8g0ABczVvqgwxhouMTKu3qc0b2rAChX+/uiQ2QVFbFvJKb0q4DoYl
	 CgStN1KCSdbPETcMaB5axa5bHrWTAGnorNuuNeWrAvBK/HlYP0GMmDa4Vy2UAvINkp
	 nWrKQnVDJ9SCu9HLRxc1zKb4jGSuZMq+KyA3qWpPMpM9jEFqyAeivd/ZrnkiViBEcz
	 cnP2zRujE9mHyqMkTqUx+d+WvpuC0cnWlZ38lTZmEaCYIgYc2QxZCFEOR8Itd95plU
	 foN4kA6A1+bKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E13380CFD9;
	Fri, 25 Apr 2025 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rxrpc: rxgk: Fix some reference count leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554402900.3541156.14858766577157035968.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 01:20:29 +0000
References: <aAikCbsnnzYtVmIA@stanley.mountain>
In-Reply-To: <aAikCbsnnzYtVmIA@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 11:25:45 +0300 you wrote:
> These paths should call rxgk_put(gk) but they don't.  In the
> rxgk_construct_response() function the "goto error;" will free the
> "response" skb as well calling rxgk_put() so that's a bonus.
> 
> Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] rxrpc: rxgk: Fix some reference count leaks
    https://git.kernel.org/netdev/net-next/c/3a4236c37954

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



