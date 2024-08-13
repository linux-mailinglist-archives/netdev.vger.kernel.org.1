Return-Path: <netdev+bounces-117891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E49E94FB5D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E531C20CD6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A95661;
	Tue, 13 Aug 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4LQr08V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E107F8
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513834; cv=none; b=n2MrWmVIgYlPhF2n3yzdHklF6FGx2lznc0OkKdF5FAwVlMIOda7FKtY+7x2szyvy70Pkl3DKJj/KsIsWracx74sfJN8O51dhJ30oDfwoMExvLPv3XvrEM7vZIv8C2Mw1m/eHCXY3C/pvX3O+RUBVQL/arRMq0lj9NSfi8aV6OX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513834; c=relaxed/simple;
	bh=aUVyhDskacL6BQQC0l5EGlLtR5ds1qcV/SBEYr3EHRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQ/a4k8O1Pgfeb60dxwsdLfUD/PEVFHomAiMOw4MEhcB60fjOpeeJj2AdVY/Rve0dOlwUYscD0csrpS93iqCWg398tR83uXR6tnYfvDOkOlotV0fQbhwWh4Rr0ovCSq+kjQK8YbYjBJzf5RAJYbfcrigFTkBlHTkDIsZWfILr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4LQr08V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B641C4AF0D;
	Tue, 13 Aug 2024 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723513833;
	bh=aUVyhDskacL6BQQC0l5EGlLtR5ds1qcV/SBEYr3EHRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4LQr08V6NCcIjhGK3Ottr47jdGI9VV8XqxWxkPJivxtnWsT9EtzMk8AROqoCBMfl
	 QPLWaFOTMio8tN+pVxjJtNQeLnFbIotVPRBCdRqtzm+q1DIAnRU0EA2fbKQ0scK2aM
	 vAFWm+wNW7yXbk0lxlPCoSsY99IDSoMkxsD0aQf8OU32DDTneQ5q+GVkCZPmb/TG86
	 lviK7IQmjKQYmvp+JOp7KfkKDzmZWM4M7gn4XRdWdNtN6VrD+uSOokg428aSgJny6N
	 znesXQgwJSaYubJ4VN6BjhkeqMqCYtmKAAswwUQUG1ZabbEsu2nb0VQyKXx3lSc4hj
	 7PsGypX/QxwlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA6382332D;
	Tue, 13 Aug 2024 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for idev->ifa_list in
 macb_suspend().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351383252.1188913.4131021823153381781.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 01:50:32 +0000
References: <20240808040021.6971-1-kuniyu@amazon.com>
In-Reply-To: <20240808040021.6971-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vineeth.karumanchi@amd.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Aug 2024 21:00:21 -0700 you wrote:
> In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
> and later the pointer is dereferenced as ifa->ifa_local.
> 
> So, idev->ifa_list must be fetched with rcu_dereference().
> 
> Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net] net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend().
    https://git.kernel.org/netdev/net/c/6e1918ff6805

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



