Return-Path: <netdev+bounces-121969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4DA95F6EA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C62B2245C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1719882F;
	Mon, 26 Aug 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4f8MMCs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7E198A19;
	Mon, 26 Aug 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690433; cv=none; b=BkjeLO14nXC9Eopu2S+dWu83iOGkHb01rHR80sQVFjjtstH/FCoGAG+LMvOau40U5kj1+gKcpl02LqCgBaG/X/4nokNiFLNRXLFILg6r5xZn5m2EmvIMetFb6nUxNdEJyBh2sHJdG/ycx2m2/57OvaCNOxRfF/2K3FxmvoDHC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690433; c=relaxed/simple;
	bh=/16y4MbvBWx7AmX9u2rF9LhJgyijTDXEyB/EasBtFvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LZCVQO7iKeBiH6SkzB0v+f73M5Z3PfNcmI2FSf4oktjTm77OJCDXSqkWqykdCwFGbvGhw7+rCYIzSnSgFkAeTbY133cC2e2hhDuz6ilmB/msbhS/UquBvkBCGL6T4HNf06QuEIDLNSV9/AfD04YGPqgx5ybp3Ffa/QioCnXCgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4f8MMCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2284C52FD8;
	Mon, 26 Aug 2024 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724690431;
	bh=/16y4MbvBWx7AmX9u2rF9LhJgyijTDXEyB/EasBtFvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A4f8MMCs4gdiuxmv9K0GalAvkSLXQvfKPGR53bS1lz7NdVqk+YYB7D16o188jxorc
	 YyjWaanIqFoCgn1VW0qnU5ljFbZeqNSgBthmpavhc5nW51cfXnHpR86s9b1jmAtUiy
	 zMzG80eN4dG5mm9i1ljHqxJ9IYe9x5omRcpVFXtCGWvjrtY2UOWC9iUk3r4FzR0jm4
	 4qMFmEtXr9e5px86xDZLwN5hrKjXIF7lRBM4w5LMDjURCVC6v3BZdRLCOlSx8KUBxO
	 1G3u4snEl7yhNvDRzOsNYcXcCTNOzAYsErSkbzcHM9tjQuz8YQBjkHSnwGWuy/iFBV
	 gHhogHboZLxKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD083822D6D;
	Mon, 26 Aug 2024 16:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] netconsole: Populate dynamic entry even if
 netpoll fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469043158.64426.9370838137438660997.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:40:31 +0000
References: <20240822111051.179850-1-leitao@debian.org>
In-Reply-To: <20240822111051.179850-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 04:10:46 -0700 you wrote:
> The current implementation of netconsole removes the entry and fails
> entirely if netpoll fails to initialize. This approach is suboptimal, as
> it prevents reconfiguration or re-enabling of the target through
> configfs.
> 
> While this issue might seem minor if it were rare, it actually occurs
> frequently when the network module is configured as a loadable module.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] netpoll: Ensure clean state on setup failures
    https://git.kernel.org/netdev/net-next/c/ae5a0456e0b4
  - [net-next,v3,2/2] net: netconsole: Populate dynamic entry even if netpoll fails
    https://git.kernel.org/netdev/net-next/c/908ee298c8fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



