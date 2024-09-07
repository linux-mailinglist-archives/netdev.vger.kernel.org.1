Return-Path: <netdev+bounces-126144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F2A96FF01
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198C0B234CD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC31B963;
	Sat,  7 Sep 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N74qLFs4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9408200CB;
	Sat,  7 Sep 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672637; cv=none; b=H0NwTzg5Y0cudNQJdWUu28uNAmbFpg9P83uwuwU1Ba5D86R3ZTYS/qehhNgeKAQExTjT8LSdI9QWFnTFZUpO5Vytd8gDps1X+uaTBitEUKuFhHvHJYJBU+8DouLLj3XvRjm5HlUL0WfC53yVDEZU2nKsaoVGHTMT0UOgAhi3Up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672637; c=relaxed/simple;
	bh=WTTUezz4wTY/HPLgpl0dOTgTNACguCSzPNfxllNKW2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HILmNyClWAfZVWEY3u1pg5W2QTGJJrWglrTUf/AsGRw3ijnRJR5FbB5aOAfmgpTwOsAfG9aHXXu2uFWpsiC27II/Cb4epxjWLG6qLD9/o+thFSQKlFw7r24L20IKy8hv4t1rTcQCwcjCEtkghk6caYuBsdEgWTc19jTwKAdupjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N74qLFs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C7C4CEC8;
	Sat,  7 Sep 2024 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672637;
	bh=WTTUezz4wTY/HPLgpl0dOTgTNACguCSzPNfxllNKW2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N74qLFs4xEAhWy8nU+TCuPPzGGeqjrLTLk07nwUPh8XvV04wQN6esaRqG4j7vw4ct
	 v6TBt3FEM4FkU475I85xSGqOtEB/yqxs0MXm27MHOiyeroxgHK0lvVZAmwV0HDbOVL
	 N13gTB0LDgipEVlyDeXg9ppaN5GLnnJZVLNU0EVAkkJC65pUOfl8vQpX7ZZ8SkT1Vq
	 a1+RatgaFnPSkXSCbeMeZvxsDkEVj6cxnivoR9gWsig1DOyfX2ZcLob/hlaRneIDG2
	 P10im70pwWGws5umBZNuA62vVeG3TUiyI8Mm97J0GDntpppm2MYuoxhGr/IgiQrVAb
	 l6vmuGwGDHuCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD93805D82;
	Sat,  7 Sep 2024 01:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: tls: wait for async completion on last message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263800.2576623.6668130104595613981.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:38 +0000
References: <20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de>
In-Reply-To: <20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 asml.silence@gmail.com, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Sep 2024 14:17:41 +0200 you wrote:
> When asynchronous encryption is used KTLS sends out the final data at
> proto->close time. This becomes problematic when the task calling
> close() receives a signal. In this case it can happen that
> tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
> final data is not sent.
> 
> The described situation happens when KTLS is used in conjunction with
> io_uring, as io_uring uses task_work_add() to add work to the current
> userspace task. A discussion of the problem along with a reproducer can
> be found in [1] and [2]
> 
> [...]

Here is the summary with links:
  - net: tls: wait for async completion on last message
    https://git.kernel.org/netdev/net-next/c/54001d0f2fdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



