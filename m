Return-Path: <netdev+bounces-127603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A210975DAB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 01:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64061C20BC2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725B187334;
	Wed, 11 Sep 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1IqF3zB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9E1BB6A0
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096843; cv=none; b=Syth2SpnQtlYVMJ4y80t8YeuJZI7ewdBYlRJl9iBrgtZOplZ+sZRowAW+MyIalpuJML9m8KfDqf/egsi2PcNdLErmLkP2EfpEO7pqNvwtvHxhhDTeKP8aM3JFT9nWwhwDi/tdRofXRb9q/WXB+F+5AMQYhdYEBHOomOW4Y3wcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096843; c=relaxed/simple;
	bh=pgoA1xiDhQ8O2DLE7wfL4wOnFGAlMSqqBq+h9fEF09w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AzSysPTEnFeUbJA8kEoPK9h1oL9/RdxNVD3nB4Zk0PvXUcAF3UxVjhiS7Pi7rtPgEKoUxpVo8DvcON/KbZJ7msQ4aTGkA7NNkRBrGZC65VzT5A+XBrikz1GRgQG3fcvpo3ig+AKMCX3NxSOqBi9VxMWfJaUKP2GzjVOH7BAlnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1IqF3zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7A5C4CEC0;
	Wed, 11 Sep 2024 23:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726096843;
	bh=pgoA1xiDhQ8O2DLE7wfL4wOnFGAlMSqqBq+h9fEF09w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O1IqF3zBH5FF+aELE4LGJ6+vxQDdykkVpXaSL6p/kbYLWwGDJ8zet5HyHnJ/s/mrA
	 TsG4EDF4dMq3mSDgBxUBE0W8nrOLBJ1H5GkmOihrHEcPvgeZLqTiauds7vKQy+1S0f
	 dvJjnX8C6K6LVTnibRvlG3Thd7KhnDoX1ZwWm02q67yjvSp4ZR6CfEbALfaVHS4TIh
	 WNcDnKY1s3OymP1FIwXYJr2/euEkiKT/HCulLUkrgB6FAokYGuPtnlw+uqzKfS3EFj
	 Sbmb6IThkP6Vqw5d4X5is64cqM9GzfZcDSpPfaJS1o4JrjiEIgn2eG9abC9lTMRi1M
	 1rKWLWae8Cmrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716633806656;
	Wed, 11 Sep 2024 23:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: hsr: Use the seqnr lock for frames received via
 interlink port.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609684399.1105624.17187868441728545778.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 23:20:43 +0000
References: <20240906132816.657485-1-bigeasy@linutronix.de>
In-Reply-To: <20240906132816.657485-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lukma@denx.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 15:25:30 +0200 you wrote:
> This is follow-up to the thread at
> 	https://lore.kernel.org/all/20240904133725.1073963-1-edumazet@google.com/
> 
> I hope the two patches in a series targeting different trees is okay.
> Otherwise I will resend.
> 
> Sebastian

Here is the summary with links:
  - [net,1/2] net: hsr: Use the seqnr lock for frames received via interlink port.
    https://git.kernel.org/netdev/net-next/c/430d67bdcb04
  - [net-next,2/2] net: hsr: Remove interlink_sequence_nr.
    https://git.kernel.org/netdev/net-next/c/35e24f28c2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



