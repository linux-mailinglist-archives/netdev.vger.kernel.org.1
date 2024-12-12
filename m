Return-Path: <netdev+bounces-151286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED5A9EDE5D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101DB18890EA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BB17C228;
	Thu, 12 Dec 2024 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS6iw5ga"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75817BB34;
	Thu, 12 Dec 2024 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977217; cv=none; b=VGAilXcsJwzBhFhIsgMbQaqgDC6fxSu2wLe+4m3bdVdHhh2AtiQonJ/abXuhY2hBQnAQBPoncWtB56dacTYV6y3a9WvGb1AsXZMcsV3TcQcB022A/YFW2ClPiFZPgDrtFSoJ20CtcB9VTWAbnxl4+Xdeakcr3MtKH803BWLhz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977217; c=relaxed/simple;
	bh=00PQElO1Yl3XY7l6iyi7EpDlRCz232eSs/v1seez5lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFFq2AuRHmRaioieA90xklYsw6d3KOM/ZfoTwFWDWVmmdPLxnF9UQZDt2vV0TsENFWzv0YXoZjlJTLK0BqGBu0R/gRnvzF61ZXB6puypvJR1sTr9EMMMNxgqsYl+EMe7fEHQfeh+J0bPK6P+JR9QkZF4NOgEKfnEhkqd8nVZJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS6iw5ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BB2C4CED1;
	Thu, 12 Dec 2024 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977217;
	bh=00PQElO1Yl3XY7l6iyi7EpDlRCz232eSs/v1seez5lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lS6iw5galpFEP+W/NeT5SdeCtlqiOeepauMScM5gVSE501ep5aUacFGeGII5qXzp9
	 xWFrYmPPWeTD6B7h+IhTOlIX1lNw7x8UjLn27LYlfbWa+/sULpzCa36zVcCA8FfxeZ
	 p2OURXb+xY3SXhLwaJEGva5E89+Kzj9Y3OI6RyyJ4EijSh+Vp+HpsTMTLx8/mCQlQp
	 VN1mHiT5TdVRxhOM0/SlyGIJ6wFgw9S6R4SEWjfO4bomLQKiRy6Ihs/xV4U3pCHkNq
	 Ts7ri2MjFn6WL3UwpPC/dYFdM3mmrsaPxGCZMdjHqOZrmv/ykE3v0BCdVxibLVgyrp
	 kZfLtLiSMmK6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72081380A959;
	Thu, 12 Dec 2024 04:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] nfp: Convert timeouts to secs_to_jiffies()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397723299.1845437.2830741054085328826.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:20:32 +0000
References: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
In-Reply-To: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: louis.peens@corigine.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ruanjinjie@huawei.com, james.hershaw@corigine.com,
 johannes.berg@intel.com, mheib@redhat.com, fei.qin@corigine.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 22:56:53 +0000 you wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies(). As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> [...]

Here is the summary with links:
  - [net-next,v3] nfp: Convert timeouts to secs_to_jiffies()
    https://git.kernel.org/netdev/net-next/c/f87e4f243443

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



