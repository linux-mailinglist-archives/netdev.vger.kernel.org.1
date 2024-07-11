Return-Path: <netdev+bounces-110713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54492DE4D
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7332B1C212D0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0EAD266;
	Thu, 11 Jul 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/hw1JO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B6BE6F
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664431; cv=none; b=Pxh1kPxjsgabjZIvjJqE3Vqbl0H4rdCVNkAI22cSkgZeYcAP6uFediC1j/qkwQiEWKPlLNhduos7zF152a17Mqk+W9Ev3lCClYWWrEVxqHtJzpgKgEYnm5C3Fsz9Nz64ATd1ux3eCnUuV/Pc6MlLU3kgAHlMLRpGRORqfxnPS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664431; c=relaxed/simple;
	bh=SXlNu+b88bUjo+eAHUwCv9mi7FCfR5v5z7JAdI9OcvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rMFYJ3YBNq2UOMT4Jxz8TX9dEiytzsO2Ufs/42sQig3oJwPOw7FAaWrFbqohem5kIVYzKc8Pfkwf0JVmZjk7MDFSlJ9pzddzQfLJn6TvMGH2m4vQif2jrZph/kXXlVV1PkAj4PVipgeez5OGp/kWyL+W4A1gILuXuv5LjzJyBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/hw1JO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD15CC4AF07;
	Thu, 11 Jul 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720664430;
	bh=SXlNu+b88bUjo+eAHUwCv9mi7FCfR5v5z7JAdI9OcvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F/hw1JO3vFq7YPf/n3adT/wa+OEVEnHQgITjQYLjmjhp6tjAhoGhLL6VZKIEKG3nx
	 NU0Y+FVn+hLKsMJo8q0qJOVk23OqDMv/uukjyB1T/tdrPoCbJlv+KektvMQe8SNCp7
	 VqCvK/kycp7etZSRVD+e+qkqDEbbbdQlqzGvVopSnnE204rSOMJot32UDQRILC8nwm
	 M1pWsY11PRgn951zPq7e1gxc0B9rKOh91MVMJlK+zmuQTejhuZKFZCs09VMtKGIxSl
	 OXhJzhpkNCjwelPZNd8gKKQOHUzbZ7Uwp3GTBDKYQ3UUnhmbsXrRIZaRUVdXUYl3yT
	 kypjuVIRKbbhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B50D2DAE95C;
	Thu, 11 Jul 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: avoid too many retransmit packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172066443073.28307.6515176583486957728.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 02:20:30 +0000
References: <20240710001402.2758273-1-edumazet@google.com>
In-Reply-To: <20240710001402.2758273-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, eric.dumazet@gmail.com,
 jmaxwell37@gmail.com, ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 00:14:01 +0000 you wrote:
> If a TCP socket is using TCP_USER_TIMEOUT, and the other peer
> retracted its window to zero, tcp_retransmit_timer() can
> retransmit a packet every two jiffies (2 ms for HZ=1000),
> for about 4 minutes after TCP_USER_TIMEOUT has 'expired'.
> 
> The fix is to make sure tcp_rtx_probe0_timed_out() takes
> icsk->icsk_user_timeout into account.
> 
> [...]

Here is the summary with links:
  - [net] tcp: avoid too many retransmit packets
    https://git.kernel.org/netdev/net/c/97a9063518f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



