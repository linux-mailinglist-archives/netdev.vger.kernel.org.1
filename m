Return-Path: <netdev+bounces-238552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D72C5AEF7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F94E1517
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2CB2580FB;
	Fri, 14 Nov 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDbBix69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42384254B19;
	Fri, 14 Nov 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084440; cv=none; b=FeG+PNf+v/H07WCVKFBSZPjLh2zscqx+rhKBUMQlj+YMP0R/Ji9mEcfQRVGCMJgeZpNVm8JB9gCcnoUayBvX4MPZooEYlAg8EBrs35comDqX/7nUGSFIGBstN5ducOwLi6HmlbGJ+xlllZ4NZC7ixj0q5j6aDEL3VA7hzjZmdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084440; c=relaxed/simple;
	bh=bjWJTG/mURONCI56zoKGanwvp1+pG3xgMrZSoIPl6M8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQdeC/GKNExIR8VBAWRdgRVlSdJ3m0oSZmZhXZhP7pSIO8YHJI+4m/VdTW6UZ9gzB/iaFfZS0U19YBpEma7HGK4FSJ9ka4izD1lgsvpKo2Am3+x+bj9sNPubwnlF9D8beNEZII9DOYZSiEWXmm5nQDk91hVKdx7hRSUMQHL0WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDbBix69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF5FC19424;
	Fri, 14 Nov 2025 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084439;
	bh=bjWJTG/mURONCI56zoKGanwvp1+pG3xgMrZSoIPl6M8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NDbBix69liiDS81vmGIRt1t5h0DdpUZUGu+fRWfFoPBhtYrQ4inUgu9QAhViXtIbr
	 JjxCRD3j+Rb71AVrSeXLqCRsBadmDAy1C31xEYzO21Pd3LnnhM3KYkoQxb3h2NCyce
	 PphbEMkgrrPL8D9dcvoho0Ne21D7hXBUdMfNSQOP8VfGsJMFGMZtvcsvF4/RCI9LvQ
	 FxAf8XysT5uu/CEMPfvsGeJaHtlqTbtbJF/uvoFjf1d++fG8ORj4iI7bbY4JR0a7/J
	 DCweEF56Kv0L++EhbBg/uyxOko4rRl6jgzOddCC0EO10EQSEk4/9DXtH/ulj9Lqkr1
	 q16VNyVzRY3gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D43A55F84;
	Fri, 14 Nov 2025 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mlxsw: spectrum: Fix memory leak in
 mlxsw_sp_flower_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308440876.1078849.9405097045494975338.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:40:08 +0000
References: <20251112052114.1591695-1-zilin@seu.edu.cn>
In-Reply-To: <20251112052114.1591695-1-zilin@seu.edu.cn>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 05:21:14 +0000 you wrote:
> The function mlxsw_sp_flower_stats() calls mlxsw_sp_acl_ruleset_get() to
> obtain a ruleset reference. If the subsequent call to
> mlxsw_sp_acl_rule_lookup() fails to find a rule, the function returns
> an error without releasing the ruleset reference, causing a memory leak.
> 
> Fix this by using a goto to the existing error handling label, which
> calls mlxsw_sp_acl_ruleset_put() to properly release the reference.
> 
> [...]

Here is the summary with links:
  - mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()
    https://git.kernel.org/netdev/net/c/407a06507c23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



