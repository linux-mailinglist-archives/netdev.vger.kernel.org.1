Return-Path: <netdev+bounces-144305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3629C6850
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE5C1F2191D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFEC174EFA;
	Wed, 13 Nov 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr0hSGe2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F81741C6
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474025; cv=none; b=B/r7v5MDnAZHzqMFM1sYK47zQ4jJ+r/aXXaTFbZoV+NH+thhcWegeN7W7beb5V7hFfbSelWNLIvx2XxbX6yY4H9jiURb1rLbiW063hQ0iNidh6NzyahWqv0m9V6x7pKimXk4mpAqzmV8/iP4p/qZ9IN+9HV7FypMVbQhPSyAq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474025; c=relaxed/simple;
	bh=JmrNFPVoj+lcSLnrFF7MSHv8rYQ1RLK+h0OMhsGwKdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqEVTcapw+wMwUyicAXBS9oMByDUn9vjuPHLtRqSDzcd4EzQu08NuNbpNnZjnVh16nV/KthC9AqdjOFIn5qeilpgKZbeXnWHgxLRmFnbDBvq8TN+6uFIubpbdRXxZOXCZW6mgAEqxEpHK/vAiKvKgku5xbFcGIjHmmCKLFXGAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr0hSGe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F41C4CECD;
	Wed, 13 Nov 2024 05:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474024;
	bh=JmrNFPVoj+lcSLnrFF7MSHv8rYQ1RLK+h0OMhsGwKdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cr0hSGe2mdHV0v4E4jVrddPKq4ZXsjSHVNb3tduloBESrAr5fbwKiTZSd3XrG+tPl
	 DhyaX1Z5Hmcejt7TarUPWFeu90JwRgIHFsZp93QsU1lizqAs6rNKgXea6s7cDX/r36
	 kSH4xyz4K3PDFoI6VkKCpwshpBK29I0McWLDeNcJD6c7sFFPuFWvwd9NagNBoxlZZ6
	 smr+PoSpiQ59h12mKqONQ76kDjjwdzdnJ4TX6fJ70kwBwlwrwwcC7rj4f2HM6LWoBe
	 7SxzShAfRlMW7XVqT52lnpnYYlakfeJsELN6PxBopD65WMYPbnjUnMGN6n6jXSRmAT
	 5UVcfCHurObOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D993809A80;
	Wed, 13 Nov 2024 05:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: do not count normal frag allocation
 in stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173147403525.787328.3977104280425913480.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 05:00:35 +0000
References: <20241109023303.3366500-1-kuba@kernel.org>
In-Reply-To: <20241109023303.3366500-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, wangjie125@huawei.com, huangguangbin2@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 18:33:03 -0800 you wrote:
> Commit 0f6deac3a079 ("net: page_pool: add page allocation stats for
> two fast page allocate path") added increments for "fast path"
> allocation to page frag alloc. It mentions performance degradation
> analysis but the details are unclear. Could be that the author
> was simply surprised by the alloc stats not matching packet count.
> 
> In my experience the key metric for page pool is the recycling rate.
> Page return stats, however, count returned _pages_ not frags.
> This makes it impossible to calculate recycling rate for drivers
> using the frag API. Here is example output of the page-pool
> YNL sample for a driver allocating 1200B frags (4k pages)
> with nearly perfect recycling:
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: do not count normal frag allocation in stats
    https://git.kernel.org/netdev/net-next/c/ef04d290c013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



