Return-Path: <netdev+bounces-66686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A878404A1
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529061F213B2
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948860275;
	Mon, 29 Jan 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuxlOh3J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA660259
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530227; cv=none; b=qPYayUt7Y3xgf0/SeK4JtmGE6D7W/fyc362CXvOPjibFQ5k53+e7Tsh6Kv3YxAJo37TTtdhbk2whMKSitFkSJq4mMpq1hjVuTB4hpdA2FLETIJLmxAe0Q04zteUo18Df5rSqQIaJHUWMaZUZXRlLTMH4Aj4PmDt8sRDWFRV4Z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530227; c=relaxed/simple;
	bh=8YA2FgbsekI/HLAKQrFlpL77L4R7NFzOtMr4krLFGLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3pKpHOXUPmiYtsr3NjKOQo0hgzdlhhg8eGr2nXxOv9lG+biaWh6tKgllObgUs4u62SwnAm5V/dw8Fi6DTHiYse+erO1Zi2U+BOJ+zTlBByKaCpXZIDevc3Cf0FsqFuabvRIBLMxaqF854QcW2EXPWwFEsR8tG3CpimBBFtBxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuxlOh3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A425EC43601;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530226;
	bh=8YA2FgbsekI/HLAKQrFlpL77L4R7NFzOtMr4krLFGLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UuxlOh3JpsfvdJeAqI9HjSZvIOprUTyIh9dZbO16JC1Tn4ok9uhGTwy7BbEpzYjQZ
	 p6RufoXrQEpdcBDi3SyQp2E+kzukR/R/MtnNemzSq88xEz9XgBeIXkU0vryGOuLKRz
	 UUKNPjo1FIDwHLj6aboOMRC1K6BTbx5cuUjBXodRuZsEGEwdFgPnwDgA8osofv8hlT
	 /3porHfQWAkUppQq+1Cv3qtU+o0x6swt3GqkV8o6wO3yo3s+rI1Y9OsBuCya/8elCx
	 bBVCLbsBZrJzW+HYSEzH0krnC2/NbuZL1VKft2L5/AQCrp3G2F6zSmqTsiZEK06n00
	 ui9/H42f8Kbgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FE86E3237E;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through
 policy instead of open-coding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653022658.12593.16621412774806621216.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 12:10:26 +0000
References: <20240125165942.37920-1-alessandromarcolini99@gmail.com>
In-Reply-To: <20240125165942.37920-1-alessandromarcolini99@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 17:59:42 +0100 you wrote:
> As of now, the field TCA_TAPRIO_ATTR_FLAGS is being validated by manually
> checking its value, using the function taprio_flags_valid().
> 
> With this patch, the field will be validated through the netlink policy
> NLA_POLICY_MASK, where the mask is defined by TAPRIO_SUPPORTED_FLAGS.
> The mutual exclusivity of the two flags TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD
> and TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST is still checked manually.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
    https://git.kernel.org/netdev/net-next/c/0efc7e541fd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



