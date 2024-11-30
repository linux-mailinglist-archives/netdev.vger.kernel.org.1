Return-Path: <netdev+bounces-147935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C729DF367
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EAF281578
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5361AF0A5;
	Sat, 30 Nov 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvePNGfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5578289;
	Sat, 30 Nov 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003419; cv=none; b=OdF3BTdLVTv2D4SvNNbwFhhy8kTj/ib2/s6UHutfMvS/PKETUKuhMu75zsfj0OAhp95zA6J+ABBg8wpJb9Lnve1trXIp2FQ5okwcYK6FsgDoUu+HtsTyZlHCs82Jr+roxN2ECDDUqgxf213lTS5Rbsu8UuoSyYnG7H+tQflR5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003419; c=relaxed/simple;
	bh=m+Q8w6gDh2ovfVMprbL0Ck2ksX/VxGqubMgK2cj4/CI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unZE1vDdfN1P1zh2bULschAZQY2h+6biEhE6BWqEAJfiCI0c+ZBpNYGmsWJpKUIlzY6/TV2YgYRC9igbtWauqh5aeYG0XZS2RDy2S0qsuyxaZxZld2JLuffpyb3yqgbR6rC9+2KGZ4r8dAs6Tbc14A7Dd9rOxtPkxcLUBuYHAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvePNGfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2FCC4CEDA;
	Sat, 30 Nov 2024 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733003417;
	bh=m+Q8w6gDh2ovfVMprbL0Ck2ksX/VxGqubMgK2cj4/CI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvePNGfz8bLZzYK5Uowsk9200R+6A3m1GaEU4/LhaIqGXR1RJHu5rwPLmyTfCtx5y
	 0CKIGB17EHT11kfFhX64ml+yPCwC5JkvJFWm//S137FrnVXOEJ030byhNTB2SCJn3N
	 0g8gmsC/hF7MUrSlIYz0nUxKMaEZesJWB3Gb9Npskk9m1vz1RXL3aq2mNWYYeeMmyd
	 N2wKAmt4lvYgLO/vOps34nBByX01uXX22Yb01t9ty+NRLLK6DQYsQSouuMpAx7RZzH
	 FhjZc+Z3t/TcCpwHiFaNuOah9WHW74DJfTZa3rFWAq7j/BIGP6FxAFSWHEU1fA1m6e
	 ZfDA79ODIlW6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3473D380A944;
	Sat, 30 Nov 2024 21:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/sched: tbf: correct backlog statistic for GSO packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300343099.2487269.2218189305772943343.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 21:50:30 +0000
References: <20241125174608.1484356-1-martin.ottens@fau.de>
In-Reply-To: <20241125174608.1484356-1-martin.ottens@fau.de>
To: Martin Ottens <martin.ottens@fau.de>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Nov 2024 18:46:07 +0100 you wrote:
> When the length of a GSO packet in the tbf qdisc is larger than the burst
> size configured the packet will be segmented by the tbf_segment function.
> Whenever this function is used to enqueue SKBs, the backlog statistic of
> the tbf is not increased correctly. This can lead to underflows of the
> 'backlog' byte-statistic value when these packets are dequeued from tbf.
> 
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configured the tbf on
> the outgoing interface of the machine as follows (burstsize = 1 MTU):
> $ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latency 50ms
> 
> [...]

Here is the summary with links:
  - [v2] net/sched: tbf: correct backlog statistic for GSO packets
    https://git.kernel.org/netdev/net/c/1596a135e318

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



